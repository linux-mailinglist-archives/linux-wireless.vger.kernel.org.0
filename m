Return-Path: <linux-wireless+bounces-31397-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIXrCTnWfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31397-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:03:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB107BC5C8
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D81305BAA5
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289E532B992;
	Fri, 30 Jan 2026 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XswpQdGI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hTokUveQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BB346776
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788884; cv=none; b=VJWYEz1Qlu95yr1LdbnorfzDrFSJirtkdzY08Ca1Vj8maydlfh06o69jwRpWw47r8Po2T4QcdpMRzYTY4dYwqu+CvytowWts6h/QWNvtcV/GPrODRIhC0pwzQFxiQnqjrmKPm/QFnYTD/UmREpf4va4hQl0b4wZY3GLoaX4yf5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788884; c=relaxed/simple;
	bh=Z3DlEYfLN5Leb1JYCXQtU7sg62lDVxo8a6kKAWMXSyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHFHNSsQToeYIG0UeF2ggWg6+AKuMjvrfeWNGtR5KIQVCSchN+S5NOF5SOfnpeqWVXgLap3SX9qU5HbU/lPNuqKkrpO7IHGhrZK3r+xs/3zXev4BAu6FGx47ETd/ca8u7BprmwD+YpheeS7GOQTjcJHn8OP1fNtQYca1Hfs7jSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XswpQdGI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hTokUveQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UBa8lg996159
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FIGo4ZcWK01
	8bS1QS7waSR8BmKdHBUAG3z7W2HLNU2o=; b=XswpQdGIPpgO+BoXTKKtys8DizQ
	wDNbZBREy099QEDHdKsTk8H7A0OJo2PtpOfRFA2sUVdbLTnNABU/ij9bYvZ1PqHj
	W5F0+8QN591XDSoK+/IZH+zcjsZo5SJpisLRaW1KAjnl+FenCBA3wJeEEuvwwf0g
	ZH9MyLJ9YTZ7zgFIh6Hv7yL5BFdDxuBUe/2JnxaDSkT/RL8a4MJGc2uttv9a7uIM
	49k3NHhnxiWrM/IldOBaoQHyOxmnCQsupr+XtntXh+EQ5pFpHM2Pw8mAXbHRhbi8
	iJU2I7E8VMHG2NgOs2+RMmbSUGJzN8L3SmUyIirEi2WIuhMiThXLGRkybbA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bvvkqv9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c52d37d346dso1358952a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788880; x=1770393680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIGo4ZcWK018bS1QS7waSR8BmKdHBUAG3z7W2HLNU2o=;
        b=hTokUveQSYYC3sSXroDYKPPj/hgFd6/P6vRjSBnBLCbubSYHQVrkudTACy28iGWf/l
         7A4NiEXX8gGnX5tNVwU5E9UZg9wozabhSSX/1xou74GoES3ZlPyNIH2KwtmZtW09UdlQ
         w85mkpkNryr590WAFTrPJban9+5H9v2fRiJ3k07GhfnoVkYM/aC38xZQA4AGBId8dVv8
         6/2olEJsb1u2FRXeP1MeH8yHF1X452cYRsA4WSeqHT1Za7V9X0rrEN7USh0ChfcUxUqt
         0KOuODIdYKPKoZfVk+rrZWORSeLiGTbDaFAdXyTRE4TTGoBwobbDKoMeSgzmjujv5M+6
         tWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788880; x=1770393680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FIGo4ZcWK018bS1QS7waSR8BmKdHBUAG3z7W2HLNU2o=;
        b=u7it3vVaPruv95GEM2JYHRv/ck7uLrElFlW324g86IN550i7EbSUqizmW4grJyI0hr
         hITIJPr3nfC1YgPs3uztBfm204BAZIcVVAfAk6yfJGX5BEjcqJyDQSZOOuh0tUAq7RYq
         C6R8OiP15qLNvDSzeoPtw62+NZt9JXIW8lLBORVLJY9F/LZm5bSSSr3SgfI9/xai7Yby
         BeEvvDiaZ9kEDBjjwLXrYnd2e/nnYoCuc+9C5iWb10gXXMnSmZRHS5dvt23Brhh17jF9
         8KzUzyKs0jaG2W1LkogmZXaafEGRItfWh8fDv1SNoUetp2QPT1DM1g6MeN2TDrRrtZa3
         Wozw==
