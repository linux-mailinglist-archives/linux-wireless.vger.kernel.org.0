Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D9AB094E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 09:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfILHP2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 03:15:28 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40626 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfILHP2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 03:15:28 -0400
Received: by mail-qt1-f193.google.com with SMTP id g4so28476514qtq.7
        for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2019 00:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AiX3V0vZUFp8choHrVYn4HWXqqK55Q7q4G1C3Ui9aqI=;
        b=sjm9F625j50DNw319ShMBsR+PNdqSCPi81PpvytfJupgmMnrbR7EYEDK6b5Xp5ogn+
         +4kIzHjAiwPOs9+94fKrpCLwCAA9sH75ZZE6evILVHWOyhB+lrdQLQfD4jy//nwNl69J
         aGmvBJrWJwl/BbvblLOMtC/jhIVs4j8xlIVaafvP5ApsDMTlMhD5amFOoKuKJVVNKbiB
         xmqIzcqvyTiTa88oqaJQ33YqitnyUU8IokVei+HAz/nkY89/NRvhSss2uuu2LGnrIacq
         RXLuJWzKzkCRz/wvsSYp+ot88ou1VZ5LRtNIouwkX44ZrcfXzMn5MF2D3iT0gnxpfwWh
         Bfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AiX3V0vZUFp8choHrVYn4HWXqqK55Q7q4G1C3Ui9aqI=;
        b=BmFHsJrxJBrgM//JXG45chtiScN3BTLQfTBzU7fk+uk8MTQaIAN3HpDtwhzpCCY+QG
         cNtM4DyMj7H0JILzJ5M8Z5pQhUUOYlEhK3O0Z9CNTt8dTBhpDZgoY0TIIJoTSroQ+4Vm
         XVsJpsNf7VVfzdK6j3gosEUN5FT1XHIGWTwJ0hOqbufxTahk51g76Stt/NtoY1pCIr98
         Taof7YvEEQj01Ylzhhnm5AtEwDmTNhPgu7afJYxtMGSUHZsGxJ35kPQ65QF22e3AbUTl
         D7JHathVdOq9NX/psneJCDKUhPKQyl5no+ji1fW3XqJ4uklqnvTQzqF+X+3K96UT+UxA
         FjBg==
X-Gm-Message-State: APjAAAWys1cNHG2od420O2ZzEw5A2uza/0GblIfB+4QMiXTYuymeMXZD
        W7DdJqx2p8Cuv5ptAxj0h6WdFKThzYfymdlUy2QuQg==
X-Google-Smtp-Source: APXvYqy68RgSR7LotQ6w1Ve+SAV8NrTzlUFCC4DgU4WkGK95rCoLiBp4SVNArL+2hD6SeekjI/Fu8qmRwE/DIMpZ13s=
X-Received: by 2002:a05:6214:88e:: with SMTP id cz14mr12325839qvb.120.1568272526745;
 Thu, 12 Sep 2019 00:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <1568270355-29727-1-git-send-email-yhchuang@realtek.com> <1568270355-29727-3-git-send-email-yhchuang@realtek.com>
In-Reply-To: <1568270355-29727-3-git-send-email-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 12 Sep 2019 15:15:15 +0800
Message-ID: <CAB4CAwde2ciT8AtYOXP3NJw=fq3uano_GQYXNKjcL+M+hKeWhA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rtw88: report RX power for each antenna
To:     yhchuang@realtek.com
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        briannorris@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 12, 2019 at 2:39 PM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> Report chains and chain_signal in ieee80211_rx_status.
> It is useful for program such as tcpdump to see if the
> antennas are well connected/placed.
>
> 8822C is able to receive CCK rates with 2 antennas, while
> 8822B can only use 1 antenna path to receive CCK rates.
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 6 +++---
>  drivers/net/wireless/realtek/rtw88/rx.c       | 5 +++++
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> index 568033a..0861195 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> @@ -766,6 +766,7 @@ static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
>         s8 min_rx_power = -120;
>         u8 pwdb = GET_PHY_STAT_P0_PWDB(phy_status);
>
> +       /* 8822B uses only 1 antenna to RX CCK rates */
>         pkt_stat->rx_power[RF_PATH_A] = pwdb - 110;

It only uses PATH_A for receiving CCK rates packets? The comment seems
not clear enough.

Chris
