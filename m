Return-Path: <linux-wireless+bounces-32198-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNUZLhjYn2lAeQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32198-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 06:20:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 187361A1057
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 06:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CBCC30474C8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 05:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004DA28507B;
	Thu, 26 Feb 2026 05:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HwF4lrRd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N/6VaCAn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA5B38945A
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 05:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772083221; cv=none; b=bBy/UC45pmwMq+yYWX4/P11jXwT5dM00UHJ8SCz85p+uFIP7yqZGs5eh42PAHkC8S/qmk1xFvHwIz3qHZ+L0Or8DKqZFssxoj8hqEOwqJAILwcCuWPlZqe6ohD0R8WhB1ukjExFK5n/zhQxRJlM4N79wnA2eSzmemz1lXRE4kSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772083221; c=relaxed/simple;
	bh=m0s82xhcJjLMqogapqSLolBlOztvtc1EXB5JnRhdpRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u+BVPGZMS8Zq6i/dBcB3Cf9wjEMF8Mh0LsZrQJoFvgfBFbZLXZMk4GMxHJAy8jD4xO4WyrdwtlXkS1N4bSfVYbXRHa6PMPkPWGxhZi7tZx0u4HZXhn9sWPOL+20qu8U3E5JXeMcjvqwwIXDbmqpRfUpiei9uLDiJ0Xsjp8/KmnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HwF4lrRd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N/6VaCAn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4UtHa3433650
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 05:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=svKc2yKqI93zPwfKetPppN6A0rp07ldcdPT
	id8RXixg=; b=HwF4lrRdWKgAJglFLHA3bYij9aEGkM+EyqIkpQQp9iVnZIj4Y08
	GAdWHaY1YWbPJ1lksMc1E4pQWcwxyAKoxcg8n8PKkqEZ+/9NabpTgBgJVE4WV3vo
	xiLop2YCqXO8dDK1z8vGlpvVULSmzngVaYN2srC8brj3bmK6DCgpdgFsJ/NEe0gL
	ds1vaB+8sfzg3o79mlEtbSVXc0YHxELwYVavJ+VK/A6rtI8nxVmfcfEsYbocDzdT
	7ZyDivMx2tbypkQfuV75KG9CTRQ4cUYaOwo6U9qAOlsQD5xPu3WXJOAgSv7y4W5W
	AwucQYtHUIMWb3tBUhGLMaPVD/TqIRHK7ZA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjc0g8mbb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 05:20:19 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c70b75aea3aso250809a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 21:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772083219; x=1772688019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svKc2yKqI93zPwfKetPppN6A0rp07ldcdPTid8RXixg=;
        b=N/6VaCAnP128kUCbb9/T0LVSRCf1W6xYOzvBKs4cqV5bHOhBLMlEWlvZXqC6q41aXB
         sTg6RwGsqERFd87FsY9SyigKsSWIv+OC2YnswYIqaVag0lC8OyzDx6M1Z6ktKwFfPeMr
         rMV5vI3KpEhB1knt7Yl8bRDuDT5Lfa0an/2P1V+R1pMcXk2GrTnt7E1dKiR9+EO+iEwm
         sj2h0eRcNdXAkIYWl/VFMBi0f0Rtv+kQVzzfPnx5wtoiM0d787E0fn0hWwGGeG+WikNP
         oxf2k18JNiBkxgvt7wRPtiNuawWmBAXlRp7ij+v/HPzw8QwTsXAZqW21+YVB4s1Q2OQe
         u+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772083219; x=1772688019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svKc2yKqI93zPwfKetPppN6A0rp07ldcdPTid8RXixg=;
        b=T4KzKK6gLrxOp+tpHMn+8OUtH+3q0b7zPGa2fda6WwqO84WgSx3WeQTeTbTTalZDvu
         +XFPx8cxfLUxvjkoouaWoiSvVKnBCq0b9/dToKdCFT4e1B3WYhTg+LXiVr/yYIvkwf/4
         R3M0arZWgw0HWmsFE/B0QG6gfNgthWxWvfu3a3KsX5NSA3gu874uoL5iFlgu7kuMBySL
         Z/ONq+sK0D7SFRCBFEwo+QAeY9WpjOlAj576MUhjHmtKE5wrfEaxq9UrJVXKMOFcKdi0
         3E3ZHlw5TfhunomlrRbVyfQ4+0IGdifiE/t3B9DJQrN+zyQFoZ/h0qKZ/yFVIJoteeDl
         kZXg==
X-Gm-Message-State: AOJu0YyXCG9xL0Lvm71r8y5KI45m5iBvI31bO72PySwOQLUr59DDTMqE
	dRfpV81nrPfGhCNiuqTohilerpfhAMCO5mlO2fs9jWyu/D77i8N59fHD16aH7ZeZykJG+YIT0hA
	vfzEViaSQ6X1KGhO8VsrKvYKf9RW9lMSMmHeOJ8c8HNYf2/FG7m95tiPkixQCE/nkAZEHg1EFu+
	BYDA==
X-Gm-Gg: ATEYQzwLdnXNB/Afql4ahVyPZH0QteIb3oDycETyqZcl0kMqxjWhEE/fkRa1XeQ3Fpk
	0/1yf2eNkdcT/Qhi6l1zkiPlFDZdwPsgwgiC7bM1RKh7cUp+Q/paCRerh/Q5JCoeeNdvJtW+mDX
	Tov2Ru4Ce1n78z5uSUTAQCvgokkVQ6073oTYzBbSZodz57FMl+UCH5JznsAI3SQ4TrBKv6QWHBK
	eHjzo88lhyNo5MMP1bLKqWzV+48yZ2TFMVwfDZ7eDIxx3d5D4dsZfT+CRksTA2vX7VqDmxHyToA
	H90ZL7CO8PrQnCEITNdyWlY9eUJ2TwuZ3wDoab4oj1AbjFICnEjNkJFsSrwocKZroVwgCIjgwc2
	Cgn+hPXSUNPSGMiTDBjbnEwQE2LElTLNiM0rvX8TL6IVsiT/IKPa9BarlT8X/dg5mk/OTHhEl/1
	/9w2z16TLE7oPwJLhJ++eaqCejDTNyW/W2wd54qEzRSaA=
