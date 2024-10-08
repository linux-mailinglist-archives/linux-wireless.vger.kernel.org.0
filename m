Return-Path: <linux-wireless+bounces-13717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137C49941FD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAE91C213CE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078F21E572E;
	Tue,  8 Oct 2024 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ojo3/nlD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B41E500F
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374255; cv=none; b=X741B69HMf7v8E9pl4cY4oxlkJyw6yANt6QyhLP0geIAK3ZJxk4p1uxBSupT+af8f3OzfCUOGLqJcLIs+VUNWgNMwBgRMDyF7p1tsgNZDndyRqfc0aHCQrpIH/ELmGgN9uMSMqBIC5L+btDlRTAxj5Ivo1w98mc/WwRDXv79P1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374255; c=relaxed/simple;
	bh=AZgOoi6WdRr87raV3gLF3pcNJ/1rAr2aqPGs4we3FUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifK1gdTxoAYguOA4S+ZwM53TsHBJTSdqDG8Z06Ol8NtIBiWrIeLCLB4cRHC17PbtqT9Z4SF8ASbLbyRWIGGmQvBmXabuRCiVHEvsX5Vq6KC2W9b5343dnEWhTEnpBTo8PEznKRqVuS/s+A1L6WRgt3UwvEXRg2coJhKZv3wxISI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ojo3/nlD; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BJoEVwgoXylfqpWJ/d4fEfXyMqbR294VctcAUMLH1J0=; b=ojo3/nlDRX7fZvATHwNofpqD7X
	EV4iYbP/wpE3Nnhb+tCAsiFkPVSDiIf+R6ETx5il4db81syw5py3xrgM7X1u5tgRYzAtrCFGvOP4H
	46Qy7iDXbvXhKMBqRhEe0W+Yu+i24883VrLwRZX8tTuWLsIProKcjEDzAaQUD1lLcVEc=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sy4ZP-006H62-2y;
	Tue, 08 Oct 2024 09:23:48 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v4 11/11] wifi: mac80211: filter on monitor interfaces based on configured channel
Date: Tue,  8 Oct 2024 09:23:44 +0200
Message-ID: <d58009e0338bf97c6f1ec771070a65e040846384.1728372192.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
References: <cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a monitor interface has an assigned channel (only happens with the
NO_VIRTUAL_MONITOR feature), only pass packets received on that channel.
This is useful for monitoring on multiple channels at the same time using
multiple monitor interfaces.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 5e43905fd26c..6df0f3953eec 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -837,6 +837,13 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 	ieee80211_handle_mu_mimo_mon(monitor_sdata, origskb, rtap_space);
 
 	list_for_each_entry_rcu(sdata, &local->mon_list, u.mntr.list) {
+		struct cfg80211_chan_def *chandef;
+
+		chandef = &sdata->vif.bss_conf.chanreq.oper;
+		if (chandef->chan &&
+		    chandef->chan->center_freq != status->freq)
+			continue;
+
 		if (!prev_sdata) {
 			prev_sdata = sdata;
 			continue;
-- 
git-series 0.9.1

