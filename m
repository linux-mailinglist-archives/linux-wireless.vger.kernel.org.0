Return-Path: <linux-wireless+bounces-23708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA4FACE080
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E9318833AF
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1B29188A;
	Wed,  4 Jun 2025 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RhuO+SM5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C24290BD2
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047824; cv=none; b=kKn06ExD1rqwnrEILEY4dbdyQrI4iOoxtg1sOgTY4+aPxFaOlr6pf/9wgYhEaWDUAqvQICzIN94UVecSi39Fy8CoC6qiODYM29Q6NQYPxvCT2B6kikFDIgSqJk0fIL3aABWptT61oA7zKku4fof2Xabp+5k2dQvW7A2dpt39xAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047824; c=relaxed/simple;
	bh=D4uQnYO7eT0RiXF98lVoWDEX1Dju5FG9OaJV45xbPiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5eMRHsnUBdZlXPbIw8bTU3IuORrGR6XYqCejffzwzKaHbXwzHWdpHs5I6AUft7Frnqyte2DMZkJGLOXGojI4kMkwF851dw0szwsDS/pq0h4IVUZ7XS68oyE3B4vDTHmMX08P5k3FQu0XhPyp8h5ftbz5YgjjPHIrcjAz7lgqb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RhuO+SM5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5547YaWL028363
	for <linux-wireless@vger.kernel.org>; Wed, 4 Jun 2025 14:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1I0pTSJGbNdQ720pHeNjnDHHyYzMawbLnkg+0ptY05w=; b=RhuO+SM5YQvH9wme
	WMS+2yEdhxTVMVP3kgChYGOWZK1tykmfdPybUNgwe+iG4Opp8+3I1esayiO+Jj3T
	m1D+rhajUiWBuqVQr+nQZmQTqtYs6gDqm2z7vId1zhj/2fxwCZp6nlVLpEUo2agt
	nqi/AQGwnn47Wg7xsz1+pvBnLf+i+rdhXAqcfNEAeL27kLiUtcwj3uxNTqmBUZR7
	gguQECRc1+2gO9U6fzHUZJ/DYTOCwSmxdL80AzuUAhHSg3z9AGBPi1Pl41a1FvBx
	ztxWKrdeeLQ9w3uoomwOJ3Kmfo8eA3XpKMgqkUzO7dZ52OcucGQvVFXXw4VFWfLO
	q3beUA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8txd8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 14:37:01 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b26e0fee459so775439a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 07:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749047820; x=1749652620;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1I0pTSJGbNdQ720pHeNjnDHHyYzMawbLnkg+0ptY05w=;
        b=KFAE/RfGLvBwOPJBmGL2nXBu+kREyKoNxURDq/4rlzn0LPL8ubpT2/bJx5z8ZXY4x5
         nUWBWn7TBJ8aJugBFuCcV58JTUmItDk7hSAU+bvfj4qslDJ6xZtg6LM4GnIKqynrI40w
         9CNhoz7K4mpKKkwfHUvHodWacOycKqXSdvYAQYDmw5n288sUNcZgieO1l0ypszMh3wEn
         ovZjNF67U2P0TUB3QtRLQg8mqC5alIc83OigU40jSwuIdAnGLLnC6pqg/9byW6j91A7T
         3IcmkDiJKmMy1KolH4WWI3mHDYWDKdkhXpbWEZll8OKNEJp3FwxuR5i533oJ1xJB7kH3
         Acfg==
X-Gm-Message-State: AOJu0YwDJKseBhd1fRcFI/fs3dCPQEdv0F2N5RTyO/AnVQkBtiFnJb/w
	qza8I+Hlaw/LybHW8vZCz+JeGSahEvhxLYTksvG0w/i+8NVAo0GnMwxukqEoj7RSp5Db4YbyWAT
	1ml06S3LWgvuPnh9EeGo9WeM+G2PDcQ05OBq2MEyoZZdByUbJuqRpGDznZnC/ZfdU4rDBLA==
