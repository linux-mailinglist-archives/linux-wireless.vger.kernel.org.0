Return-Path: <linux-wireless+bounces-18275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE4CA251CB
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 04:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE961882543
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 03:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B1F4414;
	Mon,  3 Feb 2025 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NFPBQYdd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F379EA
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 03:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738554758; cv=none; b=ZoWAVMDdLoJTNdxUn7B3lwK+S6wD+XohEqdcoUqisEeAyCXX1lynTBmhnEvcy+PCQXr/P5MX/LC32+310XoKQCNQg5tCr+wShiypqu5gwGDjnyBCQxZqBqX04DZywvIHkjURNo8EYe2M6YuPv4TD1X9Xe3O4h1O/7lmuzAjjDTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738554758; c=relaxed/simple;
	bh=KwjRFxedFQRRSAG7Ha4yf9p5dUl5QAtUiHVA0BQzbRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1OdlsWSt4Yc1JWAoeNftKTxQ9rNnx6Y7c+JnCALoPfOhm0cdxLY/BZi0inZ4oAq23snqhkBiN24dZqOU+xFaJnak349Hid9wD5MDDcInTTvjm5t6Fsge3fLHmL1QrH7md2m4uxAesOp99zMY++RK8Ph4UtxLuOuAMbN7aOq1XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NFPBQYdd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 512MKXBW005979
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 03:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GKteQMHqlRJk4UrqMtXm6v7SVSqrFvlYT+TlaH42rZw=; b=NFPBQYdd9ptds73A
	woVtFKmI7E/di6jVfj19Y/gJ5J+T9v9tJ3uUERlXpnA6kAYnnf7ZeMghdmD+bSgr
	IcfzKM96FTW2ZEuQi8IjI256NkUmDzqEhWUGu5vlXOZat/IY0xYl7dMo2Uy1OXO9
	IJ0HCjGmLbboftXPVZmJ5tz6SZZ6wKKaMB8fmAwV9tO5O8J5EkUkFPoQo5wu0qvX
	O1sSZ60xVCpoTmnPu34mK14ixUKlWiEA8sneyCxjSeg1RpPdwV9WM0OuWz4W2LOO
	WMVXvNlfj1OrBy6tgTxD236YGVFlqypKMaZc6xH+u5Nb5UY7dnwCSjRRTZ1JDG1n
	K6W87g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44j6nary8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 03:52:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2efa0eb9dacso7562245a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 02 Feb 2025 19:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738554755; x=1739159555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKteQMHqlRJk4UrqMtXm6v7SVSqrFvlYT+TlaH42rZw=;
        b=RO/8brUpjLnP1ja/fuIpHJk8HLRzZx1li9zB7oQnImGZzEbEWMU16kxZMfgmhFObf5
         NM5qbW47ZsjTKfiGPR3Ek0NkUxZ+V2+l78ArClBgpU4cXUxeWqkiuw7qo4rMokUnOI2v
         LRn60WYeRjT3XbDsMGiSAHmTC0GR6Z+H/S//JFD0wiBcxrf6fjtWXS5TUnp3XaL5Vd73
         ulRfIYyBYZLNZaZwUksN24YN7jRBR7juquknQgttRmXyNcr6Bz8b9Q3Fn1+37U3CInzZ
         MumapPVwIZEuLn1XdRCuoFzO3EkEYtBuZIqUCJp977q1EHoKSy3a3zVeiPcL1SATHZLA
         j3QA==
X-Gm-Message-State: AOJu0YyM531T0gJXlrl9+MA0ucAUTYihxfB0z6aB1w4C835w9wSgLQEB
	4L0364pUjaHCINMgawT5J9YRtZ6h12aWfjqoA6Bgfny8cpi7BHhp1tOanWI1czhtgUVojFXE7RT
	8GIPkBQQC6gxdgddtaqVvjHpg6yN6GcipzQuTkptGs5jItDBjetW2XEIqjzWXsaMMvg==
X-Gm-Gg: ASbGnctF1r/JL6pVaOBb4hlv7etAdZeauVjr9KyKSRYi1bW/WR8cirGnouruEYjo5Hu
	iYgIBu9HbW1xppaesQDYsGLU13NWZ8bQQV2JAWRswmrPPk9UcZnxBvpRsSZK238L8F65ht0oYRo
	fZyXy0WqWxxOW02OdLRe0ZQH/PJjSzAVYW+Fomc8QmKYP3dZq7ZaD4JHF0fAvU3g8FqMiByqtmn
	8+JaubHaUUZWtFoOK62xjvbk608hckOcDkn0MWKC60lWelE65znY3LCCUr8uP662YZ4cH9nK144
	DVSP7iRrz1oW2lVlHi2N2ldgEgBR+Gn+kWF2Bzo=
X-Received: by 2002:a05:6a00:1412:b0:725:f153:22d5 with SMTP id d2e1a72fcca58-72fd0c623damr29883060b3a.18.1738554754895;
        Sun, 02 Feb 2025 19:52:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLyehUB1VhbA8JH+IgZNPWA2yDL3hKKsHac+3y9Z5waJGT7vyu1n7wVoV7h8i4tgGOV5FoDw==
X-Received: by 2002:a05:6a00:1412:b0:725:f153:22d5 with SMTP id d2e1a72fcca58-72fd0c623damr29883036b3a.18.1738554754404;
        Sun, 02 Feb 2025 19:52:34 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631bf82sm7574665b3a.17.2025.02.02.19.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 19:52:34 -0800 (PST)
Message-ID: <ef9bde28-861f-4e51-8064-f734566b125d@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 09:22:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: add support of station average signal
 strength
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250201211301.357985-1-nico.escande@gmail.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250201211301.357985-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ptFyRM4no09bemSatxKNrWPoe1z4drT8
X-Proofpoint-GUID: ptFyRM4no09bemSatxKNrWPoe1z4drT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_01,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=670 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030031

On 2/2/25 02:43, Nicolas Escande wrote:
> This adds support for reporting to the kernel the average rssi. This is
> done the same way as it was done in ath11k. A simple ewma (with the same
> parameters) is updated with each rssi update.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

