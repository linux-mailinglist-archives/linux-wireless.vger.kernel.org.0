Return-Path: <linux-wireless+bounces-19549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 658C9A487B5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 19:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFBD16A965
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9BF1B424D;
	Thu, 27 Feb 2025 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F/WxPH3F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D717D355
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680598; cv=none; b=P8NnuuiPqGXcVb7qPp6j5fLTkxxOQH8VOeFSfJv/3Zv60ZY3/7XW14c88rkmO8abiY2FRaVW1cRrtoPe2MHSMzbQeJ/Xvm2Jw967WBjgRXYfDJB7CAR13qW+vhItfHKS5Il3Jc7F974G9YthyD79efXae7O6s+o+a7KEhbFqJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680598; c=relaxed/simple;
	bh=EZIcLlrc9ADOHADM1/PPyPeBvQM+hLSbtlzcQrHoGO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JIoU6nfCdkPG0CowT2DSh2Cn0CRZZKMMquFTJ3YZufgdJUcXg4mu61/GOcWhTHHfJ+sMisYzKEhI9NCBgOpW4fv+g/CDP6CX58IY3+j8JTPlJrET9kyow1WDDKZjxV/uamcVDfFxDc19Z/3LPLQTeYfnsS3EgTDKCbg/VTvjIZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F/WxPH3F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RAmH38003268
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 18:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Hl+zF8QNyQfwFouw6ZqfSKASevUsAV0jer/ijkH+9c=; b=F/WxPH3FdeDBMkEK
	tm25oAh/TsmZnhjZMDPqN/QFN28s8IkYPadjDPQ3iLpzX87GIPKwRwBRxT2BpD1r
	SH1BLmA31HdZ69BsZEuy56qQ4SARAS+csRl3ZcBMGFyG4TogUUSqK+IrXOFaPWZv
	RlBeDf0pChYA5+iIqPCqgL0Em2jUs/6U2shpZRlRdP3GpeUSZ6yXRUx7370PQ6TR
	HrwlsICwVWqcrFqlWyLT/yvsX7RSUnyJvA6tYUujc9gfV8FP8f/mMD6u3g0I1CdM
	o1dE5M32oxseuUXTN1l2AQZGKOTTheMH8v4teAxvRbwj0ubWG5kC71FcEZDH9DIx
	x0WNnA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 452pm7hbmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 18:23:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc43be27f8so4446706a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 10:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680594; x=1741285394;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Hl+zF8QNyQfwFouw6ZqfSKASevUsAV0jer/ijkH+9c=;
        b=oBJrvZW7MRZNEwIt6T3BIXta7L/AxF8foQiZo+/h1os0lCLvo1uGpLncF++JK6iEAj
         ClgwDV5S17FYnt4Mc6ZUusRLd+iGh7qdNER0K7kwm8bU41mAA6xPTRbDvWYzbyJkCLN0
         vyGk9g14zCF6HZ2SlL2nzGNnkrR3cVdlWEbx2hecCxLNYbhr2se8U0aHKblTNTc60sdG
         NMD2cQ+Z61x5CaPy8m6v7fZuFvvUtYZO0/9mO65tfyJeeqOEgk95UfUb0PW0QWSWPI/G
         +Q3Rj5zvJqpiPKiAse063wgOG58RlegCiyiF+qfSRLCCE1gkQhSPNShFfs6Y87q888bQ
         2N4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHvVonz3oOJPrXsz+RawsgWKXWUhXCcreT0BfC4Fm4tpMEe4a8bNIagbmRNJUY05gJw94tWi9Wxq5dAFfoVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyqyD2yYRKg7g4jp9O4FoYOwJv/r7eOeeCxKpc/D0wvE2QgwC5
	L6xhqZlr82w0BwRHvYFoKga5pHkWefi/YJqHbMxs3ksTINpcoVP3qfLAggOFaQrUSgth4W+Ovy4
	ml00Ajv6bJtaz1m3AYLzP6Fwb6/IezS758MNDX4Z1+vcbJSmxIUAVTGHOZZKsux3omA==
X-Gm-Gg: ASbGncuu6vBRsMCmP3r7LkVLZGTsk/NsKrFrJeDJUZIjJRb7kT8DGqv8fggKtRlUEV4
	75KpfH/Ge9/T1GG0Lqv4TO5Z314dLSH2nKbSPrWC34BYeMVv3ccU94suz4d1LghFLZPG0FC5g9V
	vzetdWJFm/25GNZ3dKuZEBObkHvvJJ6zh2kBk1DsI0dGRpiJL5zExzsa49UKvdvUITbvrdo+T7+
	n5X8pnM72LnNffbaUYdegGmsn2PGZgWNW50FUcW7TTKJO3nDRZ0KZAzScF0zKc8/REAdr7qmRgp
	/1BRXhFFMzhg1nOqwD0TBCtrziTv6sKZfrgH8IRGpjrkp/HxKkiKdrB2WcH5clGOPhP7U2MrqNb
	8BZMKva/k
X-Received: by 2002:a05:6a20:1596:b0:1ee:63d7:1d32 with SMTP id adf61e73a8af0-1f2f4b04c28mr300505637.0.1740680593663;
        Thu, 27 Feb 2025 10:23:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGXRitzuYgffUGuphu7En7wMz69ElRq83ucDmvaPv90kC8coNbpr5toZlJdzUgT4nTOIZkww==
X-Received: by 2002:a05:6a20:1596:b0:1ee:63d7:1d32 with SMTP id adf61e73a8af0-1f2f4b04c28mr300452637.0.1740680593217;
        Thu, 27 Feb 2025 10:23:13 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf20b8sm1822889a12.7.2025.02.27.10.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 10:23:12 -0800 (PST)
Message-ID: <e7497816-1c15-407c-913d-4979edd11d6f@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 10:23:12 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: please use tree tags in patches
To: Johannes Berg <johannes@sipsolutions.net>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ec3a3d891acfe5ed8763271a1df4151d75daf25f.camel@sipsolutions.net>
 <a5451ef8e9534ed4b2223f50c3ddda14@realtek.com>
 <eab28c11ea4cc4249c01557121b4741e19cf6a83.camel@sipsolutions.net>
 <d361db20975c8f2c88df6c0c11db963f6aaaaf02.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d361db20975c8f2c88df6c0c11db963f6aaaaf02.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -Tz_WUscArqsase0qcDm504oqdgp9eVE
X-Proofpoint-GUID: -Tz_WUscArqsase0qcDm504oqdgp9eVE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=981
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270136

On 2/24/2025 3:15 AM, Johannes Berg wrote:
> On Mon, 2025-02-24 at 10:33 +0100, Johannes Berg wrote:
>> On Mon, 2025-02-24 at 01:18 +0000, Ping-Ke Shih wrote:
>>>
>>>
>>> Thanks for the automation. I think it will be very useful for me to detect
>>> patch errors earlier, so submitters can fix problems earlier before I'm
>>> trying to merge. 
>>
>> Hopefully. Right now we still need to get the [PATCH rtw] tags into the
>> patches before. Perhaps we can auto-detect somehow later.
>>
> 
> FWIW I'm running this now:
> https://github.com/jmberg/nipa/tree/configurable-list-wifi
> 
> In case anyone wants to take a look and/or help out with the tree
> detection.

Probably related, can you check:
https://patchwork.kernel.org/project/linux-wireless/patch/20250226113118.7626-1-quic_lingbok@quicinc.com/

This uses the "ath-next" tag but triggered:
jmberg/fixes_present	fail	Series targets non-next tree, but doesn't contain any Fixes tags

