Return-Path: <linux-wireless+bounces-29375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E85C8DB35
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 11:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433D33AEF77
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 10:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EA731815D;
	Thu, 27 Nov 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AasLDS1H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JRm/9P/Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735362FF672
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764238295; cv=none; b=lwykpSv4fiC9i1PRwC7zlzaIcP5qp1DTHpWL7PP19J/OA95SUCZ/oAAcEHW2sAvIRytqZk4bF50quEqp6pFtdklwn6vPqOux8Q5nR1iLuBEhNl7vLrGvr/5pRk0PGED7cu3CFJSmE426yNgKGp+14HntJB//kWuSe0cVmWKDi0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764238295; c=relaxed/simple;
	bh=mE2AnZRLkyeWJ1xge5PJeGneYSTujDCSqbwUIF4Ie4o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TPRRYi+StY5FLBBVSjQRRXrwdn1oVWtnaHZGJ7yPPGkdRdrTB1VZEBdF3x9jpUMh+9eaSBdwfAdd/iAh4fv02XOvuaWPdEKnq8vtRSQNsb/NXbFuPWhF+4JpPmF9Wdnkxoj093v8vNokbG4ig6OSCRW7Gt0ezQ9trxOnB2BqE1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AasLDS1H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JRm/9P/Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR991vM1668021
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 10:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U2vy5Myh+2ubnthby73P1i
	YNRZmink+vdUuWbXnEgvw=; b=AasLDS1HoK8bTxA+zyORGo4FfKXdjunBMcyTlM
	+KbIiuLP1GMo7pTh/0pswUas2JTUxdG1zLAOdCRRa70l8O6pX8KRqSKrxImqy7wS
	yoV5dZgCaYSf1M30W+pEadLS/i+RImauIXQNIhrUzwqnXspGBli/++Fz3N1HLHjJ
	elUeWrbBf2KGX4Kg60vVICRwVXQvQfRMszrm5hDUrdW3Zw/giU22GlhnlVZ9+jNa
	Ua+MNuc36ce9XA2HPOn6uEP9zKBRNk3idNCttcmxSx22lbtfWHwYe6rQEgoXlM0+
	SFnDqgZZc4NPKHtKywlM8oIiAjEXMytW1Ht9afqC60Ew4DHw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap0bmue1t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 10:11:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297e1cf9aedso13115385ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 02:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764238293; x=1764843093; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2vy5Myh+2ubnthby73P1iYNRZmink+vdUuWbXnEgvw=;
        b=JRm/9P/QYyWZ4N9bJZNJk7Btspzxvr2O/MwsBWZtmCxXToM7Jq5KRKThj983qK19x/
         iF5clwPewypzxZvrNa65OGwpSZY/fZV2u1nd9qLsTLgZnqcgwDljsIieQieZ/uqX6Wwu
         WfLvnKaR86rFwVGE02s3D8K3u9bomcctgpFOr2+6Znf3iRF8vu+gE1RIFgPCb0RtgOZb
         yO0BeA0TPy5w3pwvkX69PUZXuCh9/PK5uqfguMXjq7dfTdRR7xhpyitTPt8Rqb4Hu7lf
         ZGR5+p0oNUgEglIXFSuZbIgSDIiBQHNE1343vvwwkWck7xor8Mb8eHwsJcLcwVPsLJ3Q
         a1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764238293; x=1764843093;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2vy5Myh+2ubnthby73P1iYNRZmink+vdUuWbXnEgvw=;
        b=U3+DE/xEs5tqg+cypNRYZSY1op1X2/uk0+rcZs3m2Df8C1fleJzxPNT7h7LUcpkF1M
         iSe3vTcV8u49BFkh/PbJchF/eejXdvmdR8SoD5kt7ANmmbv9LbQ8/5JCe7InjKPwUfBZ
         S+uA8zWgL4l/hpfStZVw9YqafbdlfuF5L44zxudIqYjNVNk3ckEICoVMm8OE26JsaLeA
         sVm7340KdPl0GL5oEH4R1DwLk6Z6sGwIRTIMwJtPRYEN2TWOJg26ZSabTPBW/exWbQil
         M2iTkdwcvT2o9jwbdj+ytWYD/Iqf33KrOEDPVklYbCfOZne+mUWu3va3PpI3/Z77nsOH
         /d5w==
X-Gm-Message-State: AOJu0Yxhez//GjSGyoEs0WBVYsGqNCdIYlRP9iELtNhw8v2wNOAscAWs
	mikemFmvIzfi0bp0Ujf0EDLlxWxhluv88JvXp5MOANuoieErTXiLByX+61OJytl87oW5PbyGrXO
	OAq1lk0SjC3kOQ64zgH0LVx/kPos2qa+X4FCTKwYOBapq4unn1G044EjTAjBq4Gx15jwOOw==
