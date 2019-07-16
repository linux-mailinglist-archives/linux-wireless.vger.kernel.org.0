Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59AA16ADA1
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2019 19:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbfGPR2w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jul 2019 13:28:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39170 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbfGPR2v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jul 2019 13:28:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so9775118pgi.6
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2019 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdipyjVpCY6f56Xd4OimbS+PX/++xiAeJwdsr6JXrj4=;
        b=h1+V62UQ9GlP5V7C0IVqWNdDBKsnlQlECKOfmge8wZcQCKZdqLaxGAP+GFTdv6GM43
         rsyjKA7SqGqU56sdSzRhGCyQ9fEcpRAkOuZoc/fykRCryb/mK1IJFA6rYJu74nY6zCXP
         plvbFxEctwJ92ks0XB0cx3o3ptKwXdPR56Xp2M9jEdbyBmQvREnzRwijT5bcJQK8ciS0
         CHmrSsEx2FL+yOvxYn8aj8xeJzpN/yDZlr/uPRH9K1OnIT57lKWkYZZLe5JLY+tHpxoF
         vPlE1PtJIoTbnhydJ88RkCm1pYqsKye8E1Ee6wJUbVNzG7CCcGHdGc3tWJTq9mhurxUV
         nPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdipyjVpCY6f56Xd4OimbS+PX/++xiAeJwdsr6JXrj4=;
        b=K/6AkXjvfmpeinkmN4xEZX0DhHWPQL9xozTxYjorGsTShYVXmMnsZW4etDzrgy1GVm
         jL7EMmx10xruB5vi4Xt7qlrb7cGfY8vHei8KakpKB95FMSJJ61sWfNbdS9BS0ykIV9l9
         dcOVMLhtMg6ViH6C5hbys2qz2tOy3cXGlq2/MQ1fhU5iJHimTWwIQEIn+hhyEtZFMh7Z
         YidvpV7waymMX2geqUdPkYxi3123T/BeXOWHfYUPJcjLKuyB3+9GgCM7IqB+GxKoGYhu
         qDyNt0wJrGjEmBfRLwoieXSPyrvTrL9n+42CFDxfMIs3ZuuwC+SG3FEVM0/JhMzQH8Iv
         Atuw==
X-Gm-Message-State: APjAAAX0X3QjEqc9jAepgvUKoLZ+Qppxx+Oiy0V5rMBFr6NFLfor+Mxb
        8rjUt5P5bgrMCLh2RpPLm8GXPx+BvcYGhy3N011FMw==
X-Google-Smtp-Source: APXvYqxRntwkNQJL/5FuY0S5lwsDvHNyTqDiq6hab1isYlxCWGc+m+UWftjkrghbfqa2HIoXg2UjyyrTCTM77O102is=
X-Received: by 2002:a65:5687:: with SMTP id v7mr36183069pgs.263.1563298130577;
 Tue, 16 Jul 2019 10:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190712001708.170259-1-ndesaulniers@google.com> <b219cf41933b2f965572af515cf9d3119293bfba.camel@perches.com>
In-Reply-To: <b219cf41933b2f965572af515cf9d3119293bfba.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 16 Jul 2019 10:28:39 -0700
Message-ID: <CAKwvOdkD_r2YBqRDy-uTGMG1YeRF8KokxjikR0XLkXLsdJca0g@mail.gmail.com>
Subject: Re: [PATCH -next] iwlwifi: dbg: work around clang bug by marking
 debug strings static
