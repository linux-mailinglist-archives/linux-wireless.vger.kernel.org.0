Return-Path: <linux-wireless+bounces-2838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D763842A04
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 17:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600981C23340
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27DF128395;
	Tue, 30 Jan 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QaMh7/w9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2021272AE
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633566; cv=none; b=RijuZ+REdcruxg8obF+fKspi3ed5JAcoUcbDFgkotJ/BVjDBL/i3cW2J8HGzh3XVTz8bIX4MTYzhZ5h5MghSkrwf7g7M9io+T2OmgLJq9Qe+FYLZkzzWSqaMOaPHejPMHoy8A2cg9q0fiG5rNdAVdm6AB0QscM2Wk2dDWbBt3Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633566; c=relaxed/simple;
	bh=0PoEH64Ex8p7FvKX8sNw3DN2fb3dR7pRsjAp/fFlPME=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WzTLZU5070nZPELGW0yaDLMlu2XZZ3GZVlWSyELaw4JDc2ZR3iXN4Rsvcy55EN8uwsaSztxTQrI5AYtVu8MaNEJCargt3+OFte68/Q/o56JkCyWUCQzsw+dzqbHO3YSo4As8J0u3aBjRI8s7vxu5vkPxzUEa98HnetAhKCRohE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QaMh7/w9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UBmjko020762;
	Tue, 30 Jan 2024 16:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TwUip3iHGpfopoACxCmIszzy86Uu4tcyJKkF5Cj9o2s=; b=Qa
	Mh7/w91xeMKg3Fh8lhcTJzHQTUwrUPneHhSBG5qpfwd1uBtm8h90UeqFzuwwJNZA
	fKHzH6tZxE8g7XurTz1CXr5v+b0CMGpY8SediS6jtlivccZRUx4NPHvuMs1NAB0u
	JCabdicYeNvRkwL0xCZBlqXEha47bQg0cFqXbIu1AvXV+9lPeXqBnzzYhFGvDzID
	N4h98BomMJUJr0UdaAcE9P3yTI6MCfpf9dfQuAyYUerePI0MT7nYyk/V7TVbrYli
	fIL74SWOTA0sR6ljnwszJ1nSVmWosuq05MQFvdA6/obr4TX78iNr5/jqe/XMu+gM
	/w6kuv3lXxR4Xrzp53Ow==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxwynh55b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 16:52:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UGqXpQ011045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 16:52:33 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 08:52:32 -0800
Message-ID: <d22781a3-1ff2-4be6-b284-400398c44215@quicinc.com>
Date: Tue, 30 Jan 2024 08:52:32 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/11] wifi: ath12k: change interface combination for
 P2P mode
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-4-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130040303.370590-4-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WbZv7uPe1ipc5AUOR2RPucTCvGqdAgt_
X-Proofpoint-GUID: WbZv7uPe1ipc5AUOR2RPucTCvGqdAgt_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=716 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300125

On 1/29/2024 8:02 PM, Kang Yang wrote:
> Current interface combination doesn't support P2P mode. Change the
> combination for P2P mode.
> 
> Also, there is a bug that when mesh is enabled but ap is not enabled.
> In this situation, the mesh's max_interface of interface combination
> won't be set.
> 
> So assign the max_interfaces for mesh directly.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


