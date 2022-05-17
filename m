Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532F5529769
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 04:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiEQChs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 22:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiEQChs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 22:37:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C3F45503
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 19:37:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i1so16151243plg.7
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 19:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N4Z3ttvVzHXbNYocm+PUkl41ddhlKhaSdHT6s7W7AFk=;
        b=BVpnIr2ejBPRJk5pmhSZQxy74azIdkHZC89jT5zw0HxpxqJ1awTieqHgU2AmYA6GdN
         oolMdm07xe33m6IkLEs0rBWGRi7eNKp+8+YmJN5yn/gFEpApFQUgvJH5XN/7JV231D7/
         1pywdyrkGe5YqS1Bewl+OMt5V7EpDtOUbdKE5mkPkPPWSFz0jM39e1yQaQvtyBfDrP9C
         1l0HkxL0lvygVpsN5KAGz2onIPvyE9I5HpiAwWsVUFFLgTSxUE+4SYKmCCigQeOPkgdI
         DQ+7RXvAkEsrkX14jlvWNOdba8lgrNmFy0pvWoZDlAkW/NJ2D220fw8s7ogfkWYVqqPZ
         9z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N4Z3ttvVzHXbNYocm+PUkl41ddhlKhaSdHT6s7W7AFk=;
        b=kClKPbH6yJv7117Qt52YL0AAQS+aXG/LotGEpi8iZi78Z62VpJk54/9V+zHuh1es8t
         GII56iVyO994i+ZYt6T1M1I1uPMVhyWSDT9Icj0NtQmQ53Tbkzw0shz/cWMC/8SKfbdl
         SXsZL9Xz51dHVo6PYWvQqLgAHqaUjyjBoN2xqd9J0Z9AO8xFBkiK96/kVuM3AqP13bc6
         oSNkEE0opJ//QVCrOprYvDhkUjUA0v7nAblIOQ1vqRAARaIPm+xfy6iVlkFHsLNAjUsI
         oRs3N5qzx4JhKscL2rj5XkV1EI0QiUnonhdXekZFVh8X1WvaKJz4ITegRFq8GEQkeDY5
         u9rw==
X-Gm-Message-State: AOAM530y3zDvqvEl6rkqauOKdms0o7WrAIkHnfxUsi71muRKheTy1JSX
        IEyKTkGc7iJwaTrzPWFfARVvx+WaoCeQfUH91hbP0qvGptN/zQ==
X-Google-Smtp-Source: ABdhPJwF1bjJcbi/Rhh2rqzbCZch6U0cdwIBj2NQd5ZwMVJq5VCXmbpZswFaJM7ese1HiIsXiW4tIbQ/D3wJys9KmJQ=
X-Received: by 2002:a17:902:d4ce:b0:15e:90f8:216c with SMTP id
 o14-20020a170902d4ce00b0015e90f8216cmr20772260plg.65.1652755066178; Mon, 16
 May 2022 19:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220516032519.29831-1-ryazanov.s.a@gmail.com>
In-Reply-To: <20220516032519.29831-1-ryazanov.s.a@gmail.com>
From:   Edward Matijevic <motolav@gmail.com>
Date:   Mon, 16 May 2022 21:37:35 -0500
Message-ID: <CAByNJ6qDgqwxqGe0+uKSGCFKLULqEQ+NeBr-dAP=2Maov9ynqA@mail.gmail.com>
Subject: Re: [PATCH 0/4] ath10k: add encapsulation offloading support
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,
I confirm now my QCA9377 pci module has no regressions in either modes
with these patches
I was able to test it as an AP and it worked under ETHERNET mode
without any obvious regressions but I'm unable to check maximum
throughput

My hardware info from dmesg and tested on kernel 5.17.7
qca9377 hw1.0 target 0x05020000 chip_id 0x003820ff sub 11ad:0806
firmware ver WLAN.TF.2.1-00021-QCARMSWP-1 api 6 features
wowlan,ignore-otp crc32 42e41877

My quoted statement of a possible regression seems to have been my old
CPU acting up and is ok to remove



