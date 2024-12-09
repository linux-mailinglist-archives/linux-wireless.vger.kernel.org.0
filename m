Return-Path: <linux-wireless+bounces-16101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AABC39E9E34
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 19:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768DA164116
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92F517836B;
	Mon,  9 Dec 2024 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WvSEN2T7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDA87080B
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769583; cv=none; b=l1cb/025MbGscsDuVv6W6T9lBTnJKoTJGkqkVGn/eUl09n7qovpDuxgFfIkL6x3yUF3k8X/4XziAF2XCots+GXJwrTYu19y+DGyRrqH10E8XGmD9oRFZU1pPbKeqDl/yT1bRhzn8wXFySWgA+Q6MC/VchIiuNhFscjOTtlS3Gd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769583; c=relaxed/simple;
	bh=qTpR+DVnZfkn/LbNpEda2wY8oM7p10e4lStF1EAt5Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anPuloQcLLE0xruBBLNZyuU2GCFfRGDSWkrpCRYezpC6Hmg86RwioPS8Ksmkd08XE/A2iFzaXv+LFzJn148omZOR05J/3ndvcwVN8mwVgka8sWphQChkvUVJ/1aD+LreJbMoR5x+FXnnypZhCGb/QNMAA6G1fozGJB7O24cP4as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WvSEN2T7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HvKp6008468
	for <linux-wireless@vger.kernel.org>; Mon, 9 Dec 2024 18:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2LRB74TS7aAZ65rDLYYop9ew9kjmQm4OjhhBw9zbRgk=; b=WvSEN2T7XZ7OPr87
	CtqIgOW1QFxIS9+mpVeCAABeiUfmN9xQcKAZHSfnbMycTvPo61wFh995xlKpT+Uc
	pAOo091tgZAuI7Dt/HsgNlGZ7ps0vt8UAtWLsAesmEfyTc0j5nsrXXeXfvMZVY2i
	dC76RYJ6RyokA69/ghHcrD/mPAeTY80AlrEgr5YIT7/MRLWdJ6/foK5zkcGb6InQ
	PG4s+vKthcTA1VBpce6ubuK0NVPbAI+so+HLzSM1ug7q8A0UY2oISmDj37QEj2E4
	J0wDTt5UDd7p8GblslXy0306nLseW0RzQs4CoH/1x/Eg/ulgaTlG1/jVSTiKLHlQ
	CzfBKQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdxxdurt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 18:39:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2162f80040aso18886375ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 10:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733769579; x=1734374379;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LRB74TS7aAZ65rDLYYop9ew9kjmQm4OjhhBw9zbRgk=;
        b=DT5Viruk8tUDWttUJTiaW8GMyASn/U/+6wof8CynNTEPtqytC+6t8guXxPeDfKVm02
         zyhuY+Oa2HGIZmS5nhxHYcVP0aTs/KJPMyDzNrYpGmtD3pU2sb09Hw7WAohDxH0AACRr
         lIhq36Y0WLDkMgtn6KyK/aEW6fqhE7JHl4hVgqosNPgYQqZLvY6AXk2aryECcQEK00X7
         X9j5jba6tNVNZS82VAKoMR/VmiyaOzfDKuNRFIKVq30Yp09s2pK3HWoe6dhT1q9X4nPz
         wd/YSbYMvauGTm3IVOg0dzbbC27OgWn8QzZZskI+7bDeLccFcK5FUQ3XkihBZ3RyMMja
         SBoA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ8+DZaf7RZJ09Ht0DDThTzchqUUmh6MBAz6d3EPwxKNTNfF4jIWOTMAqtihOIV3kg5JE+uX7zeIs853M1fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN5n61kSeXz+/s4lqeV6+2YIPWnWMe1hGSR2KUbfHYJexF0TFA
	9zi65WaS2ckCN8RD12ZEPKtv3ZpPdttz1t/CqAgfZT+jvi3e5DQglYKTpRuRrEGNSI9LmGeFY3A
	r8hCEdXJ0YbC0XZ9jxFm7xTSXvRDWF3k1QoqTgvbPG6MDBiFOJ7M2wzPSto3Y+pq/Pw==
X-Gm-Gg: ASbGncv3Ek/0MfcbomhJ3jLWlrkQGaajGSwrfyaBoWwXNLFu3Nyib4s0wFg3Rlg8nWr
	tuBDNnY0F4oniTvfLnihEdpAAalcNs6rSBXNckj+3I3G59O8C6pfwNcifuVXy3wpH3nDqNKfxJH
	4YAc3j4nwTmLpzECahiRpEChsbUNUETvkCU+6m+FYHi5KYrpyca+d/AjavwUcTv4J6dtD4P2tAa
	awN8bcQdkPHxKRoUWCsUsCx0TnkU3JlUfeM033v7/alNrEQABSyBRbaNvHnnaJZfKmd+FPrpsJ4
	knoBuyhh79dhHAYo1Hqc+SM28TqFW+DEO3wXKxoDcUY=
