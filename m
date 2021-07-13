Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436293C698A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jul 2021 06:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhGMExV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jul 2021 00:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhGMExV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jul 2021 00:53:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3314C0613DD
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jul 2021 21:50:31 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m3ANE-00041L-9K; Tue, 13 Jul 2021 06:50:24 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1m3ANC-0000Cr-4Q; Tue, 13 Jul 2021 06:50:22 +0200
Date:   Tue, 13 Jul 2021 06:50:22 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Pkshih <pkshih@realtek.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 04/24] rtw89: add debug files
Message-ID: <20210713045022.bki4tlcxnm3pwqdv@pengutronix.de>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-5-pkshih@realtek.com>
 <20210702072308.GA4184@pengutronix.de>
 <ceb8911a8ca0465a9f243e1d84ab911e@realtek.com>
 <CA+ASDXMLLEM0aYKU5u6E-xQJfJz+HkqFZjgYKirq8po6HsYc3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+ASDXMLLEM0aYKU5u6E-xQJfJz+HkqFZjgYKirq8po6HsYc3Q@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 05:46:38 up 222 days, 17:53, 36 users,  load average: 0.05, 0.06,
 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 12, 2021 at 06:57:37PM -0700, Brian Norris wrote:
> On Mon, Jul 5, 2021 at 1:59 AM Pkshih <pkshih@realtek.com> wrote:
> > > -----Original Message-----
> > > From: Oleksij Rempel [mailto:o.rempel@pengutronix.de]
> 
> > > Based on this and other part of this driver I would recommend to use
> > > regmap. It will provide to additional interface for the register
> > > access. And typically for the network devices we have an ethtool
> > > interface for that.
> > >
> >
> > Could I know the 'regmap' you mentioned?
> 
> include/linux/regmap.h
> drivers/base/regmap/
> 
> It's a driver framework and API for abstracting register accesses,
> whether they are accessed directly via MMIO, or behind some kind of
> indirect bus (I2C, SPI, etc.). It also happens to have its own debugfs
> operators for doing various kinds of register get/set/dump. So if you
> can successfully teach your driver to use it, then you don't need to
> implement your own debugfs files for it.
> 
> I've only ever used regmap with Device Tree systems (which can more
> easily specify syscon nodes, etc. -- see
> Documentation/devicetree/bindings/regmap/regmap.txt). I'm totally
> unfamiliar how to use this with ACPI (which I'm sure you want to
> support). I'm sure it's possible somehow.
> 
> FWIW, search engines turn up a few basic articles about it, if you
> find its documentation or code examples too sparse:
> https://www.collabora.com/news-and-blog/blog/2020/05/27/using-regmaps-to-make-linux-drivers-more-generic/

There are not ACPI specific register accesses in this driver. It is
using simple readl/writel for the PCI accesses.

This driver would need to use devm_regmap_init() and register own
regmap_bus. I motivate to use it not only to cover debugfs use case:

1. Current driver implements only PCI access, but potentially wont to
support SDIO and USB buses:
	drivers/net/wireless/realtek/rtw89/core.h
	enum rtw89_hci_type {
		RTW89_HCI_TYPE_PCIE,
		RTW89_HCI_TYPE_USB,
		RTW89_HCI_TYPE_SDIO,
	};


SDIO and USB buses may return error on any access. So, driver
should test if return value is error on every access. regmap read/write
functions separate error value from actual register read value and
motivate to handle errors in the driver. Suddenly not every mainline driver is
doing it.

2. Current driver implements patter based error detection for the PCI
bus:

	static u32 rtw89_pci_ops_read32_cmac(struct rtw89_dev *rtwdev, u32 addr)
	{
		struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
		u32 val = readl(rtwpci->mmap + addr);
		int count;

		for (count = 0; ; count++) {
			if (val != RTW89_R32_DEAD)
				return val;
			if (count >= MAC_REG_POOL_COUNT) {
				rtw89_warn(rtwdev, "addr %#x = %#x\n", addr, val);
				return RTW89_R32_DEAD;
			}
			rtw89_pci_ops_write32(rtwdev, R_AX_CK_EN, B_AX_CMAC_ALLCKEN);
			val = readl(rtwpci->mmap + addr);
		}

		return val;
	}

and handle this patter only in one place:
	....
	int rtw89_mac_check_mac_en(struct rtw89_dev *rtwdev, u8 mac_idx,
				   enum rtw89_mac_hwmod_sel sel)
	{
		....
		r_val = rtw89_read32(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND);

		....

		if (r_val == RTW89_R32_EA || r_val == RTW89_R32_DEAD ||
		    (val & r_val) != val)
			return -EFAULT;

		return 0;
	}

potentially this should be done on every read attempt for the PCI, and
on every read/write for SDIO and USB buses.

3. This driver has traces of watchdog support on the firmware side, so
potentially, firmware can return error on any access if it was reset by
the watchdog.

4. regmap provide a way to define support register ranges and will warn
if calculated register offset goes outside of this range.

5. regamp is endianness aware and will help to make this driver work
properly on big-endian systems.

Regards,
Oleksij
--
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
