Return-Path: <linux-wireless+bounces-6886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFD08B2AC1
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 23:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF66F280D08
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 21:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254DE153812;
	Thu, 25 Apr 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b4FKbKVl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715A1514FF
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080627; cv=none; b=Zg3c4VEi3MmD0k7U+klRN3eb0HB9m55VR1W5rAa8Wlkb3Ce/vEHpyK7gX6GaG5KDhgyqKCDi/PJE04ooo+h5widzUk777BuB0aOKcfIxX3c27uPhjjVNmqjwjPbBSrzDUw1pNdMG16KRn8CKDt+BWy6ugnhN6E3pYVnihNVUbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080627; c=relaxed/simple;
	bh=8zdylOXGfmYQIX7oa8LwU/IZvrU0Rehgaty+CXIaDaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gIF2sQi5x85KyzYbqKto1EnmDa/DBrfYlhqAvZnOWsGvclBf/VVEro1B5DEtSvF8tCnVq0t2FHHTd/Sj8URhGIEwkTGGM8pYW/tBT9B09+Bx0lU9pWy72o6it0WZXI24qZ/3e7qVnhX1vWcDs1R/ZKe/KVQW2B1Y4DH8gdh8DtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b4FKbKVl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PIlIqj024808;
	Thu, 25 Apr 2024 21:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jPLl11x4Z/AWOegpbb32olSWI/6SPyUEKslL2fdrjJ8=; b=b4
	FKbKVljPV0fWFvTxt6SAJ0lsq5E76qba8IffUc2Q842bX0696kAyMLXPX1K7dPBq
	mB68jKLNVL+vZkLqEih7BC314pYPl2tdQnaKpxOMw4TX9BzasjDZ+tAqx87nzXIM
	6YlhpD+OTqBI6d625Yrza19sknADKr4rtBt8ADjz6ebIdwZ99geN+4cdJkdw8Co8
	y51/Y7x02Xuzvd3r+URB25CF+TF5+j6+K1V61afDPSxX9i24NGlEczdtJ5+NM2gj
	CSEQP9KXkfM2Kx3WPwZK+uWiu8wldRbM40IoJNvkHQoLacQiUUYxP/gFhko+DzBl
	aQIBDuC3t3wfe1SGbywQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenkkr2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:30:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PLUKTj000658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:30:20 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 14:30:19 -0700
Message-ID: <6277fad5-a974-4b62-bb35-43a93f71cc02@quicinc.com>
Date: Thu, 25 Apr 2024 14:30:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set
 to mac_register api
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240425055759.1181165-1-quic_hprem@quicinc.com>
 <20240425055759.1181165-6-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425055759.1181165-6-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MTff5IrDsksBoFiUQGpWwMTTkH4Aa_H-
X-Proofpoint-GUID: MTff5IrDsksBoFiUQGpWwMTTkH4Aa_H-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250156

On 4/24/2024 10:57 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> When hardware device group abstraction is introduced, in future, a group
> abstraction is registered to mac80211 rather than a particular device.
> Hence, setting ATH12K_FLAG_REGISTERED in QMI firmware ready event might not
> be ideal.
> 
> Add changes to move set/unset of ATH12K_FLAG_REGISTERED flag inside
> ath12k_mac_register() and ath12k_mac_unregister() respectively.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



