Return-Path: <linux-wireless+bounces-33610-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIbjG3uMvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33610-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:05:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5402DF254
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91B41309BEC0
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C0D313E31;
	Fri, 20 Mar 2026 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Udy3FPSa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="haYTFVPH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDA3DE443
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029668; cv=none; b=EkKBpzhlAok/LxhvT6DKsEbxD5vOPsucRu0cKBtGKVQ4/vFVsKl4sjYQelXNbWuhHWjJAs6c37bWs5QKW3F5I/TL8P6qKLctUfp9XrFIkeRcoE4DRKmb0bv793uUgUuhVRJicQveLjrYs8mw01wnzhPCUv3j01mIiF5fyXj3uzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029668; c=relaxed/simple;
	bh=uFMfruKuyCB6KMqftq56YY+eYgegATwFVjpEH+Z80ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MjbPGV/pl1MGr/rNSQbCoS8d6xfEBOQfXoY04Ig0PRwccHxyHIPAuWzSFCknf2H92k+8cMcAJAfV7/Y6Q3kj+jXrwMiHFs2aiBFfXiI9SlPR230T8CsFv4UWCBy9T5G6ForRpZMWHOtTiGFNXGRcX+znJoyG9VE1Cmh3Ks0bVRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Udy3FPSa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=haYTFVPH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K94Vhs700901
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MrhsUe5vb0T
	C3OCrky85yz/+FiVsYqG4tyMdv5KQkB4=; b=Udy3FPSalPLuSkAnT8yXFjAiYBj
	m/zDDWfwBlq7awo/EzVn71RLkpOtChdTbc/yaG2UesqA9FsRB8UvQNl9uj9UWovG
	B9t6udJaUd/Ru+q2H2F/DAzsWffUOCTShrEyFQV33IyjnvhN6Wq3Y87Q9htiK9qv
	DbVknxSIXdc50KsjYAl+sFm6kLsTNP1aATojZkqFv1AhBQiJ88dEVudOSQY6hfTs
	7axy4lFoHZ1UFFdlqiUe0dIcBnFu/kjKJ+Vp5cLE0IPd92AA528HCiZkyWWQNdyn
	d6b/nOecBMzvBDAcnwszV+b7eW981ux6ExjGT0+LOfKcAtjfUnWwHF4wmgw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d139q190s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:01:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0601ff3d9so28706485ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029663; x=1774634463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrhsUe5vb0TC3OCrky85yz/+FiVsYqG4tyMdv5KQkB4=;
        b=haYTFVPHG+WMFqYi7TYgNeWy5t/kQRqLOTE/1zciN/7he+nwCeDNVXhqKMSuThBBkk
         J0BET+N1dgEskjO3PCJTmI1XsBAh/bU6QVE2i5+T6GJmNqHwixFddKAMubN353WU4BRu
         TwQTJSnrWelnx8ysRhvkhbAIsyBapx3rvFS9oKmPvMiGHtnJ6CpWOMtPKhg67fpWVK/U
         w5PYanJke5HdPXMLlS27ABc85Aw5ox31zBSOabEmINL09WPRHfcVsR7ZPZiZKxCV6buw
         vwCrrS+LAbLlwVxPXlVR2HzrO10DzTIegwMqJV4z6f5CUhJYyCjlk7DVwT2HLDSsOnqM
         yn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029663; x=1774634463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MrhsUe5vb0TC3OCrky85yz/+FiVsYqG4tyMdv5KQkB4=;
        b=CRSCUevaPKt8ykywVx3vhn519dIzwBZu4jztAWpibthTBLmS2dSPw/3EEg/GoNvml7
         cd3JcyJvzzvWOPj/C+rCv3Uuxgu8uH7RneWgYy9gZ+H7DxuX+rbMcmlD9BNDIgM3UWsn
         7RAW0ErgUHEQaOSPgOG5x8hecYSMa4fr4/AJVGr+A1Ydw0vA1ItbDmqd1fS9k5MXrewl
         OC3V3vj8vGZZmTxLUIb3D9oKtDkto7MsA7fMikahOASKVjiNDLL+/yneqqHRwPJJwwAZ
         t1wROWtWcwjrlMOa0k9fnJHeqV91MewlASSzQ/DAd8GY1tVkca/jIxrp7gi2HU3ani7O
         iKMA==
