Return-Path: <linux-wireless+bounces-27416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6599BB7C88E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E6B52710D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 03:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12289261594;
	Wed, 17 Sep 2025 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="azFY920c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9E725FA3B
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080763; cv=none; b=RonfVz1in6KoOaCuSQVqGOI+KXPNxX/lKP/RFog5K8GgwEqr5aMwnlNpDiDriypEB3jY3fszqoOjOOVkRPuCaIaeBH/h5G1ClymIzTt1g4+Z3kxBFo9wuGcc9hFFQbWo5Kll0e0N5+SeqWXFV+Y2nAssoKxxxQv6lpofpHlOdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080763; c=relaxed/simple;
	bh=sY7+9SKozhRu/TkYni/YpHN2Ml74bnH6lOQPxmF60jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoJGJzuUD30p9jg8AWrpRx2g26+m1rL/QRmn+CduKtwL/iZMsd3HwEb0bE/lUdCLDfx48+bqVqJ0m3Yfu3TkqhY0ef4h5UeN7lP1/ysuCVWVl5dFS5bWgQS21YTcCvu7kpgx8NdEzHosw4Gkd4YbVgt+4sXZhYOsPQaBasu8Wf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=azFY920c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLajKh021938
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 03:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AMuqU4rto6Tj0kKX2+FmkQgPqo1rKzpdESKn4BxVroY=; b=azFY920c9ghQDLkf
	fX1sqqg7aNP5Jffz9GSXh2VnR3wLXWdhE/kAGkT1J/6ydDFjA2lj8Bu75q+vf84Y
	HAzp0fPEqxhxWj5HdgwyysKxmo6FGp63iIJB86ImYVab7kK3JtyPW33HR4uCkiE+
	PrzdVmXHggxIPTwxuTTOWAnCnniiQL1A7zCUo6MhbbAcDCJXunrXvRw3jJUO3PED
	fGkoCLarGOX0u8YngLPc8fV1rszd5YPTrAfGevKaUU0MesqoqET6VuYMDWe63u0Q
	6WLWbOU7O/V9xBvxaUQ4ziZsDS+q69RMe5nZ+f3SsAn9NOYepWcPRygz/fH1zm2G
	+Q6abg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxygsr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 03:46:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7761dd1c845so4109077b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 20:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758080760; x=1758685560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMuqU4rto6Tj0kKX2+FmkQgPqo1rKzpdESKn4BxVroY=;
        b=efq8UdYuNdNfB74sLGd3lKJDWwPo51mbeBxxHHbZKzShlA3Ry2lrebbRBDS666IUep
         YQnHDKB4taqtWFjfai+4Fx3t+yT9KyqF5Zi+4bhny4IfKSbRMDNfS/5Fo5ZrqnxGVQpV
         vbideUcVPaMmyhzw9wtJuA9tTTpIwLDaZB41xKHEpS7mPhiBippmgcYurwHqowXJtL3L
         M/SuuzQ+0F+uJO28DIGEsSeZenC6bDsinFRV0z+iC+pKFDUt1htMtePThAuQVAxW9rQJ
         a0f/lZydz59WhB7qyl5jFSRnTt3OhYNyxcnJzf/jOkRR5BgtsZaj1AOmF5BgOswSQDjS
         tGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWez3QeaGTpgNAxNOvgQGd/sicZaQ72lmhq+gVioiXBkU6AxubfeeOcyU0+fQxT59/zA/yEcdLqGHpy3aNiVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYXPhYlS83A6gngknbeF3A/IYDt8gOqKaVBNiYUEtKNEAoKsh+
	HXe7m51kLKOktjDdlLhWL2KStV/173uBwkB/Pk/oQvCk6OpDDneEMww8PJXbH/PgEXDVQIpzhB5
	/0tNlgz5BpayIlT0/9wrdDH9rWQFuIZEtnWOCHuZLf2aA00sS6/kzl6vnXpmbb55tnfsgrce3d4
	6W0Q==
