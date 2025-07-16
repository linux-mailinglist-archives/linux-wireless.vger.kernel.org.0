Return-Path: <linux-wireless+bounces-25550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD164B07BE0
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F6BA419C9
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650832F5C39;
	Wed, 16 Jul 2025 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPR9P7Vn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C359B277030
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686306; cv=none; b=QUofSeWxgFOJ6ez93MXGdayBIdSEF31rzbcXVbJrAHIJFvQrVkRChGwEAch+qV8unVFPboe0zvUUP8HTJ+p5D7rppoH5ogFblXp6C8aATs8i8iJNnAHaPjSDJGvTtl7R37Y/m2yEa0EOhhQUsKcy9cLdY+2B40RSJwNgfvBA/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686306; c=relaxed/simple;
	bh=6RzJT1L60GvhmajeO4pYpV61WuPIfNveFy1ljekZwUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjKCBMMBofSmWKqiSIW5P1tNCNyRg81qiuRRPYLX3Sb+09HCicMNMnK1L603P8Te4JZwXZnb6QbP/o4eoox7FKu3IrGfkHFYzmViTa80MXBxHGzKBl5jbPJXTTPoozYwZ448NJV5vzmHEfaMLpCJLN82i7d0se9Gd9Ooz6hC+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPR9P7Vn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGDbff016003
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 17:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/tMth6o7tHgbIUQxZkR6tUZ2rv+sepU1UeAb/Pu8vhE=; b=hPR9P7VnD6Vfboen
	Oe0xd1Hbb1CL+U8J8zbXW/1QCBNPzds+NcaxleI45fPoewHe81S+KWfBgRSizcxH
	h31zRd6dXlLR/y9Rm/X9XG/mF4YAC/sj3YFRp+4p+vjNhp18YNzx9bvF/iqPnMik
	Ir3mQBdU6YFs+8JXvPZAJCglt7cY6IpMy45ButNyHot1hj5ldKfMLXbg+MgBIb0b
	DQClV5cw5FosXR/mwchmdNA7PYTmjwNIrr/QfJpOvPxBKe/Ib1TYRrOc9CJkkh6b
	Hm10V8eIPtpcTZxaskQCLL6LZV6yWsvU9cpzQiy2qpR94snWFQAbWNSOm1kKJAoe
	9cxjfw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyqrn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 17:18:23 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748e6457567so776885b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 10:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752686303; x=1753291103;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/tMth6o7tHgbIUQxZkR6tUZ2rv+sepU1UeAb/Pu8vhE=;
        b=oCx5nb1kawvM6hdSoT5oUXp8NbnJ69B9iJG92RRwUrfpdY6ttb5Ak8jSVVH+ht10DP
         5Vo68rP6BNiW/GhPu+o7t4gILUJFFOmnm2twULiksSLZY4FQURDqu1HgCmgVPdM0k54u
         DPpKIYwhPV7YTcwXpbLi3qSRo/1fZrwDA0zevoV22s4rWjHMXqZGtynugVtVgKGS+jwb
         7QVANnm4Pe2z2coESYqVFOtOv8tY6kBhXCsieIU/8awZ8rW3UT8B2+EOQgUpq1I1FKk+
         7SiqlKFCAEbdB+GJzeJ8+MWFYmSYjpAXoEyoCrGCa5qUKErVY1CqlULdZM+RIJq55SSm
         6IqQ==
X-Gm-Message-State: AOJu0Yxn1dPHmjL6/YaV/KCUBqkJfEriVNQ6Cl8cpQgegIiiRUK0RSfg
	qIshdlpqjoUtPMr4QK8/NTHxbDMlYwQWxsKCO/MRAyPjruNj/yV/wBAL4mPgKt2oaRz7jHblLSI
	r5PMc2YjIlvtUIoZn0DH+8FEGoPJ3x/rOqTm5uKU3n4crZLgppCHI7McdA+5cmYG/SeFxTw==
