Return-Path: <linux-wireless+bounces-2585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CE383E867
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 01:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148F628DC4C
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 00:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA6781A;
	Sat, 27 Jan 2024 00:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OD3qdbUt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613C117D9
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314836; cv=none; b=k3KQLLJdNuCYNOzYMV9uYs3SakRM2lxdmFCFXQT1wWfZM0Vw1EX2Nr7uMEqv2knWbWd6Br7SoTrRFQuzS5LEfdddDjI4FFNPgOegoGOHM20MhE4pgmPmP4RGrTB6z7bUvIkuJul3Zbs0sWz4Px7XpIJHNXRUZ6reSTfDJYRhCPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314836; c=relaxed/simple;
	bh=29Ac16C/2KhvNqqp/EOpl6vOucWH1oWUFV8Ov9yio4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k5B38vON6RZS+EVfhkPj4Pg2fTVOKBipDBzr7CU+z55FAQN7Q9lm9efP4R/a+8K45bSbAefB+i8vQspn1VBEY9p96bkUtRfefI+JZ2cVbzZpT7WFFmTWxhkgJgvhSHkdlRFWqzIt8D+47KEH4gL1hdRGF/3D33OzRc8UzcBqzNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OD3qdbUt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNo370021845;
	Sat, 27 Jan 2024 00:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BXbDSrhnJfMCsDDlW0B1W7iaJmzPxH8sZ7tVVbpi7pY=; b=OD
	3qdbUtunDdrZ0RTH13XE3I8VI53CHNnBI0U0R4NU3UR3jg1mBaMWhY3KVspW12qE
	lcD03KVAFPvDQxAFR+5sG1ySv+ZjhZ8TQ8762Obcm6tji1rdwWUpuPn7gwokDhYq
	6oFAXeBSa5HF8s0OYZg+r1XF6I8hCxAuUdyFFTMP6PbNwCWSHla2cqZCT2Nh6zhc
	61NePB8ZwKJrm4Q6D/5JyRwu59Vbbmz/gCvAILgd7AX+3Cnd6RYhQrNyK3xOW9PI
	/R+qVdpuUIycO24zequGzFsWyDZa0itdfa/IwHPKnwsCifcb+Q9sf/UyOP2GYwt4
	xogqt0UevhlZF6Zb9MBQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvmmmg9bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:20:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R0KTui005786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:20:29 GMT
Received: from [10.110.0.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 16:20:28 -0800
Message-ID: <c28f87f4-63b4-4222-a76b-8e70b2aa43cc@quicinc.com>
Date: Fri, 26 Jan 2024 16:20:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] wifi: ath12k: allow specific mgmt frame tx while
 vdev is not up
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240126115231.356658-1-quic_kangyang@quicinc.com>
 <20240126115231.356658-7-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240126115231.356658-7-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6wdsnNeFBHtS8K9KtWopeKOQQd0ifvCo
X-Proofpoint-ORIG-GUID: 6wdsnNeFBHtS8K9KtWopeKOQQd0ifvCo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=789
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270001

On 1/26/2024 3:52 AM, Kang Yang wrote:
> In current code, the management frames must be sent after vdev is started.
> But for P2P device, vdev won't start until P2P negotiation is done. So
> this logic doesn't make sense for P2P device.
> 
> Also use ar->conf_mutex to synchronize vdev delete and mgmt, TX.

s/,/./ ??

> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


