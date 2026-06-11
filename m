Return-Path: <linux-wireless+bounces-37657-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8diuLwFVKmoRngMAu9opvQ
	(envelope-from <linux-wireless+bounces-37657-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:26:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1429866F02A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:26:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Lgag5qul;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dWKh9Nb5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37657-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37657-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB5113107B9E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 06:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813E12BD58A;
	Thu, 11 Jun 2026 06:22:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E22D73A6
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158978; cv=none; b=Kb6ZvOuqmg0oRQO+IkPTDoPIqWlSPIGVSnmHHVhTnYKGs+9RZN8ZgTsnyp9q4UOVQYVuWufY/eyqPZftaNQCp2NASX1jz3zHQhJamBDTrIhWoP1OQaDV6EqzPlnkfDxIHmx4C2pD/R8bhxwt9l1oQOcPDnop9sNbUNUxdez1Sk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158978; c=relaxed/simple;
	bh=wcx0mnST8SlDk6rmebO+ZZL6CGN2pWeuykJFB1qQ8Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JbdeLzJLgAmVOmcy9A4RuqQUYzfvJaMDphFIrKbSpbNuKciSFRvx724deUEnkKhbx6Ka2rcp0g+okpMD9eZ1LTVFP5uqehjunK6Ak0gJxLb8/bkawWxMtVqjOuwpnJiqS04R/XTbumC0DxfG3qLHPTMaOiZQ3rUolN4x5vXy/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lgag5qul; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dWKh9Nb5; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GJsr3843682
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=e5hJ4gjjLT8
	WL7TNY/WnrwapNHTi3JeTi2/uXVaLhrI=; b=Lgag5qulNXm3y+ypcHb9OxBybIr
	2RSMKjnE+xc0pm4Kfn1CfRyA1bdfn4vLzd3i7AhWqkGmp3H2GfsK+sivpCe9lH1H
	WI6CaBpoMjgwcRWbayv4a1VcFnOXadcXbEUwNHHEoxql6oWIJqneX3+/GLFHXA1y
	DyNLQkq1767JMq9v8ZbrWsBdfykQrU1oAQ17m+Dlv0hCv9EjzF91oGOooGlRQC6h
	YpuDUKhvBpqbYHf54UEyQ3s5KC5OGT19YbvaVKpaGJtJQfMFE4lQJR2PXjNmglKq
	IKZvCmYGRmSgIkjZCsiUd4UxRfLhfleodeEn27izwXMaSc11AjSfpzoXqHQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe701x4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c85a2bf5388so4102325a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 23:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781158975; x=1781763775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5hJ4gjjLT8WL7TNY/WnrwapNHTi3JeTi2/uXVaLhrI=;
        b=dWKh9Nb5ysA1rpu9Jgf7TtlWKOKr28e0MNCW2+XGHrj5H86+Ay02t7/TWaZKEg6vs7
         Ger7YaCAgIWz1YlDdPL+QFAoRNVChJkhcB8urLzMxbrg8RgIF7lRy1ch3hwgpR0CUZIW
         SdI0p5za93ImfzGjnqzZohkZ0Rp94bUqITQ976kYT+Cu+ogEQ5s39mus6BUs9rIE9S06
         C6ffjPBLcU4MOytur1unmKKCtt4PH6Ij2NQbO85YtgGi1GJcHWOQZQRv5Yob9VqgnCD7
         sN6MQKqpxmhZ87yRiV1zijE75DQsZ7l2IIOzZguk/xp6yBbgkgm5XqMBlM1fL0wkMP0T
         TwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781158975; x=1781763775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e5hJ4gjjLT8WL7TNY/WnrwapNHTi3JeTi2/uXVaLhrI=;
        b=lT8X3jzJ0rjgjz0C8PDBh09z9ZN3L24vs773GWal6eiaM+NJIHh/yMlbMtT+iKzNb5
         w6XCbtolobens3y9prOjlslr2Qkan5OUK/nuN39KqmRA6+oEfHCbQB+qNKWekJ0wWDmr
         XGqhG8esvzr9J70PGNtUHslkMJXf3T4OmjBidbX6KaSiBbba3f0JYKoSZIAuqxcpJHoL
         Gv2SPC94ZUpxrHCUk/f39faTsgkbcmJEGvAcMQLCUE4Zj/Jt/f6RNPOnhIZrGZ68sCsV
         OwOkCcC5L+9QltX2yuAV7bgN/9dg6CPigFEyLA5cocny1RM8XXIYitHgi6Lc4uKkNfln
         nQig==
X-Forwarded-Encrypted: i=1; AFNElJ+RjKYdsc5OCB24apo05EnKXh7VtjPEHXZNIDQRB2+DuvgvxP36h+asVkeYYgdynHEjTp/n2zVtoe/kFwhIxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvkkycKX+M3BR+NaLbCVJhTd37GMMtWpGjw55ZFeZDF0zq1/zw
	35xnkw47acguAIVlsPu2YJBRw0s5zltOsPEhE5w6zpFmk1oskDfajEA6TORVYyEwQhjqsDjQHgZ
	jRAaOhpNl1+R1y4fxBOY2E8GcPONnFI6DRNjFxx2eZo7k6pWusQ96mutNbIopn0DcV9QKbcwa5q
	G1NA==
X-Gm-Gg: Acq92OE67O1rYQzUCRQ6Rem+pxJdSBFI7cXENGvNFt2SQtqCjphbuxj7L/HqXUc82zF
	Pjy3Z6vxYyKN9od0r6n5WIOrUck231t95Ypm4fim62JPStgbOrfz75FJ5p76whtMY1p14rNVDDM
	QpHAPCx/yTNRsDDQCnrmaf9p7kqiUgQjr4dbia5Fj8tOLy/hT3zhBPKc7D1bTxsSJaEibaja8AT
	bmw1g6fXY1gxCB1AoqlR2B/FCyZHu7Q3MWxtOaiWyspnl3wlDKqGaU/AgyX/B+GKcHGihXAlByS
	4NmFnsDgnWHowGjfzyBE8IYNi0gOG5SxJUI8e07wClsdhE+UUNQqD/Mz7mKNUMJwUMxoqrW8p4A
	kXk1QeL1NpB+lE9xoq5euUUXhiUCSVVFlZLMPnvDc/wE2QkCTHdht6TEG
X-Received: by 2002:a17:90b:1fcd:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-3778fb3c6b2mr1677761a91.0.1781158974919;
        Wed, 10 Jun 2026 23:22:54 -0700 (PDT)
X-Received: by 2002:a17:90b:1fcd:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-3778fb3c6b2mr1677747a91.0.1781158974438;
        Wed, 10 Jun 2026 23:22:54 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37752874fc3sm1247507a91.5.2026.06.10.23.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:22:53 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: veerendranath.jakkam@oss.qualcomm.com, linux-wireless@vger.kernel.org,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v5 4/4] wifi: mac80211_hwsim: report TX status link_id
