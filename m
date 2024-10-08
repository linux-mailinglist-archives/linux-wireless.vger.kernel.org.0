Return-Path: <linux-wireless+bounces-13719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D88E99430C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01E51F296C1
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684BF1CCEC9;
	Tue,  8 Oct 2024 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JGWVDFdC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577923A0
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377374; cv=none; b=Q761wC9hJIe7kRIdvcPWgZrwH+MAiT2NLIigT6XBbX/Hujs6RzYXTJtqgaH3uZzzCOY9jeqnAVbhLP5K+ipc48A1SfntfvCW60j/x10e12DnER+aDVLPo43sOruwil4CI48IRl1JCwJ54Qslzl7CfVMM9BSoXiDfTnkNLk13S0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377374; c=relaxed/simple;
	bh=kYtbuiOa/QQD3gP7crBGHopFIjpD0XL8QxLdDPshqbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Etm+cXhzhjnggn/Q9Yn2UoHK5GTrOBg7ObFW52MB7ZoaNohADXkoeJ7TM7kJacLedHV9Yqt4ffTFanU5Z+jJqEeqGt0htDD+dfhf+zYWEPpNgXLZLSDBzb5wtCNzRF69D5dvcKtqYfgQZmf3zhSCJnjcVBqcmTOEoWKb4hchplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JGWVDFdC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4984TVgS010058;
	Tue, 8 Oct 2024 08:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DSy7UTjBLw12etpFlwiEM1P+BXe0S0NJNh1K6d0Pgc4=; b=JGWVDFdCi8H/DofM
	S+DgLIKSSckxRm40E5I77HEYqV7HAZlEJXeHnagrj0uY9+ncKPQOztTH02GBenFQ
	KrXiVHz+OZefcZCV/LKjba9I6xCnhEo5z08fE6iiAtEvdi8/908093+40/xdwB4G
	XDBN9BDn7BQHdAR9/FcD14VrqYCFrTKD+CIhu0pJQ8Pw8A+4t7vyPu1Tj3eUeFlH
	anbI2JZY7GWyT8FUt6wzBfqUJ/JC0S/6o+IZy/csfLl+X0jlztrqdAeK4QaLN3ee
	Sz0pJvbgPpSM3IKArO9X4VMapksHehamLpRXypaih9Ugd450W15PqM/LUiX9XJfz
	njjtpw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424wrc0jvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 08:49:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4988nPJM029107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 08:49:25 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Oct 2024
 01:49:23 -0700
Message-ID: <6fc2d696-5d8c-42a0-9264-57f048093b74@quicinc.com>
Date: Tue, 8 Oct 2024 14:19:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mac80211: re-order assigning channel in activate
 links
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20241001085034.2745669-1-quic_adisi@quicinc.com>
 <93df47a867ee1f8d84cabdbc953707eab2ea3704.camel@sipsolutions.net>
 <6504caf7-e9d5-49ff-983e-73335f8ee3a1@quicinc.com>
 <97054998-0793-4c71-a202-dd5167fcc24d@quicinc.com>
 <a66621974d1bdaf4ef9c922907786cf757cb4fac.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <a66621974d1bdaf4ef9c922907786cf757cb4fac.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3Oa_dI6R6wepz2mlXmDFYNUu1pysRLF8
X-Proofpoint-ORIG-GUID: 3Oa_dI6R6wepz2mlXmDFYNUu1pysRLF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 mlxlogscore=785 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080057

On 10/8/24 13:06, Johannes Berg wrote:
> On Tue, 2024-10-08 at 10:43 +0530, Aditya Kumar Singh wrote:
>>
>>
>> Is your testing complete? Do you see any issues with this change?
> 
> Yeah, it can be made to work, but we're still discussing the best way
> with some internals (slowly, due to the holidays in Israel).
> 
> I think you can just leave this patch as is, and I'll keep it pending in
> patchwork until we figure it out, and then I'll just amend it with the
> iwlwifi changes when I merge it.

Sure, thanks.


-- 
Aditya


