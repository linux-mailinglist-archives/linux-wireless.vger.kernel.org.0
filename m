Return-Path: <linux-wireless+bounces-36087-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPd4IvzI/Gn1TgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36087-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 19:16:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A71D4ECC6F
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 19:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF2F7301436F
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536992E1F02;
	Thu,  7 May 2026 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xj8WLnVG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iu9tyFSC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285444E045
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174195; cv=none; b=CXWhYLH7qnR347aRqubLwl++VmvThMdpn6TVUSXi/GFNyHULxkCVkLqjUbXsulg83Xpdi0ZkVaM8GdevNxMnsrwf47OOaiTmK6zE6c8cpFxe4tZDmHbKpb4Z8MfnA3R2K1ijzoWMIzch/PIRMlZcwoEqQKtg3jilADfHpwCORjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174195; c=relaxed/simple;
	bh=GvJc1lSPtpSgv2IF0WMJEWMjSUgZil4pFug0UjPxyxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PthNxETJApXxURG7jgoBduxaLSKZqxv+BTG0mQ7OfIK8YoFBGrhh77pL9HMyLNGkYvID8nFEGqiiQGgS4GTtSaWnrGU7WFrZEIOZ4789h6c5piy7PL/erJCAU733+R7vWtyZ+rfajQy+Q06DotTMm2+62FeVQGIBueeI7GKpON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xj8WLnVG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iu9tyFSC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647C5Wsh1971634
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 17:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ROxcqDbdPdC
	LMmcWeZnJr9Q9GkqlfiECDl0b7n3aIuo=; b=Xj8WLnVG6VxN0R/9ToKxLdVNCVU
	+OCeLdeDSCspTLwbjqA5KSlf+qiwvdLsDPedhqvqOPNCbHgskAVU3y+B88817mYD
	1jzoEaSSk0tpc+COPj3fDGSvQlKK/kNEAJWPvxWy6c0tnNRWsv1yfKU6i/ENSusa
	BKd+RtE0aiUqtWv3rMttGADZlbH6KK0854067jHRULaRbeCEWoGhAV1VbQwkws6f
	wIjNm1Vt5J1YqrIBJ7yvlduPO0yMQxmeLAOajGGQ1NAbPEwK8HAnwJZ3TWICs+rU
	jQ14RxX0Y+YoXHZu1GfipVdEsLyc/ojtACL6qkgZOKmsiHnozxgBrBn+2kw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tej9bkb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 17:16:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3651991d0bcso2237559a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778174192; x=1778778992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROxcqDbdPdCLMmcWeZnJr9Q9GkqlfiECDl0b7n3aIuo=;
        b=Iu9tyFSCG7jyJDwdXI1yeeQmr7NQvl/WzfHGw6WI6N1fZBIbWq4cfrf5tX329Glgi2
         G4FdRhdnojGDtNrS5MRMf1DW742t1UAzRvy8DF6eIORUNb32c0//0aaw9FZXuzHqcOPW
         Nb9JE4DQE6e6uNy9Ebv4HPhw/qvakU1WFdI55/p3G6MEqeR4TAH5h9QCrArVdFlIPpOB
         r/tTq+vb6ajQlbinsJLt/R0iYcXbggcOUxyJ7a6z/ARZgMx+5r85VrUAn2BFcEtA/YtU
         U24mglvX9wnA8ZiOcJddsusZZp2LZ4MuBWLficXZ4en3FBgYTY7mxNsNsot+AozhhBJn
         Z0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778174192; x=1778778992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ROxcqDbdPdCLMmcWeZnJr9Q9GkqlfiECDl0b7n3aIuo=;
        b=qsiJYnqBQcUkU466f0ceuwPAmBDKP7KzlK2UeCXWHLXuXvo0ztEjqOOYURkTtLNfLt
         zqRoJvBlHu4skDR/fizc7xFK03FFQ/6ZCe7tDB+H7nU+1KLb+yLSXxIobHDHZBAmXRhg
         0VtEhMnWF9pQFpdmZYcqlzoEQRscMckkLwV/fw3NLRiKtyr/ykL2kyp3+1Z+abR99J+P
         3mC3x7/LvukA9iD0LFIicNxwaYJjbp7q1YRMINqUtUDOkoy9R3hrI5vpnweFwTwTQdcd
         StmGU9cW1KVhr9/TIFrrF9m8Kg2ZC2k5S+x+6lIseDydRarrDSMBrvmWoXZxoTJG02hf
         wlBg==
X-Gm-Message-State: AOJu0YxmVkrx4QTw4yeQE5LIoM1qZ7aeKES2fCy8KrPPTE8LbJ3VwhEt
	1UBj7izV8s91bNALx7nPnWyDZ7yFG8ApSoVPk3Cp241bXpatUck6M07bBBDAzEKQ+IJAL+UxHqp
	APpjkFbCs6sTbVH8etxvbBHZRAuW3GkBzZSsUEs2UtKvoIJax7Fz21CbG04wBZYNyuCREeg==
