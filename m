Return-Path: <linux-wireless+bounces-23692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 248DBACDB77
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 11:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10AAA7A5A64
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 09:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB4228D85B;
	Wed,  4 Jun 2025 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OHJ4H7vc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CEA28C5A1
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749030900; cv=none; b=gltSSVIaZHOQoUeWx1nQn0Cw0BhsbgehCTOdqEG9SmnT01Q7NOewmqD5wZESFaWZxEVFS0uGXSW7FxpJ8Yc7fLoh++f5qpislOoufzTCwzkGVuj5QMf4aNuopQ4hjLzK1sO8NOUBm7LvCioF6eTFgYIAqBbVIxQE4prbVPH+uyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749030900; c=relaxed/simple;
	bh=miTFNxdINta7zyIhNKTv1lrUPzISl4z0AuxlHlBztWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ab4+9NlHQ4XGH4sCovLJ8CG7K5N+ayPzTcL0nmLcdhrztA1WPCpWhskvPTtW/8ZRitmmF6JqB2w8maN2BglMD5r3wBu8/QTQfZHhipSRursDNds3kgyRqYDL6M3BRTLg6f7ppZq/HLex3HyzoW8rW66CeQi/hlEidE4pqopxX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OHJ4H7vc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso8113518b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 02:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749030898; x=1749635698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VmiYvCf6fvZ2kv+WW1AEJh/PFIWU/Fzej214OLQXFGM=;
        b=OHJ4H7vcI8zC474G15RtSezQH9LBsj2PGVeKMmxMx44CkM+nMgHjNJldjgiIptoz02
         9wjvRv/0yesPXyOe34nn0GHPoOyQ/RZK4nAQMbHa8MOSQ2gBLBdfja58g1sFoUeBL3Ge
         /Y0N6/DjXunmHsUk+cwEVnn5AU39stJa6QzHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749030898; x=1749635698;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmiYvCf6fvZ2kv+WW1AEJh/PFIWU/Fzej214OLQXFGM=;
        b=ukS7kPUhs0wiAnuBTnaEX24jW0XS5GiKxYvtzl7QG+rF2ClfbZyI5BtLygEFKzb1Rx
         iGDQbuGuURu3V4yXMHmEPsnhh9azAkjixPd7M5MxKxLsHT9seOuH3nr8VVdC1Z7F42Yf
         5slZL1YPkDrPQGh3fhusP6PRK2y10PmWvUwvW7g6zbEoU8eb8MDkiX66wk0gWZ76KCop
         oyTu7DttFbJapItJwJv6Gn81JfLzH8sNLmX++fXZJluS9U9VL+MgtMVpJnEp1fv4HNfJ
         4Dx+WAP76IPwAYMUWn8XZ/ZGc+eOt1nALvKgjPW1yXVACIHmAPOSmw+9+DyvTiHbYd8V
         uaHA==
X-Gm-Message-State: AOJu0YxXMx+1jTNi3bcxJJzoNNhs09UnZz+wZqz0RMrsZZsT8Av0bZk1
	HbSpmLI1RE+/ISXhTjK3gwY/aa/2viFrDwYZjpicT3xiOUqH2q1ye26L0Q51irhY2g==
X-Gm-Gg: ASbGncvh+xEXXIMDCWi4p7dkg99BU6lBpd3lH0aocf2ujIhinmJnkyQ/pEadSsw8/7X
	90ysdDd+LxmgltDEtriFyWCXgwH47c0zET980+xqK3/061YoRvc0l8V3YUXh8baTF8/Px1NGagk
	70KvvJe9WBfsfGJGdVDMgCueB9bdgIiNpSIEWPa5Gk7j5q8Ep9hdizrYYKqg/z84DCMiyS2UIwW
	KrLD2+jUrpQAoGF6TBmOJ0qtS93/yxOiibelaQtfSaqr1PCWZxMB8s8gMj3OdmYBnvrjPDdP3ke
	fMGn/zVR+Vp4c2ARGC86B1bzx8Ep7wkrH7bYn8iTMkf/rtGQbK8pYU74bHwuGQUlkxFbNIBtnW2
	GYajgzfQQ3L2hiQ==
X-Google-Smtp-Source: AGHT+IFxr/oRZ9tIHAMChj9t8B3ahv4uHLP1BdXSx6YJaU5NxvFyTZT6b6RfsFkuRPWOxBqHBM+vag==
X-Received: by 2002:a05:6a20:9190:b0:21a:c058:9b8e with SMTP id adf61e73a8af0-21d22bcd433mr3856024637.34.1749030898622;
        Wed, 04 Jun 2025 02:54:58 -0700 (PDT)
Received: from [10.176.3.8] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb97068sm7292864a12.61.2025.06.04.02.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 02:54:58 -0700 (PDT)
Message-ID: <b6d38c35-e410-4ea6-94e0-b9f091976953@broadcom.com>
Date: Wed, 4 Jun 2025 11:54:53 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 3/4] wifi: brcmfmac: Improve the delay
 during scan
To: Ian Lin <ian.lin@infineon.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 carter.chen@infineon.com, double.lo@infineon.com,
 vinoth.sampath@infineon.com, gokulkumar.sivakumar@infineon.com
References: <20250604091629.3943-1-ian.lin@infineon.com>
 <20250604091629.3943-4-ian.lin@infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250604091629.3943-4-ian.lin@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/2025 11:16 AM, Ian Lin wrote:
> From: Kurt Lee <kurt.lee@cypress.com>
> 
> wpa_supplicant sends NL80211_CMD_GET_SURVEY command every time after
> normal scan, which causes brcmfmac surveying each channel again.
> Currently brcmfmac implments brcmf_cfg80211_dump_survey focusing on AP
> mode, thus this change will return the request other than AP mode.

I am not sure if the driver should make this kind of decision. If 
wpa_supplicant wants to invoke a survey after a scan than we should 
simply comply and give what wpa_supplicant what it requests for. If you 
want to avoid the survey make it a configuration option in 
wpa_supplicant.conf.

Regards,
Arend

> Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 +++
>   1 file changed, 3 insertions(+

