Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D78240BCC8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 02:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhIOA6c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 20:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhIOA6a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 20:58:30 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43C4C061574
        for <linux-wireless@vger.kernel.org>; Tue, 14 Sep 2021 17:57:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p29so2325875lfa.11
        for <linux-wireless@vger.kernel.org>; Tue, 14 Sep 2021 17:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHrXpPpHxb8RmEqtjOabX0oNrFPU7C3TtcrOUaqGtBk=;
        b=VV7wQc92BEeCYJ7VBja4PoGDMAVqMC6CqfYl4NDmeJaYw/YrAM4uwae3iOXs5A3V0w
         k+8fp0wDxKZ4vNczkvMplY4JHQyWgghQrTa3js4AT62U9qLej4txKZX6/rl1TA/lqXK5
         yBj7MGxz2WKG57VL+QtY6/sSarX+imutB1E60xiJkkjwczSsmMRpjCDW6SEk+pb/Tz05
         d8sOcHvDRSgwgNKf5FabQ2hMrzUHWr5cIkJQP+8uCRQMN+7EMudco8pMfqA8RIxnDmlO
         jjZDTv8xWdAtrYLBFRkbALiDY5gKb5J2Y92AkC1aqepW/7wnOHc/Xt3plDe4vviLYTyD
         7zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHrXpPpHxb8RmEqtjOabX0oNrFPU7C3TtcrOUaqGtBk=;
        b=uAXvVTAc1KLHEORQrEHkO+LXr3CoIX0RW7nlpPizTWrprwjhoG5l7zXJ4TQNjAmHN1
         m8/EFof+3BIQh6LmOe9KGtpWHkwgQFyeAdz6sw3Y2PtJNu6Pynw8QNgtW1TzlldgchjJ
         Ug56WnDCI14P4pU7nYIJiqFFLY0zkSm4jm+1YEI9pYAhT29fVSfmzCiLKCF4x5gL4dP4
         jXX1VFXvfdD08XfRynTNs6kTFQxwKTVHBQLs3MOXr5pu8t8dahvVXqG50VFFTW5onsGv
         aQbqfYJhtoYgNcwEeRrX3Uz2slt3ury8oQJ49ADwidJ0WhjJJYRg9sZNp+KQhnMyfNml
         Plng==
X-Gm-Message-State: AOAM531XrTnlfM+qSBuU3RQLPPCEYREvw2Mne79UGbaaOhK3dfDIyh/2
        TKXN3bNIWA8rORHyC4ejWgUeB8murJ0gSxgCu8E=
X-Google-Smtp-Source: ABdhPJwCzgKQ6HiD3TdXFGf5J1ZGdteEz9HVEndFutfTLjP46nRacoVhV0zU7zLgercywpVubkudxgTKugtkeEaN+4M=
X-Received: by 2002:a05:6512:21b0:: with SMTP id c16mr15546095lft.100.1631667430112;
 Tue, 14 Sep 2021 17:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5CHuYX6heA-3+jJ+wHUOBFcLsiy43E9qOoOx3WuJ_kP_g@mail.gmail.com>
 <CAOMZO5CiWXEDKt6gJAUBkPjtogrHQtBcr0e3pn1+w1JiFqrw7Q@mail.gmail.com>
In-Reply-To: <CAOMZO5CiWXEDKt6gJAUBkPjtogrHQtBcr0e3pn1+w1JiFqrw7Q@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 14 Sep 2021 21:56:59 -0300
Message-ID: <CAOMZO5CbRjPLnnD2yHrbupMPZ90bYZOWEuN2KY5-9aN6YCYUWQ@mail.gmail.com>
Subject: Re: ath10k: Incorrect MTU size for SDIO
To:     alagusankar@silex-india.com, erik.stromdahl@gmail.com
Cc:     ath10k@lists.infradead.org, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        wgong@codeaurora.org, Peter Oh <peter.oh@eero.com>,
        jouni@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 14, 2021 at 9:04 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Thu, Aug 19, 2021 at 2:29 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi,
