Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0404C609E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Feb 2022 02:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiB1BVu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Feb 2022 20:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiB1BVt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Feb 2022 20:21:49 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5D05C67C
        for <linux-wireless@vger.kernel.org>; Sun, 27 Feb 2022 17:21:11 -0800 (PST)
Received: (Authenticated sender: robert.joslyn@redrectangle.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 115D120002
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 01:21:08 +0000 (UTC)
Message-ID: <ec6187952e1456a6b6efd9c4bb697eecf4fe9c19.camel@redrectangle.org>
Subject: Intel AX200 Not Working in 5.15+
From:   Robert Joslyn <robert.joslyn@redrectangle.org>
To:     linux-wireless@vger.kernel.org
Date:   Sun, 27 Feb 2022 17:21:05 -0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have laptop with an Intel AX200 Wi-Fi controller and everything works
fine in a 5.14 kernel, but in 5.15 or later, the adapter does not work
most of the time. In maybe 9 out of 10 boots in 5.15+, the wlan0
interface does not get created. The hardware is detected and shows up
in lspci, the iwlwifi driver is loaded, but no interface is created.

I bisected the issue to this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75ae663d053bddf7c70a24cccf53c83ae03deff8

This adds a call to rtnl_lock() that should have been included in this
commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eb09ae93dabfd0980f5226dfd0bd531eb87902f5

If I remove the call to rtnl_lock and rtnl_unlock added in those
commits from 5.17.0-rc4, everything works again (but dmesg has a bunch
of RTNL assertion failures from the missing lock). I assume there is a
race or deadlock somewhere, but I've not been able to find it. I'm not
at all familiar with this part of the kernel so perhaps that's not
surprising :-)

Any thoughts as to what might be going wrong or suggestions on further
debugging?

dmesg when in broken state:
$ grep iwl dmesg-broken 
[    6.358897] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
[    6.377120] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
cc-a0-69.ucode failed with error -2
[    6.388252] iwlwifi 0000:02:00.0: api flags index 2 larger than
supported by driver
[    6.389455] iwlwifi 0000:02:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version:
89.3.35.37
[    6.391887] iwlwifi 0000:02:00.0: loaded firmware version
68.01d30b0c.0 cc-a0-68.ucode op_mode iwlmvm
[    6.732076] iwlwifi 0000:02:00.0: Detected Intel(R) Wi-Fi 6 AX200
160MHz, REV=0x340
[    6.856276] iwlwifi 0000:02:00.0: Detected RF HR B3, rfid=0x10a100
[    6.920917] iwlwifi 0000:02:00.0: base HW address: 78:2b:46:4a:b4:97

Kernel config:
$ grep -i iwl .config
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
# CONFIG_IWLDVM is not set
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
CONFIG_IWLWIFI_DEBUG=y


Thanks,
Robert

