Return-Path: <linux-wireless+bounces-24563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358C8AEA3EB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 18:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308643A4F31
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75028C5A9;
	Thu, 26 Jun 2025 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f8deDrJ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38221507F
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957141; cv=none; b=YCY+X0MkcKEt4iKfNkIxOB4XPLdF1Jv1mF88t+XbMM6Wu66yLygOkrkgbXYjRNP4PnYmSddOVthbnepBxvu2wPdv2Y8bhgsIFW7BFER66bzZ1CuH9wY8X3neFe5ASwGabh89SmyeGc1jujZSJqCDwGOCL7XNx+9b7dX1e3Uc2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957141; c=relaxed/simple;
	bh=FP0OWrSM5UFdwpJyAWRkGkLiWZASZR2VM8uql8M9qZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrKo2jpRISYePwwbVVyuKxkjVX21xXQpJlIPo9QgPtuzKXlrXvuoCFuCT1fRHrgY7I1HY771WaXQJqjUYwVfEnbb2RA4Pt/ls6049NAasW10gXApNkCAse6rPYWrpP6lTeW6ssAuhB84YjYgR7XcayRFMOsCAyDmDqgXodZX44A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f8deDrJ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9lYj6014546
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IFPPqTu7MXA+vyY2s6jE+8VmboVurKBM4dXe7ELAAi4=; b=f8deDrJ0pdWBJwzu
	KRooBqZTRkvta3YcV7jEhkrDITXu/O9awSvIhho4e3PcsDq5gKOk8aNE0Ti/jVnC
	Az6bAgBjyoyom0ZkFORwQ+hG5qDcG7eHFZRsQybx435lb1OrQaZIvwRzKpci9Ds1
	b1Lv16j6xO83WFO/7mdNanU51UJTDFhwC389RE4BIKAzR5NnJ4QQG6gSgzlxht5r
	FMBEJ01LMfIxIBxqCh3yNJlgn0IWEvKCD64B8wxj8KbIGB4EN6+LjgF37rxiP/aj
	xGeLQWC+dkTTmLroyVQSbA2piM1gHLexnO3d77YwkOk5GSF/eXwxFAv/mz3h4HW+
	SlATZw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgm1sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:58:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso1146985a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 09:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750957136; x=1751561936;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFPPqTu7MXA+vyY2s6jE+8VmboVurKBM4dXe7ELAAi4=;
        b=xNqkQw62mERe7Gkpv55ryTKRfLnznKGYKZrGQzHFQ3Mw30PC18yNhIiq1IUf8pWS7g
         7c+k+UpehAwSdX/026vm+HDzW0bqEa1AjpbdIbuI35BKjbSexYBde24jHe2DjP1iAYTB
         zSStW2ijoA17XvUyuTPp+0SNtk/+IA3Q1vSedezBNLWw2tb44iOpN0qrJTmez/H4GEmN
         CTL8kx/G8oHWWKGqJUdhIhhrEec6bKmAVPcUOW8QaXmLI5JAiF4N6OXOAv5YRfycPjtk
         Okm1aTxtfccbi7ZP4qrTYvHSH82YdU7cflFsH79/k1WUz5TcK5gWfC9SWKvGgG9M+/o8
         mrSQ==
X-Gm-Message-State: AOJu0YxohLbqnIw8rKa01DaZsCbB3SmDeI7W4MTSsQ+y+hzA62Ah18tl
	aRVHh8SnaYQN83dYy49a66gPDAgl6DaDt5Y6Zt8HAZTxRYsXc6mhts5pN7lS/5rLgsgQvx+qqY5
	pGNqLadPw8oqOKZB6YRPkaLNPXa4cgnjfxo2B64C5qj8WRMzVXaxpxqiJNXovYKvE/rbTJg==
X-Gm-Gg: ASbGncuJvKg/OBRrPQXCwoewvt0SUhLpWJBah1ZGwvSmR9U+e8UyWfcrAyn/MkFcXuT
	r/jVWeBLd3NG4omDrG3RrKWjUy6SJEXRvcLzD0oxuBlkDE+ERAopUPwfBYSD8B9yJSyER2iYdqp
	vojsJi/FH0zVEu/UDKy1CxIOtTYtsBiL6hhmFdgaZGlhQlD6uKJ4vfc15fXuKlrOmROtES7KErC
	nrf93jLHykDBD6NkKoYmY1Q3RBBX2ubw4LjkPhOf5th3QZ1TIjGJWBxp03k6Kz4+rBibAhtdcD7
	HS1kNKzAZWge9m8DbyYs6FqHtkAW0mCK6K4O7bs96/lkHQdH8Yf8CNlu12mhnYA3B3ytlKI=
