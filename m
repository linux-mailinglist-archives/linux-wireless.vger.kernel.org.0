Return-Path: <linux-wireless+bounces-17730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC219A16605
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 05:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904121889292
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 04:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECFF1474A7;
	Mon, 20 Jan 2025 04:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JQYV9Ehk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F33533997
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 04:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737346171; cv=none; b=EKLvpIVEVLF6AdbM0QGiM5mu4LrmdaG7P2qFJX69U2/nu/6rSa2a1Ol/XNuNEYVn+u8LUZDC9vsOpMkKqkuSTDmSS3pAnOI+G3IEE7hJX2VxcaFRsRfUmUwgk3MGEwPOwXKaNKis7qNZSGdQucoYoBHVJoMeGrNS/6ub7s01ZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737346171; c=relaxed/simple;
	bh=ZnYDMWvsm29tae1gJi/m17qtBOD/utc67g2Q2eDHLEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FgZvqd8VHM63/wVJ/HrW8nzYWCU1dmwV7OU22PA2RMm775RXajzmFCB69zR/SkNTPLnoASgEO6ZsXWG0sUH9Wn1MeMSCHBuGjYiBASMFsqYyKuMhyzrV3GCwBAhjM2OjynL0efW7FcmgiUygwHWSZZziQwrTqSqNhvq7yJifxOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JQYV9Ehk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50JMt2LF007222;
	Mon, 20 Jan 2025 04:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PSOgj5cwjNHbnMBRRbTxTJDl8EcqNL8S/4PwfM6Drqs=; b=JQYV9EhkQsU7EWxZ
	96Cjj/pKK3/oqO7Pz4qCh3j4LxXHQ5NwYL6Mt86MMQg9l0b0pMASFJ2XgJduzVmm
	Zen5OLEq+QWErFOvqTJ7RodqpU4yaxla60f3AzYbrjkIK1vec94+Q55PKtf6rROv
	q1+SuGnXVZEydSq/sYYOxsKxSHa3QRpcmHlBRNoiqSMPmZybE63R4MAm3ZaKFJzU
	tdBve9AF1gY4cfYksoCJL5OInisVZe8EGWHBey5EYUDnxet0RqhsCTbnMMwlEtAj
	k1KN/q0K2JSaN5LE2gPxxwykJJuYmK9P6OyeDL30N5Gh+VNG+EFq/CylVf2l7zrG
	Se2lsA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44852d2xvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 04:09:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50K49RII005184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 04:09:27 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 19 Jan
 2025 20:09:26 -0800
Message-ID: <469dde6c-3eea-4117-84bd-93fe63d50c8c@quicinc.com>
Date: Mon, 20 Jan 2025 09:39:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/4] wifi: ath12k: add factory test mode support
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250119083657.1937557-1-quic_aarasahu@quicinc.com>
 <20250119083657.1937557-4-quic_aarasahu@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250119083657.1937557-4-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9s8dHI69i0GQhMrdjYIHeI10ltX4KBOc
X-Proofpoint-GUID: 9s8dHI69i0GQhMrdjYIHeI10ltX4KBOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_01,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200030

On 1/19/25 14:06, Aaradhana Sahu wrote:
> Add support to process factory test mode commands(FTM) for calibration.
> By default firmware start with MISSION mode and to process the FTM commands
> firmware needs to be restarted in FTM mode using module parameter ftm_mode.
> The pre-request is all the radios should be down before starting the test.
> 
> All ath12k test mode interface related commands specified in enum
> ath_tm_cmd.
> 
> When start command ATH_TM_CMD_TESTMODE_START is received, ar state
> is set to test Mode and FTM daemon sends test mode command to wifi
> driver via cfg80211. Wifi driver sends these command to firmware as
> wmi events. If it is segmented commands it will be broken down into
> multiple segments and encoded with TLV header else it is sent to
> firmware as it is.
> 
> Firmware response via UTF events, wifi driver creates skb and send
> to cfg80211, cfg80211 sends firmware response to FTM daemon via
> netlink message.
> 
> Command to boot in ftm mode
> insmod ath12k ftm_mode=1
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu<quic_aarasahu@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>


-- 
Aditya

