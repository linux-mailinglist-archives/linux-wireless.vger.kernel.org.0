Return-Path: <linux-wireless+bounces-17906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D28A1B952
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 16:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837D4188E357
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0717415EFA0;
	Fri, 24 Jan 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZPQNB/5w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81B15B551
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737732691; cv=none; b=YjN3J+HojOE1ktabrewMVniLi5S27ByFFABTc1s1kudBkEakkj0P6gMumuuh6oZgXx2K0FTV/tzubFJJa3W59TmUP6EAakLQt4+QVyS5pXl4BYKuFoTqv9mmeZxB5OkrtfI9fb/JnCfY64JFD32FX/iOlHA2fnUqNIN5HB4+W4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737732691; c=relaxed/simple;
	bh=rI8/7oGGDNTFqG0uh6K3O3yLSU5x1mFL49RbSvvuUhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lwEzMJ7plFyxbYhoK7m8Eh3W2XPrldXXSsfadhwgfIrKHh/Nasq13zuLEWAfI0Fo6suju/KHzYL+ZIph5YzQn328QpePmt+yYzVwhWo6xP5lntKIoP0KICg7eMqAj3q6xHcO7BC90zv4KLfaSlZRHboKhbhLd+bKKV1sJ9zmRSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZPQNB/5w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OBkpuO003133;
	Fri, 24 Jan 2025 15:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i4vYsRoGAV2U2Z+oNkxtW1YjRtSaGuoboQehCkxJ71g=; b=ZPQNB/5wtQvNEaj7
	LwFTm2CCUJezA8p6PNmaoH5rPKmIfAlEYVL1/aVRwXcRMdHGLuj/egQFAPvkUbII
	WQI43aLPSXomfiPdp1znf43deKq3ivlzChUAIhIEeOHxNgwgvQvh4BU3T4dKTs1f
	ytp+SEdDjchVdWJHDqJhWj7SMW+a9lSQlvP3hNSOteMdDanJG42faPK6PA1x8YwP
	8m5eYmpwwJS9MLViVPethHO4AZXeHUL11TnDflo2BzNsycP1ORrivRWx+foidgky
	TyfSI8rjskSgJ5wo5EmplIgmJTUFF062QhsTxKNR74p7zfneuc2DA7CkuOGGLHjv
	eTa1lg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ca9prgq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 15:31:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50OFVONW024494
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 15:31:24 GMT
Received: from [10.216.30.251] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 Jan
 2025 07:31:23 -0800
Message-ID: <a979cbc5-5cfe-160d-d5b9-9e5ed7513ed1@quicinc.com>
Date: Fri, 24 Jan 2025 21:01:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: ath12k: fbx: fix ath12k_hal_tx_cmd_ext_desc_setup()
 info1 override
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250124113352.93638-1-nico.escande@gmail.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <20250124113352.93638-1-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j1EEd4gXQjKRCVzGsakdpHTZ6LvtoxEO
X-Proofpoint-ORIG-GUID: j1EEd4gXQjKRCVzGsakdpHTZ6LvtoxEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=882 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501240109



On 1/24/2025 5:03 PM, Nicolas Escande wrote:
> Since inception there is an obvious typo laying around in
> ath12k_hal_tx_cmd_ext_desc_setup(). Instead of intitializing + adding
> flags to tcl_ext_cmd->info1, we initialize + override. This is needed to
> make broadcast frames work with ethernet encapsulation.
> 

SUPPORTS_TX_ENCAP_OFFLOAD not yet advertised by ath12k. How it work with 
ethernet encapsulation ?


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

