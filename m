Return-Path: <linux-wireless+bounces-12996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ABE97C2DB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 04:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA94328365C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 02:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804B7E574;
	Thu, 19 Sep 2024 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FEu7+TQ3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D133D8
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 02:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726713849; cv=none; b=cKO4e3hcp3SEKkOgA2NOKVg7FQJTmREXtm9PRy5W3GIf086rsnnWyAF0JhVk5OIENTKewzPxG17glKwgSdDtZ6t3Zg019DDapJPBEqXBVTiWHyoOMixTRkImr4+qkWlouYbURG1VIR3/pqC67fHTbbDviBIPTvoRainA3R89ti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726713849; c=relaxed/simple;
	bh=eVDTFPHEMicy46jgYmrW5UhOgKAIDNHZGtoVgeRqpIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eQ+0Ng3ow657nliOa85BJ/2NrH1HClpCJ1VqbvkaIZHmnSOVKxRp01FOm1ddBldU8JyOcchkbPvtwZw6kzCoWajWWk9R1uV+qyLsaMcmrIvdeKSSnVqqOgEey12JbyG/k6naVy1ei6aLQDgyQGiDcMv/1esptyFC95Yy43lzqUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FEu7+TQ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48ILMt8j002336;
	Thu, 19 Sep 2024 02:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LDsYwrcGZLZ6kDfm21Q86Cz3hfLWyZqBR8GPf3iPfA0=; b=FEu7+TQ3f8pa6pjS
	s4VxqlpCjCW4uK8ht8PAJvCF+BXXOHdZ09unasDK87bAhvma/yluEfrwRdhzhLf7
	A2G1y5wK2jSy2BXIGK0dFt0GYR8aStTze7AeH+PYq+Uj57DMvWW8qtq9YmiRu8Jp
	GXdVyGVTOBGneCnD7BY0CgmYB/SYnr7wNFziVs0rF6zhyA6mOukdQNGJQ7WHqOhA
	0PNChOhdYRS3vJ0vYB5FN6KtFFzpzdDoDFWHvrp0ybk+Jc7Wrqz8UXWn7QS26dmx
	K1v4iX1I9jEEoDeHb/eZa6b726xE1iATBdRaUm0lkk17EqX6CXLQWgk1gedR4CEE
	RyP5uQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4gnut0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 02:44:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48J2hxW4010642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 02:43:59 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Sep
 2024 19:43:58 -0700
Message-ID: <33963bc8-7cc9-434a-8910-cbcfc6fa965e@quicinc.com>
Date: Thu, 19 Sep 2024 10:43:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/4] wifi: ath12k: switch to using wiphy_lock() and
 remove ar->conf_mutex
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240918181042.91891-1-kvalo@kernel.org>
 <20240918181042.91891-2-kvalo@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240918181042.91891-2-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4Clxvxdm_Kfqo8ILt_gDhYVDgcrEjr9G
X-Proofpoint-ORIG-GUID: 4Clxvxdm_Kfqo8ILt_gDhYVDgcrEjr9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409190017



On 9/19/2024 2:10 AM, Kalle Valo wrote:
> @@ -4310,7 +4301,7 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
>  
>  	spin_unlock_bh(&ar->data_lock);
>  
> -	mutex_lock(&ar->conf_mutex);
> +	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
note in patch 4/4 ath12k_sta::update_wk is converted to use wiphy_work. While a wiphy work item is running wiphy lock is held already. So here try to acquire wiphy lock once again will lead to a deadlock.

>  
>  	nss = max_t(u32, 1, nss);
>  	nss = min(nss, max(ath12k_mac_max_ht_nss(ht_mcs_mask),
> @@ -4426,7 +4417,7 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
>  		}
>  	}
>  err_rc_bw_changed:
> -	mutex_unlock(&ar->conf_mutex);
> +	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
>  }

