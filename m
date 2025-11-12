Return-Path: <linux-wireless+bounces-28874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFFBC53473
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 17:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6645656ED
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154C343D84;
	Wed, 12 Nov 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DA9iyE4n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f5OHZj0s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C21335544
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959489; cv=none; b=BH+mSMaOdHPQteTPWsado+DfoONqc3R4cJH900YDTZUkANKTmZN6x/eP+i/b4L4x97b4QpR5AnSjHhfRjHbs/RYmuuXu28MZukcAooCxH0tpSzCI+Q/AUBlT3HnTyIfUBs9DwaX2O62+vmkJhF9dykSkAOnjFdSj0oebpDS9XRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959489; c=relaxed/simple;
	bh=yjgZrc0z57JWGyavP6sFiLRKD3CrIiUEXPrB5cG2BMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsgJIoC8CW3F10ItrF+gZbGbRA27IIRwMdJOdja7TetnK1e90TD9x7IiSIOfhHsY+xJf1xpaxUX8INAO/Gi9EnMDHM0mRsjJFdsO9QWAk3PDd+uIvfpcIiwG67Ycl80KYp3nnnT1jek6IB0EqKMz+kwMckvZ+2C0nDS8ouhlji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DA9iyE4n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f5OHZj0s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACDsRYh1314461
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 14:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZEROVcmd5veCgeLZc8ZMDHausStHe/ePcLVUS1KczXw=; b=DA9iyE4n3zka01QN
	OUIbgpHWWC9iG4I8kOUZbbUvhgtSBxBsSBJCx/7kBKprUT91XYewhio0qTE7TUDS
	tiMPYsG2UOPLpqOHZAywGnB4VGLq9uFS/RxRYMJOkGcxa18lxGjuQTxTV74fJtJ9
	6vqXeJ/E/TWZCj2pckwiWAvGG/HKn/XYeb15f1FYlfZrXu84aAYzL6S5wWl9t406
	NZSuYzjgmNjdBVzYLXvaoFKUbpZCXAh9Txh5hiwFbuux18W+u2tP6T27QhL+uO5y
	gEexHJEe+6oW3HkRS41icujvflfOWgqoU5XD4f0Y+0cSzLcqH7GDIP1yQ+YOD4mE
	c9DZEQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acuhg06fq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 14:58:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297f48e81b8so16263935ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 06:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762959487; x=1763564287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEROVcmd5veCgeLZc8ZMDHausStHe/ePcLVUS1KczXw=;
        b=f5OHZj0spzM3F+e2KAmIROuoCBnaWrBeS5ThdgB7h41EXg4CuDqnhLrr/EXW4l9/0P
         BtQStSm7wT5MDDMT3Sh7i48TNosviOE9cGp/o3zd5r5lDxX4vypsj11gk21zE32dKumO
         jpoLY2u27IA7LVcHYjAfMMbGg5zc+buuc8yLixta8VA3cERZEU1mQpShFGIvzVm+x+Oz
         4LVz+Y3KXHxxiwa1UX0JxpBXFWhC+hAwNvyOJ5rJipfofyKROOb9zt2e7l82MvR4W3Tg
         vNl+Hbn4d9cGi177CwLITevzXJ3bIB+qDBgCXR2TH88l+2mOlGtenf4Nua3D2cGWlXEi
         NWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959487; x=1763564287;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEROVcmd5veCgeLZc8ZMDHausStHe/ePcLVUS1KczXw=;
        b=KQD8/ja1PnIMDKycZvKHRpBZC3JmKUD8IyaBzfdLHJwCiO1go3xCgLX/NLTc7RCQIC
         6fBLD/zSEiPGpMW29qbhk/AW1TlkTG5V9gT+FDBih62cUgt+RD0G9g+ng3/b5GlOCm3o
         Vwx0fQUI21fPMrFhss6ReTDHFgEzdDWAppeETiFz6bqOOgu2Jh+F4P+QtKp0TpF+ms5v
         oVhmCkHHQH6rPec9YNtNBGvkGX1UY7GK6jKMpvjVzuhlj8hrPxf7KCywVREXczntDw33
         KiRPiNsVkf9mA7LHKq2dc2SUSxlI9ve6VTlcQ+oy0LcLxw71fkoipuZh7rLixjMy8fLV
         131Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/bUg+cJO4BfQwwpuohOUwPyn98AUbVOKb/j0yYA1832HiP0kVsZbZdfVZkUi19FJLzpiH9Aq+atsfdbIdlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0lM9he3OZb1qpPs3mJXAI1Ci3u0KaTDWo0TStCs+nebq9iW+z
	M5GLSl/wwyNnpdXFvBoR1UGgun6YceBHHfnuEcSRQZJMIBr2UVp0ZYgpntWrPR1zq5c3+T/ezX1
	1AodL8bDdFiZdUxv1u+HVkHfWWWPQIUtvTe+ae4A5cJqMBGbUpG9cLHjsYwnQDVx1Cj8/Mg==
