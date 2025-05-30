Return-Path: <linux-wireless+bounces-23504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135A4AC956A
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 20:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFECC1C21990
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1CE23C4EC;
	Fri, 30 May 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SlFMtC/d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD74194A65
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628179; cv=none; b=NbixRKE0MkzH2bV4hPXEV1CDA4Onhbfdo7lK+rZ7T0IYc1IbuP9brRMoRVs2DjyH+NXTo8f2BU1VGQQtyxb5yfXGOyvUy8PUyn6RmufySnm0x6+UvkkEqmimkXnQJrzQPqyQ0z5+EpmWPLbpV04sXV+XMCbeXZhwKSYvK8ZXpmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628179; c=relaxed/simple;
	bh=bK4SKV560tNO4xuQg/eUvYRjcrnuioApJ0JQHTa9W2k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CU/R7YXw9K+Alg1dFcblJfQ43VWxdk0MRCoiIaVVEY+7QBw1aB15sWP82NhCO0s01D9ttbxoFmsAWmPzz0vnnyf9cNxNHRSNjOcfnG6qM0X9EuMF+SfRXog3PE5OpkQB56E67GTex1f6mPQskZm/uIeqvlT1/F/hGYw0QKQ2ppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SlFMtC/d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UBdLEc031490
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 18:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=pMgpQ5I/JuIl
	38FrXwUCHv0ZOaXjPFo3NZHkRCWxWwo=; b=SlFMtC/ddsxad82sVsZYhTbMi1Mv
	IZb3EjrpvihYixx3eK6kKaC5gUdDUalayAqgSZf4xH4fAqLOhVslVEoCutf8qS76
	26mB0bbRvN05Lr+kTkQMpaxL4UD7HKqMuqZ4GUvCp8+kvFdou1FihG5AChGmgq2/
	ku66u3RCRk/EUbRdcBs1D5GaGbv39DjlGXB+0fEGdMdZkQPnKSKuxCJDRWtmPU3i
	IGzsuiAz2hGEavVp1zCnmaImp2+AAn7zL7eHfJkHb2tQ/vYYyVvGiZY6/+5F4vFs
	hHxJIaCCRvTr2Q8qwn5CK0PUodxV64DPPCArjqo3/KvGg+qYBklkbHGRgw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6vk23ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 18:02:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22e7e097ef7so22198435ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 11:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748628177; x=1749232977;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMgpQ5I/JuIl38FrXwUCHv0ZOaXjPFo3NZHkRCWxWwo=;
        b=pKiJ/mYTckzymWuPKjPTuWQbEdHNwqkz9b0GTao7shjvvNHcbP6pq6KVsVYTUBaYN1
         EwOK/kYfs6ojTSjrGYuqTlFHXhOfP3MSBVZslMY6NA+vtgqkP3uogG61mho7XyimepL3
         q1QfOU0xkSfr89Px+ykj46I+5nBhKDRV+eC3HtkyLNrt31JolJifq990jDqBuyXjHnUK
         hRr3yJJXkVQVkZaz87w2It7Q41oCjS+7WNCog7urDQv/+PpJRzVMkBcXg/ZYcegophjO
         OuRyKCtYEzf1h7g/xykeKwOi/xaoCQFlKtaxwdnNx19xExSCvJLWPPiA394Jf5ZARfEk
         +1Pw==
X-Gm-Message-State: AOJu0YwQYhP9fatfjoEQPy8K1GT9dBp6s0P2M25+k8+r7IEV7Bo1RLSM
	rpFnT2UOh9UwQvuPAqLV0YRpQD93jfkU2pfXDPI0+GtJfj+uC8PAU34Rm7Q0vOJvnqoW0wRGV4s
	5LCANKyZR93dbxmwpdNXWQwu7ad1YmnqmR4Y1LFdkDJ0uZzvhbOZWeIJ4odMLFdjTWOacVw==
