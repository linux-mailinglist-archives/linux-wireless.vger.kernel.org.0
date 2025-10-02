Return-Path: <linux-wireless+bounces-27770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54FABB21C8
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 02:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DEB3BCF89
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 00:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6A434BA2B;
	Thu,  2 Oct 2025 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KS95loo/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31EE28E5
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 00:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759363919; cv=none; b=onypH0plqdPPrasUjprdJc2IRGx3zubKH3MqVNBIXTvZFCf+0iqqRMv4UU1LMjZAb6/Kfn0kD7qxNnR+d1+pVlHBfq8/VpWFknCvCwQbBRitqm2CDB+/phmatlPuKd9YjK0wpyYuqq0Ok/dDwqM13qNlyKN+aCJBR1BAzpsZWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759363919; c=relaxed/simple;
	bh=3csAUGC0lQtMkhL11NZmntLrkQE6J9JqrTlT1+7a9qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDDM8vCfy2DbBs8xUBAt4yLw3htZ9fvgTV8HAvJ41587f86C19zMHmS9KXgZW9ouFoxq/zRq0wUo63BQx0M9R7gJQjg5O9tYlETsUzQJl1/qUmWaOOKs6cCup6OD9Nn+qIiqvslig5qxPct2SG4rZ4LhPARWpzPzsp0QQJvC22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KS95loo/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcP4i001079
	for <linux-wireless@vger.kernel.org>; Thu, 2 Oct 2025 00:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7GDoVk13gSG/i7Fk+1oEXTyiKXG2tcind1n2mdBx0yM=; b=KS95loo/y8qOm/dE
	01LB619cZ5MNkJgs0osiIJJCqF5eeKWI4BYig5r6Dm5yaMSlgwvPu7pJRr8xb9km
	f5UEyMH4fboNvRj0TSvMqt1Yhl4Nc5ejdqyjtGVbAwtpqxSvhoXFMq7YVzJcnGXr
	9sFARGQ+XJQDleeT8fSidYWISrVtg7M3NJj7oSKMozWsK/eFYJhfXLFPDfgdxqBM
	lIxsBwGPaBT9cbG9oFJA8e1wNjjK2ErhQuTUhCJSUrvrLLGpKTNIQ1x731IOd7Dq
	ou6UUEV+NZfGQkN5whdm5hEn8YXWshhoJ//42ZXIP7Nui9wQh/0CYvIvzAKDgLoI
	7V9Tjg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5xbh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Oct 2025 00:11:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26e4fcc744dso2095615ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Oct 2025 17:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759363915; x=1759968715;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7GDoVk13gSG/i7Fk+1oEXTyiKXG2tcind1n2mdBx0yM=;
        b=Uv+MLEgtH+IM1bGqHJA9FXXRE9m/6r/Nd12JjmRKB3FzV+CbJ4QgTV9mvwjAgAUSfY
         cU5n4Yynm7kd2vJGSGtk6UDYS+C0/0b7c2DA2GpH6i4RQ8bP+1BHJJl+uowika365scR
         PZOpSYEBIHQUPE68QEz0OHb+Z4bw/4rweii96PdbAf+kbKLFB0Gc4xzas+t3rKz6izXc
         jh0tUndSpLDAk42/faAATeplIZJdodmuKrOw4/uE/yV3nMXuYU49pdI7GRWlUZPJ6lIy
         ilpK37lYZxoLMPilQWVzTS8HiMf9ZV+sp74QJnPpimiIrw8IjJOQkEvuK4M6057Sqmcb
         Bfmw==
X-Forwarded-Encrypted: i=1; AJvYcCUCHy/7SSCiPBgnF2rt/3RqZpGJfNuyWrvwjhmOeWzFu5m0kL1Z1ntDztHB0eCUK9AhomGkbFAYWNLMJwKPhA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6X8KzZeqJ8pk0JVyALBemJakWxBqSo91z8i7z67cqc+vj8Cx
	PghXz0PqzwGk6c9F2i8CIOwe1vev6SSszGbeTF0xp5g45L8cCwY5PRRpDvVXPFGwgAaKVYeFwfZ
	fQYzR2c8lXoJC2FKXUuLiUhdCbtcyKoRdk/id9zOCp7k6IhmqQLKTeqCb6nZr8//vlQeIxJJlhA
	IVCQ==
