Return-Path: <linux-wireless+bounces-26973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0AB423BB
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 16:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CCFD16CDD5
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF97818C31;
	Wed,  3 Sep 2025 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QQgEn8Yr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398F1E260C
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909837; cv=none; b=FjFPwqItQH7WEoQZVYfvU2JC1d1U+syfdJ7Obfpaa4/9cTI98MisvrfgsTmau5G//jQmsPx8iLE1KY1bgSgfIlc2Z4iA2MxKfuNf/e4LK1pcpGAv/hfjR915wqWTeDjB4Cg3nfyx+xeaHp/CB9hRfGGZPOe74XE4CJ33I+ZcPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909837; c=relaxed/simple;
	bh=l+fIz049lZPy0hOp9jndh/f3OEN+BNw4PTwGJEIqPEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WrVtx1rDmIZ9mN2qEO5odzht3937XZeezcowX+pmEahfL+FHOgzeNLRG0mCpgmiIeNLzpf8N30+QSY0IPnDfumFhJYrnPxlPYzJbiYXKXVW67pKjnJl3vLisVPoBX6wyshxAXLO7uidQk5mTM6JP1DZEikTBk0GYPF+PFi7uGbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QQgEn8Yr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DwqeP005254
	for <linux-wireless@vger.kernel.org>; Wed, 3 Sep 2025 14:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yt+Ci0JYYBrzneYM13iKlC92ItJia5emASCt3Y8qTXQ=; b=QQgEn8YrT6OPpIBN
	/3hFtSNAQJH+Ymj8k+YYLVphIePhwHYP8ITc6Yk4mwrLaSyWOX3BocOxKePpgKhJ
	q3r31bQw0LqszAindp0zojlD1DDSk+pxlWBaBKAMGJspre3MraSIMAu7Qv93XcGy
	65/xlTY8w3gblZ+RdsDyZZ5VH4zkxgaPTI8j6gtBX1p2FLbsDwgsLZXZpW1LHr2H
	098uM4pBtj4+B1DiySc9x/8+hv0QfTPho1D9gEeG9R6MLUpELzdi8hDR2VAlvTsd
	67Iuj9rVvYKiQxJ1Hk7W62Iea3dhQxjNdMotQ/XpiXPrOVYEfJPBCwrfMeA8/XcJ
	OfXLDA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjky4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 03 Sep 2025 14:30:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32811874948so4008745a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Sep 2025 07:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756909834; x=1757514634;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yt+Ci0JYYBrzneYM13iKlC92ItJia5emASCt3Y8qTXQ=;
        b=c9MfZS0rGL/314jnFKR6rcF7ilU8OaA1ehJ5BK1Bu4ztTRHmwyHHJBS0WlukWw+4+P
         1C1igN6fPKpAA0VEGuXg3K0CBQoTUu8YGH7x3VPY63kmeCiZ8MsYHUYIdl1Rjji3Yizn
         C2jWaRaatpxyRM86eWHPohrwCBcZzIWcV7xs1oG8uUMJeBRYhvJCxrHtPveZsVs8A0Oq
         5Bcf6BiKWyRY3rgVH3R5iiEwr/b1s5yW+lUn/Dffot3I1aYyXuDyXE980haqg/Aq/qrm
         RUu5VLDLChNom2lRZn9if4vpBS1AdOV6KmlNdyCkBA8Pn/+Tr/Td3tyCKpmuWQ3ZGAYD
         C+Lg==
X-Gm-Message-State: AOJu0YzKSJ9MxETZH03iofED3dEt64okyvipbyokBX0They/zRXYGumc
	Fi011pgBCgZS7Gn3JF2IcxcuN99sh9lz7kV9azp4zcIvI6xakP65gE1KYzGZtaR/Kx4C/WOSOYb
	ylwBqBo/IBbxAzbc8jWo6yhqvGieOSXbtT3W5681Len/zAQrK+Ag9jriEh5DFwxzUKF9QPbjHfp
	CE3Q==