X-Received: by 2002:a05:6a00:cd0:b0:800:8fdf:1a54 with SMTP id d2e1a72fcca58-8273c0097b7mr1099815b3a.34.1772083218951;
        Wed, 25 Feb 2026 21:20:18 -0800 (PST)
X-Received: by 2002:a05:6a00:cd0:b0:800:8fdf:1a54 with SMTP id d2e1a72fcca58-8273c0097b7mr1099789b3a.34.1772083218443;
        Wed, 25 Feb 2026 21:20:18 -0800 (PST)
Received: from hu-sarishar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a059e89sm1028044b3a.60.2026.02.25.21.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 21:20:18 -0800 (PST)
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: account TX stats only when ACK/BA status is present
Date: Thu, 26 Feb 2026 10:49:47 +0530
Message-Id: <20260226051947.1379716-1-sarika.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XI49iAhE c=1 sm=1 tr=0 ts=699fd813 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=CSDw-C9IAAAA:8 a=mqiZWBmUbcNKZznDjgcA:9 a=bFCP_H2QrGi7Okbo017w:22
 a=wzwtrm5WU4lM03trS8pa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA0NSBTYWx0ZWRfX/yHAqZdFn5uy
 e78IHfTycgoLky9ejzuf53j6McRm7Umhdm+sXG+7904ifbbpyxboBKvzbGKhLVJVst5YDWJiHZT
 VzBpjFI2MeYqWMgm0YaJodH8cSARoLdLNWYyjg1UcsNi4EYKYaHiXBMpwLsFw+pNH08U2xjmNAv
 laL/Of2i4guOxYOke09fXWmMsGhJWayyGdnS973CNqFVV/I1QVJUE5E/nz6zJFPHqP9Cnnk0xe5
 4Gf9ancCkRGCAINS8yxRTADTIuchgAyGqEkN7wlW7M/IDl3V8y3hODNtjeqN1lwr9ACuHy1y6Mo
 fOkPUQkkRBpT9mu8tq3aqoRRROiaz9Tks4hifYkiIp+WF4RalaA1+uVx9ZFnUSRwI16anIsCIjg
 8V9jW2dF1vTef4zXfpzIJt54Etl6UYh2xCgl17a+OPRG3dullJhCygzRutCRTWyvpjonDRKsNJ2
 iXWsWl3eaylUdI9WASg==
X-Proofpoint-ORIG-GUID: 1qxjXD5xVjpCZslkau-PLYRfIucAQ3c4
X-Proofpoint-GUID: 1qxjXD5xVjpCZslkau-PLYRfIucAQ3c4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260045
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32198-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sarika.sharma@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 187361A1057
X-Rspamd-Action: no action

The fields tx_retry_failed, tx_retry_count, and tx_duration are
currently updated outside the HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS
flag check. In certain scenarios, firmware delivers multiple PPDU
statistics for the same PPDU, first without BA/ACK information, and
later with BA/ACK status once it becomes available. As the same PPDU
is processed again, these counters are updated a second time,
resulting in duplicate TX statistics.

To address this, move the accounting of tx_retry_failed and
tx_retry_count under the ACK/BA status flag check, and similarly gate
tx_duration on the same path. This ensures that each PPDU contributes
to these counters exactly once, avoids double counting, and provides
consistent reporting in userspace tools such as station dump.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Fixes: a0b963e1da5b ("wifi: ath12k: fetch tx_retry and tx_failed from htt_ppdu_stats_user_cmpltn_common_tlv")
Signed-off-by: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_htt.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
index cc71c5c5de5a..61c1c3b2350e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.c
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -205,16 +205,9 @@ ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
 	if (!(usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_RATE)))
 		return;
 
-	if (usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON)) {
+	if (usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON))
 		is_ampdu =
 			HTT_USR_CMPLTN_IS_AMPDU(usr_stats->cmpltn_cmn.flags);
-		tx_retry_failed =
-			__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_tried) -
-			__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_success);
-		tx_retry_count =
-			HTT_USR_CMPLTN_LONG_RETRY(usr_stats->cmpltn_cmn.flags) +
-			HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
-	}
 
 	if (usr_stats->tlv_flags &
 	    BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS)) {
@@ -223,10 +216,19 @@ ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
 					  HTT_PPDU_STATS_ACK_BA_INFO_NUM_MSDU_M);
 		tid = le32_get_bits(usr_stats->ack_ba.info,
 				    HTT_PPDU_STATS_ACK_BA_INFO_TID_NUM);
-	}
 
-	if (common->fes_duration_us)
-		tx_duration = le32_to_cpu(common->fes_duration_us);
+		if (usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON)) {
+			tx_retry_failed =
+				__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_tried) -
+				__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_success);
+			tx_retry_count =
+				HTT_USR_CMPLTN_LONG_RETRY(usr_stats->cmpltn_cmn.flags) +
+				HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
+		}
+
+		if (common->fes_duration_us)
+			tx_duration = le32_to_cpu(common->fes_duration_us);
+	}
 
 	user_rate = &usr_stats->rate;
 	flags = HTT_USR_RATE_PREAMBLE(user_rate->rate_flags);

base-commit: 62f9b9b19939138c34ce0ac1e5d4969d617ecbb6
-- 
2.34.1


