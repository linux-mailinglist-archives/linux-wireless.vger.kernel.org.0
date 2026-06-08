Return-Path: <linux-wireless+bounces-37497-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GrDYFzGIJmoRYQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37497-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 11:15:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C66136547C5
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 11:15:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="WPW/BaAj";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MsGGYrMh;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37497-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37497-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 190C63056629
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 09:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4141A3B42FB;
	Mon,  8 Jun 2026 09:08:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B022423A
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 09:07:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909680; cv=none; b=Xgq0G99BGpsgFM0c5IJUL7pSh0e74ChYdxTQgvU9MxI/00M7GP6dL1N3k11uglGVEFYCQVq5WQONKuPCru1GTjTcl4z9mS/U9iUvDM62g8s/WMjDfcc9KUh6oXkO3efYCH1k9gn3tK3nhDXx56+8NwYKS4k3CXC+IouKsQ5Pt4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909680; c=relaxed/simple;
	bh=GvJc1lSPtpSgv2IF0WMJEWMjSUgZil4pFug0UjPxyxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p4e84X1XKRgtxlEa83RiCdjKSAuXBA4z0mbpP4ZI1EbsDDct5zxkh7+jT1kTeoL4zIDtMbev098O0Uvq6s9zHqk3l+oUlnT4aYAorzEPqrB1ws7nHXeQGcFKhRjSVjVHQAUqniUGf9N0aK3d1qIISuO1VtSe++CYtXM1GL0Y1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WPW/BaAj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MsGGYrMh; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586SIrD2835637
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 09:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ROxcqDbdPdC
	LMmcWeZnJr9Q9GkqlfiECDl0b7n3aIuo=; b=WPW/BaAjUYmywarYM2VDUI7Mkkw
	DFJku0S7LPZZTLl6yWYToTemmMl/2L+k8MpsWQhHS6LT0Ruc2rANBKb6+RGlo6U0
	WGQMfs+98x7GUWYyaR89+kWNl6Ui4bSkIhQAOeiMvRybAhNPyrEJ289zFA+XZT/J
	G8tx7gvSUHmXKLb06S5wSn1k+c+u+CMuDhvkfE8cQL3hfvS8/VFr0gYurD35Hdvj
	W06SlFlCRyeyt6IJJvudMhxhBBQ5SuIx92P6eeL7FiDraKFVL+G5EOIN8yhKy9ml
	Hs6shyqt7vCZ653pGq77Q8IEjoCSQJm5KPDuw4j5nuLqTzZiosnmwc78qBw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4y9ng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 09:07:57 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85a298cd62so2663811a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 02:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780909677; x=1781514477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROxcqDbdPdCLMmcWeZnJr9Q9GkqlfiECDl0b7n3aIuo=;
        b=MsGGYrMhOyEZ8lT7K3SsgZwJfmnXI2Wa4EZEP9JoRTu38SZMFvHg+u0zCDk/I0gAqq
         l9xZmszJZMRAJv6c98CBnFARK9hfvqUZ3Xb5ioIg2LHznIun9Zovrf9dFajeRVbto7XS
         djGx6JbfPzwpw4y71s+GLiBUQbcjHurbJTUgviljGPVzeVeXnllDY9sj+x/Tpns0AjRn
         wAochk9y33OEn9Z7DtAo0GcDNBNjqBj9k47JVENFaXPbZjm6KOx3fJ6CTRfNaSKIGgkC
         3ntcSSabmfReJ4BYaAALZu+fzBUml943I5aNVXeJLrLP79FTMeI3ZT6U9ydvQDTZ17xu
         kL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780909677; x=1781514477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ROxcqDbdPdCLMmcWeZnJr9Q9GkqlfiECDl0b7n3aIuo=;
        b=OfhRuUEe1xKQRA9a8cz/mSN0WtAaeViX8NQjgRc2TmAgNEpGhOaSFSc7x4tDGPBVNf
         F9Mwhy4ZCi2MoCBCq+bg2IKLMOr/6UtDfyjjfRJbf+0BLoFsyaaX+PXzaO4zqRehR56b
         bdR4z3adOXGrt8Yavdk6GlxplTe7t9fK+PXvx41iPmZ1qtt+kVSnNrBtu8uhlvIr0Bqr
         SNXFH69h9hLdsj+ORCc9nqxpVxd5I0ZDQPpJARSw7CbqKpr+mZ1snQBUF6krm6T0utuM
         ehg+QjObkiGB2+HVhBGTn8eVb4jfix9m6/OPUonRwiWu31uFh8oDcLk/R2R0Zozscwiw
         iO9g==
