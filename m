Return-Path: <linux-wireless+bounces-18605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F8A2B43B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 22:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D9D18874F0
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 21:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0FC22257E;
	Thu,  6 Feb 2025 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ND2ISF3c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FB22258B
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738877845; cv=none; b=Ci0eADZxi51mXFyIjF5lWidC5ReCL2psYmwJocd85uGYfk/a0S4juLNzbAu2nfe16mDha1L1ta/xJQFv+sI+NpadeEdsvDnOaY0FOuVpuzUj//eHSwHdKlxihq9WJb+H+tPcqN8XxeviKZnAx/ToPboSKrHhg+MIKLOn/PUbYmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738877845; c=relaxed/simple;
	bh=ej+6EgE1/Dtfh0rxFR68ChgtHzlSS/6DTKCGhimxAO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NBIQX4QD4ZJWVu0UnKWybAjx+H5Uc8zTiWvwnddifHUMxxJvVn450FIYYp1BqFSEf2vqotfBOK7sZuPQZoCikREg46tRPJVZV5mAPjltvJ/UptWuN1lCVrNnm3QZvqxlne/JRlo6j3ZAh1h0IlcgoLsq1NUrraze2CNVUIHaXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ND2ISF3c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516AH3tE016094
	for <linux-wireless@vger.kernel.org>; Thu, 6 Feb 2025 21:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G7wjLP+yTM02I49I8Ek7TaQyeo1dCCYOyY+5OGI9Wsk=; b=ND2ISF3cvYwGfyQ0
	jt77DAeLb2bazcd+X6L+wBI+RRCi4s7jrVU9rL7nIk4CBSYmqfOveN65tWcF4sTa
	QQWUCUcYrO1jlW4PxGFDCZtevrULXy5cpj9jq336xRa6gww2Lnb7wbp9x0ybRb70
	fY98XPhZRzHijlb7h18Vt6J8l1yRULDNwRgFbwYXPImQHa4J7U8sjSU/hqArNDmK
	/AAwd03cohFN0fZugNky8XpQO2d2wBIhzW2lDus8SUJml0DsjHs0en7BBPaxupcQ
	NsxXjHlyQ3CWVh3mQGIcJclFgrrRdWp2p8W2goA3yTf1W2Vvw+N1CHrUh3/VnFyx
	9id1QQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mu6f1ksx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Feb 2025 21:37:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216387ddda8so30455625ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 06 Feb 2025 13:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738877841; x=1739482641;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7wjLP+yTM02I49I8Ek7TaQyeo1dCCYOyY+5OGI9Wsk=;
        b=viz1q8Z58W9BiZ/6XxG5l8snkHQTBCwnrrDTWn1xNCJrVGQMCCwkLzJOFGj8LMvIz8
         AoqmNAUc23GtWaNgQ9n/UWq0ELyyaNwxKAvZs0Gn8Z+UP2qG2dvEIpOy/fQBfPsWG5JM
         5c8S8zslGSINe/lNY51bMEK9/aggRvUTGrrYlzBFcB1l502483WJl7sILjyKg/WnAbkH
         rKO/ibnnl6W/+z7ox7DgvzMaLtIO3TtoAZHLyeUhjToF/4c/jQJBBusSg9NYDy94f3ww
         ofFrFeh64bwkf9JZnI1Ajuc0WcVpvSJBZQhzZYfo8D+yEEyY62S/Beuvs0FZF3Aqr6kR
         kXww==
X-Forwarded-Encrypted: i=1; AJvYcCUrcm4oCc5cGV8H9/8M74ntXVlInWzwZ0q1T7jFwHfpZUZan5sNX+KSg2QxcDIRJTADl6akvN1FTfY+QU+g6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIwHrwWdCQQSdq2U9O0/Ssi06JVnzNPLdHt25EqISulJNaPewD
	x6cBzbhXZB+7IHXHaD0mNh5t/OtIr6DwF5o9MIPq5KmDCGI5NRfMBxY5iFXl7dPw7BJNiKMO2ci
	poqLQ+GG3dC6ueEFKUfdVOCU/oGXhCVD7pf74+iPNasDa27x5IE8pW9C80tbYqCubWV4PLtDnYA
	==
