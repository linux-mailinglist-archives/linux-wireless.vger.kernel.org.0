Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D576A2115A6
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 00:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGAWMn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jul 2020 18:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGAWMn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jul 2020 18:12:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117F5C08C5C1
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2020 15:12:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id z5so12400056pgb.6
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2020 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=z4mNTT/M5shWj3ZiwJB659mU2yoX0MNQ+EAM05N/HO0=;
        b=kHdg70/Ng3OW67/DQiZCOEtNz263LqnwSzIE7ddrPDpmldcTJrqnlkwhVKkuSTmqia
         HP4ZW/mpoDSJA2gBIF9p7Hx2r1KL0wDh67LIR98Q9c3848dzQzlpk9AEgVtUnJZ84wI+
         w6BZZZuKbpW4ziAx1TBSbLJfTfK2GTdur5YTw9unZxRlQFREXBMWMUaWWPG/GDHwHXp7
         9m42LC5qwXeTGCLNmLOKZTg1sdVhjgLPJUr/GBHy8YcFXnuaAYPJzrSr55+tfE+waN+X
         DtBndxokwFn+o0xycEpoahuyj2FDUFb1eHh4186vFGXGxXLDFsloTC8eI8jfPkR39mld
         HURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=z4mNTT/M5shWj3ZiwJB659mU2yoX0MNQ+EAM05N/HO0=;
        b=KqP2C0oe3Tv4iMIZJx6FJ0ot3TDLSmip5haeO1ZgWUYwR0BEd7OoAoWV/eU0EIZ2CI
         Y2iOKmgKLiUTFmVS5C3T2shhOeOHUt7AJjPun2n2ZqZ2x0lMv/92ofZNxWLJOOL34KYZ
         DGrjpOaY2LBsE+ZVLIAVxptmn84M9ldCM2AYy+12ziaNZXdbhyq7tg1dLimddMBx7IC2
         5093h5dKOuGckAVs2E3Z5NSFLJwJqyQeLpKGYXQNAmzhhp+NJuQmI7prH3oJM/yyD/b/
         kqqoXB1HBkdSj+YW18xb2gtFd8zvC7FGSESkKRDcHVayuZsTI72t8AFBibkupmo53JLc
         lgJw==
X-Gm-Message-State: AOAM530kAe61HKc8+Rygx6XZ7VIu7E1KBGh4NQomU3yUjJM5P1qBdjBo
        jd2aW/5dexM+250HIMJChrV2SJnp
X-Google-Smtp-Source: ABdhPJzwQVOCfxw/JiYDprogD6Ugt9zrHnMvOke8dQySgCKnTG7JFg0QgZHrV7yKaUIKuEjEV+Mi3w==
X-Received: by 2002:a63:3fc2:: with SMTP id m185mr22515034pga.426.1593641562294;
        Wed, 01 Jul 2020 15:12:42 -0700 (PDT)
Received: from host-29.home (50-39-160-111.bvtn.or.frontiernet.net. [50.39.160.111])
        by smtp.gmail.com with ESMTPSA id z13sm6934501pfq.220.2020.07.01.15.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 15:12:41 -0700 (PDT)
Message-ID: <ada14dfad76b93d654606c3b397de059d968096b.camel@gmail.com>
Subject: Lost beacon behavior changed as of 01afc6fed (hwsim)
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>
Date:   Wed, 01 Jul 2020 15:12:40 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

First off, everything described here is using mac80211_hwsim. I have
not tested if any of this happens on physical hardware or not.

Commit 01afc6fed seems to have changed the kernel behavior with regard
to lost beacons. So much so that it completely breaks all roaming tests
for IWD and (if kept this way) will require severe changes to the
existing roaming logic we have used for quite a long time. Plus
supporting older kernels AND this new behavior is going to be quite
annoying to deal with.

Before, the kernel would only send a lost beacon QCM event when it
detected beacon loss. This allowed us to scan, find a suitable BSS to
roam to, and then roam.

Now it also sends Del Station, Deauthenticate, and Disconnect all
immediately after a lost beacon, and the disconnect reason being
DISASSOC_DUE_TO_INACTIVITY (4). We handle these extra events as we
would at any other time, and fully disconnect which prevents us from
being able to roam quickly (as well as breaking tests).

Looking at that commit nothing particular jumps out at me, but
obviously those added flags are causing something else to send these
extra events.

Was this change actually intended to cause these extra events? And if
so, why was it changed?

Thanks,
James


