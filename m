Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD9A6B7AA6
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 15:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjCMOmb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 10:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjCMOmY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 10:42:24 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6083A7389E;
        Mon, 13 Mar 2023 07:41:38 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 7C99720040F;
        Mon, 13 Mar 2023 15:41:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1678718496;
        bh=jHWvZ9GrC/ieXg7Cg0vUPFioY8hbPYWnhYGRHJxj67U=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=aAWvVKFgvIG3Y8nOAfipbX9cZT83eQAVcg7wBKUsOZXbaVMTc7RbyVHbt9TXwHYwG
         47nxIQHR/I3X6kv3UUYduQne6KpWSfmfkeoQ8NjTID9V2u3AfILGR3LOtH/ASXlZyW
         qyEQqbAJyuBGEw0RsW76Pyp+ZjpfuAYRASLvOAqUHYM6vmEKwdWMI0za6Q/+QZ9M+Z
         PfKT779FDJt0Q4qDG0A1hq9pUy5p/xi+uQZgsTprhMp010cXZy8IR9I04YUqi1xkJk
         051ypzqaO1+OK/x+b5CYY4UfK+mdQEeMO1abAm6+Z3xU3zNXfm5rNIt13fsRrvPl/2
         61zeiQrMaBfrg==
Message-ID: <da979443-7a99-b0c8-911b-c5a0d21d595f@free.fr>
Date:   Mon, 13 Mar 2023 15:41:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Pierre-Hugues Husson <phh@phh.me>,
        linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
 <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
 <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
 <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr>
 <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
 <0450e34e-7190-104c-832a-150f15f7c825@free.fr>
 <3d91a067-c9c3-6d71-11a7-1289ea67f109@free.fr>
In-Reply-To: <3d91a067-c9c3-6d71-11a7-1289ea67f109@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 13/03/2023 14:55, Marc Gonzalez wrote:

> On 09/03/2023 18:51, Marc Gonzalez wrote:
> 
>> On 09/03/2023 15:29, Ulf Hansson wrote:
>>
>>> To narrow down the problem, I would start by preventing the WiFi
>>> driver from being insmoded. To make sure it doesn't affect the SDIO
>>> card detection process.
>>>
>>> The point is, the SDIO card should be detected properly, no matter
>>> whether there is a corresponding SDIO func driver (WiFi driver)
>>> available for it. For a detected SDIO/eMMC/SD card, mmc_add_card()
>>> prints a message about the card in the log during initialization. It
>>> could look like the below print, for example:
>>>
>>> "mmc2: new ultra high speed SDR104 SDIO card at address 0001".
>>
>> OK, I built the WiFi driver as a module which is NOT loaded at boot time.
> 
> Still trying to bisect this heisenbug into submission... :(
> 
> So far, I've pared it down to mmc_attach_sdio()
> 
> When probe WORKS, mmc_attach_sdio() returns 0.
> When probe FAILS, mmc_attach_sdio() returns ETIMEDOUT
> via mmc_send_io_op_cond(host, 0, &ocr);
> 
> Wrapping mmc_send_io_op_cond() in a loop
> makes it work on the second try.
> 
> Would appreciate additional guidance. Am mostly stabbing in the dark :)

Caught the race "in the act" (in flagrante delicto)

Using this patch:

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index f64b9ac76a5cd..eb2c95721e32c 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1204,11 +1204,24 @@ int mmc_attach_sdio(struct mmc_host *host)
 	struct mmc_card *card;
 
 	WARN_ON(!host->claimed);
-
+	//printk("YO %s: %s", __func__, mmc_hostname(host));
+	//msleep(500);
+
+#if 1
+	for (i = 0; i < 10; ++i) {
+		err = mmc_send_io_op_cond(host, 0, &ocr);
+		printk("YO %s", mmc_hostname(host));
+		if (!err) goto all_good;
+	}
+	printk("%s failed with %d", __func__, err);
+	return err;
+#else
 	err = mmc_send_io_op_cond(host, 0, &ocr);
 	if (err)
 		return err;
+#endif
 
+all_good:
 	mmc_attach_bus(host, &mmc_sdio_ops);
 	if (host->ocr_avail_sdio)
 		host->ocr_avail = host->ocr_avail_sdio;



Two boots of the same kernel:


/* THIS RUN PROBES ONCE */

