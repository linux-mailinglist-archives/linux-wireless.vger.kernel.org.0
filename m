Return-Path: <linux-wireless+bounces-14097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11E89A0DE6
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 17:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694081F23916
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A6B20E034;
	Wed, 16 Oct 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H0zRJLqF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0C2071ED
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091883; cv=none; b=STrtgK5aN9AAh3o7CBCNgTRRp3gGQgYL2J4XOghKOcYhIoaPGDV4V7zYBhIAHM907FgG8fRygUMAhC2GM/jPUD1J5br4WX3qks+3VsEBuBfvSK8S0EAVphndQtxO7GQsmNbzFdnMflAYQGQjOvYLZs/sfm+lHiqiZHGYj6ddBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091883; c=relaxed/simple;
	bh=Xx+k9mvVD2HPf8lrrGSYBU0uSuA9KLsZjG4K+DtfHxg=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=lIL7UGnUBbLnxv/ffYbXMDrP/CX0MBF0VlQ9L1hLFYFuKlVrJgT1EaiR5TbwBQAzNe6HfdzIq7/Y6CrA+kmWjs9Sc1SoGNLocL0XNG9YxKfM+aO+zeFDXEAh0BrsDiHwD0pOH87X/awk4tR+FlQmOgwwAWcedfr93iqDSLWh5r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H0zRJLqF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAI2EN011275;
	Wed, 16 Oct 2024 15:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WkYpEXlfj4Z6HJa3arUdRA+ROLVOZ5ZsObOtV23Aa0k=; b=H0zRJLqF6WgtpFOV
	Kzx64TrGfgf29nBHj0f4MGa7XMx1iKBuyhwJzA9SIT9ORBF77a7RNtztb59Ae6II
	uqDS9gRFMBZwoYgTg8ajy6ljeCF5ys2AIPGX3h8eE1mKpuNIxz0dcSXNM2ipqFYJ
	B0zaFwNY8DM1Dl6PP0BHS3Xv5BDpU8muz2CeCLbGSccR/+C2tM4Dyc4O2rN0d6Nf
	yKkOJJWNQrrQ4aM8IBqiZiDnkSXQ41X6/HNBERS0BF7vaiWZIKT+oR3GPXoYM1aq
	DsK0VYzhk1HC4hJrz3LFVaBLC5IlGPEg1Pa3/P9z8CbVJv8smEYP/uWn8yJh9I8b
	E8xvgQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42abm5h0v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:17:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GFHvFp028670
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:17:57 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 08:17:57 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241014070610.3982173-1-quic_rdevanat@quicinc.com>
References: <20241014070610.3982173-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH v3 0/2] wifi: ath12k: Support pdev Rate, Scheduled
 Algorithm Stats
Message-ID: <172909187738.412681.6151951796339627946.b4-ty@quicinc.com>
Date: Wed, 16 Oct 2024 08:17:57 -0700
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
X-Proofpoint-ORIG-GUID: Y7w3tt4ZoTO46yOTWh0hO0l2piVMV245
X-Proofpoint-GUID: Y7w3tt4ZoTO46yOTWh0hO0l2piVMV245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=640 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160096


On Mon, 14 Oct 2024 12:36:08 +0530, Roopni Devanathan wrote:
> Add support to request HTT stats type 49 and 51 from firmware. These
> stats give scheduled algorithm stats and BE OFDMA rate of pdev, respectively.
> 
> v3:
>  - Updated dependencies.
> v2:
>  - Modified the API print_array_to_buf_v2() to print_array_to_buf_index().
>  - Updated dependencies.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Support Pdev Scheduled Algorithm Stats
      commit: 9fa60c6d40599dfb788a1cafdef9a1c464a95b7d
[2/2] wifi: ath12k: Support BE OFDMA Pdev Rate Stats
      commit: 25ff1ae52139b53c1a69f55ce235077528245b55

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