X-Gm-Gg: ASbGncsZ8ZmrjRMRFPzecBebB2xDsaWsShfVjec61mr1vLYzLZ5xpxVTu+UeXWXtAes
	+9IXaBA9pd1wXii/OrFWaHXyzbcGej2WnRscHSl2jp/+PUH9zlPc7i+yAyx4RH1aAj0ZQaujh57
	PyxfOFUGJSKjJC0PxiJK8ByFEaxo4ficjFrdU87zQpX5PaBmMLqwhrxdwavrUUsTrkz9uDBgBj9
	6F0LmjIL/ugYFWpRRvCG9xATXYkT/Ci0Pkbg7ls+wDd1q5K+++5VHA07hr1FQ4CXudajHyLy09R
	7XEh7DjRFOa2Hxh/f1LG/WqBJnT2Lb1EPSg2goSJa6AKmZ7/8Ogg1KJPSklT8UpObVi4bI9i6pB
	FU2TMYVJ8HVfYs3VOCkMfnMVszJGh0faHVb9ygQ2Raw==
X-Received: by 2002:a17:903:46cb:b0:275:b1cf:6dd9 with SMTP id d9443c01a7336-28e7f4b675emr59643005ad.52.1759363915280;
        Wed, 01 Oct 2025 17:11:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvke3HKqMMoI6anLw/qniZeIfk3dGZdV4blSVdFHttUYs84VjI/N9gM+/VbkK/eJlRr7g/ZA==
X-Received: by 2002:a17:903:46cb:b0:275:b1cf:6dd9 with SMTP id d9443c01a7336-28e7f4b675emr59642655ad.52.1759363914853;
        Wed, 01 Oct 2025 17:11:54 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d125de3sm8032175ad.39.2025.10.01.17.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 17:11:54 -0700 (PDT)
Message-ID: <85b5f6ab-a372-4ccf-b41f-67c1d22df3f0@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 17:11:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Add missing platform IDs for quirk table
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: jjohnson@kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20250929192146.1789648-1-mpearson-lenovo@squebb.ca>
 <83de6105-ef4c-48dc-8960-430893ae253e@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <83de6105-ef4c-48dc-8960-430893ae253e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9a4KjG5wzKAR6iq6sXi1Qn5CSk-C00cu
X-Proofpoint-ORIG-GUID: 9a4KjG5wzKAR6iq6sXi1Qn5CSk-C00cu
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68ddc34c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=W20sZ97e4VelUkZbdCEA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfXz+iqTKkUO6F8
 RCGZbyrdX4fxbNGB8uweBdmkIz6kWrOpZYz+f7dWJBQqJlpwYWVnvVG6EBkZJrytil3n3ont+yV
 67kZGBzITIQzljAvu+cAAAbZFiQkSI1EyFfkBsEutI9dZ87Ox8tdVN+eSiJe3ENAXchhOUq0XwU
 2tDd9KG7jD/BX+wYWZOHWoEmJERP/RWwsx/KYIzc2iI6x9rrwBja+r6f26Mmc7Lc6aaN+d/wjfr
 9S1Fsh5rBZTGsTXtoSBxqtA1fxwAlOazYce/wz1ekBhUpzG8nKLnvef4jtBsgzHtXa2vDP3y9N9
 tlmFi1PUUrHq8euiznsa7W6rfN540Q4XiBdoTnmsu0TgZ57ehNlyiDtVpEklSLyqCenUKpKvQKQ
 i4K7jnJ4ijjW0U2PwYTpoTZ0cPzDJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

On 9/29/2025 7:17 PM, Baochen Qiang wrote:
> On 9/30/2025 3:21 AM, Mark Pearson wrote:
...>> +		.matches = { /*P16s G2 AMD #1 */
...>> +		.matches = { /*P16s G2 AMD #2 */
...>> +		.matches = { /*T14s G4 AMD #1 */
...>> +		.matches = { /*T14s G4 AMD #2 */

In addition to Baochen's comments, in my pending branch I've also fixed these
4 instances of missing space after /*

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=79208b9ac68a7e71ad7e60cc37038c35b2b4252f

