Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18A8EC198
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2019 12:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfKALOy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Nov 2019 07:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfKALOy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Nov 2019 07:14:54 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8CD21835
        for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2019 11:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572606893;
        bh=WpF6LVHcwvLGyg21hweOG7aRyEpLPoQgKNX3GjxIxDA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U60KUotpd9Y8yLcU2NQQYhKd1rXR+XBFKP+GNtyV3hS2k95KdO4S7uiaothXrFZ12
         A0WHr0qNs0dAYl2ItDs2+LqwNdna6se3DOTNM3A99Th4fZsZDEPawnAc4TkJIlADw3
         5nhQrYOnp/zgSiy8nzGuGOKz4Ld9qnR32O9D4rZc=
Received: by mail-qt1-f180.google.com with SMTP id e14so12501354qto.1
        for <linux-wireless@vger.kernel.org>; Fri, 01 Nov 2019 04:14:53 -0700 (PDT)
X-Gm-Message-State: APjAAAXDPSuVZYhv7h00lOhtYxAqntvgFADtt0hYVTlTZBdF+DTF99ke
        LAa9HCKUmaRqqDhFiZXWPaQmLZ169aaYwwGVtV4=
X-Google-Smtp-Source: APXvYqwUMR0ejkbvf1SiiAiM6ne0JIKq68iwTd5z653LJKCzZSrDNlsVr4BAcBYcRaSAmmN3MtS6OWN1RP6TiMhqnbE=
X-Received: by 2002:a0c:efc2:: with SMTP id a2mr9662647qvt.44.1572606892881;
 Fri, 01 Nov 2019 04:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191101023805.16093-1-yhchuang@realtek.com>
In-Reply-To: <20191101023805.16093-1-yhchuang@realtek.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Fri, 1 Nov 2019 07:14:41 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4G0zgrPsrCwV-dDBHR9o2=hh7a+2dyBi3a77sCNE2HbQ@mail.gmail.com>
Message-ID: <CA+5PVA4G0zgrPsrCwV-dDBHR9o2=hh7a+2dyBi3a77sCNE2HbQ@mail.gmail.com>
Subject: Re: [PATCH] rtw88: RTL8723D: add firmware file v48
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 31, 2019 at 10:38 PM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> Add firmware file for RTL8723D series devices.
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  WHENCE                |   1 +
>  rtw88/rtw8723d_fw.bin | Bin 0 -> 28884 bytes
>  2 files changed, 1 insertion(+)
>  create mode 100644 rtw88/rtw8723d_fw.bin
>
> diff --git a/WHENCE b/WHENCE
> index 41494ab..5fcde52 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -2792,6 +2792,7 @@ Info: Sent to Larry Finger by Realtek engineer Yan-Hsuan Chuang <yhchuang@realte
>  File: rtw88/rtw8822b_fw.bin
>  File: rtw88/rtw8822c_fw.bin
>  File: rtw88/rtw8822c_wow_fw.bin
> +File: rtw88/rtw8723d_fw.bin

This doesn't apply cleanly.  Can you rebase it to the latest tree and resend?

josh
