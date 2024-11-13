Return-Path: <linux-wireless+bounces-15221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84049C6668
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 02:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5DE28383B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 01:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051EE2F5A;
	Wed, 13 Nov 2024 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KYNLcJLi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AAA7494
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459704; cv=none; b=M0ndUm0fSTzAky/JAKpODlrSltdcD0bnL3GqdsTbfErWQSRGOSitebQTUWhOZ337x0h72e4CknSfCgd4kg1KkE3InfVHAgVDsYAO7/2tAlmnHpaAV1Nl/PV1g4F1Nx0BfIruUjBILPPDQlGNyJGZVF8cAHtN9kjYPstVnNhk2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459704; c=relaxed/simple;
	bh=F/XX2tF0c8NOk1yQl2IJQgwhQBkg4X9mlaQ8+4IQD9U=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Nh+IEgQhmbDXxbP4XE9m4V3qQ/G4wJ0g7ISGbXbRsCGYaRjx1PkImo87r615Y79p/JlUc/KLf1mYNYMatsUDk02IPSmsW/gpS3JSjk1k+WhJX2wnQNIiHynzQjnobOXGUlFI2wg6IYZJQK8+c4wbRgSZB7oKxlNIJLbymTFWR3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KYNLcJLi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMRqtJ003799;
	Wed, 13 Nov 2024 01:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uXbDbEEiTa9fJcd/jlFzr++MTPHsqqWij8ewzpn3plA=; b=KYNLcJLiVPP8JG4C
	SpWY+tyQERpagK+8QUDB0spzXFiSIce22ZF18QSPXY3LxZBdxM75Iv6Xyd8VeVKN
	WuZmort5NpvbDJraxgfOFkU6VESvIHDHEXSGZyLpWo8xIfROEBls3v8fC+lib2Ir
	nek6oAOpYrn0MhjDe1RfAsJh3mlS48VS9uHD7xCU5Sr8AEi9eGYTz8oG40AOLT7e
	dJM5F9JpYMoDYoZwuk/BPRCJH5DI9Ni0XgI3OwZhYMBMClXxvZhMMV6bgscmu8wh
	ypyMmWIjIiHnWqAglmBDbXnC2MScakdD/UpPb5FcjdGARVsMdkAs+Y9SzKDX6W0H
	E5UDVA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t0gm110d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:01:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD11dLe016862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:01:39 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 12 Nov
 2024 17:01:39 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath11k@lists.infradead.org>,
        Balaji Pothunoori
	<quic_bpothuno@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241030114625.2416942-1-quic_bpothuno@quicinc.com>
References: <20241030114625.2416942-1-quic_bpothuno@quicinc.com>
Subject: Re: [PATCH] wifi: ath11k: Fix unexpected return buffer manager
 error for WCN6750/WCN6855
Message-ID: <173145969903.2685813.5929707088344586586.b4-ty@quicinc.com>
Date: Tue, 12 Nov 2024 17:01:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8aY5Bgutcy8R8a9qHWD1ZPH3dzNm78a8
X-Proofpoint-GUID: 8aY5Bgutcy8R8a9qHWD1ZPH3dzNm78a8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=508 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130006


On Wed, 30 Oct 2024 17:16:25 +0530, Balaji Pothunoori wrote:
> The following error messages were encountered while parsing fragmented RX
> packets for WCN6750/WCN6855:
> 
> ath11k 17a10040.wifi: invalid return buffer manager 4
> 
> This issue arose due to a hardcoded check for HAL_RX_BUF_RBM_SW3_BM
> introduced in 'commit 71c748b5e01e ("ath11k: Fix unexpected return buffer
> manager error for QCA6390")'
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Fix unexpected return buffer manager error for WCN6750/WCN6855
      commit: 78e154d42f2c72905fe66a400847e1b2b101b7b2

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


