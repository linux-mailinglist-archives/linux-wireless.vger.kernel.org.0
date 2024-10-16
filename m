Return-Path: <linux-wireless+bounces-14096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27319A0DE5
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 17:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97A91F23522
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 15:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299F120E003;
	Wed, 16 Oct 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ISEFQ+BG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40D206066
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091883; cv=none; b=adKLvJNpDjxrPxjtLPH7dSm8qHT4D69u2LGhLMbYY+PVx6OI2Z2Ihg4KwIO3kxliaoZGQq5k1US9s9uKvNEtjEo6rG+UOSuOUVFgxfG/hWXM/vtqp3zD/HuCN8RrfISALTcmuZYSc+JqNF+y4Ahu9INBNhiaX9JUDMa2peogPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091883; c=relaxed/simple;
	bh=CGaMyqSzO4SUm4xa2ME5P8QKDt4rSpd/t2qxml6IwR0=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=OlM/Suxj3YCuZ623PRq+gNOILVJhZObN3EM7tE8fSv8erp3THltwIMWpDIluqSJJ07/ovbAaLpwT9NzQqm+RmTUn16x0zPAKlsoLgz5GtgDTplOrby3HcvCk2JdJXMqId08WW50sIv5c2lvBqrIin3Vm6qzSm7krHBZOkEU035Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ISEFQ+BG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GA0ar4012488;
	Wed, 16 Oct 2024 15:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8Xe7EAOMFkg+dIERCK9OdLAf+zsW8AEnoI2Onp2fW1Y=; b=ISEFQ+BGuilI5bHk
	4GMcSg/Z9dD/O0FHYIY/yR4qf86T42S9+Rs4ToRL08+bO3ILW1IT1L/2H7Z5iN0U
	QoZ7l9n60m7YhDA8FsbKIVBGWd+7RQMCix+WrzE7+tJi3QLphyuq/YBroaGsQxXk
	sGEP3dXaow1oR5Yf8/Nu6VA8x2CnEjtw1t7f/7WRPJ62i6YApFYlFTDAJz7jqgCg
	OizLcmYXgb27avuGI0vHlPa/12xi1FkfGYEFY+oK1NbVQOlJ9BMwtM6HwJmyc61B
	eTDInDZAp5Qj88Rpcijqioli0q5Efkt4ZTZ/kbrKHQbflFpRY8r0OJYgmmVuvoZs
	XHZm+Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42abbxs285-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:17:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GFHvd5028667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:17:57 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 08:17:56 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20240717085604.4131642-1-quic_ssreeela@quicinc.com>
References: <20240717085604.4131642-1-quic_ssreeela@quicinc.com>
Subject: Re: [PATCH v5] wifi: ath12k: Add firmware coredump collection
 support
Message-ID: <172909187678.412681.572371942538670959.b4-ty@quicinc.com>
Date: Wed, 16 Oct 2024 08:17:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AxSkbiwMCzzLSiRk7lzYLtPco3n6cErx
X-Proofpoint-GUID: AxSkbiwMCzzLSiRk7lzYLtPco3n6cErx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=453 bulkscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160095


On Wed, 17 Jul 2024 14:26:04 +0530, Sowmiya Sree Elavalagan wrote:
> In case of firmware assert snapshot of firmware memory is essential for
> debugging. Add firmware coredump collection support for PCI bus.
> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
> format and also pack various memory shared during QMI phase in separate
> TLVs.  Add necessary header and share the dumps to user space using dev
> coredump framework. Coredump collection is disabled by default and can
> be enabled using menuconfig. Dump collected for a radio is 55 MB
> approximately.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Add firmware coredump collection support
      commit: a9b46dd2e483bf99fa09e6aeea7701960abaa902

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


