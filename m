Return-Path: <linux-wireless+bounces-2912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEF9844970
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416B61C221F6
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDD138DDB;
	Wed, 31 Jan 2024 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fVYCc6xz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE2238FB6
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735298; cv=none; b=UqxvDXY7SeLQVo6amPbYuYkt6fiO7jlt/42Hc6JJ31+XblVbHmBYu+IizVlb6TDn2KrFQYTuxIUE9JCwMa74AJSBj5yHxiC9RaF+2IxeDC1OQLR0SmdbMhCwZbS0ejDdr5Zi61PcY8EkSbue3Q47vAeG7PTyGCvY5hibUK+UHeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735298; c=relaxed/simple;
	bh=WHILplTVXCkuadzw18EMJp0j9EefWo48qAefxPbJqCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AP0klwy8C+CLduN3NOtrFJ5M7yPoCNH7sQJRxvcmEq0LYmD/jpzc83rsncMmIY5bklzNhm+Ohn2vpuHCEjKvBBy0LuGF5XS0n2k6q9eEZgWiONUowCFEhl1nlD+Zicc7oyMXPfSG6rSyNB+GOLfuvHiXCOFj0+7cyFcj5QIyAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fVYCc6xz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VKEijO011973;
	Wed, 31 Jan 2024 21:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6Sc1LEpPA0gvd9nYJBvnk1pRSu7b2qnwp1qT1oQfiXw=; b=fV
	YCc6xzOH/LAD46txQ03dfQgTl4PY3P50gVYtwuA+ONMbdNtJAVuJ9PNK8FLCC15y
	OmaBVysjGgVx1QvZhhAjViDl7ITeAJBOhl0wDBrNehzPgOpH7MO6ewf6dSOFEIjx
	g4fc9Oh/VsF/CB4oE/YHcdnV6mmIEODESr/3g3PzOSPHGwWFgOiUDE6zd9+NgxDU
	qzWc8Cwcr02dP8/MIIt6JMtOPom2b6jCHegz/dojcZHGtSiDYf73pTqDMLzhZeo9
	MuIKx6sCSQzZGe8xb9/vfrPPVTvTRSLROJ4XP5mUJEPzI2p7fYHdn+jLU/xOKhXa
	y4fLB/IPmCCTYCevA1Wg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyve607m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:08:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VL8Ewp024691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:08:14 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 13:08:14 -0800
Message-ID: <eba9c004-1d9b-46ef-a5a5-203d741e9c17@quicinc.com>
Date: Wed, 31 Jan 2024 13:08:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] wifi: ath12k: disable QMI PHY capability learn
 in split-phy QCN9274
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-14-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129065724.2310207-14-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SEXYqHKGyE2VoBD32vP7mPr6ksEbcTTc
X-Proofpoint-ORIG-GUID: SEXYqHKGyE2VoBD32vP7mPr6ksEbcTTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 mlxlogscore=945 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310164

On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
> QMI PHY capability learn is used to get PHY count information to
> support single/multi link operation (SLO/MLO) configuration. The
> QCN9274 dualmac firmware currently do not support SLO/MLO, if two
> PHYs are within the same chip. Due to this firmware crashes in
> split-phy QCN9274, while bringing up AP with MLO parameter enabled
> in QMI host capability request message.
> 
> The QMI PHY capability learn is not required for split-phy QCN9274,
> if SLO/MLO is not supported within the same chip. Hence, disable QMI
> PHY capability learn support in split-phy QCN9274.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