X-Gm-Message-State: AOJu0YxmzesMWzJZco2yVEwcr11fCUAbTYGDiy+nz+0RscgfPtryyYmx
	GQkcWoChbPsYAeH+w9zBVIv7o6Xdfj9A8oT/G+5h6f8HxshKAvMHrs5GgqBrhYauEPWCjHcoFrW
	+9rLQIo0Jvo9Nn9b0nfYfDGEwiSUiZ9eThnlfOhtdo7HhP6Rl91SXBn4L6I+FxDkLpoUU
X-Gm-Gg: ATEYQzwBUbhz2j3C5H5ohhnECEYbaySKR6z5tJdioEDIPcSoJ7l4XPnhMCjD++VoRWj
	SzbMGCni+59M+7LKmRBQf03W0sOQb+mH5CjYwpw5nz64loEG14x7OcNdkJmQ2AabGX9YjKkwNn7
	2m/4G1O3ZyCDgYJyWtaVup8cq6B6JBBYOYQ3Taxe2s+/lCPfhvsy5uv5lXXrBqJ50yG0O7b4MYF
	BjwM8hNTWUwl+xPgae1qFgrhkm5GTNZHaFxift0d1kSs8rt9QWpAbA7ZLsNy0HNHzIJiRCNhWqf
	vic+WaDIeqtYp+ze1qyRuAw4WeouJNSJr3xA2cA9IdAY7KzZweCfFZeouq2L/oqEFhUVbUiqm5C
	jlYWIMkAk+G9s0U7/J+AZ93ahYiCnPiGy2jDgzuig0czf0BhEieAZjoA=
X-Received: by 2002:a17:903:1111:b0:2b0:67fa:dbf8 with SMTP id d9443c01a7336-2b0827b51a2mr35474565ad.41.1774029663188;
        Fri, 20 Mar 2026 11:01:03 -0700 (PDT)
X-Received: by 2002:a17:903:1111:b0:2b0:67fa:dbf8 with SMTP id d9443c01a7336-2b0827b51a2mr35474165ad.41.1774029662424;
        Fri, 20 Mar 2026 11:01:02 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:01:01 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 14/14] wifi: mac80211_hwsim: Add support for extended FTM ranging
Date: Fri, 20 Mar 2026 23:29:38 +0530
Message-Id: <20260320175938.2547288-15-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
References: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NiBTYWx0ZWRfX/avPxUYk/uk1
 tzp3LmGN68gr2ML+pIcAkyPifC3r10bNW3R5nlE10YkfpuuzUb2TDzTT9ITOinA2h9YG6H+zRD0
 3uhVK6xqlCYFY6SldXOgZMik6aGQMKNmM2BteltcVve0TsdRdT9KuIk3VcZumr+TuGueMXui9mx
 r1jb1cooG1xP7tUJU4ZSx6qalvQlAIemkof+zIy+5+RMZF0gf+qML8/FnJzzaXx0DxSTgIgJ7RB
 F+Dqmdo0ZZwE5YJk8a8v1PiebTIuzeu2a7GbsXR4pO8Tf8Pzu7GkX6RF6D2dn1TQitqEcbZEmRA
 IzaVB87bppkVxfzPKtHr6nW19bOrIt82lxq++J38CI5KYOYSHSgDKEZjNDYNE9e6ZSdeYXHGmZJ
 q9sLYyljmaeViHYKa2XziowNBx7sN/8rbWiaeV16yDotxprjDv2ttSo6cWZ8q0mExWJ1wqvq5Q0
 a4o8FjIa0VRELF9IE5g==
