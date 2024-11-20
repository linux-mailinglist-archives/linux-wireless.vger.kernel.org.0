Return-Path: <linux-wireless+bounces-15531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6E9D3F4D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 16:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C82528407A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09AF137930;
	Wed, 20 Nov 2024 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G06nSMPf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E685C5E
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117543; cv=none; b=OG/kj+0Z/ge8NiuefYJlD40pZFdHQVkmREO2sKwEXUjnhEsWjAsdwiMBssr96jdxb6G2NG+jHAP1QCgK6RK9SpFc9IcAsHsXIIJBu8shJ5n7NLR/9O7A9QhboyDl5Iiqwju+VHGBBm9Qr5AJJsVVC+BJyNrbTPFBiMciHZPOpDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117543; c=relaxed/simple;
	bh=ba0UVn6GzdG6i7oJnPCIsYfEjDfLmkxZMsXstH3owpE=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=aplmWG3ErxwBNDrPa1OKB8S8br+EyG2qmAmN+7DuYOvbJ664Dj1/Pxjmw4HCDp6H+gtJ3SIjuKlVekLH9QfA1AgfUq0wWQUbQLIuDKuwnlBOjokkxHJ7I5XwyN0FeAzv3kCF5U5zavd+pvA6zuskg3iF/c+4zbJnirzK375HDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G06nSMPf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKAjp6a004461;
	Wed, 20 Nov 2024 15:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r117AJXxnoPPu/w4qMPMNtACUJeYSYGLjlNSEmhTREU=; b=G06nSMPf6X9I62sZ
	wIG5NcjeHj869gFo87Ftsn6moQA00lkIyQ9oImGTbC5tdcVfbeq6psMy7n+ZcQrT
	hiuf+Jm0jBEDiNgCSl5cdh2UP+3W51O43seNWjlR+kUS+vibXKFRl36klToa/OT9
	Y/uhjMSpP/zm5yw+H3/3PlwSZ+6K0gTwe7dnd9tHg5ojP28jK/qXuePECJvrb4fE
	cS3TKOzDApYJ3PwSFBM6VJAleaqFacmMq4byQLxTd0V9MT8Qt5sFEG6efUHx5dzL
	yCX3ZtyQHQzZqT5Ey3xlg2CVMCnxnfYlszfG68AduoICkDJ4XeEL8bW2rtwz8MKh
	nMOkIg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431ea70rd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 15:45:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AKFjcI5014635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 15:45:38 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 20 Nov
 2024 07:45:38 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
CC: <linux-wireless@vger.kernel.org>,
        Sidhanta Sahu
	<quic_sidhanta@quicinc.com>
In-Reply-To: <20241105052854.2118987-1-quic_rdevanat@quicinc.com>
References: <20241105052854.2118987-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH v2] wifi: ath12k: Support MBSSID Control Frame Stats
Message-ID: <173211753847.1671164.6591948218266274358.b4-ty@quicinc.com>
Date: Wed, 20 Nov 2024 07:45:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IeDwyHOnGKqKubhrfgv64oJowEJSeV5A
X-Proofpoint-ORIG-GUID: IeDwyHOnGKqKubhrfgv64oJowEJSeV5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=692
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200106


On Tue, 05 Nov 2024 10:58:54 +0530, Roopni Devanathan wrote:
> Add support to request MBSSID control frame stats from firmware
> through HTT stats type 54. These stats give information such as
> basic trigger, BSR trigger, multi-user RTS and uplink MUMIMO
> trigger within and across various BSS.
> 
> Note: WCN7850 firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
> support HTT stats type 54.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Support MBSSID Control Frame Stats
      commit: ea58aae8458480d6391c404e62f1a4b30462b9c3

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


