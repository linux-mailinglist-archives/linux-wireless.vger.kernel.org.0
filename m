Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D46B23C1
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 13:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCIMNi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 07:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCIMNh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 07:13:37 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78FD3CE1D;
        Thu,  9 Mar 2023 04:13:35 -0800 (PST)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id EDA002003EF;
        Thu,  9 Mar 2023 13:13:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1678364014;
        bh=jspTNMqmiAfUcc7bb0/7iQoCw5A51k8LsKeTMnZiFno=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=CT3IxvdEnsUeQ9GIvmFA8GbayIHBlsZGLovYXBd4yECE0ZukuHtlwwTDuItCMlweL
         KznLZoBWywgX2L8WD7uDdM1bYiIePR0NMTFGM/zcK19Ao/a0bL5M87JwgkpOIR3XQG
         gj4S6bBgWgWJr6bj+RnIIBK5zBv5EgPvmmnCEGNasP+j+qFDhqNx6Xpvq7WwtXxvt7
         US4t1SYwHX11tH5blJ+zdbU9p0c7Bzb2714uhBf4GyHEGj8DGOKnD/Gb4cxtKS9c2a
         SqOw2i7OpyQsi0DtT0asDPhaQ4DDyueFqS3gfzKjwOiXSCUImUF4Hnba/7AvgynfRK
         zg9vENDxijwuQ==
Message-ID: <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr>
Date:   Thu, 9 Mar 2023 13:13:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>
Cc:     linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
 <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
 <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
In-Reply-To: <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 09/03/2023 11:16, Marc Gonzalez wrote:

> On 06/03/2023 11:24, Marc Gonzalez wrote:
> 
>> # cat /sys/bus/sdio/devices/mmc2:0001:1/uevent
>> OF_NAME=wifi
>> OF_FULLNAME=/soc/sd@ffe03000/wifi@1
>> OF_COMPATIBLE_0=brcm,bcm4329-fmac
>> OF_COMPATIBLE_N=1
>> SDIO_CLASS=00
>> SDIO_ID=02D0:AAE7
>> SDIO_REVISION=0.0
>> MODALIAS=sdio:c00v02D0dAAE7
>>
>> NB: 0xaae7 = 43751
> 
> I have run into another issue.
> 
> The WiFi device (and the mmc2 bus it sits on) don't show up at all
> in the kernel log *unless* I add lots of debug output, such as with
> #define DEBUG in drivers/base/dd.c
> 
> I think this points to some kind of race condition?
> 
> Neil suggested that maybe the host probes the mmc2 bus "too soon",
> when the WiFi device is still powering up, which makes the entire
> probe fail.
> 
> This patch appears to solve the symptom:
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 6e5ea0213b477..999b3843c0d0b 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1400,7 +1400,7 @@ static struct platform_driver meson_mmc_driver = {
>  	.remove		= meson_mmc_remove,
>  	.driver		= {
>  		.name = DRIVER_NAME,
> -		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
>  		.of_match_table = meson_mmc_of_match,
>  	},
>  };
> 
> But this might just be delaying the probe enough for the device
> to become ready?

FWIW, the relevant device tree nodes are:

/* decompiled DTS */

		sd@ffe03000 {
			compatible = "amlogic,meson-axg-mmc";
			reg = <0x0 0xffe03000 0x0 0x800>;
			interrupts = <0x0 0xbd 0x4>;
			status = "okay";
			clocks = <0x2 0x21 0x2 0x3c 0x2 0x2>;
			clock-names = "core", "clkin0", "clkin1";
			resets = <0x5 0x2c>;
			amlogic,dram-access-quirk;
			pinctrl-0 = <0x2c>;
			pinctrl-1 = <0x2d>;
			pinctrl-names = "default", "clk-gate";
			#address-cells = <0x1>;
			#size-cells = <0x0>;
			bus-width = <0x4>;
			cap-sd-highspeed;
			sd-uhs-sdr50;
			max-frequency = <0x5f5e100>;
			non-removable;
			disable-wp;
			keep-power-in-suspend;
			mmc-pwrseq = <0x2e>;
			vmmc-supply = <0x2b>;
			vqmmc-supply = <0x21>;

			wifi@1 {
				reg = <0x1>;
				compatible = "brcm,bcm4329-fmac";
			};
		};


/* original DTS */

		sd_emmc_a: sd@ffe03000 {
			compatible = "amlogic,meson-axg-mmc";
			reg = <0x0 0xffe03000 0x0 0x800>;
			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
			status = "disabled";
			clocks = <&clkc CLKID_SD_EMMC_A>,
				 <&clkc CLKID_SD_EMMC_A_CLK0>,
				 <&clkc CLKID_FCLK_DIV2>;
			clock-names = "core", "clkin0", "clkin1";
			resets = <&reset RESET_SD_EMMC_A>;
		};

&sd_emmc_a {
	status = "okay";
	pinctrl-0 = <&sdio_pins>;
	pinctrl-1 = <&sdio_clk_gate_pins>;
	pinctrl-names = "default", "clk-gate";
	#address-cells = <1>;
	#size-cells = <0>;

	bus-width = <4>;
	cap-sd-highspeed;
	sd-uhs-sdr50;
	max-frequency = <100000000>;

	non-removable;
	disable-wp;

	/* WiFi firmware requires power to be kept while in suspend */
	keep-power-in-suspend;

	mmc-pwrseq = <&sdio_pwrseq>;

	vmmc-supply = <&vddao_3v3>;
	vqmmc-supply = <&vddio_ao1v8>;

	brcmf: wifi@1 {
		reg = <1>;
		compatible = "brcm,bcm4329-fmac";
	};
};

With an asynchronous probe, meson_mmc_probe() always succeeds,
yet the WiFi card is not detected later on, even if I sleep
1-2 seconds in meson_mmc_probe().

[    0.879756] YO: meson_mmc_probe: ffe03000.sd
[    0.914320] YO: meson_mmc_probe: ffe03000.sd ALL OK
[    1.199170] YO: meson_mmc_probe: ffe07000.mmc
[    1.232734] YO: meson_mmc_probe: ffe07000.mmc ALL OK

Confused again...

Regards

