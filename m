Return-Path: <linux-wireless+bounces-19973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CCEA55D22
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 02:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2793018916A7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 01:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2593C1F95C;
	Fri,  7 Mar 2025 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZRUuckCF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BE125DF
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311155; cv=none; b=t1szJH8YY16T6P4xdQHJUD/8iaPgMxH9y4TiEF5f5QnFEBVpZYbweupYlgAGITE3n3A07UIhjX4axgnuIIZD+8yxmcAOsFAcx4ApY5Aa7mlEtrjYCseE5PM767b4eU2julEhy15/oyyPfNVG5B647cX2lPMMyWr5AAUuvtbRzyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311155; c=relaxed/simple;
	bh=LvoAzm7saTIAbqgSdoBGOdf56CF7B0m6V38fAaSkrBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQCx0W6UygCluT68vpg8wc5DvYXlvHtrUzh/pidwVgmfvNxiOkTyAUdOwswc/rI4ktiCTmc4Jsz6mbtRxo8OCWW6/HqtEkZgmXFymUxqrsGhnogup2S46VB3lT9FDH9IYN64kmyG8xOZfh4VCmsW/nWqarm303z2B2hkr/XeBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZRUuckCF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526Guoov007914
	for <linux-wireless@vger.kernel.org>; Fri, 7 Mar 2025 01:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	syyRb10z09Eikp3Tndp2++NQwaJlbrcrwerShvqZ0bQ=; b=ZRUuckCFXZI96S+N
	fywUK6UvjmmSgNGf3FVjApPiadKr+VJ/w3JZKEMu6lLCwyckfokjC00A/wj9rz1M
	30sIjnvTuEPugg/5rBLDgRbkdndBDs7ClwvGBTS9874zePWSrJa4zoH7yxmiRexE
	Ta/QJxTsQFUotirUN6tCB595UbtdQqm6Aj5bVCHwZHvDf+gK0vFuemfxdevZNDGp
	KzMyNQ/jHnAFIJsyTVMUcdksrNjJYvVZ4rNqkrtwutUz73r8imZqxtEJNIHuaWcN
	u3DoX1B7hU0ew39DmCob4Dsj6RKrWe2q10Vvh3FiyTPQ/v2atFoZCmR9114g2nP5
	X6KwEA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 457fns164a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 07 Mar 2025 01:32:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff62f96b10so2407285a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 17:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741311152; x=1741915952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syyRb10z09Eikp3Tndp2++NQwaJlbrcrwerShvqZ0bQ=;
        b=FOWogfURzRBBB9p8LQYgQYxnYn6+OByZAVFW/y8orceH164pFf2u6GfqkAlq1swYJI
         I89iBbPHThPYJm4Nv3ySnpvcXqsWfrkkxEgiUibFqObz9ca7n53TrHGt8LvVqX8lt9AO
         NdekQrAkvMvDjRthZUlA+9HwwP/KUULD2UgEEhoGuXjNGMmJUCZ9VniwJr7767R369uX
         /lajBALkGKhjM3NQ1rq4MV4T+dH6gRR8MwmQ/Lzj/bRSCqXy6RLAc2439CGAM7St57dn
         0jYuJ3ArYc6GW6jZizlcCtwuY58eGIuj7ULa/cSO8DaiaeMpGlqqSWDOcpagAam+wK59
         gkvw==
X-Gm-Message-State: AOJu0Yzw4c6nTWBjfH2+nV5h+17vtAc0VKpILAILbP4nG8ttKGk8N4A4
	niD1m22W+6oaSF0oBdzQ+PNvT0c6+NKefGYzwTPI1azIqTZ3gtGEVW56Esdi1eMiG7xyG98TeQl
	zWkEVJ93MALkKRbwPTBrYfDjvHLejIkxU2YCOXPzzAIMCtLmGBz5q3TyKXUdjs/2jiw==
X-Gm-Gg: ASbGncuAFr/QPLby5yFPrCWyD9eJgeJVWJ6WLiO0OXSm5B3g3TAEyb24BI1tYzVUZ98
	IBgnydG1SLEfrFwDzcmvuMhDDwwcJ8RLZvc4jbopvhlUFgiTEeBrQJHyavmXzDM9lWGTNiiReDb
	iUyfp5x57gWR27b+RPPYKYL2AWD+d2tTdvc7ER00+Mh05rUW0B9pv6JHHYsiXtcr7tN+VO+Ol+R
	5WapOkW80+DAB0M/af4W45i2ES8zgfR1rdAe0GVstvfrhnVtgRsiFE1bVy975WQAmjY6MP8Kxoe
	fhHcCNAUeOf63YkMzZ70MrSfC4zY1Rk3nKiBs0hZC8z+yTRRPIBUKqXQxVfuYSC4Oyib
X-Received: by 2002:a17:90b:4ac6:b0:2fa:9c9:20a3 with SMTP id 98e67ed59e1d1-2ff7b47f7d4mr3013156a91.0.1741311151841;
        Thu, 06 Mar 2025 17:32:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRPW8E5f3qMBULJgu0zSOWvmQtBOrFlmfl15OvzM45zCu4u7hPz9wHz3GjRsmuZfcQD2/9Jw==
X-Received: by 2002:a17:90b:4ac6:b0:2fa:9c9:20a3 with SMTP id 98e67ed59e1d1-2ff7b47f7d4mr3013119a91.0.1741311151491;
        Thu, 06 Mar 2025 17:32:31 -0800 (PST)
Received: from [10.227.106.66] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff6935339dsm1918534a91.15.2025.03.06.17.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 17:32:31 -0800 (PST)
Message-ID: <c24732e0-8e44-405c-bb36-f7d3f829e0a5@oss.qualcomm.com>
Date: Thu, 6 Mar 2025 17:32:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [wireless-next v2 1/2] wifi: mac80211: Create separate links for
 VLAN interfaces
Content-Language: en-GB
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20250307003740.1329351-1-muna.sinada@oss.qualcomm.com>
 <20250307003740.1329351-2-muna.sinada@oss.qualcomm.com>
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
In-Reply-To: <20250307003740.1329351-2-muna.sinada@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cccormDM c=1 sm=1 tr=0 ts=67ca4cb0 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=f7-QD4ZV3yC2cTXiZg0A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: GgpxXToAddbqQcD4pZ_eJMnn-K9d8IAW
X-Proofpoint-GUID: GgpxXToAddbqQcD4pZ_eJMnn-K9d8IAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_01,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 mlxlogscore=965 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070008



On 3/6/2025 4:37 PM, Muna Sinada wrote:
> Currently, MLD links for an AP_VLAN interface type is not fully
> supported.
> 
> Add allocation of separate links for each VLAN interface and copy
> chanctx and chandef of AP bss to VLAN where necessary. Separate
> links are created because for Dynamic VLAN each link will have its own
> default_multicast_key.
> 
> Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
> ---
> v2:
>  - move clearing links for AP_VLAN into seperate function:
>    ieee80211_apvlan_link_clear()
>  - remove use of goto
>  - replaced "master" terminalogy with "AP bss"
>  - update Author signoff to new email
> 

Please ignore this patchset. New rebased version coming soon. Muna

