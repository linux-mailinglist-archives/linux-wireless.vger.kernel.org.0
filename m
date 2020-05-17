Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CB21D6BD2
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2020 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgEQSv0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 May 2020 14:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgEQSvY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 May 2020 14:51:24 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B25207D3;
        Sun, 17 May 2020 18:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589741484;
        bh=7visQ1waSxeU7vF4E3DD+jD/BIgH/34eBeTQ7KZvNQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VCB72sYrFoSROorZ4ousxQ+bUHChOwGKt1ja9q2iqxdzy7VZUAoKK/HaFhVQ17KA7
         6RumbcZ4jTUc9+o2Obu8CQhbD6lAP8ts+lETpIYO01yG7lfu2O0JoTBZYiWQVvbPd3
         BzGJ1nITtfBDdcSjcxmo2NZx+g2PUKE76vFrGIc0=
Received: by mail-io1-f47.google.com with SMTP id k6so8312037iob.3;
        Sun, 17 May 2020 11:51:23 -0700 (PDT)
X-Gm-Message-State: AOAM5311ZZGcMIsLos12GO2G0wr//lgHLb80ceBeEIQbNxS2G+9ujvy4
        r8lM2SrGtROQTVIJxk5grY5f+ZLZXl+j0/i1Aac=
X-Google-Smtp-Source: ABdhPJz+m+WBrkeVHbSdVbKv+ETibwb2yUp0mROmRQStXZ5D+3OTcTK9mi10fIvMybkDdlaZTw8eZWYlH/kn/e7b9gE=
X-Received: by 2002:a05:6638:3a8:: with SMTP id z8mr7424154jap.73.1589741483432;
 Sun, 17 May 2020 11:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200507041945.15491-1-yhchuang@realtek.com>
In-Reply-To: <20200507041945.15491-1-yhchuang@realtek.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Sun, 17 May 2020 14:51:12 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5TxEnvUr1y+i5405R1TV=QkdyoU0V-RzGpVm0XFeU3dg@mail.gmail.com>
Message-ID: <CA+5PVA5TxEnvUr1y+i5405R1TV=QkdyoU0V-RzGpVm0XFeU3dg@mail.gmail.com>
Subject: Re: [PATCH] rtw88: update firmware information and README
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Linux Wireless <linux-wireless@vger.kernel.org>,
        linux-firmware@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Applied and pushed out.

josh

On Thu, May 7, 2020 at 12:19 AM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> The rtw88/README should claim support for RTL8723DE devices, add them.
>
> And also there will have confusion that the 802.11ac driver rtw88
> supports an 802.11n device RTL8723DE, add the information to WHENCE.
>
> To prevent some fo the distros not including WOW firmware but have WOW
> support and cannot load firmware at the end, add a note for it.
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  WHENCE       | 8 ++++++++
>  rtw88/README | 3 +++
>  2 files changed, 11 insertions(+)
>
> diff --git a/WHENCE b/WHENCE
> index 010d1f8..4fe51b2 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -2872,6 +2872,14 @@ File: rtw88/rtw8723d_fw.bin
>
>  Licence: Redistributable. See LICENCE.rtlwifi_firmware.txt for details.
>
> +    These firmware should be put under /lib/firmware/rtw88/
> +    And note that the rtw88 driver is able to support wake-on-wireless LAN
> +    for RTL8822C devices, after kernel v5.6+. So, make sure the firmware
> +    rtw88/rtw8822c_wow_fw.bin is also packed, otherwise the firmware load
> +    fail could be a problem.
> +    Although RTL8723D devices are 802.11n device, they are also supported
> +    by rtw88 because the hardware arch is similar.
> +
>  --------------------------------------------------------------------------
>
>  Driver: rtl8192ee - Realtek 802.11n WLAN driver for RTL8192EE
> diff --git a/rtw88/README b/rtw88/README
> index 7ee24b3..b2992be 100644
> --- a/rtw88/README
> +++ b/rtw88/README
> @@ -26,3 +26,6 @@ RTL8822CE
>      rtw8822c_fw.bin
>      rtw8822c_wow_fw.bin
>
> +RTL8723DE
> +    rtw8723d_fw.bin
> +
> --
> 2.17.1
>
