Return-Path: <linux-wireless+bounces-3900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F6785F202
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 08:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C32A1F217BF
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 07:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266C3179B7;
	Thu, 22 Feb 2024 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KaIbJjGC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E917998
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587816; cv=none; b=u/YsbLilsF9Hbm457kqqyVxj9yIIx/rplMgjA6yzdMfHENqVuX1jNaPLr7+XdFDFA6INNApWWlAtSKm8ElElx+YqQpnOq3xi9qCKXlpa60Ar9g67iMIZEHttVJ9i4ZQ/280nfw+DnDvd0k52bcZAdwqpgc9oX2kdtb/AunmnuCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587816; c=relaxed/simple;
	bh=IMXSyg4QLNp7NbS/G/I7aJl3pXlCIqEDkpBlqFH8gmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZmlhhX4AfwKybYyN8Qi7ICxcfLBF4AnrFuvErzzL8YosJKYhxWKccsuBlnlEr9PiHlC52DKywI4hLag2xS46AgyF/kewpG1bqEtFcCfsY2quyz1gIADBn3yu8wHnsUR0iX2DHQ1ya2wJ98DyXKT14PR048kUDkceAuuhmZbC+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KaIbJjGC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M4eh5t008173;
	Thu, 22 Feb 2024 07:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WjcpAeCvqNYVdw5Gfg2eLls7q88UxKFRlFchWflRZFg=; b=Ka
	IbJjGCvUMbC8ivCgBLkkaPC/L/h9IReubrocGFUuAZhoDtyOYczO7s0rk3WtJYR5
	DciSUZ3roh2h37Nd0CPNwoi533+dMVvjFl/ApgftV+Qh8e0ZnIjDm4vR0qeXUeMR
	eBLkGcbumV7vJn15pZNmUSPb6Q1Q1uyFF1TC1LKdmOfN8g/cNuuANGAg82kOJN2A
	NrowjGcImAsaHas+SAwq/fWuo/0NJTNTWR+XHtGhjbhTT5cJ1FQmHpOa9M11cSzx
	EPja6WdtS/eRUdHktUt8NhCrlukJG/S7pZ49QtjveTrSPPBDBGrbw+Mdft0HmA7K
	sFf9RNHj5xXenUgXNtzA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdvww8nw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 07:43:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M7hRdH002556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 07:43:27 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 23:43:25 -0800
Message-ID: <f2536171-f878-4a71-a49b-ca87abb17251@quicinc.com>
Date: Thu, 22 Feb 2024 15:43:22 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] wifi: ath11k: thermal: don't try to register multiple
 times
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240221024725.10057-1-quic_bqiang@quicinc.com>
 <20240221024725.10057-6-quic_bqiang@quicinc.com>
 <df08dfd4-189c-407b-8a2e-6fd2bbf3b22f@quicinc.com>
 <5828b835-6b4d-4245-991a-7f6b54ee8b51@quicinc.com>
 <871q95audb.fsf@kernel.org>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <871q95audb.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S00_5w7YJtEOuHhqu0CgQzg_huYSy501
X-Proofpoint-GUID: S00_5w7YJtEOuHhqu0CgQzg_huYSy501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_05,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 impostorscore=0 mlxlogscore=913 clxscore=1015 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402220060



On 2/22/2024 2:25 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> On 2/22/2024 1:15 AM, Jeff Johnson wrote:
>>> On 2/20/2024 6:47 PM, Baochen Qiang wrote:
>>>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>>>
>>>> Every time the firmware boots we call ath11k_core_qmi_firmware_ready() which
>>>> ends up calling ath11k_thermal_register(). So we try to register thermal
>>>> devices multiple times. And when we power off the firmware during
>>>> suspend/hibernation (implemented in the next patch) we get a warning in resume:
>>>>
>>>> hwmon hwmon4: PM: parent phy0 should not be sleeping
>>>>
>>>> Workaround this similarly like ath11k_mac_register() does by testing
>>>> ATH11K_FLAG_REGISTERED.
>>>>
>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>>
>>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>> you need to add your own S-O-B
>> Oh, sorry for missing that.
>>
>> Hi Kalle, I see you have put this series in pending branch. I am
>> wondering if I need to send a v2 to add my S-O-B tag, or you have any
>> other plan?
> 
> I can add it in the pending branch if you send it to me as a reply to
> this mail. s-o-b is like a signature so I won't add it on my own.
Understood Kalle. So please help add below tag to this patch in pending 
branch:
	Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> 