X-Authority-Analysis: v=2.4 cv=FOAWBuos c=1 sm=1 tr=0 ts=69bd8b60 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=hzWLNRaLpFu95Fj1PoIA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: wx9o_4YtH_sW-YRKe6vlVJ9Z4TdIov2R
X-Proofpoint-ORIG-GUID: wx9o_4YtH_sW-YRKe6vlVJ9Z4TdIov2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200146
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33610-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EA5402DF254
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>

Introduce support for continuous ranging and advanced timing parameters
in the FTM (Fine Timing Measurement) request, response, and capability
paths. This enables more flexible ranging scenarios with improved
control over measurement timing and session management.

Co-developed-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 200 ++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 82adcc848189..6f0788c3f4cf 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -848,6 +848,18 @@ hwsim_ftm_result_policy[NL80211_PMSR_FTM_RESP_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_RESP_ATTR_DIST_SPREAD] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_RESP_ATTR_LCI] = { .type = NLA_STRING },
 	[NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC] = { .type = NLA_STRING },
+	[NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_MEASUREMENTS_PER_AW] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_CHANNEL_WIDTH] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -881,6 +893,13 @@ hwsim_pmsr_peers_result_policy[NL80211_PMSR_ATTR_MAX + 1] = {
 	[NL80211_PMSR_ATTR_PEERS] = NLA_POLICY_NESTED_ARRAY(hwsim_pmsr_peer_result_policy),
 };
 
+static const struct nla_policy
+hwsim_ftm_role_capa_policy[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1] = {
+	[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA] = { .type = NLA_FLAG },
+};
+
 static const struct nla_policy
 hwsim_ftm_capa_policy[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_CAPA_ATTR_ASAP] = { .type = NLA_FLAG },
@@ -893,6 +912,18 @@ hwsim_ftm_capa_policy[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_FTMS_PER_BURST] = NLA_POLICY_MAX(NLA_U8, 31),
 	[NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS] = NLA_POLICY_NESTED(hwsim_ftm_role_capa_policy),
+	[NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS] = NLA_POLICY_NESTED(hwsim_ftm_role_capa_policy),
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_SUPPORT] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -907,6 +938,8 @@ hwsim_pmsr_capa_policy[NL80211_PMSR_ATTR_MAX + 1] = {
 	[NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR] = { .type = NLA_FLAG },
 	[NL80211_PMSR_ATTR_TYPE_CAPA] = NLA_POLICY_NESTED(hwsim_pmsr_capa_type_policy),
 	[NL80211_PMSR_ATTR_PEERS] = { .type = NLA_REJECT }, // only for request.
+	[NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE] = { .type = NLA_U32 },
+	[NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE] = { .type = NLA_U32 },
 };
 
 static const struct nla_policy hwsim_genl_policy[HWSIM_ATTR_MAX + 1] = {
@@ -3624,6 +3657,50 @@ static int mac80211_hwsim_send_pmsr_ftm_request_peer(struct sk_buff *msg,
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
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION,
+			request->availability_window))
+		return -ENOBUFS;
+
+	if (request->nominal_time &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME,
+			request->nominal_time))
+		return -ENOBUFS;
+
+	if (request->measurements_per_aw &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW,
+			request->measurements_per_aw))
+		return -ENOBUFS;
+
+	if (request->num_measurements &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS,
+			request->num_measurements))
+		return -ENOBUFS;
+
+	if (request->ingress_distancemm &&
+	    nla_put_u64_64bit(msg, NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
+			      request->ingress_distancemm, NL80211_PMSR_FTM_REQ_ATTR_PAD))
+		return -ENOBUFS;
+
+	if (request->egress_distancemm &&
+	    nla_put_u64_64bit(msg, NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
+			      request->egress_distancemm, NL80211_PMSR_FTM_REQ_ATTR_PAD))
+		return -ENOBUFS;
+
+	if (request->pd_suppress_range_results &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS))
+		return -ENOBUFS;
+
 	nla_nest_end(msg, ftm);
 
 	return 0;
