Return-Path: <linux-wireless+bounces-24159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93809ADB75E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BA93AE356
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11CA1A5BB7;
	Mon, 16 Jun 2025 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O0+UZaQn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837842BEFE1
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750092631; cv=none; b=Nv1bpRIxZJuZeX4qFO5cKxjIXP8B9gPNg0TqtI0stKkRCvZyWI4skm0R3YWfaxKJm4CUt0PC9BDBCFTmayjvY3lbTimVgWfp+FyHWBALvp/Sw+DWe5kmMF/8FE0vfqo2/sBR+JdjnMTVzbPJHDTYQNGy+k7YY8eOcMqb3HLNVVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750092631; c=relaxed/simple;
	bh=g4LcPSCfJEXY2f9iDywRrFGmCMNTG/T1SRkg2w/xGPk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=MrGggVf1T77rKNr7H1eDYvMM3w1XJje2l2Cyp5Wj/Ktl/N0ckgFW9KEJNVWPnq7KqQa32pMmeEmJAkckUu+oSlFq2gv7Ahn++2sARypAPR/YubJZEMg6wXHnIKSV4hF6YP0bYqjwuEaAcbj4FiS7qFV/OiM+f+hXmKENZkzOzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O0+UZaQn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G92Am9021241
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 16:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ttkh5ewa+kdHGZMwLsOc6xmWx13Y/X6YrIFUXygNYKY=; b=O0+UZaQn7iq5xM8V
	y3QwuYwNl4paXDfQjEoLyGcRfwPMp5sO9GqYb0MwzX989+bubmyCu8n7NavtTdxJ
	si4mi++dZt7D1fKIOjZmATtWn3Tqv57BOkKIMyFcYsE5x23IIc/oMWnh/BFE3z7X
	/kHIxGapsMeNagiAfH2qptSKTdSuAVA/k/dem5hGbkN2ikDbrhZP4uOx+y2sllZW
	Z5xKx2z42RXyszE05qK1kHtIZbcL18w7Eqbj78XLQEL8tdvOyxeDSY8i8D8h23LR
	eTJmA9qZSqPFvtHC5CNLHnBebz7LvWPmDy76dK8L1qReCAqCySqkpHXcLeFUUxj1
	4cRdvQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 479qp5kvsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 16:50:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235196dfc50so42375145ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750092629; x=1750697429;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttkh5ewa+kdHGZMwLsOc6xmWx13Y/X6YrIFUXygNYKY=;
        b=op3GGACN3u1c2Cq3bFePz6gf3qxZrnxCcdFaIoeNURjCPZG/GcY7KFKRM1sgLCd7kO
         IRuTlYEOjuzHYsnN0kcDfuRor5KrdvL3KBTUjltri2vZV2Uggc/Y0W13ccAXwJO1mJn6
         XTEunA0uh8GyMho72gUvD09FfPnLkNwxS3CPzYtvIss+0LnxyUHSocRyGufRwE2j/Ec4
         Hk/kMLfhRlxsTEFYf1YE6Y+Glohsrfwfo+v+0ncaQW6x0i4U5h/lDk47d6LqqN77iQKh
         HbxtzJ21yUuOrjo5KLxH6yr5aubpEJN6bi3F0TD4cPajdn9xLGhbhL/eqMCH0VImconm
         WpzQ==
X-Gm-Message-State: AOJu0YwyiPya2WX/UKkhNI8wJ2ebLBs8/radQfrcSAmqCe7PW+L/z4DN
	V10qJ3AO0hq9AVM4aZ/tqYPmb5g+vcPY9NsVdBW+kY5V89UywOUkwl8qXI7yjtiFqQbZJk9zWE7
	nUPbfuBWZFv+/wXQtMpYUGnq8vYpJpiJd6Sk7fn6G7MbmUbIMaL66aEaSOn3ViczOiYsWEf32lN
	uZ7w==
X-Gm-Gg: ASbGncvsKvLHfUOK0mK8/7VuWKPLnUYUqcH2luntx7Ixi/0lHX5MeWHT5ks+ZWX9Ov0
	jFbLz6JtGtJ2cwOmbznsKTa5VL2Czgyspj973MN8aGqFeImKUg5NDj77ZRtS3x6vUmxmsxGeens
	mJGyefJjSgFkNpfgjfF2sWybU01OORkvqYCoPJnavRgKzgcoa4o+GWL66WTqqTu6I/Ms9F8coOX
	9M48EUwSVxSojQ8OdiNBscJi6icU+Ghme02xg6QLnnJuaDDrse+3gk2TCUeOE/W4fk+USt3KxWt
	yNcS0KE8KZ/rqjLZxCa2ZRkWvHCVZJFQmOpxSqO8qHWyhavsHkGBEOm/fJToULWXxn06yvv4N/k
	EGw==
