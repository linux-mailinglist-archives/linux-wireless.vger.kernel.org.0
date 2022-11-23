Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1906363D2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 16:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbiKWPfv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 10:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiKWPfu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 10:35:50 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCA468689
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 07:35:49 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id cg5so11409254qtb.12
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 07:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymXQJsm3Ibt6edPNV641PBoTil2ZrzP/k9aAa3+Ioig=;
        b=JZR04Gsql0iD+ilsmiRKt76uoSOADRXL1BgwE8sO0X98eW+WT5KnBAOgofSse38HBy
         kOeOj7tIjWpcrvEED989A8oNUDr04n+WgW2r2EU02oSddIM8u8MjpaAOyUV3B8yfK0Z8
         6uRRKsgcLor6BzHaHsA+pH0il2Zqx/RIrZDlRrzONoHJO1iROXoKMMVvCt+2zPg1vVRJ
         790uvuBU6jgoHqNC6GnZ89y0a73OWKZbgYbadJwlW6MKYETAYtBBO+tmh1d9ZY4Qi6z3
         bW5A4Cmp6GqQzI1tf3lB6GAYuIzGERVE6cRcIUIP60/4g2F4ca0QDrL5M910N+ugF8bk
         ZF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymXQJsm3Ibt6edPNV641PBoTil2ZrzP/k9aAa3+Ioig=;
        b=xCpdo7ooMidOZ7V4/W24M90HPYlIV+QdMoZ10G+VQ/STMhGBFIpi63erQXT0bADAVc
         AZYEnMFLSWGtTLe6R4+ygg2/XkaaJU9ZRDEFlsx31/aq/i2rA8+RW8khBw5TJeMmI0ox
         hPJQPd0pgAkTrDJboehCNfRibjBEXagemWUTXrljNw2VAcgE8/pUBW1NX3Wvo/ka/rqo
         lG3bFshBw2sEJJf/oFNtwvlct17fS3aGqfCUMF4exyQSIwg5/arfA2WP7HWg6MKYpxrz
         Ly3K9t0cbXTQs0CbrEUzHUPaVmm5DZQVFJAGIovK/Ob5Bnj8CWjgajqhmVLW7gfWMbo7
         ktzw==
X-Gm-Message-State: ANoB5pl8M6ecDnHfhmLQKcZqEILS7o4iLGjsmLc85F0/qxPae1lEQjQH
        Wz3WepakClh9/ZAPKFibkekVLM+oSIHEih0oMuW1y4Hvx23/vw1aqoFmhR+Q8F/uqBtgRdSgJOi
        eRFfvgBhFWDb/LdehbB7p9o+G1fvEff1cmOokzrW3vP//LYP8IqJt66VOl9hsYSoeT/uPgRbOL/
        YbU2T8WxkoK3M=
X-Google-Smtp-Source: AA0mqf5/KPbJqYkg0nAEB1iaYaZOJepoc8v1P8JT/KuAiSqJ9u4UL1pwqEHdk44fBGd2RNU8kuY3JQ==
X-Received: by 2002:ac8:67d0:0:b0:399:acab:ed6d with SMTP id r16-20020ac867d0000000b00399acabed6dmr27327870qtp.101.1669217748077;
        Wed, 23 Nov 2022 07:35:48 -0800 (PST)
Received: from localhost.localdomain (c-73-218-151-107.hsd1.ct.comcast.net. [73.218.151.107])
        by smtp.gmail.com with ESMTPSA id u12-20020a37ab0c000000b006bb29d932e1sm11990296qke.105.2022.11.23.07.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:35:47 -0800 (PST)
From:   Phil Turnbull <philipturnbull@github.com>
To:     linux-wireless@vger.kernel.org
Cc:     ajay.kathat@microchip.com, claudiu.beznea@microchip.com,
        kvalo@kernel.org, Phil Turnbull <philipturnbull@github.com>
Subject: [PATCH 0/4] wilc1000: Improve RSN and attribute parsing
Date:   Wed, 23 Nov 2022 10:35:39 -0500
Message-Id: <20221123153543.8568-1-philipturnbull@github.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series improves RSN and attribute parsing in the WILC1000
driver to prevent several out of bound reads and writes.

Phil Turnbull (4):
  wifi: wilc1000: validate pairwise and authentication suite offsets
  wifi: wilc1000: validate length of IEEE80211_P2P_ATTR_OPER_CHANNEL
    attribute
  wifi: wilc1000: validate length of IEEE80211_P2P_ATTR_CHANNEL_LIST
    attribute
  wifi: wilc1000: validate number of channels

 .../wireless/microchip/wilc1000/cfg80211.c    | 39 ++++++++++++++-----
 drivers/net/wireless/microchip/wilc1000/hif.c | 21 +++++++---
 2 files changed, 46 insertions(+), 14 deletions(-)

-- 
2.34.1

