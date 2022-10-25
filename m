Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2729260D598
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 22:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJYUe4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Oct 2022 16:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJYUev (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Oct 2022 16:34:51 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AED431359
        for <linux-wireless@vger.kernel.org>; Tue, 25 Oct 2022 13:34:48 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q71so12665392pgq.8
        for <linux-wireless@vger.kernel.org>; Tue, 25 Oct 2022 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K4idpmkzDBgIbVIVOkIoDw91xN0C1Ri4v3+lvv9+Gd0=;
        b=SsdGHf7mcgc0mw3x0Nxou+jWD7Yzfr/8TN70eljMThtqGt1SAMy+sbeY3wMbaG4/h/
         ARsQXXdkdYTnu+Sgp+7m8qsaqpJFjU1xgWPlppE6HcE2QtYMLGGR3tcGtazSDj6aRvbP
         BfluYK1sm0jk7MpBezhrmEqNto2FzBtk34SY5Pd83/77dxkbygOSoMwJhpu+w9xj4gi3
         H6drvb4o/IangNxKBRQGxZx5+qpJOnOEh7N0+F+lnu0Ex9Kd0QGYUXmIGBG5M5uSm8XX
         mswW4fPsFp42YshmohHMTq05QqL6v7jwGTOyIEtnZEEaWTDRakfGt749ILBwIEZcmizL
         b1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4idpmkzDBgIbVIVOkIoDw91xN0C1Ri4v3+lvv9+Gd0=;
        b=5czSpXSR9r2O0gdxYUAtBz4ZJKhZc6hQVWqyMLv8wPrScA3yJ0bkDGBL84YYMqb9+l
         IGmeMzMfoY+dZpHRz8qi6x9DjmwSTcVdXxFEbkrZdoQr9UbigFG5szNV4b/lzH//5/Be
         5CzYjpBYNnqSvG83MVLUL11I9tNjysbVtrCXNj44SfpSaAr9TLJhgSYEMVtqD/37OsAh
         jjZH9NAxaT2ChhMQTHTHmsMH57iCAXWrrudFXtIoL0a2a3uCLswJ38Gx4Y4PwldMPnQV
         FihY/c5EgoNidnzGiOVBYpnCvLWReTRKrUcOMPu9oXRn9nRMGlJZQWX/QZxhaE1akNld
         Sy+g==
X-Gm-Message-State: ACrzQf0xF+W6gE1T/bZhmKRnPmTGXKPHuZQCujG4Of+8kKre6kzTnx/U
        xQMRMMk11wuSOx3Hs66uJDoCgjYqiXo=
X-Google-Smtp-Source: AMsMyM77EwmHdy0cPNAGH8xE4Wq1vwkn7JYpz6Hc2Bjm6/STJytbNhnz374okBALGgKFQBAWNiksBg==
X-Received: by 2002:a63:5511:0:b0:439:12f6:fb9a with SMTP id j17-20020a635511000000b0043912f6fb9amr35025644pgb.197.1666730087628;
        Tue, 25 Oct 2022 13:34:47 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id n22-20020a17090a161600b0020dd9382124sm5514731pja.57.2022.10.25.13.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 13:34:47 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/1] Fix __ieee80211_disconnect when not associated
Date:   Tue, 25 Oct 2022 13:34:42 -0700
Message-Id: <20221025203443.410121-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A user reported some behavior where IWD hangs expecting another event
to come and it never does. This was due to the firmware (iwlwifi)
timing out after authentication and calling __ieee80211_disconnect
which essentially does nothing if not associated. The problem here
is userspace expects some event to come after authenticating whether
it be an association, disconnect, death etc.

This my attempt at fixing the problem. Note that the real issue
here is iwlwifi. The user can reliably reproduce this problem which
points to a firmware issue since a connection loss should be quite
rare I assume. Regardless, any bad driver/firmware could cause this
behavior since __ieee80211_disconnect only handles being associated.

I personally cannot test this, so I hacked mac80211 to call
__ieee80211_disconnect immediately after sending the authenticate
event. This effectively causes the same behavior and indeed this
patch causes a disconnect which is the behavior I would expect.

I asked about this a week ago with no response so hopefully this
gets more attention and at least gets the conversation going, even
if I went about the fix wrong.

James Prestwood (1):
  wifi: mac80211: handle connection loss in __ieee80211_disconnect

 net/mac80211/mlme.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.34.3

