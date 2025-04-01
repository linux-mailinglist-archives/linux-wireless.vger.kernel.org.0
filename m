Return-Path: <linux-wireless+bounces-21035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FDAA782B9
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 21:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152AB16E21D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 19:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334881E7640;
	Tue,  1 Apr 2025 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D+lHBVvp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7631E5B75
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743535506; cv=none; b=ioC8kNAmoOQYRq5Tx8/zPbh0OUDEuqfz1xFV6swm1AyhUguVbywtKXpPa8QKADI6XdqnFxfKD0aV7D7vw90kdvs38BInveLlKoYlz7eBaWXAkA7aFJIlayIf6HtMOOw7aRYteMENN4WIfreBbF76IOPRgRJxuVBD7UCbb9/4bsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743535506; c=relaxed/simple;
	bh=W85YHK4ugvMN3FxAcyhsZ24bpqZ4dYBifqhC4WDnGTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SS3fuG+jW7kBYfXi64c75nS2wReepDsDNst9uIfl/tgRNr2sCMe8fxxvXx85/kc+H3WycWi+TAkW2e3FDnH8Acvd6oDk6kL7NMz8RFfsoS8HNncnLycQvRYdXbsGIxfVijMDLr1gT2gvuo0uDHUs7ZjorXoUbEim/xuc4wsbTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D+lHBVvp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531C6wlE024667
	for <linux-wireless@vger.kernel.org>; Tue, 1 Apr 2025 19:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QRoJbb0vYJ9DMlZQ5GCvBXIE3zU73+Ef62RKapWg2ns=; b=D+lHBVvpwvzBQKWC
	O1XziUalrBP5kmXcdEY+1/LDXqqmaG/GEkF+YMMczmGe/qbWB6STbq+mZro9eLgr
	13aolxa7FwvO60bhwCmn4UJZz7ucMm5bpdimON98bTMXUOpLCM3zpaaqF0K43M19
	8tZcfd9xX8mG90KhpwYG6vQxX09KMNF7MGjkBEh6FSfvSSl5mT+jJeYRyPo6A2DJ
	IHZd+fahSd2tpaDZpGQQ+2sc6nL3Wzt29q3Z8vN9PvOC/+AGVxMIe3tmxPTk3RvP
	6hr/2Jxm1aTKoOebaxGYq8K48qrackyPbJnSB5yLXyCqiwkO6wnmInL4eaM+en8n
	Kw5bKw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p86ks717-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 19:25:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22406ee0243so85469055ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 12:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743535501; x=1744140301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRoJbb0vYJ9DMlZQ5GCvBXIE3zU73+Ef62RKapWg2ns=;
        b=Zu4WXlvisgc2MvrXxH+6NvbjGdu8GjZc+bdukZWt+YEvbBxQTH0JggaQJIYBqgTR28
         8qiIL7/YnPkdvkcVMfEKAhS5406LAg9OzQJviOKp94IdrNTMJ+WiAqA20q5S72FEwXfu
         TytrZV68cQLI3QW3kYJLrlzZKphtQE1i0ZFyLinqdBgdnilLFTHUMPxpE2a3YFeYi0UW
         rS5f8aayvDM9BWZXNCVV/bYcKjUoWao3t0kExdUtNJznbl45bKUtEuhl5hxNoeA5xkHb
         OVZrhqciUI1dXJs4qrDJUnzl+OjyPOxsLIgwo6fTTd52Hy+PDUbQz4qhPd0SSZSmg3ND
         gfNA==
X-Forwarded-Encrypted: i=1; AJvYcCViygPWg0lGw+UlUm6zJPbyDatPCBlKUi78bmNiP0gp6lIQLvoa3sZtdRUYZBctt60I5hMTww+1Wh2tQLlzvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8KPvrvQ9aJDVRP7yzdyhp4TlG9DD1lYJEmXecYlaSq0okGzP+
	ZdHnyr9uej+nqC6P8LU1z/otkUsh0apf031RIuSjsg9ptI6aCUt9oDnBB3pMIWbF8PbyMgEr9Cy
	hAbk2Z0Vst5QFID1XuNXoap6p/gwxMV/W1/gfsLpY1IOEp4YWKKngM7NHqmNQPj+kgA==
