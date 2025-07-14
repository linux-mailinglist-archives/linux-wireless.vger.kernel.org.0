Return-Path: <linux-wireless+bounces-25400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11140B0473A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 20:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E975167734
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 18:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BCE272816;
	Mon, 14 Jul 2025 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVJFZG+B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4A271478
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516583; cv=none; b=psPTyvf1tvZS2b/s9COsHO3teaxDcZZ4f4febxltilR6FiS+pT6xzvnW+9oEq6LwDuEnAzg/oFddiC9CcwXxocXWhMmrr+i8w8s7b1QsQde/yboeQgfANIJSiC7czorL5EVaRZ5grjjoL7SDf43pP8tTagY1FECcWnUM/D7lTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516583; c=relaxed/simple;
	bh=WsaWmaegmJOBuzrButycOEhIwHgX6JJZYWmvfJkZj/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ma0YCrDC5+vivJOAhNHKmAZ/QzMRYN7k8QtSmJvcJWAgBgFz9URIhDBXr0bW6wU2hcyTUBdxgBvm4Avq1tYO/7xrxY0BliUJwIUFjkWzobjS5B1UbQbXeBQfj91cbDHRb3TMwjDq4aHmflqENweYqLSD+WWpmFnK9wIgTEsuihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVJFZG+B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGSG8G021381
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 18:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kFbISeN0ohGUXeUcsSpHboAG15E9IOEo2muJrWYerQ4=; b=jVJFZG+Bx9TvUuzA
	HcW1vIGzlMNI5EN39Gi+w43yyVk8K9pEqzlKDF7F3IbJ0d/O5rAeqx2r5YeQ6UoV
	nBwsdnatjOGUONO5ANp//iSEfi3tdD8+i10N3z8lVAafTBamdIzpP1hpc+aDz3G8
	X1Sw7S/rrJPDCVo33wx24K4h/6u/xWVEQBG5jf3REymwwu2IUZBa7sUU41zk4MwD
	+Ai3re+1JpcwP4G2xSc5vBfTMUCbYywvPwyoRYmfDarSQp8gw9UBBEruxNSqX9Me
	+E54+GYiWe0IpCUfzVFo4QL0c4P+6ws1McjK5HjRFFFrNbT2aa80goUTeel6zhuI
	RwjPOw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dw09ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 18:09:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23507382e64so47238395ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 11:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516580; x=1753121380;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFbISeN0ohGUXeUcsSpHboAG15E9IOEo2muJrWYerQ4=;
        b=ISeynLmrjrC7EzrQM2op6lNhgJztJII/BXOAAEi32Arw/iJ5UuUoaDGY7bTVizuVBi
         93yxuyfS9yJKJnz5Z1RMbRoP6kK7tUwXwyDgWN0TFxOxyqhH8T1TvDeGHJjxbVfQSIfU
         varFsI6i0frY+5m/v606Aplbs1gOY6fRqZwMAPBfl7tAX4+IeeCpE/R/YOuqhYlh6cD1
         h4L5KV0eDVbK5kOlsnsQ7+o6ajNg4vplVQJc6/MlDHEVnRvOiZGL//4GIIAQP4Z3QieL
         5WOfTplDlCzzDcr+MGGqFFOE547uRSVtf0rWsKw5P9AofPufQ/3thJZBdbw0BR2cXqiu
         qnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwWFn5hNAIpzdtGfD6SygCRNi5zNnq8j9UAx2KgGxqxI8pN1jP9CvNGDpnuzGM+4iu14PN5uxTquJmLFUd7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrRTXaH3WGoOi4u8a5Wuh0mKjpTVZmqpefd9P23fgIQetTASeV
	RSf6Qk951S76jt1MzRWP6a8cjq4YmEw2xvVC1+YAM4FQX6aJVpKUuc/Ke6RIqIhyx+2aP1F4agm
	L5DltI7HSezRv31F08WizvGlYn6fhonu+DQJQng571wcvaKz72lr+ZBpu14YWhBlEGD7lHQ==
X-Gm-Gg: ASbGncsY3JEjkKLAwkvIfBj4i7HU1+k20Nz1cgnm3cX9t0F523Bu/i8GixQ9Cbq0+yC
	8HsFSEDxTTCUtuBpGg9FwGfHlCM0q6piJ3klo9CUhkxUKT6/Frrb0soPKu2lhWydwTzuZzCy/u4
	O8T+R7/nC3QfaOBIO8Q343+FV5YrvYcKGmucoL5+s3E5EPwHS1Fk9yN91ALVZ5UsNkh+D67+VCh
	PpV0yLVy5b7vOd4adYni/jIgCYtGLp4M6aRQf7SMZ0y89SFI7CiyXZQ39cg2YXdw7M9ahJJCnP0
	8RNFPHN69YPKtFJJIsd8/npTBPad2E0QtseqxF5EPY5rDuDHmzlg+xzd1SzflHeo445KvQICwlD
	0n+0JC8htzUP0LTk9CKs=
