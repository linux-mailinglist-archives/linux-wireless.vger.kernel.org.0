Return-Path: <linux-wireless+bounces-31108-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH48I7wfc2ngsQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31108-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 08:14:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13574717FB
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 08:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B09E2301E9BE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 07:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D01036B072;
	Fri, 23 Jan 2026 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SfV1o5d4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AYLaN5A+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB8A36680B
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152406; cv=none; b=YYkZDf7FLNIoW/jBE1voeyLigZwpfsGCOKY1Fe2Tp89JZZeKY8bmAgGE0/NGfVqsLy6wnmhUl1Pf3FKXA69eqVgybPehMsqnROSMU0rEL5X6kM5ITQqj3elOG9j3YwEGyHl4HJPwKD1ZRNq1pJbK8XMKppMoPR/42KFroQ9Zm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152406; c=relaxed/simple;
	bh=jWqC+jt4BrBZ8F1FUYeOhj8QeaWa+Umiyo8tgK/qcJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eiBVM87oGnXiW2kJGj/KaRO57hyoNdEi8Pm8yGKqOYmiwk9nA+gpVaVlwW6oqsVQu3cg5m6q0rCWeLny7tkmXtkIuiyTil6aE56k7HsdkTFdrmkhcfGh+uTbYVz1kk9xdiTpEFS1O9ebSQ4Zy/ieh2CxjL4BYOBU226bzRierjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SfV1o5d4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AYLaN5A+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N69ldQ2910302
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bdFTB34kDEL
	JOG7CYs3yfL3PagXXN+YLTcDqFHFn19k=; b=SfV1o5d4+QawkuiugNh8mrpR4Qy
	iq2oohBT7GmGHACWPVCo/ncOlYN10lg2kLGbWfh89m8trNvlh57XrLlLz+dy/SYq
	du5oCDF+L2k4mALaCC5nWLzfjv5QmNsH3EQnkHp7/zSIGDbd+MGFbXIM81eaLDOc
	BNHARSkd7zYWqbqa1o3/3t2Wl243jTX98j1sRUF87D2Re4jQiHubcBAvf3F7LZAD
	Ih/bcwi0S+XNpoW8C7GDP6wiKYTRDWZPuQF7Yy67c1MgYwpM6wuud4mN3CuOINTF
	iKNfYyO7dq5AfCGACIEXkwSYR+dbaqxvusFMbZVvl3cF4PWjAFf+M3s6Ltg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buvs1sj5a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:13:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34cc8bf226cso2040288a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 23:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769152390; x=1769757190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdFTB34kDELJOG7CYs3yfL3PagXXN+YLTcDqFHFn19k=;
        b=AYLaN5A+URdZ77Qbe6HNZqQHvgdKPjQcYntLxTYol3j8l89Kv13MCb8EbEScIX0H3l
         +H5DyW0QQ61qfCFNjQtxV3hSne0ory7Sv8Q5bBDHY/f3vCRA8lZtf0P+ZFE9iOsN1Y5/
         xwo98lqOQD5LUR2IASqVynUax+T7DpscMHnGnkwiJNHaHaQtXw9095oK7oqQxwKivpVI
         vzDQu/SZpV2IV2ZdQwT6AIFPquqSQxiv8OUlOvV4ZieVXPw+q/ltWBAmb9HLnRO0QRPE
         FX7Byav6IBO9oVBzVAutx3z52cb3ONn9bIJbXVWzjIQfiSCxHu1LsFDAxt+3ETSaLotQ
         JSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769152390; x=1769757190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bdFTB34kDELJOG7CYs3yfL3PagXXN+YLTcDqFHFn19k=;
        b=TFfVxkrZVOYZnyP0q6yJfbPMYZtcQOyAUJErj7PwG03ospo3Sp7L1MjUoaXbjTviam
         5GpDjPfhcgn2F1jJ82NVVaR5p2ItDmiWicSLwcfmSa3TI3d9Q/yCziBbBhYB+G1QNckp
         KgHAZgtb2ZqiTRnOghy5w8dKC0XddiekUy2a+a9zZmsWcv4e9uvddkzwO54Jjw6hJUHS
         u0WfPXpAAlMAdK1EVdQviBWuLWLPGj29SE3CYpi+CBXNO1vfI4/Mo6VsPeSB6gd0sQbP
         uVIcCCoaLnIJuDC6aReqJaSJpBo3n65efXo/qjMIYb/X+bVDEzt/0R2MnHeMvRzUQ4EB
         WPGg==
X-Gm-Message-State: AOJu0Yy3wJD9X/DLiszvLcLSrKuuMnPqGFCm0ZwHvHqmaGrSL8HWCYli
	HXnlxi+J0hnHWv7wUgjNgrNgguilsHOxcG9olX+QDUp7ydwJTH3ij05NMNLywkMF4EID+E9SCzr
	EkZMlm+a1pL+gArWjEWKyyO04Hou47R54FrTDSu9GyWQxYws5ZqU6gXUba9dR/QvvcQ4hIw==
