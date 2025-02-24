Return-Path: <linux-wireless+bounces-19380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D03A42F88
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 22:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE271783B7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 21:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207311DE2C1;
	Mon, 24 Feb 2025 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="liJAnpT2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9A1DDC18
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433982; cv=none; b=Hf1dK7d/eAtOxF6E6+AjXVYEkWtP6bzsJtVE0ivFu+75QSmfGIRnLI69ZQQifm4VI6LexUTj95jhivS/KJ8EKjmcTYukllEL3l9LolAVb9p65VB7xVEueDbq15XMQCbpmNF8ib6un0VrIq9o3reQIUB1NuHDYJ1FQNksoNA8iuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433982; c=relaxed/simple;
	bh=FqyHbgztmVN3XhIN81RGzgzXhBHLbQgv8RUrIL/4Yls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a42Jz2ofn4peARltxMbNtylF3EJrvxG5U/n201w5L9Vuupc59VRwRaUzKzfWlI1DXPQD+rbiAd1PmD3uNnx1KTvftxIsW/C1CO0G8O0njsE46IyFtOJUjE5sLuF+pbpIroqvB0Myp4r1lmWuKvSqQSbRgPUdse3phqPaSyK33r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=liJAnpT2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKOSiH031843
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 21:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rQBYdPhhbnB3jImt8Dp2qnMIdXjmOPfbLJGI/8anEKc=; b=liJAnpT2oDk2F/wy
	XhdAAQElgmesicgqrTOYw1JoiaPNp28gTje4MbUMyHySzwEltJ0K/7e1LJELPr7o
	quRnV1V7F9gtlq2kgRbQiZzqkn28MdzHRwhZUL22uwTFe628SnmdveW7iv8K1pqZ
	0Pwe6iDV05M8uBMZfwYGvZ53QPpU48/vtPES4ujFn/S3KUXADBww5sdgdsOkUaO4
	nj5buVPck2prLIKmKSdTCyq2RXoDZz5WaXy3ByiBSE8wjoIuc6cniVO0EhE8q/Mu
	2q0E5aYM8wlSeSSCem1VrTFDUrC5op/qpPj3RFQYhaHHOMs07ASHhmFVF0IQl2nK
	4L0IzQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y6ntxmsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 21:52:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-220e1593b85so93409995ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 13:52:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433977; x=1741038777;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQBYdPhhbnB3jImt8Dp2qnMIdXjmOPfbLJGI/8anEKc=;
        b=fSXsAC0hItcJ1vwuDgfe98DUMkcr8ZLIpuJnkZ6H3WpSeEwOI1s4VHBn63tDUDo+m5
         YhDMNdqa2t3/tWAP/u5OgQN7WvR+kTd7hI/5K0D08wGwOhFVOo3We/ymtgz9D0lCfU/o
         fZnA0nuogh/7dV9YQf2COrOBygIBQLprmjDtl90lFDicUKSE2yaW5vxpa2RI9075ZBgo
         j2I3Qd98OKI4wihCaboGTUsbUASK0wr1jfPsJ8NNwieq+in1W17MDO0mbL16aZmIKPmw
         oYah0CUfxg9EFq/E+M+EiO0yBEwBt0wbujzLZVgwnIYvy2qatUZ75jf3Ep6Avx2WfYhp
         W+2A==
X-Gm-Message-State: AOJu0YzWoCK8WB7KHuW6Bu6tNjSktQA7pdEckJST2cEX7Dsgm1K1Lf8K
	ek+FiS1+ai+J2o807Z8F7qdrDluUmzUGwunt0+Y4nvCU1wldYCcXhYKpZstqEC8qiNnPidR5/m9
	5KHALV+hLzfTjS3wmV0GqAoZQ/9BRwldytSyu4HnFRCd5Nvkxm78vXn/n7wY7VeRHDjWhbhZ9ew
	==
X-Gm-Gg: ASbGncvo4Qb5W5Y/g9bT56r9otJMuiPYsw1JE6O5KkC0iq9f2fbIQWQ4j2EkD+FEMcd
	EzP2Yp+lWSPYZ+IRsRjYvQDu6301CshP9aVSPtlTNLkmipruVih6ngHt9dXInjyLNcx48J8ZrTn
	xbTbrNsG8WJXDWfVjhCB4vmfz2u2wqBBHojc9YSfpNu/O87sRHdyFqHC20YNXe51y7wAQMCotnN
	5aZh60v0JbfXtFl/+zx3cdq9Co5/ssaRpDHWfdorq4tl77OpIH3J9vt/o1hqrO3KO7pBf0TGR8M
	HarxoplMAl2kWLKI3saotfM+M0Hpk2s68lw66g0dlSUrxzazZUBku9mOiL5cei/Z4QdVe8pTXC0
	37OEyKG1n
X-Received: by 2002:a17:902:e801:b0:215:5a53:edee with SMTP id d9443c01a7336-22307b3305bmr11788835ad.9.1740433977556;
        Mon, 24 Feb 2025 13:52:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNxqZXc94agx6zBE8v5M5+d/Jrs5Jq+vJHfdn2uGcXTqq+Mp8dOg69eypZe/0wZ3TQW41qDQ==
X-Received: by 2002:a17:902:e801:b0:215:5a53:edee with SMTP id d9443c01a7336-22307b3305bmr11788385ad.9.1740433977012;
        Mon, 24 Feb 2025 13:52:57 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a798asm811735ad.189.2025.02.24.13.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 13:52:56 -0800 (PST)
Message-ID: <e4817a30-3a71-4a0c-be9b-7979c40c6ef6@oss.qualcomm.com>
Date: Mon, 24 Feb 2025 13:52:55 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Abort scan before removing link interface
 to prevent duplicate deletion
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20250124093352.481-1-quic_lingbok@quicinc.com>
 <44dc86f0-7775-4d47-9058-17cb048cd976@quicinc.com>
 <7ee0f7fd-7a3d-4942-8323-08ff9c4c8915@oss.qualcomm.com>
 <bc54e1fa-da58-48e6-a148-4a980833f448@quicinc.com>
 <183bc4c7-5ae5-4654-bafe-509d7bfbd75e@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <183bc4c7-5ae5-4654-bafe-509d7bfbd75e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BAtKBaBBUwhcwTGQlADtI11YYk1NoZZW
X-Proofpoint-GUID: BAtKBaBBUwhcwTGQlADtI11YYk1NoZZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=873 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502240139

On 2/10/2025 5:10 PM, Jeff Johnson wrote:
> On 2/9/2025 6:52 PM, Lingbo Kong wrote:
>> should i resend a new version of the patch based on 
>> https://msgid.link/20250204-unlink_link_arvif_from_chanctx-v2-8-764fb5973c1a@oss.qualcomm.com 
> 
> suggest you wait until the pending branch is promoted

reminder that the pending branch at that time has merged, so you should now
rebase to ath/main and send a v2.

remember to add the new ath-next tag to the [PATCH] metadata!

/jeff

