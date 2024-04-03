Return-Path: <linux-wireless+bounces-5848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C77D897801
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 20:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4471F23BA3
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 18:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C773153572;
	Wed,  3 Apr 2024 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cwlzUKfx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28776153580
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168251; cv=none; b=g9hH55tqU5elZtSJgnewoX/K3waHJSYP2klh2wK/w4N5b9lRTMMqbF18DlItMAw1JjyltrhFuZQaYtnodz+4Hx8y4rj7WZkLkXgLceXwxrSYe6J13RlM1Fh7IEGJG2rHFlLHmnh2b+pFnE7MkOy0bgN1gwRGIRLFSsCbZCrDJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168251; c=relaxed/simple;
	bh=WD8E4cdP6rKMf3ltgodFCTj3l//9aZmEkA9aUbXOFAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Iy650HIwcyBH9oGtl1faHZGApbw5EBu3ajtq8XgkeOvLRJ6LvaQgyVvyUz6rliPOdZwwB4fnPgmBj7CWFUnUlrr40Mbn8fy3E53jJiXULJ34FAdPIrFttE/k0twDbHb2fXZIl7Ser0XA8An4EYfRxF8SI7upBlkOrjLYPlF+hvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cwlzUKfx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433DlikU017556;
	Wed, 3 Apr 2024 18:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HczcMKXjz1miRBFdxB1P5IIxhUr8+4YJ5V0KLXGsMrM=; b=cw
	lzUKfxX6V9Vr5ZrCFKH+nbcELGH832zvDQFJ7IiOyTAxxvfG+VF1MaHPpsQgK19J
	VFQxKHJM1d+WwwNsOTw4U59zKZLL+wIMFtsU1uY2A1sb22GY8e7CZ6GuOLrQ2YEd
	yu3xVqYFh+OUciZPZh/ASPv/eyfyvvph7u/rHHclFqDjvfGirBZpMyPNV2xksrzQ
	mgLuR6RNty8nUNwOQAUTU5K9dVyWKGmWhMjvhn0qHH42yEwEDsrXP4nRp6VuDy1X
	u7qUmS2acZg4zJDxycfF55565F9kAkeDnEvnvm08mfCq+43O5WwYD+2wSeG9FVvc
	nHFe8msHDO8xlwbZm8NQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x92hb1n7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 18:17:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433IHR5g021096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 18:17:27 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 11:17:26 -0700
Message-ID: <4ff8db98-3389-4fe1-9cc1-0880d4d6cc22@quicinc.com>
Date: Wed, 3 Apr 2024 11:17:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] wifi: ath12k: skip sending vdev down for channel
 switch
Content-Language: en-US
To: Aloka Dixit <quic_alokad@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240402210538.7308-1-quic_alokad@quicinc.com>
 <20240402210538.7308-10-quic_alokad@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240402210538.7308-10-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rnUwSpDcf24kncxVC0yOVoBKXIcVYjQF
X-Proofpoint-ORIG-GUID: rnUwSpDcf24kncxVC0yOVoBKXIcVYjQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_19,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=663 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030122

On 4/2/2024 2:05 PM, Aloka Dixit wrote:
> Remove the unnecessary WMI vdev down operation as firmware
> internally does so already as part of WMI vdev restart.
> Repeated vdev down results in a firmware crash during channel
> switch operation when multiple BSSID advertisements are enabled:
> ath12k_pci 0000:06:00.0: firmware crashed: MHI_CB_SYS_ERROR
> ath12k_pci 0000:06:00.0: failed to send WMI_VDEV_SET_PARAM_CMDID
> ath12k_pci 0000:06:00.0: failed to set vdev 5 HE MU mode: -108 param_value 7b
> ath12k_pci 0000:06:00.0: failed to set he mode vdev 5
> ath12k_pci 0000:06:00.0: failed to restart vdev 5: -108
> ath12k_pci 0000:06:00.0: failed to send WMI_VDEV_SET_PARAM_CMDID
> ath12k_pci 0000:06:00.0: failed to set vdev 4 HE MU mode: -108 param_value 7b
> ath12k_pci 0000:06:00.0: failed to set he mode vdev 4
> ath12k_pci 0000:06:00.0: failed to restart vdev 4: -108
> ath12k_pci 0000:06:00.0: failed to send WMI_VDEV_SET_PARAM_CMDID
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



