Return-Path: <linux-wireless+bounces-12272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2389C966B42
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 23:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF5F1F22E2D
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 21:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2F71C0DD2;
	Fri, 30 Aug 2024 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pwvtLQ+3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB0C1AF4ED
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053240; cv=none; b=PRHm5Wqrx0gSy9v45tWAGZ7R9fkbBR4bBFJl4spTjkumL52jypTWCcRewrBTF9vctto3k5trd49XwKLyj8y/TZirvkEG/aU7BPhT5JwoQ+xfbeaVlLVPBfiWhlFhHlkYhV4r14DgAkMc/hw2wOg6v+niiJ3kgEBVRuAldapJXZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053240; c=relaxed/simple;
	bh=2gRxtCofuFUodREZrEHS8zuVKB/E8IH5YRWvuVPY60s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lPo2yfNuzOR7/2FH4pUwlQg2roplV9D42DjBrjYjcLy481UH62mv6L0Eaqq6MHdPE22QElDPwyGCAZGIh7Y2RSeDmyqMdiJLopkoTGfhT7F538ezpOumk/khqiENkzqNab+J5SiJeT3B1Rt/DNB+SW9U5xiuBPFHvApuElipC7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pwvtLQ+3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UF7GuD013777;
	Fri, 30 Aug 2024 21:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E8CD1M5m7jGd03r4TpkDea5q75477vrNXG5ZOkrO0PI=; b=pwvtLQ+3d3LUnomH
	NFxwrvDHKbsDN7g9xFu3IkW2AT2+pWu7mGJM0SHMQHNh1eeMaNugcbk75fM70hkC
	Bmd1nKUwt+E1avXl0eu1nG9/kPZRtG2DRo1f/l21y/52jJWU7vE8/FvDiTc2WbwB
	z2ILxnUdvBfepLAzyZNVdg+H/vfyCWIqB4V4p4AiBFny6vecZDNiEO8kAXqCpQb8
	5MAXrIbKPY6O+RKviihcnBVnSO1OIp1Bcous8a1a2mnDDMLGPTOuBK3XHyPFWiCg
	c95bFU6ysDfqDDussieQUh3MA7ZoG8jIxsTciM/EFPB9x6LLFrw63zvIcfIBp5K0
	UY8ksg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419pv0tdn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 21:27:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47ULRD6w026941
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 21:27:13 GMT
Received: from [10.111.180.95] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 30 Aug
 2024 14:27:12 -0700
Message-ID: <e7390faf-fdcb-4de4-b15a-ce849afef406@quicinc.com>
Date: Fri, 30 Aug 2024 14:27:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Add support to simulate firmware crash
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240829084411.3521261-1-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240829084411.3521261-1-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZOEQU5q47-Fc1YYWotq47GlMQoTPpWNx
X-Proofpoint-ORIG-GUID: ZOEQU5q47-Fc1YYWotq47GlMQoTPpWNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=998 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300166

On 8/29/2024 1:44 AM, Ramya Gnanasekar wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add debugfs support to simulate firmware crash to test firmware restart.
> 
> Usage:
> -----
> echo assert > /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/simulate_fw_crash
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


