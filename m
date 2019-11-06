Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A75FF20DE
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2019 22:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbfKFVdS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Nov 2019 16:33:18 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33596 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKFVdR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Nov 2019 16:33:17 -0500
Received: by mail-qt1-f196.google.com with SMTP id y39so13601qty.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2019 13:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hsQZSOuPgDEYpkRIrusPrGiXr3Pj9L1UQOuSWwbS3J4=;
        b=TDhc43FGHx5coIphtrOFLFpgoH8tAyZKogKDj9fn+mGb/xbXUDffMPQ+MUrEKY+d6G
         W1U2CG+X336Euat8UBzHaBzYhTDGyG7yMo3Xwy9/gH9U0R4eZrvAD2W4Qv6C3Zus6jHb
         qTyHRJgk71ewf1NdL52vKUZjkJwcwW6AWO9tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsQZSOuPgDEYpkRIrusPrGiXr3Pj9L1UQOuSWwbS3J4=;
        b=T6Mw7wv2T3LzybUC+m47ExqCmWCUZe5RY+zhFu60M6iZoQrbYbVo/tXpJ4nnl/00N5
         qPeXNoBK+YWu+GL7WxuSHLnuCBcjarwoThi+xEPGWUqUwT9Ywdv7ffitNVh2oE1vZfea
         FrLQPqoELXFqyiSXauTrsBmTgeJyxs/c9YuKF3vkzZfkMDPt6YWv95ZhyT1cEAKCAtik
         PxcYFOQhfPP7i1PpNYEWaV7p0TCWZnqaRVr4OXDNQgmuxgznnjHczOO7wQgbgtZyDcKw
         alYqBNTlljB8AA82S0OyChao1tK1uzO3OxxM6B4dA72iBQMRRuNI4qOuDa48Kt0r+2h2
         Q+1Q==
X-Gm-Message-State: APjAAAUORW6IWyIaORVsswuaHZNyRYJcbW16yxwDlUECU7NjND+oeelr
        KsUxMxPCoaEm6VGmMMQQXI93x34kRzk=
X-Google-Smtp-Source: APXvYqzhd3EF/5tgTPL/6kEI1cNccPHCXf5XXNrDeMxA2oIsF9iFkOFby0gtm3yc0vaMvFJE20KUvg==
X-Received: by 2002:aed:20e5:: with SMTP id 92mr114177qtb.294.1573075995979;
        Wed, 06 Nov 2019 13:33:15 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id o3sm33740qkf.97.2019.11.06.13.33.14
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 13:33:15 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id 205so131536qkk.1
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2019 13:33:14 -0800 (PST)
X-Received: by 2002:a37:9cc2:: with SMTP id f185mr4314085qke.2.1573075994285;
 Wed, 06 Nov 2019 13:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20191105090442.8378-1-yhchuang@realtek.com>
In-Reply-To: <20191105090442.8378-1-yhchuang@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 6 Nov 2019 13:33:02 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNrsoqQ2wAg3L5S7yW2-5bVFY_Z06_0vqjz184HzQunGg@mail.gmail.com>
Message-ID: <CA+ASDXNrsoqQ2wAg3L5S7yW2-5bVFY_Z06_0vqjz184HzQunGg@mail.gmail.com>
Subject: Re: [PATCH] rtw88: fix potential NULL pointer access for firmware
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 5, 2019 at 1:06 AM <yhchuang@realtek.com> wrote:
...
> Fixes: 5195b90426409 ("rtw88: avoid FW info flood")
...
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -1024,8 +1024,10 @@ static void rtw_load_firmware_cb(const struct firmware *firmware, void *context)
>         struct rtw_fw_state *fw = &rtwdev->fw;
>         const struct rtw_fw_hdr *fw_hdr;
>
> -       if (!firmware)
> +       if (!firmware || !firmware->data) {
>                 rtw_err(rtwdev, "failed to request firmware\n");

I think you still wanted 'complete_all()' here, otherwise your waiters
will hang forever. (They correctly check whether the firmware is NULL,
so that's not a problem there.)

I'll send a follow-up to the follow-up :)

Brian

> +               return;
> +       }
