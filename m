Return-Path: <linux-wireless+bounces-22905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22744AB52C6
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 12:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02814607C1
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905A31AA791;
	Tue, 13 May 2025 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WmBxnHpt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB74D1E1E1F
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132366; cv=none; b=q6U+Vx4stP6s50p2LZmvre2AQljzkjF8Hdu9e/YrAKyrgllK7RCJp+UfkMu490RkJGqH0TuKMU7o0HZ4eYmqXa/KMt3XI4o6MRPKYmyuqeRbaiJLckVIUWJk8gRbqiHCpcyLdIu6EytniRmmp6cT309V30/VhoA7lf/zr3d0QKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132366; c=relaxed/simple;
	bh=fIknUjS1XtgaI3FZc6s+eW+eel0rIdNdOXW6UlL7dvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZH7I3rs7VoYvDpRx0xISXaydrMkBB5xQuHoUzZ9cP7DVLFo3uOCdSotuQ9tvWucqCKKMDhpvD/Qbwim+dYo21tk6QVRVQGUZnwvbIMUM1Y1jeH4W3M4Iti+k/jT65LnQVmv4cwJNWTEtf4CeXsaGAAT/+D5tvZn/BgUEjtAbrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WmBxnHpt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D6h0Mc007509
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 10:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	80K8zTIHjvxTDtMVey7EZJVuLn/HDFfHo4duh3kKXh0=; b=WmBxnHptmujpeUke
	2ePNcF5gd15OziElRoBAPeq7se4WGaNvW1UKvNGgeEKTEM/OtLIlvm9B8+OjJXKy
	T12KiH3vAiiDY2WaGLQ12g65ELP6N/al7EvRdiguhzrOvLD9NUQY92XAoLirORGK
	ijuWOUIdGSGujWjjvQ4+HpRdMjaqfmKFBvnPZZd5KMO4y2TuiIf7z2zSi8BT7H+l
	PxfdrVTcWRyJilcwbqO06sc3YAdH1BMnxWjzDIQCuJiOFSw1Vl517SDiEXUnrnTl
	srSMwylMr4vN7NkCzGl7JEUPnJRjJGk0xPvF7oVBB37m5vd/oUkayPvP6yzaW5jZ
	qmJPJA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hv5qfpv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 10:32:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso3680220b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747132362; x=1747737162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80K8zTIHjvxTDtMVey7EZJVuLn/HDFfHo4duh3kKXh0=;
        b=D9QBgYJHsB1Xe4UetpGox8SGEc5/E9kOILXZRt6RIxZGdgmYntfz+Q/n1+k9Xoirjf
         weW14xQkwyOBCcnKp75Z75QK/nLjdkKtwCS5/7xRsPYxjJJAvH1OjDY6vdfkclUeeVvh
         F+WuGpPiyoCdfhAvzaSA9PPPvsiu3uuv35djpDIFuLkQhG5AvWkar8mMOYos+XYZiLGf
         PRhx4PACDDwowFHgBVCSt+VQ/syqJfTDG1kBqrbeAPhAjkVgGPLXdoE2hQBnsqDoV2hZ
         ThBJ5QdWvU3GpsXQDEpcauorrCvSNjaMWLVUYk6yZ2/kWq+c8LHerCXFcj1t7RyDvoZD
         /0OQ==
X-Gm-Message-State: AOJu0Yy7RY2W6lGR1dU9GByxu4o8kMnIEDErhnzHkJKWe8Lxwst7xdh0
	F9MMWYpeDLqZNFt8AvZ5HmujZ7aV1yVcGS4O/ra2iFPd3dDhCPm9ALnJuXH+aYuiVQz6CSU1vBf
	mKKfay92GrP/z7BTBauEBSd4cIIpTIVR6IGxXBaxiYsy8YjJcxIhYD7LmL9a6VgZnlA==
X-Gm-Gg: ASbGnctO9yLsgqHqY4mkPYj6oN+sOiMumygM4uaKphq0U0cMBN8lnHm/iVqdxDQY9D+
	cERS+82HfYrv1PY7a0sIXDTm+TybVSzDirCaJUPZura/FtfnzeFiYWge9dtuffLAZglcpCNU6zy
	wG26Qw6kziBkBtNweptQhTO4Ak3rbE8cb5kWfLYGQhp6O8No87vRRRHKBXonByvCrKb5T2Nhoxs
	uPHK5oVl397G+wW9H2GEh3SmoEs99ZaVsBsFMBbaFnEGH8dn3BTsB7GPX/P45383Sgmrj2ZgsKy
	p+csFgxUE4phhoX4NSAMozEI90zxteplC4Z/WtEU83CfoKU6eSU=
X-Received: by 2002:a05:6a00:3d13:b0:730:95a6:375f with SMTP id d2e1a72fcca58-7423ba80629mr25483061b3a.3.1747132361864;
        Tue, 13 May 2025 03:32:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVv5+BmuvzpUk6EEcXm3Jh57l9QOl/5KvtwXrYrZ/pE2KoGIXo6ZSBiWel7SIYlvXUC0O9mw==
X-Received: by 2002:a05:6a00:3d13:b0:730:95a6:375f with SMTP id d2e1a72fcca58-7423ba80629mr25483022b3a.3.1747132361418;
        Tue, 13 May 2025 03:32:41 -0700 (PDT)
