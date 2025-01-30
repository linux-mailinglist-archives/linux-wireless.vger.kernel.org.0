Return-Path: <linux-wireless+bounces-18225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D94A2334B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 18:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18E11888266
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C9D2770C;
	Thu, 30 Jan 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dJqOOGm1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007317597
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738259091; cv=none; b=TlPal2+Y8XX+NNqGKeKgRbcZw5TFGME73t1iFRfiJjbVWowuqm970yeFx3aIoxU03CpMtZ6ZbtKDD6XolhcN8omV5uSFbvqMIWeA/d3tTZ2jK/Q69+ONzIiw92thG8qxVuU+YWJHAom2ikwyxgGJRYp2Cp/7btsUdXqvhVefWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738259091; c=relaxed/simple;
	bh=j2K74chUg1vA3y7CCXvD11yczEMAaWrC7vxmCXzQg+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfJD2GM4kuSQ/rDe0CvptuXXHTNGfmXXjTLbA4pnmYE5Zygy8r7GbDHBqoK2KIT9uAjPvD0Xy2ihHHtZFc+XlFUO1JbFGpBNYnvhfEXSRvkDeCWexOl/+OERNZ6KiycTzsbc4fnUHIm/vwg4J+LHQ5aAHHFTVd6rUOI/ypSTZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dJqOOGm1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UCpIld003671
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 17:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	APiL9Qgzccop+1y8AsLQ1XuRD1MarlgIXAZbOdLJwZU=; b=dJqOOGm1LYybRoZ/
	SKI+R5jmf9qso/MIZPhaiH6kJuD2WqAhhBQLuOifNHuLwJQxtekOqTyIDskM7J3Y
	o/tWlvppxPEPoWZ6VhaHq2k+Wy9AeYLtn8K1v/idzbLl+pOphr916OKg+GBX+IBU
	ozSm+FKILrP/yib2eoTEzj+vnhS73rOCgixY0zIow7TiNzaG/sfUTfjp9cbBrVSr
	ICRSOxxpkv84kaHFjn9u5R043gRRbXIt9EKetEPhU/CEFbRr2wBLZDmkEauH5zJS
	kkeePj1iCXPTyFRVoR5moNjPQrcjYhDNFqvcMEoiGUCvh6F3Rj5QzyCLkg1WZsZR
	DaWNSg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44g9sn0r4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 17:44:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f5538a2356so1999448a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 09:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738259088; x=1738863888;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APiL9Qgzccop+1y8AsLQ1XuRD1MarlgIXAZbOdLJwZU=;
        b=FNZQsDnkNk/UuOcrCHPhouhWEIjhTWtNMdChpTedoyJbvccgjKsXwtK1sBbotMd67x
         GukQsp+yuaRemJ5Z8A0NP5FI9QCdWRR6Yd/2Dv6MX+LY1uCKkBEaMkfuquZuvMEkuU4c
         66wt2UropyfkGeHFjnv8eqnXR9rYYAt2fa9sxuhRKf3q9M0z1LFCpoKJSUMwBYieISUp
         JXdaH5KLxCZok9TgDcnhFQxZ7ZQ0kHRwhO4qbJZb9d6M4irwGDMmNcvJ2xhLP8XFZuHR
         L7cf+uZh4UCOlQAxzLUjv2IebBYfApKfW9zkHZ2gKqt7Icc4UsNrEjqoXzc4dJMqQL8w
         /AUw==
X-Gm-Message-State: AOJu0YxDc02eUFv/5QavWDtSgPGExNNKTLDShdMCAHt3dfuLNrcR02Vk
	xxAju6XxO9KiJbBYwaVRlaOBXd00llZi2dcSbzAp2Lg9khaPTzmlph9CsGKVlrCkXbFVQSZChmc
	m8Llap3EiWNYUBoTrysParcSGoEetsgAiasMujW6Fgnv53sgKR82367jEOL0jarNQpQ==
X-Gm-Gg: ASbGnctx+2dEpa0f8sOjmsBptRCtyN39/WjYeBqG7LeveaB4rNt1YqpR5PwjX1GHYVJ
	mK1aeRTeq45Es5hTK2pK3fXTBT0mqlfCxJde1/TapYCpCT7y04ATHZh9cP8BiC9BpPdl/s+NhGz
	SRdboVztW+sOilT/5IdjOV9igXFFpmi77YdswAh5pdt7/7gAVcNOvVoomA6JGVan5traYVEDM9c
	VArCcslwzv01aQCEGRamN1UwqiO/5N5EyiDeMYz1IA264uKP0M/70NJ2WuDAyGYgGhSct+wHMt4
	twBOCOHdknRDPMb28FUiRahz5s0Bi9SQHxVmHXdXZvMsE7IWUzkA9zTgo1osh5vMVH+/bpIfZw=
	=
X-Received: by 2002:a17:90b:1f92:b0:2f1:2fa5:1924 with SMTP id 98e67ed59e1d1-2f83ac66143mr10901960a91.26.1738259087988;
        Thu, 30 Jan 2025 09:44:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUek7nw9VdAlEoKRC5BUO1BhKF0f54K+odPqUDD4lyw/JbUY4g3T1Lj50RsNebkdIphLVdZA==
X-Received: by 2002:a17:90b:1f92:b0:2f1:2fa5:1924 with SMTP id 98e67ed59e1d1-2f83ac66143mr10901929a91.26.1738259087588;
        Thu, 30 Jan 2025 09:44:47 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bccc8a5sm4210298a91.17.2025.01.30.09.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 09:44:47 -0800 (PST)
Message-ID: <d2b5c265-af14-43ab-b50d-e364d3214fd2@oss.qualcomm.com>
Date: Thu, 30 Jan 2025 09:44:46 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: remove peer extra rssi update
To: Nicolas Escande <nico.escande@gmail.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250117181953.3375273-1-nico.escande@gmail.com>
 <d5eda793-c7e9-453f-9dbc-07e5df73c47d@oss.qualcomm.com>
 <D7EG56E1I0SX.3BZRTM7N6CQ44@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <D7EG56E1I0SX.3BZRTM7N6CQ44@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dcGXCCW0OCcUhYG15mA_Jt27UlT3xvuk
X-Proofpoint-ORIG-GUID: dcGXCCW0OCcUhYG15mA_Jt27UlT3xvuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_08,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=788 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501300134

On 1/29/2025 1:24 AM, Nicolas Escande wrote:
> Arf I can see that the commit format is wrong but I wonder why checkpatch didn't 
> arn me. Do I need more options set on the cmdline ?
> 
> 	scripts/checkpatch.pl mail/0001-wifi-ath11k-remove-extra-rssi-update-in-ath11k_dp_rx.patch
> 	total: 0 errors, 0 warnings, 0 checks, 8 lines checked
> 
> 	mail/0001-wifi-ath11k-remove-extra-rssi-update-in-ath11k_dp_rx.patch has no obvious style problems and is ready for submission.

Are you running checkpatch from within a kernel tree? Looking at the code:

			($id, $description) = git_commit_info($orig_commit,
							      $id, $orig_desc);

			if (defined($id) &&
			    ($short || $long || $space || $case || ($orig_desc ne $description) || !$has_quotes) &&
			    $last_git_commit_id_linenr != $linenr - 1) {
				ERROR("GIT_COMMIT_ID",
				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herectx);
			}

So it will only report the problem if it can find the commit in git so that it
can provide the correct id and description.

/jeff



