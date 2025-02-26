Return-Path: <linux-wireless+bounces-19498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A287EA469B9
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 19:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83744188626B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 18:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0426236431;
	Wed, 26 Feb 2025 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JLe3SLeF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F342236437
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594274; cv=none; b=CK9EzIQnC8d8dEnMGw6FJQqjxWIF8iXuGWGpEMQMYeRnO8Zj0dDB0X5b/kj2wq8FpDd6+SiVIFEARWWZkovu3r0uNxV6RpCiabFKCdeQFAUbufedN1DV2bAIaI0evEP8XLAutQIm3PRudD6rJg5RPfPlXiuNnXmVNLMIVHuG2Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594274; c=relaxed/simple;
	bh=XIhbSxmFNC06Fw0F0MmY5lISyJyBHN1U2mbuG3okezc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ga9rDEiu6w4SqHfJT1Mk6R5dEJvJ3tW/W2k1Q6w6JoJNhOOVPgFR+JfPPg6nq1bo3zlVFXLaKLizWEecK36Ekw2TKMiOYZiArUUtHkUdNksDdHIMYLs6HK/Hy23joFP31CXjlyLPa0U+yKgWmURcnA4kVojsjxYBB2yXkbXAkX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JLe3SLeF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q95dOK021539
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 18:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dSOmk94mQw1ShmCt0TopglfVX9iuuh6aJXS51Z1wShI=; b=JLe3SLeFzkLYAN6B
	ul3TDuNLn/PmeD+FTI6f7Fg0XFJpKAIYHaK3n6vIYvl7Fe11/Wv/+r+0OvfXT+wB
	6xOcBFTF6locIbRFKtnnJp2DMSeBTCsoXfD2DWeaEhY7rD19x67dv3SMzmNlaOM7
	3C4Tq6/J2gU1aDZVk9/XLKM03GU9WFXpUYXGnH/CZfLDoexoxJnC36CA5SPRXIcn
	SlxzKml3Gt5pY/eBqZINUEbLwzn/BymZQD6libsTOjAZNe4GN/NHGK9Tuar+vCvc
	xP90yKeN7bZdDXvTp+h0j5ntrSnm+torgp6BKvGGtmZES9VABdcs+Id5XuRCN0Cg
	yA8QFg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prkjxcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 18:24:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-220f0382404so845565ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 10:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594271; x=1741199071;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSOmk94mQw1ShmCt0TopglfVX9iuuh6aJXS51Z1wShI=;
        b=brLkYIzUIoVNuGqQjq4Em+bB4kwe0S6iLr9Ks4YzUpQDFrMGk+sYZ1Rmif1LKLYdov
         954p1liYvAcvPNlginnJK8u6v7sQcpmaBF0mbzDc/me0tIYNrYunGuIc7RM9PEMtnOiD
         e1mOot97PMR7U5c+pcEd7rwuV7ru6YAboew2prD7l4VB+jxHWE2HqaMaPiXbxHV3BGXn
         rExl4EYBKMmlg3KSX0QCVDxFCTwtH93MNIxrAB1GIY5qwou7ZAykaa8jtIUURWyCok9Z
         0EZylD2BVwOjzV/mrSSCZp8MIsf3dTpsL4VzGVPy3l7580HQ2hA3PnTmcF+5bFpnfESs
         W6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIjIchlVtFifWOk3R55wEHuQt3hWXbiA0XfjKMopUG8Yw90YAkxoQlIlMEwZ72SG2nW7QoeADfydZxMjJo0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAMy5F8LHdBcq99BTIG+gpJmQs7S8SmfSI4X9ls8is5tF4XiPT
	aGWjvafc4Hw8qYpBkzPDF53r7XvJK/6XvIl/RuW2XBOmW8aOnBBF+r2Rlu66/0KaJ9DGDObejzR
	TzbShWFtEBG90NKt4cet7FFHgOdsanm9gmE2Ok0xq5Nz5VaUTfzKu0nMxDJfHnEbASg==
