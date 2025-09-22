Return-Path: <linux-wireless+bounces-27582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA53CB90236
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 12:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FADE7A672E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C972FF15D;
	Mon, 22 Sep 2025 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Juit/85/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3D3009C4
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537437; cv=none; b=C0ICVj4g86iUvc8HYWO0TgdIPRGW16F9IfkP6WQ0o7s9s88IKmJbL5XyFMOI4DLt7WzNsVa/mlK8rY4FQiMqI19H9CqsY60FH8KmoUAkkJM5CGn49yHEIvlAXW6/aGD9N0lvut1MQ9/mF2gHjVC8ycCiw8b3DWoV15CINj4FY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537437; c=relaxed/simple;
	bh=cfSVPF6lkLPU7ZiW9Bu/6aAGtyRRNExRiSik7JwfSFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7c4kjWrgIUVfdF3SMG+hHOC+/NpNfJ07CiQGn3bUOtoFXR/852D/lTQ46sT6kTp/QJt6V+ZU8xg5QBLKsZdLEnTKGtkEE5UWG9fRQ095F4itTaw+lOPa3KBinqS/RfTO2dqjBT/7NhrCpMXVvLTYn1uGTUwQvpKUKpjUpoR+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Juit/85/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8nJ7s018943
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 10:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3mRZTjL9CNSBmFci645MvcJjh64mcxXuziqCwozX+OA=; b=Juit/85/N8GzNdhu
	nkYqMh6RwKFWqhigRwb1uLYia0HWNiDDIMamC6jhMG8b1WJUknRWBD1Fa9dKAAsQ
	8HC4ndf5Ruw4ArKnjBw1aXIgH1Qh3ySMfKAep3GaUcm1F4tRyKSaaPMmpmQ03HSf
	cg1aaZ/NZCJ9v1dT+4fXfq6sBdacGO6CloAAciUHJkC3up4UBr9MOriFn6eC0cmO
	zLWP4djqgs7BwusVL204Dkv84JpAEgtUlWAs57t9wo7py1lp/di73Xvt3VsAD4Lb
	mE5u+oh8nt5KfvAeuK/xmiJUP8tW6K8oBm9i+MbjEjvMHRBEOhm1mLx4L8h5ULaG
	9xyuJA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k7svhx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 10:37:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24456ebed7bso52157765ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 03:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758537434; x=1759142234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mRZTjL9CNSBmFci645MvcJjh64mcxXuziqCwozX+OA=;
        b=oy5jVZfuQEbeZ7r2Sl2dj6YlovE/NarwEYG074kdLOj3IpkCqjFbXPlaKzjCmNNyXa
         1CxdxziiRsJRz+Wsne+FvMM23/P1ZNAv/2vUrGm9Zj5WRb0sJC372MmTfTbUIiC+wr7e
         3EkGAJxvG0QsiMuz7sBAkb+cVXyRJHfhze6V0udY/dpBiU83gzPsZGlQXry2Zn7EcY5m
         HvJO914+0TyUk5KzD9HAFu6aoImwrTlReyTlkLkTezRCO9PcZgVaDgk06B8CBOcG58lv
         Z6Ogt4iD/fpTA0V0/1CGL2oVURgGmfFqAqVPAH5XaZgTfGR1/iHzXvWIxBQEGwp1w5nj
         b/ew==
X-Forwarded-Encrypted: i=1; AJvYcCVtPAmEdEsbLC4cBpmJuN55PBJduyjDXjEnjGJ7qtWWA6sQMOFsaJVZYlfJxnfDyycM2XshFje8Bh1Wueq4Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgqqP8YVom6NTjK+cHKJc5SiH0UbEy7phiPgti/YWuqNKqiTxs
	mHZ0J8Gt2U2IN1FKtq/M46YSunyEd7tm5o8SymuJ9LSDZ72qaJD2j41CZaq9cbbH7eHSxMtAAsB
	mNuQ/HuglAegY1YlUhRkjui7nvVwfH895J+Mqqd1buQFWbPQ0L0AQDAPRbE/drvsznb0xY/0Yvu
	4Vvg==
X-Gm-Gg: ASbGncv6TCj4NzlMcGrsq6fjmF+7Qt6ckuD4pEK6psF5wKYTbToH9/lM4dj6y2cxivR
	YgAz+6GNI2yQVarEPYAQzT0BN0nBLFlPGTlxxNeFbjV+X1LOy3P65NvNFXncTYo/zmbsft8eBCB
	sMaFhb8nM/myK/Gfy952BBVflZlJJqI7SM3d1HDOPnmBbsV4rNxRWkUYdylokBFdy+ZDcdHxUWM
	uJZGEGK+74TQErYqpJfsw5SB1HEftGkVHlD6QaSPnZpLMOb31j24yyg0PAN0CXsmPlax815PzjN
	dSb2ZHwgNuB/ok8bvQwlXH1HdpFyjcd0omV2AfH3oVMmWurrwWlV3eFOm9m2/4pJszRm3aM9Djs
	qlQ==