X-Gm-Gg: ASbGnctrBU5k6epDnyV11AA4dndpl19/GQxRKvMNcxhQikrvXYXMdMBg1+FQjqbOJKq
	uARtYu1lQQY/Iu95ZAfXIEHdPEwqLznCdCuppvKDCKwNrcb+ZOqln0RvhV4tfbawX/1bdK9xKga
	JkhJan/Q3Q/hXLc/EhJ8j8HOTQehv4f7StOyv97FZrbUKpCTFmyOWb4exlvL0fY0erQ1uc3hW0p
	DmOkbYAEvZz0qv0twCWGJuOWn8n8DrjFvGLyGiFUImmfhW82SE4IcbnIQZBPtbKlcAUHK1TWDmN
	6hGXq0f80q4ngIrBT6sbLsKcZ/j0+Bey0dfvAciFG07xD5ARDSrs3hfHYOu9lke+vJjnOsL86Zp
	pp7J6ARRJG947Je5TlpQCnjEl
X-Received: by 2002:a17:90b:3d46:b0:329:d09b:a3eb with SMTP id 98e67ed59e1d1-329d09ba59amr9656986a91.3.1756909833194;
        Wed, 03 Sep 2025 07:30:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHINP4MgdlOjZYe0WRKqqYh49LQAy0bMlsZvSa2qRGyEKE7757cw99S8lSP/doWsQ5AKf4g5A==
X-Received: by 2002:a17:90b:3d46:b0:329:d09b:a3eb with SMTP id 98e67ed59e1d1-329d09ba59amr9656921a91.3.1756909832406;
        Wed, 03 Sep 2025 07:30:32 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32787c455b8sm12138848a91.1.2025.09.03.07.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 07:30:31 -0700 (PDT)
Message-ID: <a9b0bdf6-f445-4937-bd17-91880438ce01@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 07:30:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 2/2] wifi: mac80211: reduce the scope of
 rts_threshold
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
References: <20250903083904.1972284-1-miriam.rachel.korenblit@intel.com>
 <20250903083904.1972284-3-miriam.rachel.korenblit@intel.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250903083904.1972284-3-miriam.rachel.korenblit@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b8510b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=QyXUC8HyAAAA:8 a=l56fNLfAirrI99EgS2EA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: hzvCCIHBMNoPZYAvj5xp3u28ohF8e6w2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX2MuzrlVVYQFE
 j0i8VvD7WQwJoH2hqzxlNYZLlObVhNfu74cJkDfDae6j5XvYK/nDlLqJ1iBd/YFv9C3Zy3PhGpY
 kvg8K2/GS3bBnwvQgMD776nqBxfJmfod9xvzPzW9qAIchVSdOIjOSBLPoy6yGeWVdTRlO0cO649
 3EvtPUinrKkeXB0S0qsWdhgM8yGSSLQpVh1HJk4lc5sGE/ahlewu7s96m8OHVkFo5sR5pX/FBtM
 bKDQF9QiMQbBx3rubWl6enknQ1io8uTwOXZUZ3vm4+Wvk8KW82wd/U9cZv7k8hChbsB7dAyfK1H
 91c3Rf3isViHkQVBGfcbgew4wiYp9iwWoxCrAsU/MM42nSMeGZVfY8h53EfXxQD82uvjt115KyQ
 DNsFf5RI
X-Proofpoint-ORIG-GUID: hzvCCIHBMNoPZYAvj5xp3u28ohF8e6w2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On 9/3/2025 1:39 AM, Miri Korenblit wrote:
> This is only needed within the 'if' scope, not in the function scope.
> 
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---
>  net/mac80211/util.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 32f1bc5908c5..b56941a70754 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -1756,7 +1756,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
>  	bool sched_scan_stopped = false;
>  	bool suspended = local->suspended;
>  	bool in_reconfig = false;
> -	u32 rts_threshold;
>  
>  	lockdep_assert_wiphy(local->hw.wiphy);
>  
> @@ -1832,7 +1831,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
>  	/* setup RTS threshold */
>  	if (hw->wiphy->n_radio > 0) {
>  		for (i = 0; i < hw->wiphy->n_radio; i++) {
> -			rts_threshold = hw->wiphy->radio_cfg[i].rts_threshold;
> +			u32 rts_threshold =
> +				hw->wiphy->radio_cfg[i].rts_threshold;
> +
>  			drv_set_rts_threshold(local, i, rts_threshold);
>  		}
>  	} else {

Johannes, is this your preference for wireless?

Kalle had a preference for defining all local variables at the beginning of
functions, so that is a position I've been continuing even though my
preference is to limit the scope.

/jeff