X-Received: by 2002:a17:902:d583:b0:216:5b8b:9062 with SMTP id d9443c01a7336-2166a066e8dmr23508385ad.54.1733769578720;
        Mon, 09 Dec 2024 10:39:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGRrrYY1+/oEmCNwrACPw6WHa5roX7/eq1nAR1S1hEfaf1ofhqsiOCsZVOVp9LKt0gg0jfRA==
X-Received: by 2002:a17:902:d583:b0:216:5b8b:9062 with SMTP id d9443c01a7336-2166a066e8dmr23508045ad.54.1733769578341;
        Mon, 09 Dec 2024 10:39:38 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216413a6c92sm28572965ad.249.2024.12.09.10.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 10:39:38 -0800 (PST)
Message-ID: <cd5ef876-d849-4d7b-b8b7-94377e8720f0@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 10:39:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 wireless-next] wifi: ath12k: Fix out-of-bounds read in
 ath12k_mac_vdev_create
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>, kvalo@kernel.org,
        ath12k@lists.infradead.org
Cc: jjohnson@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241207071306.325641-1-dheeraj.linuxdev@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241207071306.325641-1-dheeraj.linuxdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LHrixStomXf9j04WlZvAWcBSVau8WMaU
X-Proofpoint-GUID: LHrixStomXf9j04WlZvAWcBSVau8WMaU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090144

On 12/6/2024 11:13 PM, Dheeraj Reddy Jonnalagadda wrote:
> Add a bounds check to ath12k_mac_vdev_create() to prevent an out-of-bounds
> read in the vif->link_conf array. The function uses link_id, derived from
> arvif->link_id, to index the array. When link_id equals 15, the index
> exceeds the bounds of the array, which contains only 15 elements.
> 
> This issue occurs in the following code branch:
> 
>     if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
>         link_id = ffs(vif->valid_links) - 1;
>     else
>         link_id = arvif->link_id;
> 
> When the first condition in the if statement is true and the second
> condition is false, it implies that arvif->link_id equals 15 and
> the else branch is taken, where link_id is set to 15, causing an
> out-of-bounds access when vif->link_conf array is read using link_id
> as index.
> 
> Add a check to ensure that link_id does not exceed the valid range of the
> vif->link_conf array. Log a warning and return -EINVAL if the check fails
> to prevent undefined behavior.
> 
> Changelog:
> 
> v2:
> 	- Updated the commit message as per the reviewer's suggestions
> 	- Clarified the description of the bug in the commit message
> 	- Added Fixes and Closes tags with relevant information

As Kalle already mentioned, the changelog should come "after the cut"
Please refer to:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

Namely:
One good use for the additional comments after the --- marker is for a
diffstat...
Other comments relevant only to the moment or the maintainer, not suitable for
the permanent changelog, should also go here. A good example of such comments
might be patch changelogs which describe what has changed between the v1 and
v2 version of the patch.

> 
> Fixes: 90570ba4610 ("wifi: ath12k: do not return invalid link id for scan link")
> Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602214

there should not be a blank line here

Also I just joined the Coverity "linux" project. I have access to the
dashboard, but don't see that particular CID. Since you've been a member for a
few months, is there something special I need to do to see that CID?
Or is this CID in a project other than "linux"? I ask because I'm looking at
A CID in the latest snapshot of "linux" and the URL is:
https://scan5.scan.coverity.com/#/project-view/63541/10063?selectedIssue=1636666

So I'm guessing your CID is from a different project?

> 
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---

to reiterate, the changelog goes here, with the latest version described first.

>  drivers/net/wireless/ath/ath12k/mac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 129607ac6c1a..c19b10e66f4a 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -7725,6 +7725,12 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
>  	else
>  		link_id = arvif->link_id;
>  
> +	if (link_id >= ARRAY_SIZE(vif->link_conf)) {
> +		ath12k_warn(ar->ab, "link_id %u exceeds max valid links for vif %pM\n",
> +			    link_id, vif->addr);
> +		return -EINVAL;
> +	}
> +
>  	link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[link_id]);
>  	if (!link_conf) {
>  		ath12k_warn(ar->ab, "unable to access bss link conf in vdev create for vif %pM link %u\n",

Note that I don't need you to send a new patch if Kalle ACKs the current one;
I can fixup the patch in the "pending" branch. But I would like to make
sure I can see the CID in Coverity, so please let me know if I'm subscribed to
the correct project.

/jeff

