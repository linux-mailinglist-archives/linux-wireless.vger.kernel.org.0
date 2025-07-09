Return-Path: <linux-wireless+bounces-25019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1A1AFDDA7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 04:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2719482F9A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 02:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F2B1D516F;
	Wed,  9 Jul 2025 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cuY2EPFY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F392AD2C
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 02:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029248; cv=none; b=SC4uHfIzT5Si9g+oBf4i9t2tNaza0nROsuZNmGl2MphST1y8wK1q65UAApzJUnniVnksw9aOumyvJJv0/r/wm8oVdkLF2YLICmYDF5sstnbBmDcKT4ETU2QqGwhLI0ewtczDld5UPVPvOAq/rUDHxspTNZkQrvoj2UlzR3gRJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029248; c=relaxed/simple;
	bh=JgjFV8ttalnLWfax5cAC90o1K+OVxDfN9tj9+H+BGBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptVIbGZIFEBESzbG/AAYox1FekB+OWrwf7XSmhlkJG+//POFC+FBpsGYg1JEa59SPU+PdkQ3SmMsH5Vby5uPUSwRAdegpISefP8hooN2zG0hi5QflD4P5Kn1M6wlFvmEVazH7E5A8mYh2b9cMKTbnnfv1eyyk4st5pXLhAqoqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cuY2EPFY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568MwFDV031658
	for <linux-wireless@vger.kernel.org>; Wed, 9 Jul 2025 02:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nQ/DF0j8qjp6KjrDbYkX903lF1T/sv5VpjC/UZ0thFQ=; b=cuY2EPFYWDKn49QG
	Up3kEHogbSBHV65Ol+DbOuy3c0lvJaa42VMjpZvE1Cw2yJNN9If+AEMthrGUBHl9
	CMJYEtEXIEeAMnTEq+NN10sB0WK4BnFdYS4xu/8J45blOC/+1T75cK82+Pk+NtgF
	XXeUo2qAkD9SkisJkGWNOU0y2mdQbDDKKbWBK2m4PDwdR/E9EIt5C6Usdv0Y+b97
	htNn0stvN9n3mavg05iUQ566WxNW0wBEWPKUns9K1rEy6xa/h81d5FoJcfr4IwiA
	TNj7G4Bcfunb0A+TRalZAebr0aN32KO9F5286RkoKwwPuam7SRrduuBkvMjObDh7
	PKWAqA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn2vej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Jul 2025 02:47:25 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74913385dd8so6870506b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 19:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029244; x=1752634044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQ/DF0j8qjp6KjrDbYkX903lF1T/sv5VpjC/UZ0thFQ=;
        b=HPAK97Lv/RWDYfzmyuV21fdj54FjmlpzyA6aO/wNg21e+xL/NsSlNhbspDvgJFqrL5
         lGp4Km8WNPY6AJ0eEHah3DwyGnjuZR2kjltaLjp0PTWF3iK2E0RPxRusZFypL6xQSB4N
         Gy99cVM9i8TzJRnwXtxhdUBPwrFpkR9bpQHt5h6EiWs9sYvU7NonEg0oCGk4GrB1uRgA
         XyBJ7ykh7xsliot1Z9TGryS7s6cRPImALW192m9vNfRiqZm9nWmodwPbn6PHdCbZaVuu
         hFswm6lYvDfmS1fWbXWT3zNtxyQ6zzehKX5/rj8cpB0r8fUgRNj6+gHcquwRvyvr+BCr
         ENFg==
X-Gm-Message-State: AOJu0YyfhEV6+ihf2oCCtWzySVK0QXSiWz1YsSAw3gUjHe5gKl1iRCuG
	EPUGhnrSBfm3aFKSl6dJZO5O18UZYF3LmwL03qJPEhJbcc1TYY+yUWYwphDXZK6sNSZdtCNq3wQ
	3nKWbfd4SCH9DWzCL+9sVFKO1SDQvjBWWlYOyY9b5IP2m2QyHM6N5GFPNVq0Cg4YIhnzOPQ==
X-Gm-Gg: ASbGnctUe9gbtw0IbhL9kwdNHJoJz8hzqJvNXQW/IdbivXI6Qv/Z+7n5zxmrjLCFIJf
	px3lvY8aBpAr2Mad/wJn8xYuqVChs1+slVPqcxi4ZehoXwp/jLHecT3xdn0BAkRUQnr2uJKZ9EW
	QzIVjh+gaRFpOZZs9vNuyyAS9f6FJp+I2HJgtUHs1ESaYOmvnYqBQbfcJmnrq1wGAEXi+j0Jfvd
	zb3Rg4jpv/yNG2pM0N9vhJx6CKr5KKIFZNdL0zy07/iTM5hn074AhtfBXAHP3YvC1rAgm8S5YFK
	HcJuATjSUQGlmqxVQVdGZOslzo72fmk1V3k6pBzih9UWrZWN6ioHigdDqQ9xYQ==
