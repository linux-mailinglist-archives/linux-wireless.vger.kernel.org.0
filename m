Return-Path: <linux-wireless+bounces-20859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F98A71D86
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 18:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1AC33A7690
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 17:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4ED234978;
	Wed, 26 Mar 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tp5ZoMhN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0EC1E1DEC
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010846; cv=none; b=JoP+ddZ28ZTnWy1PpeDe0oSdxPyqKKORDLsG4dml1S8YQD46+nMqc4I9GpHj0pI7jb1fXrfjpvjiNsi8nFqvBysGvOT6o2T7QRAfe/9GcKsi7rG4dZfVMCyKOSGQAhtH8PqseZmmpURZGSsWF8NEvaUd/08PounMSyVCexkRVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010846; c=relaxed/simple;
	bh=K+W8B8oX4XSvRqOcNqkrtJtgXCn5ryFU+TEG+KNgbKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hym+NQOTl4TRm/Yn9RKYHYCl97TVsBDhzbDW4ZNE9bxUmmhSDqaWplaWxTG1nzACNrUb9cFIi64yawN+glRU3VmJzTAv2ssLY5czG79Uq5CGxWEH1q9yjHX7Bx1yaLROJDeP4dXFU0GrgWBt4J8uXLfen90vnj8x0gf0ZTb/xXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tp5ZoMhN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QA1ikq025364
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 17:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XjdqfmANQE7XoAJoADExQqGV51um8c4JxtoMepVpYrY=; b=Tp5ZoMhNN/3zWDRF
	ggZHgh+5QBNOaY6TG8fgXw6mKhbjG7CGaG8fWqxtzwLyDNxYU6734WDdsjoiHLsD
	g7Zbk3F43BDzDSd/HVm0t4nJn+fPn05Ym6eyc+3Pbnx6MET+baP0gp52e3ivP0Hq
	Ydg2RZcdQZfx+n5fYNOjnWDVXQnSW7g1NmhT6tWLf0io8/aOMsreKfjqqMp2zlEb
	dsQCMYP2/pJZN5r0rf5iZntXDRelGlv7pVzhLeBCtxMQnkpaYXS+EIJnD0gRGMSf
	Ew2TQ0SHprYkQMUEb4aFj/NQfxnj9iYeyGOOJCJEwEkhXama1F9BuO88i9eu/FU8
	iOHrzg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mffch9y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 17:40:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-30364fc706fso52922a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 10:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010841; x=1743615641;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjdqfmANQE7XoAJoADExQqGV51um8c4JxtoMepVpYrY=;
        b=sp261deVmNfXrTkq7y1l+/kaC72nDKdgiVqaTzfGvNEdg9ulKhyh6R47Kgv4dUnzBx
         dlv2vOPLYN9BIkyWMHRiWr6tpZDxERbWjgusq9V5iD5S3t638th0hqnGHrxBuYFqv/0T
         0l8qAgYcIQvT/HZJbSHC95Kj2FzaHiq9W0Th4FL3GqPGda6v5qZwdQntNWgTxh6bX4JO
         5AG4wuZyqMyoURdsy/x097u6wKeaJLKmsuTfCH4r/1QF1s1Uj7p9Vd2yD1wI2SwNohH+
         1kgv4/BFAqrMWqkqguFK+sWpVWZAqylopy1Af0jW5fpG20a6glDwhNjmPa8S70QB1QV+
         +BSw==
X-Forwarded-Encrypted: i=1; AJvYcCVq+fWdCH1OkaNh0lFJ1gZZpvwH0W0CVc1knVMOdGDhQE3S+U1R0t8IGFmmXPBFaYue121ebI2DToKN3qM8LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX47jgeBmFWEsW2JrAOIQOYkguokgy75tDsTTz8qToaawYZ2OR
	Z+rRZOXu2Scyx5twbuqcTvhFAdNfwsHYsGh+L/a7pPiOJcuD5YPGL9gPsLYuqJbCUp+9HJFDAXz
	NpF7scGfYFPrNJfuqpe0KTNGtNnZsX41AuAamomp3yUHDUXRfZt6p4Qw2UQ6grbFzZ1KcmcGIKQ
	==
