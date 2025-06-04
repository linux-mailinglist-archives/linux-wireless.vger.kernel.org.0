Return-Path: <linux-wireless+bounces-23714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A28ACE107
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 17:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E54161CCE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25535290D80;
	Wed,  4 Jun 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gEJmksqO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7F4AEE0
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749049994; cv=none; b=HBjAxvoVbCtSFpRLLiSuK7lGZ2paeK2+PLPvwkKEh+PnYDntUpY/f8FI1XN1TohJJo4VM34/sBSv1h+dooVO0WAkXSoH63e4GMU/yM/Upx+TCO/OWOmSwL3Z6BMpsk4nPBmTDscHufwHnY6EFT+hELEVSc1e1jTzzz4cmMMVmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749049994; c=relaxed/simple;
	bh=Jkg4Sb1yi9z1Gb0NqBm9B5OPkPNevX1GB97mXAV7ACU=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=OWt12TqOL1ZOMDnzkXDVGBB96EBWdJxx0n6dtIfmu5KWYCV2XKrODNFR5ZF97vZxQb5yuQgV3t+rsYo3wGHPvm3Diud5XzNBRVtLPNltDra+AB6BFtMadHX8cBIvf2t15ldfRTDMHQB6aK/L+WuJOFOj8YAzE39WBOEKm7f4FhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gEJmksqO; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad88d77314bso1243305766b.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749049990; x=1749654790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBhHEVAzu1DGyPLF74cPEKzyjc6HXkxZf9Iv8L5FMRk=;
        b=gEJmksqOhoXpqUna1sYbwZTo1xUgphZp/MaedJdCkz+Ct9XsCgTVCioiJ/rICY/ZM+
         +PZ9JfJrrtfN8Gr+PQiRosER1WCoyF5GHxEB/2Te/t3KCi+lZDxwKfOyT2Wc4eS/Uc55
         Yq9Ao2K0O5NCqJyo+iyPCgw8Z1f8J4JuSYHP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749049990; x=1749654790;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBhHEVAzu1DGyPLF74cPEKzyjc6HXkxZf9Iv8L5FMRk=;
        b=VuOof9nY9W8RRyKkmh9LVvtTfbIDaP613fTv3E8nWq4/aBegStw5IygUO52A2+DRvB
         wNjbNR+N+XG/+eP/OzbAn2hrEcq4+RfK/4SA1yU1F2YyFp3kP3Y5yEGJXRFL5cVp19XN
         Pez5Er75MqkEJVWf2dmhO5Cz168jXwemqklOP4ehta/9W1Dd/Cx6ngWBuz9qDI3kXjRh
         2cHF7kXWk+X+P+VeJQ032Sf5fNucVHGfqUJOzmpjTGSwo7DLY2koGt9Mu9cWxGfvkPkA
         t47tkxBAZxKVqP8mgpiboToszm/4lC2OwkSQPRasUuwbPU2L+/AzmGa7NJYk+6X+nUHG
         alPg==
X-Gm-Message-State: AOJu0Yz4V+DH0hbOgkaFusARXf1K9jPVxpGwe+D5l01+AeDORE1Gr/LT
	S2enImFrW/R8t/9aei8oWOqZ+jRo5dQwp1kZTj6U5g1dfd3gMW1RiV3cO1CmtrLdaXZurTbYCvN
	pS1O7rw==
X-Gm-Gg: ASbGncuK0H590CDuzLUhQLClqEX+8MN4nMMyxRBvAtJdSljDxzc5zVrOTm+XJ4QjyRb
	AY4HxbzYY9FrZ21vnGr1Wgrj1P0lH/SVfif+EWK/0S2uIeQzAOO6OTcOu8C/oJeiFUOZjPXzLbO
	2jcracaAFWfmUi0Ps11ibBv6Ld8ibzCuN3kc6dfelZeMqhu84DJiADmHx7nwnP2yHCaLM+Uoo0c
	hVcc2Z+MbE2uQ3Wh+FoNsesvmg7OkYtmQ35cBmtZYrXe8yZsktUxuFy4FRo/KdgrT6F3TOjxDvs
	2f4A9fwb20zoRumiYK8DrV4hgd4iuP3TOc9r6DrzFl8VCxV1vZoekf2jdR9n+xQCelRUUmOIZV6
	P9V2icDgbVykSbw==
X-Google-Smtp-Source: AGHT+IEukyRcd660AX9n+HGL2NC0mjBwTJqwLfG0dG1xakPQAh2GRGT7eHe+PUNnEDYkyWaBQ/DC/A==
X-Received: by 2002:a17:906:d7c5:b0:ade:5fb:53bd with SMTP id a640c23a62f3a-ade05fb54c4mr25062566b.20.1749049989591;
        Wed, 04 Jun 2025 08:13:09 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad396ecsm1100347366b.139.2025.06.04.08.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 08:13:09 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>
