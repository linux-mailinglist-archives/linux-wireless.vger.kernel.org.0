Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DD1428B03
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhJKKsy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 06:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhJKKsx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 06:48:53 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C15C061570
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 03:46:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t9so70718819lfd.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=WpgdAJjO8KWwGTfSShcuZNH5VDBopLDqz+ukb3W8eoM=;
        b=KRCu1Ph1TIn56av0wUC59o0amEJyST3tH0sq+cxoFuTIYLtQvCHPttQdlBgtvxzOcs
         Ti3CyDV1Wr0sylj9A1JuDRF3EDFj0IbbfnwyVWSKOKatSN1R0zdKh6m3f0lz2TQsPwzr
         bOfYS5T5uaFngflcLKPTjTN5+aOCNkWd07jEHWwUSgYtL1xgUvAuf+ZXGLT0ZxCWCkZP
         p2CLVCRaIWiHtmURYwTdZj+4GrpTcocU48N3po4DGbTCIqCezNZ3noKywsnVtEjUWtgL
         Py+6M0uAKGerxSA+OM25WRtzKy80tIjSjVwtUUcyLU9gVV2QCeGRZEkB3eIdcP9SluQE
         5Hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WpgdAJjO8KWwGTfSShcuZNH5VDBopLDqz+ukb3W8eoM=;
        b=OVYUQW8+PS+CqUlQZkTtH1+A5+yMVkMY8nRx5XdegbQSuysvOWzU+yk7dP5Pzm4Yv+
         WOkT+RTfTC/in3oe8MXq2AdvbJ/UevrzRDBOiRqB6sBYlG7odKGy1q8kqP8DRTxrNibJ
         QhYdNTxFhc7SILVL5Q5k2dYjjYCDRlPThVQ00tKzM+syjHv7H5MuuLEsv4qh1TkRrcUh
         Vkc1rHO3mme0P2xoCTcNJT3Te/PEqAFNNchv4rVCuuF6rKiB80McK3BsSt+hIZxsGkvG
         DuhEuPfGwAJlQMcWfiRJ5e8mSpFtwi0W3ozpUublYiNa7HX+HNwefBjbgmEZkUOnDEx9
         Kujg==
X-Gm-Message-State: AOAM530Xr5v/6E+BKJxgAS3R9BEE7CjboKeTJsusoJC2e9ejTiRqoaWq
        szdX/M8aF69Vlj3KtR85C9YJiHpxDZ/r+qB7mTVWgXyKZDo=
X-Google-Smtp-Source: ABdhPJwHunOV+kvldwSj7jGTfWY7v73HaIS/W1iPhW4tOrwCeQpFvXNrd8qY3/VPhOu3P5wi2yh6WdMQ/Acc1aAXMA0=
X-Received: by 2002:a05:6512:3b8b:: with SMTP id g11mr6624027lfv.216.1633949211359;
 Mon, 11 Oct 2021 03:46:51 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?TcOhdGjDqSBLb3Bww6FueQ==?= <mathekoppany@gmail.com>
Date:   Mon, 11 Oct 2021 13:46:40 +0300
Message-ID: <CALOm-MsEcY7=MwfoEzhCQqSUM6qANy=oP5xYmoPqHAaADcscwA@mail.gmail.com>
Subject: ath9k: unable to connect to hidden SSID on DFS channel
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I have a project where I want to establish Wi-Fi connection to a
hidden SSID, on DFS channel.

I am running wpa_supplicant 2.9 on a device with:
"Linux 4.9.51-yocto-standard armv7l" and
"Network controller: Qualcomm Atheros AR958x 802.11abgn Wireless
Network Adapter (rev 01)"

Sounds an old project, I know, but want to bring this alive, if
possible. Unfortunately, connection to a hidden SSID on DFS channel
seems not working.

However, it works on a different, newer device, which has
"Linux raspberrypi 5.10.17-v7l+ armv7l" and
"PCI bridge: Broadcom Limited Device 2711 (rev 10)".

The wpa_supplicant on the two devices is mostly idem: same v2.9, same
runtime configuration, almost all config variables (wpa_cli dump)
match (not seen relevant difference). There might be compile option
difference, but don't think they are relevant.
The only thing I see is with driver flags, where the newer device
supports flags like DFS_OFFLOAD, BSS_SELECTION, or
4WWAY_HANDSHAKE_PSK, but the older device does not offer these.

So I suspect the issue is due to some of the above missing features in
my ath9k driver (have default driver provided by kernel).

Questions:
- is it possible to enable the above driver flags/features for ath9k?
If so, how to enable and are there patches for these?
- any hint where to look in ath9k driver for passive scanning
implementation? Is there another module/location where passive
scanning is implemented?
- any suggestions for a solution to my issue?

Thanks,
Koppany
