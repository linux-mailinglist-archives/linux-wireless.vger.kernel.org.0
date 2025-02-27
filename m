Return-Path: <linux-wireless+bounces-19525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19380A47560
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 06:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB06E16F1EF
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 05:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6951E8325;
	Thu, 27 Feb 2025 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gOMxxTCb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EFA215183
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635298; cv=none; b=p4QMoAGOgYHLHYfsaNX9bEeY5yJgEPkH9hR32md/zaAEUDWGJB9iBQIT75r79Heok8jgNi1J7Mb2RcQDvhckAfJGL1R+vroz2JOoBt/9RSWx00DFHKRNwD3MAx06oI5wBJwbILp7jDG/PKON4DrS4BYwksoGfzz8V8av0Tf9fUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635298; c=relaxed/simple;
	bh=jjM7YKAK4a8AwS4pEEPOZpW62nuOMiYvp/OijiMqHGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jpc9wZDN7+JOU6B4BmUEahe37BEcBhTSjyyEPKftkbcR2j19eHkFhnsRYdcCs0XdllM6XOPnZdbxCFjoh5Ur5hvfLUU/3oyK1f53sEMObHJN76i3bDmrPYr+AEJhqBwMbtTOM6fY2czN6ZdHO/7qMdA7Jpwf2rrnQh38/qwvewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gOMxxTCb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1wXKA001046;
	Thu, 27 Feb 2025 05:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Gl6vEk1HZ/abrV2HnFPrSMQi+hXtWln8uy/4lCmXXI=; b=gOMxxTCbOVh+xGrV
	EDt6T5meQyr1IBRo/GM+N9F4OIW90oNu2jA3zKRQld1hpU6md6qiJOKlMrjYbqz5
	DliS2+6D4ZA2db/uqUv3raoiVEK5Y81Rn+y9FQjSkusmbQsMe7ilRWT6VB+dJ2EE
	xoHgmlEo+9mbWG/YHe0nvFhYdRiesvHDyNnthZudAlDSgeoK69ZqXg6aSeBG06eB
	I+pZ5rCcCN8fbjpQkQtKFDYUC+p0GlHKnytEVvFbjHkWgINCmewzB9o9jWoXmQCx
	93LAdrQG+2N9xEoPCurGdcMIsUdZ74jjJAMJl6BeqerEPLTNBVrPjqUOCdC120nM
	R8oOgg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4523kcach2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 05:48:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51R5mDSd011781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 05:48:13 GMT
Received: from [10.216.32.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Feb
 2025 21:48:12 -0800
Message-ID: <8ac80911-a356-6a51-15ab-3b5500b30862@quicinc.com>
Date: Thu, 27 Feb 2025 11:18:08 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 5/5] wifi: ath12k: pass BSSID index as input for EMA
Content-Language: en-US
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20250210182718.408891-1-aloka.dixit@oss.qualcomm.com>
 <20250210182718.408891-6-aloka.dixit@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250210182718.408891-6-aloka.dixit@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JexNvuvpOD0AFX1xkWJRbiTJECp5wXXt
X-Proofpoint-ORIG-GUID: JexNvuvpOD0AFX1xkWJRbiTJECp5wXXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 spamscore=0 mlxlogscore=722
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270043



On 2/10/2025 11:57 PM, Aloka Dixit wrote:
> Function ath12k_mac_setup_bcn_tmpl_ema() retrieves 'bss_conf'
> only to get BSSID index which is an overhead because the
> caller ath12k_mac_setup_bcn_tmpl() has already stored this
> locally. Pass the index as an input instead.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

