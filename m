Return-Path: <linux-wireless+bounces-33702-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BBgDzMUwWnkQQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33702-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 11:21:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C222EFE9C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 11:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E025300DEDC
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 10:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A7138C2B7;
	Mon, 23 Mar 2026 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="fphDP8MW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D2D38B145
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261200; cv=none; b=qHnAfn72sSV4LblSgSUx1DwnBsBVbNLULSTLAxg+pA1ZcqSk/bkRfy609KxlU4fNIljz5S9O8UzTdrgDYIUjqz1nOse8m/2uY14vNwgzal1gJT4/LMufd7z1m5eF87AH4mavPSD99CfupSO4OW3JTG/X+nbGgQLNqTRs9X5AXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261200; c=relaxed/simple;
	bh=hEN6vVeVXRajinyQurlghyRr50SpFgAdCvnZtom7gME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqaoWLTzj8kXtFvqnjTX0fFzq8B4kkF++/n7xGlRQ/OE2oQM4wWp/EKT3ZFt9OkibN488cQvp80wIO0FyEJA8zl9lT08J4OmJdi5cwz9oOBKQr2KQX3k8XtEJcA5J6f/pO2fXUAKkC8+KNHLQe5Sy67u/+xDBpI2tct4ZvMV12A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=fphDP8MW; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CLuw3UtfxSre6eFcGibdyl77ORqwpkWrRuEcMo6jxlQ=; b=fphDP8MWeEPtqDjGejYXRf3QbV
	8hp5VjiOmktqkrqEOtmO/WT/XoMSHQzxySPi5Zde5xQ3eh18+gnUXXZDfpGZOT8VsRRzSB8RZKkFM
	k9sktRa5Y7vxAEXDmXmq7Olupu9r+TMkIvU8n+dE0EL6V98S33u6om2JAzLeCyKlmjyM=;
Received: from p200300cadf30ee00000000000000085c.dip0.t-ipconnect.de ([2003:ca:df30:ee00::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1w4cO4-00ALUX-2y;
	Mon, 23 Mar 2026 11:19:56 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH 2/4] wifi: mac80211: estimate expected throughput if not provided by driver/rc
Date: Mon, 23 Mar 2026 10:19:52 +0000
Message-ID: <20260323101954.874299-2-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323101954.874299-1-nbd@nbd.name>
References: <20260323101954.874299-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33702-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.789];
	DKIM_TRACE(0.00)[nbd.name:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8C222EFE9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Estimate the tx throughput based on the expected per-packet tx time.
This is useful for mesh implementations that rely on expected throughput,
e.g. 802.11s or batman-adv.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/sta_info.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 4259e9c13ed7..912f00d905b8 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2978,6 +2978,27 @@ static void sta_set_link_sinfo(struct sta_info *sta,
 	}
 }
 
+static u32 sta_estimate_expected_throughput(struct sta_info *sta,
+					    struct station_info *sinfo)
+{
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct ieee80211_local *local = sdata->local;
+	struct rate_info *ri = &sinfo->txrate;
+	struct ieee80211_hw *hw = &local->hw;
+	struct ieee80211_chanctx_conf *conf;
+	u32 duration;
+	u8 band = 0;
+
+	conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+	if (conf)
+			band = conf->def.chan->band;
+
+	duration = ieee80211_rate_expected_tx_airtime(hw, NULL, ri, band, true, 1024);
+	duration += duration >> 4; /* add assumed packet error rate of ~6% */
+
+	return ((1024 * USEC_PER_SEC) / duration) * 8;
+}
+
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats)
 {
@@ -3202,6 +3223,8 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_TDLS_PEER);
 
 	thr = sta_get_expected_throughput(sta);
+	if (!thr && (sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)))
+	    thr = sta_estimate_expected_throughput(sta, sinfo);
 
 	if (thr != 0) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
-- 
2.51.0


