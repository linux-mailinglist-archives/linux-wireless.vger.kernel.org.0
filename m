Return-Path: <linux-wireless+bounces-17339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05431A09BA1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 20:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BCA188E92A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3564724B237;
	Fri, 10 Jan 2025 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QtSG/o25"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3186C24B231
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536343; cv=none; b=hypBL12xEtfVIN6rPCFxBefDmiYoLrGZ88PHTHjCNl8MAfW1u8/W5LpqmWZ3jJaGUKl+0JdSIqP/+aOL2f6ztQfB785yChgL18+mJkDE9qUKqEQinjcdGeogKQ5goTLNJeTLRfuXEod9zhCRluHDpWu1WJF9IpZxvWhBhnaP3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536343; c=relaxed/simple;
	bh=b/H5ZJGXP3XV7+tRZMhulVMTuS4W5GbRSnBqo4XMmd8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=pvfVLIcAfE5gaNgr+Phpkk2NDU518uDRlszI0Ym69CDNBnSIgVNV25ggKNSb8QAUQimEmLY+9lUrKMkZpMTfzv67Z4Y14HMsc9kcW2D8DWPp4IKd5l99DqaqXoBbIWY5WiRMQ8110Sfn6fRxvFQimG8sBobggmcuaD74YIwa0ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QtSG/o25; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ABEo7f029623;
	Fri, 10 Jan 2025 19:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b/H5ZJGXP3XV7+tRZMhulVMTuS4W5GbRSnBqo4XMmd8=; b=QtSG/o25/OTTmD4C
	XrcCcSzemhA0Yw92UST+cDRInxxkqwow6Xlb+voN1wiDWdSy9kwIhkKj8WWGLdkP
	O2CWHK27SK0XvZ+KUz2Ziw9j/KRmmo09zvSqPNwH+c+/1c/UrYrj7FaZn14XGMnm
	wjT4gkDWyZANQhzxZ3nEgiNfveJA82TDUl6hxUWLKQckO8NNjisICicH1638Aqrw
	Jwdp2/gmgR1B2Zzse6COhp2sjlcniSbM1uvkF5Y1i9IbqVa4erHUF259KsZ/ebRD
	jxNrj4YBzjVduDKDemuWqkTkumEfyNBLIOmrJ6k9XkceaCYzoDmPF7renj0RrNbp
	yuvWxQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4432gq16wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 19:12:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50AJCGSw027007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 19:12:16 GMT
Received: from [10.111.179.128] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 Jan
 2025 11:12:16 -0800
Message-ID: <cb3dec32-64e3-4246-9d4e-3519032e35d8@quicinc.com>
Date: Fri, 10 Jan 2025 11:12:15 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Add support to simulate firmware crash
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240829084411.3521261-1-quic_rgnanase@quicinc.com>
 <e7390faf-fdcb-4de4-b15a-ce849afef406@quicinc.com>
Content-Language: en-US
In-Reply-To: <e7390faf-fdcb-4de4-b15a-ce849afef406@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P0ct0Xfux146N7QIvg0Y7HQ92osHUgtA
X-Proofpoint-ORIG-GUID: P0ct0Xfux146N7QIvg0Y7HQ92osHUgtA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=939 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100148

On 8/30/2024 2:27 PM, Jeff Johnson wrote:
> On 8/29/2024 1:44 AM, Ramya Gnanasekar wrote:
>> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>>
>> Add debugfs support to simulate firmware crash to test firmware restart.
>>
>> Usage:
>> -----
>> echo assert > /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/simulate_fw_crash
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Now NAK since this no longer applies.
Please rebase to ath/main