[    0.846591] loop: module loaded
[    0.848079] g12a-mdio_mux ff64c000.mdio-multiplexer: Driver g12a-mdio_mux requests probe deferral
[    0.853901] usbcore: registered new interface driver usb-storage
[    0.859421] input: gpio-keys-polled as /devices/platform/gpio-keys-polled/input/input0
[    0.867880] meson-vrtc ff8000a8.rtc: registered as rtc0
[    0.872148] meson-vrtc ff8000a8.rtc: setting system clock to 1970-01-01T00:00:00 UTC (0)
[    0.880251] i2c_dev: i2c /dev entries driver
[    0.886780] psci-cpuidle: probe of psci-cpuidle rejects match -19
[    0.891279] ledtrig-cpu: registered to indicate activity on CPUs
[    0.891505] meson-gx-mmc ffe03000.sd: allocated mmc-pwrseq
[    0.896644] meson-sm: secure-monitor enabled
[    0.906242] hid: raw HID events driver (C) Jiri Kosina
[    0.911506] usbcore: registered new interface driver usbhid
[    0.916638] usbhid: USB HID core driver
[    0.922897] optee: probing for conduit method.
[    0.924837] optee: revision 2.4
[    0.925770] optee: initialized driver
[    0.932832] NET: Registered PF_PACKET protocol family
[    0.936627] Key type dns_resolver registered
[    0.941251] YO mmc2
[    0.945287] registered taskstats version 1
[    0.946989] Loading compiled-in X.509 certificates
[    1.074273] sdio_read_cis: vendor=2d0 dev=aae7
[    1.074824] sdio_read_cis: vendor=2d0 dev=aae7
[    1.074862] mmc2: new ultra high speed SDR50 SDIO card at address 0001


/* THIS RUN REQUIRES TWO PROBES */

[    0.855536] loop: module loaded
[    0.857064] g12a-mdio_mux ff64c000.mdio-multiplexer: Driver g12a-mdio_mux requests probe deferral
[    0.862952] usbcore: registered new interface driver usb-storage
[    0.868480] input: gpio-keys-polled as /devices/platform/gpio-keys-polled/input/input0
[    0.877000] meson-vrtc ff8000a8.rtc: registered as rtc0
[    0.881206] meson-vrtc ff8000a8.rtc: setting system clock to 1970-01-01T00:00:00 UTC (0)
[    0.889310] i2c_dev: i2c /dev entries driver
[    0.895850] psci-cpuidle: probe of psci-cpuidle rejects match -19
[    0.900536] meson-gx-mmc ffe03000.sd: allocated mmc-pwrseq
[    0.905438] ledtrig-cpu: registered to indicate activity on CPUs
[    0.911212] meson-sm: secure-monitor enabled
[    0.915235] hid: raw HID events driver (C) Jiri Kosina
[    0.920576] usbcore: registered new interface driver usbhid
[    0.925700] usbhid: USB HID core driver
[    0.931999] optee: probing for conduit method.
[    0.933912] optee: revision 2.4
[    0.934875] optee: initialized driver
[    0.941567] YO mmc2
[    0.941764] NET: Registered PF_PACKET protocol family
[    0.942884] YO mmc2
[    0.947738] Key type dns_resolver registered
[    0.958079] registered taskstats version 1
[    0.958190] Loading compiled-in X.509 certificates
[    1.068023] g12a-mdio_mux ff64c000.mdio-multiplexer: Driver g12a-mdio_mux requests probe deferral
[    1.072434] g12a-mdio_mux ff64c000.mdio-multiplexer: Driver g12a-mdio_mux requests probe deferral
[    1.072766] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
[    1.081297] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.101201] sdio_read_cis: vendor=2d0 dev=aae7
[    1.101755] sdio_read_cis: vendor=2d0 dev=aae7
[    1.101794] mmc2: new ultra high speed SDR50 SDIO card at address 0001



NOTA BENE: for mmc1, in both runs, kernel probes 10 times and fails with:

[    1.265231] mmc_attach_sdio failed with -110
[    1.373006] mmc1: new HS200 MMC card at address 0001
[    1.377242] mmcblk1: mmc1:0001 SCA16G 14.7 GiB 
[    1.383718] mmcblk1boot0: mmc1:0001 SCA16G 4.00 MiB 
[    1.387257] mmcblk1boot1: mmc1:0001 SCA16G 4.00 MiB 
[    1.391912] mmcblk1rpmb: mmc1:0001 SCA16G 4.00 MiB, chardev (246:0)

mmc_attach_sdio() fails but mmc_add_card() succeeds anyway...?
Confused.
mmc_attach_sdio() doesn't call mmc_add_card() if it exits prematurely.

Regards

