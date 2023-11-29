Return-Path: <linux-wireless+bounces-210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9AE7FD25C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 10:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82802821A2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E6813FE7;
	Wed, 29 Nov 2023 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hyShzCOA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D731BEE
	for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 01:22:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2F4EC0008;
	Wed, 29 Nov 2023 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701249762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FnxhmWhKod+T+4LCypr8ik7zHyv3bJXdbVMlq11F12E=;
	b=hyShzCOAkPU664FpZa49HzvaBVbBB7nD9iiFGCOUUjL6DsTnyd55cTvZlc7ChFGcX7OA74
	CdYrPw5rsLGC2tTwQgkKYagWIw9631/+roJL+jo7ZEenQxbnBbQTYGcpCiWeAPP5TXBBh7
	fBxQTecdPg2UT8I+qWU8Emjah2iOtNrgQkWbFD+6vbMlztCrblSOFpZiKiRR3plRqwYqCX
	3ZEzp84ZIMmekUjV2yc0TiIbI20j7HqNWOEhMZM6Rtz5SNoJ80XXh/6UwBhxFwIVQIfa0c
	z21i0T2f2S/KSqJk+OIVDezrBvXGrV39b4dU5CpLuKKNXa2/jHPyJGnjfDX6IQ==
Date: Wed, 29 Nov 2023 10:22:40 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: imx@lists.linux.dev
Subject: Linux v6.6 sporadic reboot failures with ath9k on i.MX6Q
Message-ID: <20231129102240.183f94ba@booty>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello,

since several weeks I am investigating a sporadic reboot failure on a
custom board based on i.MX6Q. There is an ATH9K Wi-Fi card connected
over PCIe, and the main suspect is the ath9k driver.

Anybody aware of this kind of bug with ath9k?

Some details about my tests follow.

This is on mainline v6.6 Linux, with only the board dts and a defconfig
added. The board dts itself is based on imx6q.dtsi and among others it
adds:

&pcie {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_pcie>;
        reset-gpio = <&gpio2 20 GPIO_ACTIVE_LOW>;
        status = "okay";
};

and:

&iomuxc {
/* ... */
        imx6qdl-sabresd {
/* ... */
                pinctrl_pcie: pciegrp {
                        fsl,pins = <
                                MX6QDL_PAD_EIM_A18__GPIO2_IO20  0x1b0b0
                        >;
                };
/* ... */
        };
};
                                                                                                                                                                                             
Reboot usually works fine, but fails randomly in 1-5% of the
cases. The symptom is that the console stops producing any messages
at some random point in the shutdown sequence, even in the middle of a
line.

After about 7000 reboot attempts with different configurations it is
clear that enabling or disabling CONFIG_ATH9K is what makes the
difference:

 1. kernels with CONFIG_ATH9K=n never fail
 2. kernels with CONFIG_ATH9K=y do fail

Kernels built with CONFIG_ATH9K=y do fail even disabling all optional
CONFIG_ATH9K* options (rfkill, pcoem, btcoex and no_eeprom).

Similarly:

 1. removing pcie from the device tree makes reboot work
 2. leaving pcie in the device tree and removing all the peripherals
    not required for booting, reboot does fail

On top of v6.6 I have applied all the potentially related commits from
master that appear as of now (8 in total):

  git log --oneline --reverse --format=%H v6.6..origin/master -- \
      drivers/net/wireless/ath/*.[ch] drivers/net/wireless/ath/ath9k/ \
    | xargs git cherry-pick

and reboot still fails.

I have tested these mainline kernel versions, which no result: 
v6.1.60, v5.15.137, v5.10.199, v5.10.

A first look at the ath9k driver code did not show anything obviously
wrong.

Any clues about how to further investigate would be very welcome.

I am obviously available to provide more info.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

