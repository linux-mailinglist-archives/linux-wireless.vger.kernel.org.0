Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3135A57E16D
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jul 2022 14:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiGVMaV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jul 2022 08:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiGVMaM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jul 2022 08:30:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBDB62DE
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jul 2022 05:30:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v12so5651085edc.10
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jul 2022 05:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zh7X5Uda6egpjw+fh4SnYbKXp8IFNuJykfc8eOEqRcY=;
        b=oJJbA0UIQDRXkXqxroc0ESaeLjykv5Hz8mdjOy7mQTVNVeHBiL16d+C1Tqddf8l4be
         rrBWUhDXEF6hudZbp3Q4OwuUqGx4GtTYIptvgB+2bYbzvcfhMVXTV/jO+/R5LaSqYvy8
         xVkvnuqtJDQfE1amhM8+BZRKepDGwiDVKz4fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zh7X5Uda6egpjw+fh4SnYbKXp8IFNuJykfc8eOEqRcY=;
        b=rt5bLFLD0WjIg+w3+WgT5HD8rbYwGqSHNlsI0UJ8TP4c/DLRS7jRNWzZC6FdainsJu
         Id5QtH0Tdb/C6vaDfYlRsprUgskBNSHX4nsNv9pU2CJ5bAoYGszSjUNdO28Jz1wI/Ofx
         WkvtiPLDTk0Lhgn1VMTadCAS+duRzEhkKZMzDuB8sZ+C7a5RYqj0oE44mPzdwQnZ1+Fo
         yVTXLi+T0P6HYifDbjIPXa+9I0lpXooORF2dYMR9nTVNHSfmSAxbUqbxgEtTxEixGRR/
         5QwOetvJimxLi1kxf6cByuGDRrSZ/aVNhrYl4uZfA3KI5LUVJvHQdTm8vHpcf4QBEumN
         GzzQ==
X-Gm-Message-State: AJIora/tahiyb4NnwmhRjTTihLl7ncNWPprqfJQvAWGMUzIJ/yClwRh/
        GotsAjYJA5saOC8V9uUKacWGCQ==
X-Google-Smtp-Source: AGRyM1ux80QqQUW+EIA/65Ein87S3N52C0FoamGrt7MvX+qr5lpBaUeLzY66cSjKh/GK9bob3xmuBA==
X-Received: by 2002:a05:6402:1d4a:b0:43a:ca49:abc6 with SMTP id dz10-20020a0564021d4a00b0043aca49abc6mr418056edb.376.1658493006349;
        Fri, 22 Jul 2022 05:30:06 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id f6-20020a05640214c600b0043a6df72c11sm2462432edx.63.2022.07.22.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 05:30:05 -0700 (PDT)
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
Subject: [PATCH -next 0/2] brcmfmac: AP STA concurrency patches from Cypress/Infineon
Date:   Fri, 22 Jul 2022 14:29:53 +0200
Message-Id: <20220722122956.841786-1-alvin@pqrs.dk>
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

We are using these two patches from Infineon (formerly Cypress) to
enable AP+STA mode on our CYW89359-based platform. They come from the
FMAC driver release package distributed by Infineon.

The key thing here is that apsta needs to be set to 1 in order for AP
mode to work concurrently with STA mode. I cannot speak for other
chipsets so a review from the Broadcom side would be welcome here.

For the ARP/ND offload being disabled in AP mode, I am of the view that
this is correct, but while Arend has given his Reviewed-by on it
previously, it was part of a different series [1], so I am sending
without in order to jog some memories.

[1] https://lore.kernel.org/linux-wireless/20201020022812.37064-3-wright.feng@cypress.com/#t

Soontak Lee (1):
  brcmfmac: Support multiple AP interfaces and fix STA disconnection
    issue

Ting-Ying Li (1):
  brcmfmac: don't allow arp/nd offload to be enabled if ap mode exists

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 65 +++++++++++++++----
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  2 +
 .../broadcom/brcm80211/brcmfmac/common.c      |  5 ++
 .../broadcom/brcm80211/brcmfmac/core.c        |  5 ++
 4 files changed, 66 insertions(+), 11 deletions(-)

-- 
2.37.0

