Return-Path: <linux-wireless+bounces-34939-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAlCNFw24mm13QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34939-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:32:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A08A941BABD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CE693030B04
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94AA1E5B70;
	Fri, 17 Apr 2026 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JQRMWr1a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y5q0tUSS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F342DC78C
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432724; cv=none; b=EI3smiYWnxVlJ2oz3T9PkPUhKsmWv+nOeNyuUsXL+KvOxDGOMqjNgG5HdfJU/CezLth5fyydvPdH+QhnmocR9CQClR+ZG/fQt6qjKcQa3836KXOEinSKr9WSOs6Uc+6lBjutBrkJ31BwNsO2vPxSRkfVLcaWeC8SOwMTmhxqS9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432724; c=relaxed/simple;
	bh=cPKxVVym9iyM8zlnZzW8AAlaW67k5w9iWhczbukYpC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vpras5QihdOEk4N+MRGelfQjnJhxYG3Uaj69tsAqLA/2K265g1IX+vZjRv+ZpKnDjXof752sL/4o0KZiqFn/NDN+77imRubSQjObEN15tWUzgfhJzIvAotHPaUmNkQcOezPJU8Y1sgI0SgSlty7skiEFbTOOs1ZHvbOmgoxmoRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JQRMWr1a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y5q0tUSS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H8tjUC1971847
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Tp8oJjwa9Oq
	0L710YCGQjlzmc/zf2toN1Ukm36mQhlw=; b=JQRMWr1afLKPAQvGH/AlyJwOK4b
	sF8nKvKNRhGKaiGxdHRcBIpsn/ifxGJGyRr7D5qiJkeAcMga/HpAiLXhECTPGYnU
	HC3Vs5f1oVvmRuIyQ366mjV8yeqnqnwoywg0Vzi2V9snGc6xc4N/M3ErXqBetpyT
	g8inbvLYGccLpcDZ/LKabA950d8mHEfhhF+0GDplPdTxH4b2SXN6OOs8tKy3H9Rg
	lx5/kC0p0fuoKJew6fh0LRFuBQTgZP+vrTOJu4CerrDnSfUajgH32L9PyCbWqEiS
	6Z+h5AvBIuwzecoZFrgIGixgKVUSx8+SCJWVMKXj3bEPX8j1QD1HS65NTWw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhsh8yyg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:32:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35fbc53b64bso853476a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 06:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776432722; x=1777037522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp8oJjwa9Oq0L710YCGQjlzmc/zf2toN1Ukm36mQhlw=;
        b=Y5q0tUSS5e8iCQfR7rc392T/NXJ76tga5XnD2VT1KRnL+YLJti/5KKO7foE7FmG317
         wk54/7lbnnoi/Xp+xaEXtPoxWp38bIBqCuTg9IGlxcfRqgO7IGSNT6wBA13C9O3D4eax
         Da8OBzig/MZ/MJpVO+5QcezoI7Tzu0T5UrZIzwkX3pPSCXg4AC62xUisq31fKwdZrNNw
         X7Dnr3ua6AhIsoFFyqZkGOtY1C0oZNHrrIpDuvIP+YA63xeXMZeDvMgZK31oouheZYlI
         JbPV4yBgmKMMQSrSffj3UF7LY9Ayi+E/MR4ASeFvy65OSALF1X2t1W+Cfg8WdNqyDpbv
         rkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432722; x=1777037522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tp8oJjwa9Oq0L710YCGQjlzmc/zf2toN1Ukm36mQhlw=;
        b=D6p3jo1OxfhAkGdVKxWxp3QTvdiwxaK/bmw07K2rp+yUIAeww9jhpXxvWpC3UNwCEO
         k19d3M8M0W/dEaPSfeOOThuzOd6emAgWN5WBEESUlHmZS3WS0pVl8TDKfgyhJR7U2CT8
         Q16S8it/c4VhToX2BkRabjcnG5u0pyTtWGsoh70FcSeYQqtzTUXOlzQt9S21wRQ0fAC5
         zp1uLCCcprlgj369wQx9PLV3e5tU3GJKR1kiYqjmzckG4oxnSwQwZNkCrcLPFwef6QOG
         8IJrwmVWZkTQhw20ykLEAjpWGLLuFNnuKHbnMZxS51VP4b16c7MNZz1ntEcETSQZM5VK
         ETFQ==
