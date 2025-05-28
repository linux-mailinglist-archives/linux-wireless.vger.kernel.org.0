Return-Path: <linux-wireless+bounces-23469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D47AC684B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 13:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1184E7A567D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 11:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA4A280A5C;
	Wed, 28 May 2025 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jPW272rx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137676A33B
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748431467; cv=none; b=qWcp58d2iPRnqX7NYTSqkuuLT5YA9FIcANhO6OHs7GwfkUATNyiv+/qQMy4NYwQnea1GGOmjYkRKti7Dt3HxZYi94lhceT0kc9xkl4uj4OmZp4CbvGByXEy47fZyR7Nd+M6w8ujvKjznCyxQmu5q9VPRlAbZtsB5u1HfttP4zNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748431467; c=relaxed/simple;
	bh=s8YvYzFzgJVHFydhLtLGu0apY3FGCB+uze2f/rIqpz8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IzxF7BZFEWHirxbGy3lfPbgNNaOxWwf/Cqdcx8WLWs+mYkqEFoHirY/C/00glgV0wqudGAxS31kwMa2Y6YYGrXR1LJhetYoqaKl5CS1wbV7L+HQ0GnQu3eaoyfI8SEFHZ5EPf9uiZLhuYIk99EevR0dfYFFoa2zBbfr8lz1K1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jPW272rx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SAYVTL015681
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 11:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9OaIR/JgCGry6K2mLBsDcR
	Bp3ny/e1tbKsimDqc/P5Q=; b=jPW272rxOWAFGjUDZ6W+I6VCbZTymA/xhJ80Su
	5a8sk3mk4m3KHfbXGqpcalRRpW4pLhgqkK0qa3dCeJj98r1d7Ny57iblbpK4I9tw
	IYPylnUKNd4dEvF+Lcr9fdScRwJf1OiAGhkDdcIg+v/UFwUUzF1X8oC3H3zqqFhi
	Du1Xtq0WDEtWjPmzeSfVXDSCstO/k1EMo+MUtP0JYLybg0q33QPbM+pmqffQhzuP
	ehe4MKZr2o/qRfD0NbOUJDO5RzY/z5UnnEGtFpNRGidMJXR6sMqQ/bYiTs+m0/q+
	B2hdAxyo3XE+4UPARzA0p1A5WBUjTEhr6XYl11SHmVt6PAJQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6g921eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 11:24:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-310a0668968so4092323a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 04:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748431462; x=1749036262;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9OaIR/JgCGry6K2mLBsDcRBp3ny/e1tbKsimDqc/P5Q=;
        b=NixhCXXxQMyvbVtVsbYwN1x8/+MzWADaCkkhp7EaIT5Gv62aMhib9U6dVLI0ZJP36y
         bB/eXH1rMibszLm5GvIe1upbt44e4yiO7j76KnCzDqLitYC6aD4ZFSTUdD6V09LjAPLM
         RCYEviXUNlU47/pJ6XqAu6faZWnbnjQArmum9S3KNzTMePyprpVzPcpDRYbS486T4L3c
         J9W9xns20iVfh7ql0PPWPnzyOIs5MSFiEQM/AsbYLKqAml0r9jBwGwNnU8Rwzp+1w8m6
         DP3VKkqD3H9Y2LyAEtEW7uFZ7TH2RqYI8hEq9tZ5WPX6KzE45Hb+eOeNLfdAoSfoUOOc
         n0ag==
X-Gm-Message-State: AOJu0YwrPbkG/64uj4hMf8E3jj1tm2WmRyit+X3WzCWTN4cZr81keDtH
	WvqDIGGTzjaKIBkxzEYGvj+18R18WokhlYNexby7WIt1YDzR8ISy/LPkLfO8yO+ZKQiXyxC63Fq
	iTzwd0+IlD8NtUxWoHoWq0NzxYD86aHusJhvgMCc6ynUYbTvV3/xczqP5NjAUHrcPFIaL4Q==
X-Gm-Gg: ASbGncvgJBrv6LEXFIz4WvjiUqCjOQFNd83nEAwrkBo3VBUmrJdn2rn+YiJ0ES3bWnK
	H/XspAlURGL8IYuPfrsTiW82d9F+4N7TKWG+Uz40PBv4u39Ir0cPgRwnlhfDyOZi5FBwCEkRtEq
	3R2RquwLbid37dn+8BJom0MXB6u7Y5wA3gbk55Aj0gM4AnDltDhxWqeX4ZO2m6AUBCjVjGqdYhy
	rRO/kBTOjyBlBAIjTXmpcooHGyN6OMEDL3BN9XinNlE0r+WRYuFs/wybQvYk79NKlAWv6CjEP7y
	IT75oKEXYJSUATj+Pp5qD2Uo5SKaCVUBoYla0UwH/KpwJZvUK6rKcVCOmvIq6HGiPOavwdVOqlQ
	N4zW4gxwdzLGuEeFtIj+NhfQ+KirsYuyFnHLx
