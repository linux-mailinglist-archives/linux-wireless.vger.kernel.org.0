Return-Path: <linux-wireless+bounces-14270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4CF9A6C00
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 16:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3AC28236E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A541EE03C;
	Mon, 21 Oct 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jxH9UHgV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272731AAD7
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520648; cv=none; b=ROntPpL30KBXwzkMTH8uG+JptCfpE8OuhLNYw4Zxbqbeon3y6xS/0m4HZ/MzVbpmW8Sp663VO4OS93DOl/1ZvDlp/X/5d0AE6WSRagzq//JEpusO35Dwy251Uo9OYh052iY5Ul5p+RMLUVRu431fiXhChZuSiQBz+VABe6GIORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520648; c=relaxed/simple;
	bh=V7tBBKOqub036SqC8OYDkU4gFL87gpUGY1zV7ybIrG0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ga4WUlDK1qVZo6wy/5tdyFOXtkFyrfPOOj28f0RF2AD5+pEisPa9LM3zf4b1jiZHkJShVn5pnMolCmUGyxVoF91v8mL8PwcwMQi9sIq/0+3oncnuu0Eyz77fGQhSrQnMtlTRAx3aD/kHs3YrNByaLcGo8JaGzT/qavA2zEmv97I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jxH9UHgV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LA80r6029714;
	Mon, 21 Oct 2024 14:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jLpQ6qjyi/TBr/tyOKj/ngg9W8JrmIpwmjcHBe9zq8c=; b=jxH9UHgVl//hUtY4
	uS3Ji6dUHKUAKo/+G2GCgL80GcOR0CPYr+pFsnG2KiuFvJDly+GXWBFHZ6C46iHu
	sV58a4N6hFkwEitBlW5MMfwPABThBChLFDNbjTyqzoZFXmRKcPCbH5ONdq29wR1G
	xtChuOAFhOeQnYx2KjHNmik23avvM1I03zwUf3vEL/1TjlYq7AbektuAZn0pYmu2
	PCLPt6+HWjB/oKnQ1oOHwD3BKqk/wnoy8u8JugkTp1yuoj0vflZh+Xf40zVp4NIG
	c4hanbBemxc9yIB02oxz9p7oOzn6nxZ1w1c5bJsnVfDhGqZLqWBxPwaBWbZu1cQn
	OyesMg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vuw1ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 14:24:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LEO0uc024954
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 14:24:00 GMT
Received: from [10.48.241.209] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 07:24:00 -0700
Message-ID: <dc92b42f-a71d-4ca9-bde2-92c3ed30718a@quicinc.com>
Date: Mon, 21 Oct 2024 07:23:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k-firmware: QCA6390 hw2.0: Add bdf for Xiaomi Pad 5 Pro
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Jianhua Lu <lujianhua000@gmail.com>, <ath11k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <ZwR1hu-B0bGe4zG7@localhost.localdomain>
 <bba049d4-39f2-491b-a5e5-ebae0a77fe45@quicinc.com>
Content-Language: en-US
In-Reply-To: <bba049d4-39f2-491b-a5e5-ebae0a77fe45@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tonQVbf-0XB0t-E0HiY9rae1vdcpTaWs
X-Proofpoint-GUID: tonQVbf-0XB0t-E0HiY9rae1vdcpTaWs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=834 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210103

On 10/21/2024 7:21 AM, Jeff Johnson wrote:
> On 10/7/2024 4:57 PM, Jianhua Lu wrote:
>> Add bdf for Xiaomi Pad 5 Pro, which running mainline kernel.
>>
>> * description for what hardware this is:
>>
>>   - it is a SM8250 based board
>>   - it use QCA6390 as wlan module
>>
>> * origin of the board file (did you create it yourself or where you
>>   downloaded)
>>
>>   - taken from stock firmware image
>>
>> * ids to be used with the board file (ATH10K_BD_IE_BOARD_NAME in ath10k)
>>
>>   - QCA6390 hw2.0
>>
>>     + bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=Xiaomi_Pad_5Pro
>>       sha256sum:
>> 	  a5c99867d398b4e8773d106100e8575e1b3c29b8e18921dae50029b1253eac06
>>
>> * attach the actual board file (board.bin)
>>
>>   - The name of the files are equal to the id string in the board-2.bin
>>     (minus the ".bin")
> 
> This has been staged:
> 
> https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware/-/commit/4c8ae2fb2b78d5b0bebed63fe8b0f348f9fbc33e

sigh, correct link:
https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware/-/commit/4c8ae2fb2b78d5b0bebed63fe8b0f348f9fbc33e


