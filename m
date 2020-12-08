Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756192D34C5
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 22:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgLHVBJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 16:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbgLHVBJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 16:01:09 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22F6C0613CF
        for <linux-wireless@vger.kernel.org>; Tue,  8 Dec 2020 13:00:28 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id o11so99202ote.4
        for <linux-wireless@vger.kernel.org>; Tue, 08 Dec 2020 13:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQYt/4VgCiEwd3op5jlCPhHU8pQtIJ/B1ftm9vhFDbM=;
        b=elBXLPE9EtSolehwqod4JujVxpIlOQ+VeIEW8OSE9jod4LBKN1G7JgblBCuMqt7Z9I
         J+5q4Ho+3/TnxKhBIQY8EwD0ZAN0G5fghei/Lr9fI40OVHw+jPBMqhdNUcRyokZrO3y0
         WgzXG3aRwasbIiezVdjhx/D6QCe1aFXa90IBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQYt/4VgCiEwd3op5jlCPhHU8pQtIJ/B1ftm9vhFDbM=;
        b=MgGIjkYz0ymZL/tMc2FvspHEtIm07HKPtPzWN4dimV/mcdlm7vwNTBbYXAcwBaggKU
         khDK+4T+m9pgvg4SdRcgR+gjpstyqsUpPqmnL3uM0RyeGqBJCbPl8e86GSU4mQbI5e7G
         0L1kXD1t1cZHVjghoDdRIwnTth3I8N+wQWIEz0soOYWfutYahTX0uVnpmwEHFfsrT5Qy
         vVbcpQ1pYtWGgVFURBdt7g8epdfX+8/8dOsbf6Y87jRxkYm5pwvm9NUz3Rf5mR8Kd21V
         9ywASZp6JgQecoHm10CQi21A9koP5DjN9U8wYtUFI7XvXiuKTXddGvDvVkwcRV9G4UUF
         Koog==
X-Gm-Message-State: AOAM533syR1FYcODBzZkniDHM2UVcgFUnT9JG7D8p4FkcD5yyVksSCVr
        qjktiH6UvflGh68fjmXtTWKftMssIUIFbw==
X-Google-Smtp-Source: ABdhPJwRSWQZ57S+m26BQa2bof68nMQxbJHbHUNFCJiwGatXsOcLz+h+ps6rNbOGeLr/ATvATD+Ccg==
X-Received: by 2002:a4a:b043:: with SMTP id g3mr17519626oon.69.1607453803806;
        Tue, 08 Dec 2020 10:56:43 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id e24sm947305otq.9.2020.12.08.10.56.42
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 10:56:42 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id p126so20503021oif.7
        for <linux-wireless@vger.kernel.org>; Tue, 08 Dec 2020 10:56:42 -0800 (PST)
X-Received: by 2002:aca:c443:: with SMTP id u64mr3807625oif.117.1607453801518;
 Tue, 08 Dec 2020 10:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20201208154343.6946-1-ruc_zhangxiaohui@163.com>
In-Reply-To: <20201208154343.6946-1-ruc_zhangxiaohui@163.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 8 Dec 2020 10:56:29 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPiY5AQDu2snHSqBDA0BYi79_hmNAjsKmXm1cFrgoxo4Q@mail.gmail.com>
Message-ID: <CA+ASDXPiY5AQDu2snHSqBDA0BYi79_hmNAjsKmXm1cFrgoxo4Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] mwifiex: Fix possible buffer overflows in mwifiex_uap_bss_param_prepare
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

(FWIW, this author's mail has been routed to my spam mailbox. That's
partly my fault and/or my "choice" of mail provider, but that's why I
only see these once Kalle replies to them.)

On Tue, Dec 8, 2020 at 8:03 AM Xiaohui Zhang <ruc_zhangxiaohui@163.com> wrote:
>
> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
>
> mwifiex_uap_bss_param_prepare() calls memcpy() without checking
> the destination size may trigger a buffer overflower,
> which a local user could use to cause denial of service or the
> execution of arbitrary code.
> Fix it by putting the length check before calling memcpy().
>
> Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> index b48a85d79..937c75e89 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> @@ -502,7 +502,8 @@ mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
>                 ssid = (struct host_cmd_tlv_ssid *)tlv;
>                 ssid->header.type = cpu_to_le16(TLV_TYPE_UAP_SSID);
>                 ssid->header.len = cpu_to_le16((u16)bss_cfg->ssid.ssid_len);
> -               memcpy(ssid->ssid, bss_cfg->ssid.ssid, bss_cfg->ssid.ssid_len);
> +               memcpy(ssid->ssid, bss_cfg->ssid.ssid,
> +                      min_t(u32, bss_cfg->ssid.ssid_len, strlen(ssid->ssid)));

This strlen() check makes no sense to me. We are *writing* to
ssid->ssid, so its initial contents are either zero or garbage --
strlen() will either give a zero or unpredictable value. I'm pretty
sure that's not what you intend.

On the other hand, it's hard to determine what the proper bound here
*should* be. This 'ssid' struct is really just a pointer into
mwifiex_cmd_uap_sys_config()'s uap_sys_config (struct
host_cmd_ds_sys_config), which doesn't have any defined length -- its
length is only given by way of its surrounding buffers/structs.
Altogether, the code is hard to reason about.

Anyway, this patch is wrong, so NAK.

Brian

>                 cmd_size += sizeof(struct mwifiex_ie_types_header) +
>                             bss_cfg->ssid.ssid_len;
>                 tlv += sizeof(struct mwifiex_ie_types_header) +
> --
> 2.17.1
>