X-Received: by 2002:a17:90b:3911:b0:311:f30b:c18 with SMTP id 98e67ed59e1d1-311f30b0ff9mr1919588a91.4.1748431462468;
        Wed, 28 May 2025 04:24:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT2k6BW8Nw88MJooxw2RTEDAtCcWs25yiA/HlrYnpjr7dK3nH9uZma9yPDliobnauzqCuwkQ==
X-Received: by 2002:a17:90b:3911:b0:311:f30b:c18 with SMTP id 98e67ed59e1d1-311f30b0ff9mr1919559a91.4.1748431462029;
        Wed, 28 May 2025 04:24:22 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-311e9b668ffsm954665a91.20.2025.05.28.04.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 04:24:21 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: use real noise floor value
Date: Wed, 28 May 2025 16:53:59 +0530
Message-Id: <20250528-support_real_noise_floor-v1-0-04507bd3bc76@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE/yNmgC/x2NUQrDIBAFrxL2u4JRDE2vUopIsqkLwZXVlpTg3
 Wv7OTzmzQkFhbDAbThB8E2FOHUYLwMsMaQnKlo7g9HGaTdaVV45s1QvGHafmAr6bWcWZbSbr9N
 sp2W10PUsuNHxv75DqFElPCo8+hKpVJbPr9la+wLFfiAkgwAAAA==
X-Change-ID: 20250513-support_real_noise_floor-205986936cd3
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=6836f267 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=oo-PE9G31wNHbytkz5MA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 0wg_PAYifH9cM0uicqQpjIlcHZdB-6kY
X-Proofpoint-GUID: 0wg_PAYifH9cM0uicqQpjIlcHZdB-6kY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA5OSBTYWx0ZWRfX5bOS+KRcE9PT
 6WUMmElwab1+5MqBktcUsLqOlzkQN45TqDTMn2M+Nn/HzOEix1Rd/SsyZ3bvUQSxuQAieVSIdOB
 cVO7LbPB+rUDvr3Daz8ojZ7rXbUKMEX1GY3/BpKLJfqovGz0KzLGFFqoze5bCSs1Tpaov9pn7i6
 dIZFm4GruP/TwkGdS6Vgm8IpgSmfoF4CQJMVASwPfy6/ZnV2l5UHCMfQmrct51x5pewuxxGNfbQ
 sySJ/DXyR8RBexjTApxMrFjZ/XjTlGDhwRbdiKG8gZBCuF5fUMYMRq3oWmZAPXKs5XcQXSWfuN5
 YU7W3l0wiy1S4oNgVgvoVfbWkLCKo77bcv0aFw0jLB1o+7XibiGzGuiKapj/tPrIogOU+Ji9NDS
 X9SiRRKaOjYqNJHizYMwm405KWC6IsaK2QSAPhLua6j7Q+j3xZ8a4rwStnym7KcAu3yz+LPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280099

At present, the ATH12K_DEFAULT_NOISE_FLOOR (-95) is used to calculate RSSI
value, providing an estimated noise floor value. Consequently, the RSSI
value is also approximate. This works but however, using actual noise floor
value will enable the reporting of the true RSSI value.

The firmware possesses the necessary data to determine the actual noise
floor. This data is provided to the host via the WMI event
WMI_PDEV_RSSI_DBM_CONVERSION_PARAMS_INFO_EVENTID, which includes the
runtime parameters needed for calculating the real noise floor in dBm. This
event is triggered by the firmware during channel changes, temperature
offset adjustments, and hardware chainmask modifications.

Add support to handle and parse this WMI event. Use the received values to
calculate and store the noise floor value and use at the required places.

---
Raj Kumar Bhagat (2):
      wifi: ath12k: handle WMI event for real noise floor calculation
      wifi: ath12k: use real noise floor instead of default value

 drivers/net/wireless/ath/ath12k/core.h   |  17 +++
 drivers/net/wireless/ath/ath12k/dp_mon.c |   7 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c  |  20 ++-
 drivers/net/wireless/ath/ath12k/mac.c    |  14 +-
 drivers/net/wireless/ath/ath12k/wmi.c    | 233 ++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h    |  42 ++++++
 6 files changed, 324 insertions(+), 9 deletions(-)
---
base-commit: 3d933084a072fd5fb5da54c06a017abc0412c86f
change-id: 20250513-support_real_noise_floor-205986936cd3