X-Gm-Gg: ASbGnctNQZYqmCY7YSuz311r4ZSV1p589Xc0Fv5ftNRaNBNAiNtjfGzFsAyMwAODOjU
	+zGRCyRQ42wrm2u2NjN2JSu2/t9DTNwpaUop5rAZkiqQ+Q39hj5nJdAdbAshLPCIYtchcz8u0ke
	QF/j1SSUqmwfxIbh0jKmnhQVuZc2csJ3fh//xgQBH9BWHSGrOV4XrKjjJ6zyADTOlTVJXQ35vhF
	posyKW7FXqM+JenOBlLuq7fy2JB4hC0AZjZm8I1iTDeFwSPeFJPCp4piiNK3ehmjKecST6Xs0Hr
	i9zXzlgmqnvE2U8xR1kNcayDrNKezbGo44HHeHIhHfPCydqlQYH+LvywPuV/PI/z033QCQY2Pg=
	=
X-Received: by 2002:a17:902:e802:b0:21f:4aaf:60fa with SMTP id d9443c01a7336-21f4e7595c7mr12834355ad.38.1738877840971;
        Thu, 06 Feb 2025 13:37:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1x892Iv1IAr+zxejJwny+BJ000+ouOGHUAikBS3EHIAbcztyS84NEIkfqIGZ2mbl002x/Zg==
X-Received: by 2002:a17:902:e802:b0:21f:4aaf:60fa with SMTP id d9443c01a7336-21f4e7595c7mr12833965ad.38.1738877840575;
        Thu, 06 Feb 2025 13:37:20 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653ad8fsm17743325ad.61.2025.02.06.13.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 13:37:20 -0800 (PST)
Message-ID: <9759db76-c805-48df-a17b-b913c430b2b5@oss.qualcomm.com>
Date: Thu, 6 Feb 2025 13:37:18 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] wifi:ath11k/ath12k: refactor tx_arvif retrieval
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7bzATF3kWY8wS2y4lGJH2oDINFbtQQQY
X-Proofpoint-ORIG-GUID: 7bzATF3kWY8wS2y4lGJH2oDINFbtQQQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060169

On 2/3/2025 1:44 PM, Aloka Dixit wrote:
> MLO MBSSID series for cfg80211/mac80211, which is in review here 
> https://patchwork.kernel.org/project/linux-wireless/list/?series=902914&state=%2A&archive=both,
> changes the way transmitted profile data is stored for each link.
> As drivers currently retrieve 'arvif' for transmitted profile at
> multiple places, MLO MBSSID changes will becomes unnecessarily
> bloated with RCU operations for every retrieval. Refactor 'tx_arvif'
> to avoid this.
> 
> Additionally, fix an issue in ath11k_mac_update_vif_chan() where
> tx_arvif is not reset to NULL inside 'for' loop during each
> iteration.
> 
> v3: address comment from v2 and removed NULL check for
> vif->mbssid_tx_vif from patch #1.
> 
> v2: fixed kernel test robot error in patch 1/5 for tx_vif.
> https://lore.kernel.org/oe-kbuild-all/202501160626.Jbb3GHnk-lkp@intel.com
> 
> Aloka Dixit (5):
>   wifi: ath11k: refactor transmitted arvif retrieval
>   wifi: ath11k: pass tx arvif for MBSSID and EMA beacon generation
>   wifi: ath12k: refactor transmitted arvif retrieval
>   wifi: ath12k: pass tx arvif for MBSSID and EMA beacon generation
>   wifi: ath12k: pass BSSID index as input for EMA
> 
>  drivers/net/wireless/ath/ath11k/mac.c | 75 ++++++++++++-------------
>  drivers/net/wireless/ath/ath12k/mac.c | 81 +++++++++++++--------------
>  2 files changed, 76 insertions(+), 80 deletions(-)
> 
> 
> base-commit: 1ed13fdf7d8284742c8ede36dd553387839e5163
can you rebase? this has a conflict with:
    wifi: ath12k: fix handling of CSA offsets in beacon template command


