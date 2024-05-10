Return-Path: <linux-wireless+bounces-7440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2997C8C2015
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 10:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9201F21975
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB3377119;
	Fri, 10 May 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="sNnoAgxC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C1313C827
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715331219; cv=none; b=Igwkt+OUJRXhXrQEoQrt6I+orWSR4epoK8gYzdzCmBhGenoE7L+8O6Ll3QMh+UqgsuNleK9vvQGM0wQxh8p7inzQr/ePCGHwPYvpSoEXr6he/ndfK/4qLRAA1SfciFksgV4hVbTgCErpCgC8M1epmSbT7Oqu5UYDymaIj8WFBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715331219; c=relaxed/simple;
	bh=8kMvzTWQsyHILcUOzdfNUPWiJJKGl3cncGowDiDKyo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRrsXti9+2Vu/bAgaG16ewKgALYxrfIRf2oW8KPqe3Lj0jjlDrKtQAkkcPBSlFWsmQD9ygtO3P4NA5jYEfq619zyWrPxFgODfLE90+SdY4M37E9/DAvJQYcOzvxQwZ3bCj+8MFKw/ly9f1p4FCEde8M5ictuiRQxwnt7Tdaw2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com; spf=pass smtp.mailfrom=dd-wrt.com; dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b=sNnoAgxC; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dd-wrt.com
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:35894 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.97.1)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1s5M0T-0000000010E-1SBk;
	Fri, 10 May 2024 10:53:33 +0200
X-SASI-Hits: CTE_7BIT 0.000000, DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000,
	ECARD_WORD 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
	IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000,
	MSGID_SAMEAS_FROM_HEX_844412 0.100000, MSG_THREAD 0.000000,
	MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000,
	NO_FUR_HEADER 0.000000, OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000,
	REFERENCES 0.000000, SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000,
	URI_WITH_PATH_ONLY 0.000000, __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
	__BOUNCE_CHALLENGE_SUBJ 0.000000, __BOUNCE_NDR_SUBJ_EXEMPT 0.000000,
	__BULK_NEGATE 0.000000, __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
	__CC_REAL_NAMES 0.000000, __CP_URI_IN_BODY 0.000000, __CT 0.000000,
	__CTE 0.000000, __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000,
	__DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
	__DQ_NEG_IP 0.000000, __FORWARDED_MSG 0.000000,
	__FRAUD_BODY_WEBMAIL 0.000000, __FRAUD_WEBMAIL 0.000000,
	__FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
	__HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000, __HTTPS_URI 0.000000,
	__INVOICE_MULTILINGUAL 0.000000, __IN_REP_TO 0.000000, __MAIL_CHAIN 0.000000,
	__MAIL_CHAIN_OLD 0.000000, __MIME_BOUND_CHARSET 0.000000,
	__MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
	__MIME_VERSION 0.000000, __MOZILLA_USER_AGENT 0.000000,
	__MSGID_HEX_844412 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
	__MULTIPLE_RCPTS_TO_X2 0.000000, __MULTIPLE_URI_TEXT 0.000000,
	__NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
	__OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
	__PHISH_PHRASE10_D 0.000000, __PHISH_SPEAR_SUBJ_TEAM 0.000000,
	__RCVD_PASS 0.000000, __REFERENCES 0.000000, __SANE_MSGID 0.000000,
	__SCAN_D_NEG 0.000000, __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
	__SCAN_D_NEG_HEUR2 0.000000, __SUBJ_ALPHA_END 0.000000,
	__SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_REPLY 0.000000,
	__TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
	__TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
	__URI_IN_BODY 0.000000, __URI_MAILTO 0.000000, __URI_NOT_IMG 0.000000,
	__URI_NO_WWW 0.000000, __URI_NS 0.000000, __URI_WITH_PATH 0.000000,
	__USER_AGENT 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2024.5.10.82716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID; bh=+D0lJ6XGvB7RcRH/OwONvFz4A82ou2NnW/z7IzLDnFQ=;
	b=sNnoAgxClLp/fkgfhDTVqufBvQ0NJOtEXvL9p03lZeTBFEVUcqONW/W81dZyoR6H4yns3IJ6hCcWK2CP7UQj7tMlV4SUwx91cmsIvuVYsdwCmoeP374mj57+5oHkosYOPmeT6OWvmCb/BIjcVdJAsnzQvTHfUlZutvElQden8GY=;
Message-ID: <81137bf1-09a3-42ca-a9d6-fefeba693c05@dd-wrt.com>
Date: Fri, 10 May 2024 10:53:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v14] ath10k: add LED and GPIO controlling support for
 various chipsets
To: Christian Marangi <ansuelsmth@gmail.com>, Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, Steve deRosier <derosier@cal-sierra.com>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>
References: <20230611080505.17393-1-ansuelsmth@gmail.com>
 <878rcjbaqs.fsf@kernel.org> <648cdebb.5d0a0220.be7f8.a096@mx.google.com>
 <648ded2a.df0a0220.b78de.4603@mx.google.com>
 <CA+_ehUzzVq_sVTgVCM+r=oLp=GNn-6nJRBG=bndJjrRDhCodaw@mail.gmail.com>
 <87v83nlhb3.fsf@kernel.org> <663c9fc7.050a0220.5fb3a.4e87@mx.google.com>
