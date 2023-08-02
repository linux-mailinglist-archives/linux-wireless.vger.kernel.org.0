Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C161176DB3E
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 01:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjHBXEw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 19:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHBXEv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 19:04:51 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3291727
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 16:04:49 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-56cb1e602e7so204361eaf.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Aug 2023 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691017489; x=1691622289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMcvGoIt0gfQcmV0E7VguKzKodALh7KiIqm1shvRIBU=;
        b=cQcQZbRqv+CCu4Ha377yyThxHRqwEfT8c7TJ1xGZdtQDX/6FLxyaxV+4kg5UY7Ciht
         oWVeov1JureUkGsb/njoqvuUQuPdaIqIliZ605n9f7tA+qcH0yaYmFSbIvrktS5Z+5IF
         7WzlXIB7OjNqU0HWwa1cf3s1GaZrfBmeDnoSePJ2xEfx0BV3em89l9IyphzjxBDmSu+m
         yAfbSMJPr4QyrcYzi5ppN5Qy8/q7OEYXQRKN+RxvZNJrobsHfHCS7ccCuMRzLK/zqkcE
         NbeppuJFapP+fOWaiHJN9Vdia4Kl3VFxw807ZEvtGRHf71XX/zfH9NZplBevM63JIASG
         0hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691017489; x=1691622289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMcvGoIt0gfQcmV0E7VguKzKodALh7KiIqm1shvRIBU=;
        b=CfLWh+mnyR/qUUmYlROhnhDj7iksBAHqP7jtKaTTZEKjLnvP7sRQUnCBHAiOo4fzmZ
         2BZcl7rgkEu+KjZWE7SoHiUYb0Iehb4o06+/M/v3WQU4zmP49JF1SrYohJ6EgAG7xUmr
         gvnpucVOdsE4j3dbo4iEFz8cyQMlb5B0PpodJadI959++Bnjg7y4HmfB9sztGpN83L+M
         eOupLifo9sSHazET0bffnm7Mkv34w/eHgHVsnC1ZAhiWPwLfsENDXed8tkU2gqcc5yRv
         D6FtpdY0VlX5DJZIU4PJ+9wczWXniuhQDh4Z2SKrtNnIXSkPAgonmuEmGgQXaggqKag0
         ncFw==
X-Gm-Message-State: ABy/qLbKvYz/h+TVErE2qk98SYXppSD0t9paEvuNX56fWEy79ZFFpjyI
        9gWnaC/U/8zDKme91Pm5Dm+IjpCsmbmuGtl2rz4=
X-Google-Smtp-Source: APBJJlHjrpk9QqhFEnLrM1bkXgAveS756mEBbYsEmfZdRmX9uXdw6p0BhhxvAbCnGDy5js9jqIu45ZlttVcg8rvGzS8=
X-Received: by 2002:a4a:91cd:0:b0:566:f5bb:7d40 with SMTP id
 e13-20020a4a91cd000000b00566f5bb7d40mr15136698ooh.6.1691017489235; Wed, 02
 Aug 2023 16:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230801170052.6432-1-Larry.Finger@lwfinger.net> <20230801170052.6432-2-Larry.Finger@lwfinger.net>
In-Reply-To: <20230801170052.6432-2-Larry.Finger@lwfinger.net>
From:   Hin-Tak Leung <hintak.leung@gmail.com>
Date:   Thu, 3 Aug 2023 00:04:37 +0100
Message-ID: <CAJMB+NjFB7T1prmO5xHcp4BGvx19+Qtt5+f5_Z3EDn320ZmoMA@mail.gmail.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Update entry for rtl8187
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 1 Aug 2023 at 18:37, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> As Herton Ronaldo Krzesinski and Hin-Tak Leung are no longer active,
> remove them as maintainers for rtl8187.
>
> The git tree entry is also updated.
>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Nacked-by: Hin-Tak Leung <htl10@users.sourceforge.net>
Nacked-by: Hin-Tak Leung <hintak.leung@gmail.com>

Explained from the other e-mail address - I have technical problems
(have had that for some years now) of sending pure-text e-mail message
from it. So I would ideally add this one to the list so I can respond,
but keep the old one for more frequent reading that doesn't require a
response. Or, if a single entry is really required, switch to the
gmail address. Thanks a lot.

Hin-Tak

> ---
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d0553ad37865..432818a1f9ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18523,13 +18523,11 @@ T:    git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.g
>  F:     drivers/net/wireless/realtek/rtl818x/rtl8180/
>
>  RTL8187 WIRELESS DRIVER
> -M:     Herton Ronaldo Krzesinski <herton@canonical.com>
> -M:     Hin-Tak Leung <htl10@users.sourceforge.net>
>  M:     Larry Finger <Larry.Finger@lwfinger.net>
>  L:     linux-wireless@vger.kernel.org
>  S:     Maintained
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
>  W:     https://wireless.wiki.kernel.org/
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
>  F:     drivers/net/wireless/realtek/rtl818x/rtl8187/
>
>  RTL8XXXU WIRELESS DRIVER (rtl8xxxu)
> --
> 2.41.0
>
