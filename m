Return-Path: <linux-wireless+bounces-5305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A886F88D095
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 23:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6EDAB2097A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 22:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C5F13D538;
	Tue, 26 Mar 2024 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG4SuphH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884413D8B7
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491211; cv=none; b=u9xH3IihJsvwa8W+qRyZZDlO3hcdaGBxHNurOfuBdrQ6HZxD13IL8vKpqgs+u5KYbjFnPap52yQsGHPzuWJR4geDXhUlQdndUlW+pNxZ0AowR+CGhNhwNMoOAzqt+dMpCbA76Oey9+kVtL7uJKcnWWZ9v9QdB6OkmVD+QKB/iAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491211; c=relaxed/simple;
	bh=MggI4/cCBq2BUuzshMy3C6UMKU9fTV/UAKA8fDCbEjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwyOG/Cd6cAbNtutaWstR9oz35Lw+TklqkbGMKvq1sx2FHlaI98xQKr7ajpyjhTZ90zn8RiTusQun6luRUrX66e31T/z2yhTn/iUUM/1IGbwLLbUf0VXG0tnUCnmj/VVeaq2/1eOGOeT00a7jZGB6RcnnYdNEgowabMkQQhxm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG4SuphH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ddd1624beso168245f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711491208; x=1712096008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FIg/yDH95CXQ3WhdcuFG1a4QrqIEH4/wOAh2F5wg9EA=;
        b=fG4SuphHCmJmgxMJeS90c0XPkAzxlfvfyDlB0BOt/xTFtkG8svU+++kRgBNXXux+yZ
         wlOOg8Ur6pkQrzlGCXVCvCN8esTjIRxGOM5WYwyPJuBp3QC2RNWqiWiMiUv+RmMfff00
         qT+PinP7dk2/LoJxHzfj0AofnBSuyHD3l7gBHn309yKj3FOxk1NXflKjaFOYHswhKik5
         AqWvZas9YGD+TjVUgwoGLWWr1L+Rr+JgzvYE0swmeX+bBMtYUwRIedn/UcqWkub/PfxQ
         wwSVVadlUPCBxcxIeogsaDBeyo3BnM5TDUJcUcFr08Xfifz/tJlUyN29yHTQ6Mcseklb
         elCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711491208; x=1712096008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIg/yDH95CXQ3WhdcuFG1a4QrqIEH4/wOAh2F5wg9EA=;
        b=XZcW3cp/JDykR/85JO7RcbRyPaAuxKgIZTeviLmTOG3xg73yWvQh3Iu2S65TjQuT1U
         B+hS+m91w+0IMB3jvIYFBOk9Sf6tKFQC/l1sxJ3EkKV92rRc22nkNIhaufVFVZRBHcsW
         bk9WKHKsrPXyhMKhoP3XBxuh6GtL90HyKxQjGLCg/abERye3RfTSo1BUeCQKuJupUVxN
         QMktIJ9Lo7GdfYjWXx4+yQb3YeLKt1wN17JueE1br+sDeN3vTsRCayaqJeHRldcOf2AJ
         eYOx0kqoceW86PiVQeCZRAzh1Fj4K7sSZbgO3aeWjAJ4MZXLPiU071eDMrL62C9MrE/x
         sTgg==
X-Forwarded-Encrypted: i=1; AJvYcCXvr1TPpJeAXhB640lYlNDhT4GOKxoP99pq69fhPT8j4Zek+ppG0y2JVJ5lVL0Yyn97gRN3gROG/D6hoHxiMISPKy2Zk1p7NprxIPgjSeQ=
X-Gm-Message-State: AOJu0YyO471oBq7vNME3p7hyFXsTlqOuw4Z8uXbJhlo7VySlvdBQdNsg
	PJCv+8TF75R5koMmQOMoagMMde6NRkYO0/Kd69MMYbnpLBHrUFRa
X-Google-Smtp-Source: AGHT+IF13YKzQtMFZ8/mwHnL0IWSJy5H80WKol2arnqzNfimbavSYj/diVbSfj7JaUpTgcya9EDU7g==
X-Received: by 2002:adf:ed84:0:b0:341:c739:5ec1 with SMTP id c4-20020adfed84000000b00341c7395ec1mr3006014wro.4.1711491208225;
        Tue, 26 Mar 2024 15:13:28 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.188])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d40c1000000b0033e7a204dc7sm13111306wrq.32.2024.03.26.15.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:13:27 -0700 (PDT)
Message-ID: <387fa334-cc78-44fb-a638-0da9d104250c@gmail.com>
Date: Wed, 27 Mar 2024 00:13:26 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] wifi: rtlwifi: Add rtl8192du/phy.{c,h}
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <367ae147-3f2d-4ecc-989f-62fd7d82ebfc@gmail.com>
 <59596a57735c713a135ec64b05b8031ad9149421.camel@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <59596a57735c713a135ec64b05b8031ad9149421.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 07:22, Ping-Ke Shih wrote:
> On Wed, 2024-03-20 at 21:38 +0200, Bitterblue Smith wrote:

