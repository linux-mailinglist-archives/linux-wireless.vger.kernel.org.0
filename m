Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2F5B16F4
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIHI14 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 04:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIHI1y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 04:27:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B077C52D
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 01:27:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r18so9072454eja.11
        for <linux-wireless@vger.kernel.org>; Thu, 08 Sep 2022 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=X1TYzUf+wCu0LZdpA5WqUQ+hnIukF+U9ZzRhPSltOBE=;
        b=dEx9787cbUy3ONgbqNRx4/K/yx4F/Gg8lFXkELP8QSECjThz9tYnjYap+t6SuliUav
         4nVQ/n3eu5Yn/90eP5Hg0XoEpoH/cn3zU5wWJ609499MZU4Mb2VbD7X63lWzj7kkX68u
         pgU0Z/Ec7cF4tHGhX8ORWHfBv5ABjWfIHKc7e/DKKg8L8cXU8qC1GBTBP9UR1PC7nupn
         jD3R4gVbOC+ZdvZNPld75XMRVtIOrfu/oy2VXjxF7l7TJMtol74/OhHyZ7fp5C+owpsi
         1WtpQPCQenYNfOiqqy3CnYWQ8ljTxYnATHshZFMuG2OHGkd6kuPmVRGheptzQw/Utno7
         77nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X1TYzUf+wCu0LZdpA5WqUQ+hnIukF+U9ZzRhPSltOBE=;
        b=VCxch8+XI+PEeFtfBkGREYXLTAbT8YHK10TIe0BvSP0BWIjwzTZN+Md9zu1bcoNPx2
         GIRsCUW6JFMA/q0nU5FyPi2Xc2Z6pimgz5a4KA5M0OnGdmA5D7A1MxycUyf7Nd0mbwaB
         xegdxdv45/7MHoUrHEu8zgeQaTovudyltfIz8RhieKg9PNT74lZN0pQ9mS2i4TyCS00Z
         hhgYzCOoOmRN6AJBPeSgGeBwoQq+5I5B43Rv5gxJz5a+45R+Ql0IP8D4k674oKWYVtby
         opmg30IIqybKtWALrboPsL9UYuIitW87wihWa7EQQV7UfhtJShyIuAlkpGDVl6lxWyzC
         BIyA==
X-Gm-Message-State: ACgBeo21BDEwwweFX4IHKeACdUeG3YiJiGGTi2F+UGpEU/Vb9kl1dTuD
        Xe4zuu93+GWcFym9KGrdYBE1bqnqw6USsiIzNGff2IBLFbIq2A==
X-Google-Smtp-Source: AA6agR5XcTcsc4Ct1zYipLZkNdpQJcJA9Qwnfhl5/ZrS9XMPpVLfJ1+4fn7trDoIg6DAo0dINXTvPjQ9nygJTSHqhbk=
X-Received: by 2002:a17:907:16a9:b0:742:7a6:b17e with SMTP id
 hc41-20020a17090716a900b0074207a6b17emr5298827ejc.108.1662625672165; Thu, 08
 Sep 2022 01:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220907134450.1183045-1-toke@toke.dk>
In-Reply-To: <20220907134450.1183045-1-toke@toke.dk>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Thu, 8 Sep 2022 11:27:41 +0300
Message-ID: <CANUX_P3NRqD2YWfkFri37F982QVaCASfyz2qaicGjc9wJ6mDYQ@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: Mark IWLMEI as broken
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ayala Beker <ayala.beker@intel.com>,
        linux-wireless@vger.kernel.org,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Golan Ben Ami <golan.ben.ami@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,


On Wed, Sep 7, 2022 at 5:02 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.=
dk> wrote:
>
> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> The iwlmei driver breaks iwlwifi when returning from suspend; the bug
> report[0] has been open for four months now, and now fix seems to be
> forthcoming. Since just disabling the iwlmei driver works as a workaround=
,
> let's mark the config option as broken until it can be fixed properly.
>
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=3D215937
>
> Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation w=
ith CSME")
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

I am not very proud of this, to say the least, but unfortunately,
despite Toke's patience and
his willingness to provide logs and all, I couldn't find the time to fix th=
is.
We had tested against NetworkManager wpa_s, but not against iwd.
From the start, we thought distro wouldn't enable this and this is why
we disabled iwlmei by default.
This driver is meant to be used by specific groups that need this and
they'll know how to enable this
driver even if it is marked as BROKEN.

This is why, with a heavy heart:
Acked-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

I'd also suggest to CC this to stable 5.17+

Thanks Toke and Sorry!

> ---
>  drivers/net/wireless/intel/iwlwifi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wir=
eless/intel/iwlwifi/Kconfig
> index a647a406b87b..b20409f8c13a 100644
> --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> @@ -140,6 +140,7 @@ config IWLMEI
>         depends on INTEL_MEI
>         depends on PM
>         depends on CFG80211
> +       depends on BROKEN
>         help
>           Enables the iwlmei kernel module.
>
> --
> 2.37.2
>
