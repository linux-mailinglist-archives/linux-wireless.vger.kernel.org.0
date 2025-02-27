Return-Path: <linux-wireless+bounces-19522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CABEA47557
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 06:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0633AE263
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 05:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDE51E5210;
	Thu, 27 Feb 2025 05:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cPH842TK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FCA2063C0
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635095; cv=none; b=QnCPVRG2g4nH6tEpqLQyBua7KR2WufQeB5c/ZvUIQLAOGKp1anE8Jk0wHzjvOpgAO78yQnwdioM5x7egzkg8HpNflfkGglj7/MjdNO+RlnJbBQAQFz8IvlDBCvnkZC3gjt9QcfDu4YqAMA2AqZtLFPOi5zRRX1Pahoy0aTC0NQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635095; c=relaxed/simple;
	bh=Kp8zVClfqqI/XuQ/g+WjJ9UIygncey0TO+Br/OsRPI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C9T9dlkdkQqITiid3zoI1O41HhJ0OXMMA2drmHH176N80krhWF5y3QfmZKCvYAEeKR1tRHQhN4X10KCvd/XMzaXHzC9CXthu67uYQ1TaaKji+ZJslMXLP8nIidv+5mdVIII7fDMroq+FsnWOp4y9ysPLUQLhIpzSoySWa3YmvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cPH842TK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QGHccS022780;
	Thu, 27 Feb 2025 05:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XxHZmZwE8FNxnVT0N/qHBlvWyUcOpmThT3ugqYjnV1c=; b=cPH842TKqQAF48df
	dNAiLtOGHJKgnJhuyG6DMfyuzodGEW6ot208/XIPgzVoBwpazOdjgMYaVb3nXJRU
	b0glebtEXUYKHktwQFS3xzzyht/sFP+3B8aXAjcxPRhPfP9CcZVIhvuC2pxxFTkZ
	V41qT9UgNsyfy3O8FGeum2y7TUOpamWRpbsrj6f11rNRqD0VLKhpGPBVfCQb6kps
	/teIFlrHdilT3GnJgEhMfBs8HZpPgrxo13+awSNRWcCiKJHzREZjWmjI6lZ37V3Z
	hb9EkDLEPqz79Epc5CktIMlHxFP3G+r61v/gS82P2pkJrHrey4MAybss1TzJ2v60
	zhv6Hg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4526bj1tue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 05:44:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51R5ipce021312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 05:44:51 GMT
Received: from [10.216.32.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Feb
 2025 21:44:49 -0800
Message-ID: <ea6c7671-ca35-492f-d314-9cee535147b6@quicinc.com>
Date: Thu, 27 Feb 2025 11:14:46 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/5] wifi: ath11k: pass tx arvif for MBSSID and EMA
 beacon generation
Content-Language: en-US
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20250210182718.408891-1-aloka.dixit@oss.qualcomm.com>
 <20250210182718.408891-3-aloka.dixit@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250210182718.408891-3-aloka.dixit@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uOMVJFno3uCnelAeQRwAm2A9X1K0-4Ru
X-Proofpoint-GUID: uOMVJFno3uCnelAeQRwAm2A9X1K0-4Ru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=362 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270042



On 2/10/2025 11:57 PM, Aloka Dixit wrote:
> Function ath11k_mac_setup_bcn_tmpl() retrieves tx_arvif only for
> a sanity check and then calls ath11k_mac_setup_bcn_tmpl_mbssid()
> or ath11k_mac_setup_bcn_tmpl_ema() both of which again retrieve
> the same pointer. Instead store the pointer and pass it to the
> latter two functions. Compile tested only.
> 
> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

