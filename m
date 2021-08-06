Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960493E287C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Aug 2021 12:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245044AbhHFKX5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Aug 2021 06:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244916AbhHFKXt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Aug 2021 06:23:49 -0400
Received: from mail-wr1-x461.google.com (mail-wr1-x461.google.com [IPv6:2a00:1450:4864:20::461])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC1BC061799
        for <linux-wireless@vger.kernel.org>; Fri,  6 Aug 2021 03:23:26 -0700 (PDT)
Received: by mail-wr1-x461.google.com with SMTP id j2so10380613wrx.9
        for <linux-wireless@vger.kernel.org>; Fri, 06 Aug 2021 03:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qvoGztO/h6ZCjQn+dP/ewRm0uJwvqUO8fnqmidor9bg=;
        b=p7FGNcoXVZ2XiEQJnto6NFd8GFgEJXyAqwoSFv6jskX/gQtmoiwAA/62QuvjstrCwU
         lQ/6hS0/wnbTsI05/ijBJrZpcmCcZ1JqiqMuLb/by4TQJqvA6yUIJDeCA7aFW6nds6Uk
         pYQpRhukwzGSRXNEG98zw/UY1qVZpBQH2shwQ4Fg2A7Yj64rVvp3M7D85Gb5ynRCzrmD
         TR/R+3pTXRIjqQ1+p21LSpm1QLPPODvcUT/Yk067+Rg/PX4weFQcLqM9O+EFMc1uaMtN
         /7EBlPglmkSpv56QzRyjKXonk6MMJDx52OZDAUwQJLisPnoiRDHdWV4/EETohl6qVkt6
         p0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qvoGztO/h6ZCjQn+dP/ewRm0uJwvqUO8fnqmidor9bg=;
        b=YdPLJCPVL3ESXrLesRW/ikg+U9w9lOFbZTnkB8PzuxQ9+9sOuw7ocFd4BWjQMgvOdF
         t0EaEeR5PG5vp3PEXr2HMfnlpQIUg5KbkAQEvYrk+BU7zQP7FG4IkTZ9kGotWQtlfkCD
         5e/oGl+GHcm28pIAyfKcV2FQNX1FgOlPBRCnbskxfGaBnaRffqk+6AJYAghhLqzyty8W
         XyaQvtTnHsMPD++l2AcWSUBZX6/TdTn/Kag9k07//+mUhuIwIHh7ADUZUXEzFLDiAck0
         cpYQJLua7VhBHd4BcBLLhXAMF9pSxOBae8ibw/ietkdXvSHnYPQIedPxG5Cdf1B3Mpf8
         OpHg==
X-Gm-Message-State: AOAM5330sbYAoP4CTp/uQM3ayvuTm6kdYFTUh5ECxCahi0SFzdomT5CT
        +mpEakSQeY/zkpQZDoQMAlzPM4Sd5c4kyDZdlkMcO4TTYIRSgEPSnqQ/VU9ah2Qray3+WlRPyD5
        9xGixSr2Pjt1XULR5dcE30B989uY0j2L5C1zqbMJJu5+Ub/wZkZGkwXDkv1Rd5uB3DtYfE2laTO
        LPtjPQO0RmwNC+pLQMxM7r2mJiH3haRA==
X-Google-Smtp-Source: ABdhPJxMHMaaT8C9xcQ3r/DEySFBzmQYO4dALmp0PPNQQKQZ4gMsTRuz/8xLLxYYbwKSA9cBGs3jRWXfvH22
X-Received: by 2002:a5d:684a:: with SMTP id o10mr9823963wrw.384.1628245404823;
        Fri, 06 Aug 2021 03:23:24 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id m18sm282166wmg.38.2021.08.06.03.23.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Aug 2021 03:23:24 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.12.14] (port=47598 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1mBx0e-0006b1-FZ; Fri, 06 Aug 2021 12:23:24 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     linux-wireless@vger.kernel.org
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        linux-kernel@vger.kernel.org,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: [PATCH 0/3] rsi: fix startup and P2P mode
Date:   Fri,  6 Aug 2021 12:23:20 +0200
Message-Id: <1628245403-2517-1-git-send-email-martin.fuzzey@flowbird.group>
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


Martin Fuzzey (3):
  rsi: fix occasional initialisation failure with BT coex
  rsi: fix key enabled check causing unwanted encryption for vap_id > 0
  rsi: fix rate mask set leading to P2P failure

 drivers/net/wireless/rsi/rsi_91x_core.c     |  2 +
 drivers/net/wireless/rsi/rsi_91x_hal.c      | 10 ++--
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 74 +++++++++--------------------
 drivers/net/wireless/rsi/rsi_91x_main.c     | 16 +++++--
 drivers/net/wireless/rsi/rsi_91x_mgmt.c     | 24 +++++++---
 drivers/net/wireless/rsi/rsi_main.h         | 16 +++++--
 6 files changed, 72 insertions(+), 70 deletions(-)

--
1.9.1