X-Gm-Gg: AeBDieum01YSeUfSClf6zlth7dLa9B+eeXI+iHILZV6ZSWsbVEwqVrLv4Yakz2fqFaA
	FvzPOr6gKuTsId6k1SmySNYuyMYnIAFA9+x8u3HpM8pWTjri0jeIThOk6dZDSheFPsQl+wD08lC
	IswsRh5G4BiofD9N/InrXzA5C4Wyfd4+ihwVV6UHbCBgjZb3HVbgE6F+wIBNIjfIXI7Iyovw4qz
	eTIgG0j2r8iWlWj0xPQICmneu0EYDvQKSg7fK4t/Ewy49by5ljT+NJazCA7SGwILuKiEM3XPDHw
	NpbXhsbmhMp2om7jX229znCEvduvgjiSxivEAOZdjaLGDbxQqyw9cXPrOBrT/xeeNgUNmdON098
	UxbflKJYuI2LrQ/QTPkAmBZTUpa4TfnOiRbwWB7IUu1lkEOHjyQZynjrq
X-Received: by 2002:a17:90b:4b87:b0:35c:1f29:712f with SMTP id 98e67ed59e1d1-365ac76bae1mr9124346a91.24.1778174192431;
        Thu, 07 May 2026 10:16:32 -0700 (PDT)
X-Received: by 2002:a17:90b:4b87:b0:35c:1f29:712f with SMTP id 98e67ed59e1d1-365ac76bae1mr9124308a91.24.1778174191973;
        Thu, 07 May 2026 10:16:31 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82640f7838sm121457a12.32.2026.05.07.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:16:31 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 4/4] wifi: mac80211_hwsim: report TX status link_id
Date: Thu,  7 May 2026 22:46:03 +0530
Message-Id: <20260507171603.1007812-5-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507171603.1007812-1-pritiwa@qti.qualcomm.com>
References: <20260507171603.1007812-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3NCBTYWx0ZWRfX9TmZklh+Pxft
 RVa+HFiFzvU+45uAke5ofk/HjcNvmZI/8Keb1jjnljk0OYAuN7MQB+9M9RF3yZoLnlGpQ5jcDIY
 CksF3JkZZfeF+D+yhDOoDd2vPkQpX3vckDK8FsmVVyrwjHpH0VU/bfRCxtkVz3Lc5htiYLENRsI
 q2RBKUgqCa9EKmA506Tm8mbp5YdskQmVKZSTgd7hQLEhPGEBTyEOXLmM7QBcxbH1IbD5XA4BORU
 JznL5oJTQsgHfJ4kWZJwt1KXtm0LFmcf1bBOAG6MhlXtQyrzJpr3yNXK01y+IvqlK9eBMnKV6+D
 wBGmIUf3sPltmGAI+Es98VuwWTFfaLSyfiDbZQKbq3t5pQo1uTfS3dtA0GYHRgNXG7nFuu9/9nO
 Lr6fG6cGvmDiIRs4Lth9dIh5RT/swxhJiKr8lFvk0AE2c2qY2B6HBCpofl0uUiWRKRnyrtczunM
 TDQt8XceMD/KBdSB04Q==
X-Proofpoint-GUID: TUdTzkgKw6vDAe6OIulraiiFaQp5RACK
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fcc8f1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=NjFlLJTsBWwvL5VAOx4A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: TUdTzkgKw6vDAe6OIulraiiFaQp5RACK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070174
X-Rspamd-Queue-Id: 2A71D4ECC6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36087-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,qti.qualcomm.com:mid];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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
index dc9775cd9f54..4ad39cdfb7a7 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -2077,6 +2077,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	bool ack, unicast_data;
 	enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
 	u32 _portid, i;
+	int tx_link_id = -1;
 
 	if (WARN_ON(skb->len < 10)) {
 		/* Should not happen; just a sanity check for addr1 use */
@@ -2134,6 +2135,9 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 								 hdr, &link_sta);
 		}
 
+		if (bss_conf)
+			tx_link_id = bss_conf->link_id;
+
 		if (unlikely(!bss_conf)) {
 			/* if it's an MLO STA, it might have deactivated all
 			 * links temporarily - but we don't handle real PS in
@@ -2245,6 +2249,12 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 
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
 
@@ -6037,6 +6047,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PUNCT);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PROBE_AP);
 
 	for (i = 0; i < ARRAY_SIZE(data->link_data); i++) {
 		hrtimer_setup(&data->link_data[i].beacon_timer, mac80211_hwsim_beacon,
@@ -6262,6 +6273,27 @@ static void hwsim_register_wmediumd(struct net *net, u32 portid)
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
@@ -6342,13 +6374,18 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 
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


