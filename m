Return-Path: <linux-wireless+bounces-33934-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMibDOD9xGny5QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33934-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:35:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76095332692
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9F113008A7F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 09:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8751350A05;
	Thu, 26 Mar 2026 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="eQ3/7Ykj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from courrier.aliel.fr (pouet.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB83630E85D;
	Thu, 26 Mar 2026 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517280; cv=none; b=BMuEu7QbtapL5ugjrsD/FJelThMIpseSBag7IGJ68BiuVMOPlUfivzaa40c038Xv8Lg/E7Pmv3j2gg2Uc6/URJNaRYC9gBxG0A9KjDV59IijGJGlEAHDI1maUMEEVN4KJPWfN0Lp9Ka/TZ6KLfQ3XW63q12OcVrkN9SVs+2bWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517280; c=relaxed/simple;
	bh=hCffSrytymkZsTF+g18yVFG0ugDdfGbOo15ZfjxCRlA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oi/QB8bQGg/UqNW+U0Ie9NRkSRawe16hQdxcIZVWKllR3TMJ2BKyafPJSNK/Tv0HvgBUlisBlpkEWk+HlLpnPZHEokiLSqDoWxIsWZDFfLXDKuA32ChaNJfXPVPYCaJZv/Zd+zgOSPmcQi0FcpgvUG/BprcUOhbDjupeqyjod1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=eQ3/7Ykj; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Message-ID: <802bc778-9e18-4273-9757-c0d663e8b14a@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1774517276;
	bh=hCffSrytymkZsTF+g18yVFG0ugDdfGbOo15ZfjxCRlA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=eQ3/7Ykj9LCvsbKYSiqPnT9GfUx9Eyibc77/pFGLIy68mfwchsIIBIA4mt1YpPzMX
	 qzJhnNCu+i0VUh5RXafyaHWePHRsm3BCaZsY6YTN8ZRBwHqCqzovwcig9uJMe0TfqI
	 xvgmxbihm57B90MJpQ3wb+JUn+BMn80mc8QgNLa4=
Date: Thu, 26 Mar 2026 10:27:54 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v4 9/9] arm64: dts: amlogic: t7: khadas-vim4: Add MMC
 nodes
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
References: <20260325-add-emmc-t7-vim4-v4-0-44c7b4a5e459@aliel.fr>
 <20260325-add-emmc-t7-vim4-v4-9-44c7b4a5e459@aliel.fr>
 <512d95b5-5348-4c7c-961c-b6ca1431cee4@linaro.org>
Content-Language: en-US
In-Reply-To: <512d95b5-5348-4c7c-961c-b6ca1431cee4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[aliel.fr:s=courrier-s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33934-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[aliel.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,baylibre.com,googlemail.com,kernel.org,linaro.org,sipsolutions.net,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-kernel-dev@aliel.fr,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[aliel.fr:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aliel.fr:dkim,aliel.fr:email,aliel.fr:mid,linaro.org:email,0.0.0.0:email]
X-Rspamd-Queue-Id: 76095332692
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 9:54 AM, Neil Armstrong wrote:
> On 3/25/26 10:15, Ronald Claveau wrote:
>> Enable and configure the three MMC controllers for the Khadas VIM4 board:
>> - sd_emmc_a: SDIO interface for the BCM43752 Wi-Fi module
>> - sd_emmc_b: SD card slot
>> - sd_emmc_c: eMMC storage
>>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>> ---
>>   .../dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts  | 90 ++++++++++++
>> +++++++++-
>>   1 file changed, 89 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-
>> vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
>> index 770f06b0b16c7..5a73ae081036c 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
>> @@ -14,7 +14,10 @@ / {
>>       compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
>>         aliases {
>> -        serial0 = &uart_a;
>> +        serial0    = &uart_a;
> 
> Spurious change
> 

Thanks I will keep space instead of tab here.

>> +        mmc0    = &sd_emmc_c;
>> +        mmc1    = &sd_emmc_b;
>> +        mmc2    = &sd_emmc_a;
>>       };
>>         memory@0 {
>> @@ -159,6 +162,91 @@ &pwm_ab {
>>       pinctrl-names = "default";
>>   };
>>   +/* SDIO */
>> +&sd_emmc_a {
>> +    status = "okay";
>> +    pinctrl-0 = <&sdio_pins>;
>> +    pinctrl-1 = <&sdio_clk_gate_pins>;
>> +    pinctrl-names = "default", "clk-gate";
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +
>> +    bus-width = <4>;
>> +    cap-sd-highspeed;
>> +    sd-uhs-sdr12;
>> +    sd-uhs-sdr25;
>> +    sd-uhs-sdr50;
>> +    sd-uhs-sdr104;
>> +    cap-sdio-irq;
>> +    max-frequency = <200000000>;
>> +    non-removable;
>> +    disable-wp;
>> +    no-mmc;
>> +    no-sd;
>> +
>> +    power-domains = <&pwrc PWRC_T7_SDIO_A_ID>;
>> +
>> +    keep-power-in-suspend;
>> +
>> +    mmc-pwrseq = <&sdio_pwrseq>;
>> +
>> +    vmmc-supply = <&vddao_3v3>;
>> +    vqmmc-supply = <&vddao_1v8>;
>> +
>> +    brcmf: wifi@1 {
>> +        reg = <1>;
>> +        compatible = "brcm,bcm43752-fmac", "brcm,bcm4329-fmac";
>> +    };
>> +};
>> +
>> +/* SD card */
>> +&sd_emmc_b {
>> +    status = "okay";
>> +    pinctrl-0 = <&sdcard_pins>;
>> +    pinctrl-1 = <&sdcard_clk_gate_pins>;
>> +    pinctrl-names = "default", "clk-gate";
>> +
>> +    bus-width = <4>;
>> +    cap-sd-highspeed;
>> +    sd-uhs-sdr12;
>> +    sd-uhs-sdr25;
>> +    sd-uhs-sdr50;
>> +    sd-uhs-sdr104;
>> +    max-frequency = <200000000>;
>> +    disable-wp;
>> +    no-sdio;
>> +    no-mmc;
>> +
>> +    power-domains = <&pwrc PWRC_T7_SDIO_B_ID>;
>> +
>> +    cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
>> +    vmmc-supply = <&sd_3v3>;
>> +    vqmmc-supply = <&vddio_c>;
>> +};
>> +
>> +/* eMMC */
>> +&sd_emmc_c {
>> +    status = "okay";
>> +    pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>,
>> <&emmc_ds_pins>;
>> +    pinctrl-1 = <&emmc_clk_gate_pins>;
>> +    pinctrl-names = "default", "clk-gate";
>> +
>> +    bus-width = <8>;
>> +    cap-mmc-highspeed;
>> +    mmc-ddr-1_8v;
>> +    mmc-hs200-1_8v;
>> +    max-frequency = <200000000>;
>> +    disable-wp;
>> +    non-removable;
>> +    no-sdio;
>> +    no-sd;
>> +
>> +    power-domains = <&pwrc PWRC_T7_EMMC_ID>;
>> +
>> +    vmmc-supply = <&vddio_3v3>;
>> +    vqmmc-supply = <&vddio_1v8>;
>> +};
>> +
>>   &uart_a {
>>       status = "okay";
>>       clocks = <&xtal>, <&xtal>, <&xtal>;
>>
> 
> With that:
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Thanks,
> Neil


-- 
Best regards,
Ronald