X-Gm-Gg: ASbGncuTvAD+IoBeV8PFBgwsH4CCFx3AF3F2yEI6E7NG0DTpmW08jFCrTVGdQlEbNml
	hlzlZQ3V/8Cy3ANvY03j4TP7vjCG5Jemwf0VANvGHYNtvTaFDUsWAOdBvmvnOm/Y3CGZft9evxh
	3nsr1eYY28qfjw0I58yh/gHojpcgrzUEBlv2BC6eI925DSuLk4rjNgSlDg9Ye3hdvOqZ1UmyJY0
	xvsyavX9KHQvv0vgQmumhcZJy8T41LINd1q1a0y+9NN2eXisgcROm7veGi6r9HWIBXQm5/CsI8C
	KmCiUUILfnyTD9FEAWQmWXRne4NGHhBU2jhp0L7wVFH+tOwtCEw1W+pjG1938kIgWwXZ64sO
X-Received: by 2002:a05:6a00:2305:b0:736:5486:7820 with SMTP id d2e1a72fcca58-739803aa74emr18219586b3a.13.1743535500924;
        Tue, 01 Apr 2025 12:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGBVJ/NC27+iFdu2CR264VQCXW0ScxRXyk06iJFgEY+n+dIz2sBI/bdnJkP2tkJDBV5gFAww==
X-Received: by 2002:a05:6a00:2305:b0:736:5486:7820 with SMTP id d2e1a72fcca58-739803aa74emr18219570b3a.13.1743535500440;
        Tue, 01 Apr 2025 12:25:00 -0700 (PDT)
Received: from [10.227.89.219] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970def120sm9297103b3a.7.2025.04.01.12.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 12:25:00 -0700 (PDT)
Message-ID: <6b33cf41-838e-45a3-8793-dec1ed6e48b1@oss.qualcomm.com>
Date: Tue, 1 Apr 2025 12:24:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] wifi: nl80211: add link id of transmitted profile
 for MLO MBSSID
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>
References: <20250310200237.652950-1-aloka.dixit@oss.qualcomm.com>
 <20250310200237.652950-2-aloka.dixit@oss.qualcomm.com>
 <52beaa2c05c91590797cc1f53b779fca085c8850.camel@sipsolutions.net>
 <4e4e4737-6040-4ec2-a3be-3fe1aba7b7cf@oss.qualcomm.com>
 <b3efabfe73ad2c194e49a01342f90eda6c7903af.camel@sipsolutions.net>
Content-Language: en-US
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
In-Reply-To: <b3efabfe73ad2c194e49a01342f90eda6c7903af.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=W8g4VQWk c=1 sm=1 tr=0 ts=67ec3d8e cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=k16_wN6ffYU5a0wl804A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 6_D6Gfav38SSENB7iOd0gNgZTxkDe8T-
X-Proofpoint-ORIG-GUID: 6_D6Gfav38SSENB7iOd0gNgZTxkDe8T-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_08,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010119

On 3/22/2025 2:04 AM, Johannes Berg wrote:
> On Thu, 2025-03-13 at 15:59 -0700, Aloka Dixit wrote:
>> On 3/12/2025 1:55 AM, Johannes Berg wrote:
>>> Hi Aloka, all,
>>>
>>>> + * @NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID: Link ID of the transmitted profile.
>>>> + *	This parameter is mandatory if the transmitted profile is part of an MLD
>>>> + *	and the interface getting configured is a non-transmitted profile. For all
>>>> + *	other cases it will be ignored.
>>>
>>> So I guess it's a question of what "the interface getting configured"
>>> means, but I guess you could set up the transmitting interface?
>>>
>> Right, if the interface getting configured is the transmitted profile
>> the link_id is ignored.
> 
> But I guess I don't understand yet why it's not needed? If you want to
> configure MBSSID stuff for the transmitting profile it seems you'd need
> the right link anyway?
> 
> But if it's not needed, should we at least validate it's correct or so?
> 
>> The 'else' case in the highlighted snippet above is the same scenario as
>> the 'else' case you referred to, which is one layer out: "else if
>> (!config->index) {".
>>
>> Both are executed when the interface getting configured is the
>> transmitting interface. The difference between these two 'else's is that
>> in one case userspace explicitly provides
>> "NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX" and in other it hasn't.
> 
> Right.
> 
>> Similarly, for MLO, mac80211 does not need the link_id of the tx
>> interface because it already has the link_conf for it as part of basic
>> AP configuration parameters, hence link_id is ignored in both 'else's.
> 
> Oh so you're saying that you have an outer link_id already in
> nl80211_start_ap() (or other callers). So then I guess we're back to
> validating it, in line with how we say:
> 
>                  if ((!config->index && tx_ifindex != dev->ifindex) ||
>                      (config->index && tx_ifindex == dev->ifindex))
>                          return -EINVAL;
> 
> now?
> 

Sure, let me know if any more comments regarding this patch ant 2/2, I 
will send a new version together for all.

Thanks.


