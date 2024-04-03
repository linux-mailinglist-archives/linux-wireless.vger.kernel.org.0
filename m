Return-Path: <linux-wireless+bounces-5852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E166A89798F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 22:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C90B28F6C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 20:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A12154BE8;
	Wed,  3 Apr 2024 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="haTSTDJl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEC1553AE
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174590; cv=none; b=QL3QVrBhYUvrIBvMvi9zRi3wwT9oPKm0xtU2rWbIfGvMjMaoh3QLfbLhUDBeri/RRgbOPiwq6FSbjzMsn2JUr6ZRG9x0yhadVN7qGWnt2UCIRqESKkc87Sg1jC5+pNe2PXBCOc8rTMEq1mdxMB0ieO1Oplr9YQPDEleVg89SUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174590; c=relaxed/simple;
	bh=I1ufl5RkKe6Pmb+VcHSrHzHTsWuFN9cknv4Q4uc0+Pk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=faskfwSl99sDWWJNaZ2kIiq/mpyOA/btRiY6CHsjr6xRVOc49B3t21rzhn4WQvikTspNqBFl1jYL2PAFjbGRAduwWisF/G8BGMljSZo+DS93h4tAh0kFEq6i9GCleujZeI+d7Ua9AEUEqG9RDqBHPR5GdzirEc1SlDQZd9rIhcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=haTSTDJl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433Jr1Ca030762;
	Wed, 3 Apr 2024 20:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=I1ufl5RkKe6Pmb+VcHSrHzHTsWuFN9cknv4Q4uc0+Pk=; b=ha
	TSTDJl3vP1pIgxcNpp0DL4IBzeTR+ATBES3FbdVk2N4sNjNqajNjUNzJKgzBhW74
	GESMFyqwqKK8+WZ2SfibceS0MUsOUR37EIwHOI4YXhUZQp0vAAWhKUPsSb72Aekz
	zZRpEMLO8xrLZ9aMlz0gEJL8MvjF2YmpiU6JMb7jLgXE7qXek22f6vvf5LPiQXeP
	hH3TtU0/smDnx42/BotzvsSndTKFMRjR0Db/DsSrgiy/Qe17gqUhJYn2116Hm1Ge
	OFovMOxa+aOdChyF5RPeuJ6Cjx9bDNRIX1Mwy10YNqeej4z5vrqGFUX0si9XaTix
	nld1B5ZfWuGZbl+91xxg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93a5hrnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 20:03:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433K33cI023275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 20:03:03 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 13:03:03 -0700
Message-ID: <95e07dfc-d7ea-42a9-9354-7e1e2d5fffb1@quicinc.com>
Date: Wed, 3 Apr 2024 13:03:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] wifi: mt76: mt7915: add fallback in case of missing
 precal data
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
References: <20240403103032.54823-1-nbd@nbd.name>
 <20240403103032.54823-11-nbd@nbd.name>
 <335bba80-addd-4443-b67e-d3de114b91ba@quicinc.com>
In-Reply-To: <335bba80-addd-4443-b67e-d3de114b91ba@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nGIvNYpmjbIyJADOdg2j711r1Myv6I76
X-Proofpoint-ORIG-GUID: nGIvNYpmjbIyJADOdg2j711r1Myv6I76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_21,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=808
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030135

On 4/3/2024 12:51 PM, Jeff Johnson wrote:
> if you are going to devm_kfree the memory for this case, why not also for the
> mt76_get_of_data_from_mtd() failure case?

ignore that comment -- obviously that was the success case and the failure ace
comes here