X-Gm-Gg: ASbGnctR3N72Kgv1jxdf745HtEVVwA2cYJTeVcySf6zGutSMdKLcjEGF8Zxb9n2DoWS
	VF5HTN5G/PscyM95EtyXtHoPQ+yDoej2fJYiCMCM3vVy3Z/X4ufusECiRRisYWsSZSRx9gHpQow
	mvX4qr/WyCQ8x3S9CqRxR6MXzr+qyhZv1M/u8+jc5DsmQ7vT1w5zAm5mGXPpVVYtOLgJqu7mFds
	K3RcIMILOz9F62VXe/DsHwWGKtCMCb+BAz03G8XwR8KgG0eNxEiEMNurTc/Pjo6X1iiRsphipgZ
	dBlTUGqzAUXJqPOOM4oxjhfbzonHa/dd3jxu9cCRpSnAYgfkPtNIhphFeDAOoWK0I1z6CyU=
X-Received: by 2002:a05:6a20:9148:b0:1f3:293b:7aa with SMTP id adf61e73a8af0-1fea2d3effbmr1034953637.4.1743010841056;
        Wed, 26 Mar 2025 10:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzPzvBwB8dfFwDt/l+446jyef+m1d80JuTixPOpRYkKoUAkhVeFer8JzrCwYThrDl48WX7Lw==
X-Received: by 2002:a05:6a20:9148:b0:1f3:293b:7aa with SMTP id adf61e73a8af0-1fea2d3effbmr1034918637.4.1743010840527;
        Wed, 26 Mar 2025 10:40:40 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a282be07sm11311060a12.34.2025.03.26.10.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 10:40:40 -0700 (PDT)
Message-ID: <f5a0d68e-87f9-48f5-bb1c-a6ecaf19d58e@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 10:40:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless v2] wifi: rework MAINTAINERS entries a bit
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>
References: <20250306092831.f7fdfe7df7b2.I7c86da443038af32e9bcbaa5f53b1e4128a0d1f9@changeid>
 <085bfa6c-cad5-43cf-9432-811b744da506@oss.qualcomm.com>
 <6ef5049a68157bae0e121f48afc1d872a25087f7.camel@sipsolutions.net>
 <f703bb34-45f8-4f8b-b940-72428efa3c46@oss.qualcomm.com>
 <7e4058cf8346ad75b93a932141801b42e4cd63e7.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7e4058cf8346ad75b93a932141801b42e4cd63e7.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CdgI5Krl c=1 sm=1 tr=0 ts=67e43c1a cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=jmPUxxVvAQEylilMrj8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: Y-EHoIWepbjAMHGpd6cH_5OOMRxVcVP5
X-Proofpoint-ORIG-GUID: Y-EHoIWepbjAMHGpd6cH_5OOMRxVcVP5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260108

On 3/26/2025 9:46 AM, Johannes Berg wrote:
> On Wed, 2025-03-26 at 09:45 -0700, Jeff Johnson wrote:
>> On 3/26/2025 8:55 AM, Johannes Berg wrote:
>>> On Wed, 2025-03-26 at 08:49 -0700, Jeff Johnson wrote:
>>>>
>>>> This patch has the unfortunate side-effect that get_maintainer.pl (and b4) no
>>>> longer add linux-wireless to ath* patches, and hence they no longer show up in
>>>> https://patchwork.kernel.org/project/linux-wireless/list/.
>>>>
>>>
>>> Oops. I _wanted_ that entry to no longer match so I don't get CC'ed on
>>> everything ... I guess we need to add L: entries to all the things I
>>> X:'ed. I sort of thought that might be there anyway, but I see that's
>>> not the case for everything ... below change perhaps?
>>>
>>> johannes
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index d19627afa652..09bd9827f318 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -3655,11 +3655,11 @@ T:	git git://github.com/AlbanBedel/linux
>>>  F:	Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
>>>  F:	drivers/phy/qualcomm/phy-ath79-usb.c
>>>  
>>> -ATHEROS ATH GENERIC UTILITIES
>>> +ATHEROS ATH WIRELESS UTILITIES AND DRIVERS
>>>  M:	Jeff Johnson <jjohnson@kernel.org>
>>>  L:	linux-wireless@vger.kernel.org
>>>  S:	Supported
>>> -F:	drivers/net/wireless/ath/*
>>> +F:	drivers/net/wireless/ath/
>>
>> unfortunately the ath* specific entries will override so I think we need:
> 
> Hmm, really? Seems that if that were the case I wouldn't have been CC'ed
> on every ath*k patch?

ok, that was operator error. I thought I was applying your fixup but I was
actually applying the original (merged) patch.

but this now indicates I maintain all of the drivers under ath instead of just
maintaining the utilities that are in the top-level ath folder itself.

so from that perspective I think the ath entry should not be modified and
instead the additions should be made to the ath{10,11,12}k entries

/jeff


