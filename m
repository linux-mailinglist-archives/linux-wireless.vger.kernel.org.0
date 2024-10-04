Return-Path: <linux-wireless+bounces-13536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1899108A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 22:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2F41C22F29
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 20:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118921D90B6;
	Fri,  4 Oct 2024 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="GE4vj8Sd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616681D8A1A
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073333; cv=none; b=CbpSR2Lwmeea+7W+IM7R3VZ/G1Cy4Zz9KPjXvaXkO3axbagd9/yUQyIEbTfyq5B6KF2u283a7ZHl/15VkTNsvnCMDxds05QKS+nU5l6nuZ5d1XgyWMXWbV9mua0LS93H57UOxtFQ1Y2zyreine/gXUEXE8IgJOd4xbFDt9S7zwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073333; c=relaxed/simple;
	bh=AZgOoi6WdRr87raV3gLF3pcNJ/1rAr2aqPGs4we3FUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOkgtKaMICBvWZBXvQlWsZkwyV62X6qsLOPkN6rQ1i9IfkCO8O1Wt0JLKwNr0aojcN5ouZTZWoNWtArl9ML+nG2Q2NpWe27Z/YFg1jPCayjJjCcBF/NJaDGQIgI8JtzwNRyaK4V8/9RT1DOAhZfwxQBY7Llc81iQfceFGSmi41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=GE4vj8Sd; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BJoEVwgoXylfqpWJ/d4fEfXyMqbR294VctcAUMLH1J0=; b=GE4vj8SdStLi1vwy+V+Hc6meus
	beSWMgn42PW60L1wGP+7Do0QQKLUsUC+dbmdBRhTCAkXqGd1r+myTiYm0ZDOcVyo1IzApyVasjuCC
	rGYkZanj5W9zotUyMufA1+diMXrjHas9BT7FQRZpgD9S7AfWiqr9AbmPPxIw7CizBG24=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1swooO-004jVl-2F;
	Fri, 04 Oct 2024 22:22:04 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v3 11/11] wifi: mac80211: filter on monitor interfaces based on configured channel
Date: Fri,  4 Oct 2024 22:22:01 +0200
Message-ID: <2240bc1926a1ac108ea0afc6a9d927efa8add24c.1728063865.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.b9e938930e3d3683952cc034fde2a2e938e0b6f8.1728063865.git-series.nbd@nbd.name>
References: <cover.b9e938930e3d3683952cc034fde2a2e938e0b6f8.1728063865.git-series.nbd@nbd.name>
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