X-Gm-Message-State: AOJu0YzONIFFpxGBuv+8pPTnhaW94HnJKj/flG6Vy2RGisFjL5f/x9D/
	FkqOshd1MZx5zYETxhiMtC0HXs0zEcoJUvb158FKxqliZMWc34pbRE3lwkhtpyDftmSfPbsVx7A
	iaevU9DTfG5tmlYZmd/oCxw6IvA83/vD+NDwokckhCjb2WzVfTfwqLESciH4CGpvstprtUg==
X-Gm-Gg: Acq92OGL8x2eKKTh/5vukG8+8bIEG/fWsbkM4O6BqHMN+lNQ3xY5LWuQAT8uwLx7Yo6
	G8OM+0Ta5IJAJSCGgZG3S79xvpWAK6hS9xlDrWzPVexNh/ujfsZJ+/IVQawHQY48N6HXB+r0Rvd
	nJktZ6+j1yIy5LQUSRJbxsP709m0O9ko/MIUptmjYJGMTi8PD3SjyO+X/JxH4ynf0c9fHxauDzZ
	spBoabXuiyxXwe89kmuC6iE38avr5hdBQw4MYP9HCunFTBKNBCdmvRGfzJPXqHsTG9O+bf+MqlK
	hz7G6/N219qcoKlvWzEBE5QJHaDM5OvvhouTIkZfHRiAfSvHoPGe+WsbOUn065y20ioNisLFZZG
	+JnWODJI1eYjblgLt16+8Bj0m8/2f3e3mOhfksV1sDOuxURY/pC/MzVYt
X-Received: by 2002:a05:6a00:2e23:b0:842:66f3:c51c with SMTP id d2e1a72fcca58-842b0fb6c50mr14332046b3a.40.1780909676752;
        Mon, 08 Jun 2026 02:07:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e23:b0:842:66f3:c51c with SMTP id d2e1a72fcca58-842b0fb6c50mr14332018b3a.40.1780909676303;
        Mon, 08 Jun 2026 02:07:56 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282379db0sm16512603b3a.24.2026.06.08.02.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:07:55 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com,
        veerendranath.jakkam@oss.qualcomm.com
Subject: [PATCH wireless-next v4 4/4] wifi: mac80211_hwsim: report TX status link_id
Date: Mon,  8 Jun 2026 14:37:27 +0530
Message-Id: <20260608090727.2389161-5-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608090727.2389161-1-pritiwa@qti.qualcomm.com>
References: <20260608090727.2389161-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DGNQuQPhIJE0c_jDCRh9GTW4oCCSHQ8Z
X-Proofpoint-GUID: DGNQuQPhIJE0c_jDCRh9GTW4oCCSHQ8Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX16eAcTY5mH0l
 JoucokFcDDD+peu5nlplXaqjiiie0GJMQM7vEAAc1MbtQ1hl+cCvItomP16uQqTLqnMahjNAVz6
 HRXW4osyPQsCWTq1gwd+aiINLc9rk+USsBeCHuO7/pzxbzXbcie+iz06pD2FK4FsoNwI6gLN848
 acP/VC85Av2Q3FtzvG+HrpvM3bptUt9qzrgZg0XqBjL42faZof8wLYM6MczrUq/miBibppKWQBy
 4BmKUkeI4mmC59J4lO8WZXS0RIxAnxlL/Zn+VJ0xeQyXe3RQc44worzN0Vb5ue7EdTbczIM9YpA
 QwjeVP0b4PhCBzIBKLL17OhRdTK1udsGyOukl+TUbD+bPbFQJ3NFrfEfZ1dsXeTRnUskl9ahaEr
 CCqxoio8XVkR55LTCiuq+ymxhKlc/dwj6kKT4GiPoyKPLr0pdlJho9yweT2y6f7oB7wtsIdHDh9
 GD1PYeOlHBc5dmMxguQ==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a26866d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=NjFlLJTsBWwvL5VAOx4A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37497-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,m:veerendranath.jakkam@oss.qualcomm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: C66136547C5

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


