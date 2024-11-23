Return-Path: <linux-wireless+bounces-15617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC50A9D6881
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Nov 2024 10:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CA6281E38
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Nov 2024 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1125516FF44;
	Sat, 23 Nov 2024 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qw84sjbr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF115FD01
	for <linux-wireless@vger.kernel.org>; Sat, 23 Nov 2024 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732355501; cv=none; b=CdoSK5R9XNGmu2mDzln4q6rHIyz6pouviyCN17xeV//NGGJkIy4hMVA3pae2ILUt9aWYVVUJgkDCoioqse3E3ARv46yfrNSiGlZqzzDAJ2+/iUXAS+DaMLIUu1FodzQALN38K0LpqrNpMI4EB1gBQScAQ2AsuWoElCld0JUILSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732355501; c=relaxed/simple;
	bh=5mFgvHfxxqyIok4KkeF5i1Dm8sfAGAB7oh8z6PGyMtk=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RPc6rNjZI9MA+TIDslWpVxrUUBtR/nN6zAEYU/DamPgIc6H6foPq8E8voMX7xGmDiwj3ZnV5+TZscoMKlyEDCCNIT+anNIvFdU7KgApce6F6tytLfjwP4jCyy6zXig554CxoAeAkhb/OJP6GrRYoM2R09BGFMWvISLQHnZU7vEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qw84sjbr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa20c733e92so345943666b.0
        for <linux-wireless@vger.kernel.org>; Sat, 23 Nov 2024 01:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732355495; x=1732960295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2He4Y+3l6zjnzsCvPiyzHE8Ux0qLZfdpjc2IjiyYS9Q=;
        b=Qw84sjbrYsHpizdtgyilRz7xUzWByLC4QIvYxWJ7ob8+TX3s0ZasARIAc5ljkw+ibu
         pymgE9MmpH2OwaZz3//h5lbq8CgCQaYFVz3rziT3qwtU0sgqBWK/WPZ4vl2rylADg6Am
         CG1x3sX5NiVAhQPQWIJ9eXcvlEvrB1l736KTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732355495; x=1732960295;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2He4Y+3l6zjnzsCvPiyzHE8Ux0qLZfdpjc2IjiyYS9Q=;
        b=QmSIb31eBqMte584rrZWOzSQuR+I/QPqqzevUEIA5tq1Jb6zT1UaGvZW4WvQyrhUF4
         cLGNIEEzHCBGEs1xwKGN4pyIk/H6aAl7N/OEdAz2vKZxgkrH6zAc5RpmVeq2PJkj8oRj
         M+EIiNuSDcqyJ80ngqX5+KH6epVQNo3qbszS+7m9jYHX5B+pDWk1F7NaaxNKTioB7HbU
         umIJeILH1uMZ9tN/Xf0uvxQFU23V2p15yWSkww9UDUsm5jN27Nsq/Vr1dWah4fV7Tyc4
         JkfJGkF02v9wydJVEMja1cDI+NHRxT58jobierusGZDMJ+382WwlI3KhhpbdjxNdOtrc
         qqvg==
X-Gm-Message-State: AOJu0Yy5i0OSR7HIFakYs83Xg+meSUs0/LouhtppAprDVl+rPRfB57XI
	rR7BeEvZose8arA+CH7sukkM7bC7OlSwIcWzJFwuescYAja0QVAJGX9oI/38wg==
X-Gm-Gg: ASbGnctJBJd9G0QSZalQSoXfg47sWp5got4C38Ho/ZPPtDCpaE5sKPyMHQcEcUsaa5V
	VxlM7roTAVlVlnTOa7Msl88CjksxR0Ha3e44WDV9WArYpdIC/bGJqoAcjygFgKKt+2S2NJCn0yn
	723fUXW0M6EGIifx2ngc8O9NhCZgmbAI/BHG9+w1+a6F5YEyIFdkFRIU0uMS8d9SomxWcLv5zjt
	CdYzB5FKvHKj1SyiTkClo4RxBle75cCSdPwfXiN8uX5tsePRBk3YgluYwKvsCJjp4gdn9GOhILI
	184LDH2RwXOQ
X-Google-Smtp-Source: AGHT+IFq7oIJo3gucR1f2TVQm30JKlJTgPGnpog1fqvObzxkCV1gj1+y+gfxLL9E/8hQlX2VlIl+uQ==
X-Received: by 2002:a17:906:bfea:b0:a9a:684e:9a64 with SMTP id a640c23a62f3a-aa509e94d2emr437231166b.61.1732355495522;
        Sat, 23 Nov 2024 01:51:35 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fa20sm202775966b.113.2024.11.23.01.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 01:51:35 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Stefan Wahren <wahrenst@gmx.net>, Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel <aspriel@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <brcm80211-dev-list.pdl@broadcom.com>, <SHA-cyfmac-dev-list@infineon.com>, Kalle Valo <kvalo@kernel.org>, "linux-mmc" <linux-mmc@vger.kernel.org>
