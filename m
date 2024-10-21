Return-Path: <linux-wireless+bounces-14269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A879A6BF9
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 16:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F991C220B4
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90711F9435;
	Mon, 21 Oct 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cRjiCiTO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D134B1EE03C
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520511; cv=none; b=d80I1tuLek+9O+or2UBLFIqD5OFzA8/lKEn+j4AnCUS1qZnRo2Ny3EYrE5TeyT9D8J7LLdBjgcp0IMgr0t2LsBna/9RUnQIpRRtte/CuiULLEZOVvHczeohVwJ4qZqUZahdKs7UaXv1AxGS79hsQF0w1Utv707qUa2D8O/UsXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520511; c=relaxed/simple;
	bh=NImR+FswIWVKwKMPHc0go2mJWZ4lmJSDs2n/YXZAbwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NwDdnVZAIeRVHarB6Ncd4wFlkORTqWfNPH5zYJO0SNCiPOlUGfQoeLUlpEiIfSb1jg/w1+K4Blbt8dGZcqIQrwnldhrUGm5obm3iyngAQS4XmATnnwFv5swiJkAb32oIXFSwNMhp+nXtK28H3fdH7PJxHYJfMnLsQGHuM0zo5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cRjiCiTO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L8Vwwx014493;
	Mon, 21 Oct 2024 14:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zHeHBrYwxMWQ5dqpnebe7U8TJnrsgqXzhfBrqoLnTMY=; b=cRjiCiTO5Sk7Ze8p
	UztD0//clkrsvGweiNy5AN6kcgn6jBDAAfi2svWbb/uq94GE+RlRsdzuDcRjj8RP
	V2+kX8611e42NsVOnPZgnXBMvsB1IZxQjP2LXAOAhnDIMvo3e8cldk4zaxrA9cdi
	PNiY0+OvhMP/qa6uSTOCXysOyaXGsr5NgazHTJMQ8878v5TpBM0t0MQHj/SQ/y1K
	poYpzAfc1o8kfWK0cUuG4z8PHaYhx0a1fvzgrW+0SxdLYkBDFmMqwFz8obL6HmDt
	KE6Akru0qr8oDOSZGIcUkAE8tcRcWhypC3BtX2FzOZa2JGjAoHA5ezRWmyJuE77+
	ZNBegA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkhd16uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 14:21:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LELe03023458
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 14:21:40 GMT
Received: from [10.48.241.209] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 07:21:40 -0700
Message-ID: <bba049d4-39f2-491b-a5e5-ebae0a77fe45@quicinc.com>
Date: Mon, 21 Oct 2024 07:21:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k-firmware: QCA6390 hw2.0: Add bdf for Xiaomi Pad 5 Pro
To: Jianhua Lu <lujianhua000@gmail.com>, <ath11k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <ZwR1hu-B0bGe4zG7@localhost.localdomain>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <ZwR1hu-B0bGe4zG7@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yM7wa7HumAMYZAzzt_AckFEeLOEDug0z
X-Proofpoint-GUID: yM7wa7HumAMYZAzzt_AckFEeLOEDug0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=794
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410210103

On 10/7/2024 4:57 PM, Jianhua Lu wrote:
> Add bdf for Xiaomi Pad 5 Pro, which running mainline kernel.
> 
> * description for what hardware this is:
> 
>   - it is a SM8250 based board
>   - it use QCA6390 as wlan module
> 
> * origin of the board file (did you create it yourself or where you
>   downloaded)
> 
>   - taken from stock firmware image
> 
> * ids to be used with the board file (ATH10K_BD_IE_BOARD_NAME in ath10k)
> 
>   - QCA6390 hw2.0
> 
>     + bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=Xiaomi_Pad_5Pro
>       sha256sum:
> 	  a5c99867d398b4e8773d106100e8575e1b3c29b8e18921dae50029b1253eac06
> 
> * attach the actual board file (board.bin)
> 
>   - The name of the files are equal to the id string in the board-2.bin
>     (minus the ".bin")

This has been staged:

https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware/-/commit/4c8ae2fb2b78d5b0bebed63fe8b0f348f9fbc33e

BTW in the future be sure to include linux-wireless with any ath1*k board
requests so that they can be tracked in patchwork.

/jeff

