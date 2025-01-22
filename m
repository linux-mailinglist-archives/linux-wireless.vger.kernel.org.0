Return-Path: <linux-wireless+bounces-17841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FFFA19887
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 19:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D218168529
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 18:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0459E2153FB;
	Wed, 22 Jan 2025 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zsy3acQ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AB2153D6
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737570982; cv=none; b=IDfp5/DSiGAfzNcbO4l6fP4LFA1qF4LqErgtSp76R41v+z7G9A8uPFXcHzaiXNJQ3s7zCAtiARYxV8IqTVKIewKglAjj6nApIgUZFdBLG2DnPP0E6i7/OeHfvzILT2FK+Lju3LVCwT1UL2GzFxaB9k/b/CjqXQ8LTdA8N/3Xzy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737570982; c=relaxed/simple;
	bh=iKzMd8kawA59evMWSNmBE7h6kYJPCurUeXId2yAM+0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NoDSqgLmAdjyPga/SIq2sa/EKQ/EVV1rLJX26+zGJ9Oh+j8lEwZ02gVHUydmcqK3AuqKNC8iWQ9cKYug5duluCafX7J0cOzIo4cwtl7K3YJ0EN+8h341IJRgru6Eu3IQ7dpl8yynf+lSMNLQLO4zZKHmGKWwWK1WZw/UI/wiGso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zsy3acQ9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MGrWiw003117
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 18:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ifh75hX2lDUmB9dFOnBj3FdN+GD/9aeLONvHygEbjfs=; b=Zsy3acQ9mHIOW3ON
	EHUEXr8Q7Ue9DQ+K6OVIqu4j2Dq1tgpg40ki84QqJRA8HKpfU5DKdE06u+DqOWDf
	0xOELGhoMsT4xgO1y0RiBBgeoN1aP4dQndD2lXuGc6DOAeQ/uCWtjPwgn2TCBP90
	1ORxlCrE4es/iNZLuia9dginCOCzVclyYYJcGCp8P7vaHoc+MeOH9Vtk/Rjqkv5J
	k4vyGi2R/ls8V9bZ7p1m8ZChAvYOgfwaTmdfWe9el5EY2eS5Qo9OYGNTg7wsoiiz
	YBmYbWLhOIZrCDz6Oo7sZpiUHsOTM8OXxkgXKnZMSnm2EQ7jie271JaYFZ3u6YG9
	rjWXRQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44b4kk08cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 18:36:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2161d185f04so100615825ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 10:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737570972; x=1738175772;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ifh75hX2lDUmB9dFOnBj3FdN+GD/9aeLONvHygEbjfs=;
        b=u4aWe0FFNAROH39NRMI2jIOpQGG6vKFUrYBQfeHacnL3QSEtsMk92i404a/ABUbN2W
         Wz9wX3qFL5a/F8NqWXIx4DQzGcsPtDYqwI4DUK2Xh5p+U7CPFbuxkIBaeM938cNl+l0U
         Y5b7qs4TpALmdG8mO8MuAlfYi8UbSuxO35ZPJh54azryIPMd4rypqUcfQuoQN4T06GnP
         GoalkJ8nXN6IOQmXljOxmmI7GftVxjZwlvkXoJ/Vcasq84LZDc/z6uUj6oIxMcAbb3He
         1FOQS1EhOyLcRXdM4GA6UeXwRmTblRqokf9MXa1NW8i+RdJIOQBPXKIYYNAtbldKQLIi
         WQfA==
X-Gm-Message-State: AOJu0YyvAo7djPYcxFw3WY7ZHjbA/CAwf0tEhXCLe3OShsOohuEiRaRG
	AZCQpvDN432CQjtscNoyi8bo/R2BaxAALFdiziPv13jhvqiWKwWkIs/Ru8XNNK5vz/6V4tdZFCc
	ycS7brrujEgVab+AfBU3+iCGPWA9t1Z06bfcYVrPyAxOdP2qw/Mr98E0B4h8NGeAINw==
X-Gm-Gg: ASbGncvSAWzmVbEoAAM83ImzOZ2jPHPz1kxDvCsPiR/hVPvYSDikZsZ5A2OmNpsWTC1
	QDBQjmTuMJM3zX77IOFEC/X9mtXY1eMH5onhkyw7zjKVI/wvfTgBRGtrNV4cq164BW2C1W4C6d5
	hTcVeUWMYQXjgtJU+peaC5exMyHnB6DUrggiiVB20gty1gaSuEmB4TKa0rkpPbwOqSUzx++jqEi
	s0eufkSQSGlMioPA+SLmd8hnoyTlongYLNz9CYDYr7S8kDQ6RYMt0gkBUZnKyYaSkJ4nX3qynk5
	qulpRAhJ9UIvqGSe315t6XNmXEmnBeM=
X-Received: by 2002:a17:902:db07:b0:215:b9a7:5282 with SMTP id d9443c01a7336-21c3554b516mr326385615ad.26.1737570971790;
        Wed, 22 Jan 2025 10:36:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJk4lkbhg1zi42E+3HMeeuOQx7Gaa8QOqAQwV4V+aMmvsIiARfP5nBTwWoWHUpUnw2yuKJFw==
X-Received: by 2002:a17:902:db07:b0:215:b9a7:5282 with SMTP id d9443c01a7336-21c3554b516mr326385305ad.26.1737570971438;
        Wed, 22 Jan 2025 10:36:11 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea1fdesm98146145ad.26.2025.01.22.10.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 10:36:11 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org, P Praneesh <quic_ppranees@quicinc.com>
Cc: linux-wireless@vger.kernel.org, tharvey@gateworks.com
In-Reply-To: <20250119164219.647059-1-quic_ppranees@quicinc.com>
References: <20250119164219.647059-1-quic_ppranees@quicinc.com>
Subject: Re: [PATCH 0/2] wifi: ath11k: Fix SWIOTLB issues with DMA buffer
 allocation
Message-Id: <173757097077.4048395.12517127367376011901.b4-ty@oss.qualcomm.com>
Date: Wed, 22 Jan 2025 10:36:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: CSzkm75bfTpAJKlH6808t-Rxue_BK2L2
X-Proofpoint-ORIG-GUID: CSzkm75bfTpAJKlH6808t-Rxue_BK2L2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_08,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=794
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220136


On Sun, 19 Jan 2025 22:12:17 +0530, P Praneesh wrote:
> This patch series addresses issues related to DMA buffer allocation in
> the driver, specifically targeting systems without IOMMU that use
> SWIOTLB. The current implementation leads to "swiotlb buffer is full"
> errors and driver initialization failures. The patches aim to resolve
> these issues by replacing the flawed buffer allocation mechanism with
> the appropriate DMA API.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath11k: Fix DMA buffer allocation to resolve SWIOTLB issues
      commit: 1bcd20981834928ccc5d981aacb806bb523d8b29
[2/2] wifi: ath11k: Use dma_alloc_noncoherent for rx_tid buffer allocation
      commit: eeadc6baf8b3dcd32787cc84f0473dc2a2850370

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