Received: from [10.152.194.206] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742377046e8sm7785038b3a.11.2025.05.13.03.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 03:32:41 -0700 (PDT)
Message-ID: <77fe950d-c5af-4c28-8b0b-bd1aa08d885a@oss.qualcomm.com>
Date: Tue, 13 May 2025 16:02:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/2] wifi: mac80211: validate SCAN_FLAG_AP
 in scan request during MLO
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250513-bug_fix_mlo_scan-v1-0-94235bb42fbe@oss.qualcomm.com>
 <20250513-bug_fix_mlo_scan-v1-1-94235bb42fbe@oss.qualcomm.com>
 <16499ad8e4b060ee04c8a8b3615fe8952aa7b07b.camel@sipsolutions.net>
 <26a9e68d-bce6-4bba-871d-13e2aeee3fed@oss.qualcomm.com>
 <296b9aa887022258f8ec8e4f352822c24b41ab82.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <296b9aa887022258f8ec8e4f352822c24b41ab82.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DqtW+H/+ c=1 sm=1 tr=0 ts=68231fcb cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=vm-PoD7xXqttJQO6OBoA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: qF_BmafmYtK4yW-3nfgIFtKiL0-wbKr2
X-Proofpoint-GUID: qF_BmafmYtK4yW-3nfgIFtKiL0-wbKr2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEwMCBTYWx0ZWRfXzZi5AiFemq1C
 did/hOlKCgNaiM5BiE+0Y5EQbXjbknt5F7sJGMQbDOfoigZHZF/t8X/z/q88zSUS6NPD4XNnz9M
 GFWcUUW9o4TBnTxqUSYAWf9Sbx9CkoMH+9e5AoGuBVqhtt2rkm2/DcdVKQfjYF3MHLikfVbssSI
 qVf0/yQOBiD4KO8SWGV26gM1c3YklpClm8o/k7wDpjpc3hPJS4d/MSZEGbtqaM7Vilo9iEyJgWv
 UaUL1fYUD3937XZCJI1UTh9GmwtGlL+pO8yelytBVOpIC64ODhLqm8LBtf2Nqk8G5b6WBA5yJGr
 OajlWcx5sHVK925d+yPZHxNVqCGz+fXV/+OGm5IMfNWzmcf4anHT0acyf81lLVwENBkr6/NPFfr
 2Pj/ADaYvujsPXAMjCfFvHnLFzSJ/L/sWxFzGSh/E8GPR4lL4k1DYUta7uLTJQ93vPxE4CDn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505130100

On 5/13/2025 3:51 PM, Johannes Berg wrote:
> On Tue, 2025-05-13 at 15:47 +0530, Aditya Kumar Singh wrote:
>> On 5/13/2025 12:47 PM, Johannes Berg wrote:
>>> On Tue, 2025-05-13 at 09:26 +0530, Aditya Kumar Singh wrote:
>>>>
>>>> -		if (sdata->deflink.u.ap.beacon &&
>>>> +		if ((sdata->deflink.u.ap.beacon ||
>>>> +		     ieee80211_num_beaconing_links(sdata)) &&
>>>>
>>>
>>> Do we even still need the deflink check? Seems like
>>> num_beaconing_links() _should_ return 1 anyway even though it currently
>>> doesn't, and we need to fix that?
>>
>> If the ieee80211_num_beaconing_links() is modified then deflink check is
>> not required. Do you want to me to send a clean up for that function
>> first or would take this and later the clean up part?
> 
> Given that you're targeting wireless-next for all, I guess I'd prefer
> you clean up ieee80211_num_beaconing_links() first? But no strong
> preferences.

Okay sure let me first send a clean up. So, 
ieee80211_num_beaconing_links() should return 1 for non-MLO as well? And 
callers should test for == 1 instead of <= 1.

> 
>>> Also seems the VLAN carrier handling is broken.
>> With this patch? Or in general you are saying? HWSIM test cases seems to
>> be working fine for me with this series applied. May be there is no test
>> case to make it evident?
> 
> Oh, I meant in general.
> 
> So here I looked at callers of ieee80211_num_beaconing_links(), and many
> of them seemed wrong because it doesn't handle non-MLO? But now that I
> look again, I'm actually wrong, it simply always returns 0 for non-MLO,
> but the comparisons are for <=1 which makes that ... OK but unexpected I
> guess.
> 
> 
> But still - also unrelated to this patch - the VLAN handling here seems
> wrong?
> 
Yes VLAN handling with MLO is not handled with the change which brought 
this beaconing links API.

>          if (ieee80211_num_beaconing_links(sdata) <= 1)
>                  netif_carrier_on(dev);
> 
>          list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
>                  netif_carrier_on(vlan->dev);
> 
> Shouldn't that loop be inside the ieee80211_num_beaconing_links() if?
> Also on the netif_carrier_off() side? At least someone was fixing VLAN
> vs. MLO recently, so maybe that needs fixes too.
> 

Yes. MLO VLAN changes should handle this part. Since at this moment, 
code does not claim to support MLO VLAN fully. So change introducing the 
support should ideally handle it.

-- 
Aditya

