Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550D66D772A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 10:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbjDEIoM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 04:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjDEIoL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 04:44:11 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35DC2727
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 01:44:10 -0700 (PDT)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7BF3240012;
        Wed,  5 Apr 2023 08:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680684249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/nTDUDElyHF+a1mIYAQGLhNvpdcVG1gIAbDMEd8QqbA=;
        b=khIJNQdYJkd0m94pY8j8fwoAe/OBZlUu8PlM2XPumxU5GA8zoI1eL0BP/rGygR+k+86GRZ
        3n8HA9WONXWIKCMeHqVMel2iEiQAfpPQc/Vln4I/HjvMnj4HLwyuUgBe2MQXw6OCz1cTKQ
        9K3rlwMP/MX4myC8QFEh5EHPm8/W+0hLfYWQ88gnjoTbaFoqCWWg/Wsa4rLrqdbr6ZOk0Y
        j8Uo6wX2LOh+fUXBXmIptuusAO6dC580/3We5RG4rCK+ow7k69EZe0ZXdBeKa1JC2OJDVg
        4Dsk2HmBJyWVgxZ//r0tHkbPchGso7wmypBzg5qoXFOFZM9xSIsG0gQnTRzv9w==
Date:   Wed, 5 Apr 2023 10:44:07 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: mwifiex not working on PCIe Laird st60
Message-ID: <20230405104407.45c5700f@kmaincent-XPS-13-7390>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I would like to report that the mwifiex driver is not working for the PCIe
Laird st60 Wifi module.
The Laird constructor is using its own driver (as usual :/):
https://github.com/LairdCP/Sterling-60-Release-Packages/releases

The mwifiex driver stall on the mwifiex_check_fw_status function.
Indeed the fw status id received is not what expected.
- If I use the firmware from linux-firmware (pcieusb8997_combo_v4.bin) the
  status is 0x0.
- If I use the firmware from Laird Github, the status is first 0x0 then
  0xf1f2f4a5 after 1/2s. Weirdly this id match the mwl8k firmware status.

The expected status should be 0xfedcba00 (also used in the Laird module) as
you can see it does not match it. I don't know well how this driver works a=
lso I
don't have datasheet of the module nor the chipset.
I hope someone could take a look at it or give me some debugging hints.

Regards,
K=C3=B6ry
