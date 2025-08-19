Return-Path: <linux-wireless+bounces-26448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5720B2B9B8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 08:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862885801A4
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 06:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DE31B87EB;
	Tue, 19 Aug 2025 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cXBx3+Gk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9817D19D8A8
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585526; cv=none; b=tbJlXi4CeKh7ibiy05GlG2qbcthDhZOdTEKzh6jX5LmfxlgQde8j3eGuomz7xp+aJTA2vp6TYT5m9yfZcfpUVkc/sXOJfXoXrvoptF25t7qDTnf9LpNoQU2kouU0MTED+9jMpPjn19OiUrfj6CtDR6P2xcMLs/4GgkYtk2aJc50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585526; c=relaxed/simple;
	bh=pAoLF6OgU9nexvhoGoHay7FSSnOOjGhiFZBRNoQFC2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n798WJT9v7tvE2F1YhrrU7Oi2HGRu5Y1fpZ47Od2Di5zi6kHmqI7EA/V6y6FRYWMZMF5ejB+dl+KhQfw1OTSRXy49JoglB3Oj6zcY5vvi4rLpeqwMSgfnHNZuUgdI+n6gNKULa9SrVFHMi89XtFLWSQb3wth6SYa9Dn6fYHL/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cXBx3+Gk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J2RD3u025345
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 06:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Qq/aMBe6WA4icgWdgRmHu9HjfiTSjioB8bzv4f37ps=; b=cXBx3+GkykVB2H/+
	rclAvJg00+PXYq+P1x17sgD1TMbD5Mr0kkctnu068m/FosJuNT7d0BALR5K22p0a
	/dUdXAemP0M4HkqjYkI9pWZik0RToD2Iv6sdHhSVijNoFQvovqmzTvOyF9uv0kvO
	Qv6bfJXiJenCa3GzevEUxRLdm0ZrUsewskNeNI0Xj0+58rWumfk29GUeFnUd23DM
	Wu5weD7jy5HoFyCR3TEPHsWf4FO5d59MAwbKXoEn1lsRODVAYEShrbe4mRZMsw2r
	Kbpps1z79DH3QdawTiOKd+UOn6H+YzATOxP1fmz9ox+2sI0WyBmvG/Exex3xXRM9
	Qge4fQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m71cj6dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 06:38:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4716fb7f2aso4028525a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 Aug 2025 23:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585524; x=1756190324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Qq/aMBe6WA4icgWdgRmHu9HjfiTSjioB8bzv4f37ps=;
        b=UlmcHsFu1LaYN/UdgbnXJxx11v7x5+cI5ilmIGR6U6nBlRSOn7PiQRPRLbbrC0RvHy
         Q1ZOZ34+aFM+BnRRxNq2doQOTI+tu27Crje5yeVxyji6e8SAmW1XCjoj2lTyEulSCX8T
         L9bOAzN7H9ndZRMYSuroQmcTfDVTkNvqisRfdigtBH8zdAV0lN7qBPTiGfNo+z1knAsR
         Xypop2toOEHFOsb1JC5JGtOl4XFq/Z5fx9wy/OYDJE0ha8/LC783FkXQN3JzjTjn4Cub
         SynYbBJpbDpMFjMzzRO6KyOM9GSg1W8qzLTgLEXdL9AhKSEI//FZJPHnS67Pzh/VnbnC
         FoPw==
X-Forwarded-Encrypted: i=1; AJvYcCUce9i5rqg3YSJ/gIDyBLv0ixlorXH1/yeVQHTLUlDDletYooRlfeEFQDIb9mHH1dOj/kILHYkzD3WY6pyIwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+o7SIbY6BM3xXNCFPZ+lY6X8U3b19LTLBZlOc5LzIEBB72iQj
	JTwb+npmCYNrkEAtDDHTaHa/uYMVSARhrjS8e9M9P6GVET9OHgsHUNa+pboh2jjfyDpL8bEtYg0
	DDAq/tm0EfGshomlClQlpwL58vSXYP1wnebB7bfpwWYJ3V0o28Z+3kUe/O1isIx9bfm5KXQ==
