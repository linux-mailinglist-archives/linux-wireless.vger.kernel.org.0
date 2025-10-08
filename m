Return-Path: <linux-wireless+bounces-27875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E74BC3C4B
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 10:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AF13C618F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 08:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047E92F290B;
	Wed,  8 Oct 2025 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XnM0OleO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B6A34BA3C
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911109; cv=none; b=FX+exJhXEp9jHpC6yjwYaCFFU5cA5KcH1p5MdjzN0NB6moB7mcf3aKDLw4Ui5kWUVlRCQPjLE/IrE7o8vhThCbaAv/5jCbG3WJ+1zXGQ0O7GVQbtTnG7Yo7X4nbzx/3YSCi/kNFLjlO6JQOqRKS0maP7Z5dOozw+WcldUNRBI2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911109; c=relaxed/simple;
	bh=hHlw+bA4LP9wsR2Sp9lLAoAsdImPeUU4Jk8u5uTeN1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usZXc/nErmQjL1b+MXabfp4Ukj21umTmjvRUBoC5FHtuc8/THl5+/HJtgoRMHazxPArHxwMXuKwkQ2ooZE8nKFk4AfQhadokb8r/7FJ8+ixLp+zExUTqhdA5gUJbC+kUgIKEBvmPYbx3KXE8CNga12TdbwrbesfNW67u+P3KSuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XnM0OleO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5987bQLR028700
	for <linux-wireless@vger.kernel.org>; Wed, 8 Oct 2025 08:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oT4qN5wiw/obLfm5ycH7/scKXzGS50BShMeNqi9Ne5U=; b=XnM0OleOFQ/36zij
	+rTq6C/7QGYMZA1eERe+4kp7tS7SJaO8Kif1b+3xmGf0WW4WwznY2SPtLjoQXTqR
	mojHcYkVfjy7+duwqI0/NKjrFCETHMqgsEN5Ag5W224dd4fXeYgY/Aa3hUssrTpb
	PY4A7A81HvvOfBUK/RYijevjBtxbzctgjxvu1dH2LpOkf6muv2HWnOPzXYbZLa3v
	BHctcqH4t1YjsgcrfrFoonk27CUZsYSXaI6v1NYw2CJ7RoA8o8Vnx/pMibeiJT30
	P1bM6D/drRBewiK6rFe+QOoNJqH8F4Y8fYg/se2aa2X4xAjZhZX3lCKD8eA7zEWC
	8c1AVQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n89hhgch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 08:11:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33826e101ecso1388145a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 01:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759911105; x=1760515905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oT4qN5wiw/obLfm5ycH7/scKXzGS50BShMeNqi9Ne5U=;
        b=ZIQytN9/VvNEa15QAuufeUN5DmLX/0RSKRosB5zqnoKzZ6s3amweLpSZsKJ/zWqeJc
         oV7Go9bEeAESGVS5RCbDTxgaVeXCPJR96AStu0rDWn0sYdgACEGBeyVwJsR1hF1h51/W
         +BraQhVqIVHKg4c9z6Oi+OcHeyUVBOG/1ADrCZ/HMJLeuiOBkXnCyzNgH8X3IXau0PmN
         3LEsBENAD4GklDaS/zXwTUontOtEW1GGYSKnXpAu7BKnNabaePaIf6kcKd44yt3fytGt
         IoBzVISvsxBDlF18AX4dJzMz8DBruVEmyTebhly5UUWb+TScUJD527jVSZkNq8F0Kkcp
         37BA==
X-Gm-Message-State: AOJu0YwIvuqWeZZVSQfDwZiLapRhRUkYTzzcH1Rs2C95wZlPORfWRj99
	KlgwIVo1FQtMWeI15abWmSb8vWcpEiR/GotQZTQ2LkovkMAoYVQ9niXKTiBIe+UIxiCaKGfsA9+
	wNQb1gp8V1Jrnfn49ZLEPRFg699VgiBU6CJCXOTdoVlZ7G7PaweJjt4wE507HKw0M8x+1vVSU59
	LsiQ==
