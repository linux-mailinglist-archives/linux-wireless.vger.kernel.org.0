Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A9D8FBAD
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 09:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfHPHGH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 03:06:07 -0400
Received: from mail.someserver.de ([31.15.66.35]:54022 "EHLO
        mail.someserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPHGH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 03:06:07 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Aug 2019 03:06:06 EDT
Received: from localhost (87-231-101-12.rev.numericable.fr [87.231.101.12])
        by mail.someserver.de (Postfix) with ESMTPSA id 66533121546;
        Fri, 16 Aug 2019 09:00:20 +0200 (CEST)
From:   Christina Quast <contact@christina-quast.de>
To:     ard.biesheuvel@linaro.org
Cc:     Christina Quast <contact@christina-quast.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Anushka Shukla <anushkacharu9@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zach Turner <turnerzdp@gmail.com>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 0/2] Use ccm(aes) aead transform in staging drivers
Date:   Fri, 16 Aug 2019 08:59:34 +0200
Message-Id: <20190816065936.12214-1-contact@christina-quast.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use ccm(aes) aead transform instead of invoking the AES block cipher
block by block.

Christina Quast (2):
  staging: rtl8192u: ieee80211: ieee80211_crypt_ccmp.c: Use crypto API
    ccm(aes)
  staging: rtl8192e: rtllib_crypt_ccmp.c: Use crypto API ccm(aes)

 drivers/staging/rtl8192e/Kconfig              |   1 +
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c  | 187 ++++++++----------
 drivers/staging/rtl8192u/Kconfig              |   2 +
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c | 187 ++++++++----------
 4 files changed, 159 insertions(+), 218 deletions(-)

-- 
2.20.1

