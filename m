Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC7713B70
	for <lists+linux-wireless@lfdr.de>; Sun, 28 May 2023 20:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjE1SE3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 May 2023 14:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE1SE2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 May 2023 14:04:28 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00CBA3
        for <linux-wireless@vger.kernel.org>; Sun, 28 May 2023 11:04:26 -0700 (PDT)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4QTmky2dsMz9s88;
        Sun, 28 May 2023 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1685297066; bh=YanqDXt4gYh4Yg3JqmV9JtAyudOLfmWpefbYo9liq3c=;
        h=Date:From:Subject:To:Cc:From;
        b=bb23lso99koRLCKNFf16IDGcxbFpr3mit3zTeQsXBTre+pNWPDOViI03ChiHtQwyy
         7J0F4/hkI7Xe/37c7sgZZFoHYm5n1yP/zT6itopoXhWGAvnCx+lUnXVKxZLZxGAV4/
         G1r0tb+hJsdMGLxb82mJiunyMkiP7iHsouABMy1s=
X-Riseup-User-ID: 6A7FC8C9BCBCE7A3C029150DB0000B24648A75844749123286731A8FFEC99756
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4QTmkv52D1zFs02;
        Sun, 28 May 2023 18:04:23 +0000 (UTC)
Message-ID: <2c9d0354-1fbe-b468-8afd-30689e31e60b@riseup.net>
Date:   Sun, 28 May 2023 21:04:21 +0300
MIME-Version: 1.0
From:   Rany Hany <rany_hany@riseup.net>
Subject: [PATCH 0/1] MediaTek MT7915 AP Start/Stop Hang Fix
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

The below patch for mt7915 fix a scenario encountered by an OpenWRT
user related to "/etc/init.d/networking restart" occasionally
causing the driver to hang.

This patch incorporates the fix implemented in mt7921 for mt7915.

Rany Hany (1):
  wifi: mt76: mt7915: fix command timeout in AP stop period

 .../net/wireless/mediatek/mt76/mt7915/main.c  | 38 ++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

-- 
2.34.1





