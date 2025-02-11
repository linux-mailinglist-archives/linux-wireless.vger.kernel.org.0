Return-Path: <linux-wireless+bounces-18742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75678A30454
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 08:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2746E16411C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 07:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC61E9B2D;
	Tue, 11 Feb 2025 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UrCo7emB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9221D63F7
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739258398; cv=none; b=ZgFoGTZAxJQ/4fvLhosnD2c1CRTDDiv1X+qLCUZmLCBesxn0XKM71KHRJeORH3w/oCRPYO8ouVPfk/aJg5La4+JEXmq8sJboKWEQA8yVW4bRgFvbT91J6KBnFHo39fEVhseCLD72WmWr7QbLZQYiRln8FqcWS4WQrYUPXdWyrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739258398; c=relaxed/simple;
	bh=1nvclx5J+9q6NqBtLQxHNpyoKnKiGdEXgtHgkzY3u8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LA7kdv5cEGJOZ6PHtkQcUcpyfFrY7ixwIZ5+z2Cp0760DPomEvXc+57+U2yqHGyPq9KVzalUlbiUN2ttEW9xkTS86GB3359Aw6ZnxTV6jn8cWAC6oiSqdATfv4OaRTi0lCFcYdNVhDfpitmym1CSzOz8PKdPmoRTqqjDvWekey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UrCo7emB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B3fM2U012444
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iS/AMLx5WfTsuFmeMy00aDgSBpo96c7fJK4uXFuxMGg=; b=UrCo7emBPws/YPfw
	DbmgAe5XvojHppPBrsLaJ6sqTBvDc2W//Kijk/OsywhSk71BE4cO1g+Qv2bjc+Av
	xG74oZMeQvfUObYX8qEpZx22hR6tIxb5PTQGNojPE0ceiPE1jzLO8qNvgHptSba7
	E9RlKVdwOQvy3UMrbp6zE+8FKHpoeGxho5rsk+caPZnLdaISaJqxdamD/R8cFEEu
	RvW0ct0VxSjPKz/rj63+VjGTZJwNIlD4I7gfRNHgR9YWzbCbfl5hyuGhEyUk+Stn
	Jd7bPhuaWLhdwJs2L0ZIU7kNtTa4AE608F3mIz7u/3o/SlLhJzs3SKnrePfS9zek
	sTNhqA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qxv3rf3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:19:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fa440e16ddso6165955a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 23:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739258394; x=1739863194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iS/AMLx5WfTsuFmeMy00aDgSBpo96c7fJK4uXFuxMGg=;
        b=V/2cF/+Njm2qQ6gnKt0h4tVe7I7ezGs4+V+9IrYnsdTx/RjJjawdt5XWjngN5ye05Z
         /7+akckxLRTINs+1wSTRKbXk2bxXsMn5cgbUyKfAJj8b2RcObqU83+oW/248V4w9/6c/
         SV0eP2YScp3Sp7THnzYEtd5uUZXgX97TXfuobvjPQERbhS8UDAdExodIYt0s2r/ZzbO7
         Pjm3Sk60f+wgF8TMeS4iwkt0aQpfOBxUuG6K58Ne5LWQgG5wgrEUuFGRlsWOFG/tRWG6
         q59dcy5BbDB1ILT3KsNlA2ZdOpUfJ4jzaNOv9ma0V8OpTX0SyZZ5NcVlk195x5zvdC6A
         YRrA==
X-Gm-Message-State: AOJu0Yxv4xgJvBgoMOJfFKPaL1z8rOddiT4YW/ONIa79soxmjR2VgRPn
	yFW2+R5CJMTK3btKJO1B5419K+nkBQ+40GLzXNLMjEx91GZcQ2aN1OJwfRGaJMD6GVETe9qt2t0
	18kG5a6NeSq4RDf0u5+6R99jYpvBDV+dg4jgBuFdeggViTZds4ONZUFyUIb/PRg4lb5sz6iwUeA
	==
X-Gm-Gg: ASbGncuot4fwZnBp+HFWdLU4dR/ycBL0ikNyhTfV3MWTeq8tUu2zfYq/9rJCvOMSP3C
	Ew85yShSAl5aqIQFwe9hBZUREv02stIo2ZeGhNxPUQJe+RpBIIusWTJD+4/wbWjxyTBvUXp4D3W
	yRMcaY7rmIY2aG5TJ7HjkhVOrRgmVgCSEzRA4JeBUNcYLRXcJqq5WrY5gqFVDl6ZYiU7jpdIT3a
	EhCcBl+fkCuRI7P6qQe7ItpB1HgEmwvadZLEP285F4GAGT1SvKwx8sE3BJnhAfMQH0gPsK/AtxP
	p1pCGc949jIDEjezLOqnOKJpr4RObn3DpbKgAltC64RXPxWx2F1i
X-Received: by 2002:a05:6a00:2d8a:b0:72f:590f:2859 with SMTP id d2e1a72fcca58-7305d482e33mr24822929b3a.13.1739258393647;
        Mon, 10 Feb 2025 23:19:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwqAq5l9Ji9C88x1p2Eexlw37essUckjr3xte7DxXx9hZFmyJ03MrvQumAt/ZQWvw6s/wvRQ==
X-Received: by 2002:a05:6a00:2d8a:b0:72f:590f:2859 with SMTP id d2e1a72fcca58-7305d482e33mr24822905b3a.13.1739258393259;
        Mon, 10 Feb 2025 23:19:53 -0800 (PST)
Received: from [192.168.225.142] ([157.48.123.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73094992465sm2587063b3a.148.2025.02.10.23.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 23:19:52 -0800 (PST)
Message-ID: <1c79a03b-3379-27af-693e-1b4a5f64c6e6@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 12:49:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/2] wifi: ath11k: fix RCU stall while reaping monitor
 destination ring
To: Kang Yang <quic_kangyang@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20241219110531.2096-1-quic_kangyang@quicinc.com>
 <20241219110531.2096-2-quic_kangyang@quicinc.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20241219110531.2096-2-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: md-Ap2iwY0OsoG7YsV1o17fGw6fMDM_C
X-Proofpoint-ORIG-GUID: md-Ap2iwY0OsoG7YsV1o17fGw6fMDM_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_03,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502110043



On 12/19/2024 4:35 PM, Kang Yang wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> While processing the monitor destination ring, MSDUs are reaped from the
> link descriptor based on the corresponding buf_id.
> 
> However, sometimes the driver cannot obtain a valid buffer corresponding
> to the buf_id received from the hardware. This causes an infinite loop
> in the destination processing, resulting in a kernel crash.
> 
> kernel log:
> ath11k_pci 0000:58:00.0: data msdu_pop: invalid buf_id 309
> ath11k_pci 0000:58:00.0: data dp_rx_monitor_link_desc_return failed
> ath11k_pci 0000:58:00.0: data msdu_pop: invalid buf_id 309
> ath11k_pci 0000:58:00.0: data dp_rx_monitor_link_desc_return failed
> 
> Fix this by skipping the problematic buf_id and reaping the next entry,
> replacing the break with the next MSDU processing.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

