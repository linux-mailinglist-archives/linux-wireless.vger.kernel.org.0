Return-Path: <linux-wireless+bounces-29211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 489C2C75DCD
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 19:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96C2B353E44
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 18:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B933019CD;
	Thu, 20 Nov 2025 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iDuwMoq6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6g8G2NF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF05333439
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661910; cv=none; b=KRYVI0bjp+wR22JO+9g9pRzCXBgioxiaf7NFpW37OtPE4RskuoPmKXXvSHL1kZ0+kwbm1RMmlKPZlrFs5xyb6JkTAe4GxJCx/kcZuq6Yb1DyM15lsQBzvWEVlXLfmS6+XUSVcjBwEr7UAOWvlC6lu9LxapkpJA3bN/kVoBXnozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661910; c=relaxed/simple;
	bh=8Nk5GMhwXm9IMfM3G60BkyzEkRskrHYSLEa9yNbb4os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cG6KxPJLjM7UnoXRTmJ6KL1M5j9O/oHsxo9c8l0WLbtUPazyRp+ofYacuz18LlDk2y4jqaqkY2wSZn713Dw3/5lOq1bCy4nPGmyppDXfuzP9hjfpCFi0Ej6I9gsTiF9Uibrv/5wdBqt0LO/8aAihefqQ+CaEqiRo+TYWyuJDkr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iDuwMoq6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C6g8G2NF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKC4DV23407793
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 18:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JuyQcpZNlll2DkMsFvTsaPoccVC77T3rZPbIJMTs2D4=; b=iDuwMoq60s6wYUco
	8onsgt1l+VyGDcvr2kc5WJUpFbJaZlpkXaOajVcYXr2wkfcduYf4VMTdNBMvFMcv
	RsBlnNWdAzN2UEalw76NfUebuJUtY69dNZwWC8fhcVR1x7z9SETZRkfwecKIxWzz
	9P71m7KY8Bqv+QLpyfM7gyfst17O+OIM+w8TYLmER3srbiJK/RgGv3HGNvixr6YE
	9DJJB6wxygTYxzhNecdGPN9FvyloUFLu257zi9o+FtOqCLzRD0ewPpO6pM5mteNO
	loTp5zBAqMGyiIVHIVV44/L3fyQeLYhskeP5skrbK69tc5OkJwL0w8S8Fse93BlC
	mlu0Vg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahm813tt1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 18:05:08 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-3e82b0276d4so1715565fac.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 10:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763661907; x=1764266707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuyQcpZNlll2DkMsFvTsaPoccVC77T3rZPbIJMTs2D4=;
        b=C6g8G2NFPWqtvQSvMeiqOOmaxNRB9SwFI9VZqKYbvaG2EbTjBiK24xO1QAKM0rRz2v
         /dKTrmFSUFbBao8oz8Z0szTY5KNvPeVJ6PalvqxkGznw6u2NqSCgEzd8u9QbSHXLFYPC
         5xjxZpAx++D9Dtq0PxTSmp3vTkbEHU4ftAT7DAF1kzZUp0g0xCTH21IGFJVk36Igq7bG
         WuvxAr8FU8JVvnknO8LvtqMaKN93pRaDYmQMHEZfkD99J+GGvYs0Zk+wLV4LVGtEsnCA
         BolpnRgpZxJuGhiWaIhfk/T0xmsHk4aoF7hD5EWc9mqmXj3jyhFYVd4q1EWYJZcslQ7H
         TqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763661907; x=1764266707;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuyQcpZNlll2DkMsFvTsaPoccVC77T3rZPbIJMTs2D4=;
        b=hj6gpsS0SDY2nqJpR6+SGpqgOWx6j+MVTA9HI22CUeQZJzTCucUUUkbQLtz18WrqxA
         Fn+f2pCjtgD7GWZO0BIHj9drLPPyPLNrOjG3EfIdjZRXHhCeXxNfOYOIs64/7fcl/PjD
         bqCXg7ap4iGSBB3PlgQe1/hhvev5dcoXQzSWPtxVwsCkvAJIvGjbxxXfwF9Ho4VrNue+
         q4Imx3PMFYrL4R+N6nphusQPhdvI0uXEgbwDBfnSy6512VbdANmih9RVqtMZaLHTIv8g
         KiAyXcabOtX5IaWoOTTVbP8CZ3pdhrMpRIAyYgx55orCLunt14uCtiuuUk6qmHJQ+gPT
         5avg==
