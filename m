Return-Path: <linux-wireless+bounces-35252-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCQ/Lud06mlAzgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35252-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 21:37:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C57456D84
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 21:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 079333004216
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 19:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FB430BBBC;
	Thu, 23 Apr 2026 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5gjiapd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9DE30EF94
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972888; cv=none; b=APvgnq1WdEHFaiXhoLqZtmijpdnf720LOu4e0myMTSnXDp/l14T68wkQ5zjKuDmD93S2zxwtDFyQBoTFwfYOi2M3NOeyk0vWwd7q6aq/WgswjOzVz8n5XQyqxIP1WWRfGsGQGgTHBi/qt0FuV17J3C8znVse7whoYKHvfzdD2Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972888; c=relaxed/simple;
	bh=539Dj0pPYhwl2x+BzLZq+XdlgxBs17271S6FLl4Ch74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/mMuSAohJShkAuRadRPrQAZnypr5IuGhMlK7ZyOIRTDBlix5+lG74SWpus6wlSEwkwOiOPaLKoJXbrpmEpeYlmy9zyGdQsP/2cCR7Db+LvJp+Y/TsP+N78CAzO6EoKcdmPQ8omyNVs6SB0HRr0FZlmDqfyTYPHsxuEmUIWfq+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5gjiapd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so92087565e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 12:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776972885; x=1777577685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SByx/RZF2gtg1snRuA3Fm71cYm2ogOemoitCIMC+OQA=;
        b=D5gjiapdM3cAGIfIU/mjJYbQCNXpvgfqc+Nh4iiph+nL7/APiYTYn1F31Qpt/qCakI
         mtzDpnFKEUhsGkzUwgQdSHAipG2ICYVf3GLWNzOW6c5ZdGaV7JhiwDIHSYhoq2au+5W4
         BoZpcUzmTVmwoK0ApQq/FsOiiKsaDME3XCmy+o0XmLvB1fKz9pijDNOSEqpVYcqV8Tts
         MHMuamVvCrgY3glmX4+oVeHEZFUtqEoVd7O7TwOnoa2gAqR+UnIKq53F7qFO/Hc6/UN0
         ijpC+mLO3/LndzSz2jRpvoNsqc/AFvrDGGIbbUiZ9CMLfjMXwSkW0Mm1bIb2Hq4r1sDF
         5GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776972885; x=1777577685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SByx/RZF2gtg1snRuA3Fm71cYm2ogOemoitCIMC+OQA=;
        b=dltjIEb56UgVp0hiHfwLd0LB2EfmOxcg60qSeDcKWVXHDvtIZEKfJn/mHvZvRvZfjl
         Hx7UOVDx1clEGeMUXxQ0GB7J9uoKCpTkSOJvNuhziNVK55p8A7RSlcIm/80PNWoHaWpu
         FDyIeKuAXyzvczVKcEtF3gt6irOaX9HxAcyfEeFSV2fU5O71+kRgAXg+jf7pBC0VetZL
         zres/XUbMhVaeCvZ0IuuKeb162w8r5axe24WzCgCBo1MTTm3KJeWy5Re5qXrtxZ+z8pP
         NED9p8WYx6i5QqzymF7wAwO84DFfZ0v1D7Gyp3sDlyj2cqmhslh/I/G5M1zNVe+Yyn7l
         ygnw==
X-Forwarded-Encrypted: i=1; AFNElJ90fPeBvr7waycmdnSXn8qW2AH/nxxqcHQ3A/h0dA3qHBpxxumgkYz7HKVDuvDz2YgU76SFmDMk2Qiya3CzIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8iFWX0eaNRKyCjtUe/WIXFbz2wshWYSW4w2iiybhl7OJxCHI2
	jWgAdhoqkDlZkhJnJzHNqR6jW97blePatOa4VbCtxZz8s0cvIN71uDJ5es1MSg==
