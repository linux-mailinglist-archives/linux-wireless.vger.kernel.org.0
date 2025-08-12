Return-Path: <linux-wireless+bounces-26305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9F1B225AC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 13:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CED188A7C9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 11:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2611FCF7C;
	Tue, 12 Aug 2025 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LB/w2QH0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A681AB6F1
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997441; cv=none; b=iExLSUy23g1seO5XntwB8UaM7M0zmDkSie8Rv1Gm0GqE7vSSF5nzvKqalbuuCgWZqNW7W4/3dfQjQ/2SSG2wNHhRLr3/5sX7W71eA1nJ0gLfChbrphJCnpPU2vMKg71m3nANhs7SfiX0X5LSBi5jzZ69R8POylWUz+BrPOxCCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997441; c=relaxed/simple;
	bh=8OzBlHSV9Btlaq9nX2jbU4O3wo49gziGzFHVuaockg4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XL29I/JuRPS+519c+BU+3Rjyx77iVcSSsQttiZxngtU7PTvz6tOTBVne/TxgSpWwfvSPCIfPIS8FeotFiIOprEyIblNCMUceOqfVz0tR1stOr196VaxmsKcqYpjMA5rF+LlzHgMThfOGZIdoRVTOlYW/sH2OXqNLfqRrQsVYOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LB/w2QH0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvaKF017558
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=qYwhKepfUiuQ
	Wx5VxD2n5yHLqvEMme+QkYCnGzbfhhY=; b=LB/w2QH0EfX3z+YCQzrBj+2Mlyni
	2xlrtsMbZ0+wI26ZfhH1N1T0aXOtb53WGjWmH7iypO2xZ+AqMr8G9CNHxzBtmaF+
	2dr7DmaXCo/gvvOwm5RwZbFRmdQlvkmKEoni+Zy1aw9UAHgvtFtDvDAR6t6aN1GP
	yUYs4OFi4yH+8A06Il5JIM3J6pgqT3XY73jVyR3k6PO3nTcik4YW+41+4N41Xvbg
	T4Y98xOnqPzLs3RtG4Ynv96dvT8IVVjwIod3ki4fCvd7mcg2ZabWNTTyCyMqw4Pt
	e3fYLPX7Y8DTutw8MPN+jJM34lz/4gYKzNZXQHcr/DpB1sIR8E9YblFFPg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4bw4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:17:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-242ffe6d0afso6329405ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 04:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997437; x=1755602237;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYwhKepfUiuQWx5VxD2n5yHLqvEMme+QkYCnGzbfhhY=;
        b=iePhuycu6wTtjUa6+vq05hj7pWdBhIQjiUWSdfapYLd9jrGdaAFBZUNV2CHoN/7njW
         s8aaA8kKKvFQTuyrWlIxV9LvF+5znbOjkjCNmVMMriuXg5GVRfCHmQTP1cA9GzkR92dn
         aKS/0jwGb7PivKsNKLKnvn5HFqhOjwPws0ixi0oZWLTmUvzEvb2JA9/2qpBZg4lMcXIQ
         IhsaaU9CAahvMRLd6Om2AtuyrVd1qa2GecysP8oDa1QLCvDLGEr8jIgZefCERNEzoom3
         z7R9S1BYdDOqih5qme0JphTEDQ6SSplQLWW4JJ7u/yhRHmBKbkyx9z4+vpkdpglvpWPj
         8jXQ==
X-Gm-Message-State: AOJu0Yyf6f8nvWlItnPwzG8cvCcWdWdNIbQ8KjSIFhHWQgRmBHfLw0jV
	9nd/BctTIF0Nhdn5cnLBUuv4tF9Nhn7JqIhYBQM9VaLkx8oesbE2YT9F6SMZhEu5b4HuDaKUdxz
	aF5sksykLFGeTWTWOrxHzqWDJYsCEeFgvEeDsgP1geD3Ood1k8XEtbGHEZgtVGmpR53d/0w==