X-Gm-Gg: ASbGncuQCmq9yOiQaXO5Y4n35umIkydv1xPeMefgCSTLsX0Rfsj0ioTMvKvA4gDhweB
	iYRxdkNk5jshdzZv4wRE30JYEiljQVPlI5/Dq/8c61x+fpNCSZiQyyxrXkBH7rcwkLJcZbUWSjD
	40dl7gOBjnDFPZwLDqdQIVsvyQn9aBtTkCghK/PqFWH3qXZXXUCHUNdDFFspVMLIhoefHXIWdXF
	E0Qcwx6iiDeacu5rr1cUYsYMqfbcdAOPyOyhw7xHyvWGTOpm1lVXcv8/u4O2btJIJdHW+wCTfXS
	ZgGIge+qElxSCBdDE3p02ZVRRZ3JpOaV/vIQOCM0sLr8le0T/Q2Zt7Iso7THj1UFU3CpK2GOCdB
	fmzNOE/RHG/nlOUpkGsYTQSaYrCP0hjf+dHdz
X-Received: by 2002:a17:90b:5746:b0:31f:1744:e7fd with SMTP id 98e67ed59e1d1-32476aa1cdfmr1843075a91.31.1755585523819;
        Mon, 18 Aug 2025 23:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQYE9o0BkXEZqqGhwXwAEvO5q7mg3A9ZGePOqkdZyzZsjwzpO4oWulSOZ4lo2KN9r2OZ7z5w==
X-Received: by 2002:a17:90b:5746:b0:31f:1744:e7fd with SMTP id 98e67ed59e1d1-32476aa1cdfmr1843053a91.31.1755585523326;
        Mon, 18 Aug 2025 23:38:43 -0700 (PDT)
Received: from [10.133.33.94] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d76f9d5sm9646108a12.45.2025.08.18.23.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 23:38:43 -0700 (PDT)
Message-ID: <d6f0b64f-1764-41cd-a7c5-fb34d034ace2@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 14:38:38 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k: REO status on PPC does not work
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NAC2RAEkHJrhDr7rX8iaOqZ6ZRjqlnNi
X-Proofpoint-GUID: NAC2RAEkHJrhDr7rX8iaOqZ6ZRjqlnNi
X-Authority-Analysis: v=2.4 cv=IvQecK/g c=1 sm=1 tr=0 ts=68a41bf4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=HThdk4v1ZfnwiNzKKCMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0NyBTYWx0ZWRfXyGRyInIWPiRt
 AftkC4cghq8DZa+9QQrROspzY7IERMM0jR/NgK1rfZEgqFcytHb6gbyJbzB5Bb5FMAWk3PfToo/
 /z49mHKU6oPjosqU9KIgDUWSJbSXYvYRWHQ8sO4zbbtycU3gFWvnwtMyJenyiZBGHOTc7evlmpT
 j1uyDQQiWzfCcaIyFiIcXVcrTxtQq60lP11bSseudZIXUYUaaYnfhbAwKFa5e3FPZ29cbzpU+8F
 S579R4Fqmd6xZEg9CuxKOpMNtCLsk3gNstzLi8LNmnbP/e9yBirzRcPQQAfhaSIcKKjfwPnD3r9
 gzU/wZ1mTdWDk9yzwFddwLyW+ju+D7s5rJ7vMJNUIUtFqPa1EBMJP1PzlCh+VDjIJAepsI92N5j
 atdCfD3x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180147



On 8/15/2025 4:13 PM, Alexander Wilhelm wrote:
> Hello devs,
> 
> I'm currently working on getting the 'ath12k' driver running on a big endian
> PowerPC platform and have encountered the following issue.
> 
> In the function 'ath12k_dp_rx_process_reo_status', the REO status is determined
> by inspecting memory that the hardware has previously written via DMA.
> Specifically, during the call to 'ath12k_hal_srng_access_begin', the driver
> reads the value of 'hp_addr' for the destination ring (in my case, always with
> ID 21). On the big endian platform, this value is consistently 0, which prevents
> the REO status from being updated.

This does not seem an endian issue to me, because either of them we should get a value
other than 0.

> 
> Interestingly, DMA read/write accesses work fine for other rings, just not for
> this one. What makes the REO status ring so special? I couldn’t find anything in
> the initialization routine that would explain the difference.
> 
> Could anyone give me a hint on what I should be looking for?
> 
> 
What hardware are you using? WCN7850 or QCN9274?

> Best regards
> Alexander Wilhelm
>


