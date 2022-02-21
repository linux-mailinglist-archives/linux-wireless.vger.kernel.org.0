Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD74BE698
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 19:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379704AbiBUPzR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 10:55:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379702AbiBUPzP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 10:55:15 -0500
X-Greylist: delayed 293 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 07:54:52 PST
Received: from condef-01.nifty.com (condef-01.nifty.com [202.248.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B31275F7
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 07:54:51 -0800 (PST)
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-01.nifty.com with ESMTP id 21LFlnV3018552
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 00:47:49 +0900
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 21LFlSnE006690
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 00:47:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 21LFlSnE006690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645458449;
        bh=dtp8UTYYBKFR7FHfcvm2YwZLAGG9dAhDe2xB+cA/EGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=snZ4tPdM//jr/O2segZ+fHGI8Oy0uPtjSKD3h5cA85O7h6MHD746TfXyhzOMhLSca
         a+1fTQ5Y21myK8tDCNWizDAKhhO+eEh4tsmLFGRiBimEoXBtiLD7wbbm4SmL584cUf
         5qD6wTH4wXry2EfErCea2BHbIc/6f1br648kLChIJhtEvSXGKqMIcefnQMP5gjpppq
         b7frwCR+CAOwmrjw0tBPnAFOzPifKqfxLNtGez99FC9qz7rKJyVZc90Fi7buIaDlPA
         IViWXTZ1GhzNWwe6yGL1LFWqjVfN9N8m3bNnHkZeX++ADJ/5f/kFPmFF4n+227AdGH
         Vncnr1RdIqviQ==
X-Nifty-SrcIP: [209.85.214.175]
Received: by mail-pl1-f175.google.com with SMTP id i10so13244227plr.2
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 07:47:28 -0800 (PST)
X-Gm-Message-State: AOAM533tKMh/JHXkAUpSjpdMuR2R6xhzLjcle8pGyZDjYJ/PyJdDogrp
        5IU7bW3+pPF+x0OcbQMXuksMNia3MhOkynESZS4=
X-Google-Smtp-Source: ABdhPJxa1ZcfxHUZjRd5g3i8XjlUyj5qeefIySxz78HXhs6Po9Qkks3jSQeulS2gkiGpWKpwVNdbJcjtdkYGk+6DE8U=
X-Received: by 2002:a17:90b:4d84:b0:1b9:4109:7118 with SMTP id
 oj4-20020a17090b4d8400b001b941097118mr26274143pjb.119.1645458447966; Mon, 21
 Feb 2022 07:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20220221155512.1d25895f7c5f.I50fa3d4189fcab90a2896fe8cae215035dae9508@changeid>
In-Reply-To: <20220221155512.1d25895f7c5f.I50fa3d4189fcab90a2896fe8cae215035dae9508@changeid>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 22 Feb 2022 00:46:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNATD3mK+Z0tLAwOj93+fdZBKJ85ASdqNL8WuauXDzL8iXA@mail.gmail.com>
Message-ID: <CAK7LNATD3mK+Z0tLAwOj93+fdZBKJ85ASdqNL8WuauXDzL8iXA@mail.gmail.com>
Subject: Re: [PATCH] cfg80211: fix CONFIG_CFG80211_EXTRA_REGDB_KEYDIR typo
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Feb 21, 2022 at 11:55 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> The kbuild change here accidentally removed not only the
> unquoting, but also the last character of the variable
> name. Fix that.
>
> Fixes: 129ab0d2d9f3 ("kbuild: do not quote string values in include/config/auto.conf")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---

Thanks for catching this!

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>



>  net/wireless/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/wireless/Makefile b/net/wireless/Makefile
> index 1e9be50469ce..527ae669f6f7 100644
> --- a/net/wireless/Makefile
> +++ b/net/wireless/Makefile
> @@ -33,7 +33,7 @@ $(obj)/shipped-certs.c: $(wildcard $(srctree)/$(src)/certs/*.hex)
>           echo 'unsigned int shipped_regdb_certs_len = sizeof(shipped_regdb_certs);'; \
>          ) > $@
>
> -$(obj)/extra-certs.c: $(CONFIG_CFG80211_EXTRA_REGDB_KEYDI) \
> +$(obj)/extra-certs.c: $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR) \
>                       $(wildcard $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR)/*.x509)
>         @$(kecho) "  GEN     $@"
>         $(Q)(set -e; \
> --
> 2.35.1
>


-- 
Best Regards
Masahiro Yamada