X-Gm-Message-State: AOJu0Yzi1vCJb1IKwEFdJ0bW06QkOJS3bF9PBn4pkG0fD2qYTM/mOS4k
	xIKkVVdSN9FCK0+pSTjwt7FbfUVFGZFUHMmNp5ktcGC4vLkP07MM3EnUf5+aCSOYuz7W7QICaoK
	gPqiSFEU2pDc47W00k+zJNTL/VnYic8ar2u0z8p3D+ktmdl4F4YOMhXw/+fIcEn4FjiMAQXS9pC
	cV
X-Gm-Gg: AZuq6aLoBSoZQsppamw22sky3F/AzFWbfsx8YJxGiQZ4aiUP83yZsOI+qQBT49DeXP3
	QdmV2GMITRv97RzJotaJUZv5niX6eiDSzn/yqw6Fdd96Jyiin7Eh/CT5OTwQ2q+QpnVyAGZ25vl
	Xh8ot8qZbwadub0IwAl/28GBaX55no2KPXIIhGNndY8eX4CA8ILSfaouqKE39Dc3cAnhjBRiUWr
	MItaV5Ad73ylW47Ers5cCSlcRc5ld3pto40N4NHnfeQ2CfjFRNaN0rmY/TtMyMltjX+cOLq9oyq
	zK8PW/3qaLudPqWC9mldqDReH2BvF7tvyUy3FPkwIJyjkG08XOSg3XZIsgYTaJJ88SL4UFb/y6H
	W59USZGVIEhLF5cgwpzCXR+MVAdPxUPU5sprXl2vzzOQ=
X-Received: by 2002:a05:6a20:430d:b0:38c:627f:873f with SMTP id adf61e73a8af0-392e0108a89mr3551911637.45.1769788880381;
        Fri, 30 Jan 2026 08:01:20 -0800 (PST)
X-Received: by 2002:a05:6a20:430d:b0:38c:627f:873f with SMTP id adf61e73a8af0-392e0108a89mr3551864637.45.1769788879757;
        Fri, 30 Jan 2026 08:01:19 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:01:19 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 13/13] mac80211_hwsim: Add support for extended FTM ranging
Date: Fri, 30 Jan 2026 21:30:39 +0530
Message-Id: <20260130160039.2823409-14-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZdEQ98VA c=1 sm=1 tr=0 ts=697cd5d1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2j_3TcRq-o5txmHaYkMA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: LnRN3PbeAdMKLiYCHSGrEwyP5zL9Ofzu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfX56Mn3ojnVH8c
 O+kpBiGdYJFcbXcp2gplIieHgY+Pn7mxOE7SJhpQGqaiBGInCgeqrSBgqqcXCTZnPTHB9o+j8jj
 U5fT5YjdpULZAXN60tQ3og0zqkMlcDM5rEQwrApC6FX8z3OD0mk3jiXPqY/iJ79seoBpMkqvLNp
 bRJMRhHPBnD4h27mt8YWEd0ta5CjcY0zfBuEr9lGjiLmIq7NqZvjgJ58BSOzDhQQSHzsYcA0eeC
 PlCBJD6mymxAf5WS8u5Cm5wdDZoGSkdFuM3kBiVI7/xXIW7geyBMvGBIBQC3rfaL54kylsa/nON
 A8jTbjCyyDidILTr8pA+ONZSNygU0losPHIK9n23jTqIBRDPvY/7kcdEbbdrVagSjjIgaKV9/Jb
 M8+FfX5TpXTiynegOqEzyTGkEtjxti3h/N/NuBIaNsxQqiBU2Yi9rA6B7is7xBTppQ0wI+tg8NL
 v6CUM35vSCx9q9f/3Gw==
X-Proofpoint-ORIG-GUID: LnRN3PbeAdMKLiYCHSGrEwyP5zL9Ofzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31397-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EB107BC5C8
X-Rspamd-Action: no action

From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>

Introduce support for continuous ranging and advanced timing parameters
in the FTM (Fine Timing Measurement) request, response, and capability
paths. This enables more flexible ranging scenarios with improved
control over measurement timing and session management.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..430058bb0326 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -843,6 +843,18 @@ hwsim_ftm_result_policy[NL80211_PMSR_FTM_RESP_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_RESP_ATTR_DIST_SPREAD] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_RESP_ATTR_LCI] = { .type = NLA_STRING },
 	[NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC] = { .type = NLA_STRING },