X-Gm-Gg: AZuq6aJLRZoQLGKFP1E+YWGaQafoSEmzvTbfhB94YyZ/RGpZwgGHYV3A19WQp7ZdhXT
	iS3QmuEjMfU0+h9wuxnAZG+kK7+5JqSmXMYhudm8sSjMOnq/l3hBwe6BQNLrfXdIvG+CF+qnmUI
	amnMnbRCjxqpyVRjlsdZntuN2Dhgpy3LtcUpEH2QhMRXk2q4JRn/WUQ4HtyfouAG0cd31GbV6Bi
	cvO9ZkJFATnuBqxeox3YkBYU+bRXafM+0DcG0LseL2H+qgBfew0RFYLHyMHwkFNCm/BevtWxbVm
	fZ2pYxfUeP5rCoOzQAt7vjapDm8H4z3wTX7IwyuUVZp98W89i0dbGJ7bQd9YNiuSrzLh/h/G5ZV
	qbnk/gwyx1b73ZBfSHMU3zhXvvf1KOtDyVJgld+qZnknrNcLWRr8mdEvAB+Xel3TRXSp0Kj+GFx
	jDxzV1Zu2w5QZrSaxHoY1Lm/hPChzpcQ32
X-Received: by 2002:a17:903:2acc:b0:29e:5623:7fc3 with SMTP id d9443c01a7336-2a7fe457d45mr17339905ad.12.1769152389896;
        Thu, 22 Jan 2026 23:13:09 -0800 (PST)
X-Received: by 2002:a17:903:2acc:b0:29e:5623:7fc3 with SMTP id d9443c01a7336-2a7fe457d45mr17339735ad.12.1769152389371;
        Thu, 22 Jan 2026 23:13:09 -0800 (PST)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa654sm11319165ad.11.2026.01.22.23.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:13:09 -0800 (PST)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 1/3] wifi: ath12k: Fix index decrement when array_len is zero
Date: Fri, 23 Jan 2026 12:42:51 +0530
Message-Id: <20260123071253.2202644-2-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123071253.2202644-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260123071253.2202644-1-aaradhana.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GyV72-6CcV1YO-aE3G_mmc_aez_oz7zB
X-Proofpoint-ORIG-GUID: GyV72-6CcV1YO-aE3G_mmc_aez_oz7zB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1NCBTYWx0ZWRfX5KAiGAbz+DQ6
 CtKsQk2NXa5uxYposDUCUC4en0tV6vdppGcyIkMkvxbi4i+B8mwvgodZThFFKGuPoPoHHevXNo0
 N9Go0T+d1TqGa1Yrat31fhfsalJBAEbQdBQ8ZFdHY4gbWQ4+eZHHPPEeIYXbsRDgV22fXmqbWZ/
 j4k451D4i55FVoq2PcXFXVsnyZGtgfmV1OYARvaaFHn5GuNOGca3hefGj3MaIfiF30YzNlDH4dg
 bP2D1fbaqnGFPRTFS2MMsxjEzxHPpkO7sFG77y+z0J3fi2lobhBkN+ooE+t0qpoh4SLz3QfjZZW
 JbIzW7B1Y7jbo4nufxBiQ8vC9WxM8kWv7UgJMW8OocRhtTN3ZAZReiPnoUTpJyeHOCEkzCcmIxx
 g7aSWDwKEhPV/r/yuXpwO42y4P+E3f986KWsvtf8BK4ehlpJw55R1W5RyWQHLI3fwuZ4qt+oEHO
 k2Jg9R/T1tz33+tC7Mg==
X-Authority-Analysis: v=2.4 cv=faSgCkQF c=1 sm=1 tr=0 ts=69731f86 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=pJ2hT3CBv0cagPr_DSUA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31108-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 13574717FB
X-Rspamd-Action: no action

Currently, print_array_to_buf_index() decrements index unconditionally.
This may lead to invalid buffer access when array_len is zero.

Fix this by decrementing index only when array_len is non-zero.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: adf6df963c03 ("wifi: ath12k: Add support to parse requested stats_type")
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 48b010a1b756..4f749d473d0e 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/vmalloc.h>
@@ -29,8 +29,10 @@ print_array_to_buf_index(u8 *buf, u32 offset, const char *header, u32 stats_inde
 				   " %u:%u,", stats_index++, le32_to_cpu(array[i]));
 	}
 	/* To overwrite the last trailing comma */
-	index--;
-	*(buf + offset + index) = '\0';
+	if (array_len > 0) {
+		index--;
+		*(buf + offset + index) = '\0';
+	}
 
 	if (footer) {
 		index += scnprintf(buf + offset + index,
-- 
2.34.1


