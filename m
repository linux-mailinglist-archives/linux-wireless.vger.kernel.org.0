Return-Path: <linux-wireless+bounces-18303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7F3A25E75
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 16:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8A416A175
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010520897F;
	Mon,  3 Feb 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jI03SrBI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851420A5E4
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595764; cv=none; b=KmKsBWygmLPZvuEh1hgGA1dWNvkOUI7cotgLR23i/TKyrZ//YBSJGPe+QnB6alTjh9cdglYE16B89/wcIVNQ1tJCsMbseU1dXxPNbVSIS/fw+ckw0l28ONxN1jKb0Is7MoLi7i7LLsj2vQYYEm6p3+kdOgBP/jLRX4qke0uQgzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595764; c=relaxed/simple;
	bh=iDydjZq57ezzw7Vxnzs7qjXNp5dvuX41IuPAdtjO5n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnNlW5kx6OhfptPUPVRpLbPRoWf+X0zZgQf0gr5mCBvwZdDhbQJY1N7A2gstT9JVrCwcPb1Ypj/Z6aKEwFcCiB7rt9aCtY+ot/qGtcdkFk8fOnic5JiAfEVbky4+AsdiGOSudt4BtVosXJgFE2C60pr+zP/AFwi5g9GUDKGmVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jI03SrBI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513Es8Df006219
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 15:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RbOpfV4DVLO95imPLnFbxGA0p3PpVX2ZR/gqOgfzH+g=; b=jI03SrBIEZSG1FQx
	FgO+tWTr2FLokgeV/B2jwC1kX6+8vi4UM6Hb+0y5YROeqs4UxtJ7gy/S4FdL7j86
	U1VOH+roJrLyA6TJBjgbnSPJiMl6WCuoToARAe8WqbNNHsO8sfd5EgeDz/ZMPY8z
	KQbh9RpLqNVYcNXLBC7mcQxZUVcVUFyopUYijAjkw0gIzNI5Kd9YZgBU84e+qDsx
	lLIoeI3K+6ikn/r8U4aOUgCxBhHudDGnHJv26N2VnL+mJP4iV7DF2OXNiCPy3U7e
	Za4BbxfkULLorbVspwa+KRBbTonIBPqM1Aa83ulSQcWMmoMgcC1gApkF9iinQyCG
	K2ErDQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jqxw1fqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 15:16:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21681a2c0d5so86112645ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 07:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738595759; x=1739200559;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbOpfV4DVLO95imPLnFbxGA0p3PpVX2ZR/gqOgfzH+g=;
        b=eDi5cBbgk2E78MTTflzn/+xQt6XQAmnvmMtDDvqxxd2sjoCvkPUnbl4SfPXv+VjcMK
         r1439+R0+6b32C7rzMqarlaSdGFYH+ZrGfDEuXAd3eCFJXD2v6+ZAx+UlZ3NOKFVz6+T
         6/CRaket5TsdsqqGBTta3wyFvGolW1oYiLu2JH5DZbpQgV9cRhqa/7JSV5IUMJnOkrBG
         g5uhySgVWwNLcKR1cPBKoMv9BxV2Y6da2+N7o6clDV2HbpWHCoEsSs5LeW1uqPvG+psA
         p7ljStdzWfTewMw8Gpk+pLJPOrqJ7WLgrREHkOnhDf33lFDfcMkAC6aCyCAsLjnu8yvw
         DxBQ==
X-Gm-Message-State: AOJu0YysAtMZl/Qg17lk5o2HAZZx/DGMh8Xsf10/zSriiLROEHGeoSVs
	pZTqjYPFvGyrHJdXHX0tnl1VnNvPY/Dca0FtCDoOy2VSgLr1kJOzxX8mac5qTQq0rC7G8FaZlN7
	kLwLgKCsVXrmpHgtTGg9AECFgGPZy9z+RqFTjuwDZMizU7gRK3/Z1JGznMaBR5hUPbw==
X-Gm-Gg: ASbGncslBz97ValnnIx8148MCTwr8djLGSwxkuf0D3uxB20IXSFtNMTSgGVhOU1K2OO
	wnT7zQq1kpCQZV8ElqMiEdcmMpjYtLip2gIH+i9tRj2vQEb+wps962YjMCiimIYIf7D9iageZ7c
	s3Nx8Pu/oN1cUZETlT/t13mlESUoHzsomIMJb0gx8TRcduA/1JGnfYDICwdAxdV7d/o65E8L6lQ
	6YVGPf3miFbSqKyCoEwGjM4QGs9b1QK/CyyhYvbiLS/Valk29gffBNmgijVc1K77LoUaRScux0V
	v2wNzBg4tbLfHfV81TCr3OK9VWepkbCEEfTv00WzGg==
X-Received: by 2002:a05:6a00:a96:b0:725:b201:2362 with SMTP id d2e1a72fcca58-72fd0c04624mr33183662b3a.11.1738595757595;
        Mon, 03 Feb 2025 07:15:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYUrkJ7xVaQWMC1G1nTizk+q1vhiGIW+1+1WOMLMlj9A3d7Db1ZQ/tItgeo5j/1nrKRmJPXg==
X-Received: by 2002:a05:6a00:a96:b0:725:b201:2362 with SMTP id d2e1a72fcca58-72fd0c04624mr33183463b3a.11.1738595755582;
        Mon, 03 Feb 2025 07:15:55 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631c039sm8604049b3a.25.2025.02.03.07.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 07:15:55 -0800 (PST)
Message-ID: <b6ac3212-8e68-4c64-8434-b03cc4d380d0@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 20:45:51 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] wifi: ath12k: Add Support to Parse TPC Event from
 Firmware
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
References: <20250130061104.962124-1-quic_rdevanat@quicinc.com>
 <20250130061104.962124-2-quic_rdevanat@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250130061104.962124-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eeUVcrChnKZmIQwbG2JUs4UPxQtYxl4A
X-Proofpoint-GUID: eeUVcrChnKZmIQwbG2JUs4UPxQtYxl4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030112

On 1/30/25 11:41, Roopni Devanathan wrote:
> From: Sowmiya Sree Elavalagan<quic_ssreeela@quicinc.com>
> 
> Host receives four Transmit Power Control(TPC) events from firmware on
> sending TPC request. Fixed param TLV is present as part of all event to
> indicate the event count and end of event. TPC config parameters along
> with regulatory power array comes as first event. Rates array comes as
> second and third event as it cannot be packed in single event.
> Conformance Test Limit (CTL) power array comes as the fourth event.
> Firmware packs different sets of array params which includes array
> length and type inside master TLV as different subtlvs. And the actual
> content of array is packed one after the other inside a separate TLV as
> single buffer.
> 
> Parse various events and save it in local structures. Create tpc_stats
> file using debugfs to store these local structures. Create function to
> handle TPC stats read to relay the information to the user.
> 
> Command usage:
> cat > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/tpc_stats
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan<quic_ssreeela@quicinc.com>
> Co-developed-by: Ramya Gnanasekar<quic_rgnanase@quicinc.com>
> Signed-off-by: Ramya Gnanasekar<quic_rgnanase@quicinc.com>
> Co-developed-by: Roopni Devanathan<quic_rdevanat@quicinc.com>
> Signed-off-by: Roopni Devanathan<quic_rdevanat@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>


-- 
Aditya

