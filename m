Return-Path: <linux-wireless+bounces-29365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82782C8CA02
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 03:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4804A4E1826
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 02:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA08D1DF247;
	Thu, 27 Nov 2025 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/F4y/kx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q/Yy4U+c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FAB224B06
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764208806; cv=none; b=U6nxnTODtSjs7Q/u++KJqGKjCtHupeaQLMfwwKItMMDGIyLQc3qE94iSLLf8e8frDEDXf3UJSyAuoKkXRO5x9d+tZ6X1H0PqpncdZKHN4DGfgsiStiHZdhOHmHo39k+rlvl0Dq4PKmuYPm7cNMiWmJQVJBf8+fL6eQEssi1W0Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764208806; c=relaxed/simple;
	bh=hQUQlMfOGlM/+qEUb1IT+Hhj+c0CZdzKueiH7QOg5Zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5tMFDrUq5kkG+OIP1I9a2DQ7zV8Spz4bAqovGpvUwo4JdSkf431mMkdEwD0ydW/yBf1QbiRpVoqRE1dMjYE5v2FrKZXoraoBPDOOXea3nQKMrgbr1LZ/d6PVPRjIsLp1cqHQubl21OxCe1niSAt/9VDSixSVObaKPqOEFjNqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z/F4y/kx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q/Yy4U+c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQNe9EV1849374
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 02:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nxYwLRqmN7KIfn9UeEw8WfGGjDSac5cTCY5zVzU1VWs=; b=Z/F4y/kxjieppySW
	H5RS2geP4Oby64JviJKQg0z6hljbj/LnhB5M4/TKrYt7ujyQGmw5eRQBtiy/llOI
	LLqUQ3U/Ez8FrqvJD9Mk3TSd82hRh++wkRAQdbDzaLijJJxtkTeWyzKAGnPFQbst
	YwoQ/Pd9W9RPPaCXB03fc3jRCdrDwhZpY81cn06We4DcGK9sizVPPkx0dT8osF5T
	DqIloxAvKUBUMm6p5GWOqSM/kCFT1O8v4KQG505WW9ifzWTFKVxYuJ8kStzIODXY
	4LTuQrUZ4dzSpxMCIRZBhJ18/T2syEiGfNxePN6d/N3CiWMH8ZAH0ypWBff6zZHx
	koBDjw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap0mst2kd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 02:00:03 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a99a5f77e0so502343b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Nov 2025 18:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764208803; x=1764813603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxYwLRqmN7KIfn9UeEw8WfGGjDSac5cTCY5zVzU1VWs=;
        b=Q/Yy4U+cu0df+v7ephdIWoD9xmyFqnuh98wuss+YPCNk193OSHmNH6oA6feUwdXQtf
         S9Zops6Mk9+oUE7r8mYfYzjBZ87imP8qkmlIKQtHH+4ZHolezueEqNxnJtXsXGsaCgGv
         qmFxFhHnsuhf4l2omdWw121xySj2EfU7au2QNRkyD/SSls2Nzyc8hsVmxSazQYT7ErV7
         KT/sLBDksQcdiTlnoonUvabYmGtVIOzJUzrt8+aCr/ayvO5NuJESfE9Glj6S8H74KkY5
         v941Fw7N1L3H8FemBZ4voR+OXF7WiP+gdAgpzs+v7ip/+yBZzwX2ZIx0Wrvmbda9QabM
         GZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764208803; x=1764813603;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxYwLRqmN7KIfn9UeEw8WfGGjDSac5cTCY5zVzU1VWs=;
        b=fSkinqDkCyDeQfPqmwjvYfxDWe4ObRsTL3YMEvFvb9V+f6JPromG7rt3PJwWxLjNUX
         kYI3+D1SZhDt8myHM3nS2MFIGieqaJDc6rI+b/7XA+OGfpwPv/J3JULqUBJlHOo2Px6U
         6JTaE7A02+D4DN7k6oyJa7sTrUnT007Y/AQbsUGOrrIqyFXasGerj0DVR9DDFyGkMcB2
         rOYFtRfXAhj/C6yBpWUZFdZtqv79VM+A49WpG+AeFRUd4YmaVKV2BiPRHOSv9vJEC8d4
         tse6/maWo33iiYy5aAqeOkwcabjP+88qPO4IR0ic4wznOHH9X/lDk4SG/y0C7hh120nn
         Gv6w==
X-Gm-Message-State: AOJu0Yxx2T81VmHbXMPgIp7zXd1nR/un4Dg/xIi6086YGq8OpXKJ0iEM
	muU70o+7PVVrJKb9TbtjSsU6qLdUBV257301IOkjCcpVPfi0uNpYoBWPjqgpQuig79Hbn4y7meO
	dTuT5t5JkXPgaGjBCWRUXD5I2y9F0ZVZwT2pxTbzQJo7YDpXLR9/nbK20bmblpg98ee5N0g==