X-Gm-Gg: ASbGncsAxjMlJZXc0FDB9HOtq/22ahZqQVsYAfujERIRW7qsoImfLbP0yrLkAU4UcSe
	WeFUVtd1JGtQSkn7wBiGWGm2dpPtrS5T8OWLlhdnbsB8Jj0gNy2LDGkLmpoLkgXP5ZaD+fRyAWo
	EQMGSPC2w/ANz2d2IUrst6nwXwMPSBXjLcNY+S07A/Kw3Z2RokXD1nSl1cj2PPRk9ydoZH4kiSC
	w+1Y8c6udjNyx6Pq6xBZLFVvGW6yI5tQrjfOVjeuoMCE9fXU9K8AIphcLdQTxoM2XLZfV4it2bA
	VwPLFjN2nXfFBkNq8O2cm61oec6p41gaTafzoAMJdtoIDeOlZTwS6EZKT0+o4ZBAAzphF1Toe9s
	bJ6OfXisVNmkR3fK72ac=
X-Received: by 2002:a05:6a20:1584:b0:234:e109:6bdf with SMTP id adf61e73a8af0-2390c56e8bbmr294958637.19.1752686303070;
        Wed, 16 Jul 2025 10:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF56y5nV1rAeM2TuaaRxByMhD0eKi4TFlVWOHGMOxWKdeVyu82Dt3msTx7dIP/gme5crNDFgg==
X-Received: by 2002:a05:6a20:1584:b0:234:e109:6bdf with SMTP id adf61e73a8af0-2390c56e8bbmr294908637.19.1752686302511;
        Wed, 16 Jul 2025 10:18:22 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe345f2esm13991621a12.0.2025.07.16.10.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 10:18:22 -0700 (PDT)
Message-ID: <3dc23475-1c16-435b-9c6d-d2d7996280c4@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 10:18:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
To: Johannes Berg <johannes@sipsolutions.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>
Cc: Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
References: <20250716135252.51125baa@canb.auug.org.au>
 <4ee6758a49e6f01c5e42b2f7c27aff905ac07dfa.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4ee6758a49e6f01c5e42b2f7c27aff905ac07dfa.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oJ6MgmzJSAhzu76C5fZ8ueGrARKMpSjO
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=6877dee0 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=ULWNt2tdzX7OOLHh:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=Swg7eHfTgBCftI4JXWkA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1NSBTYWx0ZWRfXyALH32adTRqT
 otrcDmC0GHhLgi8A1ALXEbud/X6x1WKtqhZlDg3rT1leOz2w9SWNkRTurR7hoOjtpRJd2fMrw0B
 7NQm6FT3/tgELu5UECNnSjrxaB23gjyMUxOJ/nGuGzFMhyZ4CVvNlA4f3/95BqN1dhHy7PtuktW
 +h91bf8fGL3lPhdAOLs4MBi0g2Aaq5ytqCy0H5kaTn1rvR1XNYzWFvJ0QdFdHJfsvMntccKDiRn
 gt6JjDk6/I2KJwjs+SKJmh+2V+hKW5LRKk7sugg1fRR+9turvrRY8RdNM3tlrSeFd1Jk+BXIhJV
 7flYTYZJagBrRvSoMu96DDu8LU9FU3vJ/764UnSRfDVGotta6wQ7z9pkDLnBVLnZ4UT16KveXzR
 7oiWXgeJWI5HFGzJ9eXITpAFd/7ducRRNZqDTdG2hvw6bBKC+x76t+OBkP9MOYb9T7ky+g5J
X-Proofpoint-GUID: oJ6MgmzJSAhzu76C5fZ8ueGrARKMpSjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160155

On 7/16/2025 1:59 AM, Johannes Berg wrote:
> On Wed, 2025-07-16 at 13:52 +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the wireless-next tree got conflicts in:
>>
>>   drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
>>   drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
>>
>> between commit:
>>
>>   5fde0fcbd760 ("wifi: iwlwifi: mask reserved bits in chan_state_active_bitmap")
>>
>> from the wireless tree and commit:
>>
>>   ea045a0de3b9 ("wifi: iwlwifi: add support for accepting raw DSM tables by firmware")
>>
>> from the wireless-next tree.
>>
> 
> Thanks for the heads-up.
> 
> I'll double-check, and give Jakub a heads-up, he's probably going to hit
> this, unless I defer the wireless-next pull request. We'll figure it
> out.

I'm planning on sending an ath PR for the 6.17 merge window early next week,
so I hope there will still be one more wireless-next PR.

/jeff