X-Gm-Message-State: AOJu0YyUBQJZ6NajS+9yxqfw5hbSQ261/vFAXMBv327AHZ3m8mCgzmYz
	2NrJYCJGsjSiN/aICTD2IcAK7BW4X8XWDRXl9S/lsEmISkgr4El3S2lvRk8W65UygHOxoqZIeZW
	Ursq/A6+48yBPwaKUIhnpAEAEv7moD0NgYIP2tJv3u7FteOXAS07vxT/TehK08Uupe5Jiag==
X-Gm-Gg: AeBDieveoRjEvaD0ejd5n8lmjEgpqErHCOHgkVTlmn95R7JFjcRFp9eVhnVxPk8CBAw
	0RHoPynyAaD7f/9mmXgueYY5H1C0fZSr92MwcodS2k5zM2QUifLTwNbcdmGA+CfUnuK7qseKjnQ
	KIHkfcESHdMcw4Sz3cNBhpTSfmN330ywUyqspIenc1WlDfJHIOUA3bbB0uWEzXZkQF4/OKZ5tKX
	ZFQKkBOmxIU9BTJNR7cI4cD5RHjkhvujtN4F2b4FyFxKzC/toKiYQQnfcPG1Jtfd5j7ByCGSbm9
	VA/GQkuhm03H/jcIEmz7ROwZHiiZlAwrk4j/H0/kKOM75vzYteCKHLj/X9+NrxSKJMhogUjz0Ox
	o2YETigfLCNvTSwDI0Pk4IJkwIEJnJI1uAmA3vyAqFeVWgziSiUYNomUs
X-Received: by 2002:a17:90b:3808:b0:35f:b572:ece9 with SMTP id 98e67ed59e1d1-361403bdcccmr3160972a91.5.1776432721746;
        Fri, 17 Apr 2026 06:32:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3808:b0:35f:b572:ece9 with SMTP id 98e67ed59e1d1-361403bdcccmr3160912a91.5.1776432721153;
        Fri, 17 Apr 2026 06:32:01 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361418c3944sm2734438a91.8.2026.04.17.06.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:32:00 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2 4/4] wifi: mac80211_hwsim: report TX status link_id
Date: Fri, 17 Apr 2026 19:01:23 +0530
Message-Id: <20260417133124.3412752-5-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417133124.3412752-1-pritiwa@qti.qualcomm.com>
References: <20260417133124.3412752-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d6/FDxjE c=1 sm=1 tr=0 ts=69e23652 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=NjFlLJTsBWwvL5VAOx4A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Mc2cNzPX07ZPTJkseH-RYcp-ppDhj3Xg
X-Proofpoint-ORIG-GUID: Mc2cNzPX07ZPTJkseH-RYcp-ppDhj3Xg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEzNiBTYWx0ZWRfXyRCbB1jUPOC1
 o9VBn4OaclPbzM6W6hAkqdhRMxWNbJfZUAyPikdLnywObGx2mQOhXCyPWAnFrEG46guNsm52Xb8
 ZJ4vwltbOezWEKgAh6BPyrp10w6DT6BXMX46ZFeIx5rsBGwMyzd+vvuT8fFR1etc48SFTezKebU
 phAoy2sSxAt5X8EJyZtbLJ4coqDy2GGRFYaBlGJFIy0xTaZJSpMD7OXgk9BdvrQX1IWYvt/66Lr
 g2sq6ZDN0OP8Syo5TsCHqvqD+IZY0pL4AvPPqKAODX9MP7ySN83cmVyVOpVZeOZj1ZsiQlxfHS0
 B4PijVVvCzpW2lxP5Qxo6VKhsQqmEiIJGqdWC4OrN2NZMWNvB4j+em4QuHzaS7cdjp55EFQcV2Q
 92ct17LfQELDHxtTI9eauMGTDSume4kY1Q2sdLF9x+5C4cdWCFV2hNkGx+1mqigssI+Cmd8sWfa
 yX1yOQ/QE1y5JzrqJ4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170136
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34939-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A08A941BABD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