X-Gm-Gg: AeBDieueoa5lJLMjaIM9pyfbbdYI43T/dcg/GCD2YNBBlHLx4h16NvNpOB0ZSWQPnCT
	Le0n5jd1ccfL4Sw3LULgJxr2L3CJksCwC1OvWGnN8B1I0lbRcgWp2TjCFprtX9vgCiltWaj0WT8
	83vs93cTpgbjn9687YNFs3rRWqMJCfZnnEDU9QmXqHv4xYybmvi5ZI8bkeNUbEHG2vcc9ES8ldO
	Gzu9w72OxIcsCHmwgVx8yBZIIl/teD+9nFh2LLlcmA3dyJmwy5gbrBKtcCeCh6MuxCH46wVLZ0I
	w6IpfQSgRlpBaFMrDV5/4RA8t55IYlhkzDgjkng+dBhV31JDt11MnyAX5HwzL+WbTx35TVJwYlc
	XxN4x3geACbjOj4jAp8w38wS/JfqKt7NY+pzXemHsmFKcJHIcumgr0ZmSft2JScetUCsCGRkaue
	jaLCBKQbF/1cJHxwT7RnHcAcwXKczYKbraTJ2JWTaB
X-Received: by 2002:a05:600c:a086:b0:48a:568f:ae82 with SMTP id 5b1f17b1804b1-48a568fb009mr175288745e9.10.1776972885087;
        Thu, 23 Apr 2026 12:34:45 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48919f54572sm136756605e9.26.2026.04.23.12.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 12:34:44 -0700 (PDT)
Message-ID: <ae18ae17-2c12-4d8f-bc73-122bdc45433c@gmail.com>
Date: Thu, 23 Apr 2026 22:34:42 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 5/5] wifi: rtl8xxxu: Enable 40 MHz width by
 default
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>,
 art1310@proton.me
References: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
 <4f053103-adfd-4ead-acb3-ef69127a4bab@gmail.com>
 <8a4c664f-231f-437e-b010-b741c7ed7be8@leemhuis.info>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <8a4c664f-231f-437e-b010-b741c7ed7be8@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35252-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,proton.me];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: D8C57456D84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/04/2026 16:39, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 11/20/25 15:13, Bitterblue Smith wrote:
>> 40 MHz support is hidden behind the ht40_2g module parameter with
>> this comment:
>>
>> /*
>>  * Some APs will negotiate HT20_40 in a noisy environment leading
>>  * to miserable performance. Rather than defaulting to this, only
>>  * enable it if explicitly requested at module load time.
>>  */
> 
> FYI: this patch causes a regression that was reported to bugzilla
> (reporter CCed here): https://bugzilla.kernel.org/show_bug.cgi?id=221394
> 

Hi Thorsten,

Thanks for letting us know. I replied at the Bugzilla.

