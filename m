Return-Path: <linux-wireless+bounces-24615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 525A4AEB9AD
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B85B97AF5A9
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A2B2F1FD0;
	Fri, 27 Jun 2025 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G41F2Oi2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3792E2669
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034125; cv=none; b=Yxl7dIy+sfJ1+fprrR2r7qKVLttBnFHAddl3cg6N9QlEG6lQ+2IPEaEwIDpFe9g3CdGecmmH++Kx+tE+m47nWfzuukbmHJpE2Xz8EfekwpnZT4oDlRprpYsrOa63SB/aqmmmRNOtn7Z11iE762hwBEgt+xWmuMqF7kVRNFhRcNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034125; c=relaxed/simple;
	bh=di5YCkCyRWtwPwLXY8NeEr0ABzYjfRsUk0OR/XeYBpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XCdJ9i1OwvtCG0vnRg8E0z4TmUm6DmA6hA39bxQEINQmmiKpn3YRjN8fbP6IgW9Vgw07WTWiw6GVrRztFlLxeVoWUylOuYG6T498PiCEHuBt5CXwlGGZBByNPeIktQkaN410F0iNIdRvnL+H4zgc/t1tVOfV/svT4ydqqdu44YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G41F2Oi2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCMb6u009857
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y4eM6SjrDXLimKuVvdeZHfoYXt1zPvwpm8OzS+9y8as=; b=G41F2Oi2uCmPfPvk
	JhboewZ2I19vNFf1AuJYtOuwjDPYhxrBuupEH742hElSRVF5OJUF68AfcJVFld6M
	o1UcWGUI3x8iqV0bqEWw1cdRq1YtVTCxF7zPIebKoThEwQcB1Ftf0ZwsNBWHqUHq
	Tmu3dQf5LzNmUPW9NGeb1tS4CAEyaAxyVXN6pGDLp2Ga91Ic6QKP38ay/2Ihs2Rv
	F+VYqVTvbJQW/JhnhkCII1Q9xBwhJW98zsshAO2Ob0Zni9ie7JxJIUUsko4oD/8u
	rIH3wdkVys5NM7NLp4QR8FU4VFAW98br61mVOyuaiOI79a0ocm4wIjQ3OVWs0Q1p
	ww3RkQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g88fgtgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:22:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234906c5e29so27731195ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 07:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751034121; x=1751638921;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4eM6SjrDXLimKuVvdeZHfoYXt1zPvwpm8OzS+9y8as=;
        b=Hr6V2jqJ0+7nWwN91r5eunoVmn5oAMvRKzLAjBGrJMT5M82SI/71R6WOhrq4YagVya
         HdWFq0i6Kj3KS+gMVdTAtpE1gzsoldsqkiSMMo+lzu+olrrgxryNaoJqNHnbqXv+SY/U
         A0fyjTcluMyCyCvd0nwavVAvWCRyxQPqyGm7stqy4ginBK31gp7LkCJHwKf/cZhigPdp
         dhDHkv5FjxQQgXRlNwxSW8QjrRYRIrqzDeU/vsWf89iRUCGQZnH3V5WkO1feUUt8GyN5
         23ey/Kiftan56l5aWzGI0iIj/CphVswe11MC2VQHFq5CyMlGXUoU01Zj6YWfZLdjJi6k
         YEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhaXNDH25uuGBzwt90qxUTRtRq8keB0HgYZdDU2bBmCe9yUQVRgOg15HVfE9loHwCdhiY4Ot5Y8Bk3+pfPQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OARKZkGPFZ4KBtBqMbrkbW8y5zHzuUJDHw42NgdIXNp1HOSE
	QtsxFk27TPpS3xm47YuGt+JONVkCeYW2Q3UxKGMFuUxoBN3Whaii8iMEZimdi+ro3KYqQkuuPaS
	ML3uMJ8NaUI12xBoSpQim7ieUhllXXjwbR1zEjrZ+OWNBMeSKPetGgJEUr4pOojO12qH/gpRUCu
	JLDg==