X-Gm-Gg: ASbGncu1FOEB/f1XeZz93EoxSAdgjc1h8RJ+DZQ2FyLcaOjthL2PvwwNDIJHp4sR9Qe
	P3FUOrIHip4nLklnIB5RZptGCnFHR1MVNu9fXDa6N/euHA/kdgpJOiv/0T/WIfMFh/YqTE7abES
	vXQ++OWC+A7sRZH4WN4XboNPlMX1hnDLomF5WLgggA+yy50tOmVDX1FmD5mJtkH65mf8eDdJo8d
	cLKwLnNL/wnXQW/52BTqHMCNTNjfpNVsOqeUDmH0lm+2/YarF3+Wvmv4rS8pwsuTppzXjc4tRG+
	jHFaW9rbGkJFd52Z5QqDYS9/Pc8zppztjXtS0A1cgeJpbCx3j6NohxqdrZIPa2LWKdo=
X-Received: by 2002:a17:90a:dfd0:b0:311:b5ac:6f7d with SMTP id 98e67ed59e1d1-3130db44b34mr4122837a91.6.1749047820328;
        Wed, 04 Jun 2025 07:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGde+Nfl8rFYASmgoSZK/FCW5irkGZrrIOIOrhaN9afSKb+U2epla4AQv0p4YnT/qFm0NFUyQ==
X-Received: by 2002:a17:90a:dfd0:b0:311:b5ac:6f7d with SMTP id 98e67ed59e1d1-3130db44b34mr4122803a91.6.1749047819545;
        Wed, 04 Jun 2025 07:36:59 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3d7aaasm9006591a91.48.2025.06.04.07.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 07:36:59 -0700 (PDT)
Message-ID: <c541e288-7859-4f50-a4a8-b7a6ee38cd99@oss.qualcomm.com>
Date: Wed, 4 Jun 2025 07:36:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/4] brcmfmac: support AP isolation to restrict reachability
 between stations
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
        Wright Feng <wright.feng@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
References: <20250604085539.2803896-1-arend.vanspriel@broadcom.com>
 <20250604085539.2803896-5-arend.vanspriel@broadcom.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250604085539.2803896-5-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rPkkp7jGAHDEkU5TBnTx_Xrb1mGz5WFg
X-Authority-Analysis: v=2.4 cv=Qspe3Uyd c=1 sm=1 tr=0 ts=68405a0d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=PW-KNzBFAAAA:8 a=bUQKSiCPAAAA:8
 a=Q-fNiiVtAAAA:8 a=ej4xoFaHywEyN7SLwwwA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=84zbTXrhsdUYOv-GFPQN:22 a=-fHZXUhsFbuwFN3fwQAr:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDExMCBTYWx0ZWRfX/3Y/nIHI1FvR
 /lEeqQCgEW5jIfnl6xsemx0+hRBxlp2Htxmt3bELecT15vwOWWWCppTBqW3ELw/DJ7yF1sbikna
 yEYAxu5WUZ8eJITJvTq+pxkRGbaTsb1Wb0nmQfCNQT47GPUS3FU9hrfYUW2FSZtVaPWoq6pyWYb
 SeAFeLqsBYBgfbfsc5C5s//QqjRYl59m9FRj/uoschfQGWBnSK6P4ctlSDhmi25MS/wHt2cl94w
 SDqL2as6JD0pHm5Gwn1hOwNtHokBX/rkiUqfyn73BCPafnDoQMg9bW71oAf1YWwLuB5bWywNLJE
 I1O2srwGoawNX6dBCM5oNwibWrOsZoZDWmsCJTcWNMNWeKOqvxZowfEaQwGH1Y0AAtJ++G9p9DT
 77Tysex5zDmBboVSWpZakOXi8SbGuAq0LFVdVkRd0oFFgI2vEwkn7pvW1gpSWfJoIpgHciQK