X-Gm-Gg: ASbGncs8ERmpuPjWLlgABzotGIpl5c3fFmLyXG2IJg+N214vx+cCjwhqc4A9DX+Z/vj
	s5NhShf5U8xRx6ytje6tx7OR6YLmqBoWD4j1r1c1D6d/X0Je462NIbmNheOgaZaj0+DHax8H0pp
	o6pxeVE63RP8wPeBnxzWbhiJPdHJ9EaX+6C2RajCTfRnZ7VvAr0usJjohmq6UITOoNrzBEjDrCg
	dybuznteCxyHPBEu7nDGphe3Kr3AMaksXzjAf1P4yQ09djMaoDKZCjdT+70H9WGlOutCVCg/tJv
	g52oSIMqkWd2U8AD/gM6rhIdHJbDarQ9hbgPLRC6wAocdRkvpgvhGF7h/QnAWKVb21b3RwpRKLz
	UMJ0Tp/K4YKezOlJ3iDV4iKdwEu9hpdcVf0BzwX2fi97OpQ==
X-Received: by 2002:a17:902:ba85:b0:234:909b:3da9 with SMTP id d9443c01a7336-235395b1dcbmr31263975ad.27.1748628176637;
        Fri, 30 May 2025 11:02:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2CNxtpL3ryZAd8ovOBU8Wo+dW31fe5Jzn9KzO9hcp+EEC66gPHoxUl/hDKNDR2xLfs5HQtw==
X-Received: by 2002:a17:902:ba85:b0:234:909b:3da9 with SMTP id d9443c01a7336-235395b1dcbmr31263685ad.27.1748628176239;
        Fri, 30 May 2025 11:02:56 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc868asm31374435ad.31.2025.05.30.11.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 11:02:55 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next 0/3] wifi: ath12k: Add 802.11 encap/decap offload support 
Date: Fri, 30 May 2025 23:32:44 +0530
Message-Id: <20250530180247.424349-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=UOXdHDfy c=1 sm=1 tr=0 ts=6839f2d1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=OjkgN9cAhSkzZ7XfgKUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: YEaF9qZYGHAP4cLl_xfW5lemEeXoPbvx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE1OSBTYWx0ZWRfXyzIT477BHL95
 q6FUc3JKIc6L+TOBe/uf7wH2ekLaRLwTiyeMz1tqq8aRbSV+0PMdxQl6Dr0wgv7dptBAHTEkANl
 Naob4NZxbPxR9Mw6/Yz7QaUdU1aoRMy9FjWwr8+AbhpJG/gZHcsVBEebXox0Z7Zkfs8ujy8/6QK
 n8AinY8dN3D9kYfMt04XgDf9ZOB5SEU4tpP207qQwzz3wkSg9/4XhPZcyQO6BwZMDmob5PCaWPv
 aMluR3KydeUjV6+QzrmPhee/7vHMOqlOufW09oi5Z9KABQ0mfzpuq9dzfOEZJbYOTcG6QJBFqsJ
 jnzYr4KjePruyTdcB6WwgJkUqh2EPIxlLyfdo6mJmP6cnaAIgQ1YZy2a3ycyU3IL5WirjHfbuPX
 42f+/BsdT8iesrqQZtSHfBmDoQTPLqjiHY9Nz/FtQzI0ZSNjtFzmcKY8sWx6MdFemtfrXBCU
X-Proofpoint-GUID: YEaF9qZYGHAP4cLl_xfW5lemEeXoPbvx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_08,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=922 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505300159
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, the mac80211 layer handles construction and parsing
of 802.11 headers during packet transmission and reception.
Offloading encapsulation and decapsulation to hardware can
significantly enhance performance. This can be achieved by
having the driver advertise hardware support to mac80211 to
bypass 802.11 header processing

Nithyanantham Paramasivam (3):
  wifi: ath12k: Fix the handling of TX packets in Ethernet mode
  wifi: ath12k: Fix TX status reporting to mac80211 when offload is
    enabled
  wifi: ath12k: Advertise encapsulation/decapsulation offload support to
    mac80211

 drivers/net/wireless/ath/ath12k/dp_tx.c | 101 +++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/mac.c   |   3 +
 2 files changed, 93 insertions(+), 11 deletions(-)


base-commit: 3d933084a072fd5fb5da54c06a017abc0412c86f
-- 
2.17.1


