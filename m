Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EE074C18F
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jul 2023 10:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjGIIOo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jul 2023 04:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGIIOk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jul 2023 04:14:40 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBD5109
        for <linux-wireless@vger.kernel.org>; Sun,  9 Jul 2023 01:14:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so50529581fa.0
        for <linux-wireless@vger.kernel.org>; Sun, 09 Jul 2023 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688890477; x=1691482477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cz+2PLpEunsGXWPYKnCgCYavce6GRxsSsnNMgNcFMdc=;
        b=SDS+snrNKf6RDQVuJnqHw0EdaKtlTlwHQRAGQFHwBKZpngAm/vJua/OtztO5U9jQOx
         viPUju6pyKFabV85IknHRV3+eUA5mIvokrJ6X0s4ro1RP+EOeBPWzEjCNNI/3qWHXBBc
         IXehFnp1XjQMV4N9X1RMWUmlSDhNkyhK0ekiRYjzy6TcAYjx81lGwOfxe+5hdEQrxyPC
         GEA7RCcf9z59z95nyFw+nk7wvU9L/SpJ6tzoYFOTCe+iDdj190GgRbMAKN7WiXFyEXfp
         iOmFxbInTc6LTd7XJgE14X7iw0prmD2n/tkRnpThpyDTNImMcM7iixmJQAItiAuuGAtw
         /8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688890477; x=1691482477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cz+2PLpEunsGXWPYKnCgCYavce6GRxsSsnNMgNcFMdc=;
        b=ZHk94WsXhELoDmt2Wiwdsf9BsXLvIuQLOa9KDIzot4E1PHYzUxKxp4UXL1PueRb8Ey
         yDcfi+97OEaPEwWGfoxmRXTojKsZLbMB7Mq0qeGoEyYai1nYvC2EUOTcjLCcBbKpCMOi
         mZJELJRV64BZmeIwuoP+9idItUgBvHxRPhT8wYHJgR+sp3xKj6DpREIsrlA+X24Kb2W6
         ljMy3g6/pWesoO4BToACNnfHmO5DrUS/05hYfFc33DXZSyoi9bGdCtA04xnnSZwY3ddq
         KloZMEn5vgV9c9Qmd1cGRAaZDowqFPVK8KihvT4px53s8/Qnj2mh97aB6WttFUKVk5Ll
         ePFQ==
X-Gm-Message-State: ABy/qLZ016jO0VcD2oiMbJijVjiqvFKaMzmfcbF1o8+2UmYwzqmpvb7M
        a0QY+TVL7rNUwMHs8u/EfXROMfXVZcVzHCRBKWWQUPcEliw=
X-Google-Smtp-Source: APBJJlEm9bk0Py2kb3cM0SRtq/ShA8ZuImDXiqyvZsn3yTILcygUDk4zx2pvCUD+9U0sH3ARHrqDbvGFpTRchW5WqDA=
X-Received: by 2002:a2e:7318:0:b0:2b6:d92e:16cf with SMTP id
 o24-20020a2e7318000000b002b6d92e16cfmr6232517ljc.50.1688890477043; Sun, 09
 Jul 2023 01:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAMP0i8mHkvXtnkb3miNYMfy9M==xy3Jm501V5O+md=G=r-EWbw@mail.gmail.com>
In-Reply-To: <CAMP0i8mHkvXtnkb3miNYMfy9M==xy3Jm501V5O+md=G=r-EWbw@mail.gmail.com>
From:   Andreas <anteus92@gmail.com>
Date:   Sun, 9 Jul 2023 10:14:11 +0200
Message-ID: <CAMP0i8kJGxiQ6oQROp8gZCCgEW_N0WREsoPnWHaj=ODQYWM33Q@mail.gmail.com>
Subject: [PATCH] wifi: mt76: mt7915: fix AX slow upload by disabling AC160
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes slow 802.11ax upload on the RT3200 with mt7915 non DBDC.

In AX mode the AX upstream to the MT7915 radio drops to the slowest
connection mode: MCS0 (zero) single stream NSS1. The issue has been
observed on Apple devices and Intel cards under upload load and with
some obstacles in line of sight and distance to the AP. While under
the same conditions AC speeds would be much better.

"It is probably a firmware blob bug that is being worked around by
disabling AC 160mhz. Unfortunately, even if users select 80mhz AX in
Luci this bug will happen. Basically, without this patch AX is
completely useless for people with affected devices. So in my opinion,
disabling 160mhz AC seems like a small price to pay to solve this bug,
especially since 160mhz AX remains available."

"160 MHz capabilites are out of specification for MT7915. MT7915 was
never advertised with 160 MHz capabilities, our devices here are
instead marketed with 80 MHz bandwith numbers: AX3200 - 80 MHz
channels. Mediatek - the vendor - has completely dropped 160 MHz
channel support for MT7915: [MAC80211][mt76][remove mt7915 BW160
support]

With the out of specification AC VHT160 capability enabled the whole
AX capability is wasted for several users, because it will slow down
some AX capable stations to the slowest AX uplink rates. The user
workaround to switch MT7915 to AC mode works but no AX advantages that
the device was bought for can be used."

Forum thread https://forum.openwrt.org/t/802-11ax-worse-than-802-11ac-with-mt76-driver/126466

Partially reverts
https://patchwork.kernel.org/project/linux-wireless/patch/20230301163739.52314-1-nbd@nbd.name/

Signed-off-by: Anteus <anteus92@gmail.com>
---
 mt7915/init.c | 1 -
 1 file changed, 1 deletion(-)

--- a/mt7915/init.c
+++ b/mt7915/init.c
@@ -420,7 +420,6 @@ mt7915_init_wiphy(struct mt7915_phy *phy
            if (!dev->dbdc_support)
                vht_cap->cap |=
                    IEEE80211_VHT_CAP_SHORT_GI_160 |
-                   IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
                    FIELD_PREP(IEEE80211_VHT_CAP_EXT_NSS_BW_MASK, 1);
        } else {
            vht_cap->cap |=
