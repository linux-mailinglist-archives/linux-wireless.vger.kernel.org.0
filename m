Return-Path: <linux-wireless+bounces-13446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B7F98EAEB
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 09:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE6A7B2483B
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1274A13B293;
	Thu,  3 Oct 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="hcQLEMzn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4D12CDBA
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942306; cv=none; b=uQpU/PZDMINWc8z8h4F6wKY6tolag6ZHGQs/+1dFchKLz8pgzfnx8NEUGdV9QGUBoj6jLGhokH511XW5zrk54570/9Z6XqzTcbc3PB0vMYj96jvftZkKe/ZfAXdF9tt0qjEb6N/bW6X6rVAddT3E8f2Gz1cgHzaMCXtb+S8Wqxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942306; c=relaxed/simple;
	bh=AZgOoi6WdRr87raV3gLF3pcNJ/1rAr2aqPGs4we3FUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bt6Wxb5J2TGD387p8fyDXOM0k/7WjlxScKm6RMMorvsIFYV2XkARCXBmD0hqTipRtXVEH14XDI3VoppOYJDU7JYtsq+uZa9Fz03/F36RREH/T7eCyYoheSRefYaBeNN1w63R/9ZFhsmOUYo/87bb95OJonEC+sFGxabrnsodHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=hcQLEMzn; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BJoEVwgoXylfqpWJ/d4fEfXyMqbR294VctcAUMLH1J0=; b=hcQLEMznHHjRNNPxwbRFUhha0Z
	onyx3IWF6I20uik91ocVrAom4uWNCyRfcXP1oGO6/OjHmw2z/lzAoQ55IEjnwO0931PF7E8WTkVv4
	WAb5KZHFQYhNYqqBvLTDD1wj+Uk4sTYcPUOsEdvLcYjeQfbWqauZ4A5fnM7xW2VrNcIM=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1swGj8-004Jgh-2C;
	Thu, 03 Oct 2024 09:58:22 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v2 11/11] wifi: mac80211: filter on monitor interfaces based on configured channel
Date: Thu,  3 Oct 2024 09:58:19 +0200
Message-ID: <dc3c2070b11f400907c4fd1984a4fc548a35749f.1727942154.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.debd54967c43dd95013c56efa390ea6117062373.1727942154.git-series.nbd@nbd.name>
References: <cover.debd54967c43dd95013c56efa390ea6117062373.1727942154.git-series.nbd@nbd.name>
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

