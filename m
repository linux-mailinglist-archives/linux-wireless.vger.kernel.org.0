Return-Path: <linux-wireless+bounces-33931-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOuONh38xGny5QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33931-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:27:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F11332529
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA0D03059DF1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F5C3218DD;
	Thu, 26 Mar 2026 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="DLHP6k5b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from courrier.aliel.fr (pouet.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF58B23BCE3;
	Thu, 26 Mar 2026 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516895; cv=none; b=CpvGsglUZKLvJVDAYylN53JWrjHPCXg63FQcBtD/QHUI56GjYTWu+LTg39PFoZct6NopmJonvr5vfdZ6UXRyzM9T7egLyfFMO9LwCzoGWqhpel7WWR9IxoJSiNALLNoAWUCcY7bN+N8NyRsHUTCBZTBH7P5J+JabaaW0IxP6BRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516895; c=relaxed/simple;
	bh=2YaYUbMMIxfIM/eW1LcT+WvPOTT5iE3ZIsUBYpytHd8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jifmSf8zp9P0Fyh+7l46rgXvPbS4yVQBjYHSFDGFOJ7/IVdn+o6gkVzN9fI6yfiddddYDyPhGiUiIyPcSORgWrIsIMaUUjYqwHenr1TbPXHJ770S4Nrww2gaR7qzWRkeUgh/OkW/R41RYTEyGyCkiRGfEMEE6CP93cmRt+b9ZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=DLHP6k5b; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Message-ID: <3e99df2d-b569-4542-bae7-6da69077c6f4@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1774516881;
	bh=2YaYUbMMIxfIM/eW1LcT+WvPOTT5iE3ZIsUBYpytHd8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=DLHP6k5baF5AyGc4dYc8Fd+av78eTCJt05sovXqCIPmDP8TRST1BZFzhtR8b8QH1o
	 icdEuVQR/9j+v4+H9yNfIEHN1IAodzWshk6d+jPCCu437OaOwtVC6yxFqJpaNS4SwR
	 GFvN7gMBxi0oGa0Sf7JWcw6HfOy93flNX4bkIcaA=
Date: Thu, 26 Mar 2026 10:21:20 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v4 1/9] arm64: dts: amlogic: t7: Add eMMC, SD card and
 SDIO pinctrl nodes
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
 <20260325-add-emmc-t7-vim4-v4-1-44c7b4a5e459@aliel.fr>
 <5298e691-99ba-48fc-874b-c9af308664ee@linaro.org>
Content-Language: en-US
In-Reply-To: <5298e691-99ba-48fc-874b-c9af308664ee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[aliel.fr:s=courrier-s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[aliel.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33931-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[aliel.fr:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-kernel-dev@aliel.fr,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,baylibre.com,googlemail.com,kernel.org,linaro.org,sipsolutions.net,broadcom.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.15.160:email,aliel.fr:dkim,aliel.fr:email,aliel.fr:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.15.240:email]
X-Rspamd-Queue-Id: E4F11332529
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 9:52 AM, Neil Armstrong wrote:
> On 3/25/26 10:15, Ronald Claveau wrote:
>> These pinctrl nodes are required by the eMMC, SD card and SDIO drivers
>> to configure pin muxing at runtime.
>>
>> - eMMC: control, 4-bit/8-bit data, data strobe and clock gate pins
>> - SD card: data, clock, command and clock gate pins
>> - SDIO: data, clock, command and clock gate pins
>>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>> ---
>>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 98 +++++++++++++++++++
>> ++++++++++
>>   1 file changed, 98 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/
>> boot/dts/amlogic/amlogic-t7.dtsi
>> index 6510068bcff92..016b5429c8d1b 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>> @@ -250,6 +250,104 @@ gpio: bank@4000 {
>>                       #gpio-cells = <2>;
>>                       gpio-ranges = <&periphs_pinctrl 0 0 157>;
>>                   };
>> +
>> +                emmc_ctrl_pins: emmc-ctrl {
>> +                    mux-0 {
>> +                        groups = "emmc_cmd";
>> +                        function = "emmc";
>> +                        bias-pull-up;
>> +                    };
>> +
>> +                    mux-1 {
>> +                        groups = "emmc_clk";
>> +                        function = "emmc";
>> +                        bias-disable;
>> +                    };
>> +                };
>> +
>> +                emmc_data_4b_pins: emmc-data-4b {
>> +                    mux-0 {
> 
> No need for "-0"
> 

Thanks I will change that for the three nodes.

>> +                        groups = "emmc_nand_d0",
>> +                             "emmc_nand_d1",
>> +                             "emmc_nand_d2",
>> +                             "emmc_nand_d3";
>> +                        function = "emmc";
>> +                        bias-pull-up;
>> +                    };
>> +                };
>> +
>> +                emmc_data_8b_pins: emmc-data-8b {
>> +                    mux-0 {
> 
> No need for "-0"
> 
>> +                        groups = "emmc_nand_d0",
>> +                             "emmc_nand_d1",
>> +                             "emmc_nand_d2",
>> +                             "emmc_nand_d3",
>> +                             "emmc_nand_d4",
>> +                             "emmc_nand_d5",
>> +                             "emmc_nand_d6",
>> +                             "emmc_nand_d7";
>> +                        function = "emmc";
>> +                        bias-pull-up;
>> +                    };
>> +                };
>> +
>> +                emmc_ds_pins: emmc-ds {
>> +                    mux {
>> +                        groups = "emmc_nand_ds";
>> +                        function = "emmc";
>> +                        bias-pull-down;
>> +                    };
>> +                };
>> +
>> +                emmc_clk_gate_pins: emmc-clk-gate {
>> +                    mux {
>> +                        groups = "GPIOB_8";
>> +                        function = "gpio_periphs";
>> +                        bias-pull-down;
>> +                    };
>> +                };
>> +
>> +                sdcard_pins: sdcard {
>> +                    mux {
>> +                        groups = "sdcard_d0",
>> +                             "sdcard_d1",
>> +                             "sdcard_d2",
>> +                             "sdcard_d3",
>> +                             "sdcard_clk",
>> +                             "sdcard_cmd";
>> +                        function = "sdcard";
>> +                        bias-pull-up;
>> +                    };
>> +                };
>> +
>> +                sdcard_clk_gate_pins: sdcard-clk-gate {
>> +                    mux {
>> +                        groups = "GPIOC_4";
>> +                        function = "gpio_periphs";
>> +                        bias-pull-down;
>> +                    };
>> +                };
>> +
>> +                sdio_pins: sdio {
>> +                    mux-0 {
> 
> No need for "-0"
> 
>> +                        groups = "sdio_d0",
>> +                             "sdio_d1",
>> +                             "sdio_d2",
>> +                             "sdio_d3",
>> +                             "sdio_clk",
>> +                             "sdio_cmd";
>> +                        function = "sdio";
>> +                        bias-pull-up;
>> +                    };
>> +                };
>> +
>> +                sdio_clk_gate_pins: sdio-clk-gate {
>> +                    mux {
>> +                        groups = "GPIOX_4";
>> +                        function = "gpio_periphs";
>> +                        bias-pull-up;
>> +                    };
>> +                };
>>               };
>>                 gpio_intc: interrupt-controller@4080 {
>>
> 


-- 
Best regards,
Ronald