> >
> > On a i.MX7-based board with QCA9377 chip, I received the following
> > report from a user running kernel 5.10.48:
> >
> > "Doing scp or just pipe through files with >10 lines I get stalls and
> > error logs. The ath10k_sdio errors look like this:
> > [  196.822363] ath10k_sdio mmc2:0001:1: failed to transmit packet, dropping: -12
> > [  196.830109] ath10k_sdio mmc2:0001:1: failed to submit frame: -12
> > [  196.836279] ath10k_sdio mmc2:0001:1: failed to push frame: -12
> > [  196.925452] ath10k_sdio mmc2:0001:1: failed to transmit packet, dropping: -12
> > [  196.933090] ath10k_sdio mmc2:0001:1: failed to submit frame: -12
> > [  196.939334] ath10k_sdio mmc2:0001:1: failed to push frame: -12
> >
> > I am able to reliably reproduce the issue by sending a lot of data
> > from the i.MX7 board to a host connected via the AP:
> > printf '=%.0s' {1..24000} | nc 192.168.0.2 1234
> >
> > I was able to narrow the issue down to the mtu. If I set the mtu for
> > the wlan0 device to 1486 instead of 1500, the issue does not happen.
> >
> > The size of frames that I see on Wireshark is exactly 1500 after
> > setting it to 1486."
>
> I am able to reproduce this locally on an imx6dl-pico-pi board with a
> QCA9377 SDIO chip
> running kernel 5.15-rc1.
>
> [   10.383463] ath10k_sdio mmc1:0001:1: qca9377 hw1.1 sdio target
> 0x05020001 chip_id 0x00000000 sub 0000:0000
> [   10.393717] ath10k_sdio mmc1:0001:1: kconfig debug 0 debugfs 0
> tracing 0 dfs 0 testmode 0
> [   10.405764] ath10k_sdio mmc1:0001:1: firmware ver
> WLAN.TF.1.1.1-00061-QCATFSWPZ-1 api 5 features ignore-otp crc32
> 7746e551
> [   10.640195] ath10k_sdio mmc1:0001:1: failed to fetch board data for
> bus=sdio,vendor=0271,device=0701,subsystem-vendor=0000,subsystem-device=0000
> from ath10k/QCA9377/hw1.0/board-2.bin
> [   10.664515] ath10k_sdio mmc1:0001:1: board_file api 1 bmi_id N/A
> crc32 544289f7
>
> The QCA9377 operates in STA mode.
>
> Simply doing "ssh user@192.168.0.1" causes:
>
> [   55.824159] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
> [   55.832169] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
> [   55.838529] ath10k_sdio mmc1:0001:1: failed to push frame: -12
> [   55.905863] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
> [   55.913650] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
> [   55.919887] ath10k_sdio mmc1:0001:1: failed to push frame: -12
>
> and it is not possible to connect via ssh to the other machine.
>
> Changing the MTU size to 1486:
>
> # ifconfig wlan0 mtu 1486
>
> and trying the ssh connection again, it is possible to connect to the
> other machine.
>
> Any logs I should capture to help to analyze this problem?

If I clear HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE, I don't see the error:

diff --git a/drivers/net/wireless/ath/ath10k/core.c
b/drivers/net/wireless/ath/ath10k/core.c
index 2f9be182fbfb..728a18b3b462 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -730,11 +730,7 @@ static int ath10k_init_sdio(struct ath10k *ar,
enum ath10k_firmware_mode mode)
  return ret;

  param |= HI_ACS_FLAGS_SDIO_REDUCE_TX_COMPL_SET;
-
- if (mode == ATH10K_FIRMWARE_MODE_NORMAL)
- param |= HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;
- else
- param &= ~HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;
+ param &= ~HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;

  if (mode == ATH10K_FIRMWARE_MODE_UTF)
  param &= ~HI_ACS_FLAGS_SDIO_SWAP_MAILBOX_SET;

Any comments, please?

Thanks
