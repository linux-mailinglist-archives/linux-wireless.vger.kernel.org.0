Return-Path: <linux-wireless+bounces-15018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D99BFA93
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 01:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F11B1F2238A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 00:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFB6366;
	Thu,  7 Nov 2024 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RglQpKim"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC107E1
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 00:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938335; cv=none; b=LDwZutSsW6lh2713AvomlA5726KKmrp2MJTgfB9zPvOA5oZ1rwsD2kSgOZVO6IX4iHPSUkZ2LKSKwkjxCPheaVViLUE++aFzUOiS0GFtFmi6Pt09tlmHVp81jTQ721R873dMnipXFB4DdGoTVzfsYUDikTRfEZezmr64axbl+Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938335; c=relaxed/simple;
	bh=N9pU3+l63HBZN7NzzIqI/Rvt7CIfx4bYJpp5lXIgxfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jbaMw1vrGYPBUGX275unlf+uZn0rOeyzc+nokcTtXH1161aOxFKT16WHWq/Gn/4ivUfEuSe1HeGUJyYyHMl9D2dGBqaU0S9elSb/2lv6wSITiIqKH/XjIY4jFQn7k2Yd9zFSxIil8dhYZmTbaR87sSOuzVsnf/i+erAstfhiwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RglQpKim; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6IMV55003973;
	Thu, 7 Nov 2024 00:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yLx2uaNglJrl7r/IxccTF2WyiC+Hv8MmhCGkFPyZ0UE=; b=RglQpKimNcyE9ppU
	KPdRfBZyTnCtljQS4e0H05ysLtsvKByPw1QyHwXQu0FDH+py2LoYq865tt5b3BAO
	6jIFiCSGbkIRCy0k/4ba/QcuYz1+tswO9dFF/SMvHgK8VZetF17oLKGBZotOYIYD
	vjOq7LrY7itD1Jqa6p5JqwaJ6TATjKmR43LzIbQXpNSowFSbn+NeM/JN0okNgYX9
	J7egCinpHMxT/KGjoVkZzcIA6ELBZYTCMlbqoLzSegJvdq0YStXMZGp6y6MugAQm
	5sLvVAbUEwixlvckRjlsopsuzjjKQmWoQav5/6XK74F6H+FFeHDAalU/nkN2CyPK
	+MZMeA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qfdx5t8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 00:12:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A70CB41007233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 00:12:11 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 16:12:10 -0800
Message-ID: <2306dc90-cdb5-43e3-a664-c194604cd100@quicinc.com>
Date: Wed, 6 Nov 2024 16:12:09 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] wifi: ath12k: Support SoC Common Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20241106044548.3530128-1-quic_rdevanat@quicinc.com>
 <20241106044548.3530128-4-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241106044548.3530128-4-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p9NOIWWSRZjlae-6RD1TeXErjmYCkof-
X-Proofpoint-ORIG-GUID: p9NOIWWSRZjlae-6RD1TeXErjmYCkof-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=941
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070000

On 11/5/2024 8:45 PM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request SoC stat from firmware through HTT stat
> type 38. This stat gives drop count of SoC.
> 
> Note: MCC firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
> support tag HTT_STATS_SOC_TXRX_STATS_COMMON_TAG(125).
> 
> Sample output:
> -------------
> echo 38 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_SOC_COMMON_STATS_TLV:
> soc_drop_count = 0x0000000000000000
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


