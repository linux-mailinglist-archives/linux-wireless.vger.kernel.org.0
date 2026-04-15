Return-Path: <linux-wireless+bounces-34761-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH3PAJpf32k0SQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34761-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:51:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B9F402E24
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3971A31A8CDA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE56533D6E1;
	Wed, 15 Apr 2026 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LW0drYwz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c1ewMeG2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BDA33B6DC
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246217; cv=none; b=B7HMR5m2x9lDhZY8xMeZidJM+LxFMeqTROoT38q7j4gZ2+534C0KA9N1LzXhu4+eCLgoLBvFhPtLMYtxFCd3+iETyNcQ7ZWYWX37ryE54b7f6sODkkoW6LXszleQ5bwo6Z+uBlo4Y0qCA8jorqIlSj4MMJ9XIVY4nDJzcmGhwp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246217; c=relaxed/simple;
	bh=ft3c8Hzj6D1pLvYZvtpnWJAa5AvgzNT+r4j74jkL9gk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VqWrEHIAkfcNdHv15nyBuMyUMz8EXVDfuWGEMObpk1BPsHJ907KTDOnuoDS0abdhU69FPU3zKBYVHSYuFir1EdzpwY02L9gRBprEwh6ERaBCeySWbJLZVK7wUAJnGB+U09XS05ntZvpCVZbNMdMRqDW9Cpr/hQyw3S1sguEzfOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LW0drYwz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c1ewMeG2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F5xFoi2772603
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BOkbJ7B+9b/
	G/PSD/guAysA1Rp/LOpG4NfLcDhJ+B6s=; b=LW0drYwz+CTaUKpWPnuDX/NWmjF
	xFlmnuj0OU2Czcu66PoHSGeYINleZXHJDMbVlDwCtkmON1jq7zJqPFa8MgDWoxDh
	o8GVpInpUpkRag2ZAaQJQEb3G06qZ1jzAn+P9bvzXDBj9kyB4/BfccqOcBv39FPJ
	tR8Sv8eGxMkBZgdMuwu8qqOhbKbgtx8YZaKlqzYK2HW4GCKJDl35I9wfaRu4LqDq
	Vmohqi49AHocS6t67tFwLedtkUhYEobloF2HqfoQe2EvXeWNtlykEEN+P+twE557
	aab0lUmDSG5akJ5+qFKyqTLQvLRbcjR72cVGy4pIG95e8SqOGz4Ur7ywDcg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj50v0tq2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so7117687a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776246215; x=1776851015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOkbJ7B+9b/G/PSD/guAysA1Rp/LOpG4NfLcDhJ+B6s=;
        b=c1ewMeG2YD2Cp4EHaVZVOSd2uvG3GaF1N0UUJp4PNz/5KTd1nN8K8s0QBTi3eFT1ZR
         oyl0epB6f2v5aJxzsr/rimzNCwT4qWaXpOqc8rg6HAemmiE9nupmnX6/HOpSDOQ3EL6p
         5b7ZGBSWC6JWlIUYjSYy4MolVjnO3otfZWbyykHybPjT++8mllMNJR7P8R9BlcETA+8D
         IYdHjfzVsJPD5CEHO/CEQu6RpI3oHHkZjSIr9SGQ2aI6XJ1tb+Eq7SOjwUbsrT5uI06k
         353hlrmqm84d2Z6FRtstrEkfGy3d1SLwEQq96BhAHTrpNKUv0TMeY6+bu3U5WZr2pxvX
         uf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246215; x=1776851015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BOkbJ7B+9b/G/PSD/guAysA1Rp/LOpG4NfLcDhJ+B6s=;
        b=HGxqACrOFLV+ZtwTvMVtEjrwsP1KuoXi19pQpamvVnqSKdbm+nflQaMvxxzLEhySMh
         gxJuaYcJCD2OIyTI40kG9vEflUglqjoUsRI1yCZouhq889B//NLizZprQiwhLqCauJep
         J6bDqdEqCPZWr5V2ctS1dLm/N4IC4WCcBTcsFVo7DJgTQRI4ATgTi/4esrwxaHhA+Hp5
         W6GTwrsirbUHGA6km5MwJDuEJ4AsW40fqQ7DkbxBEmRr0p4jhWaj4u9F2ht5jjkuYnqo
         OM24k16yKHiMcYxK0wf0e8EYkCk+otelLJDRLGJwtWpp/Zv7QMJgMwtwyjHuGeK5/fY6
         IjAg==
X-Gm-Message-State: AOJu0Yy76xpHk0w2Mmdtuf8iMkfNO8FQVzSRQ13YtjT7pwDEC2cAF8D8
	C6hNeJvrbTmEvjiCJAVGSb/ucm/bFKwKjWBWGznVGtLY+dR01OHrzwdAMlY6UOUwClEtENxSDgu
	czhv/g6ETtj3yFY6lYE4xQZupnuzAf/yu5Ijo8tR9omgMXIy6OYgZXipHwO6NTCLP3AgkSnhAqm
	Z5ug==
