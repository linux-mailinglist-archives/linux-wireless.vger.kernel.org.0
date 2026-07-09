Return-Path: <linux-wireless+bounces-38821-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YbjwLYGKT2rMjAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38821-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 13:48:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F07730946
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 13:48:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=YmJ0DgEn;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=f9o+ZPdT;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38821-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38821-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74568309D660
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 11:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC78409631;
	Thu,  9 Jul 2026 11:42:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E27410D01
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 11:42:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597378; cv=none; b=k7fEiYblEuCr0yj7KaOruShMez6JihODxyBpqOHCWhxWvWn98ZaebZ/36LvYj/AU05Jd+8es4Gcn2ZltU6K87hjOV3G95OhFdNCQUeQ8dMZfVLGX83VV9W99m4969gLo23VFWBzmGqsmA6u0G1ffHm338oLnJrmQoLkDcR/aJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597378; c=relaxed/simple;
	bh=wcx0mnST8SlDk6rmebO+ZZL6CGN2pWeuykJFB1qQ8Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RLobB8Ceimy0N9UxfGat64tnP1l9ojocBrpMfyk9xkQV8A6iQ7KVlLdgPi2vrQEkigfwZs0EHgF/ctYnNPR5MZ3Md4z9Otu+Af2SghHPN5uCvd4UdmN/qFny/Fbhd/lpujbE3VuT8EIQvaZoC483rwYJPQbrEXim3xTU9P6TxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YmJ0DgEn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f9o+ZPdT; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNN571575673
	for <linux-wireless@vger.kernel.org>; Thu, 9 Jul 2026 11:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=e5hJ4gjjLT8
	WL7TNY/WnrwapNHTi3JeTi2/uXVaLhrI=; b=YmJ0DgEnUvhkcAJaFyo5zc4a1IW
	boTBEXaxRjhswA6Qs6TQeDlTGUm1pPhRZqqVQc/3rstfShxzruAICrIa3zbRGYN1
	m8ivQNVZyC8m2dKTyvY1+yijsnAi6khmVFZqDf0fNYKk7UsSK6PYN7M/90+oseaW
	0AUINnXodCqRN5PXVD6FWsBtQG+pw1E/M6l/w82r5eQ7H6G9d14A7b52YHHbPHGr
	E8fw4fKOQoWcsBkiFccK8sNJtW/Qeovy8N/5SAyphqkn6yu8r+etHxY49Pd99ohO
	mGbd9rdc3usHIdJB5o3ZmDLXq6uQ4UBvv1qxgL+FOEvp6YqT0JD0rNK/zjg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqwc04g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 11:42:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so2272077a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 04:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783597375; x=1784202175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e5hJ4gjjLT8WL7TNY/WnrwapNHTi3JeTi2/uXVaLhrI=;
        b=f9o+ZPdTIzkeXC/9RG/q5MhpbwpluCohnTOfE7jmbd79xmVLssOb8zPHpLWja2W28P
         UEF5O8MMRBFH7lJKWexlttogknSrs92wdM340TXH+LeBvKJwHIOaaV6zOGgnvKE3zuZG
         GMEV9a6qETH/sSJv6bL1j5WonmH0cqUKeZ6BDziO4F5Id72nYQscQW9Pybm8YRRVoOan
         COLhhTRtfAoxCQX2iEjhLp+8Fc8fw3r7tqgeV4bS0uLGeGoUa6a/XhuLKcr+eSBred+g
         AlHVChYwMADk9bRDSIOQSm2Q8TfxGYXtHch8JuU4rVZ0q38DRAQGreNSLGT2e+lb2/UC
         e4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783597375; x=1784202175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e5hJ4gjjLT8WL7TNY/WnrwapNHTi3JeTi2/uXVaLhrI=;
        b=DMne/qRZp5IDnQMl7MNj98T00qVpiStB/vEZJvVxGAeBWjHDuhRswDl7Cy0ValVw5B
         MeyeLSGFJI4rTPdoqwR2wv67/ky78KPnmrk9QpSZDLzwCy9L7cfVHp2m3iB4RNiU9VJM
         TZVtpwVdkRZDNudTq06BqdU5Cq4rYNBjD0LMKRzs9S5RaIc5tuXAp0lreTf6NsdcRQWz
         0myfIQ7QwOxof/R9xSQsmIP6HgCu4J2+svSfaEnH0jvCKYoY53z+CzfafutPukhXQxAR
         7whaODLZxYyGNK0WF/VLyp2wEKgVsaeKu1VxZEN14tgZQjZA06M11RBdVrXs03HfrmEh
         XW3Q==