+	[NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_RESP_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_RESP_ATTR_MEASUREMENTS_PER_AW] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_RESP_ATTR_BANDWIDTH] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -888,6 +900,14 @@ hwsim_ftm_capa_policy[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_FTMS_PER_BURST] = NLA_POLICY_MAX(NLA_U8, 31),
 	[NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_CAPA_ATTR_EDCA_BASED_RESPONDER] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_RANGE_REPORT] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -3488,6 +3508,49 @@ static int mac80211_hwsim_send_pmsr_ftm_request_peer(struct sk_buff *msg,
 	if (nla_put_u8(msg, NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR, request->bss_color))
 		return -ENOBUFS;
 
+	if (request->min_time_between_measurements &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS,
+			request->min_time_between_measurements))
+		return -ENOBUFS;
+
+	if (request->max_time_between_measurements &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS,
+			request->max_time_between_measurements))
+		return -ENOBUFS;
+
+	if (request->availability_window &&
+	    nla_put_u8(msg, NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION,
+		       request->availability_window))
+		return -ENOBUFS;
+
+	if (request->nominal_time &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME,
+			request->nominal_time))
+		return -ENOBUFS;
+
+	if (request->measurements_per_aw &&
+	    nla_put_u8(msg, NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW,
+		       request->measurements_per_aw))
+		return -ENOBUFS;
+
+	if (request->ingress_distancemm &&
+	    nla_put_u64_64bit(msg, NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
+			      request->ingress_distancemm, NL80211_ATTR_PAD))
+		return -ENOBUFS;
+
+	if (request->egress_distancemm &&
+	    nla_put_u64_64bit(msg, NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
+			      request->egress_distancemm, NL80211_ATTR_PAD))
+		return -ENOBUFS;
+
+	if (request->range_report &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT))
+		return -ENOBUFS;
+
+	if (request->pd_require_range_results &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_REQ_ATTR_PD_REPORT_RESULT))
+		return -ENOBUFS;
+
 	nla_nest_end(msg, ftm);
 
 	return 0;
@@ -3857,6 +3920,57 @@ static int mac80211_hwsim_parse_ftm_result(struct nlattr *ftm,
 		result->civicloc_len = nla_len(tb[NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC]);
 	}
 
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT])
+		result->tx_ltf_repetition_count =
+			nla_get_u8(tb[NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT])
+		result->rx_ltf_repetition_count =
+			nla_get_u8(tb[NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS])
+		result->max_time_between_measurements =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS])
+		result->min_time_between_measurements =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS])
+		result->num_tx_spatial_streams =
+			nla_get_u8(tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS])
+		result->num_rx_spatial_streams =
+			nla_get_u8(tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME])
+		result->nominal_time =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW])
+		result->availability_window =
+			nla_get_u8(tb[NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_MEASUREMENTS_PER_AW])
+		result->measurements_per_aw =
+			nla_get_u8(tb[NL80211_PMSR_FTM_RESP_ATTR_MEASUREMENTS_PER_AW]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_BANDWIDTH]) {
+		result->band_width_valid = 1;
+		result->band_width =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_BANDWIDTH]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE]) {
+		result->preamble_valid = 1;
+		result->preamble =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR])
+		result->is_delayed_lmr = 1;
+
 	return 0;
 }
 
@@ -6312,6 +6426,33 @@ static int parse_ftm_capa(const struct nlattr *ftm_capa, struct cfg80211_pmsr_ca
 	out->ftm.request_civicloc = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_REQ_CIVICLOC];
 	out->ftm.trigger_based = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED];
 	out->ftm.non_trigger_based = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED];
+	out->ftm.support_edca_responder = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_EDCA_BASED_RESPONDER];
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS])
+		out->ftm.max_no_of_tx_antennas =
+			nla_get_u8(tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS])
+		out->ftm.max_no_of_rx_antennas =
+			nla_get_u8(tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA])
+		out->ftm.min_allowed_ranging_interval_edca =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB])
+		out->ftm.min_allowed_ranging_interval_ntb =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS])
+		out->ftm.pd_edca_bandwidths =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS])
+		out->ftm.pd_ntb_bandwidths =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS]);
+
+	out->ftm.support_range_report = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_RANGE_REPORT];
 
 	return 0;
 }
-- 
2.34.1


