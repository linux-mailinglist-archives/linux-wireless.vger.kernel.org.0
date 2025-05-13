Return-Path: <linux-wireless+bounces-22903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F02FAB52EC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 12:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99262981FE5
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0587255227;
	Tue, 13 May 2025 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MlZKfHp5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3991254AF4
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131441; cv=none; b=keIF4WtbtEGvszXNqsPGUvb+1BVP5lfi8PQVNBW7tE9jRdQuVdVeHntkM2nzgVs+j62QhjGVohfdvEEbjJ+wiA+JdFWwVjELECF5PouwGap9AbZEVLEj9MTRjA3ycnIq8s/DcuhOTx9Ayfy7j6GUytoh2SmZgJJ0jGTSUFKqrKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131441; c=relaxed/simple;
	bh=YPtYVXRxNchYVtoNxYECCpShOcMZmmbhDoSB+1Yqhr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYell2Mi43jLdrShJt4nYN/dLupllrt3WUudUT6RjPJ6cHslV1AdafZwY2sChI2ObRxjg3kWzgEPnG8kxpEN4OFQbe/y3b8QKBVJvmN/s6JPjxbNmIh43P/aK216Uq02xeWEDAlQ8GXxY7Uiq3e4uw5y81ZjlTZ4znB9ABLRDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MlZKfHp5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D7RvBG005605
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 10:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NpvCrOWgU5cpFOIl3kofLU9KI6eGSBahid+fNqQr2k8=; b=MlZKfHp50nLFcOr5
	ByhiEq1wu2BEnQk0TX+GXaj2syvGESu4faiOq+99mztJk58Z/oPltKBTzCAbmgxW
	kvKu67aLMUVR0iGzqaQq7F/R9bS8eXy4pfm8EasKEHGVlPZaPcWncVFvu3VE9QaF
	g6utatSvMwg9AhO/5PcdukuEDJZZSPBXhJj0Tmdx+LjvgxAkUe8eJJ8sJBuPSyNt
	EJKEJQTVK6hDN8KpkKe3vNCPaaoM6AwRruPuLdiRA5ii5vqmfBdSpF6XLLwph/Ti
	wN5EdOUfUYEaG2tZS283PP4gYE5pPv2TW1CzxyIoRS7EyGQqHZDLh6FQqejbwh24
	7YdB1g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hx4k7c85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 10:17:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2518fbaaabso4064661a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747131436; x=1747736236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpvCrOWgU5cpFOIl3kofLU9KI6eGSBahid+fNqQr2k8=;
        b=ZfIfpC4OclGfeok8RGAIe5D1869uQsxHpv+trIUGpmO5RO2tFTmGFfI9gtYHjvqlrx
         baURfdfF+9CQ/NNHULvTLEFZMD0pFaoVh/mZOzC0gZJmzsE15LaoGTWJGYes2qxOgIOV
         U/9a5SXMHBMV2CrYibu9P9J2/o8hNWth12Dyu9q2UQHpo1yM0d48jPXMw/wyi1+hoStu
         88SS1IsWVPxy0EZRWR+saru3/Lnm7JZNSrLni6Rkofo8Z8CMIgsHNxKc68d52GFZnK7O
         UOWeo3W2hSS25MEdE9VgY2JV/b6KsGRpI3JFLbWS0SJrUtECslSMpb/6ZPnv/IwX9BRe
         /wHw==
X-Gm-Message-State: AOJu0Yz7gWl4meBhUkuPLKWz0Djgp0mCxTLofs+SooHAZwebdXaviG1p
	biXCTcLDdTCZQ7SKeFI1lcdyUwfD5WOK6VMLf3dKlxi7rmnRydOOC0MLz281BEiU5XQ3dpfS2Qv
	gGjXgFLjXAMKRLFmvXo3znB2mYs/+Deyba76TN2hUwGizVdhXx5i33PdLIM9ais0Inw==
