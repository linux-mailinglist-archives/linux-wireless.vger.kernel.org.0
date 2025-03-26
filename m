Return-Path: <linux-wireless+bounces-20857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863ECA71C25
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 17:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458891882B7D
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12E1A8405;
	Wed, 26 Mar 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bmT1yPjQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592A21C6FF3
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007543; cv=none; b=ARaeGSCChALtVZebP5iPge2gdvYg15OKWjPiKya1Ao/GsgyAoembqRc3RTwOumPlRfYYLBNVTuSCQMaMmSmv9S6MQRrnl/qCc9U6BDOoT89En1W9HSYZqnHmC1Om1fy6PBFdWInvkk6PbTHC8q0OIpj62hVkUEK8EFWujH/1BM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007543; c=relaxed/simple;
	bh=DO2cxoxiumlrUe1IJSjAa4rIeKKb/58S6x0SajZ6A3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFp/vq/eutgWG2q2VMKtNgtOMuLB3BmS7YUkiERboin5NTgays5QfHL+VSv2L91+QdGzCUbM+cgyiyi6I2ns4nFtePoGYL4GCrIqmIMjrFjbgqQRRpJzmqeiaxJuGzkIL9WR/sHuXb3IH5Zc823u5gdGpgt0bgaHjjSxcuFLTPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bmT1yPjQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QEmrrL000563
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 16:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mfHr1bpjrfB+Y5hqI5TyDscSS5DcbWy4pzZcPGoqFGk=; b=bmT1yPjQWMtWZY3Q
	XZbWJaEycJen+eSlFGKc9YCc6YKefxWVh9MGLTG9806TR8VWD5I+DEjaUTZ04WO8
	QOKtHGfchL4+/6iPgvTRUFTcSPxOqulQFEAaGZovoARqwkEV+6gWxqpsL5LsKJ3l
	NIG/Rgwwxf2XzNBR9hVjFQQCQjQyGuNTEdHbP/sQav2OGaT89VnrkJ2MdSSE9ZW5
	zHWWe7sRzoYHrNnJ9bfB0fNVd8UCaRfs4OydFssb8H+wrpjeuU0yrnU+tjRkKdiR
	CPC7AOdJ8sxTv1TQALpbtMtmVFG6dlvJQLY/mo1QKbtmDb/sIq9uTUJrW4eqH0Ll
	6wnFCA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kypsbggv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 16:45:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225505d1ca5so1209015ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 09:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007540; x=1743612340;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfHr1bpjrfB+Y5hqI5TyDscSS5DcbWy4pzZcPGoqFGk=;
        b=iC5yPBAzTHHxwP5CicQZiGACd52S+qNCxzkjlcfDJ+Lt6hefn4xpgJq1CqyVRTBBS5
         X/15N+quk4ySeCskUDFrxUPuco3qtw+FSf7o5a6f2J+aWAfYeVbs5TxTrw/iQDNwtPKO
         1Hb3BCgSqfYQzZKzThIAHVoJVS3mopzjWTLYe+ew0LGhZtL8Kfm5uPQyH3vigRtZla9/
         XZsVLJ6qKQ1BstXJ0c3j8Af6PaZUN1ppODtyGh76khV3X0Xn2AWxlWDZwpoOkI5AVT0j
         iaaY0rKCEoVBIZF94CbsCVzIkvOzrc7k9w4xg5B/gFcrzQFfsuA+ziuK1Vi3YkQo+s1b
         qGiw==
X-Forwarded-Encrypted: i=1; AJvYcCUEeshhPoHfeSVacLRiYBUBM16DViXSQLwvhn8FRpnfI4AOSdCRCYyJhZgQj1kQDK+0T8RVEr1gbJb2ni9ZmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxloGgTkNrgURxM5hOfADVbY1VMT+yfnBdfaIrbdC52dl/KTj0i
	k35hogK6k3rEvQxaKQQop6E1/WiwrmJi3PcIiV/FA1AEQBX9tHnS3JZcXC33/trnOSBWvKc5Pbc
	5wvsjG1LOmQMbnuVOp1HRnk4pfeYkXks6aEFUCkxDyUzhTFP2fF5A4kNfSOQOBYGWzA==
