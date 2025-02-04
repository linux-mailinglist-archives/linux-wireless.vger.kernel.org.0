Return-Path: <linux-wireless+bounces-18396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6C4A26CBC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 08:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9213A859D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0BB2063C5;
	Tue,  4 Feb 2025 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E+HcT9pY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBB82063EB
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654646; cv=none; b=XS8Y2iV2+NMrBHwRJOlJ0QzLqi5NROiAkVNNNFrPmJTFDrVcScZCaiZTKEd9GNHcCyrbh8mExtQkHa1BD3j4rT6plJKGOk/2iKeDcuQ6pficcA3sgHp6OgF7Wdagj7GfWC+HfxU8GxfuV9wdmglQ1z/8EMBX/odUQPide14rZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654646; c=relaxed/simple;
	bh=ka2IBi9a2GpSPzEM/1uNqgSv0jNcPEASZwzqtq2/bDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fkYVVvZRizzZkTeJAaoACWYU6VpS3YV8DXZnDQq3MECPfouZI/aqIAafOJat6qVknP8VwO3wGVuRF19mxI9cEXg7E0itnu+MhtVpr4x+o8PJgOheVwbdIei2JQjMEDRHtmDJbTLNSvcRPvuY3uUf1wmH471E0HsErwb9mFT3PR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E+HcT9pY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513HfVLT017320;
	Tue, 4 Feb 2025 07:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W3bEh5bn7zCkl3Lw9mlSOMCtzxHPotvQvRbPEmcgKss=; b=E+HcT9pYOB7KI9Wm
	PrgDSy+NFeHoCOccofvomp+XQFfPJHMDPlwRSQD/gPl1E/EWxxd1aTBnSkUuiiIh
	l11RNI/ka5Pe9JG+ay/kuyseDS1yitTZNvxZNX7hVDTO7NvyBV5yexpNOqDtFlVV
	ZICYU4IWcKvsoE0BTLURipSRHN4l3tjAS9XnVaBUOby+fK4nzlsnVj7TG7oPYQC/
	/ViM0ckQQTRN1utvmLA9GZ08Mm0c1NFuueziw8CFm1m0w84c/vKZ05T+5pwlIGdf
	y+stuHguTeTprNVmy8QVkKE9KGFL6xAC3gvQnX4RLCzpNYM8InVRkIGOA1hAZmGK
	MFjKHQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k2e1hjsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 07:37:20 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5147bJq4016580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 07:37:19 GMT
Received: from [10.152.202.85] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Feb 2025
 23:37:17 -0800
Message-ID: <63bd7dd0-4dd6-e9c1-9aff-c81df86bda4d@quicinc.com>
Date: Tue, 4 Feb 2025 13:07:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] wifi: ath12k: move firmware stats out of debugfs
Content-Language: en-US
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
References: <20250131193726.3568086-1-rameshkumar.sundaram@oss.qualcomm.com>
 <20250131193726.3568086-2-rameshkumar.sundaram@oss.qualcomm.com>
From: Mahendran P <quic_mahep@quicinc.com>
In-Reply-To: <20250131193726.3568086-2-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hSiu2yLRXIhQ-eXW_ExAWskT_urGyjUw
X-Proofpoint-ORIG-GUID: hSiu2yLRXIhQ-eXW_ExAWskT_urGyjUw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040060

On 2/1/2025 1:07 AM, Rameshkumar Sundaram wrote:
> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> 
> Currently, firmware stats, comprising pdev, vdev and beacon stats are
> part of debugfs. In firmware pdev stats, firmware reports the final
> Tx power used to transmit each packet. If driver wants to know the
> final Tx power being used at firmware level, it can leverage from
> firmware pdev stats.
> 
> Move firmware stats out of debugfs context in order to leverage
> the final Tx power reported in it even when debugfs is disabled.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Reviewed-by: Mahendran P <quic_mahep@quicinc.com>




