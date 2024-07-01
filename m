Return-Path: <linux-wireless+bounces-9803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85E091EB6D
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 01:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957092823DD
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 23:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB41F172BBC;
	Mon,  1 Jul 2024 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WITem647"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C651172BA6
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877317; cv=none; b=cjvVqSVNQNWmPvrUuEf6JDWFvSevP5sRjuOyzjiRba8vE2ih0xer1sOO98aZaGBDWaZRyYMs01MtsIKmGxwFaO4YohkaExU8KL8seGME0IlFoKVq4SzNRkWa91+Ko228+SjMi0a3H3hvacoMD7hfcc/2w1Kaosm0KK5zfCL1PXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877317; c=relaxed/simple;
	bh=JBJReagojtomJmJ+zvzkUJJq1tA+Y+t1NmrGuwUac/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I3ZZ7NePNbN+GEmn0g5oBRI0ac5DZB39mMlWDMsKhJ3j+ufQuXtdhgNQ0v6IClQP0CcdjOzU9JnVeubdegGlG1Kct+qdYL8TZ0A9OKxSA5n6DFn/M9YmbkSeRTZ8y51AWQ5ngAWRPNvtU8OwhnyMzrmcz8EzP0VLVS8IRJaEcgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WITem647; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461BbmK8010891;
	Mon, 1 Jul 2024 23:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lZOSybswH8DYxlG3T1ZI5UoyHgjKSha7erN55ScJYUI=; b=WITem647JXQIW5eQ
	AG1yYAdWaLZwbN42JHDdz6uAkF3uKo1NZdkTc15iPr+LHAFJqzpD1MNHk/8Q+CXn
	NIbtVDnfAwE+YgxO6T8ynv0Hx9c0pHuO9FyZCBCsA1adE4Mev1L7ZnfuesHqJSv4
	SvLmrM4A94IJCmK3anH5V7JqrHvobVUzoWet3PkQmzzKQtTF4hgM4yV97PjsSHw5
	wUuYW1syBGu4TluZNL89dE6+/AdV0QpCiRY+SUYqeGRimgbgAGtVu/TZEd2FjKU4
	elkSNbHgcgvPfGo0EBFOyIyBLbestq6j2wMrT/1YSJdqAWdl8g1lJNLdHChnsjqF
	rlR3Eg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 403kj8tr0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:41:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461Nfq0x017635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 23:41:52 GMT
Received: from [10.48.245.148] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 16:41:52 -0700
Message-ID: <c0fdb440-17c6-4e6b-ba9f-87f13f31e4ed@quicinc.com>
Date: Mon, 1 Jul 2024 16:41:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/8] wifi: ath12k: Introduce QMI firmware ready flag
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240628095139.292952-1-quic_hprem@quicinc.com>
 <20240628095139.292952-5-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240628095139.292952-5-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rN_SMDZ7bSp38_S4EG-S8IQ7jGJ0Qf4y
X-Proofpoint-ORIG-GUID: rN_SMDZ7bSp38_S4EG-S8IQ7jGJ0Qf4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=791 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010176

On 6/28/2024 2:51 AM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> When hardware device group abstraction is introduced, QMI firmware
> ready event of different devices in a group can be received simultaneously.
> 
> To indicate firmware ready event is completed for a particular device in a
> group set a flag (ATH12K_FLAG_QMI_FW_READY_COMPLETE). This would be
> helpful when hardware recovery is introduced for hardware device group
> abstraction.
> 
> Add changes to set/unset ATH12K_FLAG_QMI_FW_READY_COMPLETE flag for a
> device.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