X-Gm-Gg: ASbGncvheGF8kXvKFslLGL9EmFqfub+HS2BR0pqBm3Oq03LpQsA10EH1QM7JNmDWIx5
	VFN/rb/Qxtf/kPPhZ87PR3UiOb7dKAALAlEgerepIvO4nNWgH49BP2Oy37Dt78JEAsp5YQ52q6L
	CFTJj/AiqheitzgJf/Rkvt50V18ErC/k6Ihgt/OCS5ena9uoJYqqsfuykaMlmQsSq5/FVhYk+9P
	NudCh0w4h8VLB5Qfb5UBZlkXLsWey/dMsQvxPfgKg0rO3RF1cTWUrkNLLlgrhWXHrDkM9NPmlWA
	i91HZO+7SNAk9J9eeCYkNrx+pItWKG5qyYQcMpmIjPmATUPisHKN2oV9qelhTwdq0G5kYhuRmJu
	Nj3o91Hfi75b0GwM=
X-Received: by 2002:a17:902:ea0e:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-23ac46580damr50610045ad.46.1751034120749;
        Fri, 27 Jun 2025 07:22:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFkmKM8WlPTTNvsx9lG6OjBTXZUN3o8yqNoNrwDd20JxRQQvS1aQTttb28OkF3vW9wEEZmMw==
X-Received: by 2002:a17:902:ea0e:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-23ac46580damr50609715ad.46.1751034120311;
        Fri, 27 Jun 2025 07:22:00 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39b928sm17231585ad.111.2025.06.27.07.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 07:21:59 -0700 (PDT)
Message-ID: <a2b447ca-fe62-49d4-b24a-f9709575b693@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 07:21:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux Wireless Request for Collaboration (AP-centric features)
To: Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <6f4dc13a-b2f9-4f88-a1fb-8c457a6ed057@oss.qualcomm.com>
 <dd5d7dabccee33e81f77163b5ba640841cfe5ac8.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <dd5d7dabccee33e81f77163b5ba640841cfe5ac8.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDExOSBTYWx0ZWRfX2IEMl5aTj9hq
 6BIYdOVyjEO50yApWQT8DHx0GMrvNXyQQmB/jdVaHshG5T22tHLmqqBIA8uYSW1hmDwTIZx0MCP
 yn3wayD2NF+5aRk3clPhW4lNQLRZksh2tiYtRu/qK+7pNNhMpy7rGLLqZpTptKUO/98Zh7wB/T4
 fVM1ub4xiidCAbEqEsTrF2r+KZHN7Oc9as/uPMuAhZdYlcptvdi95eOkBZJNLYOV4lYWBZkXPTw
 Y9YUDrKluNGLXa60AxX3apVxeOuufC4BKgrtV/sA+OkJeC7f3nMjJXyNZc/nWYUZk8/xnOW3YPG
 iAckpDgxWwWmKw87jKi5GK88pAsScmEeJg+bK10tiDPvA0taZB8Dngo2xEG2MvzCj3aujDo2cJ5
 RzKmKuH8drjARdetlGlTZdQZPUyMb3kUbAxnxR7ymBxUS9vAalcPA2k2HN06BwdMJqDfyTDC
X-Proofpoint-ORIG-GUID: pw6TvJwjKbFlZwScNAMY0rWuXh4W9EFo
X-Proofpoint-GUID: pw6TvJwjKbFlZwScNAMY0rWuXh4W9EFo
X-Authority-Analysis: v=2.4 cv=LNNmQIW9 c=1 sm=1 tr=0 ts=685ea90a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=fcV47FgRjNm2VZinP7AA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=954
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270119

On 6/27/2025 12:39 AM, Johannes Berg wrote:
> Hi,
> 
> So I held off for a while since I didn't want anyone to think I have it
> covered ;-)
> 
>> Specific areas of interest at this time include:
>> Robust AV Streaming (IEEE Std 802.11-2020 section 11.25)
>> Seamless Roaming (IEEE P802.11bn/D0.2, March 2025 section 37.9)
> 
> But of course generally with my maintainer hat on I'm interested, and to
> some extend perhaps the seamless roaming overlaps a bit with client?
> 
> Now that I learned more about it though, it seems the seamless roaming
> isn't even all _that_ seamless, and doesn't require major surgery?

I think you have a typo: s/doesn't/does/

Seamless roaming is meant to be seamless to the end user but definitely not
seamless to the underlying client or the AP code. And although the scope isn't
as bad as MLO (we hope), it is still a complex handshake, and there are some
things that will be in our proposal will definitely need discussion.

The reason my team is focused on the AP part is that, as reported earlier, for
Wi-Fi 8 we want to transition to upstream for all of our AP products. Our
primary Wi-Fi 8 client will continue to use the downstream qcacld driver, so
client design is currently a lower priority for my team. Perhaps Intel can
drive that :)

/jeff