Populate link_valid/link_id in mac80211_hwsim TX status so the
transmitted link is reported to mac80211.

Set the link information in both the direct TX status path and the
wmediumd/netlink TX status path.

Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 43 +++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 1fcf5d0d2e13..032678dc2298 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2087,6 +2087,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	bool ack, unicast_data;
 	enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
 	u32 _portid, i;
+	int tx_link_id = -1;
 
 	if (WARN_ON(skb->len < 10)) {
 		/* Should not happen; just a sanity check for addr1 use */
@@ -2147,6 +2148,9 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 								 hdr, &link_sta);
 		}
 
+		if (bss_conf)
+			tx_link_id = bss_conf->link_id;
+
 		if (unlikely(!bss_conf)) {
 			/* if it's an MLO STA, it might have deactivated all
 			 * links temporarily - but we don't handle real PS in
@@ -2279,6 +2283,12 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 
 	if (!(txi->flags & IEEE80211_TX_CTL_NO_ACK) && ack)
 		txi->flags |= IEEE80211_TX_STAT_ACK;
+
+	if (tx_link_id >= 0) {
+		txi->status.link_valid = 1;
+		txi->status.link_id = tx_link_id;
+	}
+
 	ieee80211_tx_status_irqsafe(hw, skb);
 }
 
@@ -6009,6 +6019,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PUNCT);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PROBE_AP);
 
 	for (i = 0; i < ARRAY_SIZE(data->link_data); i++) {
 		hrtimer_setup(&data->link_data[i].beacon_timer, mac80211_hwsim_beacon,
@@ -6234,6 +6245,27 @@ static void hwsim_register_wmediumd(struct net *net, u32 portid)
 	spin_unlock_bh(&hwsim_radio_lock);
 }
 
+static int mac80211_hwsim_get_link_id(struct ieee80211_vif *vif,
+				      struct ieee80211_hdr *hdr)
+{
+	int i;
+
+	if (!vif || !ieee80211_vif_is_mld(vif))
+		return -1;
+
+	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+		struct ieee80211_bss_conf *link_conf;
+
+		link_conf = rcu_dereference(vif->link_conf[i]);
+		if (!link_conf)
+			continue;
+		if (ether_addr_equal(link_conf->addr, hdr->addr2))
+			return i;
+	}
+
+	return -1;
+}
+
 static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 					   struct genl_info *info)
 {
@@ -6312,13 +6344,18 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 
 	txi->status.ack_signal = nla_get_u32(info->attrs[HWSIM_ATTR_SIGNAL]);
 
+	hdr = (struct ieee80211_hdr *)skb->data;
+	i = mac80211_hwsim_get_link_id(txi->control.vif, hdr);
+	if (i >= 0) {
+		txi->status.link_valid = 1;
+		txi->status.link_id = i;
+	}
+
 	if (!(hwsim_flags & HWSIM_TX_CTL_NO_ACK) &&
 	   (hwsim_flags & HWSIM_TX_STAT_ACK)) {
-		if (skb->len >= 16) {
-			hdr = (struct ieee80211_hdr *) skb->data;
+		if (skb->len >= 16)
 			mac80211_hwsim_monitor_ack(data2->channel,
 						   hdr->addr2);
-		}
 		txi->flags |= IEEE80211_TX_STAT_ACK;
 	}
 
-- 
2.34.1


