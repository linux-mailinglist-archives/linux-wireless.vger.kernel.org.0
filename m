Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642C26AFA59
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 00:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCGX3l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 18:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjCGX3g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 18:29:36 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D3AA8C71
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 15:29:34 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536bbe5f888so274363567b3.8
        for <linux-wireless@vger.kernel.org>; Tue, 07 Mar 2023 15:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678231774;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bJ6NZHGkpRkTiX3dCTEr0XpMAJGOf1LnwlOlGKi6QGE=;
        b=LcNU/709IurQswTVxBtCwgR9Z2x/h4HzmHztuGemk+HqU20yL1bwP35EH/mh1El6eq
         5bMbBLbfGHqzALPUVLFeFpwOEW9C2uBczKaY2k22drs7ToO6lGApb7gv0j0UV4SmHWZn
         hSRAqvLX3yMGg8MdPRU7QCps7HM0O+7Pk0I9CsTDQ68RgxwDAyHUZMEKE0MoJHbNqRl0
         8BrE6MyFYFboE1QJoeEZp5h4LUxd+oLn6PmhH+Mi0i/gqxRf2l3FxiiS/jsymN54YdhY
         lquSMtFjxC1b5F4JQtplORJh8XRcXjnDr8GSVlhqntx90A2d+mo5wiA3SCELmwu8fPVM
         yhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678231774;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJ6NZHGkpRkTiX3dCTEr0XpMAJGOf1LnwlOlGKi6QGE=;
        b=KM6eu9Dvzd1fzuU0IQMQfmdbYIqcF++ny2nHf3NMu+KNt77Si53HHiZ0DNViXX+kKY
         J5IDvdS4j5FyeaWpygX3HuSGbS9ToGeCo2EkBleVgBjJMH2Hsa1p+5W+Zavgnl1WEVgw
         KcAV2T56Qbewo3E1nw9kwPHmMWz9eJsAfcf05aYheFCcUrdLshKfBX+Y8cARRFRtWrCw
         oYlUToEN8ttki/ttdc9eIMRBT5rgRL9bnenb65IujGTzJ5BdkmKsOJOl8x4SiS43fAj3
         tt7VlWJJLga3KsQxS7uz9uPtsmWab+jigP0Dsi0z1VYsgPFHHmjwlIwnUvHcfsaSHhqW
         H2tw==
X-Gm-Message-State: AO0yUKWOIkRFUeNTQH9H4mRlqou5yeIO0o47BZr9jLfv9h5xWLvA2Wa+
        lHJWsTj1ACA8zO5Fqog8+uMprbHQQbmhdWdZ5ROe5raVSg==
X-Google-Smtp-Source: AK7set8L5GqQUZAEqG3CRHb/tUayapEvWXAA+oDKRRNBiVBSnUrsbzjOlC2zk7IfChRTX+lgL6lxCLMMEQO3UZZR/L0=
X-Received: by 2002:a81:ac65:0:b0:530:9fa8:74ab with SMTP id
 z37-20020a81ac65000000b005309fa874abmr10502720ywj.3.1678231773911; Tue, 07
 Mar 2023 15:29:33 -0800 (PST)
MIME-Version: 1.0
From:   Tim K <tpkuester@gmail.com>
Date:   Tue, 7 Mar 2023 18:29:20 -0500
Message-ID: <CA+shoWTCExx7UQsC07mXe0FnuQDC6FGs_Vfd0qgVV+9V6wGrQw@mail.gmail.com>
Subject: rtw88: Monitor Mode Stability Issues
To:     linux-wireless@vger.kernel.org
Cc:     s.hauer@pengutronix.de, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

All,

Please excuse me if I am breaking mailing list etiquette, this is my
first email here. I was advised to CC some developers, so please
forgive me if this is too forward, or in the wrong place.

I am experimenting with an 8822bu dongle, and doing a packet capture
on monitor mode similar to kismet. (I have a simple bash loop doing
channel hopping in one window including HT40 and 80 MHz channels, and
tcpdump in another.) After a varying window of time (between 1 to 10
hours) the monitor interface simply stops receiving packets. There are
no output messages in the kernel otherwise indicating there is a
problem.

Cycling the interface doesn't resolve the situation, I have to rmmod
the driver, and then re-modprobe it. This allows me to get packets
again, but the packets stop in another few hours.

I am running this on a BeagleBone (Debian 10, Linux 4.19) and have
just setup a second copy on an STM32MP1 (Debian 11, Linux 5.15). I am
running the driver from lwfinger's GitHub repository at 4bede29. I
have cross compiled the drivers with cpp-arm-linux-gnueabihf 4:8.3.0-1
(Debian).

Interestingly enough, there seems to be a parallel issue. Using iw to
probe the phy info, it seems that all the 5 GHz channels are marked
"no IR", even after I set the regulatory domain to "US". At one point,
changing the regulatory domain caused some kernel messages to output
about "rtw_get_tx_power_params [rtw_core]" from phy.c line 2069 --
this was on, I believe, 3af004d.

Any ideas on what could be causing this, or steps to help troubleshoot
/ provide more information?

- Tim
