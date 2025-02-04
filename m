Return-Path: <linux-wireless+bounces-18390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B842BA26CAF
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 08:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B56C188310A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035D32063C5;
	Tue,  4 Feb 2025 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eCmmLo7Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D842063FB
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654551; cv=none; b=t7r0U11O15U0wRqKXrcwFMbgFQ77VhlikmlwfGI41VzFndesvItPivfToHggodZLxoURZ4yh9fZR3o9/PZ9DhPXFNaVWASYkg+wQluCNO/OScOHqPcqRd77ds3vt0SXFAge8Q4CURnPHbCjSmC7S3BxXt+DyQgp1Mvyy1P+kSu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654551; c=relaxed/simple;
	bh=/TshHlyhMPY9p59xbe+L+Oo+DmFTFUlR8gzGtdGQuVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puyozZWQBtIDGwA3snVL2dyLWd80DL1b+KcRTP4A6aceIQRZc2kDVh7XGlLl6KqE0zFpFgzAvY9zqEq7dDQaRzGCjg3uRPQmxfz9U/2vHgs+y7RRMHn74QyDzxNyqa1iIiz/eW5ZJycG/FkUNXvBbNuP8Ds4xcVQ1p++yQZ/TSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eCmmLo7Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5147GYDs011196
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 07:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XNk5GEHY2vpwvgWChX+aKrs57eHJi/VNa5EgCgXUgm4=; b=eCmmLo7QvWXxzOEh
	DKrfBzNImWeMRuuj7hsXn+x+2azYN5YZqx/xEVriqeDPl8j6HaPQ60nc8cPVprwL
	jgeR2oMvdWc5j4RSktiz4oFcgpNLbM3gqbvjOBUmEUk7fbxaSbPPPSonATUUXBII
	JjcY70DQXFSDOxODhRTflO15ljUYCuE6rSeRZv0uySLXzB0O0Z6wkDpIQbrri2h4
	wiQuBwvorCPAjfbkycDLqv1Ihn95Jz0HML4qy/1fooxGjrJVfTG3ueYwEUuWZ2oC
	zRepaEdoseSNTdGQzKZewxwA3nZRWk8tOAdbaSs1Ap5dZTzK3pD8M86SZOn2wW3+
	ynZfZQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kec4015e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 07:35:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f129f7717fso10344559a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 23:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738654548; x=1739259348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNk5GEHY2vpwvgWChX+aKrs57eHJi/VNa5EgCgXUgm4=;
        b=KFoNmdml6LdSHnbgZ3oJJb39ryGMzuWecFlj0oyxsQAX0Hp8T/4FE9f29PzDSuZgVZ
         V9SSDq418IjLDt6cCDq0XkROIvqX0m+UWe0rN2HTXTTXv+wVsxHJLqvuR0b27mo2Ghqr
         QIFJi7FUURM/c9NsB3K3nKli6HBg0iNB7iMMFdm4QdjmRZpWi2eNspVc+LNnuioShLig
         1pSlE5RlBpolkU5eIQldTxHnPAMEt3/ASNy2vG/uvsFgopgPKi2rLHH9dURb0Xi3v0us
         04O44zEaWIo8GrjV2f79IMt7yx9pJQ6FNNscBREQQDNNpUfNMKpmsRFNEjhAlQaFFlN7
         jvGQ==
X-Gm-Message-State: AOJu0Yy+e9nj9OEnPIs2HAAf2WfqEQeK4QUKwHtKfI3GL/dSRQMsnhKT
	ZjZbqzFibvBUGJYz8/eZ3qdbGSN6ThFPegAF7jyYxv5Op4HkWDbth2BVMYi1vNuAeyoTWytbRrl
	GhsxiXVTqLL95JSf4pUYBCcgrYj3XeI/vRteMriJKmRiVR7Yufcto8dkRM9TTuNHmvA==
X-Gm-Gg: ASbGncvaXaqyQy9WRbDprE7cjhYXvpFCycoJCA9k6h74hzXY6DRnELZ4abRl73ePqI2
	wRsat7+UijRrnP+wwIG757XwGrhJrxG0Aag68KX1msV/egpcPrbtU3gJ9eYhRjd1mWoG4t47NXF
	IWVF1f2re9+LuQjnwW8ywyAYw+svyo0TD9G96MtkzkCA0Cmg7YMye6up1RN3aUlDGlFuvHnoCWD
	3H0OWZSk4m7M7s3YzK4DG+nDJrdZwWG/R8REzFv3HcFfNjgm7W3uzMbAlmRTXQnuftTLMoV7LDz
	JQb9S8GHSyR5jmW+Xz3yXM2f+x7QQ6x/JlzL1DJp61R9sYM=
X-Received: by 2002:a05:6a00:884:b0:72a:a7a4:9b21 with SMTP id d2e1a72fcca58-72fd0bc7cb9mr35652297b3a.5.1738654548558;
        Mon, 03 Feb 2025 23:35:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmsqjymbrkDEMXx0uq+DnM18cYXX7nW3LMNz2qYbPHat/9yoLX1lbH8wOZSBS2srU+UJsmHw==
X-Received: by 2002:a05:6a00:884:b0:72a:a7a4:9b21 with SMTP id d2e1a72fcca58-72fd0bc7cb9mr35652258b3a.5.1738654548111;
        Mon, 03 Feb 2025 23:35:48 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ceb1csm9556119b3a.151.2025.02.03.23.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 23:35:47 -0800 (PST)
Message-ID: <fac29cc7-6407-d5ef-32f8-6c8baef1f37a@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 13:05:44 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/8] wifi: ath12k: remove redundant vif settings during
 link interface creation
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
 <20250204-unlink_link_arvif_from_chanctx-v1-3-675bd4cea339@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-3-675bd4cea339@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nFydHZdJdsF9hNnoiGgsJJtAaUTLjGBX
X-Proofpoint-GUID: nFydHZdJdsF9hNnoiGgsJJtAaUTLjGBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=764 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502040059



On 2/4/2025 9:53 AM, Aditya Kumar Singh wrote:
> Currently, vif level settings are done in ath12k_mac_assign_link_vif() as
> well as in ath12k_mac_op_add_interface(). Since it is vif level settings,
> doing this on per link does not make sense and it contributes to redundant
> code. Get rid of this redundant code from ath12k_mac_assign_link_vif().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

