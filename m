Return-Path: <linux-wireless+bounces-26972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1183B42377
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0C0170901
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 14:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81197309DD8;
	Wed,  3 Sep 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RPbd6J9k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DE830148D
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909370; cv=none; b=cucAg9cziQCUqKXQTNNwSo6iwGhSXoZLEkURQgIxeaMt5dnx9Lhio+AITwd8tmtJ5zkonGl/TD4AElzcJo4wWt5jqcRH4HSb5plLrBbINFBnPfBZ7EjD2F0Ckgdkz5xr78emhzgP3QEUixTXxR7vSass7W3EZRnVQpodoqlsDJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909370; c=relaxed/simple;
	bh=YShnZmPVrVd6ybKUizC2o7NCPnn57hCQxoOPx7ReqcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzETS0/Y46WlEYu12GPWUcTgciQBDNOgVUet3dl11/G53WjM6NAK/g8NgCxXbdu+OtJjRUKpVSiqUPR+l2G9ts7xbZr0gC457TPjdS1BkGBAKSePjS1GNTxH6kiInxM9kaXhMmQ3+iE3QyWoQxQoARI8wcG25sIyuD4eCZ22E4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RPbd6J9k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx0fS019644
	for <linux-wireless@vger.kernel.org>; Wed, 3 Sep 2025 14:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gxMN2LIyz+W4Ltzu42JSpEjeMsuz6kL9fkm5wj0kqYU=; b=RPbd6J9knHH33Zta
	gPu7rMqAYeYUsiHa1ZFm7hgu3tvSHEjljn8mBitLVkf1O2kB9x5zlNCeGVb+iJQx
	4a3sW92VScjqcflXr0hBvlQCcLmBnqZhCt9bwGRPjK0sIGAv8igvXnr5k8JBRjXS
	0S/q/k9sXEHuoktj0S46M1Ebh1HSmY510b2xfNejMthBtRDxujUE51FJQiTbcLLI
	/8gf0+qsefAiYuJpvhdWQEm7cO5eHR+yXywpKo9NUheop/ulr/zURqJDr68G+A+F
	mvxgjkTYTF5vEoLbNuFxihbCAefMR0VH+XmyjtletzfnAdCH4p1J4qJba/TkqJPz
	9f8QgQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk93ssp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 03 Sep 2025 14:22:48 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77231755b56so986410b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Sep 2025 07:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756909367; x=1757514167;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxMN2LIyz+W4Ltzu42JSpEjeMsuz6kL9fkm5wj0kqYU=;
        b=edfJl1h6yqPPOQ547jA6IgFzvCUo/IfIFXJ3MtHhM+RWphQr0ShgZdruLCcv1tca4v
         RFgFiVAKMYhp+bdw6owjkBP3EdLniBVqi33lnAU9EHFE7WGcGtrEHQE5gIZGkpsZV88h
         Xrd8+9LpPM6MNdzjBVvOfXo7/nQI+WcgI+EPf/MAC1+X1+hpqWBbqaKp+8aK2DtFFMiR
         C9arHBWmz7X3QlFZfT4Hrfn+hmCk2VHwAGx2sr8el4qmiUnOE5HJ2bBo1XTYF3KUS+4H
         Cz5XP0sbWIptrWfiOlND5lDgfuDH8v74f0tBoaEtWLT0RmjG9jB0vbpgNj/WzwUSxRlH
         DCtg==
X-Gm-Message-State: AOJu0YzJxqnhKSQbJlnSTZL98c38nEbdvKSKykAzMe3XLXI0OaTYMl+1
	327cGvXJZX3xClXUcBSQoniUEpQ6WF1LT9mgW6dXpdEGiFvCFID6bS6W9zRhfT/xnFFWSAmgQB8
	D6HIQiRIRiN/fn27m3XNpwWQRGGJemgVtx0kYM2NZdwlcmgWZK1Etk1IfVxY2Lg4rMUBOGQt+Mp
	h4Vg==
