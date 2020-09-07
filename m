Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E06425F659
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 11:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgIGJV2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 05:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgIGJV1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 05:21:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19125C061573
        for <linux-wireless@vger.kernel.org>; Mon,  7 Sep 2020 02:21:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 5so7767652pgl.4
        for <linux-wireless@vger.kernel.org>; Mon, 07 Sep 2020 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ls8dcJi4qtOvCU2D4R5ImDJ/y6J5SG+OLOdy4QraSBc=;
        b=TILt43kzRglwwZpLkFHLnisaTmsNlo+61rHo1KS/nQri73+96CNUDQZTVwc7rSH+8D
         YHXds8iQaBrKVH2D7shNhefhNfH6Ai7PEYdiBE61QH7iBAhytr1M8sRIMJWcGuYl7FeK
         s/MXyaPfk7VVuDo9XOiJsBtFz1/0xaGqJhM/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ls8dcJi4qtOvCU2D4R5ImDJ/y6J5SG+OLOdy4QraSBc=;
        b=ARMYA2wO4wpizy7YW3MqfHIDVXLHLl2hpFBSdjavVboi0eGDdNpymAOBwnLel83D72
         0g61WM2DYXA8CiHDUpLF62S0XQWp9Yr/ZZxHKiOmdaha5psvHF4o/xQwLNvUz5wSXeGq
         0KZr1i0+mZr/e7nYKfE7RH3O5oHz0gn6Su8UdjJiz/bxDq1kbTdAyiJuvu2AiYtzb1hr
         GS37Q4W9bglvjYmBvQ+A+3Bitf5WLW9plLVEPs4dOhcpOj54TwHkqgcZBIEAFA+LxcUU
         Ei0+JCZDjagrZ9lrkN1+lRCr0LhiGfTiPjzOnBvcVn9Sv5zlOhW2hozhUTW1GGPNbkqz
         1eow==
X-Gm-Message-State: AOAM532YNyL8uWcYtD8/1/avhUlJHFuMpGu3vE/MhYFEQ7Up+hfUMX3j
        QOjMRBCd7Uv7Jqd1nf9CIyNXaQ==
X-Google-Smtp-Source: ABdhPJwCPzhAB3dh4Q9WnGb1ePX3p7XeXSrk5bqrBoCM3WabA7EzZYJaUYdyPBASfjCdLRIN6Enf/w==
X-Received: by 2002:aa7:8f03:: with SMTP id x3mr19608161pfr.256.1599470484062;
        Mon, 07 Sep 2020 02:21:24 -0700 (PDT)
Received: from [10.230.32.194] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id u27sm824337pgm.60.2020.09.07.02.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 02:21:23 -0700 (PDT)
Subject: Re: [PATCH 1/4] brcmfmac: add change_bss to support AP isolation
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        chi-hsien.lin@cypress.com
References: <20200901063237.15549-1-wright.feng@cypress.com>
 <20200901063237.15549-2-wright.feng@cypress.com>
 <0101017467cf4336-e8ed5107-762a-431d-9ef0-a2631dd090be-000000@us-west-2.amazonses.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <c90157f5-2c1a-1535-3453-450590857f74@broadcom.com>
Date:   Mon, 7 Sep 2020 11:21:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0101017467cf4336-e8ed5107-762a-431d-9ef0-a2631dd090be-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/7/2020 11:04 AM, Kalle Valo wrote:
> Wright Feng <wright.feng@cypress.com> writes:
> 
>> Hostap has a parameter "ap_isolate" which is used to prevent low-level
>> bridging of frames between associated stations in the BSS.
>> Regarding driver side, we add cfg80211 ops method change_bss to support
>> setting AP isolation if firmware has ap_isolate feature.
>>
>> Signed-off-by: Wright Feng <wright.feng@cypress.com>
>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
>> ---
>>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 23 +++++++++++++++++++
>>   .../broadcom/brcm80211/brcmfmac/feature.c     |  1 +
>>   .../broadcom/brcm80211/brcmfmac/feature.h     |  3 ++-
>>   3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> index 5d99771c3f64..7ef93cd66b2c 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> @@ -5425,6 +5425,26 @@ static int brcmf_cfg80211_del_pmk(struct wiphy *wiphy, struct net_device *dev,
>>   	return brcmf_set_pmk(ifp, NULL, 0);
>>   }
>>   
>> +static int
>> +brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
>> +			  struct bss_parameters *params)
>> +{
>> +	struct brcmf_if *ifp;
>> +	int ret = 0;
>> +	u32 ap_isolate;
>> +
>> +	brcmf_dbg(TRACE, "Enter\n");
>> +	ifp = netdev_priv(dev);
>> +	if (params->ap_isolate >= 0) {
>> +		ap_isolate = (u32)params->ap_isolate;
 >> +		ret = brcmf_fil_iovar_int_set(ifp, "ap_isolate", ap_isolate);
> 
> Is the cast to u32 really necessary? Please avoid casts as much as
> possible.

It seems to me. struct bss_parameters::ap_isolate is typed as int. It is 
passed to brcmf_fil_iovar_int_set() which requires a u32 (maybe function 
name is causing the confusion).

Regards,
Arend
