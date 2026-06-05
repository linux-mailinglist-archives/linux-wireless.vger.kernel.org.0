Return-Path: <linux-wireless+bounces-37416-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0nhNEtnDImqYdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37416-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 14:40:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2221648401
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 14:40:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nbd.name header.s=20160729 header.b=cCvhvwjF;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37416-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37416-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nbd.name (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 501C4300E2A6
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068E8385D71;
	Fri,  5 Jun 2026 12:31:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B22D2496
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 12:31:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662662; cv=none; b=NxyRcAD2Neq98n0aNAsg6/DHYHwBWCQvY+4hoVvmtTGf6Gt1VktKNiWrs1CwNl8HnJcVQApNo1Fafg8yM5QNjJACx67l6noFG3irtkm6liIUEqdwI4iPGppiFetQgskqVexKtoKngxRUJV9cUx/MsnPjEYNaQcq9aXXxAIfqaCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662662; c=relaxed/simple;
	bh=6+m8jlgYgY4V/ds9RpG+giaDoLHTfOafbCG3yuc2Cy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rt9Dl0nyA/ab4e9wubydL1SSnXNBSbEUw7L1aBbMPpUiZNl8F58G5leAghzPcD1V9kbpG6WKejv4iIUdEnSIO/FRKNF1Y7PuTf2PmMTMzvco3I0Zlf3ptF+QVFt3q/4WH7s68B6Bj5F1DD1rGy4Fa0emBHPgmf09c/LCsCPvhcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=cCvhvwjF; arc=none smtp.client-ip=46.4.11.11
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CQDY6eEpwus5hVK5Bh4lfaSa/YWhVZz73waBiXeXo2E=; b=cCvhvwjF/0CWh7MT/LoFej8KXh
	IAsBrwZRuFUy6hYgk8UR4o1IbyCa+Ut8PPWOQC2nxZa2MfZutV7i/G4A2n5nlfExqTQAln8TbUp1+
	5Msq07H+P5nkGCbTZQXKR3rpsSirUbI8jjjJQQ1CXhZsayvUWy6F5MlasRwrjW+aSc6A=;
Received: from p200300cadf03d5009ebf0dfffe00fa2d.dip0.t-ipconnect.de ([2003:ca:df03:d500:9ebf:dff:fe00:fa2d] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1wVThO-0090er-15;
	Fri, 05 Jun 2026 14:30:54 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH wireless-next v3 2/4] wifi: mac80211: estimate expected throughput if not provided by driver/rc
Date: Fri,  5 Jun 2026 12:30:47 +0000
Message-ID: <20260605123049.1128869-2-nbd@nbd.name>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605123049.1128869-1-nbd@nbd.name>
References: <20260605123049.1128869-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37416-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nbd.name:-];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nbd.name:mid,nbd.name:from_mime,nbd.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2221648401

Estimate the tx throughput based on the expected per-packet tx time.
This is useful for mesh implementations that rely on expected throughput,
e.g. 802.11s or batman-adv.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v3: avoid band=0 default, return 0 if no chanctx

 net/mac80211/sta_info.c | 49 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 4c86a3793804..b0a87d5a66ca 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2769,6 +2769,28 @@ void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
 	}
 }
 
+static u32 sta_estimate_expected_throughput(struct sta_info *sta,
+					    struct rate_info *ri,
+					    struct ieee80211_bss_conf *bss_conf)
+{
+	struct ieee80211_hw *hw = &sta->sdata->local->hw;
+	struct ieee80211_chanctx_conf *conf;
+	u32 duration;
+	u8 band;
+
+	conf = rcu_dereference(bss_conf->chanctx_conf);
+	if (!conf)
+		return 0;
+	band = conf->def.chan->band;
+
+	duration = ieee80211_rate_expected_tx_airtime(hw, NULL, ri, band, true, 1024);
+	duration += duration >> 4; /* add assumed packet error rate of ~6% */
+	if (!duration)
+		return 0;
+
+	return ((1024 * USEC_PER_SEC) / duration) * 8;
+}
+
 static void sta_set_link_sinfo(struct sta_info *sta,
 			       struct link_station_info *link_sinfo,
 			       struct ieee80211_link_data *link,
@@ -2983,6 +3005,10 @@ static void sta_set_link_sinfo(struct sta_info *sta,
 	link_sinfo->bss_param.beacon_interval = link->conf->beacon_int;
 
 	thr = sta_get_expected_throughput(sta);
+	if (!thr && (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)))
+		thr = sta_estimate_expected_throughput(sta,
+						      &link_sinfo->txrate,
+						      link->conf);
 
 	if (thr != 0) {
 		link_sinfo->filled |=
@@ -3236,6 +3262,14 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (thr != 0) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
 		sinfo->expected_throughput = thr;
+	} else if (!sta->sta.valid_links &&
+		   (sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))) {
+		thr = sta_estimate_expected_throughput(sta, &sinfo->txrate,
+						      &sdata->vif.bss_conf);
+		if (thr) {
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
+			sinfo->expected_throughput = thr;
+		}
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL)) &&
@@ -3256,6 +3290,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (sta->sta.valid_links) {
 		struct ieee80211_link_data *link;
 		struct link_sta_info *link_sta;
+		u32 est_thr = 0;
 		int link_id;
 
 		sinfo->mlo_params_valid = true;
@@ -3267,17 +3302,25 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sinfo->valid_links = sta->sta.valid_links;
 
 		for_each_valid_link(sinfo, link_id) {
+			struct link_station_info *lsi = sinfo->links[link_id];
+
 			link_sta = wiphy_dereference(sta->local->hw.wiphy,
 						     sta->link[link_id]);
 			link = wiphy_dereference(sdata->local->hw.wiphy,
 						 sdata->link[link_id]);
 
-			if (!link_sta || !sinfo->links[link_id] || !link) {
+			if (!link_sta || !lsi || !link) {
 				sinfo->valid_links &= ~BIT(link_id);
 				continue;
 			}
-			sta_set_link_sinfo(sta, sinfo->links[link_id],
-					   link, tidstats);
+			sta_set_link_sinfo(sta, lsi, link, tidstats);
+			if (!thr &&
+			    (lsi->filled & BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT)))
+				est_thr += lsi->expected_throughput;
+		}
+		if (est_thr) {
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
+			sinfo->expected_throughput = est_thr;
 		}
 	}
 }
-- 
2.53.0


