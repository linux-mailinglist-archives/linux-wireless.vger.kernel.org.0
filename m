Return-Path: <linux-wireless+bounces-18380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF864A26C25
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F78C167F6C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 06:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B722D1DDC23;
	Tue,  4 Feb 2025 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BZsqEqEQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290C13212A
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738650727; cv=none; b=sbbl1eQdXUSLaqe4tXai+kixPG3f8V6Oc1xRcL8P1wz6Q/0nxX1jTmyxeOTEw4vWQmq5zulVvrRh85ZOexQ36JngMRpv1Mp2m1CETzfpn1h0fBvF82Ud+gMQqzAAcy99RFIqBOyZZZC0UHa3HcbJv6jCCNVqjig2dRoZUHBVauY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738650727; c=relaxed/simple;
	bh=/4rjOTwNi39W+501f8EHnO7fW/g7V8wDWtjN3ItXb7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzsXkhnoV/c4EAHKe3uQpxN6YcL5Y9CdKfayREKgpe9AlqFkEg4Ii86hdceAd20XkmzT/NmI14dnhnHhfs+KR0mh5oioAjNTjEOVHZZ96qz3iPu1sXESWEid5XCVoxFJs1TnQlB5iUel+++P40Aqkxq2cKkerxY9jxS1te7EPXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BZsqEqEQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513HfVhx017317
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 06:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ejXDfZiXgdUwzRJOza06PMfldWfFVq6Bwxl1/GBOZko=; b=BZsqEqEQdJwel5cw
	JU1xkQRk7i0FSYNi3eyzz/gIUPGqC+HZsbM91nfts3dSeeu3ap+HNv6J1lkRw8vb
	7bNzlPTOFHM2dNTPUBdgApJWRTJOM0/+G/IHcOdMqpvVUCaaRG9kTT+ULJjMLbI6
	/iLmsWZTw0nbEooh90KbfewFRmuph5PFLNL1FyKbwJnbFS/eyqGr4GMgIlPJ+P4H
	v2uZTJB3eCM8xaxXKtMgxSKqUbAa1ggkoDDBN0RaCOPHEfEv2RcSdMQiqRdmscYM
	2GAwo9TKHa2F11lZ2XqNgMOChOZv0gyPzm7o/2FWULZhMFAwvIhsk+UOIO8qn0S4
	MBwkLQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k2e1hef2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 06:32:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2166f9f52fbso174072515ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 22:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738650723; x=1739255523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejXDfZiXgdUwzRJOza06PMfldWfFVq6Bwxl1/GBOZko=;
        b=OwuadkxMQ7njeWcHCXHq6EalEaP0Cz6GpraLIzdsCEr90pzFaRJuS+CcztfpIandul
         7SGtHgaNzPAOlUs0oM1GVlmMQ/fHr0caVCCjNeQ2Ig0B7WuaX0hExcreP2OEF5DbV2Sx
         pH1mAzjGtOhP2NT0dnfonqlpFH9EWZuKCR/M7YbKycs3e7BB7rirsgDBuR9QYxA89X+5
         JqYjTDvKtrFDDlpSFhYr1Ewcj6qcJm3WBibaryet0pn9niQtsi4eeCFgauYRCFm9oC+U
         HCICwBjlTsn5NsFuxDEd4qtu1jIezlvSxtUXZ6vgLq2URehkDLewd+VttTImJj+GeyAJ
         nTfA==
X-Gm-Message-State: AOJu0YwrI/cNrlrFFrlk0DakSfDAed/LC+Ws7ge6JCNfPi0nSo3ERNrp
	l6/z7WjuYs0p2aHJx5HSqTKQS9OKL95yf3d7yNVx0QYee0w2qDCN1REVPluM/OkE2K2sAj+gcva
	mlnA2ZgbYsXsWmyFGbIOkj20Z7EmmexVGpwuPOY261xR84rcSDIbpYNguJgoWdLROSA==
X-Gm-Gg: ASbGncsaRAXGIo4r0jq071lK9zJFJerpieDhBGqLzjXvNglU3/DA5PL7NJpE9YG39+S
	b6kBWRW9jURJ8VNE0Zvv1xdWBHUPNAWaG2/DsmpCvRACzeLaglFJhIiiJBbnvjfSrpP4XN+Zep+
	BneCENzSw9mOLZdlcbnC8hw8RzBLXp2owEhQbeiuIoN1aDMA8SD8w0LJu0BzhSE7Cne83aErR+t
	dBP8XqB5tYzZpw/O3q7+SP9GGSGBTbGae0i1maLmGEGLHzbbTrCXMTPEFTmr/J05uOQJX6F93OP
	j60wFptuP6seig3NlqKqPskybzUg3XhXcUDQ24M=
X-Received: by 2002:a17:902:d2cd:b0:21e:fe28:adab with SMTP id d9443c01a7336-21efe28afa2mr37251795ad.45.1738650723295;
        Mon, 03 Feb 2025 22:32:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxbwyPkI8o79Yk8tejCx6Qy5rP1sKmP/UkbDF5+RPS3e0OytLPrYq/FCiE31NfOr6norJfSA==
X-Received: by 2002:a17:902:d2cd:b0:21e:fe28:adab with SMTP id d9443c01a7336-21efe28afa2mr37251405ad.45.1738650722898;
        Mon, 03 Feb 2025 22:32:02 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bfbfe6bsm13837746a91.46.2025.02.03.22.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 22:32:02 -0800 (PST)
Message-ID: <20960f16-d797-48a8-9bd7-29af3e88593c@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 12:01:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Pass correct values of center freq1 and
 center freq2 for 320 MHz
To: Suraj P Kizhakkethil <quic_surapk@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>
References: <20250204053451.2703834-1-quic_surapk@quicinc.com>
 <20250204053451.2703834-3-quic_surapk@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250204053451.2703834-3-quic_surapk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yHNUZR94texth07raCV-mB4xPHX2YMzv
X-Proofpoint-ORIG-GUID: yHNUZR94texth07raCV-mB4xPHX2YMzv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040051

On 2/4/25 11:04, Suraj P Kizhakkethil wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Currently, for 320 MHz bandwidth, center frequency1 and
> center frequency2 are not passed correctly to the firmware.
> Set center frequency1 as the center frequency of the
> primary 160 MHz channel segment and center frequency2 as the center
> frequency of the 320 MHz channel and pass the values
> to the firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