X-Received: by 2002:a17:903:1a23:b0:236:10b1:50cb with SMTP id d9443c01a7336-2366ae70097mr155955465ad.26.1750092628632;
        Mon, 16 Jun 2025 09:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk17aGuC6iLUEc194iq+DZJZg9A7w6AkhMV7zV5WW6RdsMpYO3iEEiHo7TRIKeJWwrLEgGYw==
X-Received: by 2002:a17:903:1a23:b0:236:10b1:50cb with SMTP id d9443c01a7336-2366ae70097mr155955005ad.26.1750092628081;
        Mon, 16 Jun 2025 09:50:28 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2366e4d6653sm44184525ad.71.2025.06.16.09.50.27
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 09:50:27 -0700 (PDT)
Message-ID: <f960f294-3a64-4ab9-bfb6-9d74dcdea2b0@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 09:50:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux Wireless Request for Collaboration (AP-centric features)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
References: <6f4dc13a-b2f9-4f88-a1fb-8c457a6ed057@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6f4dc13a-b2f9-4f88-a1fb-8c457a6ed057@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jFnkHdSlkMhB2D4aWP_cPdSVzfT2rZek
X-Proofpoint-ORIG-GUID: jFnkHdSlkMhB2D4aWP_cPdSVzfT2rZek
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDExMSBTYWx0ZWRfX6FojAkGWRjKW
 D6UBUAZa3qQl9E6ITtUBw95PS8s9byZttjvohSs9aUor5KxEopIxWnYCh8fOtBvFaeKWiQ1x+pv
 GMkcxbDOfcLjL0GwetKhaMy++Pkt/kG9BOqoJyufAgeGq4q8S+f1UhtA0Q4XnWXQi/wA56Rxp1/
 1P5e5FdcecUNxnQGnI9qSvX223SCogIeNcaE06P//TqzWPSrMs26NW44ImDh376BT3B2EzumjlF
 Ml/Ie7cf5+mFGbCzUY+bvX3UQHwKeRxCGRar42fM8bp23UnfUG0ccxfmXRE6n94ToS/+Ll5ugYs
 1zghJe90ICA4QwzmTSDYjpmblcb9QPzX4EuhnEPO0GeM9AFeYCscFll49IS5RCGuQUCt1gj7ju+
 SL++pRSVlF9EUBtcAAlL0Rc4PqlaNOr2ktkGMHW+2F+DoBDGoDWDhAdGu6zetOgU9YdojHIX
X-Authority-Analysis: v=2.4 cv=fMc53Yae c=1 sm=1 tr=0 ts=68504b55 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=h92Em8YJgqh6t61Dwl8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=768 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160111

On 6/3/2025 3:08 PM, Jeff Johnson wrote:
> Dear Linux wireless contributors,
> 
> Qualcomm is seeking collaborators to bring AP-centric features to the upstream
> Linux kernel. Some of the features we wish to see are already present in
> downstream drivers, and we wish to migrate them to upstream in order to better
> support our customers and the community. Other features are new in 802.11bn,
> and we want to learn from the past experience with 802.11be (especially MLO),
> and nail down designs early, before expending large amounts of development
> time and resources on a design that is ultimately rejected by the community.
> 
> Johannes suggested that I poll the community for interest, and then those of
> us interested in this activity can collaborate off list.
> 
> Specific areas of interest at this time include:
> Robust AV Streaming (IEEE Std 802.11-2020 section 11.25)
> Seamless Roaming (IEEE P802.11bn/D0.2, March 2025 section 37.9)
> 
> Please let me know if you want to be included in this collaboration.
> Or let me know if you believe there is a better way to collaborate.

So far I've only received a couple of private replies, none of them from
representatives of the other major AP vendors.

Since we are eager for an upstream implementation of Robust AV Streaming,
we'll just post our design proposal to the list and hope that stimulates
discussion. Look for that later this week...

/jeff