X-Gm-Gg: ASbGncv+tLijPyeXQ8Tv4hUA2afs3afgi1Hi+odheaY9TKgPreNvFmxMmIsAovPUYLi
	FRkpA6DpGQYHur5bN1RE94Olc9yiYKfqL+DvhEoEua7vTbdQc3aR7PWDcnvFPdiXQpCP/nOVstc
	0/VdkobquKxMbz3OCCr7wHh09GXru4Fn1nSxbA6IqFApPohgkXh1/wauhv+Y1TQq3cvMHbsaiWG
	4K58M3CpPgfQBuNo3/E3BEIpJat4YnPa2EnzFh+tqHTYj+IRCJxvc6zFqVQCpa57jbeAQGdy62Z
	6M+VTKeSAhnQCGl5auYkvIwIF1CGQxH8znA9UeMzn4uIH3gVbscDVFruewtldA0fIMoK8cE=
X-Received: by 2002:a17:902:ebc3:b0:224:1c41:a4cd with SMTP id d9443c01a7336-2280481d1c2mr3598195ad.3.1743007540047;
        Wed, 26 Mar 2025 09:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRZ1pTniiIeTTc4QMA+ney35fp7pbxHtF1uoyISmEeDUZ9I+OE01PoohpTLlbRR66L/BN+UA==
X-Received: by 2002:a17:902:ebc3:b0:224:1c41:a4cd with SMTP id d9443c01a7336-2280481d1c2mr3597705ad.3.1743007539484;
        Wed, 26 Mar 2025 09:45:39 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227e4f973ebsm35091525ad.127.2025.03.26.09.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 09:45:39 -0700 (PDT)
Message-ID: <f703bb34-45f8-4f8b-b940-72428efa3c46@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 09:45:38 -0700
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
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6ef5049a68157bae0e121f48afc1d872a25087f7.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: J14p8rh2LaE8Ya_M1bR3e0vFVuvELmYd
X-Authority-Analysis: v=2.4 cv=fIA53Yae c=1 sm=1 tr=0 ts=67e42f35 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=JfrnYn6hAAAA:8 a=V_h-L1VytAR8xbYAWvUA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: J14p8rh2LaE8Ya_M1bR3e0vFVuvELmYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260103

On 3/26/2025 8:55 AM, Johannes Berg wrote:
> On Wed, 2025-03-26 at 08:49 -0700, Jeff Johnson wrote:
>>
>> This patch has the unfortunate side-effect that get_maintainer.pl (and b4) no
>> longer add linux-wireless to ath* patches, and hence they no longer show up in
>> https://patchwork.kernel.org/project/linux-wireless/list/.
>>
> 
> Oops. I _wanted_ that entry to no longer match so I don't get CC'ed on
> everything ... I guess we need to add L: entries to all the things I
> X:'ed. I sort of thought that might be there anyway, but I see that's
> not the case for everything ... below change perhaps?
> 
> johannes
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d19627afa652..09bd9827f318 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3655,11 +3655,11 @@ T:	git git://github.com/AlbanBedel/linux
>  F:	Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
>  F:	drivers/phy/qualcomm/phy-ath79-usb.c
>  
> -ATHEROS ATH GENERIC UTILITIES
> +ATHEROS ATH WIRELESS UTILITIES AND DRIVERS
>  M:	Jeff Johnson <jjohnson@kernel.org>
>  L:	linux-wireless@vger.kernel.org
>  S:	Supported
> -F:	drivers/net/wireless/ath/*
> +F:	drivers/net/wireless/ath/

unfortunately the ath* specific entries will override so I think we need:

diff --git a/MAINTAINERS b/MAINTAINERS
index 6191b699352e..927d92518fbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19387,6 +19387,7 @@ F:	drivers/media/tuners/qt1010*
 QUALCOMM ATH12K WIRELESS DRIVER
 M:	Jeff Johnson <jjohnson@kernel.org>
 L:	ath12k@lists.infradead.org
+L:	linux-wireless@vger.kernel.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath12k
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git
@@ -19396,6 +19397,7 @@ N:	ath12k
 QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
 M:	Jeff Johnson <jjohnson@kernel.org>
 L:	ath10k@lists.infradead.org
+L:	linux-wireless@vger.kernel.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git
@@ -19405,6 +19407,7 @@ N:	ath10k
 QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
 M:	Jeff Johnson <jjohnson@kernel.org>
 L:	ath11k@lists.infradead.org
+L:	linux-wireless@vger.kernel.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath11k
 B:	https://wireless.wiki.kernel.org/en/users/Drivers/ath11k/bugreport


