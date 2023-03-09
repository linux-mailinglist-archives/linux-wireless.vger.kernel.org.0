Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD55C6B2B41
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 17:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCIQy6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 11:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCIQyh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 11:54:37 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1853A22A3A;
        Thu,  9 Mar 2023 08:45:31 -0800 (PST)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 47FA32003DC;
        Thu,  9 Mar 2023 17:45:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1678380330;
        bh=rsAF33xOWKleODOfDwi0uA2zvM7ioCnYZ04Hs4dAfyM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Mzw++Zfax1adTN3X9aNvqovSpBYyqKxM1F5Tqz00UtkcCQFIF8V2UPW3BxBq+/ob9
         U7Fk1dfCUObVXWXx44SMD1ceUv0KIkItm1OuN7kzL5Z9GDQEzniRKm4AO6N3ebtyuB
         wApgW4n/wQcemeT7jQ/8PnPmIDWzi/wrM4wDWC7EinV9ky9aQb3Wn+IHYmXFzEV6MS
         ApC9q/oBIdc1YXNDlZGSyuW9GS+2DhtETb9pdg3VeYfBr0/JPP7bjXX0Wf1D/VQPGT
         o/qcQ7vVn61X4jEiiNXJ2DGVvnqwcsKTaErSC+j0AK16gCNxLgm8YGQwfyIC/ZSbCw
         pu/q2Yn7p7MGg==
Message-ID: <1e75516f-5539-3347-f909-1597f8175ef6@free.fr>
Date:   Thu, 9 Mar 2023 17:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
Content-Language: en-US
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
        Angus Ainslie <angus@akkea.ca>, linux-wireless@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
 <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
 <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
 <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr>
 <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
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

On 09/03/2023 15:29, Ulf Hansson wrote:

> On Thu, 9 Mar 2023 at 13:13, Marc Gonzalez wrote:
>
>> On 09/03/2023 11:16, Marc Gonzalez wrote:
>>
>>> On 06/03/2023 11:24, Marc Gonzalez wrote:
>>>
>>>> # cat /sys/bus/sdio/devices/mmc2:0001:1/uevent
>>>> OF_NAME=wifi
>>>> OF_FULLNAME=/soc/sd@ffe03000/wifi@1
>>>> OF_COMPATIBLE_0=brcm,bcm4329-fmac
>>>> OF_COMPATIBLE_N=1
>>>> SDIO_CLASS=00
>>>> SDIO_ID=02D0:AAE7
>>>> SDIO_REVISION=0.0
>>>> MODALIAS=sdio:c00v02D0dAAE7
>>>>
>>>> NB: 0xaae7 = 43751
>>>
>>> I have run into another issue.
>>>
>>> The WiFi device (and the mmc2 bus it sits on) don't show up at all
>>> in the kernel log *unless* I add lots of debug output, such as with
>>> #define DEBUG in drivers/base/dd.c
>>>
>>> I think this points to some kind of race condition?
>>>
>>> Neil suggested that maybe the host probes the mmc2 bus "too soon",
>>> when the WiFi device is still powering up, which makes the entire
>>> probe fail.
> 
> Ideally, the WiFi device/driver should not need to be initialized to
> allow the SDIO card to be detected properly. Looks like there is
> something fishy going on.

Something fishy indeed ;)