X-Gm-Gg: ASbGncvdFbcxgczww4CeC9tuWCiAnHq6pXKFr8j6ZlRqMBA6kmEIXQ0jvBBaUw2PG5l
	rZIiwyg8hrc9Q7u4HRs0FcKEWYbHYFE1Ijpxs5l9vVM/tcJo5flP9yfC8tbwmKbntDqClrSFNU2
	EQBcrtzQDy42woHiyaZutFK8Ho0R+qGUsINjGQMqpNwcVLv7R9s0kNfXgqTPG9pjaBZWB1xyk+M
	dIlszdxWKePSilP4mcZdGfs6McEW+R9d6EzcbiG9GMG0KJskj0LKU992fo4Xct6TISwXVkN/zPV
	keC1+ZTtAylD0hk1guPO1rikt1K/JSUDFrIMsI6T+E48EU+Y6yqZRJ6O1TQ8x6zGM3h4Med6GzK
	G5B1rcBhUYA7CDc8oGsSLU3hjzd1U5DjA86/D0vgDmZqP1b85pea3FHHMXrbbVCeOqkWQIhZpOT
	3qiQIsm9fHsWKBg6GQiJgHD1z7SiSbDAqLDaX24H+FQw==
X-Received: by 2002:a17:903:b84:b0:29a:5fe:4f33 with SMTP id d9443c01a7336-29b6bec5065mr278337255ad.20.1764238293019;
        Thu, 27 Nov 2025 02:11:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb8ewgffmlsFj+5+TTJDj8n5a3S9ojm3Fao20vm/CNAoEuJFh0OJM1Zsk6Xd0trf2PpCyJIA==
X-Received: by 2002:a17:903:b84:b0:29a:5fe:4f33 with SMTP id d9443c01a7336-29b6bec5065mr278336955ad.20.1764238292554;
        Thu, 27 Nov 2025 02:11:32 -0800 (PST)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce44389bsm13586425ad.32.2025.11.27.02.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 02:11:32 -0800 (PST)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 0/2] wifi: cfg80211/mac80211: Add support
 to stop a link instead of whole interface
Date: Thu, 27 Nov 2025 15:41:22 +0530
Message-Id: <20251127-stop_link-v2-0-43745846c5fd@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMojKGkC/x3MUQqDMBBF0a3IfBswY6XFrYiUoi92aEgkI20gu
 PcGPw9cbiFFEiiNTaGEr6jEUMFtQ8v7FTYYWauJOx6s5bvRI+5PL+Fj7K2z/eoGB35Q7fcEJ/l
 6TfSTBA9VE5APms/zD0wLlKdqAAAA
X-Change-ID: 20251127-stop_link-14013df5fe28
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=AKyLkLWT c=1 sm=1 tr=0 ts=692823d5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=L1wzaVs1W0D95kxv:21 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WOzeXCvXS4iwisPlnIoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA3NCBTYWx0ZWRfXy5z2IypT13dt
 H0YFPtGlJpiHBVua83q366EBkoyZMQ0RhIKE+E14L4ZVluT6B93A8YHQ6aCKuAfg2f2F3y0LOLY
 D6YZTablpNP8m9jy2HqUzAd8YFC8QXFKbaiaHfjwsCTJm6DSvOFKJNbP/PP3GGRUICCgpRRRhhz
 ceN/GNZv+EiIAfTKuIUTOx9ORXoKTHC/ET7wJrUgDdX0XAqErETB4RtWjdXOEy6Ivj3LJLjzHAo
 laQpOGSHCqIxThN4duoy9o2wf8GiAvd1Qnoa3kA7VmRtwG2vkJaf+ykbsSbWtlRWB2FqTZDD8cF
 /zQgodKDYbkjFbUPstOLvgbmKbz2Sk+K8ScVW/7ZpQtX8fLiwhatndn62NQp5OPRz5OKBTpNzOt
 JNgiloVmcsP/1sXJFG/6//4IOIV3Hg==
X-Proofpoint-GUID: FdTrW5_p7XngIZj9-3zmISys588bvZ3v
X-Proofpoint-ORIG-GUID: FdTrW5_p7XngIZj9-3zmISys588bvZ3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270074

Currently whenever stop iface is called, the complete iface is getting
stopped. However, there could be a need for AP/P2P_GO type, where one
would like to stop a link alone instead of the whole interface.

This series introduces new API cfg80211_stop_link() to allow drivers to
tear down only a specified AP/P2P_GO link during MLO operation.

---
Changes in v2:
 - Added a new API cfg80211_stop_link() based on the feedback.
 - Updated the authorship accordingly.
 - Rebased to ToT.

---
Aditya Kumar Singh (1):
      wifi: mac80211: Update csa_finalize to use link_id

Manish Dharanenthiran (1):
      wifi: cfg80211: add cfg80211_stop_link() for per-link teardown

 include/net/cfg80211.h | 16 ++++++++++++++++
 net/mac80211/cfg.c     | 13 +++++++++++--
 net/wireless/core.c    | 30 +++++++++++++++++++++++-------
 net/wireless/core.h    |  4 +++-
 net/wireless/reg.c     |  2 +-
 net/wireless/sysfs.c   |  2 +-
 net/wireless/trace.h   | 13 ++++++++-----
 net/wireless/util.c    |  5 +++--
 8 files changed, 66 insertions(+), 19 deletions(-)
---
base-commit: f9e788c5fd3a23edecd808ebb354e2cb1aef87c3
change-id: 20251127-stop_link-14013df5fe28


