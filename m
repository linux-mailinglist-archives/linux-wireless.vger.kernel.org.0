Return-Path: <linux-wireless+bounces-17826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD98A18F85
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 11:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1623A3057
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CC61C3C0D;
	Wed, 22 Jan 2025 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GUkFJPe5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6118CBFE
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540988; cv=none; b=C7XUJ+YZ/JX9DgOh8JcsBuQBfcp2QID6Li8jhVYUfgGsQKeq1rmQZNvCZV+rMMEcruNtpa36eSBaoMgQe1SJ8B85SWUq78E2fV82tC2sCCh3nbkuXC+1I0CQzupspEVsaOtJOMQw+mOZ855Suci3olkqXQBn6skUwBOpLyuZOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540988; c=relaxed/simple;
	bh=8aF85o5ew5dAWnVfJV3Zu0xJUJNFfIadMzJC4K3gvnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QV3FV0DPmf9AuJVkz5THHv+uNnMKtLbKRCqo6pOxR4U5rpXOg73RQFXi71HZQY2qvtaAhTr0TS9j+gOSfOdqnL8cwjXOYzek/+a2xtmmmQyskJRTbSF6MY5/gRjGx5fMU//XHKl5Wjn1vAMgG3CawgZ8SaC57cHJr1fbr1qTa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GUkFJPe5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M4Z4SJ019857;
	Wed, 22 Jan 2025 10:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uh5V6M/NjV8X/SaZn8H3TleQnN/GlTxxidIJqM410tY=; b=GUkFJPe5SaA2rtju
	JrgwBuvhowJ/TV2lJBvFi9tD1RhOmD99pyKRwfCaFWhFR3IMrdNb69xI80GGH/Tx
	/HoJY43Uoj2eNb2xavgqhsmcNbPZTRW0NEh9jlG4Fl5e9ydj58IE9S4LjkWzOKT8
	7YQBHTRdATdmqlRpRXgWyn/pm0cYHKFKOEGX2Qa5JA5ZiF+fQvtrCVdjazlGZb3q
	3yMLGkuCqucSQkLJ/uCihmP/YjpC+43VNvJjj0fKL+/nF/WlJBQfxSMiSj+gElP7
	mFce6n2xz9BJLl+aJe8Ob7rapDNozf7q7OpURD+C2rQV+g55Qn0bmqcCg5iDnanA
	qXqW+A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ass6gseg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 10:16:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50MAGDtX030294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 10:16:13 GMT
Received: from [10.216.8.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 22 Jan
 2025 02:16:11 -0800
Message-ID: <42f69fd0-4820-403a-b6d9-2a822891ca06@quicinc.com>
Date: Wed, 22 Jan 2025 15:46:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/4] wifi: ath12k: add configure country code for
 WCN7850
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250121104543.2053-1-quic_kangyang@quicinc.com>
 <20250121104543.2053-2-quic_kangyang@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250121104543.2053-2-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BWKnYJCFAjMqJLgHb2xui8_9sZyv7UmX
X-Proofpoint-ORIG-GUID: BWKnYJCFAjMqJLgHb2xui8_9sZyv7UmX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=904 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501220075

On 1/21/25 16:15, Kang Yang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> Currently, WMI_SET_INIT_COUNTRY_CMDID is used to set country code for
> WCN7850 and QCN9274.
> 
> But WMI_SET_INIT_COUNTRY_CMDID is not the correct command for WCN7850.
> 
> Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware, which
> is used for WCN7850 to update country code.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

