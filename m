Return-Path: <linux-wireless+bounces-30810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AE0D1E0B4
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 11:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 139573065E19
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 10:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25FD38944F;
	Wed, 14 Jan 2026 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oNYKedCN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F7Z7z03A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C743876D7
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386509; cv=none; b=tyoAeteyXinldhMDOCWexI1+iMt9odoHsLIP6LZNVGCNx0MzFiJFzU2ChJZEkwDIAc9aK5Mbhc9jvwCPlYUL1iPaQYjTpYRlDtA1QeYD26w6eUY5F3tmmd3RyWFbjwUqCXLzEJYVr47+E1JvE08qjS1k2FJGvtdFSBK5HH/+zKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386509; c=relaxed/simple;
	bh=8IkNfw4G/KgtmavLqOFQx+pcGGisZ7pjVp3POO2WZN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKXrVx50CPBNQRzzPaREo4onRlpHsu5C2EpdOwsZ5ekNiUBSO9fk4yT5oXVtIyKT6x7hfnGiHYf3hX8gU0wj25Sk/XGdRw1L9bCJCACXkA8lDITOwLMPSUIANqdQ23vlKU+8myTJHtzx1HE7x6heFnfsJZnb+4wxSpZO1zvaj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oNYKedCN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F7Z7z03A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E7jVEk148452
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 10:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aF9c1EXyBTx/L8NAjeL67gg5/TBchObFfqb9kwdQNdw=; b=oNYKedCNprP37ee4
	9WIt1tkoIhHUJJOMyrjWbqK60OPWBWBJEO9Co3yf4XLdCMfd6tveYUIkY8gbaDi4
	x1FBvH9ExbdI+Te8AjqJNYmxkagNwV6vYDAHlv2YK8P5fTIs+6hlaMFlPhcBEmhq
	K8ohX1+hi4CNLn7n6aVAy1HXhjfJuZXq/4Pdf70VoHxEqzpsuKAzvQHYma44CGVO
	HFBT5pmzAlVgOZvOmPcwHryJVU/FejaQ8KWXJpIDHFnHGUrAl/+qVeq5Q/Y6L7y4
	PfVeRcuKUeVIivUSRWgHiR/lEpQCiQbIHZJ5iiTZ/mdAckkM7uBOydYyEu6a8BQu
	33xWbw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp6ragnvq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 10:28:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a13cd9a784so76041455ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 02:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768386505; x=1768991305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aF9c1EXyBTx/L8NAjeL67gg5/TBchObFfqb9kwdQNdw=;
        b=F7Z7z03AYyMplZx+NB7+hR83LVBxARJtRnqO2hkl+KqD+W8xS5E63ijsevl6nC5AEP
         VjooIrgtI3J769UY2bcmfyICjSfYtWkmerIYyZgZSKhEiw46dyhb5uJzeD41LbzD9fas
         uuW41lzCS6K+TGVZYZcwC60usrfmNtNkY6OLFm12U8mOjZoEW5pU/rZD+uldG94RCQn1
         u5RfFHcbK6U+dQ2eKP/40iUU/IvVNvj4XP6XL0xBVYwX1XWxm05AMMGXAmjIiytKIK8/
         soTtqZTGFcJ4Qf3Ocwtu8Xc474fQWpASg2QNJngIJ2MoyO9sE9aM4pu5xdRf80dcloXT
         dGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768386505; x=1768991305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aF9c1EXyBTx/L8NAjeL67gg5/TBchObFfqb9kwdQNdw=;
        b=c37gVQkLyVQejS6c00d9fKZXbLeRarCfaMb47T5qO2I8A6Dw9K2riqm8zaiMMtrjGy
         IO6fpoEEESO/NTe1a+qX1mlm3iY2m6VbuEs5kBgCgzPZH01GjHaLYu7YthLjvlN/xHyE
         +jPY/czmCex0qTD+qoPIYCFGpbPT9rI/UZNxSStYoOOqLXT9ap2mfHhLRAinP7u8UC2P
         QhK1Il1uyBqslKUIxGVjdd6nZHQlVyylcY/BnZ6vAZDLnWqpOXD9/xRfQdm/3rLEQcd8
         8hDqMmwc09cqypY6MOA7jYXH6HlJivSoknVkmuWoamlhwXTmygxncGIjr7yEyvjDai76
         QLNQ==
X-Gm-Message-State: AOJu0Yx50yAPtYLZa59/6m/C+lKpDBO/aKA1n/Y932+k9GOvPGZlvZ8t
	EWmzA5tNQX5V3DELgN7fozsqY6XgSr3xl6+ot/uzo5udgy8sIINUxjTbfAKfl3Vwy5/t2ZDo5Qf
	44/QGPI6p4th4mcHYpGxHt3vQyRVuIzmgsbpUH0ByYE6vptdzW14THdtbckT7BohGVAZ4Ng==