@@ -3993,6 +4070,57 @@ static int mac80211_hwsim_parse_ftm_result(struct nlattr *ftm,
 		result->civicloc_len = nla_len(tb[NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC]);
 	}
 
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT])
+		result->tx_ltf_repetition_count =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT])
+		result->rx_ltf_repetition_count =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT]);
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
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS])
+		result->num_rx_spatial_streams =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME])
+		result->nominal_time =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW])
+		result->availability_window =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_MEASUREMENTS_PER_AW])
+		result->measurements_per_aw =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_MEASUREMENTS_PER_AW]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_CHANNEL_WIDTH]) {
+		result->chan_width_valid = 1;
+		result->chan_width =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_CHANNEL_WIDTH]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE]) {
+		result->preamble_valid = 1;
+		result->preamble =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE]);
+	}
+
+	result->is_delayed_lmr =
+		nla_get_flag(tb[NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR]);
+
 	return 0;
 }
 
@@ -6498,6 +6626,72 @@ static int parse_ftm_capa(const struct nlattr *ftm_capa, struct cfg80211_pmsr_ca
 	out->ftm.trigger_based = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED];
 	out->ftm.non_trigger_based = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED];
 
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS])
+		out->ftm.max_no_of_tx_antennas =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS])
+		out->ftm.max_no_of_rx_antennas =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA])
+		out->ftm.min_allowed_ranging_interval_edca =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB])
+		out->ftm.min_allowed_ranging_interval_ntb =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES])
+		out->ftm.pd_edca_preambles =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES])
+		out->ftm.pd_ntb_preambles =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS])
+		out->ftm.pd_edca_bandwidths =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS])
+		out->ftm.pd_ntb_bandwidths =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS]);
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS]) {
+		struct nlattr *ista_tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1];
+
+		if (!nla_parse_nested(ista_tb, NL80211_PMSR_FTM_CAPA_ATTR_MAX,
+				      tb[NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS],
+				      hwsim_ftm_role_capa_policy, NULL)) {
+			out->ftm.ista.support_ntb =
+				!!ista_tb[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB];
+			out->ftm.ista.support_tb =
+				!!ista_tb[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB];
+			out->ftm.ista.support_edca =
+				!!ista_tb[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA];
+		}
+	}
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS]) {
+		struct nlattr *rsta_tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1];
+
+		if (!nla_parse_nested(rsta_tb, NL80211_PMSR_FTM_CAPA_ATTR_MAX,
+				      tb[NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS],
+				      hwsim_ftm_role_capa_policy, NULL)) {
+			out->ftm.rsta.support_ntb =
+				!!rsta_tb[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB];
+			out->ftm.rsta.support_tb =
+				!!rsta_tb[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB];
+			out->ftm.rsta.support_edca =
+				!!rsta_tb[NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA];
+		}
+	}
+
+	out->ftm.pd_support = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_SUPPORT];
+	out->ftm.pd_concurrent_ista_rsta_support =
+		!!tb[NL80211_PMSR_FTM_CAPA_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT];
+
 	return 0;
 }
 
@@ -6519,6 +6713,12 @@ static int parse_pmsr_capa(const struct nlattr *pmsr_capa, struct cfg80211_pmsr_
 		out->max_peers = nla_get_u32(tb[NL80211_PMSR_ATTR_MAX_PEERS]);
 	out->report_ap_tsf = !!tb[NL80211_PMSR_ATTR_REPORT_AP_TSF];
 	out->randomize_mac_addr = !!tb[NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR];
+	if (tb[NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE])
+		out->pd_max_peer_ista_role =
+			nla_get_u32(tb[NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE]);
+	if (tb[NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE])
+		out->pd_max_peer_rsta_role =
+			nla_get_u32(tb[NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE]);
 
 	if (!tb[NL80211_PMSR_ATTR_TYPE_CAPA]) {
 		NL_SET_ERR_MSG_ATTR(info->extack, tb[NL80211_PMSR_ATTR_TYPE_CAPA],
-- 
2.34.1