X-Gm-Gg: ASbGncvDO6aMr5Y2oO5fgcNn5Ph9hPLdhVNaLi1Eyie9uYhuLexlkABl8GdYixJtXbh
	h1VD98z+Ssl43n0C5vNnBXxAB0Ka+0C58NXkJ7ANWq1Jhjp+RrAzErqKmgawTNy9x/gLbcznYU7
	AHK1Z0DKNdE5jnbkPge5w3y4yHCBksG8sdPlR/1f6KkxW3vbY315NoPk9EufTm3M8xH30VChsfo
	2E5SyTTH4d4t3BLuMpiS43SWbP+FTmy0ZUl0b2ePA3UP4v3exMlvRqAZV86HGrBnnOn19Cjmrm8
	1eSqXZ5fMelkD01tiavVLqz7DrqFp0ZUP2Bg16HbSNC+vpF5jVvlqcknE1QWQ+KQ8VZJHj3xZ5h
	8Y1K2IdY8Y8Uy7Ai3bZoSgwW1DUZEt+gvSRwI67IlcRWhJuFhoT4CoQIxW24=
X-Received: by 2002:a17:902:da91:b0:297:c079:4c32 with SMTP id d9443c01a7336-298407db038mr93803995ad.11.1762959486786;
        Wed, 12 Nov 2025 06:58:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrpn0fT+xmTQ2KE3jNXQxBgiCrfh9f+Cowdb1Z+6u8BAS8ehhTTnn4URI8fzcTRIFNufHZHQ==
X-Received: by 2002:a17:902:da91:b0:297:c079:4c32 with SMTP id d9443c01a7336-298407db038mr93803555ad.11.1762959486231;
        Wed, 12 Nov 2025 06:58:06 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc10c573b3fsm1834473a12.34.2025.11.12.06.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 06:58:05 -0800 (PST)
Message-ID: <c18877f0-1b48-466b-aa20-6207661030fe@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 06:58:04 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ath-next-20251111
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
References: <15a98cae-0274-45f4-9b8e-be6fa9720884@oss.qualcomm.com>
 <7d445736914f971bfbf89b3480cd6552434eaf7f.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7d445736914f971bfbf89b3480cd6552434eaf7f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NbnrFmD4 c=1 sm=1 tr=0 ts=6914a07f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7SW9FmOQa233CxgTmL4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: X14cFryOxiVKMgOX_YztpNTH9PfLVBA4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMSBTYWx0ZWRfXzp+oAhTSJ5Ip
 ArSkaHk4dWQJgcUHoGQPSeGGgGZPFDrdQAK7ygJev6L+Yel2AXbNKOAEFi6eu3paxSrSY71f3v7
 itLkIi1dMJQcF0F/gghCnwaq0O4JsmMCmDFSkdL7rt/tv9r+6TFKnmYu7Pd3VVLSnv8seOqVpJ+
 xFZ42L4U1wIiiYZU0hLAPxzI91Vs2nFC367BF46lPqWcAknKeklBDytZQIARMF7GqzOtbq9eEyl
 CtJT6bQFstzHJ1g3x8a1BCbuAwBMIa6+k8F+W5B5I2WkqpKMSFL/v9QpWRGvFjN+ngEgJ/7y6op
 nUkGR4oWNEuRDqU+dGxj9TqRnOT5n7xbHC9OHadmB+RaciKweJlZFj0D1vKYyNXTGV7Cy0rWotC
 N9AN7ig0gsx+8zOhFGfxgXzsP1gFDA==
X-Proofpoint-ORIG-GUID: X14cFryOxiVKMgOX_YztpNTH9PfLVBA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120121

On 11/12/2025 3:51 AM, Johannes Berg wrote:
> On Tue, 2025-11-11 at 09:28 -0800, Jeff Johnson wrote:
>>
>> Once pulled into wireless-next, ath-next will fast-forward, and that
>> will provide the baseline for merging ath12k-ng into ath-next.
> 
> I just sent a PR to net-next with this, so you might want to wait until
> that's merged and I pull net-next back, to have all the current net
> content as well.

Will do, thanks!

/jeff

