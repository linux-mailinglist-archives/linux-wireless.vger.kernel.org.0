Return-Path: <linux-wireless+bounces-4648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB43C879F8D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 00:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BD31C20DF3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 23:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4484D108;
	Tue, 12 Mar 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XLgTvFM4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B44D106
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285243; cv=none; b=VSWh90Ys5lsBzVLlQG4dH0QgTrn2tgyhCtWRT0C8Uo4QN/Usb4hVnf1nAIDczQeJWEOM1WHvvlFbZMEHq1ft337EWjIDrAsJxqFPFzACUasFBch+hXmZgM9mKlblNp7RByB6qNjevvdOp8yXi4eMIr2lTUKa+IEXaIoGfTaCuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285243; c=relaxed/simple;
	bh=9Dnqxi5Z1ck1xzO2hD8WnnLMKUY+fjVAXqjarjjMhHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SMXkGfAH/3TXcHxvOLghA/uaehOHlGudJ/QVCHFTjHcDfL1RrkUXPe6hRTZ7QPT6vtQz+FWJf8KE/V9IAo3fw6TgqsAMdMQWN6vQ9oZ0l0A8S7CGtl6Qp8ZUBqmet7wpYWBwuDTUx5orWDndB4/7S1CppuD2COuAfwqoAgcu1e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XLgTvFM4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CMqhZ7016775;
	Tue, 12 Mar 2024 23:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tJ3ryX6o7xF7M2xw2ApTxQmkDBzbrmUDQXsUDo/ojZk=; b=XL
	gTvFM4i4CTNUcoRTmmP+QcwqTEWDs2KW+3sS7oOMi7RQGhACsKGEdR0WdKMBt3gl
	FJwJL/6G7E0ex5fGlAlL3M+UIIyq0T9WGCrjgznD7+tNbkNVZyNbxqnJr+7fBofs
	3sFn5hQQ+z1Yx2hScW2n5uhpHWVsJgLsZiutSFZOfm8cYd/QjOJv/aID8PHGvIrk
	N+uIt6c+5v5yXCnt3+ez0ItVUap+B2zEik32XAT2YLhjKtTk6vYvh4Sj7HJVC4lc
	BZOwRg1jAYbSGCrwKc9TFek4THBAB7U3aZ5prKgO5E8Ba2uDiDbeWrTWOQe/HHZi
	5PFy3ohdHEju54AbidDg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtjef22v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 23:13:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CNDupK025776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 23:13:56 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 16:13:55 -0700
Message-ID: <7cfa431a-9530-48d3-855b-7c1c08b40a0a@quicinc.com>
Date: Tue, 12 Mar 2024 16:13:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] wifi: ath12k: modify regulatory support for
 single wiphy architecture
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-10-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240312135557.1778379-10-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oHKgySys57ynXEZX6hpxS5WYCDAeOtAN
X-Proofpoint-GUID: oHKgySys57ynXEZX6hpxS5WYCDAeOtAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_14,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=956 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120178

On 3/12/2024 6:55 AM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> With all the radios being combined and registered as a single
> mac80211 hw/wiphy, separate regd built from firmware rules need
> not be updated to cfg80211. Rather we can pick one of the regd
> built from the rules to update to cfg80211 for the whole
> registered device. We prefer 6 GHz pdev based rules since it has
> the rules for all bands. If the hw doesn't support 6 GHz, then update
> rules from one of the pdevs.
> 
> Also, when regulatory notification is received, update to all the
> underlying radios/ar so that it becomes aware of the change and as
> well us it updates its local regd with the new country rules. Later
> pick the appropriate pdev's regd(6 GHz if available) and apply to
> cfg80211.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