X-Gm-Gg: ASbGncskTqVXwWcW7U80b+3kfQPpyQGC/ecBz9MmjSee9nj4LTcP9QdyQ5PPpmUrE+H
	urtZ4VzX4WOkCZ2LFAw/ICKdwGAmbY8n6BChHZMEApToS4Y86j3XMgIFsnGLLWBY5KWQex1zoO2
	8LZO8BPj++6Lhu0XOul6IuiXvkatHiSFBtl9gGhMAxiBzte5AQg3NYcmxvsk0kxh6hyqFsXQsn0
	TawnR0b3Pk74iWq3Wyhi0a+PWQ1H0r14Ivoz6RBnuFL4n1cxoACmJjYW4Ea8oUaoxThqTxxI9TP
	tUHQQG7h/WpWvrHUgrM1bXGoLg+GuDoWDFkv6maEG2QPEPLUJpP6ABIttUrF95qC8/u0lWU4jS5
	dCxVaeJVoQwm2RJ00StGbbV/iWA974OIY6tRqXd+DMGIcczdQQIwdwSESIHCnZk2IN4k780SwUI
	1KT8IYC74=
X-Received: by 2002:a05:6a00:13a4:b0:7ab:fc99:d856 with SMTP id d2e1a72fcca58-7c58db2cccdmr23634226b3a.18.1764208802902;
        Wed, 26 Nov 2025 18:00:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENfADCaProux62pOe0aziLvWIBPRLROMPBABGopdZq7iAzgdg4tnabsaVC0rKt6Joy0GaX7w==
X-Received: by 2002:a05:6a00:13a4:b0:7ab:fc99:d856 with SMTP id d2e1a72fcca58-7c58db2cccdmr23634194b3a.18.1764208802438;
        Wed, 26 Nov 2025 18:00:02 -0800 (PST)
Received: from [10.133.33.245] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed37ab3fsm23137458b3a.22.2025.11.26.18.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 18:00:02 -0800 (PST)
Message-ID: <aedb4f4b-fbb6-4a09-83a2-9dc80307b5cb@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 09:59:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: remove redundant pci_set_drvdata() call
To: Alexander Minchev <adminchev@proton.me>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251126170213.27959-1-adminchev@proton.me>
 <20251126170213.27959-2-adminchev@proton.me>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251126170213.27959-2-adminchev@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: So4GySLOFR2BSf0IDSS8Dyn9afHUbX-8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDAxNCBTYWx0ZWRfX3nvX4FDxbEn4
 c4BtYj7JkQzYWpQrQg9IegnQ6qt3PxJ6dFXH+XeZFxbtVseyufrC7MuwPYrHFwP6jTnARZctn79
 zDMUZahKkwIdOheCsjvut/bGCVNoJyw6p0wCuIfQ+5hauqeortSZ4llNu1rORZ/d3Q8e2JCbMXI
 03blrou/oDlVAkfIZMJ0ySNK+btLwMt6KiZrUsNzE+NMYjr272CzRLYJwEHxRoagodl1mRef6TT
 kaCzHeZ7tDlkXsipYGh6jvGbq/4ISzJt5v9JHxRPoepFCBRajEjPEYB8ehUBP4QtDR/bi9qT+qo
 X6c/wermyVMgn8xbQTSmkhoGI4HDce25dl5F0whzgvtDiE19HSDlRvyfNGmCbdgwcle0cj5aW0b
 2aWo1UW+Apb0mg41QSdubsUcGAa5zw==
X-Authority-Analysis: v=2.4 cv=N5Qk1m9B c=1 sm=1 tr=0 ts=6927b0a3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8RFSuhLZcfpH7MuG1VkA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: So4GySLOFR2BSf0IDSS8Dyn9afHUbX-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270014



On 11/27/2025 1:03 AM, Alexander Minchev wrote:
> pci_set_drvdata() is called twice in ath12k_pci_probe() with the
> same pointer. Remove the earlier call so drvdata is set after
> ath12k_base and ath12k_pci initialization is complete.
> 
> Having two calls might suggest that drvdata needs to be set early for
> some reason, even though it is not used until after the 'ab' struct
> ath12k_base is fully populated. even though exact placement is

nit: s/even/Even/

> not critical, keeping a single pci_set_drvdata() at the end of
> the initialization makes it clearer that drvdata points to a
> fully initialized structure and avoids confusion for future changes.
> 

==>

> Tested on: WCN7850 hw2.0 PCI
> WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

<==

nit: this has to be on the same line

> 
> Signed-off-by: Alexander Minchev <adminchev@proton.me>
> ---
>  drivers/net/wireless/ath/ath12k/pci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index a12c8379cb46..7bf98618ac1e 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -1580,7 +1580,6 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
>  	}
>  
>  	ab->dev = &pdev->dev;
> -	pci_set_drvdata(pdev, ab);
>  	ab_pci = ath12k_pci_priv(ab);
>  	ab_pci->dev_id = pci_dev->device;
>  	ab_pci->ab = ab;

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