X-Gm-Message-State: AOJu0YxsveWlRMWoU3wTeVX0bkGEGVVGDdLPRMXOo80AmbZclHP/blr9
	FnTmd+8q3xY0ATNWwNoQ6TjeXKaEBQlXBisqqCG0qnOa1GnNs+LDRK/s5rM6iFPq9PXD6e8gYhE
	HsZhG/HSC/V6phkGn64xVXmXoj/e2H5aFZd/NApI2qHpKgfpnltvVZNwcABkTLsYrQiLEaA==
X-Gm-Gg: ASbGncvEg8HEif3JiaUfm4eSRrdVMo87en61e/4WVvYLZ2oyBscKtKacREkS8HLIXXX
	Kt+D7XoRFEXlR+0kI78ye7uVjneVob8+0PXxbAn0fKg397s1H+cz5Cl/ws7JsWxutAdjyImznhE
	EB/Bptl4ZKROcgYPqptb6/m3JykXCddIA00WW5eT1dAWpIjaOiTo22NkH/Wep6TrE1aZbnQd4Pf
	qxkpPuPM294+i+qJILsXzfRm28vz65o8rSx7U+2bNsAKVtDUAE8kETZY54zJicS6FGEHu7ovtrt
	SSWUjntj98jUAheNhERp62nuhfPmqW5EDVLV/4F5mDFnAWp7KDnZQW+lJG2WkE6iJfrLD5Es/5u
	Y2aDmgDZxB1Qs6MnxRAu3jiRjwdZ2FOeELW85eqoShR7ABy9NZTqThbp1L4OhtEIpO4IrsKms1v
	AW
X-Received: by 2002:a05:6870:8904:b0:3ec:5ca9:d15d with SMTP id 586e51a60fabf-3ecb81acbebmr179315fac.37.1763661907283;
        Thu, 20 Nov 2025 10:05:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEd5oYmMj/INKleQZdyU+i6Z44oEC8iroO08qkoEl/5zRQjjmiIxz5eeEhp1rBkuV3BWRZMQ==
X-Received: by 2002:a05:6870:8904:b0:3ec:5ca9:d15d with SMTP id 586e51a60fabf-3ecb81acbebmr179281fac.37.1763661906834;
        Thu, 20 Nov 2025 10:05:06 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9c2cf16asm1489091fac.5.2025.11.20.10.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 10:05:06 -0800 (PST)
Message-ID: <69b2d01e-38f3-4a6a-a7e6-5d94d42fe65a@oss.qualcomm.com>
Date: Thu, 20 Nov 2025 10:05:05 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] wireless-2025-11-20
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <20251120085433.8601-3-johannes@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251120085433.8601-3-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Sfp3kNBjXaYkALgl3tJGjLZ0WW3ueUa3
X-Proofpoint-GUID: Sfp3kNBjXaYkALgl3tJGjLZ0WW3ueUa3
X-Authority-Analysis: v=2.4 cv=SJ5PlevH c=1 sm=1 tr=0 ts=691f5854 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=3vU-vsCiunfMoQw1-XoA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDEyMyBTYWx0ZWRfX0Z5qC1ZWiS75
 4Kpfa9xAiAS0LXVACQXXr6FexzrVEmmFzw/KzlFdG1ZtUsAWvxafJsdsTWpKqEt7y8IwrCeJKh4
 TdqSiFsvAYSjTBewLUW75KFNrx0xYfeH0mwAhv8Ica14PVF5VKVv3fH3SCugIO5ox1/Ymmbttxp
 rRAHKRTTwLETFV4Y4RVR+SsjJYnVlxoSplof6no5SDcH7XqhNbIQcGYRRz3PxsD8k8yEqvMa/aK
 MaVwpEOM1ah7GBxip3+0rZNT+25PaKInEBC0jxbsW092vz1h6ACj5dstGcAwPjALMwNZfm3lBB+
 mSAJ5NAc8qas6mjdG9UVXfgiiEOZOJoIk/CmSVZeCVSr1MzSnFGL7R867x4wI8FycZ6JI7LI/xV
 4So7kzZXWvxkRjZUK+aSZcKnmpcFeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_06,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511200123

On 11/20/2025 12:53 AM, Johannes Berg wrote:
> Hi,
> 
> Looks like things are quieting down, I fear maybe _too_ quiet
> since we only have a single fix for rtw89 scanning.

Isn't that the way it is supposed to be heading into -rc7?
:)

BTW internally we're finalizing the ath12k-ng => ath-next merge.
It's a non-trivial merge of around 100 patches on top of around 60 patches
since the branch point.

Current goal is get it to you next week for the v6.19 merge window.

/jeff