> """
> Since kernel 6.19.0, the rtl8xxxu driver fails to maintain a connection
> with the Realtek RTL8188FTV (0bda:f179) USB Wi-Fi adapter. The device
> gets stuck "configuring interface" and eventually times out, effectively
> disappearing from the network manager.
> 
> Regression Window:
> Works perfectly on: 6.12.x (LTS) and 6.18.x (LTS and non LTS).
> Broken on: 6.19.x, up through 7.0.0.
> 
> Notes:
> - The device remains visible on the USB bus (lsusb still shows 0bda:f179).
> - The wlan0 interface is created.
> - NetworkManager attempts to associate, but authentication times out.
> - Disabling USB autosuspend (usbcore.autosuspend=-1) does not resolve
> the issue.
> 
> Hardware:
> Bus 001 Device 002: ID 0bda:f179 Realtek Semiconductor Corp. RTL8188FTV
> 802.11b/g/n 1T1R 2.4G WLAN Adapter
> """
> 
> Then later:
> 
> """
> I confirmed that the Commit dbf9b7b "wifi: rtl8xxxu: Enable 40 MHz width
> by default" is the cause of the regression.
> 
> I tested passing cfg80211_disable_40mhz_24ghz=1 to the cfg80211 module
> on 6.19.x and 7.0, and the adapter works perfectly again.
> 
> In Windows, forcing the adapter to 20_40MHz causes it to be unable to
> connect to any AP, and it only works in 20MHz mode. In Linux 6.19+, it
> gets stuck configuring the interface and crashes. So this is most
> probably a hardware issue.
> """
> 
> Ciao, Thorsten
> 
>> This parameter was added in commit 26f1fad29ad9 ("New driver:
>> rtl8xxxu (mac80211)"). Back then rtl8xxxu only supported RTL8723AU
>> and the RTL8192CU family. It's entirely possible the miserable
>> performance was due to mistakes in the channel switching function,
>> which were fixed in a previous patch.
>>
>> Delete the ht40_2g module parameter. If someone still needs to
>> disable 40 MHz support, cfg80211 has the module parameter
>> cfg80211_disable_40mhz_24ghz. That works too.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
>> ---
>> v2:
>>  - Add Reviewed-by.
>> ---
>>  drivers/net/wireless/realtek/rtl8xxxu/core.c | 19 ++++---------------
>>  1 file changed, 4 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> index a18f73aea837..c06ad064f37c 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> @@ -20,7 +20,6 @@
>>  #define DRIVER_NAME "rtl8xxxu"
>>  
>>  int rtl8xxxu_debug;
>> -static bool rtl8xxxu_ht40_2g;
>>  static bool rtl8xxxu_dma_aggregation;
>>  static int rtl8xxxu_dma_agg_timeout = -1;
>>  static int rtl8xxxu_dma_agg_pages = -1;
>> @@ -45,8 +44,6 @@ MODULE_FIRMWARE("rtlwifi/rtl8192fufw.bin");
>>  
>>  module_param_named(debug, rtl8xxxu_debug, int, 0600);
>>  MODULE_PARM_DESC(debug, "Set debug mask");
>> -module_param_named(ht40_2g, rtl8xxxu_ht40_2g, bool, 0600);
>> -MODULE_PARM_DESC(ht40_2g, "Enable HT40 support on the 2.4GHz band");
>>  module_param_named(dma_aggregation, rtl8xxxu_dma_aggregation, bool, 0600);
>>  MODULE_PARM_DESC(dma_aggregation, "Enable DMA packet aggregation");
>>  module_param_named(dma_agg_timeout, rtl8xxxu_dma_agg_timeout, int, 0600);
>> @@ -4896,8 +4893,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>  				sgi = 1;
>>  
>>  			highest_rate = fls(ramask) - 1;
>> -			if (rtl8xxxu_ht40_2g &&
>> -			    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
>> +			if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40)
>>  				bw = RATE_INFO_BW_40;
>>  			else
>>  				bw = RATE_INFO_BW_20;
>> @@ -7851,7 +7847,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>>  	sband->ht_cap.ht_supported = true;
>>  	sband->ht_cap.ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
>>  	sband->ht_cap.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16;
>> -	sband->ht_cap.cap = IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40;
>> +	sband->ht_cap.cap = IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40 |
>> +			    IEEE80211_HT_CAP_SUP_WIDTH_20_40;
>>  	memset(&sband->ht_cap.mcs, 0, sizeof(sband->ht_cap.mcs));
>>  	sband->ht_cap.mcs.rx_mask[0] = 0xff;
>>  	sband->ht_cap.mcs.rx_mask[4] = 0x01;
>> @@ -7860,15 +7857,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>>  		sband->ht_cap.cap |= IEEE80211_HT_CAP_SGI_40;
>>  	}
>>  	sband->ht_cap.mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
>> -	/*
>> -	 * Some APs will negotiate HT20_40 in a noisy environment leading
>> -	 * to miserable performance. Rather than defaulting to this, only
>> -	 * enable it if explicitly requested at module load time.
>> -	 */
>> -	if (rtl8xxxu_ht40_2g) {
>> -		dev_info(&udev->dev, "Enabling HT_20_40 on the 2.4GHz band\n");
>> -		sband->ht_cap.cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
>> -	}
>> +
>>  	hw->wiphy->bands[NL80211_BAND_2GHZ] = sband;
>>  
>>  	hw->wiphy->rts_threshold = 2347;
> 
> #regzbot introduced: dbf9b7b
> #regzbot title: wifi: rtl8xxxu: 40 MHz mode breaks things (just like in
> Windows)
> #regzbot dup: https://bugzilla.kernel.org/show_bug.cgi?id=221394