X-Gm-Gg: ASbGncsrFNVARZBaZm6y5SpJ8eiO0maKDIIHpsyRcjUgY1a0d3Z7YkdazjZdRuNkKfg
	Fks/xZBjNT3W5xvN84nj4SAtWyUnNyP7sgteHqXhfMtBNHrwFcSOqClrmwBZKQq71ZH+tL88ZJN
	7FTjWRU4UTz2SLPeOcsbDM7vlMd8gTyEN0nBxGul7/Mjgx/Gxffy95JUV6aDuY5n9YmS+nHFVar
	9y77l1rHudv/vkaID41FH2XxXvgySUZPsRNLjAfmaK28RwCsuozkJt9V8XwdNgTTabeO5pd4Wux
	CyUyktgS3xIZMowDfPxgYnH0Lv3WFnQJEdUo4ygPZaxozPmFiKTlI3spnXf1JayWC62tqJGZrvg
	8zIkyxdUCHUo1NAh7yUCQCwgX
X-Received: by 2002:a05:6a00:ccd:b0:772:7b9b:b1b6 with SMTP id d2e1a72fcca58-7727b9bb582mr5871345b3a.9.1756909367030;
        Wed, 03 Sep 2025 07:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0EpWv9Bnnpd7uB5Eu9yqLe3hgag7Ty/a1+Sm+XM2Zs7buhxPdUwb4Ec1nqvg0ycwPn1n27g==
X-Received: by 2002:a05:6a00:ccd:b0:772:7b9b:b1b6 with SMTP id d2e1a72fcca58-7727b9bb582mr5871299b3a.9.1756909366323;
        Wed, 03 Sep 2025 07:22:46 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26abdesm16569088b3a.1.2025.09.03.07.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 07:22:45 -0700 (PDT)
Message-ID: <c3312127-0b87-4825-bf73-05351f8eb55e@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 07:22:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: fix reporting of all valid
 links in sta_set_sinfo()
To: Johannes Berg <johannes@sipsolutions.net>,
        Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
References: <20250822053229.519836-1-quic_sarishar@quicinc.com>
 <b8eb835bb73e348c331e008408159a8026d28870.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b8eb835bb73e348c331e008408159a8026d28870.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4cBZ1AbIWr2R6q9QssfZd4YexASjNZE1
X-Proofpoint-ORIG-GUID: 4cBZ1AbIWr2R6q9QssfZd4YexASjNZE1
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b84f38 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pD2vXDK1idOVCrmdNlIA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX7KF2sXY87k8p
 1SKuypfXWQ2FbaI+pWz5lzXGrbpdBcct4Q9kV1/i18ZGfQDGHI/8eIa/QFBYEiGqmBn3A3lW6D7
 nBl9eJEAt6u4jnpu5g9WNhkGH8NacXUXADYBszc6y1/o0AmIXV6Scgu8re9CgnPwbNnmpr4gxmW
 UWJjTdQoEHEu9dqoj1SN1HuWGtY1W0+Wia2mAOVY6tcp36Y1Gpx4gM7nogBvWF648eHjimLnwa/
 wnoR4IoUXpBre/SzQHmkK+iCau5wbVKQ5wxhZZmKXSS0wJrwz47mFUMLQJNkLdWX3Q2hFNSHqLw
 3jgFxqyLvP+kzDQYK4b03D1BFRxHASLkF8ByvZ8zDLNTiMHSgDT7AkSVz9OnSQAwj22ycilDCxc
 T+ApT1HV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On 9/3/2025 1:01 AM, Johannes Berg wrote:
> On Fri, 2025-08-22 at 11:02 +0530, Sarika Sharma wrote:
>> Currently, sta_set_sinfo() fails to populate link-level station info
>> when sinfo->valid_links is initially 0 and sta->sta.valid_links has
>> bits set for links other than link 0. This typically occurs when
>> association happens on a non-zero link or link 0 deleted dynamically.
>> In such cases, the for_each_valid_link(sinfo, link_id) loop only
>> executes for link 0 and terminates early, since sinfo->valid_links
>> remains 0. As a result, only MLD-level information is reported to
>> userspace.
>>
>> Hence to fix, initialize sinfo->valid_links with sta->sta.valid_links
>> before entering the loop to ensure loop executes for each valid link.
>> During iteration, mask out invalid links from sinfo->valid_links if
>> any of sta->link[link_id], sdata->link[link_id], or sinfo->links[link_id]
>> are not present, to report only valid link information.
>>
>> Fixes: 505991fba9ec ("wifi: mac80211: extend support to fill link level sinfo structure")
> 
> With a Fixes: tag for a commit in 6.17-rc, why should this not also go
> to wireless for 6.17?

Concur this should go through wireless instead of wireless-next. That was a
miss on my part during internal review.

/jeff

