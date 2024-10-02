Return-Path: <linux-wireless+bounces-13421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C91E98D25E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 13:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE29B1C217F8
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 11:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D0E201262;
	Wed,  2 Oct 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="GXuqg15i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0391200116
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869524; cv=none; b=XVHsu+JzI16Fs6d9YNyYFHFilJeE2j2HR6/crmtZoG3WBKE52t/0DYLST8Grnc/diZk+xZPygchQy+LVGMjbePcsILYRxnJHAPNVHfQJO2sqcpDSP54+bkUTAPsPgsyaEn0zdr/SSefR2Dg9cDuS2Zppj9XbJf/ghmZIQWm8jZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869524; c=relaxed/simple;
	bh=AZgOoi6WdRr87raV3gLF3pcNJ/1rAr2aqPGs4we3FUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdlFccCQbjB7gtAsQdwrd64/wkJ3no+rgOlMmStyK8RfXvHblOUjM9OTRozr3oMkELiIxR/q8/QTlPYvoBaJNaROXIkPHZRmR9bM3kkySwiiB1UhCwWgZ0+1Vqrh080DsH6Fsfsi3DGyZjUYVhten+EAOFb7ijfj7Dg5gSttZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=GXuqg15i; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BJoEVwgoXylfqpWJ/d4fEfXyMqbR294VctcAUMLH1J0=; b=GXuqg15iMdtiLrTm5PomggSf4Z
	+2rY9IYFE2dxxXd2kvXG8gdf3UdiJxAST+V34u6Z+tr2t+kIYVhe/xmstrtEgdbYTo+BdA6CZQBT6
	b8thSlTNmO8rETMfipIi/eh5X0Mi3NnzUSdJiuFkIuadBTi7AArW7CAneyDPJVhKT0tI=;
Received: from p4ff130c8.dip0.t-ipconnect.de ([79.241.48.200] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1svxnE-003vyr-1X;
	Wed, 02 Oct 2024 13:45:20 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH 11/11] wifi: mac80211: filter on monitor interfaces based on configured channel
Date: Wed,  2 Oct 2024 13:45:17 +0200
Message-ID: <859d0e2138e7d918f9f10926bc2a937370033a94.1727869380.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
References: <cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
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

