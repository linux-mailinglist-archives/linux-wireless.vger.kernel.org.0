Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E119AED009
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2019 18:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfKBRrV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Nov 2019 13:47:21 -0400
Received: from fudo.makrotopia.org ([185.142.180.71]:42620 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfKBRrV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Nov 2019 13:47:21 -0400
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
         (Exim 4.92.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1iQxUc-0003iM-1I; Sat, 02 Nov 2019 18:47:19 +0100
Date:   Sat, 2 Nov 2019 18:47:01 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
Subject: [PATCH v2] rt2800: remove errornous duplicate condition
Message-ID: <20191102174701.GA1489@makrotopia.org>
References: <20191102154639.GA4589@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102154639.GA4589@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-28 06:07, wbob wrote:
> Hello Roman,
>
> while reading around drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> I stumbled on what I think is an edit of yours made in error in march
> 2017:
>
> https://github.com/torvalds/linux/commit/41977e86#diff-dae5dc10da180f3b055809a48118e18aR5281
>
> RT6352 in line 5281 should not have been introduced as the "else if"
> below line 5291 can then not take effect for a RT6352 device. Another
> possibility is for line 5291 to be not for RT6352, but this seems
> very unlikely. Are you able to clarify still after this substantial time?
>
> 5277: static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
> ...
> 5279:  } else if (rt2x00_rt(rt2x00dev, RT5390) ||
> 5280:         rt2x00_rt(rt2x00dev, RT5392) ||
> 5281:         rt2x00_rt(rt2x00dev, RT6352)) {
> ...
> 5291:  } else if (rt2x00_rt(rt2x00dev, RT6352)) {
> ...

Hence remove errornous line 5281 to make the driver actually
execute the correct initialization routine for MT7620 chips.

As it was requested by Stanislaw Gruszka remove setting values of
MIMO_PS_CFG and TX_PIN_CFG. MIMO_PS_CFG is responsible for MIMO
power-safe mode (which is disabled), hence we can drop setting it.
TX_PIN_CFG is set correctly in other functions, and as setting this
value breaks some devices, rather don't set it here during init, but
only modify it later on.

Fixes: 41977e86c984 ("rt2x00: add support for MT7620")
Reported-by: wbob <wbob@jify.de>
Reported-by: Roman Yeryomin <roman@advem.lv>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index f1cdcd61c54a..c99f1912e266 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -5839,8 +5839,7 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
 		rt2800_register_write(rt2x00dev, TX_TXBF_CFG_0, 0x8000fc21);
 		rt2800_register_write(rt2x00dev, TX_TXBF_CFG_3, 0x00009c40);
 	} else if (rt2x00_rt(rt2x00dev, RT5390) ||
-		   rt2x00_rt(rt2x00dev, RT5392) ||
-		   rt2x00_rt(rt2x00dev, RT6352)) {
+		   rt2x00_rt(rt2x00dev, RT5392)) {
 		rt2800_register_write(rt2x00dev, TX_SW_CFG0, 0x00000404);
 		rt2800_register_write(rt2x00dev, TX_SW_CFG1, 0x00080606);
 		rt2800_register_write(rt2x00dev, TX_SW_CFG2, 0x00000000);
@@ -5854,8 +5853,6 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
 		rt2800_register_write(rt2x00dev, TX_SW_CFG0, 0x00000401);
 		rt2800_register_write(rt2x00dev, TX_SW_CFG1, 0x000C0000);
 		rt2800_register_write(rt2x00dev, TX_SW_CFG2, 0x00000000);
-		rt2800_register_write(rt2x00dev, MIMO_PS_CFG, 0x00000002);
-		rt2800_register_write(rt2x00dev, TX_PIN_CFG, 0x00150F0F);
 		rt2800_register_write(rt2x00dev, TX_ALC_VGA3, 0x00000000);
 		rt2800_register_write(rt2x00dev, TX0_BB_GAIN_ATTEN, 0x0);
 		rt2800_register_write(rt2x00dev, TX1_BB_GAIN_ATTEN, 0x0);
-- 
2.23.0

