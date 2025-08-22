Return-Path: <linux-wireless+bounces-26549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E18B30DBD
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 06:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1180556797F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 04:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1492580CF;
	Fri, 22 Aug 2025 04:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RGYjDpVe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788517F4F6
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 04:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838425; cv=none; b=WnuQj+R94VjiXW4u+edqppbbpRfS78o+E+5BRRpYM/ERWOVqdOYlv2bgtxbkbaoS0AW/BNq8MZ2fueJPaJdaTJd4OBnOqMfZ3UqUZrLaCDhAww9ILno6sbnPTycPsvDab01k4RjDLaaHbVNF3srQM6y2F3CWN3q2UhvpOipW8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838425; c=relaxed/simple;
	bh=R1gc75tjP80WAxQ4wu3rFVtfPOqmH37kjZXjfWhfC/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaECquLftBiqpx6Q2Ql3THy9j9EKd+cjdGn2+yI3k6FYvr76Nj34PUxZ55MRBxamrkywYL3tT5PnUUiQYrFVqIAscFAVyTBXoX3LiezdLUIHNdkcokAD2tHB8f/JVclg7lEtzPaexD55BVnwaMPtb1rQ5km3cgdy35tZWyuE83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RGYjDpVe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI9OtF002961
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 04:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PdSWT3gYgOt4OIy+2Lw7uk7WcpKN/yt+BewlbQw7y0g=; b=RGYjDpVehOmnXb/h
	+t3WD9wcwUu3e+YjzHD4+JS0Kl16DPJON28Dl27vGNXgL2hK1D852XFRgR5Vg9P4
	6PYC3DtR4MVlgINvCV8BgsbN5VBE9nbm8hhKl5aNxpxxNMPvIhi+eSABUYk1ezZn
	mrRAcdvj8EqACUxFHIWejy2QgvP6fQIbzpDEqZW+FMqrX6lbfN+9EHdtaEsMw0pL
	WvxgRfqBAw3Z0RcyZo+eNNO5dw2QMDmilySLNJ7dDWqvHx0DTPdvh7225YH4V1LX
	WC6II+IYqGDZR9QozNhENEGIuHpfkn9jKMmZU1dz/N3L6SmiIYqZxcgriZHa/CMm
	dMGX/Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdnp8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 04:53:42 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e614889so1728581b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 21:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755838421; x=1756443221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdSWT3gYgOt4OIy+2Lw7uk7WcpKN/yt+BewlbQw7y0g=;
        b=PVTxtndGnOpzeLdS3QGdBxusRbmpmTUAHAdC+3KECQah/V2v7xKNNhnO1aAuguAvU+
         MKKCwT5EZwojrbLvwo5FR/Z1tlzkcDuC+l1v1a94f8xklFUAQ9UrrqYqhJjy7Q6j9yeV
         ESd47F/hsgui0UgnGwLyJEEi+I8Gy6AKmaK1nYA5xHunDrrqiJFPzod2YT+uSDgw+WX2
         Ly/xEhr3VUNnkqyDCgIu1rcgkjUyeNvjgi23/hqeSF304Fcs20O9gsazPEaTYCVqyDwH
         174pU9ltIZJT+evHIat/m091WWwEqbAW3oS217sHci+yYInSkpRyLSLVivTPL/1TbIxU
         JMXQ==
X-Gm-Message-State: AOJu0Yy5XzvkVAVYohRNSAw8hWq8pg7sjLyBfpZcPtbnzXmt1kW6Amqn
	ooFDXZYrtZASGVHpiy8odCpRkeDg6g6hzpWGXiO2vPBbN0Rabm0almKoFdiM8Q5b4i2Kkt6XPAW
	DZVJ3Kp+HYBi6ksg/GOoen9jaTiB/HKgVCFVLP2W6iTZmcJz5rf4f4G0684mwRJQ9BZMHkcokXL
	0bjQ==
