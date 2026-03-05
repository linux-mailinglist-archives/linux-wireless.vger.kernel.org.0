Return-Path: <linux-wireless+bounces-32564-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PK+AOeqqWlSBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32564-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:10:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B7A2152A8
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B9BC316CD33
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77F23CE483;
	Thu,  5 Mar 2026 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="junuNvhH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TWazU5sZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89063CF672
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726904; cv=none; b=JkY1Sa4mOIjK6MhP4u2udLZcwzExnz4ieTqiWSPh2kZvomKlCOnUmlUz16mEsXGlbYfIPUV+E+fpbFFPEiPOM79PBrbMggHXJcIMXWrBwN4vA+u+v7Mkmpwv4jspZOn2qcxN/TXTmjhgAuWry/nxozTw76AD/vXWyaHlDzBc1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726904; c=relaxed/simple;
	bh=tEEFynMNM8uMd/y+qGaRBr0gXnbUTyixUid6JIW4CsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOhNR7W8ms3qr5oGFTPbKqRw0X9fAUX++SwzTWhVeo5AjdNS+3wrNbldMw+bE0nvLyN+wuTK1E7xz3Z826+wukCccDIZLr4iVy2ObnrRyST15OL+N2KDVF8HUk/p+NgO7LENWiKBcZXOnPHVsopWY21RRfOPHm7Hvt1wzIm6g8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=junuNvhH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TWazU5sZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFqkm861729
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2ln0KU+MMWV
	I0pRq0PJ6j07FSdr5tIi9XUUP5LHrSdU=; b=junuNvhHdRPUDkX04WGJFgs9jGg
	kBYiTYk2xDsziJFdfY7G8u5PzxY46M3MDDyjjgZe1Z6kBwjVKWIC9fBXfs9CiBWK
	kF/8kG3N+zlgv3aY+5fac3tnfpWDj+bAiM5GV9hB5KiN6efOFlD7DGm6kcSf+8yq
	/arlHyGJpV9nJVY5/IAIo6V2HXxarOpkdOnzXYOeXfzXFAn/F5G2xPv4GQ3P+gM1
	HXzenRLFhZ+yd4GP5QTDka3DwrpQUBznui16wrcvuFyKcYTiNFNY8DNSDXw0dcyW
	wXwxG1PlLQW0X+okbBRciJaJZaxXdXWFjl1yR1jAiTwCzbiK/cfkxeRKf2Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0wbybr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:08:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae4b96c259so51559175ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726900; x=1773331700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ln0KU+MMWVI0pRq0PJ6j07FSdr5tIi9XUUP5LHrSdU=;
        b=TWazU5sZIdZf8oZOzjNY9R7+Yq9OCCdvltQ3srjuiGaM9fzghay8Ntos3F6b4HB1lo
         DaOxf6/TTlfQjzVJmZg5RvxLZeyPrPfsyJ6OCRJfGxSD9HM/wnMRCYEtTo2t2ymmU4aS
         SvWQL7VgvGKHLK7Rc9izTl/2CPmvdB3FByJnlc0ipOdptvo+zkl9FVxxgdwxebuC8NAc
         vcYztk5OXvL87aMmE1NshN3xlFRNp5/aM9H2u8+UR0r/WPSGNUn6ljY41sOb2ggx5IAp
         LZrd53UP74UGSc0kZCBUCloNcMXBbknUGVjR8GBVIjMm3bxqwiUnKACdFnKPTtqP8Brd
         O2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726900; x=1773331700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ln0KU+MMWVI0pRq0PJ6j07FSdr5tIi9XUUP5LHrSdU=;
        b=Uf+NU2Pze4cd+xgA2ZhkLB94OG+/zQqjInSv4qHvxeIPmp64cvqZ17AKTkqpdHmnft
         yBqV5SkSyPDpNZ1hExl7de1K1eZiiccs0IYNIf893n7GnsAuGFXFRj162xr1H6zDPb1Z
         J/PzrOIQLLPvttKizcFG1LCQr0Z3ZK5jvWv7NtGQyVgo/RM58KoqltY0XqPub/7w2bDm
         p5DqVm/m6tOpwtOGHVzFESiz2e6/3RHoU7Yq5qsx4fHxB1CYQQMBuk4gwtlbHRYkSLEg
         AsaE8Xbdc+5QsNKJ9jZpatBC5HNHWDVzQkYNKrgj17AS129/2uWYH+vlpWvnlV0nHUnU
         gz0Q==