X-Gm-Message-State: AOJu0Yx+tmEThzEq8eO31qWXYDTnnqNUgnsJ1B0pDMpmHAwvjMaWiwKH
	paov1oe2kX5tecNeXo9TeeyE7CZk3JYm/t/EmwFUSyJYcBWE9yxZoyX5nrC8CKGYwME0NmxssmB
	bHCM+CV7Lf/OV2LgKskm9pwny3OJJQepyvgER1+f6HECJMm9cVt7ufBy7STgprHQM9yaZRdw01X
	R/Fg==
X-Gm-Gg: AfdE7cnmzjjc/v1DyHBY7ZmMn81WYr4wadPHxpr99z69HqteOIDZqR46SyB9u5yECs7
	8TCSu1wBHUzpU23oOmx0ni9cT7V2i/bkfhxQGagRk2WGVgOZJzAfdCNan7EnMNujG9dZxC+gn6v
	6anFVtY7AZcNbmF4DslUVUsV+3STaHkWFYeGHKT+0BVjsaK69F2B0p+TcYcHBMuRPi0834u7uBp
	SjQwjR3VSsx/eddT92XkEx0irURENrC9Hlbf2kGLMMe9s0PXARKWzxhAolcCpMP9ewa5yBuhL1l
	nq8x5HwtKPutffwc0Uhloy1ijV3JtTK/Q/+HC9ZNDJu2M13QUdlhh0Dh0fLa5LYHHRdhIHCtv0e
	nCq1qTbhGh2bF1Rvi1M83xu/Csc0Y7RvsPZY=
X-Received: by 2002:a05:6a20:a10e:b0:398:7df5:2dae with SMTP id adf61e73a8af0-3c0bcf49b71mr8002851637.9.1783597375072;
        Thu, 09 Jul 2026 04:42:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:a10e:b0:398:7df5:2dae with SMTP id adf61e73a8af0-3c0bcf49b71mr8002810637.9.1783597374574;
        Thu, 09 Jul 2026 04:42:54 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6594f9a0sm31772753c88.4.2026.07.09.04.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 04:42:53 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, veerendranath.jakkam@oss.qualcomm.com
Subject: [PATCH wireless-next v6 4/4] wifi: mac80211_hwsim: report TX status link_id
Date: Thu,  9 Jul 2026 17:12:28 +0530
Message-Id: <20260709114228.672317-3-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709114228.672317-1-pritiwa@qti.qualcomm.com>
References: <20260709114228.672317-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDExMyBTYWx0ZWRfX+vnoHRQ0yorV
 OQKrByJwkUd+SA6nE9lLUbATGKVjRV5hNUfJDBSMpL7A9IKToqzzta9JfhPLLO280XAqGTZpnE1
 psDJT1aKKutcFVGvoRxOe9jzvMnQRMEEuSFxY7kAD+kduwPO8B3QZbQRbC1K/h3JfPTmNXSfzYj
 3dRfImJAmQV+az176v4sMSJUzNusujjzM6EgBW2S+ZhStvnY06E0VJmJyYhw3elMYQQokRv7P7U
 ZGQz4sELVmg+QeQHSeycxYP6jfv3gT5FGlkcomHnphjjr97JmRf6mamkQbVTSqDa4bbox3GeP8q
 kK5AWOUeBwNzMFSh61A32rwgZ5F++f+N6QUYcUpbMcy8s6ChxLVlUd57NZCEfIIXoHp3XApBZ4j
 JW4LZnLI4GZvV18bVVehI3dc0DzhO44pxJ2AkXu2DdA6Z5KJgVWJqrze+QwSqTIS7iT2RqciOAD
 vd05+ut09D8tPtOdGOw==
X-Proofpoint-GUID: Wf4JUGJpV1ZtflTA1aaTjqCm4xr4TvWY
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4f8940 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=NjFlLJTsBWwvL5VAOx4A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: Wf4JUGJpV1ZtflTA1aaTjqCm4xr4TvWY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDExMyBTYWx0ZWRfX4J0jPW3VVieI
 F5U+uDzfyv41HXhKf4CK8/XAw+38jPq6n2jZL/F8wkdEbHoDBCCi4ITeHJyXPrM3uxsizg3Y1QQ
 cn5ltYs9BOaqmgZrJslH1cp8bH/+B5o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090113
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-38821-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:veerendranath.jakkam@oss.qualcomm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qti.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 34F07730946

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


