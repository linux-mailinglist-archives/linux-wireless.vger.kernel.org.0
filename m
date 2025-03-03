Return-Path: <linux-wireless+bounces-19716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD03A4C5F0
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 17:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FDB3A35E6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49195189BB0;
	Mon,  3 Mar 2025 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FGwuvb7f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03C7080D
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017703; cv=none; b=ClsmvZAApC7Lty83/uda45zEm8mx7+wUVoB3K//vFrHGTvo58O0PKz5T3b3naJWtSbfJd0Mv6DQS47m1AGoz3J7tXeEmGjHNNAC0jzCFn+jwWa2KZkjyP1s0I1kTmgeIa6gPc/LnogLAeRl0afDjsP0mloljWCge1KFiTwAOvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017703; c=relaxed/simple;
	bh=DQ2ARohgT2WIxx2+PKksbW62z0i8lh6jAaz6kyrI3Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWhcsDEc7aclWofeRH+1tyQW76ICOKu3K/t9TpRNsvRgJACePE3Ud7FbIavjcPfUmoI9O+NmcVPkvRE94QEvdEcLchvV8VSeFcZ7hSgzX/vOe9gymKDPuot+6v95pLfBwin6b8dRTA7GX0m8OyLxrJuNR2OZrIuB1/IPiIXYkVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FGwuvb7f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237iUue025431
	for <linux-wireless@vger.kernel.org>; Mon, 3 Mar 2025 16:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xjaEGavEZhaf/n/BWdL16Lx6yvyWPHtzKIlO2g0w1kc=; b=FGwuvb7fPeCdUYmt
	kSEV+tNt2exVNAVOVU5hX26IERHMoo9UNVgLlvIpctgCziJsB3TAnNYrv80c6wY4
	qLkEGYNmMZ+3bbVGLkD/J5X2+gYwmQgbHjY+SXhE0UMgV6VDdQFWkKAQg3CoQuZP
	04Hvo2JICh4Y8BSk90bxpKmLNPuWcxbZQRnQiqMXnOg9KADvtuDne/5x9zmJfVxF
	JpHEAZInTpXaqZMeqDl0VioKXJijBoA5tbOyfe9tO5uXSqGViZZU/uCgVvV4Zlij
	rAx+wUzKOsj8bXHWXE4/zTqtM0XMxTw3v9iHqxtwk4vJuUuLOpPsUjr8N3epnCD1
	tc0V8g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4558a61dpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 16:01:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fe86c01f4aso9092982a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 08:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017699; x=1741622499;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjaEGavEZhaf/n/BWdL16Lx6yvyWPHtzKIlO2g0w1kc=;
        b=VLh6itHe/SlDNm6Uy+fogIz/ibiTbE798Nvl2x7ymbIn5BwolFeDA/SZ+wY2XAXH0k
         XeKFFdf6etGYyfsGGbf31IepgnW83jYuHCyqzNFQmifNrfWkoGtJD+AbFM3WHGVk+2hs
         xOQoDacMq4KZ/T5lY+XhyRiZu0gY5+1syot9RIQrlA5hY5026QcdZ7JVd6dsweSSsN6h
         yYcEXFUNTiw+oJFrOAMzcCZ3kisvp6+GZqLd9cnG0ksjRSkXo5S1oFnSdtLOQOhZp2iu
         wJxgqpIwoXUReEEOCiWMF5o3VCIDo5nq5stmyYKM+RHS9X/RlTQgzvaiztH512k0LJEc
         Dtgw==
X-Forwarded-Encrypted: i=1; AJvYcCWkGaQANy4pRuMuJKvpyse3PYex+qwpwVg2lFqVcuL7j2u/SsQfBQvgUqv+fjhZ7kI7uWJw1ApOJXBhwaAzFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaAHFj4f5sVNY38XjbqlMnAcrr2pLJUI4yf8upaMtMMH4C+xWt
	rFNyC3E2usgICG4nDXTRceZKj/syf2Q7+NTS6hfXaiD6cyYi/K4kTZh/hgOW0kB4XVphG5XfkYX
	jeF6RR8y25BJCQ14m76T2emvnBdqP5ruiOWdD8aBO/c2ZOxdyjpdO4CYxR9L2haIX/w==
X-Gm-Gg: ASbGncvneaBAAM42uePEnu03P+aGNh51i0zS3sNR2lxDEzG5VGqZA//qgdhQjKXtXfA
	chiZKWga46uuspdJdmoLKkJgdLDSFhF1JgyYHzMlrbeqnbzS28NZ1Xf0+m1/Uw2eferDAi6nNVY
	oB5/OLLi6PIN1Wit5qaBwbOCu3AhxXSibP6om19c26Xmd/5eXsK3g6S7H5mKSoPvfdprqijbhWo
	Z+8zmqCERc1CU+jE0agh/nwK0Ll0fqmP1Xmv40AmhfnkRb/Mpiu9dQfuJVmyeRz7l6qECvXa6r8
	IzxO2esDXKxGcJ7qOdRtHFBHk+k9iuUOyzqXM1vluL5uztL2o7FZKsXPrKVq2BdwnQN+jqeYM//
	lIAlyVxJe
X-Received: by 2002:a05:6a21:4613:b0:1ee:cfaa:f174 with SMTP id adf61e73a8af0-1f2f4e4c89emr22116730637.42.1741017698937;
        Mon, 03 Mar 2025 08:01:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ7lQhwdPu7F1bK4GZ8FGaLSacV4bEWANJf/oaDv1AOnK27gH8LHesKf32x0Ct88uuBV+zUA==
X-Received: by 2002:a05:6a21:4613:b0:1ee:cfaa:f174 with SMTP id adf61e73a8af0-1f2f4e4c89emr22116685637.42.1741017698472;
        Mon, 03 Mar 2025 08:01:38 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf29f4sm8326270a12.11.2025.03.03.08.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:01:38 -0800 (PST)
Message-ID: <0d92ca31-c22b-4798-aa60-5feb66def31b@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 08:01:37 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k: WCN6855: possible ring buffer corruption
To: Johan Hovold <johan@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>
References: <Zh6b-38tGGXo-ee7@hovoldconsulting.com>
 <Z8Gr-IMD-UZTU-X5@hovoldconsulting.com>
 <1f8fa248-c18a-4bb9-b995-0961f7f3fa37@oss.qualcomm.com>
 <Z8VWAWl5UdZQYGgr@hovoldconsulting.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <Z8VWAWl5UdZQYGgr@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aYS8U8NKJn5q7Q_fqzThnUwnXV4csMDG
X-Proofpoint-ORIG-GUID: aYS8U8NKJn5q7Q_fqzThnUwnXV4csMDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=969 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030122

On 3/2/2025 11:10 PM, Johan Hovold wrote:
> On Fri, Feb 28, 2025 at 09:07:32AM -0800, Jeff Johnson wrote:
>> On 2/28/2025 4:28 AM, Johan Hovold wrote:
> 
>>> The ath11k ring-buffer corruption issue is hurting some users of the
>>> Lenovo ThinkPad X13s quite bad so I promised to try to escalate this
>>> with you and Qualcomm.
>>
>> I've escalated this with the development team.
> 
> Thanks, Jeff. Just let me know if you need any help with testing patches
> or firmware updates. We have a couple of users that can reproduce this
> very easily and that are also able to test patches.

There is a patch under development -- you should see it this week.

/jeff

