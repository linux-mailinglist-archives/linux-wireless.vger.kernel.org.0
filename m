Return-Path: <linux-wireless+bounces-3364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BECB84EE26
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 01:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 622F6B20EAB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 00:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079E3EDD;
	Fri,  9 Feb 2024 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ihOv7bOd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEC77FA
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436880; cv=none; b=uMqV/Ritl1OmCawRZCKlz5x6l0RJdRV5IGLrziOCz3ctKvtft2rU+kzDLACTj0/H6aj+KM8AomEkfODxYAC1uT+rb6EEtdL41OJjePRIXsGM0NvPW4PWaOVdIOJja0/Jj3rPllKhd1atl45vm2sbz0RJmPb4U8iaa4FgPJhsCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436880; c=relaxed/simple;
	bh=ZtCvR0ZrIr0Zbw37p441dS6OQbvhX2s9KzKiCYdUVDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Shrx1VYLFz8UjXtW8oF0XTKqSSvPXxEolROztZYStgrOHRaAcU2+GSCDJf5CDs59kjN7MBSNnbYA8tR6NrstdKEztCPRDE2lPhtSMjNWm+3VNsITVJGrOF39Iaqi/QxZl3pezRXM9FKyJwi5egp1aXbEpRmqTeD9EfUfHc7oOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ihOv7bOd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418Mhkqu026726;
	Fri, 9 Feb 2024 00:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DjHnlFwhfRg/+W+t0IhdhVIPwPmCY9RO9f2DiYCS50s=; b=ih
	Ov7bOdI3d7CU5uYA1wsOaGX104z03vy7oc7KAhEcb7D190ZqwhcDHt6zJ29nzP0C
	/6U8YvCzXSLbUiLDYpXO7vwjQwZaN/88Ck4F9hFthOvSTrGlJWB0yQzJ6WeWZ07g
	XFKm+7GFWVK0rA59uR0VwxcWocx+cx18fuHZ4FdADYbZuLCD/behiuAd+GErnDeZ
	OmBFPPnG82kroGEvxXX24d7fWC0icEAK36VxmIDoi6XENMudn1jk1IB2Ov9taSmp
	nyRViNKqBNceu8XrkBeTZFdt1lCyOVYqg5coISNr03vdjQni09OPiUND1mWMslxk
	uzkTrtvJ66YE8iv8XgpA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4pavjv7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 00:01:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419013Lb025433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 00:01:03 GMT
Received: from [10.110.97.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 16:01:02 -0800
Message-ID: <e8ecb4cb-bc84-4fe0-915a-cf6d7f1e241f@quicinc.com>
Date: Thu, 8 Feb 2024 16:01:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: mac80211: remove gfp parameter from
 ieee80211_obss_color_collision_notify signature
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, <linux-wireless@vger.kernel.org>
CC: <dan.carpenter@linaro.org>, <ath11k@lists.infradead.org>,
        <johannes@sipsolutions.net>, <lorenzo.bianconi@redhat.com>,
        <kvalo@kernel.org>
References: <f91e1c78896408ac556586ba8c99e4e389aeba02.1707389901.git.lorenzo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <f91e1c78896408ac556586ba8c99e4e389aeba02.1707389901.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GCoj5rKq2pAFuEpS7cT3sOUEQi1il6_L
X-Proofpoint-GUID: GCoj5rKq2pAFuEpS7cT3sOUEQi1il6_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_12,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=712 phishscore=0 bulkscore=0 adultscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080137

On 2/8/2024 3:01 AM, Lorenzo Bianconi wrote:
> Get rid of gfp parameter from ieee80211_obss_color_collision_notify
> signature since it is no longer used.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