X-Gm-Message-State: AOJu0YzZus+5517L/2xL+8RvgMLJA/hedWLqcoahKu/k2X7Ly3HJ9SY6
	U9W2h3V1QaZJES45o1lCmLbWJds3pULXghk11npD8NI9CqAp+n4DQet2rh7vJtM53cYIF8RJI8s
	7RD+jG1D0VONsOtOBaNpz+k2CJvm7Ae4fztFGTn0xOrmXZWa0n09zRcphpM3IbwjvDq6FXGhu7z
	mb
X-Gm-Gg: ATEYQzzNwblaKmIp+TsPPQS68uQq/+KV/yf8wjLF3v1Upw9ROBSFYt6L2DQtt7TodNV
	IN5yuiBy/q9d/DNW6ldg9ry9LKT0ljl0PWff6r2Pp36KO4YtGULO5GluC7w4vXx0NCbCnPzmW0Z
	CPm8ALt2k74XkTHW5TS3rtWV87pTDr8087g11MTJU8FA+CuHikNDQpjYr4c8DJA4rTCk09O+A9T
	Hg9LStgLlBhdnkHKUqarSLMMp7ECa2ht0c4oBqFVyIOHMG3u5JJXfKXK93OZEYlHzZFt4WVKV4I
	BSHVF5GiG5XdKsjVHNQdhWPmfJVOhLWWW9U26eC+wzZENc+Recxz5BoSeYtuhTroaTAWU82sx54
	mvEiaNpK2WPxvjvp8QeCKn2ql8qafbtyjsGL7JaKX59SAmTJ81IUFjX0=
X-Received: by 2002:a17:902:f548:b0:2ad:a96c:e40c with SMTP id d9443c01a7336-2ae75bb4d0bmr27642175ad.16.1772726899580;
        Thu, 05 Mar 2026 08:08:19 -0800 (PST)
X-Received: by 2002:a17:902:f548:b0:2ad:a96c:e40c with SMTP id d9443c01a7336-2ae75bb4d0bmr27641815ad.16.1772726898857;
        Thu, 05 Mar 2026 08:08:18 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:08:18 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 15/15] wifi: mac80211_hwsim: Add support for extended FTM ranging
Date: Thu,  5 Mar 2026 21:37:12 +0530
Message-Id: <20260305160712.1263829-16-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: U3Y6VqYiJTDPRV7TcR8-E1rtvYQCeuRA
X-Authority-Analysis: v=2.4 cv=BNK+bVQG c=1 sm=1 tr=0 ts=69a9aa74 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=13r4Q-eI3Re6bTJqT04A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEzMCBTYWx0ZWRfX4tjGUSS5k1oR
 A7jW+4pnIBSHkzAObE0hUSTUw+0UqS98QOgBcDkizqMCufFnLaceWfR14MIPoOkfNC99QFjC57E
 z5QyIC0x1HmiURs/O8/rUdT+l2D/P2A5QlfV9K/1WXuOCXJZ9vMU6OwxqL9mjq8mRJX/5N5XbLf
 awtBJRRf+E9rsbNuRTdYxjShAhCUa69b27l1/wA1TgK+PgE7MDQesmRSFkDQlhTYIAddtkrDx5e
 NyvFO/zz50gKzNdp5o/nknGtvI7Sg6l9h5mDaGnFXs9shKj8aoLYMmC7+8+kKg65qBKuLIoDEob
 ljsXdVVNcH92zjgI/qYaTslXrO6xFbCFExIEa4Zu6otsdcOx+Q/JFfK3136xfhteAkDDFYcwvAF
 PxaiI0+urWMCRdm6saoFzQX4o7KWcjkEptpursvfSlJxfds8jCH+zX7e5lVaRyNRbe39jLjsBjG
 H4ezjL+jecp2eQ3OlFw==
