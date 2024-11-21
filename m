Return-Path: <linux-wireless+bounces-15565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1056B9D5085
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 17:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EA72824B8
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D6619EED7;
	Thu, 21 Nov 2024 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vanujc80"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19824199244;
	Thu, 21 Nov 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205567; cv=none; b=jweihJu15GdyRQwooebn5rK2TN3M7upupHZYOMcD5iHzeAMTdlE0jQhcFo6ysLK+W9QuQ/AQIxmfmfGJWnwDXJTIUJudr5FTCucLReMxwCN6ENFRoUakOfSE2COia/cnGNAalfKYfS33poNcbPd6bB9M+7WauYiMwhv3Fj/c63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205567; c=relaxed/simple;
	bh=S3Afhg+PLYxPNRqjQ3T0ylUOGEhOBMijBlP/YvwJGKI=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=JbZ1dWCdnthDay9qlGOWrGKW9WCBmo0QsbpYY6KoBtH+ZEo7nm8v/MfBgbJgizEIqKkEI2pjOJSBjmpHmww3uY4xW1TQex+K8eKRIaJ9bIJAapGLX2pe48dCWRCIK+nmp9TR3n+75gRo2UfciK7R9zER+q4FQgeidqLEeEQOJgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vanujc80; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALE9h43003085;
	Thu, 21 Nov 2024 16:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KZ84JMVvxDNU5imZVpSIKTsUWtWxpzgrH3qi5fL/ogY=; b=Vanujc80bIBTyF1/
	8dwccA9cn8AfhGb4dyg8rnMuytmtxS/CZviXpxXyjXU/dsxRc0lva3Dzj4kf35tr
	Tc0YvbXqudtiM7Vs+bvWsnLcu619yaVlXTato/RfKnbzCPPOfZcWLJecElwHbaCN
	RFo7fZI6qTOHkz5SXrZOu6KgsQzoDenacOXF4ofJ4kTEg48rEMli5ColTLhjVnmy
	cBimsvuK23YrgKMRmMzHxybJJeYEKvZ9S3sIm31QaJ6g34H7WCY2RhLPNA0s6ZgC
	WulHoJcbQbAV9TMa+RoUjG+0JPPu2g3+owd7vvS11MvLUWGX7oICYm17V2LkORQN
	9uQeNA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4326cs8ag5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 16:12:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALGCccV002126
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 16:12:38 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 08:12:38 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <kvalo@kernel.org>, Miaoqing Pan <quic_miaoqing@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20241031000541.3331606-1-quic_miaoqing@quicinc.com>
References: <20241031000541.3331606-1-quic_miaoqing@quicinc.com>
Subject: Re: [PATCH] wifi: ath11k: add support for QCA6698AQ
Message-ID: <173220555844.3016923.11617496891402313997.b4-ty@quicinc.com>
Date: Thu, 21 Nov 2024 08:12:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YGUvEwg4ISHiOcLK-NysMRO4M7Oot56a
X-Proofpoint-ORIG-GUID: YGUvEwg4ISHiOcLK-NysMRO4M7Oot56a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=583
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411210124


On Thu, 31 Oct 2024 08:05:41 +0800, Miaoqing Pan wrote:
> QCA6698AQ IP core is the same as WCN6855 hw2.1, they share the same
> PCI device ID, the same major and minor version numbers, the same
> register address, and same HAL descriptors, etc. The most significant
> difference is that QCA6698AQ has different RF, IPA, thermal, etc.
> 
> Follow the approach done in commit 5dc9d1a55e95 ("wifi: ath11k: add
> support for QCA2066"), enumerate the subversion number to identify the
> specific card.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: add support for QCA6698AQ
      commit: e238638e6f24109c0c7639f4a2db023388bd1b76

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


