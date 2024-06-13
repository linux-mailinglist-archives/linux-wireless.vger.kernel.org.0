Return-Path: <linux-wireless+bounces-8988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66C0907EA1
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 00:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD4A1C21015
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 22:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C9413D53E;
	Thu, 13 Jun 2024 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SmNSv7oS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E8513DDC6
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718316757; cv=none; b=cMWTaYUVTFyxSmJlVRQ8AQxkYKWDwmU0Z/ghQTbKBa28BQ8PIq3auxiGoDfmshowcn/CaeJXjZ7hhlY1ienHZr2RYwzlk7+Q6vJx6aE9DlODFp6yYmd+J6dbHQStMFtRaSJaSv331G+JR/2rAMDKq510UR19PdLdLod4/LsDZd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718316757; c=relaxed/simple;
	bh=ZWOG/ICMHEpO05m504VTL0VAf2j4w/VhOe21sNC6tPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wp0vYXrxtHTnOKLfyuzud0BO7sU4IWhnS6jmFH0pCnZk9P16vHT82F9qx+nzHCdpEGWrRlssAmMuNZxVNhx7uDL/QuEqNQbA6psXEDp9pmMA6wY1/VjKdvpQiISk1WVHrAEBj6mKotGDEoXWBtj2I1kGU8V83ZNe3kMO9FjSK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SmNSv7oS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DJGm8O003692;
	Thu, 13 Jun 2024 22:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2wi3O1xjOyMTFQWm98Sl2JQrawOmdmn8o0kX1XSoKFg=; b=SmNSv7oSGKsyEtwt
	y1gSWJryWOLDqQfrXp2uK4rV4rYoENcXSMK2mhqD92r2sVmviw0V6bU+Z+Lr6ya0
	1BRNOj0ZM0WVR1DEsl1Lxs5lrWzuWGHnqVOSr8iED2ZCTc8Z4CSmE88675UzGii7
	Css8JvawJMA3zay7IvvNP8/gib6jFpdQrdliimTtVMo8DI4fo7ylbOdKj4H2GDBf
	BZ2fl2yXe1t7+ZqtxsrAJA4xVKxY6tv2rjytjtplSf2Jq+IxdWELNTeQd0VKTK3D
	zXdanRlLy8M09dvWMv7e0Q8wuzx1Hely4VYMKQ9gWX6SFE5fJZwo8Sagtkb+V5CG
	VTyREw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q2rdar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 22:12:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DMCWoH020659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 22:12:32 GMT
Received: from [10.48.243.167] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 15:12:31 -0700
Message-ID: <da716af8-f237-4ffe-87ef-efc931955932@quicinc.com>
Date: Thu, 13 Jun 2024 15:12:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix firmware crash due to invalid peer nss
Content-Language: en-US
To: Ajith C <quic_ajithc@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240613053528.2541645-1-quic_ajithc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240613053528.2541645-1-quic_ajithc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BnjVU1fZIvG39rMfTPPgLZMVF-YUez0b
X-Proofpoint-ORIG-GUID: BnjVU1fZIvG39rMfTPPgLZMVF-YUez0b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130160

On 6/12/2024 10:35 PM, Ajith C wrote:
> Currently, if the access point receives an association
> request containing an Extended HE Capabilities Information
> Element with an invalid MCS-NSS, it triggers a firmware
> crash.
> 
> This issue arises when EHT-PHY capabilities shows support
> for a bandwidth and MCS-NSS set for that particular
> bandwidth is filled by zeros and due to this, driver obtains
> peer_nss as 0 and sending this value to firmware causes
> crash.
> 
> Address this issue by implementing a validation step for
> the peer_nss value before passing it to the firmware. If
> the value is greater than zero, proceed with forwarding
> it to the firmware. However, if the value is invalid,
> reject the association request to prevent potential
> firmware crashes.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Ajith C <quic_ajithc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