X-Received: by 2002:a05:6a00:c84:b0:748:eb38:8830 with SMTP id d2e1a72fcca58-74ea6652bb4mr1477307b3a.13.1752029244451;
        Tue, 08 Jul 2025 19:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4f2L3r+oNT/avXH/4ZfezYoJMBm/VekozQ6XrcYIynsKjsadJJ4UbsxMUYMB1n2pUGbU6Zw==
X-Received: by 2002:a05:6a00:c84:b0:748:eb38:8830 with SMTP id d2e1a72fcca58-74ea6652bb4mr1477281b3a.13.1752029243986;
        Tue, 08 Jul 2025 19:47:23 -0700 (PDT)
Received: from [192.168.29.88] ([49.37.212.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce43d4f1asm12802173b3a.161.2025.07.08.19.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 19:47:23 -0700 (PDT)
Message-ID: <114409da-5d1e-40ed-aa8e-3bcb769ac0a1@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 08:17:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3] wifi: mac80211: consider links for
 validating SCAN_FLAG_AP in scan request during MLO
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-fix_scan_ap_flag_requirement_during_mlo-v3-1-dca408b10ba4@oss.qualcomm.com>
 <f5148f63e6f96fd18558dbb7f49d090aec931745.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <f5148f63e6f96fd18558dbb7f49d090aec931745.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686dd83d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=mPedDPIPg4NzqpvR87qMnA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=4ctZDmFpGKd6Wb6K1JoA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 4N2bD7mWCAXWvT7L8ama-bRL1m0u_xD8
X-Proofpoint-ORIG-GUID: 4N2bD7mWCAXWvT7L8ama-bRL1m0u_xD8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDAyNCBTYWx0ZWRfXwcBhJf/d0MFb
 BpD0ZbkGhM8+H4Mx4II7l87C85WOHE0Q3aOLCwh1/HNN1bbgCeZBRbnexatN3+khcSSrZHZsdUY
 GU5NvfOKvQPPgPDVQqgM2q49hJzmx9Z1JYBDJWjFJe42FZ0T/S1eqIs5BExRe4AijmJT58vwXg5
 B79Wj4aRIHSNWe3+whcZMvJRHqx7WD3KgaqG6RDKX00Uwll3WqDblxYvy8JATsWEbgqJRqfHddj
 IzRSOWYD1JF1AMBYAhcCuMh1f1JFLkkU87EsiBv9D+X107XPNBvDxAVPN/rBJsGfIeSw6OWKMV9
 uPvmI5K0l6cI2/WNfrRx1gQxCLRBH7Ls1qumTYqlkFbaPvDLTPli/JgTm5XhBa0syFjX6HW5TV+
 P4vg614E4i1H25TWuw4iG4MoGXabMsG2Oz4vQaQEDS1U36R9DnaMtoG98OWHY5noB+U6e8qk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090024

On 7/8/2025 4:16 PM, Johannes Berg wrote:
> On Wed, 2025-06-25 at 18:31 +0530, Aditya Kumar Singh wrote:
>>
>> -		if (ieee80211_num_beaconing_links(sdata) &&
>> -		    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
>> -		     !(req->flags & NL80211_SCAN_FLAG_AP)))
>> -			return -EOPNOTSUPP;
>> +		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
>> +		     link_id++) {
>> +			link = sdata_dereference(sdata->link[link_id], sdata);
>> +			if (!link)
>> +				continue;
> 
> for_each_link_data()

Sure. When I was writing this, this macro was not present hence did not 
use it. Now that it is there, I will use it. Thanks for pointing it out.

> 
>> +
>> +			/* if the link is not beaconing, ignore it */
>> +			if (!sdata_dereference(link->u.ap.beacon, sdata))
>> +				continue;
>> +
>> +			/* If we are here then at least one of the link is
>> +			 * beaconing and since radio level information is
>> +			 * not present or single underlying radio is present,
>> +			 * no point in checking further and hence return if
>> +			 * flag requirements are not met.
>> +			 */
>> +			if (wiphy->n_radio < 2) {
>> +				if (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
>> +				    !(req->flags & NL80211_SCAN_FLAG_AP))
>> +					return -EOPNOTSUPP;
>> +
>> +				continue;
>> +			}
> 
> Is that _really_ worth special-casing in the scan control path? It's not
> like this is a performance question here.
> 
> Maybe ieee80211_is_radio_idx_in_scan_req() shouldn't WARN_ON() then or
> something, so we can reuse it. Or maybe (better?) just reorder the
> checks there, if the chan_radio_idx==-1 and radio_idx==-1 would return
> first, and WARN only if we found a scan channel that isn't covered by a
> radio?

sure reordering seems much better. Thanks for the suggestion, will change.

> 
> And <2 seems really strange anyway, ==1 should basically never happen,
> it's equivalent to ==0, as in no list of radios?

That is correct. If underlying wiphy does not advertise, it would be 0. 
And if it advertises, ideally it should be 2 or more (otherwise why 
advertising?) But, there is no check for 1. So a radio can choose to 
advertise but keep n_radios as 1. And having n_radio 1 is also same as 
not advertising it. Hence to ensure these kicks in only when we know 
n_radios is greater than 1, < 2 is checked. Same way other two places 
also it is used.


-- 
Aditya

