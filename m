Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D47966231F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 11:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbjAIKX6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 05:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbjAIKXf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 05:23:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0795519292;
        Mon,  9 Jan 2023 02:22:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9832E60FDB;
        Mon,  9 Jan 2023 10:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01926C433F0;
        Mon,  9 Jan 2023 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673259741;
        bh=n5e+FPuvdwGXP9UMyOLez3XH3zqGrOElpmX997pbMFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lUYxRnm153RxssY8PzrkvBnXGnCf4/QJucLVhL4DP4SgiU6fnz3PMRS4u8LcMAeZz
         KyXWTZgv+mEhQeKfAU0Y9cDNwTwCvHpDnz7QyuOm8Yn2jHetxgfyVbPBfJmWmiAKms
         9MR26xoNZ7ZvRCNBYtjEO0EdJ2dNNEkBnCpF6ml+YsG1natalXZ1csbKj8wnQm9J7C
         dYtSZ94vwE/+8YYbB01L+keIbRn+Zzt6YzUxPeN1rgPDww8a3QNv8td9qU1qdOxtr7
         q/IRZcPz1bR6qi1Tyxk6sjl/+gpG5XbUSLwLTLU8lnLWAB4tuMB8U2mnuLlhRsZN1J
         w95hn+8ruVTaQ==
Received: by mail-ot1-f43.google.com with SMTP id m7-20020a9d73c7000000b00683e2f36c18so4963783otk.0;
        Mon, 09 Jan 2023 02:22:20 -0800 (PST)
X-Gm-Message-State: AFqh2kqrUCBdFe+0du8UXsHad9zRxoXSVPhnuCWpcMtcsuIy/Q/+G4Jo
        ib1j/NRCIRFT7hWdiYurC/BijFraTARjGWM5a44=
X-Google-Smtp-Source: AMrXdXuXgBjCFJpilFXuqYoJabAYebgmziJtjMVYgK/PC4Zs/8tfRVdbDhTEhY1ntucdZb/hqm59wFqeGS/kS8j+hL8=
X-Received: by 2002:a9d:128c:0:b0:66c:794e:f8c6 with SMTP id
 g12-20020a9d128c000000b0066c794ef8c6mr4139067otg.343.1673259740192; Mon, 09
 Jan 2023 02:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20230109082514.50747-1-arend.vanspriel@broadcom.com>
In-Reply-To: <20230109082514.50747-1-arend.vanspriel@broadcom.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 9 Jan 2023 19:21:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQg6fvHmxRh_GCsV798gC_PY4JGVChLwKzS6V9sRCH0gA@mail.gmail.com>
Message-ID: <CAK7LNAQg6fvHmxRh_GCsV798gC_PY4JGVChLwKzS6V9sRCH0gA@mail.gmail.com>
Subject: Re: [PATCH] scripts: rpm: make clear that mkspec script contains 4.13 feature
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-kbuild@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi.
Thanks for catching this.


On Mon, Jan 9, 2023 at 5:25 PM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> A fix was made in the mkspec script [1] that uses a feature, ie. the
> OR expression, which requires RPM 4.13. However, the script indicates
> another minimum version. Lower versions may have success by using
> the --no-deps option as suggested,


As far as I tested, CentOS 7 did not work with --no-deps solution.
It just ended up with a syntax error.





> but feels like bumping the version
> to 4.13 is reasonable as it put me on the wrong track at first with
> RPM 4.11 on my Centos7 machine.
>
> [1] https://lore.kernel.org/linux-kbuild/20221228191014.659746-1-masahiroy@kernel.org/


This is already merged.

Please use

Commit 02a893bc9975 ("kbuild: rpm-pkg: add libelf-devel as alternative
for BuildRequires")

instead of the URL.





>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>  scripts/package/mkspec | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index adab28fa7f89..094e52c979a8 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  #
>  #      Output a simple RPM spec file.
> -#      This version assumes a minimum of RPM 4.0.3.
> +#      This version assumes a minimum of RPM 4.13
>  #
>  #      The only gothic bit here is redefining install_post to avoid
>  #      stripping the symbols from files in the kernel which we want
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