X-Gm-Gg: ASbGncvwE1pMnh3hmgwI/VmzbCqFBIxWiVLgTNg/nXdo66xY4s3aFKDBVIgU2DmTHgO
	Wo2w3jkcvhF0zJu80ppjM92/Z8TYkJ8UzitO+Ilw5K9YmrTFhQ4ohkaEC82b8aIabqxfZE9wxl7
	ZKJBIaZTlhGucsfbKGEhjxwA0GCKkzrLmLbQ9Kbei1Z9h8RMhCbi1PeEpMNKD8HEq8sTzAIT357
	HsyRPMxZKFz57vcvwEnU/9Kc3nQ5jN9aa2bjnkJaB6nkAs7t91dsH8+nreV7KV5l08UnjYjgaIn
	QqngZwcg9iCmDlAzZphtz/oIr//VitpUZFKZi72EB8g1qqg2+ok0Pe0/9U3uQe/yNMkUnE9ke7l
	WmCICb0hY5mY=
X-Received: by 2002:a05:6a21:6d94:b0:240:1d4f:720b with SMTP id adf61e73a8af0-27a9760c9d8mr838026637.23.1758080759693;
        Tue, 16 Sep 2025 20:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0SDPT67Q8/Cmh9y8XsaaAI5lLTinSzkTWY7gbKUtf+kghwj+ZUL4wfYqfmIlqztAHU7GdLA==
X-Received: by 2002:a05:6a21:6d94:b0:240:1d4f:720b with SMTP id adf61e73a8af0-27a9760c9d8mr838000637.23.1758080759189;
        Tue, 16 Sep 2025 20:45:59 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.98.234])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54f4aafde6sm30670a12.23.2025.09.16.20.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 20:45:58 -0700 (PDT)
Message-ID: <e2809c34-7002-f189-a10e-21695b529ee2@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 09:15:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: fix 2 instances of Smatch
 warnings
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68ca2ef8 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=r0KOKur2OvuaYElxfjaavw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=BoDogKCtvrOBLCu30DUA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 4D9WIUDxySgMa1LG3GU_uV6Pvmee8936
X-Proofpoint-ORIG-GUID: 4D9WIUDxySgMa1LG3GU_uV6Pvmee8936
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7cea33RInE3S
 /wQLXqwCMXuDE5rydpcjVuW3N/9BB0zHpegFftfIGFyUBawcY6YXU2ON+cP6T4v5HRTEAAPnqUL
 vfejLOk7kAQMKwWCA/GLv9Qjla5CuGl7Y1EGv49D/h8gF0JZbQdLfIzXtEomZs9SIucaIiWsu+7
 hpF7BZiHGekKFcqGMUdyztOKXiQefkEJ29+K/7JKey8pEMMcXZW6PHa3FonB7BJl+CNo5g19Kq8
 o3jpNCA9Z+3N7nKr/iMYwgm281lX0AI/67GbnAYbGiWeoSUeDSYKDLeuZK0uxvd3DZldWZrj6nB
 2t2oNLYKJrf6zIZX6wjHEUelx95nVHmwHlgFBzEyCxHO95pcN+er93EDSqjumure1R7Ei/aX9Pr
 Lz2A1n9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/4/2025 8:33 AM, Baochen Qiang wrote:
> Fix below two Smatch warnings:
> 
> 1#
> drivers/net/wireless/ath/ath12k/mac.c:10069
> ath12k_mac_fill_reg_tpc_info() error: uninitialized symbol 'eirp_power'.
> 
> 2#
> drivers/net/wireless/ath/ath12k/mac.c:9812
> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'local_non_psd->power' 5 <= 15
> drivers/net/wireless/ath/ath12k/mac.c:9812
> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'reg_non_psd->power' 5 <= 15
> 
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
> Baochen Qiang (2):
>        wifi: ath12k: initialize eirp_power before use
>        wifi: ath12k: fix overflow warning on num_pwr_levels
> 
>   drivers/net/wireless/ath/ath12k/mac.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

