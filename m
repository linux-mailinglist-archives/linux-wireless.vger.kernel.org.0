Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB88F57E113
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jul 2022 13:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiGVL4z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jul 2022 07:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiGVL4y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jul 2022 07:56:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475869D500
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jul 2022 04:56:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fy29so8096608ejc.12
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jul 2022 04:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGjj7186mM2yO4GSFsDCk7/cUN+zmyGyR+LphmXz2M8=;
        b=Mix5xObPMC0ssFnT2y3C+FMvvPcVOxA3Igw2MWeI9+ec/R400laDHZsuoTeqpE99nW
         T4xYcE9JO5gHdIbO1/1gyEhZvMuJblizyKb75r13PW8wu1Y9pWjjqVs5z6i4ZKuESLm1
         6/hEcrzQZJLDv7UT1PsH1QK8b4a03hZmGB/nE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGjj7186mM2yO4GSFsDCk7/cUN+zmyGyR+LphmXz2M8=;
        b=lHXRcI5z3maZXRTcv7Um0k9onqP00W24c0r1KkubqBfD94biDkjtRmW5YqnsYu6sEN
         6CgMkJMgtnhVPOTWtCW3vh3ZaQbw1ebWjMQkPo5+G1oMXVn5JMKEBSaRaZ9Q3KX3nJCM
         UelxUWk3IEK5PMLC3YvkpGeOEBMW7q71v3o//hzad8kk3gUUkbXgW0h5/bzc8rS9eZpK
         R5TAN2k2c3MuLvokmjTt8kt6LnwmPyR6dNPRS1kCtWdyviSyxTGmC5p+axB0A41TD/Jc
         6ZCZQ9Z7FCHgCoLxM0TutzX4jzv5iA4VYFXhW5CAi4YOITdiC/zeU7JP3/NHscBrcbEf
         Siiw==
X-Gm-Message-State: AJIora8ou2Db0zofdxZVvEH6Bh5R+rMynNo48Ddse3k9NWINi/zuY+VW
        zAKLVwgIHSLrNYT7bUAVG1kZTA==
X-Google-Smtp-Source: AGRyM1vZqi+QNBJVN3VCcSzHHYrD6USsYIyVWHkO5BcBCNupFmEtQnqWTJQiLL0D2UavISs+owgbdw==
X-Received: by 2002:a17:907:1c0a:b0:72b:378f:2fa1 with SMTP id nc10-20020a1709071c0a00b0072b378f2fa1mr192530ejc.492.1658491007733;
        Fri, 22 Jul 2022 04:56:47 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id kx6-20020a170907774600b0072b3182368fsm1934370ejc.77.2022.07.22.04.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 04:56:47 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] brcmfmac: fixes from Cypress/Infineon
Date:   Fri, 22 Jul 2022 13:56:25 +0200
Message-Id: <20220722115632.620681-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

We have been using the following patches from Infineon (formerly
Cypress) on our CYW8935-based platform. They originate from the FMAC
driver release packages maintained by Infineon. Please consider these
for inclusion in the mainline as they address genuine issues.

NOTE: I got a checkpatch warning about author/S-o-b mismatch on the
patch from Syed:

    WARNING: From:/Signed-off-by: email address mismatch: 'From: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>' != 'Signed-off-by: Syed Rafiuddeen <syed.rafiuddeen@infineon.com>'

This is a technicality because the company changed its name. I can
re-spin if you want, but I am hesistant to change author/S-o-b of
somebody else, so any alternative suggestions are welcome. Thanks.

Syed Rafiuddeen (1):
  brcmfmac: Update SSID of hidden AP while informing its bss to cfg80211
    layer

Wataru Gohda (2):
  brcmfmac: Fix to add brcmf_clear_assoc_ies when rmmod
  brcmfmac: Fix to add skb free for TIM update info when tx is completed

Wright Feng (3):
  brcmfmac: fix continuous 802.1x tx pending timeout error
  brcmfmac: fix scheduling while atomic issue when deleting flowring
  brcmfmac: fix invalid address access when enabling SCAN log level

 .../broadcom/brcm80211/brcmfmac/bcdc.c        |  3 +--
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  8 ++++++
 .../broadcom/brcm80211/brcmfmac/core.c        |  4 ++-
 .../broadcom/brcm80211/brcmfmac/flowring.c    |  5 +---
 .../broadcom/brcm80211/brcmfmac/fwsignal.c    | 16 +++++++-----
 .../broadcom/brcm80211/brcmfmac/fwsignal.h    |  3 ++-
 .../broadcom/brcm80211/brcmfmac/msgbuf.c      | 25 ++++++++++++++++++-
 .../broadcom/brcm80211/brcmfmac/pno.c         | 12 ++++-----
 8 files changed, 55 insertions(+), 21 deletions(-)

-- 
2.37.0

