Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4ADE7B4A
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2019 22:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfJ1VWj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Oct 2019 17:22:39 -0400
Received: from fudo.makrotopia.org ([185.142.180.71]:57312 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbfJ1VWi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Oct 2019 17:22:38 -0400
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
         (Exim 4.92.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1iPCQy-0006a0-59; Mon, 28 Oct 2019 22:22:35 +0100
Date:   Mon, 28 Oct 2019 22:20:01 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org
Cc:     Roman Yeryomin <roman@advem.lv>, wbob <wbob@jify.de>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH] rt2800: remove erroneous duplicate condition
Message-ID: <20191028212001.GA2318@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hence remove erroneous line 5281 to make the driver actually
execute the correct initialization routine for MT7620 chips.

Fixes: 41977e86c984 ("rt2x00: add support for MT7620")
Reported-by: wbob <wbob@jify.de>
Reported-by: Roman Yeryomin <roman@advem.lv>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index f1cdcd61c54a..c85456c8c193 100644
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
-- 
2.23.0

