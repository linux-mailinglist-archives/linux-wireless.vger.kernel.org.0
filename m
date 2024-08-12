Return-Path: <linux-wireless+bounces-11322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB42594F78B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 21:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED86C1C2213D
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 19:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD1418E05A;
	Mon, 12 Aug 2024 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jv9fxs8c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854BC17A5B5
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491492; cv=none; b=ejuT25pqKnxjTLN/Rwbxjt5+TjADHAn4zuHpFfpxT0PcjeVllz9c4NAfxGp1eO53+thFVAg6yM5lEdai+NwcUPVsM+4Ik3IQB8Px44QeYQ0JLFBrmbmqiPvzXwS6xmS6/7Bl6+4ael1KGfNXkCBUBWGomYghvuiIgXbY4rsMM2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491492; c=relaxed/simple;
	bh=s2V2eRR0Whoo+RJ2FqR9EXBf8QkBNIdb56/pFdfMtbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OpB1ilIyWq059PSn3jfFATxmLOBWZT2Yz5vZM39E1b5tHpTR3NBWv1W5uE+bML4dmYqsnwd2a8FY7jsbbxONqsaMnInuKYsGXVDrgmto6xvyoVGI7XoJcRx/XrtLptwKi3buXrWGl0eli7Ok2cQwgdxlL16g9jtXqR0n/FMvJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jv9fxs8c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CDSZOb016311;
	Mon, 12 Aug 2024 19:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A5nBAbcGfghxcsXTDvSiXeAzu5bQbVOsO9caI3QSLlE=; b=jv9fxs8clv5r/mVA
	526QE4Ov8EJC4tZOI0baE5gVq0PvMYG/6rKfG6WgjgZHjj5uLTWpj1xj6fR+Woym
	b2v0SLXhFCn+rYdjQaECdDS+gW2gaejD7mCxkXsVJjR+E0LBcIA/kIziNoCUA9zZ
	nf9UaOjuBhdoZIGcEsIc7QvsWfx5eK0rV7Ybszg1OaPGG9y/JsIILpSYoj2o2yPi
	vkzL6Sczhdi2jSYGK0QEuOYyaF6xf3pYVWNUeP4fz9mYKt6tc/YCuaExRzFdmqH7
	hINyAAG/+QSGYz2QP8ggI36qBy/V20Pgo909BosFROQ9MaGPVsx5rGAgnpvrQrST
	8Py+wA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1chn6r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 19:38:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47CJc6Jf019237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 19:38:06 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 12 Aug
 2024 12:38:05 -0700
Message-ID: <c8e30334-39ec-474e-8705-06b66803b916@quicinc.com>
Date: Mon, 12 Aug 2024 12:38:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] wifi: ath11k: Add firmware coredump collection
 support
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240731014104.798028-1-quic_miaoqing@quicinc.com>
 <20240731014104.798028-2-quic_miaoqing@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240731014104.798028-2-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IUkjTf9Xfnv-PNXO2SVTtUYXa2H6O50K
X-Proofpoint-ORIG-GUID: IUkjTf9Xfnv-PNXO2SVTtUYXa2H6O50K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=755 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408120145

On 7/30/2024 6:41 PM, Miaoqing Pan wrote:
> In case of firmware assert snapshot of firmware memory is essential for
> debugging. Add firmware coredump collection support for PCI bus.
> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
> format and also pack various memory shared during QMI phase in separate
> TLVs.  Add necessary header and share the dumps to user space using dev
> coredump framework. Coredump collection is disabled by default and can

should this say the Coredump collection is controlled by CONFIG_DEV_COREDUMP?
we removed support for the separate CONFIG_ATH11K_COREDUMP

> be enabled using menuconfig. Dump collected for a radio is 55 MB
> approximately.
> 
> The changeset is mostly copied from:
> https://lore.kernel.org/all/20240325183414.4016663-1-quic_ssreeela@quicinc.com/.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