Date: Sat, 23 Nov 2024 10:51:35 +0100
Message-ID: <193586f1458.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <a122ad79-086b-42a9-894e-d589092bac80@gmx.net>
References: <a825587c-e6f6-45f8-8ac0-a1a5642a5333@gmx.net>
 <16169285-d838-46f3-8be1-3639f573062e@broadcom.com>
 <86ef2465-3b5c-47c8-9e81-ad5b545bcfe4@gmx.net>
 <89888eab44b7b431ac7fedcd573db325e07b935d.camel@sipsolutions.net>
 <a122ad79-086b-42a9-894e-d589092bac80@gmx.net>
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: brcmfmac: error messages while entering suspend
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On November 4, 2024 9:06:04 PM Stefan Wahren <wahrenst@gmx.net> wrote:

> Hi,
>
> Am 04.11.24 um 13:18 schrieb Johannes Berg:
>> On Mon, 2024-11-04 at 12:59 +0100, Stefan Wahren wrote:
>>>>> [  384.292071] ieee80211 phy0: brcmf_fil_cmd_data: bus is down. we have
>>>>> nothing to do.
>>>>> [  384.292079] ieee80211 phy0: brcmf_cfg80211_get_tx_power: error (-5)
>>>>>
>>>>> These errors are not new and I assume they have always been there. I'm
>>>>> not an expert here, so I want to know is the problem here that the SDIO
>>>>> interface is shutdown before brcmfmac is suspended or lies the issue
>>>>> within brcmfmac suspend itself?
>>>> Upon suspend we execute the remove path and cleaning the interfaces.
>>>> We notify cfg80211 about the removal, which in turn will notify
>>>> userspace, but is tries to obtain the tx power from brcmfmac.
>> I guess "it tries to obtain" is some sort of event path that wants to
>> include the TX power in an event. That doesn't seem to make all that
>> much sense on removal events though, so perhaps we could remove the
>> get_channel and get_tx_power calls for NL80211_CMD_DEL_INTERFACE.
> Not sure if I get it right, but the follow patch make the errors go away:
>
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 1ac8a196f376..52120cce2f7e 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -4006,23 +4006,25 @@ static int nl80211_send_iface(struct sk_buff
> *msg, u32 portid, u32 seq, int flag
>          nla_put_u32(msg, NL80211_ATTR_VIF_RADIO_MASK, wdev->radio_mask))
>          goto nla_put_failure;
>
> -    if (rdev->ops->get_channel && !wdev->valid_links) {
> -        struct cfg80211_chan_def chandef = {};
> -        int ret;
> +    if (cmd != NL80211_CMD_DEL_INTERFACE) {
> +        if (rdev->ops->get_channel && !wdev->valid_links) {
> +            struct cfg80211_chan_def chandef = {};
> +            int ret;
>
> -        ret = rdev_get_channel(rdev, wdev, 0, &chandef);
> -        if (ret == 0 && nl80211_send_chandef(msg, &chandef))
> -            goto nla_put_failure;
> -    }
> +            ret = rdev_get_channel(rdev, wdev, 0, &chandef);
> +            if (ret == 0 && nl80211_send_chandef(msg, &chandef))
> +                goto nla_put_failure;
> +        }
>
> -    if (rdev->ops->get_tx_power) {
> -        int dbm, ret;
> +        if (rdev->ops->get_tx_power) {
> +            int dbm, ret;
>
> -        ret = rdev_get_tx_power(rdev, wdev, &dbm);
> -        if (ret == 0 &&
> -            nla_put_u32(msg, NL80211_ATTR_WIPHY_TX_POWER_LEVEL,
> -                DBM_TO_MBM(dbm)))
> -            goto nla_put_failure;
> +            ret = rdev_get_tx_power(rdev, wdev, &dbm);
> +            if (ret == 0 &&
> +                nla_put_u32(msg, NL80211_ATTR_WIPHY_TX_POWER_LEVEL,
> +                    DBM_TO_MBM(dbm)))
> +                goto nla_put_failure;
> +        }
>      }
>
>      switch (wdev->iftype) {
>
> But this change doesn't consider get_txq_stats and the further calls
> rdev_get_channel for the valid_links.
>
> Do we actually need nl80211_send_iface() for NL80211_CMD_DEL_INTERFACE?

In term of user-space API the answer would (probably) be yes. At least the 
primitive should be send. What attributes should be included is debatable. 
The primitive is probably used by user-space to cleanup or disable 
functionality using the given interface. So only attributes identifying the 
interface are likely sufficient (wdev-id, if-index).

Regards,
Arend