X-Gm-Gg: ASbGnctmdwWqTg3NY0uYoYeVx3LQH6OWrRE5W2qIt1d2uOVbYD3Ef/jwCSUghavjMMT
	fJUTvFinYUDJRWG+CuvzmV0strW//V6NWO/tQPIje6Njj0/HfkPx2c5FqrGSu1D5tLnX7UVHoMx
	QZ/EXHFq6DnuAcGDyBeWfqbCf0XrcS4dRRtvwjC+AoPG2hfIS5xTBgqPoIMqlV97t2wxgIxfml5
	yxhHrL7UlOJxtnf+HKR4MC+AjP8LtafAn/H34Q2NLuA70r0KNOKHtFniClz7AJTVdTyTeAIZDa5
	pUzMOPsfkZTQv4J/SBHKoeNifOH6qk94cV2Agn6QX5wbll4H+a3Sl4uQuwMHphurzGyDRF6C5D+
	bHtI=
X-Received: by 2002:a05:6a00:9295:b0:76e:9f28:ad56 with SMTP id d2e1a72fcca58-7702fa664camr2571561b3a.14.1755838421336;
        Thu, 21 Aug 2025 21:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6u2ikUXUVBUECwrNR1ag6wNqTPXlRsLEuZ68v4REo6NV6FKg5x+PpgePlDfd8KhPT2WYleQ==
X-Received: by 2002:a05:6a00:9295:b0:76e:9f28:ad56 with SMTP id d2e1a72fcca58-7702fa664camr2571534b3a.14.1755838420822;
        Thu, 21 Aug 2025 21:53:40 -0700 (PDT)