On Sun, May 15, 2022 at 10:25 PM Sergey Ryazanov <ryazanov.s.a@gmail.com> w=
rote:
>
> Hello,
>
> this series introduces driver support for hardware encapsulation
> offloading feature.
>
> The main goal of the series is an overall improvement of system
> performance. On a QCA9563+QCA9888-based access point in bridged mode,
> encapsulation offloading increases TCP 16-streams DL throughput from
> 365 to 396 mbps (+8%) and UDP DL throughput from 436 to 483 mbps (+11%).
>
> The series consist of four patches, the first three prepare the code,
> and the last one introduces the offloading support itself. The first
> patch reworks transmission status reporting to make it flexible enough
> to support 802.11 and Ethernet encapsulated frames reporting. The second
> patch reworks improves Ethernet encapsulated frames handling in the HTT
> Tx layer. The third patch reworks the module parameter that configures
> the main encapsulation format of frames that are passed from the driver
> to the hardware. It makes it possible to configure more encapsulation
> methods than just raw or not-raw. And, as stated before, the fourth
> patch actually introduces offloading support. It changes a couple of
> frame analysis places along the xmit path and starts reporting
> offloading support to mac80211 via the corresponding hw attribute.
>
> The new feature has been extensively tested with QCA9888. It works well
> and introduces a measurable performance increase on platforms with not
> so fast CPU (e.g. QCA9563). Tests with MT7621+QCA6174 show no
> regression. I was unable to observe any measurable throughput increase
> in tests with QCA6174 due to the poor perfomance the SISO client and OTA
> testing. Only slight downlink rate stability increase with slight
> reducing of the SIRQ load on the AP side.
>
> Tests with QCA9880, QCA9980, QCA9984, QCA9377 revealed no regression
> [1]. No specific throughput tests have been performed. In OTA tests with
> a regular load, there is a slight increase in througput stability.
>
> In tests of the QCA9377 in Sta mode, Edward Matijevic noticed a possible
> regression in the Ethernet tx mode compared to the Native WiFi tx
> mode:
> > There might be a regression in download bandwidth under ETHERNET mode
> > but I didn't do enough tests to see if was my PC or the adapter as the
> > upload bandwidth was similar to other tests.
> > NATIVE_WIFI performs the same as without the patch.
>
> Credits: thanks to OpenWrt folks Old=C5=99ich Jedli=C4=8Dka
> <oldium.pro@gmail.com> and Edward Matijevic <motolav@gmail.com> who
> helped me a lot to perform extensive testing with various chips after a
> RFC/RFT post in the OpenWrt development mailing list [1]. Thanks to
> Zhijun You <hujy652@gmail.com> who helped with the testing, pointed me
> to the previous work (see below) and the missed parts in the HTT Tx
> layer [1].
>
> Prior work: similar patches were independently developed by QCA and then
> submitted for inclusion by John Crispin <john@phrozen.org> [2] and
> latter by Zhijun You <hujy652@gmail.com> [3]. The work was not merged
> due to the lack of a part for 64-bits descriptors [4]. The idea of HTT
> Tx layer change from this work was adopted for the series in patch #2.
>
> 1. https://www.mail-archive.com/openwrt-devel@lists.openwrt.org/msg62013.=
html
> 2. https://lore.kernel.org/all/20191216092207.31032-1-john@phrozen.org/
> 3. https://lore.kernel.org/all/20210524103130.66693-1-hujy652@gmail.com/
> 4. https://patchwork.kernel.org/project/linux-wireless/patch/201912160922=
07.31032-1-john@phrozen.org/
>
> CC: Edward Matijevic <motolav@gmail.com>
> CC: John Crispin <john@phrozen.org>
> CC: Old=C5=99ich Jedli=C4=8Dka <oldium.pro@gmail.com>
> CC: Tom Psyborg <pozega.tomislav@gmail.com>
> CC: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> CC: Zhijun You <hujy652@gmail.com>
>
> Changes since RFC:
>  * new Tested-on and Tested-by tags
>  * new patch #2 for better Ethernet encapsulation support in the HTT Tx
>    layer
>  * rebased on top of latest ath-next
>
> Sergey Ryazanov (3):
>   ath10k: improve tx status reporting
>   ath10k: htt_tx: do not interpret Eth frames as WiFi
>   ath10k: turn rawmode into frame_mode
>   ath10k: add encapsulation offloading support
>
>  drivers/net/wireless/ath/ath10k/core.c   | 11 ++--
>  drivers/net/wireless/ath/ath10k/core.h   |  1 +
>  drivers/net/wireless/ath/ath10k/htt_tx.c | 61 ++++++++++++---------
>  drivers/net/wireless/ath/ath10k/mac.c    | 67 +++++++++++++++++++-----
>  drivers/net/wireless/ath/ath10k/txrx.c   | 12 ++++-
>  5 files changed, 108 insertions(+), 44 deletions(-)
>
> --
> 2.35.1
>
