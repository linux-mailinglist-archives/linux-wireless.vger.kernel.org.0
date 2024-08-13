Return-Path: <linux-wireless+bounces-11375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6550950CF4
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 21:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A4F1F25642
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 19:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86CC1A4F3B;
	Tue, 13 Aug 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gMAPpRwn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7241A4F13
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576342; cv=none; b=hI/XoG4bugnLjc+GYtaHAsep940FNmHxGtSFKIMBb7s2V8ab7f9rhAz/LwyqcENzidjyTGqyk+HXEeKylC8QenZ5B+h9ZUdOfrcgIA8yy4H/7MbUIo8M15ACvJPPb2hxw8T0CCu1QEe8pdBtQsgcnfHg34lyuUygcCApdENCnbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576342; c=relaxed/simple;
	bh=T0E/+Z0sATpq1yYb1guwXHEs2qNl1CK6tXA4/FSRjKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gfAMsCrr2hre07mo4july92A2IE4OnWEBDobWWc2XNRbKP+N0+PN0HEEirUQtasUmPeoWpURYNeDK0DWo1jeYrmVoCpDwxOF4VJXZUa5vpUshrc0dYRXd3yu80Rjn+B/WGzGsRDkE4V6wmHHtrUSALfJdTvcq2qgJqRqiqZy2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gMAPpRwn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DC8nAb005666;
	Tue, 13 Aug 2024 19:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jx3mnCJA+AL2fn/1qC4LOQ88tS8X3R+WfwGY5fOq5co=; b=gMAPpRwn1i6GjkbM
	jDDWpxC8uUmc2Gu+mwNhwlOwArsu7/gJmEQqoHQ3P7Gq0Ey0A58uC8w5Qo+teyzb
	bcQ2uKA9LyI5nv0X8ls10hagi+61yQz3REjs/REXP7tAkxGdiykijMmL5fEophGV
	kxQEEmcmroUYGQA9iq5A3ejrcMS92detECvPDWWzQ3XRrJ69PEhCwk9CJWjgN26s
	v/FxnYroPXVvfZbczBVHPKrWNunPccSOq8iywzFBh7fK8xOL3lHl+mAwz0yMKza5
	YiBUUyh+HPV75/YVEGf2nxFB+AgfgtqhNnkzMjex347HgP7fkvRvgBO94OjHjBxx
	Jhc9Dg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x18y0ya9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 19:12:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DJCD8e028538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 19:12:14 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 12:12:13 -0700
Message-ID: <4fc3d4a1-7dbe-412b-a6bc-72d0a5d13196@quicinc.com>
Date: Tue, 13 Aug 2024 12:12:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] wifi: ath11k: Add firmware coredump collection
 support
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240813013028.2708111-1-quic_miaoqing@quicinc.com>
 <20240813013028.2708111-2-quic_miaoqing@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240813013028.2708111-2-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gt2f_uhUvxjoFbzFBp7NpjG5qSDOlCB1
X-Proofpoint-ORIG-GUID: gt2f_uhUvxjoFbzFBp7NpjG5qSDOlCB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_10,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=736
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130139

On 8/12/2024 6:30 PM, Miaoqing Pan wrote:
> In case of firmware assert snapshot of firmware memory is essential for
> debugging. Add firmware coredump collection support for PCI bus.
> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
> format and also pack various memory shared during QMI phase in separate
> TLVs.  Add necessary header and share the dumps to user space using dev
> coredump framework. Coredump collection is controlled by
> CONFIG_DEV_COREDUMP. Dump collected for a radio is 55 MB approximately.
> 
> The changeset is mostly copied from:
> https://lore.kernel.org/all/20240325183414.4016663-1-quic_ssreeela@quicinc.com/.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Kalle, are you able to test this? I don't currently have a HSP setup

