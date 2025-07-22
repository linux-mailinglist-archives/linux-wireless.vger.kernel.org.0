Return-Path: <linux-wireless+bounces-25831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 998B2B0D4C3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CA1547009
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451732D63F3;
	Tue, 22 Jul 2025 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1lI7noR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7D2BEFE8
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173357; cv=none; b=YmBNKsWVngMdOdIAE8Gw5OkPcJ2qn+ZoHI5QeZ/ePCTfTuFzQ1l2DlWxDRSlLfTvFhn/rTbYBH4NLD9u+QxouJuCEGj3nUxBNSQnosBFY1N9atQvSmK5P2dar2aO/al33q5hWcg224GszEX6Pzb0RQOsiWeaBKIV1Hx+cMHQ3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173357; c=relaxed/simple;
	bh=foXUIgStGDglp8soaKzHpgchVPakvD0gG4XkkGSqNIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IssFsKFetDkmFWypEWO9B9UY6eUXIRB9sc+oOSi9NOT4kMGc/61SyeqGmf0W+9pr4K0IIKhB9aRfQaOn1OAdsEFEo63j8W7+u1YOq/DLEgsYrvJR+73ZDWNrAvHYscgZdvLyp1d8Gj7chw4QZHV4WWo3JRI9THgpsfXiPLNQyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q1lI7noR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M2iHNZ005664
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v1CPlPbwtTVjIc8HWeOwVxWexCvpUqlAqvq7jTFTfSM=; b=Q1lI7noRzvDFvPCU
	3M4pyUqyo1Z5L85dZNCwP2tRgZ6Ll7/0wsZObSzkJRJkYfPx8ot0nWCk5nZelo4p
	DjqwhWvqJPJGTxgy9USzzfvGnZh6HVCnvXJODTdwJy04RlOINBsym3ih2itgH/AT
	r8+1CTwFQkyV8GY8zDRNr+fF2jQt9u9qkXHGMaj4dp4EkJ7b8ewo9DhIvhuq640a
	P3cLJuTnmWC6BsEbfU2zGEfhmyFQGCZYc8Wrf9xe71fiBc0ezq31KnLIH/f2gMl6
	HXRy68e9hiGcHKXXWkCVBh38jy28J4dX6MXv+OO9o36TiZHWDqR999IcXvbr9rQ+
	amBX9g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047q8tj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:35:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b00e4358a34so3404644a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 01:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753173353; x=1753778153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1CPlPbwtTVjIc8HWeOwVxWexCvpUqlAqvq7jTFTfSM=;
        b=G43p7gfqJXmSVmWvbR4+0xpV2nlSaN7/D6mhE/dZzSNwnOY5rhhu5Udav4RGTgmI2V
         ECsb0MJ8S3KhdnJygNfxWjVJWq3b1Eu9tndCwA99Sh/+U0nbKGe5a2x9YUapQZzekPFl
         Xl+d0WocQan2pyT3sLoUG1ejpUGxgM70RIIprtqTp4JT75IlE4F+1nRIFOQhFQATkepq
         7HSzuzcc+sGnJx3g+/2O19RwqtsNkjhOAU19LloqSMM3jzFPTjf9wE2K4Pojaku0FhWq
         cUII+14++ANFwB5gDZQvkA6GMWhlcCyHReO27NEZBuGUZrxWhojQ01hJe+7CuzvEdIPz
         oOjw==
X-Forwarded-Encrypted: i=1; AJvYcCUoLRCyXid1W8Z3/5D92vhN7dEXI2cWRAwOclIDwaQkR/J7Dj3m8pE1UGZZVjoLatajXWyZpk9/HHpykoL4VA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi0gxcXb+PhT3aVCf/hpyxaH+liBed+R7hIclffICtRgGCqNAJ
	HaPQMecdZ0zf/+gwz8/dmcLV69O9SK94/0Jf1sOIncKOEQNaFI/+qYksF1UmXJYIczJva4DW8ra
	/TljSiZQU17kZXAHg0Nwyi8yCfH0X9vcV4HIid4XZUHsr7PnU6kxCfGwV8MEHQIh8o+5y0Q==