Received: from [192.168.29.88] ([49.43.250.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7f0b4f34sm9444661b3a.92.2025.08.21.21.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:53:40 -0700 (PDT)
Message-ID: <c7e383a9-c291-426b-a7f1-7845fabbaeeb@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 10:23:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DESIGN RFC] Critical Update handling in the kernel
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Ping-Ke Shih <pkshih@realtek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
References: <20250717045540.27208-1-aditya.kumar.singh@oss.qualcomm.com>
 <1a77ca6a35ad03f839b7c997de3977b521d88edc.camel@sipsolutions.net>
 <4a94fa66-8140-4cc8-996c-0ed097b4004a@oss.qualcomm.com>
 <08fee54dd5afc5c8b4966188eb3016713a3d8c8a.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <08fee54dd5afc5c8b4966188eb3016713a3d8c8a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a7f7d6 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZEbenvCwA/jsp6YF92WlZw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Iw58rL21pA4ktbaB5ZcA:9
 a=Dzz9079OjwPXSBvo:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: hquj7tuZdcVI4cpQqIWRzGGFexsF3m_P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfX0CufGr+fxPDd
 BeHhK1HLedJ8N2B9voKyKUN+3umaDFd1wltVWeV3rxNRKfFLhGvwDNUkOOHchH+9tNVGTGSLXjc
 mJvhtG+5DXyQMcwozVMOQHsGZAxDDAKlwty7UJ1UaXaQrCVPLq412R8qrMafJ2VxZ6WgM4tueFN
 US4AjpFAyH2QXyqFe4DG5DDSHYkL+aQ3FwTTNtI7VwxCtNHsHX6Co2pb0trcf9t+VSMHyrRi9Mj
 tT2aMiqbEwvKcjLwfkA/SQLXkA9TD3K7i/eWXB7iRZ/+FoWH6ATMZePjieshfuQN44h8HbCKBAo
 ppd0bAHBC6l4JFGUzryqjGRa+A3U7ankWTJQ83Jvhar49hwMVPnSc3zMrdhHyObsT/tZLqCmaUE
 et+tmYQM+8uLoVlDoJPR62RZ+myS6w==
X-Proofpoint-ORIG-GUID: hquj7tuZdcVI4cpQqIWRzGGFexsF3m_P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

[snip]

> 
> I still don't like the parsing though. Like I said above, that's a lot
> of complexity that simply doesn't even exist when hostapd controls all
> the updates.
> 
> 
> I really would have envisioned this much more along the lines of having
> hostapd start the channel switch (WLOG on link 1 out of links 1 and 2)
> with an nl80211 message that has:
> 
>   - post-switch beacon for link 1
>   - during-switch beacon for link 1
>     - CSA counter offsets for CSA, eCSA, etc. elements
>   - post-switch beacon for link 2 (?)
>   - during-switch beacon for link 2
>     - CSA counter offsets for link 1's CSA counter
>       (for all the per-STA profile link 1 elements)
> 
> isn't that pretty much it? All the BPCC is well-contained within that
> and maintained by hostapd.
> 
> I'll agree that this limits to only doing a single channel switch at a
> time across the whole MLD, but maybe that's not the most problematic
> thing?
> 
> 
> OK I guess I'll have to think about this more ...

I've also spent some time thinking through the idea of handling frame 
formation at the hostapd level and simply notifying the kernel. Here are 
the key points I arrived at:

1. Using a single Netlink (NL) command:
----------------------------------------
The average beacon size is around 500 bytes. During Channel Switch 
Announcement (CSA), we need to send two beacons—one for CSA and one 
post-CSA resulting in approximately 1000 bytes per link. If we apply 
this across all 14 additional links (MLD can have max 15 links), the 
total data sent via NL becomes roughly 15,000 bytes. This is quite large 
and may exceed what the NL socket buffer can reasonably handle.


2. Using multiple NL command for each link:
-------------------------------------------
In the case of a 3-link AP MLD, where Link 1 initiates a Channel Switch 
Announcement (CSA), the sequence would look like this:

Link 1 starts CSA via NL command:
     * csa_beacon
         * CSA and ECSA offsets
     * after_beacon

Link 2 beacon update via NL:
     * Beacon data
         * Partner offsets
             * CSA and ECSA offsets
Link 3 beacon update via NL:
     * Beacon data
         * Partner offsets
             * CSA and ECSA offsets


Once CSA is completed on Link 1, both Link 2 and Link 3 will require 
another beacon update via NL to reflect the new state.

The complexity increases when, during Link 1’s ongoing CSA, either Link 
2 or Link 3 initiates a CSA or a Color Change Announcement (CCA). In 
such cases, Link 1 must update its beacon to include elements from Link 
2 or Link 3’s per-STA profile. However, since Link 1 is already 
undergoing CSA, it cannot perform a beacon update at that time, leading 
to a conflict in update handling.

To keep things simple, one might suggest allowing only one Channel 
Switch Announcement (CSA) at a time within an MLD. However, this 
approach isn't feasible. For instance, consider a 5 GHz link that's part 
of an MLD. If another link is performing a CSA and the 5 GHz link 
detects radar, it must immediately initiate its own CSA and vacate the 
radar channel. In such scenarios, enforcing a single CSA per MLD is 
impractical and could lead to regulatory non-compliance or operational 
issues.


Even if we somehow manage to address the earlier issues, a new challenge 
arises with managing moving offsets and tracking which offset 
corresponds to which link relative to the reporting link.

For example, consider an AP MLD with three links. Suppose Link 3 
initiates a CSA. As a result, Link 2 receives a beacon update that 
includes a CSA element in Link 3’s per-STA profile. Let’s assume the 
counter offset for this CSA is at position 200.

Now, if Link 1 also starts a CSA, the next time Link 2’s beacon is 
updated, it will iterate through all partner links from Link 0 to the 
maximum. Since Link 1 comes before Link 3, its CSA element will be added 
first, followed by Link 3’s. This causes Link 3’s CSA element to shift 
down in the beacon, and its counter offset may now move to position 400.

This dynamic shifting of offsets makes it difficult to reliably track 
which offset belongs to which link, especially when multiple CSAs are 
active and beacon contents are updated frequently.

Another challenge with handling multiple NL (non-link-specific) beacon 
updates is the need to wait until all beacon updates are received by the 
kernel. This requires implementing a "wait for completion" mechanism.

However, since waiting indefinitely isn't practical, there must be a 
timeout or fallback threshold. This introduces a few critical questions:
   * What happens if one of the links fails to send its beacon update 
within the timeout?
   * Should the CSA proceed with the updates received so far, or should 
the entire CSA process be aborted?

These decisions are non-trivial. Continuing the CSA without all updates 
might lead to inconsistent behavior across links, while aborting the CSA 
could delay critical operations like radar avoidance. A well-defined 
policy or fallback strategy is essential to handle such partial update 
scenarios gracefully.

-------------

Considering all the challenges discussed, I still believe that handling 
beacon manipulation at the kernel level is the most effective approach 
especially for critical updates. This method offers the best possible 
way to manage the critical update feature purely through software, 
ensuring reliability and consistency across links.

Let me know your thoughts on this?


-- 
Aditya