Date: Thu, 11 Jun 2026 11:52:25 +0530
Message-Id: <20260611062225.2144241-5-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611062225.2144241-1-pritiwa@qti.qualcomm.com>
References: <20260611062225.2144241-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hNyo7S_vHUNomwC3S-ftDDPq3TDa6ymz
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2a5440 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=NjFlLJTsBWwvL5VAOx4A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2MCBTYWx0ZWRfX9wbQM+9plxsQ
 hvK+XBklRx9WcHpI42sMbJDyk5mGIO9Lq63TlZz6T2aArl9/qxp8sTtSK/2WdNwHmSuxPnseQFL
 BcpryybCqaWQrnwNTVAEX8XEjTs5TjC6Px6x30cjdTRr/lDWZxFVVufxtAQ5o5vWyMQG4HRKCjd
 XZgFOfisBcUD740A/2TlkM6kUVqA0BGB/3yP95hlbKkz0IVl4KVkrsJY7h2ccI5Ttu9W6OoggLS
 HIT2aPzRwqFUzb+FWpzOHGjVyADxPFH6eDabg7mjKOHYV96p3YSKWYi5B+FRj3MPPgseImeMQ+D
 xeUsRkD/6sf9I9L2ZRK6JTbC/G8JsHOvGm2zNfDeQ3KjNISBAbfF3wyF5J4tVhbSDYn8PjB97r1
 oMg+8xXNrZ+OOd2QepLeum+wUg//TgDRB+OMbpimE7457vlXbilK/lis41fm3ZNzhqaU8zyCX8p
 FwZzmew7jq3oAMiZjHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2MCBTYWx0ZWRfX6B/CgpPJb8VB
 DVJ2qmuNR78Beo6MJkJjiLsVEhpqfJy294aH1SFzNG39A3jpm6QlKL75WPj9s2hYgajPMZF/SHS
 Su6l2fdY+o4phpZqO8utyS/AzlSOi0U=
X-Proofpoint-ORIG-GUID: hNyo7S_vHUNomwC3S-ftDDPq3TDa6ymz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110060
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37657-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:veerendranath.jakkam@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1429866F02A

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

Populate link_valid/link_id in mac80211_hwsim TX status so the
transmitted link is reported to mac80211.

Set the link information in both the direct TX status path and the
wmediumd/netlink TX status path.

Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    | 43 +++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 0dd8a6c85953..61fd8d8ba1a0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -2103,6 +2103,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	bool ack, unicast_data;
 	enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
 	u32 _portid, i;
+	int tx_link_id = -1;
 
 	if (WARN_ON(skb->len < 10)) {
 		/* Should not happen; just a sanity check for addr1 use */
@@ -2160,6 +2161,9 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 								 hdr, &link_sta);
 		}
 
+		if (bss_conf)
+			tx_link_id = bss_conf->link_id;
+
 		if (unlikely(!bss_conf)) {
 			/* if it's an MLO STA, it might have deactivated all
 			 * links temporarily - but we don't handle real PS in
@@ -2271,6 +2275,12 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 
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
 
@@ -6092,6 +6102,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PUNCT);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PROBE_AP);
 
 	for (i = 0; i < ARRAY_SIZE(data->link_data); i++) {
 		hrtimer_setup(&data->link_data[i].beacon_timer, mac80211_hwsim_beacon,
@@ -6317,6 +6328,27 @@ static void hwsim_register_wmediumd(struct net *net, u32 portid)
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
@@ -6397,13 +6429,18 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 
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