X-Gm-Gg: ASbGncvBMzycv7SZChcfLW/VJ4ioegvgVLEFlxTj7sjd9xoC7WWuq9ZLX65gitdR5/N
	eny8GlvG7KgKr4aFdR7JeH0VmxGWf9DTJRnAttbZJZ7xX8mx7LsWcFlV3iUzwZECb8B/BBlkf/5
	LvpygKV+YjAocqZLLTZkeQBMd4Hy9yGvZjxQnwxMbdjmrhasIHMx68raeQf5+ujsVTlyvTp1E//
	eAOn8oC3om5Z7ZRWuDjgMzal1hVjW+2+A16DYpMwUfE1cDnv93q8lYBoGb45zjJlg5j67qaRjaM
	BwtfobjANteHt/SkJrNGQ+qEY0RitKwqNm7xWU2ELDLtP8LMKyzm9lKSlGBnNI9RYADspBIUG73
	Dd03uByZoNKjf8UiMWT2ivQ==
X-Received: by 2002:a17:90b:4acf:b0:32e:6111:40ab with SMTP id 98e67ed59e1d1-339eda4744dmr8176217a91.3.1759911105392;
        Wed, 08 Oct 2025 01:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwHDNuEaE+rLfTNBWLkilBQWefpmRZUNM+SfQTjfQNfl95ppg4VogY664yfD1KZU1/gQLQww==
X-Received: by 2002:a17:90b:4acf:b0:32e:6111:40ab with SMTP id 98e67ed59e1d1-339eda4744dmr8176195a91.3.1759911104882;
        Wed, 08 Oct 2025 01:11:44 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.106.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7932d06d3afsm2988365b3a.70.2025.10.08.01.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:11:44 -0700 (PDT)
Message-ID: <f1aaad21-1f09-491b-b0e3-974b65a57963@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 13:41:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Improve RX Error Handling and
 Debug Visibility
Content-Language: en-US
To: Sarika Sharma <sarika.sharma@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250930091551.3305312-1-sarika.sharma@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250930091551.3305312-1-sarika.sharma@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0NiBTYWx0ZWRfX2/Bl1j8yUk7d
 CfwQCnGik1f6YPvPzh6nsZxh/xt9gkABVFqKQ/4O3l3btxtP9RhETFLRJlg4iTKd1ZUiXnLcBhW
 ycGg8i1pkrsJBel6nvMvjwfuzkHX68UlbNBmMkxnlg8FO3m5cCI7hSgUpxlNnRS5ysrYZ41AKIP
 YdsNglaBaZ07BrRy0Bg2HIJ18/ldKj8rmY5cuy9g+a6wk+1I89YPUp+u+aNzOKrYph0n/jlUoWK
 afogMek9tuc7GytgMhheE9lu1d6eTt+SmA0nB+IvR7/OrR6Akc9XOxFEAZcmAhffXbjbi8e81Ln
 YNtpy9FpQ79s+fW9+DzubSli/9M8HLhV1ng5MiD8GaRFezGPL9MKrLVpE1WT+40SUewZYzqzG3r
 O7wNhZx2MaqittfR7VSO9l7heF4BcA==
X-Proofpoint-ORIG-GUID: fOit7ES_smlaZsHu95f_7pr_2pIkgSO9
X-Proofpoint-GUID: fOit7ES_smlaZsHu95f_7pr_2pIkgSO9
X-Authority-Analysis: v=2.4 cv=cKbtc1eN c=1 sm=1 tr=0 ts=68e61cc2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=z6xreaRxtU16OQ9bEhv1vw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=H_RQpMyiQRhNCIPQZMAA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070146



On 9/30/2025 2:45 PM, Sarika Sharma wrote:
> Fix buffer leak and potential crash in RX error path. Drop MSDU
> buffer-type packets received on the REO exception ring from
> unassociated peers, as they are not parsed but their buffers are not
> freed. Add debug counter reo_excep_msdu_buf_type in
> ath12k_debugfs_dump_device_dp_stats() to track dropped packets
> and aid debugging.
> 
> Sarika Sharma (2):
>    wifi: ath12k: Fix MSDU buffer types handling in RX error path
>    wifi: ath12k: track dropped MSDU buffer type packets in REO exception
>      ring
> 
>   drivers/net/wireless/ath/ath12k/core.h    |  1 +
>   drivers/net/wireless/ath/ath12k/debugfs.c |  5 +-
>   drivers/net/wireless/ath/ath12k/dp_rx.c   | 72 +++++++++++++++++++++--
>   drivers/net/wireless/ath/ath12k/hal_rx.c  | 10 +---
>   4 files changed, 73 insertions(+), 15 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

