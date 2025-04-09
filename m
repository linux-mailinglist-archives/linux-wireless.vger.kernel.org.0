Return-Path: <linux-wireless+bounces-21307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2453A81E32
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 09:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66D24C1275
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 07:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648631D618E;
	Wed,  9 Apr 2025 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mdIUS0XT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE5825A2AD
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183414; cv=none; b=VdPcgFa32Qp4iunBBDJB9fwRIyCB02/1gj6srkzjCmZ7KBLGfK06ZdDTXI4rJqcWzZEC6DJh/5ddaXOwXEzT18EJH7gUnXhctbFmAcz+RpkgfxPpdXVuPKJ8iEVWs8cF99Y8aas2sKvXihdQLi1iFOMKFdL7tjIV6hdNkUYReOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183414; c=relaxed/simple;
	bh=TbCJOIFZxOuGyD8oWXw8Z6jUczKbN8HoYWk4bAX9skc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFRtYSp/DJ6h2xfB7ww2JvAFyodA00BhS2fkJnVWvlzH6IvNv2A/nHJHx0lhg5rUTYGfp90/2o2O8jyLkODrw6p2JaEj6Hq38kdmD0BYbf9yG95xSOQa+Tpv7CfbXAR3Kszo2YYRXpf7XuIvSyT5OM+BIPhDVplmnw+RmmTGbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mdIUS0XT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYq2l027497
	for <linux-wireless@vger.kernel.org>; Wed, 9 Apr 2025 07:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gGopHc8M8UiNAurUBT8tbmUjbBdi9nDkUm7yBzqMldo=; b=mdIUS0XTGKVtMDDZ
	H3rvzGmwgrXrm0T+Ydx0KIFg4NI2TDT+27Tbt9YZPKsjs9KVZefnbr+ncxFBDT8v
	FYtXZhJst6HFgzfiA2ivQcYdB1j/kmdwU8ddd/nB9kqqhZCvCWTYT4rOajx1rSAc
	engn+O6tC1NNQN8/fFVjvIWWQtmgaFPfIjdUmpkp/MNAvyC2PgdwsgMKL2tr/GzS
	VZ04VabI3LwSQkl7TwFovkANnzI+50ONEVzBgLrd+lgV5/QiObXdjeCMvFB9DTeL
	lbTZdkCKvCDGCm8IG9WgMBPZODiNe0YZIOYhpSBEEAT8c7WNGKbbLRBBQHJHeVxP
	uyLWFw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrjh44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 07:23:31 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7391d68617cso446296b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 00:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744183410; x=1744788210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGopHc8M8UiNAurUBT8tbmUjbBdi9nDkUm7yBzqMldo=;
        b=awVCJYbWifgyAHnepe+B6VLl4wQFO1z0SIlkYbkiJRtTPgbVXOmf8uBZP+EEIn48vk
         PbTnxR1IkhcEdfybX96JBJrePVysBq8negYSn7+bEwxzzIFE8JukSmkHU/+W6EsolVSK
         ukWuOvfI7RCYl9dW96bBcheBALH+l/6T8sDvh6Zg83zcFPRw9ieJAVZqJZYc0k/MDzQ3
         opASCzCnrm5wQoMYr5/4fl4O3i3pyZzWyz6b5W5N4zpu/qRdwFCzqORCFsRj1jBxXV2U
         fAA81nzac9l1PJ43Bydrf2HNWCAfQFqhGv2AHOvRI8yQvE8YuxcVfiCX44fPMY14CRuv
         pZqw==
X-Forwarded-Encrypted: i=1; AJvYcCWv60TiyiiUp7lBjibAxkUgzhsr4Q8I64p0EADZmGni261db/Hzupf1PNLBx1PSgS8r4vVIUWyTWrwQrYdaFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDFYFfLKaPe2xD8Nci7CEC8HRv6GstzW3akoOU1liJvWdCRGDD
	ucb+Q34eu/YmylxPyaiGKZnxfqEjwDdNQgJf8hC55eZNCGkyhmVD8sdRp/ofBA0oB7tUJHvARsi
	HSObRvO66v16wEInbchlULDSHDoXm9K2yNqQROBD94nmNGwRt/NNvDkX6wujH5lA2QA==
X-Gm-Gg: ASbGncvvvzPboIQJVsFCQ9pIu3/giA5h4R1dBMP1nk9xgp5Ez6EQWDkGMkFm78bxodq
	kCh+dfU8Pqp4WKSmq+b/C8RhOm0T9FRbYZ2Fv+n6I23dzKzlgnqI9Gf+3AeCxTW4KBGabOptg/Y
	UPyfSenxYEcNMAbzrN7o2ir2UjJ/H8wCSBs0WOgTr/ghHnehSAvsHKbt3io6VTGOUZgBcfYVu8K
	gJW4hvaWxf3k2A7D46WjjZj0dLpdtiHvuC81mJtY8em+S0WbR88UkR+Sj6MrKgy8QGXDvjicd0h
	etHwmNmo/ymehFodk6NUEDsUDRwCmxBNulRRyK/v6DmWbIHdawAuFA==
X-Received: by 2002:a05:6a00:18a5:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-73bae3ff744mr3170249b3a.2.1744183410036;
        Wed, 09 Apr 2025 00:23:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPtgVisc7CCOafLf1M/gX+5QZW2iaobdlIZE4fEYvLA2WNor2YEuBrLxps+jQ8y/aA3Q6YcQ==
X-Received: by 2002:a05:6a00:18a5:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-73bae3ff744mr3170201b3a.2.1744183409441;
        Wed, 09 Apr 2025 00:23:29 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2afefsm619328b3a.16.2025.04.09.00.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 00:23:29 -0700 (PDT)
Message-ID: <7378fa5d-5495-ec0e-9f15-6aa7e63d204e@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 12:53:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: fix cleanup path after mhi init
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Kang Yang <quic_kangyang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250403-ath12k-cleanup-v1-1-ad8f67b0e9cf@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250403-ath12k-cleanup-v1-1-ad8f67b0e9cf@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: T_TKGehfi1RNrCz2R5WLihlmnTUwy9j1
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f62073 cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=QRlmjJKdkydlmUMDs2wA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: T_TKGehfi1RNrCz2R5WLihlmnTUwy9j1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=991 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090032



On 4/3/2025 3:34 PM, Raj Kumar Bhagat wrote:
> Currently, the 'err_pci_msi_free' label is misplaced, causing the cleanup
> sequence to be incorrect. Fix this by moving the 'err_pci_msi_free' label
> to the correct position after 'err_irq_affinity_cleanup'.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1
> 
> Fixes: a3012f206d07 ("wifi: ath12k: set IRQ affinity to CPU0 in case of one MSI vector")
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