X-Proofpoint-ORIG-GUID: rPkkp7jGAHDEkU5TBnTx_Xrb1mGz5WFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040110

On 6/4/2025 1:55 AM, Arend van Spriel wrote:
> From: Wright Feng <wright.feng@cypress.com>
> 
> hostapd & wpa_supplicant userspace daemons exposes an AP mode specific
> config file parameter "ap_isolate" to the user, which is used to control
> low-level bridging of frames between the stations associated in the BSS.
> 
> In driver, handle this user setting in the newly defined cfg80211_ops
> function brcmf_cfg80211_change_bss() by enabling "ap_isolate" IOVAR in
> the firmware.
> 
> In AP mode, the "ap_isolate" value from the cfg80211 layer represents,
>  0 = allow low-level bridging of frames between associated stations
>  1 = restrict low-level bridging of frames to isolate associated stations
> -1 = do not change existing setting
> 
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> [arend: indicate ap_isolate support in struct wiphy::bss_param_support]
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index dc2383faddd1..d6c8ad7ebced 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -5933,6 +5933,26 @@ static int brcmf_cfg80211_del_pmk(struct wiphy *wiphy, struct net_device *dev,
>  	return brcmf_set_pmk(ifp, NULL, 0);
>  }
>  
> +static int brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
> +				     struct bss_parameters *params)
> +{
> +	struct brcmf_if *ifp = netdev_priv(dev);
> +	int ret = 0;
> +
> +	/* In AP mode, the "ap_isolate" value represents
> +	 *  0 = allow low-level bridging of frames between associated stations
> +	 *  1 = restrict low-level bridging of frames to isolate associated stations
> +	 * -1 = do not change existing setting
> +	 */
> +	if (params->ap_isolate >= 0) {
> +		ret = brcmf_fil_iovar_int_set(ifp, "ap_isolate", params->ap_isolate);
> +		if (ret < 0)
> +			brcmf_err("ap_isolate iovar failed: ret=%d\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
>  static struct cfg80211_ops brcmf_cfg80211_ops = {
>  	.add_virtual_intf = brcmf_cfg80211_add_iface,
>  	.del_virtual_intf = brcmf_cfg80211_del_iface,
> @@ -5980,6 +6000,7 @@ static struct cfg80211_ops brcmf_cfg80211_ops = {
>  	.update_connect_params = brcmf_cfg80211_update_conn_params,
>  	.set_pmk = brcmf_cfg80211_set_pmk,
>  	.del_pmk = brcmf_cfg80211_del_pmk,
> +	.change_bss = brcmf_cfg80211_change_bss,
>  };

So the real question is do we really *need* all of the other patches, or is it
OK for the driver to just process the one attribute it wants without
indicating that is the only attribute it handles to userspace? I know of one
out-of-tree cfg80211 driver that has only handled AP isolate for a long time,
and AFAIK there have not been any issues.

In other words, why isn't just the two diffs above enough to satisfy the need?

>  
>  struct cfg80211_ops *brcmf_cfg80211_get_ops(struct brcmf_mp_device *settings)
> @@ -7634,6 +7655,9 @@ static int brcmf_setup_wiphy(struct wiphy *wiphy, struct brcmf_if *ifp)
>  				    BIT(NL80211_BSS_SELECT_ATTR_BAND_PREF) |
>  				    BIT(NL80211_BSS_SELECT_ATTR_RSSI_ADJUST);
>  
> +
> +	wiphy->bss_param_support = WIPHY_BSS_PARAM_AP_ISOLATE;
> +
>  	wiphy->flags |= WIPHY_FLAG_NETNS_OK |
>  			WIPHY_FLAG_PS_ON_BY_DEFAULT |
>  			WIPHY_FLAG_HAVE_AP_SME |

Ultimately that out-of-tree driver I know so well would adopt this scheme if
it lands, but it currently support AP isolate without all of the other changes.

/jeff

