Return-Path: <linux-wireless+bounces-21108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA545A79515
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 20:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0027A5979
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 18:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD821C84D0;
	Wed,  2 Apr 2025 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="StLywDKK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CE1C84A5
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618571; cv=none; b=iiDWPvTIHjaiNzOPNKrYrgPgNvbs/inrjSpqLgTBpYa+gy68DWLABdjPN6KQZVy04U2QZV4ngGIYW6+F6nBISq3PM/GHNNQIqyLba1cPzp8qPcP623b8qmsabKgG+VTmKpQGQa983sGl2fch2nXJ4GtzLEsHvn0MVLHU5ukHdOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618571; c=relaxed/simple;
	bh=XBAJ2s/htPsXTJHXDtLSpF/XvYqy92qrb54T6j4jrnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WZBiFnMXxPO6LvOTR/cu6JiTJ19GeSFo38B65hZz3Pm3i90Za7bK//CTncnvG0EDZqMuSn46ZdZ5Sd7bBSuXGR87mDpkgeVwdtlH6fiPPSCJGUKryUUbcd6872aKL+aigK+b6seIWIWbSp3gmbnb+3vAZFfdCaCpY1Lvi1pUG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=StLywDKK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532AtSfk023292
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 18:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0zMaEUcmCblYUXxd78oWrLnsixQpLbuObDJ
	ggjybQLg=; b=StLywDKKjy54lwvSuUnzdJL/CErnrye1Wp90xeucyJEyPEiGQfR
	XSLRO58P3DcDkq7WuEfKSRE2oENhJutjMdnYmNhQ+RptRbllD5NysjrqZpoDT+j7
	XjZdSNvfjv/znyAgj+/J9CBk85Wji1NccfLu9vX1aAxgDhQ+0sOKpG3357h8W3r9
	2u9qLd1vTYaYqYaoFkdOKYvkx9fZSoepi0E5dEOkgeGbOr80BPHVlrxKqoRnWal6
	CXE6RBmaf/dPZMpLwtjVcxX1CEv6TCi24W8bBEv6g5RdZnuGQteewAzBVxB0oFh+
	na5EEbThcN+wbBoH9+07eer+pdxMhCsTJ0w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ruadtq6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 18:29:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-223fd6e9408so12722535ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 11:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743618568; x=1744223368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zMaEUcmCblYUXxd78oWrLnsixQpLbuObDJggjybQLg=;
        b=WKzZS7IDbqwYek8mXbh3QxmQAI682VqjUZelC1TPsPdWaYfHGWhc4ZM+tiiSkSraMY
         6BH4LtFlJeI/ZCiapfZQsSIfqJVYKnq8fE0YWYkaq32IKy9r2lIBeXt1cOrKHBJvJhfo
         WJ1hgcWXvqAqGgeYfKoyVcHSQIo/H6X+rBVcv64pGUxXl0+Mpg9cRSGG176FymVEYXnD
         T1Qk48zR0hAIoYzdq6XiuI5sASBokVn30aJqAVYON+hWoh61pcufxBU9VFwydeLhXDjx
         eRKTXUK06kKYqFBzoUt1N/YfXY29XGastGdAIv1kfMoHoyQP+ECjz+/17GmrjWrj3VAO
         uIsA==
X-Gm-Message-State: AOJu0YzY+1cTdmccORyKEIHqiYbkWKwHBQFhGvHEpwdo9F12XVwGWxFb
	Jg2DaUvGYAd1hYkdwXH170PxRlbg+ZSWnhS6YJ9M23SbRdC1KXjv/4uqRKrF8VxrJbihPIYLhZS
	K7AOeIX3EoULXStgBzfBG7z08CEyz4K+Yy1f8ZEN7mAGv4UpRCIWjz5Nk3ygRBnVY1FlOqyEX+A
	==
X-Gm-Gg: ASbGncsQAdDHFLWgqN3C6l98gvCORd22StPbqKy8WRt3+DGhvpr/Tvag97lbub6u98K
	m/r8lf/sdcCYzPjnk3xNE8KpAe1qNn1//yHIdbvCGv5bEYwDiB2l38uN6MVZnTtNGFnK9gE9Hq3
	+6hvIuprSFdUV9zjxJpzlO9SPyPATlTBxTJ+7jnsrmBsOemf8hfZB9PyWvfWoXHDIz9fhCT1oP0
	acOHIsBbvblxH//zxziTPK0rYL9uYdIAJ//CAYpaM0dVptk/5S33j36BInb3q0pfzcfg7c1JhKE
	QsJWalrh3VNlTak4ixnjnkNapEEF9hy+ioW7CRJeCy5RlxQn7+x70+v7jzU1NLFTZ5dSLAIYMxC
	nmXK7ngaJrk4YGRq+T4rUxIiO4mNKPZqTfA==
X-Received: by 2002:a17:903:1205:b0:220:fe36:650c with SMTP id d9443c01a7336-22976620f8dmr7927785ad.23.1743618567873;
        Wed, 02 Apr 2025 11:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMF1uXng/b3SMVahihOal/Rp2xq0GwlgD8jTUHpug2KPW26pazW4/py3y/JtwOdtuIQtQCkw==
X-Received: by 2002:a17:903:1205:b0:220:fe36:650c with SMTP id d9443c01a7336-22976620f8dmr7927565ad.23.1743618567477;
        Wed, 02 Apr 2025 11:29:27 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf860sm111978885ad.115.2025.04.02.11.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:29:27 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 0/2] wifi: ath12k: add rx_info and replace the usage of rx desc
Date: Wed,  2 Apr 2025 23:59:15 +0530
Message-Id: <20250402182917.2715596-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VI/dn8PX c=1 sm=1 tr=0 ts=67ed8209 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=V4QcQPTyrmqQ3YzeKasA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: iLamf7rBcpHyp8bB62ukSn2J27MmKGF8
X-Proofpoint-GUID: iLamf7rBcpHyp8bB62ukSn2J27MmKGF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_08,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=465 malwarescore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020117

This series adds rx_info to capture required field from rx descriptor and
corruption in rx path.

P Praneesh (2):
  wifi: ath12k: add rx_info to capture required field from rx descriptor
  wifi: ath12k: replace the usage of rx desc with rx_info

 drivers/net/wireless/ath/ath12k/dp_mon.c |   4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 171 +++++++++++++----------
 drivers/net/wireless/ath/ath12k/dp_rx.h  |  26 +++-
 3 files changed, 122 insertions(+), 79 deletions(-)


base-commit: ba613742db305037ca2193b2b552b769c4f2a5f7
-- 
2.34.1