X-Received: by 2002:a17:903:2c8:b0:234:9375:e081 with SMTP id d9443c01a7336-23dee28fca7mr188893325ad.42.1752516580251;
        Mon, 14 Jul 2025 11:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlrVJWOBDRvGbBSjF25XzVNgGrlOj935taOAHhzqu22n2fpLGzjDIzZGTjZuXNECU08IYR/g==
X-Received: by 2002:a17:903:2c8:b0:234:9375:e081 with SMTP id d9443c01a7336-23dee28fca7mr188892995ad.42.1752516579769;
        Mon, 14 Jul 2025 11:09:39 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4333e6csm100580675ad.162.2025.07.14.11.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 11:09:38 -0700 (PDT)
Message-ID: <87d96834-0b29-4282-8538-fc53551824e8@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 11:09:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: cfg80211/mac80211: remove wrong scan
 request n_channels
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Haoyu Li <lihaoyu499@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
References: <20250714142405.02beff564ba8.I25dd7af47f5dab3b560dec7b33cdaf49c3a4418f@changeid>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250714142405.02beff564ba8.I25dd7af47f5dab3b560dec7b33cdaf49c3a4418f@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2BfRC7_WT0DtV2tIHWhOa3Az1qKQg4wp
X-Proofpoint-ORIG-GUID: 2BfRC7_WT0DtV2tIHWhOa3Az1qKQg4wp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExNSBTYWx0ZWRfX6vf1UVmchXOo
 p1tbmdJiLDd9AU5bWTFTwAL43Irq/RLA5Cgj6LFnYEIJIqWSnuBv48hpOgjvsthLyA3oW2hKDni
 wY3pwtpF0gHQeOuXlQdrgH8G6tBmOSpCu8iAP0UmJAhiOK6+E8vXDwvrq0ByNFKjcjxerV8AmXf
 FAk8rupSwhvcI6zy7ijqmdfct0FBij3nV6wojatSTVykxYBlTmhvHvAOtkVHvS0shO872wQqG9p
 Mi9jCFGIfjxOQ0hkQcJPhAbMjbOcaAOEkWVybdMJL7Oxyk4Iu0QikfzH5fLkQlOyvuRGUABzzt9
 dVqXo5J4eUEDo4TF+901gPlXhrSId4xRpNcS1aveZBJQ/7k3G8H5d67I320ANtI0LI6f25Z/j2U
 bzTatQaaerJRJPOL1gdgYZsCzTXoBBP/hoE0r9SUXy9ijw4lROiZxD6oiQVKJhH6CGpIZA8P
X-Authority-Analysis: v=2.4 cv=CJQqXQrD c=1 sm=1 tr=0 ts=687547e5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=kRP92PEwoq-KMulAjFkA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140115

On 7/14/2025 5:24 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This (partially) reverts commits
>  - 838c7b8f1f27 ("wifi: nl80211: Avoid address calculations via out of bounds array indexing")
>  - f1d3334d604c ("wifi: cfg80211: sme: init n_channels before channels[] access")
>  - 82bbe02b2500 ("wifi: mac80211: Set n_channels after allocating struct cfg80211_scan_request")
> 
> These commits all set the structure to be in an inconsistent
> state, setting n_channels to some value before them actually
> being filled in. That's fine for what the code does now, but
> with the removal of __counted_by() it's no longer needed and
> it does leave a bit of a landmine there since breaking out of
> some code to send the scan or something would leave it wrong.

Perhaps also refer to:
<https://lore.kernel.org/all/20250714142130.9b0bbb7e1f07.I09112ccde72d445e11348fc2bef68942cb2ffc94@changeid/>

Since (as of now) __counted_by() is still there in wireless-next

> 
> Remove the now superfluous n_channels settings.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/mac80211/main.c    | 1 -
>  net/wireless/nl80211.c | 1 -
>  net/wireless/sme.c     | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index 6b6de43d9420..2a7587955127 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -1359,7 +1359,6 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>  				      GFP_KERNEL);
>  	if (!local->int_scan_req)
>  		return -ENOMEM;
> -	local->int_scan_req->n_channels = channels;

so i'm looking at how int_scan_req is used.
is there ever a possibility that at the time it is used that the underlying
wiphy information may have changed such that the number of channels trying to
be filled exceed the number calculated and allocated in this function?
just want to make sure there isn't a reason to keep track of the allocation
size somewhere.