> [...]
> 
>> +void rtl92d_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t)
>> +{
>> +       struct rtl_priv *rtlpriv = rtl_priv(hw);
>> +       struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
>> +       struct rtl_phy *rtlphy = &rtlpriv->phy;
>> +       u32 timeout = 2000, timecount = 0;
>> +
>> +       while (rtlpriv->mac80211.act_scanning && timecount < timeout) {
>> +               udelay(50);
>> +               timecount += 50;
> 
> What is the purpose? 
> 
> Even if you really need it, just mdelay(2) or something like that? > 

This comes from rtl8192de. The TX power tracking can re-do LC
calibration. Someone decided that shouldn't happen while
scanning. I don't know why.

>> +       }
>> +
>> +       rtlphy->lck_inprogress = true;
>> +       RTPRINT(rtlpriv, FINIT, INIT_IQK,
>> +               "LCK:Start!!! currentband %x delay %d ms\n",
>> +               rtlhal->current_bandtype, timecount);
>> +
>> +       _rtl92d_phy_lc_calibrate_sw(hw, is2t);
>> +
>> +       rtlphy->lck_inprogress = false;
>> +       RTPRINT(rtlpriv, FINIT, INIT_IQK,  "LCK:Finish!!!\n");
>> +}
>> +
> 
> [...]
> 
>> +u8 rtl92d_phy_sw_chnl(struct ieee80211_hw *hw)
>> +{
>> + 
> 
> [...]
> 
>> +       while (rtlphy->lck_inprogress && timecount < timeout) {
>> +               mdelay(50);
>> +               timecount += 50;
>> +       }
> 
> Could LCK and switch channel happen simultaneously?
> Can you point out the case?
> 

When a scan coincides with the TX power tracking deciding to
re-do LC calibration, I guess.

> 
>> +       if (rtlhal->macphymode == SINGLEMAC_SINGLEPHY &&
>> +           rtlhal->bandset == BAND_ON_BOTH) {
>> +               ret_value = rtl_get_bbreg(hw, RFPGA0_XAB_RFPARAMETER,
>> +                                         MASKDWORD);
>> +               if (rtlphy->current_channel > 14 && !(ret_value & BIT(0)))
>> +                       rtl92d_phy_switch_wirelessband(hw, BAND_ON_5G);
>> +               else if (rtlphy->current_channel <= 14 && (ret_value & BIT(0)))
>> +                       rtl92d_phy_switch_wirelessband(hw, BAND_ON_2_4G);
>> +       }
>> +       switch (rtlhal->current_bandtype) {
>> +       case BAND_ON_5G:
>> +               /* Get first channel error when change between
>> +                * 5G and 2.4G band.
>> +                */
>> +               if (WARN_ONCE(channel <= 14, "rtl8192de: 5G but channel<=14\n"))
>> +                       return 0;
>> +               break;
>> +       case BAND_ON_2_4G:
>> +               /* Get first channel error when change between
>> +                * 5G and 2.4G band.
>> +                */
>> +               if (WARN_ONCE(channel > 14, "rtl8192de: 2G but channel>14\n"))
>> +                       return 0;
>> +               break;
>> +       default:
>> +               WARN_ONCE(true, "rtl8192de: Invalid WirelessMode(%#x)!!\n",
>> +                         rtlpriv->mac80211.mode);
>> +               break;
>> +       }
>> +       rtlphy->sw_chnl_inprogress = true;
>> +       if (channel == 0)
>> +               channel = 1;
> 
> Can this really happen? 
> 

I think it can't happen in rtl8192du. I will remove this check.

> 
> 
>> +
>> +       /* notice fw know band status  0x81[1]/0x53[1] = 0: 5G, 1: 2G */
>> +       if (rtlhal->current_bandtype == BAND_ON_2_4G) {
>> +               value8 = rtl_read_byte(rtlpriv, mac_reg);
>> +               value8 |= BIT(1);
>> +               rtl_write_byte(rtlpriv, mac_reg, value8);
>> +       } else {
>> +               value8 = rtl_read_byte(rtlpriv, mac_reg);
>> +               value8 &= (~BIT(1));
>> +               rtl_write_byte(rtlpriv, mac_reg, value8);
>> +       }
>> +
>> +       if (rtlhal->macphymode == SINGLEMAC_SINGLEPHY) {
>> +               value8 = rtl_read_byte(rtlpriv, REG_MAC0);
>> +               rtl_write_byte(rtlpriv, REG_MAC0, value8 | MAC0_ON);
>> +       } else {
>> +               mutex_lock(&globalmutex_power);
> 
> What do you need 'global' mutex? Usually, we want to support multiple instances
> run simultaneously. Does this mutext across instances? 
> I feel not. Please move them into struct rtl_priv.
> 

With the dual MAC version of RTL8192DU two instances of the
driver will access the same chip. This is why we have some
global mutexes. I think multiple devices can still work at the
same time, they will just slow each other down a little during
hardware init/deinit.

>> +               if (rtlhal->interfaceindex == 0) {
>> +                       value8 = rtl_read_byte(rtlpriv, REG_MAC0);
>> +                       rtl_write_byte(rtlpriv, REG_MAC0, value8 | MAC0_ON);
>> +               } else {
>> +                       value8 = rtl_read_byte(rtlpriv, REG_MAC1);
>> +                       rtl_write_byte(rtlpriv, REG_MAC1, value8 | MAC1_ON);
>> +               }
>> +               value8 = rtl_read_byte(rtlpriv, REG_POWER_OFF_IN_PROCESS);
>> +               mutex_unlock(&globalmutex_power);
> 

