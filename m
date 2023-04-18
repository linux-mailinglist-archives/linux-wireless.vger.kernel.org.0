Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895726E5CAD
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 10:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjDRI6O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDRI6M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 04:58:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5286E3C30
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 01:58:11 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pohA9-0001Sk-Kc; Tue, 18 Apr 2023 10:58:09 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pohA6-0007ze-G9; Tue, 18 Apr 2023 10:58:06 +0200
Date:   Tue, 18 Apr 2023 10:58:06 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Hans Ulli Kroll <linux@ulli-kroll.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Tim K <tpkuester@gmail.com>, "Alex G ." <mr.nuke.me@gmail.com>,
        Nick Morrow <morrownr@gmail.com>,
        Viktor Petrenko <g0000ga@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>,
        ValdikSS <iam@valdikss.org.ru>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 3/4] wifi: rtw88: set pkg_type correctly for specific
 rtw8821c variants
Message-ID: <20230418085806.GO13543@pengutronix.de>
References: <20230417140358.2240429-1-s.hauer@pengutronix.de>
 <20230417140358.2240429-4-s.hauer@pengutronix.de>
 <abc17f5fe6c944a5a1361d4d76817a08@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc17f5fe6c944a5a1361d4d76817a08@realtek.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 18, 2023 at 12:36:31AM +0000, Ping-Ke Shih wrote:
> 
> 
> > -----Original Message-----
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Monday, April 17, 2023 10:04 PM
> > To: linux-wireless <linux-wireless@vger.kernel.org>
> > Cc: Hans Ulli Kroll <linux@ulli-kroll.de>; Larry Finger <Larry.Finger@lwfinger.net>; Ping-Ke Shih
> > <pkshih@realtek.com>; Tim K <tpkuester@gmail.com>; Alex G . <mr.nuke.me@gmail.com>; Nick Morrow
> > <morrownr@gmail.com>; Viktor Petrenko <g0000ga@gmail.com>; Andreas Henriksson <andreas@fatal.se>;
> > ValdikSS <iam@valdikss.org.ru>; kernel@pengutronix.de; Sascha Hauer <s.hauer@pengutronix.de>
> > Subject: [PATCH v3 3/4] wifi: rtw88: set pkg_type correctly for specific rtw8821c variants
> > 
> > According to the vendor driver the pkg_type has to be set to '1'
> > for some rtw8821c variants. As the pkg_type has been hardcoded to
> > '0', add a field for it in struct rtw_hal and set this correctly
> > in the rtw8821c part.
> > With this parsing of a rtw_table is influenced and check_positive()
> > in phy.c returns true for some cases here. The same is done in the
> > vendor driver. However, this has no visible effect on the driver
> > here.
> 
> I agree this patch, but still want to know more about the meaning of
> "...no visible effect...". Do you mean your USB device works well with/without
> this patch? or, IO is absolutely the same when loading parameters with
> check_positive()?

Yes, it works with and without this patch. With this patch
check_positive() returns true in some cases whereas without this patch
check_positive always returns false.
I don't know at all what effect this change could have, maybe I just
need the right test case to verify it really makes a change.

I just realized that something like the below is missing, as the
cond.rfe part needs the raw rfe value from fuses >> 3.

Maybe we just take 1/4 and 2/4 and drop the others. I am running out of
time for further debugging RTW8821C which is a chip our customer isn't
interested in.

Sascha


-------------------------------8<--------------------------------

From 70e0bbf1e1d3949dede9f814d39970e5b27d3329 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 18 Apr 2023 10:33:56 +0200
Subject: [PATCH] wifi: rtw88: rtw8821c: set rfe correctly in phy code

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/realtek/rtw88/main.h     | 1 +
 drivers/net/wireless/realtek/rtw88/phy.c      | 3 +++
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 462f69547be03..a75c86981acf7 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1738,6 +1738,7 @@ struct rtw_efuse {
 	u8 country_code[2];
 	u8 rf_board_option;
 	u8 rfe_option;
+	u8 rfe_type;
 	u8 power_track_type;
 	u8 thermal_meter[RTW_RF_PATH_MAX];
 	u8 thermal_meter_k;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 128e75a81bf3c..deb39cbea440f 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1048,6 +1048,9 @@ void rtw_phy_setup_phy_cond(struct rtw_dev *rtwdev, u32 pkg)
 	cond.plat = 0x04;
 	cond.rfe = efuse->rfe_option;
 
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821C)
+		cond.rfe = efuse->rfe_type;
+
 	switch (rtw_hci_type(rtwdev)) {
 	case RTW_HCI_TYPE_USB:
 		cond.intf = INTF_USB;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index a50753ae235b5..72485c9471f11 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -49,6 +49,7 @@ static int rtw8821c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	map = (struct rtw8821c_efuse *)log_map;
 
 	efuse->rfe_option = map->rfe_option & 0x1f;
+	efuse->rfe_type = map->rfe_option >> 3;
 	efuse->rf_board_option = map->rf_board_option;
 	efuse->crystal_cap = map->xtal_k;
 	efuse->pa_type_2g = map->pa_type;
-- 
2.39.2

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
