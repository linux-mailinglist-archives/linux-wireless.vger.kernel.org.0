Return-Path: <linux-wireless+bounces-21684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7C2A92D6A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F0197B4611
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 22:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9424921C184;
	Thu, 17 Apr 2025 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HivXcKTG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D2120E306
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930660; cv=none; b=DTl59l5BLj98JiirKU+JHcs+9l0t2De9q5r0jiwyYu486LEZykofqQUdFSyZHEIlIWPDYiDuAHOLLDZ9hNx6ICOmGYTEMQZkclRC6fr2ywYyH/MLe9CYrjk3SNg17AmDiBqgCwHmmw2LHb789YXVj83b70/r/yGa58/zvlo0qNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930660; c=relaxed/simple;
	bh=ZaTW/lLyOvrRLGy3sMdL3k9bIHdQcZzLn8tN6MuCB7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FbdZe9fX6KLNPY9oKmTH84bxmB5nLiF7auC4B8Cy5iUU6XpmQFXQZwqRB3d+XKEgLtaIdfdyyoElz6pwN8/EUiNLtDZePuAXPgXwq49iHHVPMhpp9TsLrsNhACb3UBifPRT22u2d0B2EA3X4/KvasOIBkKyBDvNVEuYuh0pZyKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HivXcKTG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClOS3014269
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qz+jktuaNe9C8iWX5656J/Frv6q0DtBvT/HgdKu5fbA=; b=HivXcKTGs1ExeGPw
	uDBJv6OP1Fk8dIcinzKT8/XawVCeVqogE09SQoxnEJAhMBg2g96zW1tJ+b2+gbM6
	TtPP6+MNMG0I1+VY0qWjzM28gc2S4i/jYT6gJNYzKDlkLAP4SzG43IEy6myW2iUS
	4pi9mwoKRsfsuSutlO4Ha962bEVAsG+e0NTWfjwhrGrcDddeFTy5H7wnnW2jgh8M
	OQYy0hXbBPKNFqtIeLu4OuLMRtsMv6kA/igVwWWtfXeRqMzFh+9h7z1+JmBUF9yz
	ljWkwgIkvctwnGtDaGz3Bj4AuUKrV0w1PTJ0GjEBBc7O2z6ShhtV8BAZJC37Y4R5
	JWZjUg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfs1g9ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:37 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-73c205898aaso901559b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 15:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744930656; x=1745535456;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qz+jktuaNe9C8iWX5656J/Frv6q0DtBvT/HgdKu5fbA=;
        b=lMl64trONyuv1ZeCRGPsiJuq8UiK73L8MbkFwXmixcvFa1EZ1byl4I4RApmbF2HaF0
         LFYJ1JiqoFZgitN1lHztCZHf5W5rTY32si+5eZQco4TQf0UJ9qzNSInJC6e/zOPHIQGU
         qsET7mh2gLBwiPtJRDP/BAkojqNYds6HeNIn+gRUjoQifr10QDMHoWSjRMeQsI7OYywO
         2cvECAZ7+g2hnAOXT3M8Akw3sn6zt3Ua8xqfUUimaPVJ1kLFRDx1e4qfFbgbFADtpBCm
         /NC77XhHdCgPVOmqJ//pT1FMdkfFtuLSivfxf5WFZ7hOod0uF1ORgWmMurYWjf7KG3oU
         EhGA==
X-Gm-Message-State: AOJu0YzjiQlYGBEdBXbzC25p6tdYGPzbDepNuN6a9BUrgRIJLD/T9kEq
	hj7QoF2DijBli/zRM7ZbkvrFYTKxXTRNJzxPRaApnLmKrUPrLe1qyvYNzbXtcBYM+uOkP11LGu1
	0Q6MhrIAg7MWDOA/KVxlO8MtatBn7RqKI4RLV15vjTKAv1HLFTbzuLHhSql0YrsTEvYESuwlNPQ
	==
X-Gm-Gg: ASbGncudmlMaUeMB8jlBRp3hlqERY9408fg2M5itb8AKoHYXMh5FQPq7mKQIGqx4FzV
	pE1gVuc2rjZCjIaUsiIsQHVjfIMndEaa65m7MkVc/Agxq0lEqPKY02oyB3NqosGAc8v2xRzf86+
	8xyQ3eShKCNSkCpVLWAO1e/5JNF34jEK7sSGGZurGaxsvSODOirW/LXebXPrN8rP4x2BKaU4mJ+
	WaXtnJo+c+JpXa9QSvCIr1Xqf/tVEYgn4QhSXUPrs2UzSQ6c/GsbXC0ultHoPXgg1h0JTzJ6F6e
	/dKoJ/ZsxkFN1pDi8Qbt7FDiczgv4vqLazSdEQbIU///98ZC
X-Received: by 2002:a05:6a00:14d2:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-73dc14ad1a8mr841606b3a.8.1744930656096;
        Thu, 17 Apr 2025 15:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV0mSf5Bn3WSEcs9dnuFc35G7YUOqjB5EWQYGDI9UVaxSfdUrIbHn5m34UnpiPhNvNjAnZYw==
X-Received: by 2002:a05:6a00:14d2:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-73dc14ad1a8mr841579b3a.8.1744930655608;
        Thu, 17 Apr 2025 15:57:35 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901187sm426468b3a.76.2025.04.17.15.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:57:35 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250408045327.1632222-1-quic_sarishar@quicinc.com>
References: <20250408045327.1632222-1-quic_sarishar@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix invalid access to memory
Message-Id: <174493065499.1347382.8547356391304429074.b4-ty@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 15:57:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=68018761 cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=0XJ0nkoN6fRkH-oyq9IA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: YlA5b_KntzytWjGDrTdjygVoxlnyhlIW
X-Proofpoint-ORIG-GUID: YlA5b_KntzytWjGDrTdjygVoxlnyhlIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170169


On Tue, 08 Apr 2025 10:23:27 +0530, Sarika Sharma wrote:
> In ath12k_dp_rx_msdu_coalesce(), rxcb is fetched from skb and boolean
> is_continuation is part of rxcb.
> Currently, after freeing the skb, the rxcb->is_continuation accessed
> again which is wrong since the memory is already freed.
> This might lead use-after-free error.
> 
> Hence, fix by locally defining bool is_continuation from rxcb,
> so that after freeing skb, is_continuation can be used.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix invalid access to memory
      commit: 9f17747fbda6fca934854463873c4abf8061491d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


