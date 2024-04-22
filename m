Return-Path: <linux-wireless+bounces-6684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7788AD387
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 19:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09CF1C2109F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 17:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48767153BED;
	Mon, 22 Apr 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eNYI+WYS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4B154437
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808317; cv=none; b=m4yHWcZ3htEjtbA4954iyM75E7I59U0kJTwGbgEhJIyn0ezyO79GUlxBcE0tBKl2L8n7X3xaAX71zpRri87etN6Y3xpe9C0d81yPjQymh5HXGFxu8U7d+Y7nvfVFCjH6mJUJvmW3uICFRIzijr/l528vHSW6Pw+kFf2eF8M9fUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808317; c=relaxed/simple;
	bh=vP1WhAtlgg4+rEPZI1JVYBHUwDZQ8s/08YN/jBT+b18=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BGsSjrc4lVb60V/ulOsn+zSG07HOJ8/hiGcscfFm6oMM818lI6hAJRIERMXu6sIZ3phIoSr6iFehMM2hTrkqApCbN232ddRbL8SGH3azocUXih31TQfEUk/yJc1XYpQFsobLyhpuaKa21ebtUz9pBZYBYeN4ex7hKZrawABg8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eNYI+WYS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MBjRhT009748;
	Mon, 22 Apr 2024 17:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=W4RgUdZEDJyofdEpQ0QmVWlr1oC0V22k8KmwizUyYRI=; b=eN
	YI+WYS/0+Xu+qE+8dPBksEnuPfZrcgbUuXTth8tAFwZ7l/vinZUOD/LXlB5oRtyu
	TQZysFoVlaMdW82Z1pZZxZZif5Et4FGXFbbZ9qD3Im/oGgQi34uhchf9N1I3plrC
	Va6kRn+ZrScKF1CA47mNPmV+zPyplgndczFRdjZrBdC7TN+mhX5I0x+lUocNUbQV
	KekTYycSo+cy4pVuV3BLtuQ+8XdcYpH/RFYqKZc976aoMoYMuPjLFgc5yo6Gdv0e
	FtSMrxEiR9WWHI5bA/h7pkj2t3f3gLsTuwiDJ7W8+XNyBRiDOf/wV+70EEFxyEc2
	600qnTwmn7xCf1/66tWQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnne298pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:51:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MHppsT024330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:51:51 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 10:51:51 -0700
Message-ID: <cccbe3c3-6db3-43eb-9eca-fc16989a9c00@quicinc.com>
Date: Mon, 22 Apr 2024 10:51:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] wifi: ath12k: fix warning on DMA ring capabilities
 event
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <20240412060620.27519-5-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240412060620.27519-5-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z0Rto2CW--1e6GjoAJ8Q7GCu1eOjvHpS
X-Proofpoint-ORIG-GUID: z0Rto2CW--1e6GjoAJ8Q7GCu1eOjvHpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=444 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220075

On 4/11/2024 11:06 PM, Baochen Qiang wrote:
> We are seeing below warning in both reset and suspend/resume scenarios:
> 
> [ 4153.776040] ath12k_pci 0000:04:00.0: Already processed, so ignoring dma ring caps
> 
> This is because ab->num_db_cap is not cleared in
> ath12k_wmi_free_dbring_caps(), so clear it to avoid such
> warnings.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