X-Gm-Gg: AeBDieuO7KC2mlE8dmvVukV3rdkiUdPcnzAncMxvdwUY/Cb+raP7tOmeYQMiiJ6i1gQ
	1Ezj7lVf7FfL9gWZFDi6Kov54S0DESVUjp+bMkvN1NFUwDliQ8C1jDJkwQJuIusFK/QKUNqjTnV
	c5bLixNAloAFatyDRRqqk12KyRj1IceL72SCsV/vOdeMqUvUK87/qlIF5Lbq5Lh4D+6LRzFGgk8
	nbcZohao0GcZEakLx8prepWlxjh0oE5xNAlb4g0KCHnEs1KOS0TUFLWGc67qyviz17XnQnW1rnA
	Wncl6ywlNmjAXHmwuVMaHffWiRzCkkslppRXKoR4z5kTUo2IdiIXPl8AuMZEqm9qWIOAgyt7Cid
	pvE3qsek9pblebxz3i7VLULMjD1uSaE9U2W8h+0QXkOUzH6RGvNAi4iEP
X-Received: by 2002:a17:90b:5548:b0:35f:c156:a82e with SMTP id 98e67ed59e1d1-35fc156ab7amr6493070a91.9.1776246214772;
        Wed, 15 Apr 2026 02:43:34 -0700 (PDT)
X-Received: by 2002:a17:90b:5548:b0:35f:c156:a82e with SMTP id 98e67ed59e1d1-35fc156ab7amr6493048a91.9.1776246214292;
        Wed, 15 Apr 2026 02:43:34 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd2101cf1sm2391200a91.15.2026.04.15.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:43:33 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Subject: [PATCH wireless-next v1 4/4] wifi: mac80211_hwsim: report TX status link_id
Date: Wed, 15 Apr 2026 15:13:04 +0530
Message-Id: <20260415094304.1731390-5-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415094304.1731390-1-pritiwa@qti.qualcomm.com>
References: <20260415094304.1731390-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: q4wy7TpzKWFICgoj76gus_4Tiz77Brag
X-Authority-Analysis: v=2.4 cv=eLMjSnp1 c=1 sm=1 tr=0 ts=69df5dc7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=NjFlLJTsBWwvL5VAOx4A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4OCBTYWx0ZWRfX6i1Z/uPcQHxp
 0zaUV42mJMncVVC85Zb5yPfrtuYZAfMP73l1xrBk3W83l8If50M5jufPREFtvdWDgus7f3Md2AS
 iI+2PMSPsxRZauD05PDpbi4NnDUh389EIRPmpfzUQ3tWVmQ8tdA/Jekdfc+vjcBokF6CinC4r3K
 f4l6V+2vagHuMTk8wyvhGqrV2/Q8SfOpOM8QKzOhv4yMCBoVeAGMWUUB7Qav+NxAoi7FH1wcqYP
 X0Y+bynb1mBRQOlQHq+IQb2JH1nV3VaomGYlQRUhUBE4u8UuUzBNPR1rJhYAXUaRTmPgWpCWWer
 ISePj3X9S23mUTL5xG1Y0haVmyqkiLlPU4nrE3nmY4w4Nx7U0Al98RFVoczAmV24mrsqDCUlmaz
 9a4Znylv0KHVQAwdCZohMmyZ91OJnWhOiGrLSH35eL/pmgqoOVd5tnVV/3K6cdKirqJWk3hL1rK
 QdQcW2aYZWlPPkZEeCQ==
X-Proofpoint-ORIG-GUID: q4wy7TpzKWFICgoj76gus_4Tiz77Brag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150088
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34761-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qti.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 65B9F402E24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

Populate link_valid/link_id in mac80211_hwsim TX status so the
transmitted link is reported to mac80211.

Set the link information in both the direct TX status path and the
wmediumd/netlink TX status path.

Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 1fcf5d0d2e13..2a3df3e81f54 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2074,6 +2074,27 @@ static int mac80211_hwsim_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	return 0;
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
 static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_control *control,
 			      struct sk_buff *skb)
@@ -2087,6 +2108,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	bool ack, unicast_data;
 	enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
 	u32 _portid, i;
+	int tx_link_id = -1;
 
 	if (WARN_ON(skb->len < 10)) {
 		/* Should not happen; just a sanity check for addr1 use */
@@ -2147,6 +2169,9 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 								 hdr, &link_sta);
 		}
 
+		if (bss_conf)
+			tx_link_id = bss_conf->link_id;
+
 		if (unlikely(!bss_conf)) {
 			/* if it's an MLO STA, it might have deactivated all
 			 * links temporarily - but we don't handle real PS in
@@ -2279,6 +2304,18 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 
 	if (!(txi->flags & IEEE80211_TX_CTL_NO_ACK) && ack)
 		txi->flags |= IEEE80211_TX_STAT_ACK;
+
+	/* Simulate ACK RSSI in perfect medium (no wmediumd) */
+	if (!(txi->flags & IEEE80211_TX_CTL_NO_ACK) && ack) {
+		txi->status.ack_signal = data->rx_rssi;
+		txi->status.flags |= IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
+	}
+
+	if (tx_link_id >= 0) {
+		txi->status.link_valid = 1;
+		txi->status.link_id = tx_link_id;
+	}
+
 	ieee80211_tx_status_irqsafe(hw, skb);
 }
 
@@ -6009,6 +6046,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PUNCT);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PROBE_AP);
 
 	for (i = 0; i < ARRAY_SIZE(data->link_data); i++) {
 		hrtimer_setup(&data->link_data[i].beacon_timer, mac80211_hwsim_beacon,
@@ -6312,10 +6350,16 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 
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
 		if (skb->len >= 16) {
-			hdr = (struct ieee80211_hdr *) skb->data;
 			mac80211_hwsim_monitor_ack(data2->channel,
 						   hdr->addr2);
 		}
-- 
2.34.1


