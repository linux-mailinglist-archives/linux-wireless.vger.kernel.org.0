Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A44B292F6C
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Oct 2020 22:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgJSU3V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 16:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJSU3U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 16:29:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D003C0613CE
        for <linux-wireless@vger.kernel.org>; Mon, 19 Oct 2020 13:29:19 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so384302pll.11
        for <linux-wireless@vger.kernel.org>; Mon, 19 Oct 2020 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0BXgwvZ4jMHeZzNiv/wjk3o+W4wXRElRH5oxkY1vnuA=;
        b=CUjnbXwaMT8ibYDhv8kuaXzN8wHPUqXDF1oEqzBNaZjWeHxGFkAor0dnR4KMd2zLdU
         NBgyo6C1+6tnJSpgk9abNQj95rbRjpW6ZkDIqRpW0AG8J8/f9imhkSQC23DCDYxBME5d
         5uLw3YFlR36YgPjWkCNadigt3mdA4Ieo3ca28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0BXgwvZ4jMHeZzNiv/wjk3o+W4wXRElRH5oxkY1vnuA=;
        b=OgVhs/hwUIQ34Xj9f86FFVUegq2p4u0eghG6ZPMkaJ9B0uc2JjF32jhNLVpIY8sb6O
         oAQdmnJbzAtP+lqCBFGguoLmfprKZ75QvplcixnrFbQFGuh+6QvLI8JQlchvjwVblXXy
         TscyIcnYAK1FxX3QTWOINy7v+SP0mNULpdxcWPp73TPAqjPud7Tb6qecon8IEiV7wESD
         1NQiFTLAfWsmBz+KPH0RAQolbENV+DeK6d6oyOHDXFJUTauYAt/Xlb813IeDiGXiLGih
         DR5nqL/r4Ku0iA7R6NXGZSHJhG2vbF71cXCgk0HmdoBqPY+GWFETUhQPjtnnm3AwIwoE
         fXLg==
X-Gm-Message-State: AOAM530Fmrh8vEVvRM6GHx+cJVYTrp3/lRhzGCleJ7QZD2IahC9x2eWb
        om2uEYiLzknU9jbpES3VcdiCIkCPCagUXA==
X-Google-Smtp-Source: ABdhPJxznxOd+w/SV1e0NtHbz0gDUy4zbvVe7TXOjHppmqbLWzKsi4ApFNMXpgLddQlEKaKtMNDrmw==
X-Received: by 2002:a17:90a:ab92:: with SMTP id n18mr1063752pjq.233.1603139358811;
        Mon, 19 Oct 2020 13:29:18 -0700 (PDT)
Received: from [192.168.4.200] (c-76-102-118-9.hsd1.ca.comcast.net. [76.102.118.9])
        by smtp.gmail.com with ESMTPSA id y10sm595893pff.119.2020.10.19.13.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 13:29:18 -0700 (PDT)
Subject: Re: [PATCH 1/4] mac80211: save HE oper info in BSS config for mesh
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <20201009021811.18584-1-pradeepc@codeaurora.org>
 <20201009021811.18584-2-pradeepc@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <cc254230-5909-b77a-8c13-2c769a618660@eero.com>
Date:   Mon, 19 Oct 2020 13:29:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009021811.18584-2-pradeepc@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +static void
> +ieee80211_mesh_update_bss_params(struct ieee80211_sub_if_data *sdata,
> +				 u8 *ie, u8 ie_len)
> +{
> +	struct ieee80211_supported_band *sband;
> +	const u8 *cap;
> +	const struct ieee80211_he_operation *he_oper = NULL;
> +
> +	sband = ieee80211_get_sband(sdata);
> +	if (!sband)
> +		return;
> +
> +	if (ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT) &&
> +	    !(sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
> +	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
> +	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10))
> +		return;

Are you update BSS only for sub-20Mhz?

Shouldn't you remove "!" for 20~160Mhz?


Thanks,

Peter

