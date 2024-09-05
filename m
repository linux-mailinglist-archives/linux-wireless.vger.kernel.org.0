Return-Path: <linux-wireless+bounces-12554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7496E22C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 20:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC122B213FB
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D9818893B;
	Thu,  5 Sep 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VkZq59vo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AF18892C
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561732; cv=none; b=DjNN/rGtf5gHo6uozMuh1YohVzEQk44rfBaQbiSXQ7wNHrRiyuiFT1SS6sTpBvlYjQ7D410G4uueOgdb6GnvYGF/gc5xgQ8lT01IdQfAa0YGQJfmXhhiO/LYXgTxT002GQlhotjcp8I1+XgqohXB2OWisTTgkeTIrpw57C6Pdzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561732; c=relaxed/simple;
	bh=yOWP8rBqyiSxbgasC0XEeEwkzSqUAZi7VP7hSfbjFxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=isZT1+ioU5AYoYWhk2CV85MyN/54EiyAdXdws/OSEjnARLnh6EoaHzAmNOO3ww6zJBXZNpMtMhepCF5VklebFUqZwDS90DcuK8BBKUrqx9l0CTfpUtap/PcOWvlc7AnA7633+7mS6TNZnL/k/R9J24RGX0cABr7vXpMcGhEO+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VkZq59vo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQ5er021772;
	Thu, 5 Sep 2024 18:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L5Os+bA9Fs3wqrNOsTKewI6oSD5lRDuJsFQaEBESRMg=; b=VkZq59voxT/u5DTp
	yNFh8d0uH2U+OA2jMNIBhtfJ5usotm3SBbPb0GQmKvOlfzDzj2nAfPLtlEsIjoyr
	6XMvr1Wl0l03Rh8+4fG0RkDkjYysE6lkFQF9apnjdaCd4rGCy7Hg5a7TwyEYHDf8
	6h/ub8EZJprX2+ADaVJ84Y7LSvDcuBSiW4tacYuqE+DUdGIWvwUAOSpCwx1DTJiF
	L1a5mZgjyjrQv7W8OU3bZgesYhHK+QmuxNsFuag9ZxJuDGbOr5Obzw3XQqlE4JBx
	PLg53HVUnwxJaGREvFVzr0hPs0ELgFM5Wh360CsqftmE+GVegu/ljHHiHV1vUb9H
	YKv+ng==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwu00yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 18:42:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 485Ig2c6016042
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 18:42:02 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 11:42:01 -0700
Message-ID: <63944476-d63c-457c-ba5e-391a94706945@quicinc.com>
Date: Thu, 5 Sep 2024 11:42:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath10k: add USB device ID for Atheros QCA9377-7
To: Tomas Paukrt <tomaspaukrt@email.cz>, <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <5Jj.Zbdh.4ausKfY}jbL.1csLRX@seznam.cz>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <5Jj.Zbdh.4ausKfY}jbL.1csLRX@seznam.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OCEzxS097ApRBQ65BHawv29v1XWPCpP6
X-Proofpoint-ORIG-GUID: OCEzxS097ApRBQ65BHawv29v1XWPCpP6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_13,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=496 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409050139

On 9/4/2024 11:59 PM, Tomas Paukrt wrote:
> Add USB device ID for modules based of Atheros QCA9377-7 chipset like
> 8devices BLUE bean or SparkLAN WUBQ-159ACN.
> 
> Tested-on: QCA9377 hw1.1 USB 0.0.0.111
> 
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