Date: Wed, 04 Jun 2025 17:13:09 +0200
Message-ID: <1973b80d788.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <926c66d7-91a6-4555-9c2e-6557400eb5ba@oss.qualcomm.com>
References: <20250604085539.2803896-1-arend.vanspriel@broadcom.com>
 <20250604085539.2803896-2-arend.vanspriel@broadcom.com>
 <926c66d7-91a6-4555-9c2e-6557400eb5ba@oss.qualcomm.com>
User-Agent: AquaMail/1.55.1 (build: 105501552)
Subject: Re: [RFC 1/4] wifi: nl80211: allow drivers to support subset of NL80211_CMD_SET_BSS
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On June 4, 2025 4:06:51 PM Jeff Johnson <jeff.johnson@oss.qualcomm.com> wrote:

> On 6/4/2025 1:55 AM, Arend van Spriel wrote:
>> @@ -2899,6 +2899,9 @@ enum nl80211_commands {
>> * APs Support". Drivers may set additional flags that they support
>> * in the kernel or device.
>> *
>> + * @NL80211_ATTR_BSS_PARAM: nested attribute used with %NL80211_CMD_GET_WIPHY
>> + * which indicates which BSS parameters can be modified.
>> + *
>
> Ideally this should describe what is contained in the nested attribute

Thanks, Jeff

Sure. Can add that info.

>
>
>> @@ -2996,6 +2996,40 @@ static int nl80211_send_wiphy(struct 
>> cfg80211_registered_device *rdev,
>> rdev->wiphy.ext_features))
>> goto nla_put_failure;
>>
>> + if (rdev->wiphy.bss_param_support) {
>> + struct nlattr *nested;
>> + u32 parsup = rdev->wiphy.bss_param_support;
>> +
>> + nested = nla_nest_start(msg, NL80211_ATTR_BSS_PARAM);
>> + if (!nested)
>> + goto nla_put_failure;
>> +
>> + if ((parsup & WIPHY_BSS_PARAM_CTS_PROT) &&
>> +    nla_put_flag(msg, NL80211_ATTR_BSS_CTS_PROT))
>> + goto nla_put_failure;
>> + if ((parsup & WIPHY_BSS_PARAM_SHORT_PREAMBLE) &&
>> +    nla_put_flag(msg, NL80211_ATTR_BSS_SHORT_PREAMBLE))
>> + goto nla_put_failure;
>> + if ((parsup & WIPHY_BSS_PARAM_SHORT_SLOT_TIME) &&
>> +    nla_put_flag(msg, NL80211_ATTR_BSS_SHORT_SLOT_TIME))
>> + goto nla_put_failure;
>> + if ((parsup & WIPHY_BSS_PARAM_BASIC_RATES) &&
>> +    nla_put_flag(msg, NL80211_ATTR_BSS_BASIC_RATES))
>> + goto nla_put_failure;
>> + if ((parsup & WIPHY_BSS_PARAM_AP_ISOLATE) &&
>> +    nla_put_flag(msg, NL80211_ATTR_AP_ISOLATE))
>> + goto nla_put_failure;
>> + if ((parsup & WIPHY_BSS_PARAM_HT_OPMODE) &&
>> +    nla_put_flag(msg, NL80211_ATTR_BSS_HT_OPMODE))
>> + goto nla_put_failure;
>> + if ((parsup & WIPHY_BSS_PARAM_P2P_CTWINDOW) &&
>> +    nla_put_flag(msg, NL80211_ATTR_P2P_CTWINDOW))
>> + goto nla_put_failure;
>> + if ((parsup & WIPHY_BSS_PARAM_P2P_OPPPS) &&
>> +    nla_put_flag(msg, NL80211_ATTR_P2P_OPPPS))
>> + goto nla_put_failure;
>> + nla_nest_end(msg, nested);
>
> I'm personally not a fan of (ab)using attribute ids in this manner. This means
> the receiver would need two different nla_parse policies, one that expects
> these to be NLA_FLAG when parsing the new attribute, along with the existing
> policy (such as the kernel's own nl80211_policy[NUM_NL80211_ATTR]) that is
> currently used when parsing the actual attributes.
>
> Does nl80211 have existing examples of using attribute ids like this?

Having two policies with the same attribute on receiving side would also 
rub my feathers. For the attributes used above we probably have other 
places where we use them from kernel to user-space. Clearly an oversight by 
me. Let me check.

Regards,
Arend
>



