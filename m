Return-Path: <linux-wireless+bounces-7072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225AB8B80A1
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 21:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F45B22E5C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 19:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280777710B;
	Tue, 30 Apr 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T0WE37mp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD68199E95
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505652; cv=none; b=u/vmuISwNyfrjmM+cu1hcpECooQHPDEfbqdztOcD5jpIhs+SbpWGUjTSvBDBE3KqK0B4TA/TOfoa7Eg9Mv8vAhN8Fh+4FcmXwpKuka54eLV8VoMROpK6W+g6Z0shRIyoEMnxWSIzcqGUZihzFiVlDq2VssbXKMxrrDTFdHUzXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505652; c=relaxed/simple;
	bh=6rI/hOc6IcIoHZWjjgvb1m/luzBWnjp9rgv6BC0GbKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ADrvfzZcW1mbTQEw/T1pwbzGX6BZZZEspPtDqgtNFbh2h9tq3YdEAmDdHKxHjtzPsdrVjtUEJdHFWYSXoE5OCsw6NN/7BQzckFYvGZX1YRIcq14VAQvs8GrI423NkizOByrTgb2B/FSQ8xez0Emc1b4uMurZKuvD60Nfbqc12+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T0WE37mp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UJVQPA026466;
	Tue, 30 Apr 2024 19:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kE1zD4Gz6EOj9TdipkDylMfoWWKFo2EriB+fewRzK14=; b=T0
	WE37mpYYHjTc9COisc+68IwPXi/FJcTKKRueaiXEfrUFBqYgBDufFr4YKC6qljqN
	v+jNyBKYP/ZwmpJRILpJuDUOBGcJeD6i4KZxHFjV5+8Uf40l+WKeWHg/J7KhljNq
	JzoqDwJ/0NMpKHfdfFODmWhB+zrfk0IVaqNjxQu7JGgy7gZPFGagOP2llTSpC3WM
	BwRbbPkhLgUkjVJzVx+gPsOd4EeTfXMQGi2kv6CHI8CBrozXndVbGAe6KTbHJbeZ
	9+0UY6MO6IJX0B0WcTzVtntl9dmbfgQ8qHaOy6QMfdIW+VvTrHntilWtf7iAv9fO
	9Gh5p/yddXMXFs9zdQyg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xthgvv0tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 19:34:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UJY1el030899
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 19:34:01 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 12:34:01 -0700
Message-ID: <af25ee19-4ec8-4e31-b2d7-b8f1974894da@quicinc.com>
Date: Tue, 30 Apr 2024 12:34:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 1/3] wifi: ath12k: fix calling correct function for rx
 monitor mode
Content-Language: en-US
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240430091414.2486196-1-quic_tamizhr@quicinc.com>
 <20240430091414.2486196-2-quic_tamizhr@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240430091414.2486196-2-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qn9THTP_JH383syvEpcFoQwZNTjBiVZC
X-Proofpoint-GUID: qn9THTP_JH383syvEpcFoQwZNTjBiVZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=762 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300140

On 4/30/2024 2:14 AM, Tamizh Chelvam Raja wrote:
> Currently in ath12k_dp_tx_htt_monitor_mode_ring_config()
> ath12k_dp_tx_htt_tx_monitor_mode_ring_config() function wrongly called twice.
> Fix that by calling ath12k_dp_tx_htt_rx_monitor_mode_ring_config().
> 
> Currently monitor mode is disabled in driver so the change is compile
> tested and boot sequence verified.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

(although very confusing that there is preexisting RX functionality in dp_tx.c)