X-Gm-Gg: AY/fxX5D+mWFhovnCGygKWEZKowsYMTCccI9z3NToa4s7CVXpkdzgTFduCaCTdOcfV3
	9XVqqUWXTKE3upQKgWCjeaxqzsH0HQS1aEQjDRsE6H/96ZGViUSNe3cSLodGPdvW/ORPvafP8rF
	Z3DNHjvLp+Hgt9U3XL7bt2Nr4uptWkgtOEH/0TDQrqj1QYPc0LM0v4ywAcgkbhMI9OrwJd4izYC
	ofInfLWOE9J2Kdgo0lofZ/cNwc2nxrYrj2LnS2yL8YRtdCAQYSK82B4swILF3+aKkcqf0KK8avG
	TlzDuy+KCcR2Wi+8CN6jcW5bURK5V1kATcvz4xR5e58A5IJTezPZt84MtOHwI15Gz82FtXj2hOV
	QI75rf1saBHsYdKWes01A9feEGlxpfn4HzA==
X-Received: by 2002:a17:902:d58f:b0:29e:c2dd:85ea with SMTP id d9443c01a7336-2a599dac14emr22251685ad.11.1768386505056;
        Wed, 14 Jan 2026 02:28:25 -0800 (PST)
X-Received: by 2002:a17:902:d58f:b0:29e:c2dd:85ea with SMTP id d9443c01a7336-2a599dac14emr22251475ad.11.1768386504535;
        Wed, 14 Jan 2026 02:28:24 -0800 (PST)
Received: from [10.151.41.62] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88c2sm223194625ad.79.2026.01.14.02.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 02:28:24 -0800 (PST)
Message-ID: <a7c854e5-63b9-4ec2-b53a-9e88db5a172a@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 15:58:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 4/9] wifi: nl80211: Add new NL attributes
 to support (Re)Association frame encryption
To: Johannes Berg <johannes@sipsolutions.net>,
        Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com,
        quic_drohan@quicinc.com
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
 <20260106152503.223216-5-kavita.kavita@oss.qualcomm.com>
 <16099966d1cbdccc5160c6aa7a2615dcfd0060d6.camel@sipsolutions.net>
 <036322aa-0c90-4735-88cf-76fa831a9ec3@oss.qualcomm.com>
 <f2292ae64dc0da7e68e025a13327270d4a65cd87.camel@sipsolutions.net>
 <745cc8e42be1751c7f7f18d39d85b8e81fb0d951.camel@sipsolutions.net>
Content-Language: en-US
From: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
In-Reply-To: <745cc8e42be1751c7f7f18d39d85b8e81fb0d951.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA4NSBTYWx0ZWRfXwCsrAa/sXOFW
 cegFXxtrgY5UuGGZxJPRdb2d/SR7XD9g5Pz0EDc4UK/eX+ZNAkz3Poy445R+ow6BR3q/ERPip3s
 zAyca55wn1rFlvbgmqvfA7vPQ2MeWox6k2qizcj4LSDnD2PxjtrEPktwSfSZ3lqrxGFwFVLqnC4
 SlNYYc2ME/6zfSepy2MmWOOfhv2sPqU6VV2h3CaogmkZJGFWjNEiDrfhYkxWIUzm0yiDjeIq90j
 RsNmVqpa1NiWgSxty0pofya6hZC134eTM5IdUlKKQ4npKKt/oREB0H1MlD34IerpeNQgDTt1CCi
 OJyoxK6uJpe0sw5XoczB7tBLkgnoJ9X0abADWB4OSGsYdvyyP3rDEeld/GH/idTqIyTw1dC2/NB
 lK8Zdl9v/hf+N8cmCxQkV2NB4wm7882fwY0wXBwGmXY/Zwqe7STEoOnx+66IfK+YLUguhjVgl3A
 Jak7DDZ7X09skUjZlLQ==
X-Proofpoint-GUID: 1vt4d7dF7WP0rcipFnPhDcsridejka70
X-Proofpoint-ORIG-GUID: 1vt4d7dF7WP0rcipFnPhDcsridejka70
X-Authority-Analysis: v=2.4 cv=L/EQguT8 c=1 sm=1 tr=0 ts=69676fc9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QRNfBpVJ2mjVg5NCklkA:9 a=QEXdDO2ut3YA:10
 a=QYH75iMubAgA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140085



On 1/13/2026 4:57 PM, Johannes Berg wrote:
> Sorry,
> 
>> To some extent it _feels_ to me that you're arguing they do have value
>> to the driver and I just don't see it, but then can you please explain?
>> Or maybe you're just arguing "we may need flags in the future", but then
> 
> That should've said "we may need _other_ flags in the future"
> 
>> why add the two unused ones now?
I agree, Will cleanup all references to "epp_flags". Thanks.
>>
>> johannes


