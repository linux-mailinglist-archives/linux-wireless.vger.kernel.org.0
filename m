Return-Path: <linux-wireless+bounces-19916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804EAA54EB9
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 16:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1E53AEE4E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868E5199B8;
	Thu,  6 Mar 2025 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fpm6MY2I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC3D299
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274219; cv=none; b=cfgOSV+YX+TZKyRPzkr6LVfwL5I3xP0G6cpexbliuIwSsKXQdXKUkTpiHCpH88FWNmztlTaU8UcHqfzo7cF2+mYTJitZV1sAXCNBAnx9cREvj+LzsIYaOa1PcpPcKR6wxIRwYLYgVZAR5D85+Zg5ixHLQtP7IWhj62jT72aH3qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274219; c=relaxed/simple;
	bh=tedjru8cDjpmN7DoMv851IR5BNSLafk+zGks4yef/LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/C98OOPSpJ6QkjKj7v+ubqg2BPgPjicUtxskfCMn76uy9//tOP6M/Q6eS59wNWBk02xVGAHm2W9o1Fma1EAf4T38NbYDFhIEsplFjbuqsCkqPIQutwBR3P0vxLmc/p4TlLZpSFwr0t3Ej+8GTJJhGCdalnC5wkI9g14kQGebLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fpm6MY2I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526915a8008332
	for <linux-wireless@vger.kernel.org>; Thu, 6 Mar 2025 15:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6NrNV60kruSz/Q/BffVmnWWUliwXR/DPBiFbGL065Yg=; b=fpm6MY2IjkyIP8Wk
	4kY8Ll4+eF71XlSApLOa0T+wRFk/egtiRyiLKNCbh48uU2LlxRL8EIVJn+Bq2ldQ
	DxTd61H/CenySFWA9v41My0qEdYsjIXh32zDgR7rWppBmo8dLDY62qbxMHjFts8T
	dq9H6lhNQG4h0u/noEg+uzsZDe1kqQ3P6pLcDhNBZAgTKfnRvdaJ42rvjUrN48X1
	kzB8AN+i6qjzXumDllfG3EifF38t0MT+wxalkC31gQOpybIfCFnA2JoydmSD5sqD
	6pZNNIZRXzp6LHkZ1nZQ22YaNlYe+tNV3tHb6HLsFA+283Bu5XbjTg1TuWbFUnuj
	87T4YQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tsgnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 15:16:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22368a8979cso14272335ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 07:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741274215; x=1741879015;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NrNV60kruSz/Q/BffVmnWWUliwXR/DPBiFbGL065Yg=;
        b=WH0LFpaIo3dOrcm7M0J3zlm10QMtV0waRYjJtpK82F87skUIi93jIkUscQFOuRAUse
         GSo7bYWKsWvz2mBngwIHGpfEWLgQ2kVoDjhOceqb4pJc6YZL1XbBLqEp2h+ROrKxwoGg
         vbJiZkQZNP95lFOgttxi7mncqC50OCMeBd6/XFzJcABGIV+sRKrE5tZUVC9hH8vDUsaq
         gi4H2j4QY2lYpMzt2HlYDxSa7Eqx01kSogq2zjeWyjeTSJX9MM5SnYK6p/varVD3tDb9
         UWslfDKTbwqk2+HBiG5tFICmoDQnoQoJCVbsV22bYE7hXcHCnBqejnn34V7PK2c/xen3
         W8aw==
X-Gm-Message-State: AOJu0YwCfC7eTD39hx0KZh3z2Jp5NPckqwzORbDNhvFTQg/oyDqKfJxw
	leQdxKpOI1whLr9a2YQ9GLhnr7iklFhvPIHpsQY7AezZCFaNJ9lmBF/90rGlxsm55ckHQ/pmZoh
	0TQM8L+xbRE65lSqRg7aU36tgaLDE5EUvpTmzkQWRnawUeWMZsEiVL8vqsekxXy014Q==
X-Gm-Gg: ASbGncue3gujniXsI3OYS7LwoaJwe9mq+P0w9NQaRFKV/jPicSZUdtp8isE2fRDpBLo
	+9gfTgBZ+pf0Moe4YBoe7A37UEx5z/r/UPFUzT1XC7ma326uRc7rsBDXsHHxT/WkZojXzMW1ceF
	+L7VcYX7VvxFKmMUxbhex1lwY2FO1fzcIVIBFEOia7m7zBgfgm7JB/NBk0f2lEhwc9U5qpRID+k
	V+NIQsAwlLXtTKhJ9ErJXXJaEwLeX/z5m/gkLvVkT5ZiYpiA3oR73EYwI6K2O5DShEWijXqiaU+
	t0C+LU5eEyFGqlwTA/VzLC3Os4FbyFpom234mNVIvpeKT/R/fZQQmliX9J9QR/oY6ggYSVEKJHA
	Xwl9P2uDZ
X-Received: by 2002:a17:902:ea10:b0:220:d79f:60f1 with SMTP id d9443c01a7336-223f1cf31ffmr123668055ad.42.1741274214969;
        Thu, 06 Mar 2025 07:16:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAlepsOa00MM5EgvkYBfNq/xlERGdkdf2DFldElqkC5C/IIph2E2eA5BlXDXhSmqN734MNZQ==
X-Received: by 2002:a17:902:ea10:b0:220:d79f:60f1 with SMTP id d9443c01a7336-223f1cf31ffmr123667635ad.42.1741274214573;
        Thu, 06 Mar 2025 07:16:54 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddbf2sm13505765ad.18.2025.03.06.07.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 07:16:54 -0800 (PST)
Message-ID: <97868f22-71ba-40fc-9586-0693e4627f2a@oss.qualcomm.com>
Date: Thu, 6 Mar 2025 07:16:53 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 15/15] wifi: mac80211: set WMM in ML
 reconfiguration
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
 <20250306124057.2b473bffdbcb.I362c3101d3f523a8db37c16cd7b5f573d76a36e6@changeid>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250306124057.2b473bffdbcb.I362c3101d3f523a8db37c16cd7b5f573d76a36e6@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HZbuTjE8 c=1 sm=1 tr=0 ts=67c9bc68 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=QyXUC8HyAAAA:8 a=Ea4-1DG7U-CfBJmvuZ0A:9 a=QEXdDO2ut3YA:10
 a=GQT5ValzTsdgqRVf67lT:22 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: olK66q9d-YizZkzyGVo6h4Yt4aar55wZ
X-Proofpoint-ORIG-GUID: olK66q9d-YizZkzyGVo6h4Yt4aar55wZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060116

On 3/6/2025 2:43 AM, Miri Korenblit wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> In the per-STA profiles for added links in multi-link reconfiguration
> the WMM element should be included. Fix that.
> dfjhds

s/dfjhds//

> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---
>  net/mac80211/mlme.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 94d9d9ca42fe..bfd3653a5b84 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -10435,6 +10435,7 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
>  			return -ENOMEM;
>  
>  		data->assoc_link_id = -1;
> +		data->wmm = true;
>  
>  		uapsd_supported = true;
>  		ieee80211_ml_reconf_selectors(userspace_selectors);