X-Proofpoint-ORIG-GUID: U3Y6VqYiJTDPRV7TcR8-E1rtvYQCeuRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050130
X-Rspamd-Queue-Id: 56B7A2152A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32564-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>

Introduce support for continuous ranging and advanced timing parameters
in the FTM (Fine Timing Measurement) request, response, and capability
paths. This enables more flexible ranging scenarios with improved
control over measurement timing and session management.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 32897d88bda3..31366ce1a1b7 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -846,6 +846,18 @@ hwsim_ftm_result_policy[NL80211_PMSR_FTM_RESP_ATTR_MAX + 1] = {
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
@@ -891,6 +903,16 @@ hwsim_ftm_capa_policy[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_FTMS_PER_BURST] = NLA_POLICY_MAX(NLA_U8, 31),
 	[NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_CAPA_ATTR_EDCA_BASED_RESPONDER] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_CAPA_ATTR_RANGE_REPORT] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -905,6 +927,12 @@ hwsim_pmsr_capa_policy[NL80211_PMSR_ATTR_MAX + 1] = {
 	[NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR] = { .type = NLA_FLAG },
 	[NL80211_PMSR_ATTR_TYPE_CAPA] = NLA_POLICY_NESTED(hwsim_pmsr_capa_type_policy),
 	[NL80211_PMSR_ATTR_PEERS] = { .type = NLA_REJECT }, // only for request.
+	[NL80211_PMSR_ATTR_PD_SUPPORT] = { .type = NLA_FLAG },
+	[NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT] = {
+		.type = NLA_FLAG
+	},
+	[NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE] = { .type = NLA_U32 },
+	[NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE] = { .type = NLA_U32 },
 };
 
 static const struct nla_policy hwsim_genl_policy[HWSIM_ATTR_MAX + 1] = {
@@ -3563,6 +3591,49 @@ static int mac80211_hwsim_send_pmsr_ftm_request_peer(struct sk_buff *msg,
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
+	if (request->range_report &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT))
+		return -ENOBUFS;
+
+	if (request->pd_suppress_range_results &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS))
+		return -ENOBUFS;
+
 	nla_nest_end(msg, ftm);
 
 	return 0;
@@ -3932,6 +4003,57 @@ static int mac80211_hwsim_parse_ftm_result(struct nlattr *ftm,
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
 
@@ -6433,6 +6555,41 @@ static int parse_ftm_capa(const struct nlattr *ftm_capa, struct cfg80211_pmsr_ca
 	out->ftm.request_civicloc = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_REQ_CIVICLOC];
 	out->ftm.trigger_based = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED];
 	out->ftm.non_trigger_based = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED];
+	out->ftm.support_edca_responder = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_EDCA_BASED_RESPONDER];
+
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
+	out->ftm.support_range_report = !!tb[NL80211_PMSR_FTM_CAPA_ATTR_RANGE_REPORT];
 
 	return 0;
 }
@@ -6455,6 +6612,15 @@ static int parse_pmsr_capa(const struct nlattr *pmsr_capa, struct cfg80211_pmsr_
 		out->max_peers = nla_get_u32(tb[NL80211_PMSR_ATTR_MAX_PEERS]);
 	out->report_ap_tsf = !!tb[NL80211_PMSR_ATTR_REPORT_AP_TSF];
 	out->randomize_mac_addr = !!tb[NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR];
+	out->pd_support = !!tb[NL80211_PMSR_ATTR_PD_SUPPORT];
+	out->pd_concurrent_ista_rsta_support =
+		!!tb[NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT];
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


