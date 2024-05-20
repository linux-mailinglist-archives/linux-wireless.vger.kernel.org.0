Return-Path: <linux-wireless+bounces-7853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A638CA51E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 01:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C471C21340
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 23:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E009137C28;
	Mon, 20 May 2024 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fF3A4Qol"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6F3611A
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248336; cv=none; b=PClc+BB0tF2njCwiGQnlStJG3ioSoTI+slIoneRKkGNt7W20KOcpE9qKJBrFBhqlgmafAZqyUdQQxan9UwnA+Tbc+kjO/U26q/jDmOVtHfL2XxcljZxTaqwsFVJvHB0du+jDdhHaLSWYTQcumpQTOrqkf6fwbMTvgLsFedLC06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248336; c=relaxed/simple;
	bh=m7Ecxls+ho3ab4FPcb2O/eaQTnPMSiDoanZR/Ir0X98=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HivFuTlBSPm47KLsckX8LNNpyUqiIxSYt0FEXSN0aQdbOiBYplS/vm65zfAsp9WrZoxOZpRH1UcUii4MrGG/fyA4UVPZ5PV3EcEF26c+cYe6CSXau/eeULZP0s4LdZHMBesFR5Aw6esmC2UmyvJnbH6x23p7SQuxqywLk97Bzsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fF3A4Qol; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KBn7Xg026034;
	Mon, 20 May 2024 23:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UUxxfq9/ysoF4T/zCzom0D94X2iZGjGmhzqIIGldFvE=; b=fF
	3A4Qol0jbgxNe0bHPbny9PP5iSIIBwcB3ZA3lwI8PF5Xtg0srAj+aWgxfvWIr4ZH
	YFqIvvOcoF9UlcHh++fMSh8SSb/+OiAswa9aGnhQ6FFGtPK6BOA+mZmGWBTDJ1Nw
	LTH5uba3rrNSQ0EI0lxx3zjDDG1IxQF7GgvPvYvlckJwqeudJnHPWUDCwNr5h3Bo
	WjbL0FLihnQojvuVTBw2mjTZxAvTHxmMZP+IbyhJuDCoMHWOSc/aWrdJ6XVzIerd
	vR9UH7fooF0MuiMiSNoB1zClb9nvPis+tzGPRdh/ZHFsa3Ul8oQEfz0CDjoK3UyW
	gU+HXO42Aza2RIdUl7UQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n3td0k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 23:38:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44KNcmOw005437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 23:38:48 GMT
Received: from [10.110.17.44] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 16:38:48 -0700
Message-ID: <2efd9e1a-7471-474b-a2c4-893f3afcbded@quicinc.com>
Date: Mon, 20 May 2024 16:38:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath12k: fix invalid memory access while
 processing fragmented packets
Content-Language: en-US
To: P Praneesh <quic_ppranees@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240520070045.631029-1-quic_ppranees@quicinc.com>
 <20240520070045.631029-3-quic_ppranees@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240520070045.631029-3-quic_ppranees@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AaFdtoB8yZEv0F33kRN4HAA1Q3Pg5GHb
X-Proofpoint-ORIG-GUID: AaFdtoB8yZEv0F33kRN4HAA1Q3Pg5GHb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_13,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=739
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200188

On 5/20/2024 12:00 AM, P Praneesh wrote:
> The monitor ring and the reo reinject ring share the same ring mask index.
> When the driver receives an interrupt for the reo reinject ring, the
> monitor ring is also processed, leading to invalid memory access. Since
> monitor support is not yet enabled in ath12k, the ring mask for the monitor
> ring should be removed.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