>>> This patch appears to solve the symptom:
>>>
>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>> index 6e5ea0213b477..999b3843c0d0b 100644
>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>> @@ -1400,7 +1400,7 @@ static struct platform_driver meson_mmc_driver = {
>>>       .remove         = meson_mmc_remove,
>>>       .driver         = {
>>>               .name = DRIVER_NAME,
>>> -             .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>>> +             .probe_type = PROBE_FORCE_SYNCHRONOUS,
>>>               .of_match_table = meson_mmc_of_match,
>>>       },
>>>  };
>>>
>>> But this might just be delaying the probe enough for the device
>>> to become ready?
>>
>> FWIW, the relevant device tree nodes are:
>>
>> /* decompiled DTS */
>>
>>                 sd@ffe03000 {
>>                         compatible = "amlogic,meson-axg-mmc";
>>                         reg = <0x0 0xffe03000 0x0 0x800>;
>>                         interrupts = <0x0 0xbd 0x4>;
>>                         status = "okay";
>>                         clocks = <0x2 0x21 0x2 0x3c 0x2 0x2>;
>>                         clock-names = "core", "clkin0", "clkin1";
>>                         resets = <0x5 0x2c>;
>>                         amlogic,dram-access-quirk;
>>                         pinctrl-0 = <0x2c>;
>>                         pinctrl-1 = <0x2d>;
>>                         pinctrl-names = "default", "clk-gate";
>>                         #address-cells = <0x1>;
>>                         #size-cells = <0x0>;
>>                         bus-width = <0x4>;
>>                         cap-sd-highspeed;
>>                         sd-uhs-sdr50;
>>                         max-frequency = <0x5f5e100>;
>>                         non-removable;
>>                         disable-wp;
>>                         keep-power-in-suspend;
>>                         mmc-pwrseq = <0x2e>;
>>                         vmmc-supply = <0x2b>;
>>                         vqmmc-supply = <0x21>;
>>
>>                         wifi@1 {
>>                                 reg = <0x1>;
>>                                 compatible = "brcm,bcm4329-fmac";
>>                         };
>>                 };
>>
>>
>> /* original DTS */
>>
>>                 sd_emmc_a: sd@ffe03000 {
>>                         compatible = "amlogic,meson-axg-mmc";
>>                         reg = <0x0 0xffe03000 0x0 0x800>;
>>                         interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
>>                         status = "disabled";
>>                         clocks = <&clkc CLKID_SD_EMMC_A>,
>>                                  <&clkc CLKID_SD_EMMC_A_CLK0>,
>>                                  <&clkc CLKID_FCLK_DIV2>;
>>                         clock-names = "core", "clkin0", "clkin1";
>>                         resets = <&reset RESET_SD_EMMC_A>;
>>                 };
>>
>> &sd_emmc_a {
>>         status = "okay";
>>         pinctrl-0 = <&sdio_pins>;
>>         pinctrl-1 = <&sdio_clk_gate_pins>;
>>         pinctrl-names = "default", "clk-gate";
>>         #address-cells = <1>;
>>         #size-cells = <0>;
>>
>>         bus-width = <4>;
>>         cap-sd-highspeed;
>>         sd-uhs-sdr50;
>>         max-frequency = <100000000>;
>>
>>         non-removable;
>>         disable-wp;
>>
>>         /* WiFi firmware requires power to be kept while in suspend */
>>         keep-power-in-suspend;
>>
>>         mmc-pwrseq = <&sdio_pwrseq>;
> 
> This one is particularly interesting. Can you share the content of the
> sdio_pwrseq node too?


	sdio_pwrseq: sdio-pwrseq {
		compatible = "mmc-pwrseq-simple";
		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
		clocks = <&wifi32k>;
		clock-names = "ext_clock";
	};

	wifi32k: wifi32k {
		compatible = "pwm-clock";
		#clock-cells = <0>;
		clock-frequency = <32768>;
		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
	};

			pwm_ef: pwm@19000 {
				compatible = "amlogic,meson-g12a-ee-pwm";
				reg = <0x0 0x19000 0x0 0x20>;
				#pwm-cells = <3>;
				status = "disabled";
			};

&pwm_ef {
	status = "okay";
	pinctrl-0 = <&pwm_e_pins>;
	pinctrl-names = "default";
	clocks = <&xtal>;
	clock-names = "clkin0";
};

					pwm_e_pins: pwm-e {
						mux {
							groups = "pwm_e";
							function = "pwm_e";
							bias-disable;
						};
					};



>>         vmmc-supply = <&vddao_3v3>;
>>         vqmmc-supply = <&vddio_ao1v8>;
>>
>>         brcmf: wifi@1 {
>>                 reg = <1>;
>>                 compatible = "brcm,bcm4329-fmac";
>>         };
>> };
>>
>> With an asynchronous probe, meson_mmc_probe() always succeeds,
>> yet the WiFi card is not detected later on, even if I sleep
>> 1-2 seconds in meson_mmc_probe().
>>
>> [    0.879756] YO: meson_mmc_probe: ffe03000.sd
>> [    0.914320] YO: meson_mmc_probe: ffe03000.sd ALL OK
>> [    1.199170] YO: meson_mmc_probe: ffe07000.mmc
>> [    1.232734] YO: meson_mmc_probe: ffe07000.mmc ALL OK
> 
> To narrow down the problem, I would start by preventing the WiFi
> driver from being insmoded. To make sure it doesn't affect the SDIO
> card detection process.

So far, I always embedded all device drivers in the kernel (=y)
You are suggesting to build the WiFi driver as a module, correct?


> The point is, the SDIO card should be detected properly, no matter
> whether there is a corresponding SDIO func driver (WiFi driver)
> available for it. For a detected SDIO/eMMC/SD card, mmc_add_card()
> prints a message about the card in the log during initialization. It
> could look like the below print, for example:
> 
> "mmc2: new ultra high speed SDR104 SDIO card at address 0001".

When everything works, I get:
mmc2: new ultra high speed SDR50 SDIO card at address 0001

When it doesn't, I don't get that line.

I'm trying to debug with printk's in
mmc_rescan_try_freq, mmc_rescan, mmc_attach_sdio, meson_mmc_probe

The problem is that adding "too many" printks makes the
probe work! (Debugging this issue is nerve-racking.)

Thanks, I will test your suggestions!

Regards