X-Gm-Gg: ASbGncuMOk8PQ3AOVNw1gWeG241tFhLuRgBquTlXkTwplMlYPr3/5GqWHlB8LBUJoi1
	8WsDYSn3OZEXUU9iisI3gs7Bxs7J0nEt9YC8qIcqmToYnrFHL8UJIRaR+mup3xpWrYgN/rBAV6F
	ZIaiiNM99r4nxZWD4YSCB7QPlYvWcep9kDqrgmwZgJp08t6NazVejqdoaCyb03srWY0JDnctQyS
	D2haYGqywIj9mQeI5OcMnVqWgBE/TiHAUbGeCpWG6+AreF4A4CznA9/UhbZZKYOT+YCrFJrUvr5
	XRaISrMa4c6l9H2rLbmxvtsT0+eaN2lv43FYXPV31i/rzIkIF4c=
X-Received: by 2002:a17:90b:3d8c:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-30c3d62e5d6mr25261870a91.27.1747131436099;
        Tue, 13 May 2025 03:17:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIQSglw62YPtOpiT2/xmAHW933FddDkbyK+ln1dlw68QmpU+bhwWTsjnzGBvaYIN3j8T0eJw==
X-Received: by 2002:a17:90b:3d8c:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-30c3d62e5d6mr25261822a91.27.1747131435590;
        Tue, 13 May 2025 03:17:15 -0700 (PDT)
Received: from [10.152.194.206] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4ffbc88sm10327508a91.49.2025.05.13.03.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 03:17:15 -0700 (PDT)
Message-ID: <26a9e68d-bce6-4bba-871d-13e2aeee3fed@oss.qualcomm.com>
Date: Tue, 13 May 2025 15:47:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/2] wifi: mac80211: validate SCAN_FLAG_AP
 in scan request during MLO
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250513-bug_fix_mlo_scan-v1-0-94235bb42fbe@oss.qualcomm.com>
 <20250513-bug_fix_mlo_scan-v1-1-94235bb42fbe@oss.qualcomm.com>
 <16499ad8e4b060ee04c8a8b3615fe8952aa7b07b.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <16499ad8e4b060ee04c8a8b3615fe8952aa7b07b.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ReqQC0tv c=1 sm=1 tr=0 ts=68231c2d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=C9-73DTKG-V4ExX9xGAA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 1d-ODnT0TyZEKP98qXvB_fEqwe5WH0Ob
X-Proofpoint-ORIG-GUID: 1d-ODnT0TyZEKP98qXvB_fEqwe5WH0Ob
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA5OCBTYWx0ZWRfXzk6TZA4xlUgC
 enY78RWaDpeFTqhkaMijoA54Yv1EIQT27PncMuTjl/4WRll/34h8SmrmM/lGgALWJ9UkZyz193j
 ov/9hLjTBf2neuESJm8/4+/gcZFooa1+5BsFZf7aDDtRO8BWP+lfTCgaDVnLdHA+92BbxumQW8K
 GtjnGfK8q3vOI//Ryu4+zXJ/NUMzdhSkuxTenwIGAVOCDynT6AcLRl1z4N5yVa5+yGcGWNrTg50
 Sv5aLIVLKA/yRbv67zE5leWH9Y2LTEV5A34n3gRVmjJYpOwzgZ3wcUawX0PWj5CyRtIOG1xdi1C
 fKcabnj9RIafomYIVMkD1TNHW9itnxwAXjrmD6/6pTzI5CI0OaHmxhjURotep/KFflX9fjDrpOo
 Nh9n5RX9Bh5kjtZFR+oSDuJukHbr0VF+Fo9rtzdLeKb/j3J3RDSKjz7q+He9nq4YDohz9qWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=848 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130098

On 5/13/2025 12:47 PM, Johannes Berg wrote:
> On Tue, 2025-05-13 at 09:26 +0530, Aditya Kumar Singh wrote:
>>
>> -		if (sdata->deflink.u.ap.beacon &&
>> +		if ((sdata->deflink.u.ap.beacon ||
>> +		     ieee80211_num_beaconing_links(sdata)) &&
>>
> 
> Do we even still need the deflink check? Seems like
> num_beaconing_links() _should_ return 1 anyway even though it currently
> doesn't, and we need to fix that?

If the ieee80211_num_beaconing_links() is modified then deflink check is 
not required. Do you want to me to send a clean up for that function 
first or would take this and later the clean up part?

> 
> Also seems the VLAN carrier handling is broken.
With this patch? Or in general you are saying? HWSIM test cases seems to 
be working fine for me with this series applied. May be there is no test 
case to make it evident?

-- 
Aditya