X-Received: by 2002:a17:903:298c:b0:267:44e6:11d6 with SMTP id d9443c01a7336-269b755bdcdmr165506585ad.6.1758537434525;
        Mon, 22 Sep 2025 03:37:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvcWulNg9Fj6/yWP0trbjkyuvTBxtJhrOwOY+wpV2j7uSi59HnUGyIfFBK0KLrGNwikmeEuA==
X-Received: by 2002:a17:903:298c:b0:267:44e6:11d6 with SMTP id d9443c01a7336-269b755bdcdmr165506185ad.6.1758537433964;
        Mon, 22 Sep 2025 03:37:13 -0700 (PDT)
Received: from [10.152.203.89] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802deb3dsm128985645ad.93.2025.09.22.03.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:37:13 -0700 (PDT)
Message-ID: <4689a1a9-c37b-46cd-baf8-9e5fed06764a@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 16:07:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/2] wifi: cfg80211: extend link support for
 stop iface handler
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org
References: <20250922-stop_iface-split-v1-0-087403cea9f7@qti.qualcomm.com>
 <20250922-stop_iface-split-v1-1-087403cea9f7@qti.qualcomm.com>
 <35fe10f3adaaeaf667e9f95931319fb6d1954a0c.camel@sipsolutions.net>
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
In-Reply-To: <35fe10f3adaaeaf667e9f95931319fb6d1954a0c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX56FA2jJGJ8hQ
 wln0rc+DfVGRY//IHm7k/9PhLxDHxA4cewaVAyFM/lV80m030UvRtntr1RmwEpSK0q1Y53+D5/J
 ZVlwhydReF457x6nFoxIdlihDCiT1/yP2gicS8ZZpScnHRRfjYYm15OtMhIyYmIxOEEKlsXvsrV
 wcvL94KHX73hlGxUccXeGJMJxzbrwMcbFqtC70fAtetnR+WlWsXczUn9e9i0OO7wMBoEZbWwaiu
 EbPXdYUBhAikgPYAC2Mb0Yw4YQUYG5KX8hd6NFssbjBVN5mNi9tbtZKTL8OXR4bUqffmejmALbw
 JYsXOWeTBLCieXDr4mC+dQEAnIadfBbuoikZ9enMuA4NQTncPnW3/sVGdqIKo2whYnad0HzHp45
 HYK5kCHD
X-Proofpoint-ORIG-GUID: xZ4NLd1xnsvc9t6FLa7meforb3bxZ_AK
X-Authority-Analysis: v=2.4 cv=bvpMBFai c=1 sm=1 tr=0 ts=68d126db cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=P6100GRzAtort1aoOjgA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: xZ4NLd1xnsvc9t6FLa7meforb3bxZ_AK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018



On 9/22/2025 12:30 PM, Johannes Berg wrote:
> On Mon, 2025-09-22 at 10:54 +0530, Manish Dharanenthiran wrote:
>>
>> +++ b/include/net/cfg80211.h
>> @@ -9559,15 +9559,19 @@ int cfg80211_get_radio_idx_by_chan(struct wiphy *wiphy,
>>    *
>>    * @wiphy: the wiphy
>>    * @wdev: wireless device
>> + * @link_id: valid link ID in case of MLO AP/P2P_GO Operation or else -1
>>    * @gfp: context flags
>>    *
>>    * Trigger interface to be stopped as if AP was stopped, IBSS/mesh left, STA
>>    * disconnected.
>> + * In case of AP/P2P_GO types, if link_id is passed, it would only stop that
>> + * link on the iface alone. If need to stop the whole iface, -1 should be
>> + * passed.
>>    *
>>    * Note: This doesn't need any locks and is asynchronous.
>>    */
>>   void cfg80211_stop_iface(struct wiphy *wiphy, struct wireless_dev *wdev,
>> -			 gfp_t gfp);
>> +			 int link_id, gfp_t gfp);
> 
> I think the naming (and touching all drivers) here is awful. Much better
> would be to make a new cfg80211_stop_link() or so, pass -1 there to mean
> the whole interface, and have cfg80211_stop_iface() be an inline that
> always passes -1? In one fell swoop you get better naming and not
> touching all drivers.
> 
> johannes

Sure Johannes, will introduce a new API as mentioned and re-spin a new 
version.

Regards
Manish Dharanenthiran

