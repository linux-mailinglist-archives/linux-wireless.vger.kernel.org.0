Return-Path: <linux-wireless+bounces-14790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 879C69B7E8B
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 16:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13729B2149E
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6141B1A2554;
	Thu, 31 Oct 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B9pNY0VG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C21A3BC8;
	Thu, 31 Oct 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388691; cv=none; b=mjS2t4DFe+hEJSoNJgFKacnxlGP8l+erctqBVLF1VAwXNAnpnjxZBUuHyVwa0coXNLOLSIIhhFg4429An7DOms0E6ZjvUoG2/+0Xlf7DYfNgYUrvFEkpJC0824JyMiaTzfym7yjJJ6XYqfkRFF+GuoF6uHl1HQEQGzzs3p09Jf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388691; c=relaxed/simple;
	bh=T2Fa3SUut4Ty9yjJO6CPTHbG3BQNqqTTUOqXsqZxfJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SlYLsf9w7PxQ8rbYGRv0gVC9o4hzp+R84ijCnXr4CFUSUPfCI14S4aV0phnGZqrPqUHEtghaXRjM3w1HyLbjuyBokPutNyquP14Ydvdh56vpapbjvolVBm5TWx1UaHTapMmRMCf+kV0sTtnDzwGy7wthn1L4I7M9x98Szkymx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B9pNY0VG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VBwSE6002694;
	Thu, 31 Oct 2024 15:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ub/JWH13NrOvk/2P9lnbjjU3DTjmfkl31DbRGAiNyYM=; b=B9pNY0VGzcgMhXhb
	30FWzsIaVtgvDgXPmQGd1vaWZctqSPdmzr8jCwiQIPEkAdhQkAeOF+0aYoZgoeQg
	0jVz3ptX+LSgitmNtPkod2JJw+pTmTjQKJaBqobpFdgD2wb5qZ68GQTI6Mnt1e1U
	2c1AJ5VdZovAfxDRCr5oH3thT7LxSFEh3ewi0wdv1QAV2ngXG/xrFpVtNh2fKwZg
	tkVWOUjKCcBBxx/zp4FCDtWDWkaEiFoPK2ow9oJpIlEyfm9NRwTzFtu2cphyDM7t
	9laW1D+jjV0qirN2G7U4eq6drBAgIt5qsirykS97CzF+NfsPoeJCceqn+bo+7Fql
	TJhPyA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kmn5c3wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 15:31:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49VFVMRb003181
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 15:31:22 GMT
Received: from [10.48.242.225] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 31 Oct
 2024 08:31:21 -0700
Message-ID: <73ccf2a5-f08f-49ce-b810-6282f9a35f6e@quicinc.com>
Date: Thu, 31 Oct 2024 08:31:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: add support for QCA6698AQ
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241031000541.3331606-1-quic_miaoqing@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241031000541.3331606-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M8v_aAnhj6vHUCcXg8Wtyv10U1yYtUGa
X-Proofpoint-GUID: M8v_aAnhj6vHUCcXg8Wtyv10U1yYtUGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=759
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310117

On 10/30/2024 5:05 PM, Miaoqing Pan wrote:
> QCA6698AQ IP core is the same as WCN6855 hw2.1, they share the same
> PCI device ID, the same major and minor version numbers, the same
> register address, and same HAL descriptors, etc. The most significant
> difference is that QCA6698AQ has different RF, IPA, thermal, etc.
> 
> Follow the approach done in commit 5dc9d1a55e95 ("wifi: ath11k: add
> support for QCA2066"), enumerate the subversion number to identify the
> specific card.
> 
> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04479-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


