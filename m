Return-Path: <linux-wireless+bounces-16114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924369E9FCE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 20:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8161C164E77
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 19:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B81198823;
	Mon,  9 Dec 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MCBtfDJg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05315853B
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773477; cv=none; b=jXdfrZ32WQGCyEErjP07WqQAiLMq97Wu8nuaeCGUDDc2ExMxNE1QEpKTDcRPwI3D+UnwuXygakiG+biOLEYir89M1Fg+Wtasm/bH4zdyKkEhDFncpBJilYqr3iKjwZ7ex0QsnsKSVF9pGT/gMCDljWUEc5cApUKNgU1Hs0qXPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773477; c=relaxed/simple;
	bh=ow/KqxCHyunMrsdOQ2Cl+Qlj34e+7mwsg3bahRpKpPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4ApUKMIgL94sOqyTH6IA/d84S3Lbtpyg9/vwthUwKA6J4D4YOLq+/Fy5psHq+viD5pghByshObfCvx7n7NLNlxiKRHgyP0UsAaHHLllQYrQq8uZQGjDdzu0MpFukSE06PdVeVI4ga85d7GCZ3MKBI3Ffth/y6stQplHqv4T/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MCBtfDJg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HHAGI002489
	for <linux-wireless@vger.kernel.org>; Mon, 9 Dec 2024 19:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ow/KqxCHyunMrsdOQ2Cl+Qlj34e+7mwsg3bahRpKpPk=; b=MCBtfDJgkaoML6v9
	Ih6npGzME6NG7kFDPIwNCLVI2OyomU26CMwwiq+xxd4LAYTBClpphk4IS+SQx3nF
	Yd2ZjdIQLZNYbiBp8PHCbbuhRolnaaGX+pXNHENjheYJnd0sunqfelSFRlfHBpGy
	LRyI3L7HWBEfqsj2Clxp2YFxMLSgRNb2MNuMpAScgRiXN9hOpf6kIGTpOIb7ccYZ
	Xv5XisRvKziffTJ/DUwE2Okye5ccsJywYZxvFFxWs+6y1UIUMxpKCVFLK0nSAYol
	Y2xtwJ+euef054Y9H2j28FXeEFivKyu5DqTa/4SoFjK8IOqvly1pSiYSlF//Qnbd
	DEloxw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dxw41sre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 19:44:34 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7eaac1e95ffso4004403a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 11:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733773473; x=1734378273;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ow/KqxCHyunMrsdOQ2Cl+Qlj34e+7mwsg3bahRpKpPk=;
        b=jMaBxwlF4fKBOmJSPbJwcyGD9NVyS/XGFrbKkNCRLqsfIJOpLi+hga9XPMhCdU50MO
         AS++t4xOuA53X0xJ6ry3F1lX7WaVJ8fPyS8H6t0/imnGxf5sEGXOCbrTlA9nD9HGGPXi
         FoVJWwYpEhkJH5XF6Y9D8qjqIYmBxt2xOnOVnzrlYiOl4RZ+rsKo1ZIAiCs+I+7FImmm
         sgvwrlgxoVk/1nvKET6s/xwjlF8UUKWQztO8kgJNAiKa1XFVjCTKFOLoxd8sXzWrHHUg
         CvO0WwxedVHBkIPfcg24+VB7afPVCE0UxdC+msBf+ZioLZPku/JuyOnBDQqjBfkKYMUp
         WZ7A==
X-Gm-Message-State: AOJu0Yzg/ZwMUkL98u3AjAQ6iUCMkJg3aKSJV4oFubWqckue8vnseMgC
	TuzuYTsAlmx9/x5nsHi5XpByJ5jkk0V0PCH8BGGC3stBcykm14jCdEv/L/5Jcenrgu3XcCfu5wn
	c8PKuCJpXr1cbJKGgWeo+wXhmMOnaehzBbAYoof8WwpqG9caq4tPOP1ly0fRTE/g0OXt+SzRfPQ
	==
X-Gm-Gg: ASbGncttC3/ZnQqnpjGUSENCLcRw06HHwGC8Nw+1nZWScbcByiacHtfeHv+p8iQO0Vb
	vcJZxquiI0itMZ97pORAkpMbVL1RgmYGnGGlyH34/2z9iopBrDngLzeXLlBvqxTapg8vVkec5eh
	S+eEBj5irfPVLQtDPUWaEaAkM9vLoAUG8ZceJJtz388PCRzJpRqEk8JJ67i4v+hlmyykdxAPSn6
	/vuCvhxzkZnAhxvGsSzGQB/ZoPvQdfFKRgzGd87neDF4bOGcRW92fGi7lsMfTomjVZ2sfTjlLTL
	yORf0JDGYla1kmtmDhiPegFJ1IKVb83KLF8IPpUHOu8=
X-Received: by 2002:a17:90b:38d2:b0:2ee:b2e6:4275 with SMTP id 98e67ed59e1d1-2ef6ab0cf92mr17473225a91.26.1733773472952;
        Mon, 09 Dec 2024 11:44:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHusWsAEuoe+eEdRfSy/WitEZTG7LXYqOy1oR30O6/24EOjzOheiSTBhKw4SCyZ3PVopda7Q==
X-Received: by 2002:a17:90b:38d2:b0:2ee:b2e6:4275 with SMTP id 98e67ed59e1d1-2ef6ab0cf92mr17473181a91.26.1733773472589;
        Mon, 09 Dec 2024 11:44:32 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef8fbed9ecsm4267817a91.10.2024.12.09.11.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 11:44:32 -0800 (PST)
Message-ID: <6f9bf36e-6866-4c83-a165-dd0af49902d9@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 11:44:31 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] wifi: ath12k: move to HW link id based reveive
 handling
To: Kalle Valo <kvalo@kernel.org>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20241209185421.376381-1-kvalo@kernel.org>
 <20241209185421.376381-2-kvalo@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241209185421.376381-2-kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VX1mX6lImoJtqJ5DGsX1qYUrOtsF9gGF
X-Proofpoint-GUID: VX1mX6lImoJtqJ5DGsX1qYUrOtsF9gGF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=672
 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090152

Subject nit: s/reveive/receive/

I'll fixup in 'pending' if there are no additional comments on this series

