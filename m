Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1927DE6E
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 04:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgI3CVo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 22:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgI3CVn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 22:21:43 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98933C061755
        for <linux-wireless@vger.kernel.org>; Tue, 29 Sep 2020 19:21:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id n25so230585ljj.4
        for <linux-wireless@vger.kernel.org>; Tue, 29 Sep 2020 19:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/BCd40YbQgzD9EN03mnmrzEdJ2XYqRBE4b2P+bnn04c=;
        b=X+T8ij/vznZYSiDvlF9kRVFNTCo5yBKUgQZOg3dr8ZqnCtYNj1K11QDvM6ae09FV3p
         ghbdy9b1UF+cDVL1JUStnZ2bj0ZW2v8qR/dB5VPRJMYJZxabYKJpnK75Juuev6D6V3Ty
         nVgs+od6yJvbmlyWzWYZpdqKKQgJQXpPbhZ5FuNCD4TDh2qvNKEo36e0HpY2y5XoKFnp
         cY6IcweC4k1z9KNCJy7e59mV2ioDrHPoFq8AsnW8dAOFIboN3a9BGZEbn64qAKmGD3th
         tUD34OAWiHBrzq1KQSYNeke8zoHFm6t5Njwux/NCKA6otYe8oWFu17Q5PlC/KWtANmjT
         dlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/BCd40YbQgzD9EN03mnmrzEdJ2XYqRBE4b2P+bnn04c=;
        b=ShFfBtDcdSj462UuH9sQhPWLRggbfPkSzB4JOMdrCnhnH6/KrWQgn1E6zJWFCsrCqc
         PPPMUUHC47o4JzbmHIWzQLRY1dn0xS/hdJTgxtNEqamSG14Da/StglCMy1Gsjysxi1fH
         +HBYZXnYD3dJJfHGUq1ZjjvybuVcZkbQkHUnDmSn6GnMqlWOEaEBGlB8OpLTAvK8nGOX
         I4NoL5kfn2F0aHZAzeRRBmXedKKnD+/2M1d6jUKcwPDOcGfshUJwIkwEkIjZQyhJ8VIe
         idjGCQfZeE3tGTznz+TXufeV4jcyddIPbqQShlSYfb8Hh3zDWHeu5QDeIrlmdzS92VhG
         DQJg==
X-Gm-Message-State: AOAM532n5ydLFFeld7Wu7frwGIlYGBUry+DAT/gMFRXne3apLr8bDo4j
        jgxvpCxTSkVAR+KnKEpB0Zaph2T694TJaaL3WHfoHAZdxzTEkA==
X-Google-Smtp-Source: ABdhPJyH169KPH/8xkVlvwPcKmU12LigN1JS8XqW6wGVW7yV3mq6b7M9jmD0VJyy8+ZgKdYFefbx+ti1TI5ssFAriPY=
X-Received: by 2002:a2e:9042:: with SMTP id n2mr153531ljg.112.1601432501406;
 Tue, 29 Sep 2020 19:21:41 -0700 (PDT)
MIME-Version: 1.0
From:   Ramon Fontes <ramonreisfontes@gmail.com>
Date:   Tue, 29 Sep 2020 23:21:30 -0300
Message-ID: <CAK8U23bTXsJrCLbAOMB+qk5ZPrnaTOoncA3Xe=HGNBPwkNkc1g@mail.gmail.com>
Subject: mac80211_hwsim: wrong tx/rx bitrate when width != 20MHz
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I'm running 2 virtual interfaces: one in master mode with hostapd
(802.11n in 40MHz) and the other one in managed mode.

I can confirm that the AP is working on 40MHz:

ap1 iw dev ap1-wlan1 info
Interface ap1-wlan1
ifindex 221
wdev 0x6c00000001
addr 02:00:00:00:02:00
ssid new-ssid
type AP
wiphy 108
channel 3 (2422 MHz), width: 40 MHz, center1: 2432 MHz
txpower 14.00 dBm

as well as the client:

sta1 iw dev sta1-wlan0 info
Interface sta1-wlan0
ifindex 219
wdev 0x6a00000001
addr 00:00:00:00:00:02
ssid new-ssid
type managed
wiphy 106
channel 3 (2422 MHz), width: 40 MHz, center1: 2432 MHz
txpower 14.00 dBm

However, tx/rx bitrates of the client are not equivalent to the 40 MHz
channels. Only the MCS index seems to be ok and I can change it via
iw.

sta1 iw dev sta1-wlan0 link
Connected to 02:00:00:00:02:00 (on sta1-wlan0)
SSID: new-ssid
freq: 2422
RX: 1199869 bytes (12752 packets)
TX: 4055 bytes (41 packets)
signal: -14 dBm
rx bitrate: 6.0 MBit/s
tx bitrate: 39.0 MBit/s MCS 4
bss flags: short-slot-time
dtim period: 2
beacon int: 100

For some reason I can see the correct tx/rx bitrate right at the
beginning of the association (e.g. tx bitrate: 270.0 MBit/s MCS 15
40MHz), but right after that they change to 20 MHz. I have been trying
to identify errors in mac80211_hwsim, but I was not successful. Can
anybody help me? I did tests with/without wmediumd and the results are
the same.

--
Ramon Fontes