X-Gm-Gg: ASbGncvn9sUJLjlhHrbLMj4dtOEmH9slullLppuMaEavwbhHx61VG+N+PfKP1fupVLU
	bhWrjiZkR6JhYxJE22EjpHI1KPQXz86c+15x6fbOZvVq31t86cw9pVwRuxiff/LrmGY97QjJT1r
	2nnFtyMBv1dhpYZHRgr+hFPhcJAU2+2r5hVsuzYZ13aYMQvhcZ2J+NxezgXBHp33ucRj9kaArCX
	1h2ZCsU6VVHPcMBvD+l1KR2Aa//n517pQFByDGP4/+qoAnG9cu8zOhYHVOjcsv6cghIBSQAl87h
	m+kclUjeTV/ndOXVGm1eNZxyLChP2b651JrCwkWlCPaZpoC8TaQBq9XhqXwZQAIcE6tgT1QA5+R
	u6Z+Rx0EA+PE8Q7qKONwomnsYAuVq7RM=
X-Received: by 2002:a05:6a20:2588:b0:220:1ca5:957c with SMTP id adf61e73a8af0-23814269fa7mr47543353637.31.1753173352902;
        Tue, 22 Jul 2025 01:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxQoVSL6iDytp5HaUmhxPmpFMPPetP7b0Xmv7yoM9vlNb9LHyBBh/GNPcPF++PFFEUqYTYnw==
X-Received: by 2002:a05:6a20:2588:b0:220:1ca5:957c with SMTP id adf61e73a8af0-23814269fa7mr47543312637.31.1753173352439;
        Tue, 22 Jul 2025 01:35:52 -0700 (PDT)
Received: from [10.133.33.45] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbd66eecsm7175486b3a.142.2025.07.22.01.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 01:35:52 -0700 (PDT)
Message-ID: <0b28bb5f-56b3-4be6-b4f4-89ca546a24d0@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 16:35:48 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k_pci: add a soft dependency on qrtr-mhi
To: Christoph Hellwig <hch@lst.de>, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
References: <20221202130600.883174-1-hch@lst.de>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20221202130600.883174-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA3MCBTYWx0ZWRfXwgE/3ysD02po
 vB5gikYl8oNOwanq7cWFXdMUwL5II+Scw+X2P0E961KVi15qLDVT3y+kotvjwhv3fVTuqAMOlMo
 WHBKvi4GPPiyuXksF/0mziTEQE+T8aMeHPPsQdYO+rvaeUQdkUyVJuHlj249mcqRS/G2PthxvE7
 6AlA4LOx1BCcQRLdTHLExb+whHR/4vaD7QlXdacT4WQOkb0EsgVwdJpPXAlj4THBqtOqRW5kGqo
 HYhhwIX5GHKLLhhddgceLhtW8RpcwtAoERX9zZFFwLVLsDYhklJ8QdDb8zBVQoodHUxZmZ6EsBH
 dFtY/wHnSF9wSGjfy2wfOS8xPNsO3WQEpd1TeR+XEull9phjg0RnWQNIl48+slHOXIVTsfFfbRm
 9uPF0ozMEfDVuEOr/1/w9vUSJHYCatHoMEX7jolD4951vSUBJr7xXOf1UwLGJbRZucfRj22S
X-Proofpoint-ORIG-GUID: B4iw8R0T74fAZMSM84MbzfycObvzy570
X-Proofpoint-GUID: B4iw8R0T74fAZMSM84MbzfycObvzy570
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=687f4d6a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=dBPL878wbgeN_2oxvkwA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220070



On 12/2/2022 9:06 PM, Christoph Hellwig wrote:
> While ath11k_pci can load without qrtr-mhi, probing the actual hardware
> will fail when qrtr and qrtr-mhi aren't loaded with
> 
>    failed to initialize qmi handle: -517
> 
> Add a MODULE_SOFTDEP statement to bring the module in (and as a hint
> for kernel packaging) for those cases where it isn't autoloaded already
> for some reason.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/net/wireless/ath/ath11k/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index 99cf3357c66e16..9d58856cbf8a94 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -1037,6 +1037,8 @@ module_exit(ath11k_pci_exit);
>  MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11ax WLAN PCIe devices");
>  MODULE_LICENSE("Dual BSD/GPL");
>  
> +MODULE_SOFTDEP("pre: qrtr-mhi");
> +
>  /* QCA639x 2.0 firmware files */
>  MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/" ATH11K_BOARD_API2_FILE);
>  MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/" ATH11K_AMSS_FILE);

Do we know why this patch is rejected?


