Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A462D3430
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 21:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgLHUcP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 15:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbgLHUcO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 15:32:14 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D576DC061793
        for <linux-wireless@vger.kernel.org>; Tue,  8 Dec 2020 12:31:28 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id o144so17311183ybg.7
        for <linux-wireless@vger.kernel.org>; Tue, 08 Dec 2020 12:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lne4PvkhK9agYEgzjS9te6vCuHKM3HSi40k8tH/cnbg=;
        b=O8u/LFMGaD05T4BW7FSwj5ut69kES9sL7RktfTp/Kctwu7Qu3IDWfHWwoCzdQUwKkB
         iPBi/ikRSki7CqX2rs6D3nhpsb6/0YwPfYMrUBvAul6Mo1rBT88gheiHANmH+pABQXiY
         eD+26TUCkFqW3zQpFUD++8m0ykl0h8VMaV5yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lne4PvkhK9agYEgzjS9te6vCuHKM3HSi40k8tH/cnbg=;
        b=jo7k8/sObmA37xj0xKEF29ai3FnRCTtVEahbXnHJW26kyunj+4dIi5TurL2JhkfFNr
         s22Hqf9XuvSToHeijEtMXosJ4n+RLpghP1bWB44Q5Rf0go3e6DvQVAn/nPIRM0ZACylq
         v6gGzkfPKBub8k/Xh4joKZdL5HfwGeifN3+3iGX8ZeToVakhXxq8E+Hcr1JqwEvYQhd8
         n7V1foeUaxLI/LK9Ke4EtlZ9kxcs0YHhd0/8cIlsdXZNcZYBPinbTazTxUJjacs7BcXz
         XQRfngZDSRqZrMCTs5cc8M2fR00zTwCiDVLAceavxae2pGQ3NZXoTsbgBRuQ6dAxX9l2
         jXKg==
X-Gm-Message-State: AOAM533fUyL2tShHxac0LtqFstS3vIWT5toqrdPv8Rf86ZSiEhs+Dyf0
        AkQmmvQtQED8Nong76cSnNUz7gSieCtVaA==
X-Google-Smtp-Source: ABdhPJy8Dv1FFMV3Hmy45bQojirOjvt/tYnl58Lod9BWxTrvnTuAq7Ue8Nio+aq1pdZvrFWYy0DMoA==
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr11422598otn.41.1607454733756;
        Tue, 08 Dec 2020 11:12:13 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id z9sm2260956otj.67.2020.12.08.11.12.12
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 11:12:12 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id a109so1228273otc.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Dec 2020 11:12:12 -0800 (PST)
X-Received: by 2002:a9d:7394:: with SMTP id j20mr12995977otk.229.1607454732130;
 Tue, 08 Dec 2020 11:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20201208150951.35866-1-ruc_zhangxiaohui@163.com>
In-Reply-To: <20201208150951.35866-1-ruc_zhangxiaohui@163.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 8 Dec 2020 11:12:00 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPVu5S0Vm0aOcyqLN090u3BwA_nV358YwkpXuU223Ug9g@mail.gmail.com>
Message-ID: <CA+ASDXPVu5S0Vm0aOcyqLN090u3BwA_nV358YwkpXuU223Ug9g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mwifiex: Fix possible buffer overflows in mwifiex_config_scan
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Dec 8, 2020 at 7:14 AM Xiaohui Zhang <ruc_zhangxiaohui@163.com> wrote:
>
> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
>
> mwifiex_config_scan() calls memcpy() without checking
> the destination size may trigger a buffer overflower,
> which a local user could use to cause denial of service
> or the execution of arbitrary code.
> Fix it by putting the length check before calling memcpy().

^^ That's not really what you're doing any more, for the record. But
then, describing "what" is not really the point of a commit message
(that's what the code is for), so maybe that's not that important.

> Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/scan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
> index c2a685f63..34293fd80 100644
> --- a/drivers/net/wireless/marvell/mwifiex/scan.c
> +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
> @@ -931,7 +931,7 @@ mwifiex_config_scan(struct mwifiex_private *priv,
>                                 wildcard_ssid_tlv->max_ssid_length = 0xfe;
>
>                         memcpy(wildcard_ssid_tlv->ssid,
> -                              user_scan_in->ssid_list[i].ssid, ssid_len);
> +                              user_scan_in->ssid_list[i].ssid, min_t(u32, ssid_len, 1));

This *looks* like it should be wrong, because SSIDs are clearly longer
than 1 byte in many cases, but you *are* right that this is what the
struct is defined as:

struct mwifiex_ie_types_wildcard_ssid_params {
...
    u8 ssid[1];
};

This feels like something that could use some confirmation from
NXP/ex-Marvell folks if possible, but if not that, at least some
creative testing. Did you actually test this patch, to make sure
non-wildcard scans still work?

Also, even if this is correct, it seems like it would be more correct
to use 'sizeof(wildcard_ssid_tlv->ssid)' instead of a magic number 1.

Brian

>
>                         tlv_pos += (sizeof(wildcard_ssid_tlv->header)
>                                 + le16_to_cpu(wildcard_ssid_tlv->header.len));
> --
> 2.17.1
>
