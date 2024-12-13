Return-Path: <linux-wireless+bounces-16389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3669F1747
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 21:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E856188729C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 20:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16921547CA;
	Fri, 13 Dec 2024 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HKcaCs4o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1C190471
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120695; cv=none; b=ZcALBxqBL8YXTfSbxGS7UF2Ha53ZCMoGtWNJ6RYSw2MyreOzEItvUsIWRnqOQZ1OmqAB0I04/8xxs+Hei56kmQEdvRixh3c5Azk1ruQ7E1T4v+5WWexFE3xSPxNhxc25AKSL4h7fv1/0sXnDv8EEKhuAYZvEgMBomJVb5IBSScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120695; c=relaxed/simple;
	bh=ezQFxgn2mNbyhDn9y7xYbtkzW81Vzgz4dWRsgR6ZHUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwaEsvn5CG7IXCqPICJQUarUVd6ZGKGUyacvf5SSiGQWmyr1Yoi/MEIRteNBryXg8x8Lzbjj60k6LI6xGP9sZ5YmT18kBfTwn35jsJ5GNvt5OeCU9jbhJkmmGG2ncvKsq2zybTecIMmlGwTcC5vYg5dJK8tbGc5dV3NgIR8sRa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HKcaCs4o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBTqnY001416
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 20:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6s+b083W1wmEUiIkmlBJcoQMHek1L8QCLwU5cYw5Hjo=; b=HKcaCs4oDy3+zp/o
	qDbuCBfGiaESxJSlVkfkx7i6Wfe4W0U2saYDumey2DYxFHE3QMTbD+vxUK+FL9/e
	fvp0GpgpgC08Ghk7dE3EWSq2qrDovxkecjqWhVcHLrL96gq9jFmf7BM/1mm3hHQ5
	0AzMGseu/Fipy8OrJIac0WMga7WVHFUI89zPW/1LAY1NKNppP57sA2bjUo3Rn0bU
	XH8nh7Fe3MId7USsVFTJsiZfgj1cE3NKyHjxgGkVhTzilPoqeWJZa4eRTpvkBvLE
	Nfv84bxLg3n2UpbsXHv5+eI/O8ajK+NCO8HDBODZzXJa3IpieDyY1G3DcTYnz5cx
	m9MlWQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gm3s197g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 20:11:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-725cab4d72bso1678200b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 12:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120686; x=1734725486;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6s+b083W1wmEUiIkmlBJcoQMHek1L8QCLwU5cYw5Hjo=;
        b=st8M5MOlg/RQR71Jg/GfjSuS4B07DOJdlH9QmmfgE04zh6kFfClK7JFRm/dHn+CYQX
         TfRzgVAn7D3ABbfCFZgfXxafjfy7gcwSlji7WH9QnO+PCSFqtHLtmfxLlJ04fLAyqL3S
         qrMih/03xx/CcGBXafbomsCrjltHUtn2DiuKcGgsYJtpaDzvNomf+Lm9ozwwy6O2QIQR
         t1z7zXRWwouFpZhnmQVja2dpVd3AMinPyf3kQ3lkjFg18Wdg9qImiIjeyjusuBpujfzW
         Q9rW4xtb5TUxmkE+kEEezU0z838YeTDjTKyMDXgWqBE+vh0IW8IDEjNDfKB+BknLgsYI
         Xlpw==
X-Gm-Message-State: AOJu0YyVAp39qfUQZZR4MlvETcW/AU8rVcrwBOkCh8fivicAlSTh30q7
	a5n20vYGSMv0cW7cOjoAErgeoUbVsEk9opKNDz3Q1uqloNoFmqEdENB1BxQpLosQo8gY1J8ufs9
	3bimRpwdF9Yx1hxeZN0ZXARuVeLA2qDI+pPRoR4rAQ+oniM9juDWBqTQJYPsg+Nir7Q==
X-Gm-Gg: ASbGnctkVrD6OAu/vXvYKtP7nKfAZzRKkynQiNJAR7SfVI//Sx2AY5YfUyk+RJCyGsG
	spiG7DE0kS1sqzCKQMgHBd5NwiF2sqNZW/i6cNcmp4uUyzIE6N9LS8sIxfBPO+C9mw4D8hhHlAs
	GdfcSi3aNAtgdVSXFhrLH7yJsdouqVj90oZCts7LaVkNmu3aM5/1HodwmxnwY+cTvJyhG5pUMVV
	JW+B9MI8mMm0mFaWqMv+apI7sto9OndLAEvRemTMY6YVMDWDboV/ZziyIxsyJJmWUZmKVbdKuMV
	vXRQY6ChgEwqPsW9X0UaHcxeGqU2bc38J6IFSB7eaLpTuUFmuA==
X-Received: by 2002:a05:6a00:238c:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-7290c22e8a5mr4963774b3a.18.1734120686505;
        Fri, 13 Dec 2024 12:11:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELYBnt6FUzd41iF3qq8MoZKpRcUawqKnp7+Wij87neydzAO13IvXLfbO//EYJCdES4BatM6A==
X-Received: by 2002:a05:6a00:238c:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-7290c22e8a5mr4963740b3a.18.1734120686071;
        Fri, 13 Dec 2024 12:11:26 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac53cdsm187916b3a.23.2024.12.13.12.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 12:11:25 -0800 (PST)
Message-ID: <11d8f3a6-3942-44dd-9c41-fdc645e5fdeb@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 12:11:24 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ieee80211: update Indoor AFC standard power type
 definition
To: Johannes Berg <johannes@sipsolutions.net>,
        Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc: linux-wireless@vger.kernel.org
References: <20241213121146.2398269-1-quic_vjakkam@quicinc.com>
 <a850fd692db3458301eb5b7388110a3ec6ec0d01.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a850fd692db3458301eb5b7388110a3ec6ec0d01.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eCOYoP24wclqy2CD-bMjLhQwdIsi_jF7
X-Proofpoint-GUID: eCOYoP24wclqy2CD-bMjLhQwdIsi_jF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130144

On 12/13/2024 4:16 AM, Johannes Berg wrote:
> On Fri, 2024-12-13 at 17:41 +0530, Veerendranath Jakkam wrote:
>> Update 6 GHz regulatory info subfield mask and Indoor AFC standard power
>> type definitions to align with spec changes introduced in the Draft
>> P802.11Revme_D4.2, Figure 9-896 and Table E-13.
>>
> 
> Huh. That seems like a change explicitly *designed* to break backward
> compatibility? Should we accept the old value from older APs or so?
> Otherwise we can't connect in some scenarios, I think?
> 
> Or at least should we say here in the commit message or so why backward
> compatibility was broken, and that it was for other clients that didn't
> behave well or something but our code was already fine?
> 
> Or am I completely confused about it?

IEEE Drafts sometimes make non-backward-compatible changes. This change brings
us up to date with the language in Draft 7.0 that was ratified and will be
published as IEEE 802.11be-2024. So if anything breaks, it is because it
hasn't been updated from the draft to the ratified standard.

/jeff


