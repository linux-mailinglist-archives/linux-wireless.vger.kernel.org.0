Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E8472DC0D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 10:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjFMIJT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 04:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjFMIJS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 04:09:18 -0400
Received: from bin-mail-out-05.binero.net (bin-mail-out-05.binero.net [195.74.38.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B8DE79
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 01:09:15 -0700 (PDT)
X-Halon-ID: 91984d59-09c1-11ee-80b4-ade5659629c7
Authorized-sender: petter@technux.se
Received: from petterwork.eu.esabglobal.net (unknown [194.71.86.70])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPSA
        id 91984d59-09c1-11ee-80b4-ade5659629c7;
        Tue, 13 Jun 2023 10:09:09 +0200 (CEST)
From:   petter@technux.se
To:     linux-wireless@vger.kernel.org
Cc:     pkshih@realtek.com, Larry.Finger@lwfinger.net, morrownr@gmail.com,
        kernel@pengutronix.de, kvalo@kernel.org, linux@ulli-kroll.de,
        petter.mabacker@esab.se, petter@technux.se, s.hauer@pengutronix.de
Subject: Linux mainline support for RTL8811AU/RTL8821AU
Date:   Tue, 13 Jun 2023 10:09:07 +0200
Message-Id: <20230613080907.328548-1-petter@technux.se>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm investigating a wifi dongle (LM808) that is based on the RTL8811AU chipset.

$ lsusb
..
Bus 003 Device 066: ID 0bda:a811 Realtek Semiconductor Corp. RTL8811AU 802.11a/b/g/n/ac WLAN Adapter
..

I cannot find any driver support in mainline for that chipset (8811cu/8821cu, seems to exists). Just curious if anyone knows if there are any ongoing efforts to get this driver included in mainline?

I can see that both:

https://www.lm-technologies.com/product/wifi-usb-adapter-433mbps-lm808/?template=driver

and

https://github.com/morrownr/8821au-20210708

exists for non-mainline support, so will play a bit with them. But for maintenance etc I'm interested to learn about possible mainline efforts within this area.


BR Petter
