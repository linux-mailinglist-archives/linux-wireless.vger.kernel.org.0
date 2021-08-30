Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CF33FB8F6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Aug 2021 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbhH3P1o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 11:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237416AbhH3P1n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 11:27:43 -0400
Received: from mail-wm1-x362.google.com (mail-wm1-x362.google.com [IPv6:2a00:1450:4864:20::362])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B8DC061575
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 08:26:49 -0700 (PDT)
Received: by mail-wm1-x362.google.com with SMTP id i3so9070357wmq.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RrIvaJZ/GjhxIo37rC4zzq6/oz+qoDd/3ecuQPVux5o=;
        b=BtInqqaRvi+tvj/zNMrgH4HVRQbXbX/Ba2rZoWVSeVgngTXvTbgvFp90mWeXb9IrCq
         +S3gfG263hc1pRVxg9L5dKqFeenwjwxryY2oowIU4Mu1IL9upOGqHuJhixyqFdK+z/dw
         2hXwVRDtSyszZWP6tJGkJr+WXL1iQoyuUWdfiq84UXH3qGSq9mYgZlIVvKnHbevB6PNI
         c59ZUL7l/WQFec1J3Z6nX7KO7c0sS/mnf8damXXOQ+/6w73VfREgsUnsuoNrnZx1/ii8
         sECfak2Ru22f7UymTUF5U9Rav87N2vysKbQYKNVt/IHsnUJhITwsX91OtUm8XFIkBnbu
         DJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RrIvaJZ/GjhxIo37rC4zzq6/oz+qoDd/3ecuQPVux5o=;
        b=PSoTXYTaxXFdOlfKM/avyigZFQ8chdz06ppNOD0QmNdxpowNFX2kfi2r5jIWghV5gy
         8dEU9loQSiNr49DBhtjcltomnupMLgnPOew8piYzPMmqmIs0JetHRdTVyePHpDV/rCqv
         db0MQxeXZY22+/bU5qmNvx0ZOnnGCdM3qpoNraVmiqIm6eIyEYN4++iaGY07fqmqcZKR
         j3XEZPox8GwPlM5pZkdZYh0GjxHtuaMxnAfdPXovAAGY2HxBnooOni7WZ8rxwzE0ay2P
         fbx5pD8jBSRcE82c8ngXjS4sCOeABU9SOg9pQQEk4Whhw+5jVskwfqU55miJgjMp+xRP
         kFFA==
X-Gm-Message-State: AOAM5302lcoDrXnC3tm12WDlGwkHFEu0tHnRGkZFEk5nAfdVAVlfjs6O
        s4QEzUClZQmrlPyKoWizUCFF97m/ZFOPLPOA+3UFuHg1oNOuCq3wmJ6n2tBcQmFeYdbVH4vUQbi
        bsvaCcq2O4yIJx2zp9KsDJwi7dY0zL829OVkCbZrGMP4+hKDXyxBoSv1oqiyaa4aRB2V7RPElgA
        +iCxzNb1y/AqeeBnRjv2IpP/BsLre9xQ==
X-Google-Smtp-Source: ABdhPJwQT+w11PKVsAe8yvCQ/H4GqlvdAfEUkz0+LgLyA8XAPYXB9B4JwlvqNls5V+2PlbnwFylBF+8mUybR
X-Received: by 2002:a05:600c:3b9c:: with SMTP id n28mr15483219wms.184.1630337207746;
        Mon, 30 Aug 2021 08:26:47 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id g15sm388399wmq.15.2021.08.30.08.26.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 30 Aug 2021 08:26:47 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.13.38] (port=37560 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1mKjBP-0005mz-AT; Mon, 30 Aug 2021 17:26:47 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     linux-wireless@vger.kernel.org
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        linux-kernel@vger.kernel.org,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: [PATCH v2 0/3] rsi: fix startup and P2P mode
Date:   Mon, 30 Aug 2021 17:26:43 +0200
Message-Id: <1630337206-12410-1-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series fixes an occasional startup failure when BT
coexistence is enabled and makes P2P mode work
(the two are unrelated but sending as a series since the same files
are modified).

Tested on RS9116 in P2P client mode against an Android phone (S8, Android 9)

For an unknown reason GO mode does not work against the phone but it
does work against a second RS9116 device.
In this case Android does not send a response to the 3rd WPA handshake
packet. It is difficult to debug this without the phone wpa_supplicant
logs which I don't have.

Regression tested OK for STA and AP modes.

V2:
  * rebase against wireless-drivers-next
  * add cc: stable to patches 2 & 3

Martin Fuzzey (3):
  rsi: fix occasional initialisation failure with BT coex
  rsi: fix key enabled check causing unwanted encryption for vap_id > 0
  rsi: fix rate mask set leading to P2P failure

 drivers/net/wireless/rsi/rsi_91x_core.c     |  2 +
 drivers/net/wireless/rsi/rsi_91x_hal.c      | 10 ++--
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 74 +++++++++--------------------
 drivers/net/wireless/rsi/rsi_91x_main.c     | 16 +++++--
 drivers/net/wireless/rsi/rsi_91x_mgmt.c     | 24 +++++++---
 drivers/net/wireless/rsi/rsi_main.h         | 15 ++++--
 6 files changed, 72 insertions(+), 69 deletions(-)

--
1.9.1