X-Gm-Gg: ASbGncvzGT9UM4lZfRiwK8D7JrclfkKdq7DxvhRicARLFyZ9cnk1CcGCgaegGDifVW9
	8YMwA2sUEzeXljR9TWBR78C8dUcc6ggJixSxMLhwco/x0jg6JxBIJagybR4D6rjY2gZG9f2Qqc2
	+J4nXSVSa2ttMCHmPR1bAYg0MGk8pGqzUJHJ1MhfDkoFC4iP8JkNxD+ujwErhuUhFnlw6YnHvy9
	AGBQzwldwtOIx0yr3mn2axLpB2SM4Z3mj60ot/0bul9dRj+Uw6ElaY5RwoDZI6OtGy1EVeF5Rqy
	ejR7TNbyUKtyFKnqgC65pWgqfdGO8JRe3gOgASUnr0b4it2DTiZXWyh5zdAOUDMn4xdnPwg1V3H
	bAq2Nf0M=
X-Received: by 2002:a17:903:1b26:b0:240:99f7:6c10 with SMTP id d9443c01a7336-242c1ffb220mr275547895ad.1.1754997437126;
        Tue, 12 Aug 2025 04:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9YHYgdY2Hy4IBVsi1SF/S3HVYHnH3d3qLx3AKPjK8PHljTjJF/lpOTY8YdTxgLfZweDgoMw==
X-Received: by 2002:a17:903:1b26:b0:240:99f7:6c10 with SMTP id d9443c01a7336-242c1ffb220mr275547515ad.1.1754997436688;
        Tue, 12 Aug 2025 04:17:16 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1ebc1sm296048935ad.67.2025.08.12.04.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:17:16 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next 0/3] wifi: ath12k: Add support to handle inactivity STA kickout event
Date: Tue, 12 Aug 2025 16:47:05 +0530
Message-Id: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: XvKt7YTCr2EScE1pkEh4vqodtBZctNS3
X-Proofpoint-ORIG-GUID: XvKt7YTCr2EScE1pkEh4vqodtBZctNS3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX5U8IlbIye9HE
 gT+AFuxisWvUljTf6DLZms6+hC3Eb3v2Ab8JnsTXT5pck5MLszMdUzNzvF7Jqqs2bfcjwTJaePd
 wfUe89RQ6BxIGwNrTe3dEr0vvTwT+ruHEsd5jpGKnmsh8iQoyKoftpDwhlvyhB6NzL0xp0V2HGI
 gaEJmuHtCXYlxm1yNwc9Fd77LymWNaso9U7IOl7f5Z381H1Tde0MPPR3VS9z/iEktKrBkpSCkkf
 w8l0i3RwXtbn6P6nAS65Twuo3Hc546/v5Uvp5OzVRLz/qMLjJnLaLzgOsBvOPu/IY9NdqusiJxM
 MnFSolxGYJeO0X4Xf0Ng4vg5sEYZXctLyrVuahIx9d581mWZw0IecDfba0fZsB5Z6v63mmFlp9e
 X9j1MZmg
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689b22be cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=2OwXVqhp2XgA:10 a=aFusDkrkR4dZjGMLmIQA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

In this patch series, enhance the WMI_PEER_STA_KICKOUT event by adding
support for reporting the kickout reason and RSSI value.
All reason codes are handled by reporting low ACKs, and will be leveraged
in the future.

Add support to handle the peer non-AP STA kickout event for the reason
inactivity.

Currently, the ath12k_mac_handle_beacon_miss() does not handle MLO non-AP
STA. Hence, add support to handle the MLO non-AP support.

Arulanbu Balusamy (1):
  wifi: ath12k: Add support to handle reason inactivity STA kickout
    event for QCN9274/IPQ5332

Maharaja Kennadyrajan (2):
  wifi: ath12k: enhance the WMI_PEER_STA_KICKOUT event with reasons and
    RSSI reporting
  wifi: ath12k: Extend beacon miss handling for MLO non-AP STA

 drivers/net/wireless/ath/ath12k/mac.c | 24 +++--------
 drivers/net/wireless/ath/ath12k/mac.h |  3 +-
 drivers/net/wireless/ath/ath12k/wmi.c | 60 ++++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/wmi.h | 15 +++++++
 4 files changed, 66 insertions(+), 36 deletions(-)


base-commit: d9104cec3e8fe4b458b74709853231385779001f
-- 
2.17.1