From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
In-Reply-To: <663c9fc7.050a0220.5fb3a.4e87@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=s.gottschall@dd-wrt.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: s.gottschall@dd-wrt.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1s5M08-000Cnb-2J
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: s.gottschall@dd-wrt.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1s5M08-000Cnb-2J; Fri, 10 May 2024 10:53:12 +0200


Am 09.05.2024 um 12:04 schrieb Christian Marangi:
> On Thu, May 09, 2024 at 07:50:40AM +0300, Kalle Valo wrote:
>> Ansuel Smith <ansuelsmth@gmail.com> writes:
>>
>>> Il giorno sab 17 giu 2023 alle ore 19:28 Christian Marangi
>>> <ansuelsmth@gmail.com> ha scritto:
>>>
>>>> On Fri, Jun 16, 2023 at 01:35:04PM +0200, Christian Marangi wrote:
>>>>> On Fri, Jun 16, 2023 at 08:03:23PM +0300, Kalle Valo wrote:
>>>>>> Christian Marangi <ansuelsmth@gmail.com> writes:
>>>>>>
>>>>>>> From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
>>>>>>>
>>>>>>> Adds LED and GPIO Control support for 988x, 9887, 9888, 99x0, 9984
>>>>>>> based chipsets with on chipset connected led's using WMI Firmware API.
>>>>>>> The LED device will get available named as "ath10k-phyX" at sysfs and
>>>>>>> can be controlled with various triggers.
>>>>>>> Adds also debugfs interface for gpio control.
>>>>>>>
>>>>>>> Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
>>>>>>> Reviewed-by: Steve deRosier <derosier@cal-sierra.com>
>>>>>>> [kvalo: major reorg and cleanup]
>>>>>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>>>>>> [ansuel: rebase and small cleanup]
>>>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>>>>>> Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
>>>>>>> ---
>>>>>>>
>>>>>>> Hi,
>>>>>>> this is a very old patch from 2018 that somehow was talked till 2020
>>>>>>> with Kavlo asked to rebase and resubmit and nobody did.
>>>>>>> So here we are in 2023 with me trying to finally have this upstream.
>>>>>>>
>>>>>>> A summarize of the situation.
>>>>>>> - The patch is from years in OpenWRT. Used by anything that has ath10k
>>>>>>>    card and a LED connected.
>>>>>>> - This patch is also used by the fw variant from Candela Tech with no
>>>>>>>    problem reported.
>>>>>>> - It was pointed out that this caused some problem with ipq4019 SoC
>>>>>>>    but the problem was actually caused by a different bug related to
>>>>>>>    interrupts.
>>>>>>>
>>>>>>> I honestly hope we can have this feature merged since it's really
>>>>>>> funny to have something that was so near merge and jet still not
>>>>>>> present and with devices not supporting this simple but useful
>>>>>>> feature.
>>>>>> Indeed, we should finally get this in. Thanks for working on it.
>>>>>>
>>>>>> I did some minor changes to the patch, they are in my pending branch:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=686464864538158f22842dc49eddea6fa50e59c1
>>>>>>
>>>>>> My comments below, please review my changes. No need to resend because
>>>>>> of these.
>>>>>>
>>>>> Hi,
>>>>> very happy this is going further.
>>>>>
>>>>>>> --- a/drivers/net/wireless/ath/ath10k/Kconfig
>>>>>>> +++ b/drivers/net/wireless/ath/ath10k/Kconfig
>>>>>>> @@ -67,6 +67,23 @@ config ATH10K_DEBUGFS
>>>>>>>
>>>>>>>      If unsure, say Y to make it easier to debug problems.
>>>>>>>
>>>>>>> +config ATH10K_LEDS
>>>>>>> + bool "Atheros ath10k LED support"
>>>>>>> + depends on ATH10K
>>>>>>> + select MAC80211_LEDS
>>>>>>> + select LEDS_CLASS
>>>>>>> + select NEW_LEDS
>>>>>>> + default y
>>>>>>> + help
>>>>>>> +   This option enables LEDs support for chipset LED pins.
>>>>>>> +   Each pin is connected via GPIO and can be controlled using
>>>>>>> +   WMI Firmware API.
>>>>>>> +
>>>>>>> +   The LED device will get available named as "ath10k-phyX" at sysfs and
>>>>>>> +           can be controlled with various triggers.
>>>>>>> +
>>>>>>> +   Say Y, if you have LED pins connected to the ath10k wireless card.
>>>>>> I'm not sure anymore if we should ask anything from the user, better to
>>>>>> enable automatically if LED support is enabled in the kernel. So I
>>>>>> simplified this to:
>>>>>>
>>>>>> config ATH10K_LEDS
>>>>>>      bool
>>>>>>      depends on ATH10K
>>>>>>      depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211
>>>>>>      default y
>>>>>>
>>>>>> This follows what mt76 does:
>>>>>>
>>>>>> config MT76_LEDS
>>>>>>      bool
>>>>>>      depends on MT76_CORE
>>>>>>      depends on LEDS_CLASS=y || MT76_CORE=LEDS_CLASS
>>>>>>      default y
>>>>>>
>>>>> I remember there was the same discussion in a previous series. OK for me
>>>>> for making this by default, only concern is any buildbot error (if any)
>>>>>
>>>>> Anyway OK for the change.
>>>>>
>>>>>>> @@ -65,6 +66,7 @@ static const struct ath10k_hw_params
>>>>>>> ath10k_hw_params_list[] = {
>>>>>>>            .dev_id = QCA988X_2_0_DEVICE_ID,
>>>>>>>            .bus = ATH10K_BUS_PCI,
>>>>>>>            .name = "qca988x hw2.0",
>>>>>>> +         .led_pin = 1,
>>>>>>>            .patch_load_addr = QCA988X_HW_2_0_PATCH_LOAD_ADDR,
>>>>>>>            .uart_pin = 7,
>>>>>>>            .cc_wraparound_type = ATH10K_HW_CC_WRAP_SHIFTED_ALL,
>>>>>> I prefer following the field order from struct ath10k_hw_params
>>>>>> declaration and also setting fields explicitly to zero (even though
>>>>>> there are gaps still) so I changed that for every entry.
>>>>>>
>>>>> Thanks for the change, np for me.
>>>>>
>>>>>>> +int ath10k_leds_register(struct ath10k *ar)
>>>>>>> +{
>>>>>>> + int ret;
>>>>>>> +
>>>>>>> + if (ar->hw_params.led_pin == 0)
>>>>>>> +         /* leds not supported */
>>>>>>> +         return 0;
>>>>>>> +
>>>>>>> + snprintf(ar->leds.label, sizeof(ar->leds.label), "ath10k-%s",
>>>>>>> +          wiphy_name(ar->hw->wiphy));
>>>>>>> + ar->leds.wifi_led.active_low = 1;
>>>>>>> + ar->leds.wifi_led.gpio = ar->hw_params.led_pin;
>>>>>>> + ar->leds.wifi_led.name = ar->leds.label;
>>>>>>> + ar->leds.wifi_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
>>>>>>> +
>>>>>>> + ar->leds.cdev.name = ar->leds.label;
>>>>>>> + ar->leds.cdev.brightness_set_blocking = ath10k_leds_set_brightness_blocking;
>>>>>>> +
>>>>>>> + /* FIXME: this assignment doesn't make sense as it's NULL, remove it? */
>>>>>>> + ar->leds.cdev.default_trigger = ar->leds.wifi_led.default_trigger;
>>>>>> But what to do with this FIXME?
>>>>>>
>>>>> It was pushed by you in v13.
>>>>>
>>>>> I could be wrong but your idea was to prepare for future support of
>>>>> other patch that would set the default_trigger to the mac80211 tpt.
>>>>>
>>>>> We might got both confused by default_trigger and default_state.
>>>>> default_trigger is actually never set and is NULL (actually it's 0)
>>>>>
>>>>> We have other 2 patch that adds tpt rates for the mac80211 LED trigger
>>>>> and set this trigger as the default one but honestly I would chose a
>>>>> different implementation than hardcoding everything.
>>>>>
>>>>> If it's ok for you, I would drop the comment and the default_trigger and
>>>>> I will send a follow-up patch to this adding DT support by using
>>>>> led_classdev_register_ext and defining init_data.
>>>>> (and this indirectly would permit better LED naming and defining of
>>>>> default-trigger in DT)
>>>>>
>>>>> Also ideally I will also send a patch for default_state following
>>>>> standard LED implementation. (to set default_state in DT)
>>>>>
>>>>> I would prefer this approach as the LED patch already took way too much
>>>>> time and I think it's better to merge this initial version and then
>>>>> improve it.
>>>> If you want to check out I attached the 2 patch (one dt-bindings and the
>>>> one for the code) that I will submit when this will be merged (the
>>>> change is with the assumption that the FIXME line is dropped)
>>>>
>>>> Tested and works correctly with my use case of wifi card attached with
>>>> pcie. This implementation permits to declare the default trigger in DT
>>>> instead of hardcoding.
>>>>
>>> Any news with this? Did I notice the LEDs patch are still in pending...
>> Sorry for the delay but finally I looked at this again. I decided to
>> just remove the fixme and otherwise it looks good for me. Please check
>> my changes:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=688130a66ed49f20ca0ce02c3987f6a474f7c93a
>>
> All ok for me, Just I notice the ATH10K_LEDS is not exposed anymore? Is
> that intended?
>
> Aside from this very happy that we are finally finishing with this long
> lasting feature!

since ATH10K_LEDS is no exposed option anymore. how is this feature 
enabled then? Its not selected by any dependency

Sebastian

>