To:     Joe Perches <joe@perches.com>, Kalle Valo <kvalo@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Sara Sharon <sara.sharon@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 11, 2019 at 7:15 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-07-11 at 17:17 -0700, Nick Desaulniers wrote:
> > Commit r353569 in prerelease Clang-9 is producing a linkage failure:
> >
> > ld: drivers/net/wireless/intel/iwlwifi/fw/dbg.o:
> > in function `_iwl_fw_dbg_apply_point':
> > dbg.c:(.text+0x827a): undefined reference to `__compiletime_assert_2387'
> >
> > when the following configs are enabled:
> > - CONFIG_IWLWIFI
> > - CONFIG_IWLMVM
> > - CONFIG_KASAN
> >
> > Work around the issue for now by marking the debug strings as `static`,
> > which they probably should be any ways.
> >
> > Link: https://bugs.llvm.org/show_bug.cgi?id=42580
> > Link: https://github.com/ClangBuiltLinux/linux/issues/580
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> > index e411ac98290d..f8c90ea4e9b4 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> > @@ -2438,7 +2438,7 @@ static void iwl_fw_dbg_info_apply(struct iwl_fw_runtime *fwrt,
> >  {
> >       u32 img_name_len = le32_to_cpu(dbg_info->img_name_len);
> >       u32 dbg_cfg_name_len = le32_to_cpu(dbg_info->dbg_cfg_name_len);
> > -     const char err_str[] =
> > +     static const char err_str[] =
> >               "WRT: ext=%d. Invalid %s name length %d, expected %d\n";
>
> Better still would be to use the format string directly
> in both locations instead of trying to deduplicate it
> via storing it into a separate pointer.
>
> Let the compiler/linker consolidate the format.
> It's smaller object code, allows format/argument verification,
> and is simpler for humans to understand.

Whichever Kalle prefers, I just want my CI green again.

>
> ---
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> index e411ac98290d..25e6712932b8 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> @@ -2438,17 +2438,17 @@ static void iwl_fw_dbg_info_apply(struct iwl_fw_runtime *fwrt,
>  {
>         u32 img_name_len = le32_to_cpu(dbg_info->img_name_len);
>         u32 dbg_cfg_name_len = le32_to_cpu(dbg_info->dbg_cfg_name_len);
> -       const char err_str[] =
> -               "WRT: ext=%d. Invalid %s name length %d, expected %d\n";
>
>         if (img_name_len != IWL_FW_INI_MAX_IMG_NAME_LEN) {
> -               IWL_WARN(fwrt, err_str, ext, "image", img_name_len,
> +               IWL_WARN(fwrt, "WRT: ext=%d. Invalid %s name length %d, expected %d\n",
> +                        ext, "image", img_name_len,
>                          IWL_FW_INI_MAX_IMG_NAME_LEN);
>                 return;
>         }
>
>         if (dbg_cfg_name_len != IWL_FW_INI_MAX_DBG_CFG_NAME_LEN) {
> -               IWL_WARN(fwrt, err_str, ext, "debug cfg", dbg_cfg_name_len,
> +               IWL_WARN(fwrt, "WRT: ext=%d. Invalid %s name length %d, expected %d\n",
> +                        ext, "debug cfg", dbg_cfg_name_len,
>                          IWL_FW_INI_MAX_DBG_CFG_NAME_LEN);
>                 return;
>         }
> @@ -2775,8 +2775,6 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
>                 struct iwl_ucode_tlv *tlv = iter;
>                 void *ini_tlv = (void *)tlv->data;
>                 u32 type = le32_to_cpu(tlv->type);
> -               const char invalid_ap_str[] =
> -                       "WRT: ext=%d. Invalid apply point %d for %s\n";
>
>                 switch (type) {
>                 case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
> @@ -2786,8 +2784,8 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
>                         struct iwl_fw_ini_allocation_data *buf_alloc = ini_tlv;
>
>                         if (pnt != IWL_FW_INI_APPLY_EARLY) {
> -                               IWL_ERR(fwrt, invalid_ap_str, ext, pnt,
> -                                       "buffer allocation");
> +                               IWL_ERR(fwrt, "WRT: ext=%d. Invalid apply point %d for %s\n",
> +                                       ext, pnt, "buffer allocation");
>                                 goto next;
>                         }
>
> @@ -2797,8 +2795,8 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
>                 }
>                 case IWL_UCODE_TLV_TYPE_HCMD:
>                         if (pnt < IWL_FW_INI_APPLY_AFTER_ALIVE) {
> -                               IWL_ERR(fwrt, invalid_ap_str, ext, pnt,
> -                                       "host command");
> +                               IWL_ERR(fwrt, "WRT: ext=%d. Invalid apply point %d for %s\n",
> +                                       ext, pnt, "host command");
>                                 goto next;
>                         }
>                         iwl_fw_dbg_send_hcmd(fwrt, tlv, ext);
>
>


-- 
Thanks,
~Nick Desaulniers
