Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2E915EF18
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 18:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbgBNRpx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 12:45:53 -0500
Received: from muru.com ([72.249.23.125]:55312 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389513AbgBNRpw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 12:45:52 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4AF4780E7;
        Fri, 14 Feb 2020 17:46:35 +0000 (UTC)
Date:   Fri, 14 Feb 2020 09:45:48 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     "Arthur D." <spinal.by@gmail.com>, linux-bluetooth@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: Droid 4 WiFi firmware loading error
Message-ID: <20200214174548.GC64767@atomide.com>
References: <20200211232425.GE16391@atomide.com>
 <op.0fu85owhhxa7s4@supervisor.net28>
 <20200212150722.GF16391@atomide.com>
 <20200212162131.GI16391@atomide.com>
 <op.0fwkyxvihxa7s4@supervisor.net28>
 <20200213041112.GL16391@atomide.com>
 <op.0fw0oas5hxa7s4@supervisor.net28>
 <20200213161157.GN16391@atomide.com>
 <op.0fx4hozhhxa7s4@supervisor.net28>
 <20200214161100.b7aqb6wwsrxmx4ab@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214161100.b7aqb6wwsrxmx4ab@earth.universe>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [200214 17:20]:
> Hi,
> 
> WTF :(
> 
> Right now the BT driver and the WiFi driver are no aware of
> each other. Actually the kernel is not even aware, that both
> drivers are using the same chip. Unfortunately this will be
> tricky to solve properly. Since a system may have two WiLink
> devices, the only solution coming to my mind would be adding
> a link from the BT device to the WiFi device in device tree.
> Additionally we would need something in the WiLink driver to
> check if driver has been initialized properly for a given DT
> node.

Yeah exactly.. I think the best way would be to export something
like wlcore_register_bt/wlcore_unregister_bt.. And then have
wlcore_register_bt return -EAGAIN until wlcore is up.

> On Fri, Feb 14, 2020 at 12:54:50AM +0300, Arthur D. wrote:
> > Hello.
> > 
> > Some users have reported that they have issues with WiFi firmware
> > loading on Droid 4. The fragment of dmesg for the issue follows
> > at the bottom of this mail.
> > 
> > With the help of Tony Lindgren I have found that the root of the
> > issue was Bluetooth firmware loaded before WiFi driver (wlcore).
> > 
> > Now we need to change the kernel to make it load Bluetooth firmware
> > only after WiFi firmware is loaded. So the bug will not be triggered.
> > 
> > Any ideas on how it should be done?
> > 
> > P.S. When I do "rmmod hci_uart" on Droid 4 device, I get something
> > like endless loop of error reporting from kernel. The fragment of
> > dmesg can be downloaded from https://dropmefiles.com/wCPMF
> > I'm not sure where to report this one.

Yup I've seen rmmod hci_uart produce kernel oops, but I just tried
to reproduce it again on v5.5 and it just took a long time to rmmod
with no oops.

Regards,

Tony

8< ---------------
# dmesg -C; modprobe hci_uart; sleep 5; rmmod hci_uart; dmesg -c
[  616.926422] Bluetooth: HCI UART driver ver 2.3
[  616.926422] Bluetooth: HCI UART protocol H4 registered
[  616.926422] Bluetooth: HCI UART protocol BCSP registered
[  616.926513] Bluetooth: HCI UART protocol LL registered
[  616.926635] Bluetooth: HCI UART protocol Three-wire (H5) registered
[  616.927185] Bluetooth: HCI UART protocol Broadcom registered
[  616.927764] hci-ti serial1-0: GPIO lookup for consumer enable
[  616.927764] hci-ti serial1-0: using device tree for GPIO lookup
[  616.927856] of_get_named_gpiod_flags: parsed 'enable-gpios' property of node '/ocp/interconnect@48000000/segment@0/target-module@6e000/serial@0/bluetooth[0]' - status (0)
[  616.927886] gpio gpiochip6: Persistence not supported for GPIO 14
[  624.002838] Bluetooth: hci0: command 0xff05 tx timeout
[  632.572662] Bluetooth: hci0: send command failed
[  632.572814] Bluetooth: hci0: download firmware failed, retrying...
[  634.722991] Bluetooth: hci0: command 0x1001 tx timeout
[  642.812652] Bluetooth: hci0: Reading TI version information failed (-110)
[  642.812652] Bluetooth: hci0: download firmware failed, retrying...
[  644.962707] Bluetooth: hci0: command 0x1001 tx timeout
[  653.043151] Bluetooth: hci0: Reading TI version information failed (-110)
[  653.043182] Bluetooth: hci0: download firmware failed, retrying...
[  655.203582] Bluetooth: hci0: command 0x1001 tx timeout
[  663.294372] Bluetooth: hci0: Reading TI version information failed (-110)
[  663.294464] Bluetooth: hci0: download firmware failed, retrying...
