Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A9E10E511
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 05:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfLBE22 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Dec 2019 23:28:28 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39312 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfLBE22 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Dec 2019 23:28:28 -0500
Received: by mail-oi1-f193.google.com with SMTP id a67so12427087oib.6
        for <linux-wireless@vger.kernel.org>; Sun, 01 Dec 2019 20:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LgBboMICnj2iH/rTV3073CJYWv5GwAcBJW5M29WGpSM=;
        b=syV3j7Hu11m63kUcNojo+OWUMCIOEiyL67jEJRiTEogknwMiiNReGl8MoFceA0T5PH
         Y6KbGDFDeWaOGCUVP5Rw6wjFhgkyLr/KpaWNVM/Ft2E2bQLASRi7izviemMikrM6HKvP
         A0+SPGXipMhkW2kqS8mgL9l6K7Sz1nppUdbk35BcGEvxcQjkiDs1vNuuXZdbInXreitH
         gtlSP1Bxgl7HjxP6hhCeY37LlQVdob9hvPt7xUvoJHTorp6MifkpJGrz2VWogL4K8ELP
         E2rZVeO+1pEJ/FM7YF1oN8LlHOZA5dLb/utxEY8WgP2dlJrAcTgyxoWV/d242yQQW//A
         mC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LgBboMICnj2iH/rTV3073CJYWv5GwAcBJW5M29WGpSM=;
        b=sFbeOmurA2t6DvQRM76ydEJgHYEcAZm96urOVqV+5p8DtrflQCaxmQqVPY5OXjJBEK
         ueTFG34OLl82x8/nzUfmcA0oQdvgBOIix+jiQmB9ewikF+mgjNb6/qnCCGbGs01C5ir0
         jJHMq5vT8wOuGhKcPARXS98gVqinMA3cmTTTjoCprMeU1zFa0YjnEtvI8MHeINQc6l5q
         mwhIsBgN0LBYHqPltCXK4wNYIsoLw1GTfDItmTuifyahGUumJ5VgH5OhvGar4aSmlriO
         X3URe6g0xaK9Mdv4yamNcRASloVsPRcsXLSwk4FbZD3iWW9fT3jR/2wQkO0akm+ike/V
         7fsw==
X-Gm-Message-State: APjAAAUKepRzVlKbLjdHotvbVfH7ejjgbtuciqJeylkZE/41gTQUUbtf
        ZNszvDMBpV2+oAWp/kF6oSQujKL5rCoTt5ndog8=
X-Google-Smtp-Source: APXvYqzhNYYWtmhWCXwpdpaX8OwGnHKvv0/o3rhmxqugZEEMHkcjio3shH32OAJteV5w+dQBR/u9TaUMDbYFUX58hns=
X-Received: by 2002:aca:f305:: with SMTP id r5mr10458267oih.174.1575260907465;
 Sun, 01 Dec 2019 20:28:27 -0800 (PST)
MIME-Version: 1.0
References: <0101016eaacca72d-a73d6fb5-0e3f-4fbb-9045-8363270fe25f-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016eaacca72d-a73d6fb5-0e3f-4fbb-9045-8363270fe25f-000000@us-west-2.amazonses.com>
From:   Justin Capella <justincapella@gmail.com>
Date:   Sun, 1 Dec 2019 20:28:12 -0800
Message-ID: <CAMrEMU89NCJ4HKVqirYrNTC83Hv8HpT7uKrvQ-3p3Bvju=8_-Q@mail.gmail.com>
Subject: Re: [PATCH] ath10k: set max mtu to 1500 for sdio chip
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

So I understand the reasoning behind using ETH_DATA_LEN, but would it
be more future proof / obvious to the next dev to calculate the size
given the interface's parameters/defines--- I get that the values were
chosen to align with this but just worried if things were to change
over time this would not be resilient/obvious thing to fix up?

I was curious if these changes would have any impact on things like
WEP where the frames are a little larger? I came across a random post
about 80211 mdsu/mtus here
https://www.cwnp.com/forums/posts?postNum=307311 and they had
mentioned it, so it got me curious

On Tue, Nov 26, 2019 at 7:00 PM Wen Gong <wgong@codeaurora.org> wrote:
>
> For sdio chip, the max credit size in firmware is 1556, the 1556
> include payload, ieee80211 header, htt header, htc header. So it
> need to set the max mtu to 1500 to forbidden TX packet which exceed
> 1500 form application.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/sdio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index 60849ab8088f..8aa8ebc1d8e9 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -2185,6 +2185,8 @@ static int ath10k_sdio_probe(struct sdio_func *func,
>         bus_params.chip_id = 0;
>         bus_params.hl_msdu_ids = true;
>
> +       ar->hw->max_mtu = ETH_DATA_LEN;
> +
>         ret = ath10k_core_register(ar, &bus_params);
>         if (ret) {
>                 ath10k_err(ar, "failed to register driver core: %d\n", ret);
> --
> 2.23.0
>
