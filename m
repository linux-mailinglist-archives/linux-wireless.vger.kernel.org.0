Return-Path: <linux-wireless+bounces-14429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66B9AD251
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 19:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2101C21720
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 17:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4D11ADFF5;
	Wed, 23 Oct 2024 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VXRKo2UP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A396B1C3030
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703681; cv=none; b=g9cHiQ745/MrK6A9ULQrNKsVjJyXX+okl3HFl9o45shav2al733obcYQ+qHaAzmpIosSXAhgLcXQVAsnPur0VEq1OcXelW8EGU2yUKQE6TxmzfI9cpV5xk1jS4uXTdOZfPPoqbIJmqqV/MQ1Co4q8v/2qeW1VTEkL10M7MkOhX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703681; c=relaxed/simple;
	bh=Knp3gvk471hKFAbjXJQoNWtWJNwiWTahXqr9XdHi5XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S2hpwLfMCrqhcrX4pjxhpaKWU6hYMSrgvcirp8/HyC4BgPS/umuGvm25301sC1h7g5jTCxa/wMVdDN+BmsmKxyRN1cPIroo9+07l9H27O98M9ycjFwS1ZgUClHewmMz9fUExW5Z4iqEDSqZfaIfuZLK7FiN+Xc5PBmRY7Hyaq/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VXRKo2UP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9Xgcm023430;
	Wed, 23 Oct 2024 17:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b50UQFeHeo+8nfQnP6vmevfiqE/cxmki1RMuFJHmpMk=; b=VXRKo2UPUemox/u4
	GONQdKqjjwyD8oC0el2rKEK+3OvWgoHmS/x5HRIQmKtWdrVtmwt1z1+b2vKPnBCE
	Afj0cTIxgwi/w447zaOVSvqBRMZYzY1aZHXT+fBVhku+tqu/LYb2j9nn6R84Gvwe
	rMBjL4GKnX+RMVcfYo9BAl8g2+bs3SkWTk8P70ND69yS2Eiq6EB85sULiGbNYb4i
	kaPMGPC7sey5/yGl0dGZIv8KTlKGYo5uj/Q7jrBFkB+PV0fwz7JuLlKc6Piotk2l
	ERtqIlOh6mIRntKllpKgL6kwTMNFLV6+aJDwDGjTumwFkZPop+atvTxO2xE5weju
	35sMDQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3uk09s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:14:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NHEZ9g031840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:14:35 GMT
Received: from [10.48.242.6] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 10:14:35 -0700
Message-ID: <d5fffc97-2603-4614-95cd-333c86435534@quicinc.com>
Date: Wed, 23 Oct 2024 10:14:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: convert tasklet to BH workqueue for CE
 interrupts
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241022072406.3231450-1-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241022072406.3231450-1-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: myfcHx0R0gVULm6zUE2y67Abqzfn9oJr
X-Proofpoint-ORIG-GUID: myfcHx0R0gVULm6zUE2y67Abqzfn9oJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=906
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230108

On 10/22/2024 12:24 AM, Raj Kumar Bhagat wrote:
> Currently in Ath12k, tasklet is used to handle the BH context of CE
> interrupts. However the tasklet is marked deprecated and has some
> design flaws. To replace tasklets, BH workqueue support has been
> added. BH workqueue behaves similarly to regular workqueues except
> that the queued work items are executed in the BH context.
> 
> Hence, convert the tasklet to BH workqueue for handling CE interrupts
> in the BH context.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

(Not sure how to stress-test this, but it does survive multiple rmmod/insmod
with a Youtube video stream running)


