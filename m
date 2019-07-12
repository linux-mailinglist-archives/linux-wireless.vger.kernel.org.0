Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B7F662B4
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 02:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfGLATG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 20:19:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36658 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbfGLATG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 20:19:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so3499313pfl.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2019 17:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cXwPjnGAmuSK2ZaU+Ltpqy4ycTb2N7DG1+z1aocDv54=;
        b=H8jwe3rChH4G7iCj19aG+jdTznh7B97b9IBA1NFnsgbjB1uousOK0oJNLWfDlTXmK4
         zufv/ozFwoIPysjElmQ+t7Zg/hhXPAHCnhEDd0dBt8Gu7JYSKV35byBYpmzHzICcRhIw
         d6WUTeL5mu3lCkjv0XPOuvqx+VP/f61fQhPzrIoX+wmbrcbPMxjBYMeoOWFP+DBo26or
         spJ7MHeVaPilLfnoqqASjaXWKqJ+0XEq5Ong80tp7CMEGVVSadV16s/Ng7p0tLLORU7D
         qAXfW8mGQtfQcDjhIz7eSMepf70vkowGJn8eHxEeBRGLbbL9+4wLVZMnKqQHP5SjG4Gh
         Jsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXwPjnGAmuSK2ZaU+Ltpqy4ycTb2N7DG1+z1aocDv54=;
        b=l5lER9wyUG/XaxVKj0ReZopHXQlNx9kBR6dNY4vzUgdEdgTi4POTi65jwRMhXU5+45
         fvezBVcPinLhOUpt/Iugz8FWTo3ZhXVr8E10Ic8i1GARlfRjasbO0wDBsndfQmo55+nM
         +SOPbQ6Wznfg7Li5QLOhBSAb3xwtSTAMvfwUalOlUEq4C3Rpvm81rPhtQLz8EeKSxbX+
         geeUNKj7pN++htcXjo26YSQP4E+TNDpfZweM5iA3AMM8D53wC8ABrlfdNkpyv52Sx+Cs
         wnZVyhoLsG78MBuE/aUPef5IDlApQ4rg57PgIVYJE6q7IbkQpWHp53utw1RVdUelIYWz
         4Hnw==
X-Gm-Message-State: APjAAAV4/OZTUT/gxcxySOvsiY60doBxpwIYtSx1BsnzKNFNciLPd1HD
        NIU38EYVRjutWrl5EnnWX84atXGnGy/iSHqjSkUdOA==
X-Google-Smtp-Source: APXvYqz8a97UOm7FtJ1ymacgN41+7iKD+V77S1AaSr9ry+cK2pVeO54pyfOkaOO8sRGs6RyjYFwX1TFVH5CYtrb+7Z4=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr7784463pje.123.1562890745251;
 Thu, 11 Jul 2019 17:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190712001708.170259-1-ndesaulniers@google.com>
In-Reply-To: <20190712001708.170259-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Jul 2019 17:18:54 -0700
Message-ID: <CAKwvOd=C_fTxT20mv5LrNmrSWezNgtBy5nzFJb2gpuo_Lx-f0Q@mail.gmail.com>
Subject: Re: [PATCH -next] iwlwifi: dbg: work around clang bug by marking
 debug strings static
To:     Kalle Valo <kvalo@codeaurora.org>
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

On Thu, Jul 11, 2019 at 5:17 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Commit r353569 in prerelease Clang-9 is producing a linkage failure:
>
> ld: drivers/net/wireless/intel/iwlwifi/fw/dbg.o:
> in function `_iwl_fw_dbg_apply_point':
> dbg.c:(.text+0x827a): undefined reference to `__compiletime_assert_2387'
>
> when the following configs are enabled:
> - CONFIG_IWLWIFI
> - CONFIG_IWLMVM
> - CONFIG_KASAN
>
> Work around the issue for now by marking the debug strings as `static`,
> which they probably should be any ways.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=42580
> Link: https://github.com/ClangBuiltLinux/linux/issues/580
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Sorry, I forgot a very important:
Suggested-by: Eli Friedman <efriedma@quicinc.com>

> ---
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> index e411ac98290d..f8c90ea4e9b4 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> @@ -2438,7 +2438,7 @@ static void iwl_fw_dbg_info_apply(struct iwl_fw_runtime *fwrt,
>  {
>         u32 img_name_len = le32_to_cpu(dbg_info->img_name_len);
>         u32 dbg_cfg_name_len = le32_to_cpu(dbg_info->dbg_cfg_name_len);
> -       const char err_str[] =
> +       static const char err_str[] =
>                 "WRT: ext=%d. Invalid %s name length %d, expected %d\n";
>
>         if (img_name_len != IWL_FW_INI_MAX_IMG_NAME_LEN) {
> @@ -2775,7 +2775,7 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
>                 struct iwl_ucode_tlv *tlv = iter;
>                 void *ini_tlv = (void *)tlv->data;
>                 u32 type = le32_to_cpu(tlv->type);
> -               const char invalid_ap_str[] =
> +               static const char invalid_ap_str[] =
>                         "WRT: ext=%d. Invalid apply point %d for %s\n";
>
>                 switch (type) {
> --
> 2.22.0.410.gd8fdbe21b5-goog
>


-- 
Thanks,
~Nick Desaulniers
