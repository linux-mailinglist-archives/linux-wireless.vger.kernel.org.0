Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5401745782E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 22:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhKSVjy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 16:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbhKSVjx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 16:39:53 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714EDC061574
        for <linux-wireless@vger.kernel.org>; Fri, 19 Nov 2021 13:36:51 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id y5so23951662ual.7
        for <linux-wireless@vger.kernel.org>; Fri, 19 Nov 2021 13:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lOKLQrhvfUzPs56nlN4o6ujSoAcpqItEhmOXcbtgQdA=;
        b=c5mt+ZIDXtzGGIYfOTNa4ggkKKNC+OLiymaUszGdfsDoOOIZtxGB4Hp7CCgG6JyGvy
         kEgEP9pAVjRtxPOcPbARGWRmUt3ETfGXfSp/Cqk1veV0P8czE+gxqTqaF0Y4z4/Eszkr
         HM92lipIRzyLoQCcFUg4S0NjPzW9R6eKUkVgwm4u8g7SGM405QWbKpivUi4TtUz/hK4S
         IOfagnYHFRmuuArINGjNlzVgWnY92Ep5G9wmosdrx4/BkE+rdGuF5bjHX73hBXzMvYQg
         2hnn8BiUEtLg1YFVguDKc1BSgIKu29PRdFaSWsnMw93S4JVR4XpIU+MY26ohKRKZU+eR
         CqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lOKLQrhvfUzPs56nlN4o6ujSoAcpqItEhmOXcbtgQdA=;
        b=DG+CGdJMPq+aiDhLDbxuz0u7kjFbw5C7D3Q/2h8gJkeFGsmEx53Du2HChKvVhAqZKh
         gVPlKPoYIEYirM5YJqZtDV98yd8cH4rtcvbn9lX9iJOuIkUzbqEbSK7aNrydwdMwQEKK
         Eu6lIGcpthNp4ZRaKd0PVHysizUUPW+m+6kCjeYpHvjKphVeYRAtoCeOAe3o5AH9q2nY
         3YNjKGOiFLi9UwC2eEKdqEuCNYfOj52H1f6VNxsjKCNIydcdLNQSjnsyO17+e1mQPO3k
         nCvxMV8gGoQvcZSwyKjBIhNzWfXOLgGhqdUs8XO2RvYklhgMQTkYrrp+nvDSCYVIn+f0
         zWig==
X-Gm-Message-State: AOAM530H0/Y87hISja17ZEr6s44jvlEMuplYBuu4W8Fn15M/SJGSwVVQ
        lGZ45UltXjlRLsXz+sWxt8+x+pDiyrhh/LK5lq5YR9lVAjY=
X-Google-Smtp-Source: ABdhPJxOC60VaTRfSelm67+s0JG6BeeVjqH/i/0c1hddFjtd55yk4iNBtqcGub4e4QUNu0s8cuQ6d0emz+0nINJ+II8=
X-Received: by 2002:a05:6102:214f:: with SMTP id h15mr98005962vsg.60.1637357810460;
 Fri, 19 Nov 2021 13:36:50 -0800 (PST)
MIME-Version: 1.0
From:   Jupiter <jupiter.hce@gmail.com>
Date:   Sat, 20 Nov 2021 08:36:14 +1100
Message-ID: <CAA=hcWT_dmKU1Uj4YmJ_rxZ+HsCVOEYJLSH-h3B3qqNhC1xi-g@mail.gmail.com>
Subject: mwifiex reset buggy
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

After days debugging, enabled CONFIG_MMC_DEBUG=y, I suspect the
mwifiex reset issue could still  be a mwifiex bug.

I use firmware sd8801_uapsta.bin, it is able to connect to the WiFi
network, but  reset either from WiFi modem or following command killed
WiFi, disabled mwifiex and wiped off /sys/kernel/debug/mwifiex/mlan0:

# echo 1 > /sys/kernel/debug/mwifiex/mlan0/reset

[  416.311114] mwifiex_sdio mmc0:0001:1: Resetting per request
[  416.333491] mwifiex_sdio mmc0:0001:1: info: successfully
disconnected from 34:08:04:12:b1:a2: reason code 3
[  416.366368] mwifiex_sdio mmc0:0001:1: info: shutdown mwifiex...
[  416.374812] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
[  416.381431] mwifiex_sdio mmc0:0001:1: deleting the crypto keys
[  416.387455] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
[  416.393423] mwifiex_sdio mmc0:0001:1: deleting the crypto keys
[  416.399401] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
[  416.405364] mwifiex_sdio mmc0:0001:1: deleting the crypto keys
[  416.411332] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
[  416.417410] mwifiex_sdio mmc0:0001:1: deleting the crypto keys
[  416.423293] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
[  416.429349] mwifiex_sdio mmc0:0001:1: deleting the crypto keys
root@solar:~# [  416.546386] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
[  416.583278] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
[  416.888906] IPv6: ADDRCONF(NETDEV_UP): sit0: link is not ready
[  416.894822] IPv6: ADDRCONF(NETDEV_UP): wwan0: link is not ready
[  417.302781] mwifiex_sdio mmc0:0001:1: WLAN FW already running! Skip FW dnld
[  417.310149] mwifiex_sdio mmc0:0001:1: WLAN FW is active
[  427.490344] mwifiex_sdio mmc0:0001:1: mwifiex_cmd_timeout_func:
Timeout cmd id = 0xa9, act = 0x0
[  427.499732] mwifiex_sdio mmc0:0001:1: num_data_h2c_failure = 0
[  427.505825] mwifiex_sdio mmc0:0001:1: num_cmd_h2c_failure = 0
[  427.511751] mwifiex_sdio mmc0:0001:1: is_cmd_timedout = 1
[  427.517216] mwifiex_sdio mmc0:0001:1: num_tx_timeout = 0
[  427.522686] mwifiex_sdio mmc0:0001:1: last_cmd_index = 1
[  427.528063] mwifiex_sdio mmc0:0001:1: last_cmd_id: 28 00 a9 00 07
01 07 01 24 00
[  427.535612] mwifiex_sdio mmc0:0001:1: last_cmd_act: 13 00 00 00 00
00 00 00 34 08
[  427.543248] mwifiex_sdio mmc0:0001:1: last_cmd_resp_index = 0
[  427.549058] mwifiex_sdio mmc0:0001:1: last_cmd_resp_id: 28 80 07 81
07 81 07 81 24 80
[  427.557033] mwifiex_sdio mmc0:0001:1: last_event_index = 3
[  427.562670] mwifiex_sdio mmc0:0001:1: last_event: 0b 00 0a 00 0b 00
0a 00 0a 00
[  427.570045] mwifiex_sdio mmc0:0001:1: data_sent=0 cmd_sent=0
[  427.575852] mwifiex_sdio mmc0:0001:1: ps_mode=0 ps_state=0
[  427.591087] mwifiex_sdio mmc0:0001:1: info: _mwifiex_fw_dpc:
unregister device

The /sys/kernel/debug/mwifiex/mlan0 was deleted:

# ls /sys/kernel/debug/mwifiex/

Looked at Douglas Anderson post "Fix Marvell WiFi reset by adding SDIO
API to replug card"
https://patchwork.kernel.org/project/linux-mmc/cover/20190716164209.62320-1-dianders@chromium.org/,
I believe mwifiex should be able to replug card after reset, is it
still buggy or is it the firmware sd8801_uapsta.bin problem?

Thank you.

Kind regards,

- JH
