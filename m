Return-Path: <linux-wireless+bounces-11442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE989521D5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 20:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07A11C2201A
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 18:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5171BD017;
	Wed, 14 Aug 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pNvwOL8s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2691B32A6
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723659129; cv=none; b=eWHIVKqN3Hwhz3six6bZU9rsvmYBG+kiLh2eYYN38/zVppbxBufpBM+guTcgDxQ7Wk2udiNdH7x+Yh+/URIQfSxO/fSFcWS4yyTLbVPd6o8Ynp0k9lxfORkwWocgF2eInv+JSPyTYclu0wkhWsWEQdRNZuzLOiTGqJrd72dZKEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723659129; c=relaxed/simple;
	bh=+ZNfUBj0p+Kk8eG/OzL7QV8Ud2VTAoByTDg/yhxV2Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uPQV5V/3Z3Z1+lvqJ+EonyDyyIIutHBpJIorZvNX+JJVLR6UOH8tj6UADICNUIIeA+8M89QGEuPmB7bTnABrV999hm5NbrfzEi7LhsMf52sAVcdzIICrYFQ9fYjIbxiCN6FScXWUTvkgcZfQ40z+zU6S0F/ho1JkyTJrpvewdqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pNvwOL8s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47ECvSTZ017225;
	Wed, 14 Aug 2024 18:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mjLNQSr7MXL+jo0Hqwe/pztdR07h/jsDy4S2LUII5is=; b=pNvwOL8sb9Rrf7EQ
	iut0UJp1NgkM2vKRnpN0ehthmCLbAKVAMa+tZyCl30/2jJeIwQ2RfD3ruVkwqKNm
	W8V8chqT2VaRwDd/kVpEVhbu99qMMVCi02vheSCcwTVwEgu/Lt8kOoS53lqpn0fH
	BcRZuVh70DzPxJ6X2c6wtOwZA3ZzfKurjoIhqQUtP3H8hlgwugo+A8Hu1ntZaJg/
	hEM0O56yzNWrA4425kbE+z2mNCPVvAW/ukFlHBga+MgEGmR+xtcqLTV0ulxmzDtS
	n8OOkOqbzdCX6gKzkRPN4Kduhm2M8jkNUN7a0IwnBR2dbQ8MvLlwTAk2zeWyZlEL
	oB1Idg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410kywjcdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:12:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47EIC2L0013589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:12:02 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 Aug
 2024 11:12:02 -0700
Message-ID: <9e3ff5bf-cd73-46a3-8d43-81f452b5b5a3@quicinc.com>
Date: Wed, 14 Aug 2024 11:12:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath12k: Introduce iface combination cleanup
 helper
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240814103423.3980958-1-quic_periyasa@quicinc.com>
 <20240814103423.3980958-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240814103423.3980958-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rfTKKhbsGqL-raJuAtVbOiajO4XLIsVZ
X-Proofpoint-GUID: rfTKKhbsGqL-raJuAtVbOiajO4XLIsVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_14,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=725 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140124

On 8/14/2024 3:34 AM, Karthikeyan Periyasamy wrote:
> Introduce a cleanup helper function to avoid redundant code for iface
> combination cleanup. Remove the cleanup code from
> ath12k_mac_hw_unregister() and ath12k_mac_hw_register() and replace it
> with new cleanup helper function.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00183-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