X-Received: by 2002:a17:90b:582c:b0:313:1a8c:c2d3 with SMTP id 98e67ed59e1d1-315f26896dfmr9569155a91.22.1750957136301;
        Thu, 26 Jun 2025 09:58:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDpfopUuG4hU2Yb0y46Ll3Pqz+c1+9LjOPXninqakgris97nlpW0Y2qwrsu8JaSPMiEtOk7g==
X-Received: by 2002:a17:90b:582c:b0:313:1a8c:c2d3 with SMTP id 98e67ed59e1d1-315f26896dfmr9569125a91.22.1750957135783;
        Thu, 26 Jun 2025 09:58:55 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.255.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5428ae2sm4932845a91.28.2025.06.26.09.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 09:58:55 -0700 (PDT)
Message-ID: <27c788ee-b12d-cfe6-3543-f320c4b7fd72@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 22:28:51 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2 0/2] wifi: ath12k: use real noise floor value
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
References: <20250623-support_real_noise_floor-v2-0-974bbafa317e@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250623-support_real_noise_floor-v2-0-974bbafa317e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Z3CuNJZZZsJoltGDDIbh0fzTyxrcvhOP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE0MyBTYWx0ZWRfX+Er2FIPOHKS6
 ygu6ZYTfyeVakxK0CrY05LsRflWTja7H7kD6WZGDsWF29dgwVFXyqQQ7wlE9bgb9Wh1D75GuyuC
 7FPfj0UMoq2tKTakbZeqY9ThFHlRR+dSIU+4fPD2GTp+mNd3m4EEDK6tMnlLIWOSI5LgML474iI
 2+vKDr8zAF9jKwq/Bs89ElzmFMANIiVHsP+22fmY9nVNzLDq5LBBcjToTCyudqVH4N3uQW8aPUX
 idbP2GspfTT4mgzyt/A+J78mkCzmKGzYUiDrb6zMQqa3F1bbsxvrwslTD3bhjsnfFtkDSqSE78I
 pcLHLZaWgUjzJi11RNtXpAK6JdrZpaipICDz3aniwYytPdbDl2sJIYNWkAtgrf/5BOdcnr4zlAS
 kutJOMtCepKGOB/jDmZGnaC2/69kTgunhj7rUE4rah5dSN8FVDaKWlhVj05bcuQrLdmP0QWl
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685d7c51 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=/xG1ZwzdjF5UbGEDupzz2A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=-iIeHy2jdy7NZ5vI0E0A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: Z3CuNJZZZsJoltGDDIbh0fzTyxrcvhOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260143



On 6/23/2025 9:19 PM, Aditya Kumar Singh wrote:
> At present, the ATH12K_DEFAULT_NOISE_FLOOR (-95) is used to calculate RSSI
> value, providing an estimated noise floor value. Consequently, the RSSI
> value is also approximate. This works but however, using actual noise floor
> value will enable the reporting of the true RSSI value.
> 
> The firmware possesses the necessary data to determine the actual noise
> floor. This data is provided to the host via the WMI event
> WMI_PDEV_RSSI_DBM_CONVERSION_PARAMS_INFO_EVENTID, which includes the
> runtime parameters needed for calculating the real noise floor in dBm. This
> event is triggered by the firmware during channel changes, temperature
> offset adjustments, and hardware chainmask modifications.
> 
> Add support to handle and parse this WMI event. Use the received values to
> calculate and store the noise floor value and use at the required places.
> 
> ---
> Changes in v2:
> - Rebased to latest main. Simple conflict was only in wmi.h. No other changes.
> - Link to v1: https://lore.kernel.org/r/20250528-support_real_noise_floor-v1-0-04507bd3bc76@oss.qualcomm.com
> 
> ---
> Raj Kumar Bhagat (2):
>        wifi: ath12k: handle WMI event for real noise floor calculation
>        wifi: ath12k: use real noise floor instead of default value
> 
>   drivers/net/wireless/ath/ath12k/core.h   |  17 +++
>   drivers/net/wireless/ath/ath12k/dp_mon.c |   7 +-
>   drivers/net/wireless/ath/ath12k/dp_tx.c  |  20 ++-
>   drivers/net/wireless/ath/ath12k/mac.c    |  14 +-
>   drivers/net/wireless/ath/ath12k/wmi.c    | 233 ++++++++++++++++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/wmi.h    |  42 ++++++
>   6 files changed, 324 insertions(+), 9 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