X-Gm-Gg: ASbGncuEUZAE/9SWZiWLPz9tkmjiKInsLX/L8AA4MQAY7eIjD/sdDWnOYhlyVX/01MA
	1dBVMGDBU64iWbqNihwBZ/RKnwbyjftK0TJoKldFtY71eJVJNd2qGp2z2whPeDolePWmJS3e27U
	OFwd0yiHvRS0/vsV5xQZjqGgRyckXmyx67A7LnhkE0YcWCidTSS4eZ6HxCVVYXDirZZbdBM6PSa
	KttBXoh3OZ5OCwnhvYsmuFsH5aoCf3/JEVGcH7lWAm5Jy8M2q0nohW+Te8JZvZqGCUWmAGgL8v1
	8VAp5FUJLtr3+AG0aJnKmzovWydN+338Qr7riMx5G0O4EbJa1yaaV7sEOmDFNYLOu7foaaw=
X-Received: by 2002:a05:6a00:44c3:b0:730:75b1:720c with SMTP id d2e1a72fcca58-7348be4df71mr6941971b3a.23.1740594271080;
        Wed, 26 Feb 2025 10:24:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZQ/juNnfrSZXE67q7aPuo5Gwg8ro6WfpXnZq+xYbpraggzoidGmirzoKYAxvis/4TA8MKJw==
X-Received: by 2002:a05:6a00:44c3:b0:730:75b1:720c with SMTP id d2e1a72fcca58-7348be4df71mr6941817b3a.23.1740594269112;
        Wed, 26 Feb 2025 10:24:29 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81c589sm3931818b3a.135.2025.02.26.10.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 10:24:28 -0800 (PST)
Message-ID: <9dd0dd35-5e73-490d-adef-cd45a74a8133@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 10:24:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: remove debugfs dir for virtual monitor
To: Alexander Wetzel <Alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>
References: <20250204164240.370153-1-Alexander@wetzel-home.de>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250204164240.370153-1-Alexander@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1eCsqg9fOlzgsk2Yv7880aDmM_NXS2PR
X-Proofpoint-ORIG-GUID: 1eCsqg9fOlzgsk2Yv7880aDmM_NXS2PR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260145

On 2/4/2025 8:42 AM, Alexander Wetzel wrote:
> Don't call ieee80211_debugfs_recreate_netdev() for virtual monitor
> interface when deleting it.
> 
> The virtual monitor interface shouldn't have debugfs entries and trying
> to update them will *create* them on deletion.
> 
> And when the virtual monitor interface is created/destroyed multiple
> times we'll get warnings about debugfs name conflicts.
> 
> Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
> ---
> That was a bit more tricky than expected:
> 
> local->monitor_sdata is normally already deleted when we call
> drv_remove_interface. And we can't simply skip the call for all monitor
> interfaces...
> 
> And one additional remark:
> My iwlmvm card is not taking it well when I bring down the monitor interface
> while TXing on it. The firmware crashes for my "Alder Lake-S PCH CNVi WiFi"
> card.
> 
> But that also happens with unpatched kernels and so I don't care
> much about that. I can make a bug report, if that's news and want you to
> look into that.
> 
> Alexander
> ---
>  net/mac80211/driver-ops.c | 10 ++++++++--
>  net/mac80211/iface.c      | 11 ++++++-----
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
> index 299d38e9e863..2fc60e1e77a5 100644
> --- a/net/mac80211/driver-ops.c
> +++ b/net/mac80211/driver-ops.c
> @@ -116,8 +116,14 @@ void drv_remove_interface(struct ieee80211_local *local,
>  
>  	sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
>  
> -	/* Remove driver debugfs entries */
> -	ieee80211_debugfs_recreate_netdev(sdata, sdata->vif.valid_links);
> +	/*
> +	 * Remove driver debugfs entries.
> +	 * The virtual monitor interface doesn't get a debugfs
> +	 * entry, so it's exempt here.
> +	 */
> +	if (sdata != local->monitor_sdata)
> +		ieee80211_debugfs_recreate_netdev(sdata,
> +						  sdata->vif.valid_links);

With make W=1 C=1 I'm seeing the following which I think is a result of this
patch:

net/mac80211/driver-ops.c:124:19: error: incompatible types in comparison expression (different address spaces):
net/mac80211/driver-ops.c:124:19:    struct ieee80211_sub_if_data *
net/mac80211/driver-ops.c:124:19:    struct ieee80211_sub_if_data [noderef] __rcu *



