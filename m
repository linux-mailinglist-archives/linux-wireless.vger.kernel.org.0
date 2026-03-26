Return-Path: <linux-wireless+bounces-33932-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG1TDAv8xGny5QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33932-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:27:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A78EA332521
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A37430E0D3A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 09:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316ED3164BA;
	Thu, 26 Mar 2026 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="pGEt6Bsp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from courrier.aliel.fr (pouet.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1DC31717B;
	Thu, 26 Mar 2026 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516954; cv=none; b=LgjCkHznJfJmPD6ABSde21fsrh3SI4lMuqrzHqU5iDUYr2jUzVFwH/RiRW0fWHnWhUSOoR5HHjBmwCnAssDEQc1FeAGeLfvbjH1O+3/0OE1bSct6WR+FUmR15QTAVnzWKSq8wDpKh4TI7hdMiRNzVkYShrgXYC5CuaMIiSRKzGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516954; c=relaxed/simple;
	bh=T5Gnu4yLDY6S9iBMZo1e1nUZtHu8V8m/kPrwHC6rWMQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pmk2qPTo4xBBfubUgjqyP98SvWqwaOnYXf60LyFnYgmTozRfgWZ+EnZFP63b+NasLmR+EXPD3vEjpEddj7VGzFDctWyQkMKpnJY7wX5PU9aXuMOLf470pFXXclmDFZvuZ7nySzu9kNIbnHXdxn6rLORzHWtDukIH9yUlSSqQohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=pGEt6Bsp; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Message-ID: <8e722981-db67-4529-abdc-ea7dec02e5ba@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1774516950;
	bh=T5Gnu4yLDY6S9iBMZo1e1nUZtHu8V8m/kPrwHC6rWMQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=pGEt6BspYwu2UBwjNusLubOi0aBAOaebCYF1iZEVI2/fKnASLYTxiNuRzwLV56N+P
	 CIH3Iw2pgoIiGo/WnTcUavi4C1vJ6ip4/FlOHTQmawnRM1d2z/uzY9JYURnjCzmhlj
	 2hLxwsSOpfSQ2PQZ8xlR2w+XICSS2T/jT+wqc714=
Date: Thu, 26 Mar 2026 10:22:29 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v4 3/9] arm64: dts: amlogic: t7: Add MMC controller nodes
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
 <20260325-add-emmc-t7-vim4-v4-3-44c7b4a5e459@aliel.fr>
 <4b2ba22d-7d0b-4c71-ad83-46d198718fec@linaro.org>
Content-Language: en-US
In-Reply-To: <4b2ba22d-7d0b-4c71-ad83-46d198718fec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[aliel.fr:s=courrier-s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[aliel.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33932-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliel.fr:dkim,aliel.fr:email,aliel.fr:mid,8c000:email,0.1.87.192:email,8a000:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.39.236:email]
X-Rspamd-Queue-Id: A78EA332521
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 9:52 AM, Neil Armstrong wrote:
> On 3/25/26 10:15, Ronald Claveau wrote:
>> Add device tree nodes for the three MMC controllers available
>> on the Amlogic T7 SoC, using amlogic,meson-axg-mmc as fallback
>> compatible.
>> All nodes are disabled by default and should be
>> enabled in the board-specific DTS file.
>>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>> ---
>>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 39 +++++++++++++++++++
>> ++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/
>> boot/dts/amlogic/amlogic-t7.dtsi
>> index 016b5429c8d1b..62c87d0ef7065 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>> @@ -374,6 +374,45 @@ sec_ao: ao-secure@10220 {
>>                   reg = <0x0 0x10220 0x0 0x140>;
>>                   amlogic,has-chip-id;
>>               };
>> +
>> +            sd_emmc_a: mmc@88000 {
>> +                compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
>> +                reg = <0x0 0x88000 0x0 0x800>;
>> +                interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
>> +                status = "disabled";
> 
> move disabled at the end of the properties
> 

Thanks I will do.

>> +                clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_A>,
>> +                     <&clkc_periphs CLKID_SD_EMMC_A>,
>> +                     <&scmi_clk CLKID_FCLK_DIV2>;
>> +                clock-names = "core", "clkin0", "clkin1";
>> +                assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_A_SEL>;
>> +                assigned-clock-parents = <&xtal>;
>> +            };
>> +
>> +            sd_emmc_b: mmc@8a000 {
>> +                compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
>> +                reg = <0x0 0x8a000 0x0 0x800>;
>> +                interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
>> +                status = "disabled";
> Ditto
> 
>> +                clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_B>,
>> +                     <&clkc_periphs CLKID_SD_EMMC_B>,
>> +                     <&scmi_clk CLKID_FCLK_DIV2>;
>> +                clock-names = "core", "clkin0", "clkin1";
>> +                assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_B_SEL>;
>> +                assigned-clock-parents = <&xtal>;
>> +            };
>> +
>> +            sd_emmc_c: mmc@8c000 {
>> +                compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
>> +                reg = <0x0 0x8c000 0x0 0x800>;
>> +                interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
>> +                status = "disabled";
> Ditto
>> +                clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_C>,
>> +                     <&clkc_periphs CLKID_SD_EMMC_C>,
>> +                     <&scmi_clk CLKID_FCLK_DIV2>;
>> +                clock-names = "core", "clkin0", "clkin1";
>> +                assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_C_SEL>;
>> +                assigned-clock-parents = <&xtal>;
>> +            };
>>           };
>>         };
>>
> 


-- 
Best regards,
Ronald

