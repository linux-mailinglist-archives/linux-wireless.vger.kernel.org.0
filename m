Return-Path: <linux-wireless+bounces-6460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674A28A8916
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 18:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978D71C2226B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1E0148FFA;
	Wed, 17 Apr 2024 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi0urSry"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5316FF41
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372206; cv=none; b=AXRtPYFmfsjx4ZdS3+gAGMM9/b+30aAKBh1DmDFH+JW2e0LgGqkLQp4Gjnkt74bfuYo56f+xyYsJJM0Db3NmhZHbH8ZLPypangCZsndo1RDdcpd9TrvhfjwYc49PGcXooa9+lS/1fZL7UC9KWlo7dYZsGC9fJdlBmZh5eVtw2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372206; c=relaxed/simple;
	bh=fxA6fRTuucE05Td59mNZ7iKBAIBhlarFs8+ynl4W5V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUi0R9BR9sTjuVC65KXO5U4P232+/0BGPb6QST6nnzfo0nRuI2fTqHv0csW8Jnt1Aj/RDGXPGVoU6aDHPQjrqAI+EhXPaDU4m8uWh9kj8kyryZGOpVVSz34vZyvFPnePCuJfTOrYXJ2Hnld1etWO9EFtTYlDciOS88KhOtvMhyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi0urSry; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a526d0b2349so465684266b.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713372202; x=1713977002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/Iet9vw4YRQbMJVvkHPoVsLlhmY94rpoQJA+SdfQnM=;
        b=Zi0urSryDf6DyYd9pCwdOI+VZE9B8LkcUdaZDSyaBXlMiV9V1zcaLvG0Gg0ivM8M5Z
         8fjeDbziabC85qBClrzWbrh+7yHgIkf4pS8yGsa0wWQmWqGGzSiX4Hm9AzIph0zthCd3
         /kLa/1H39sMoc6cRlq8iOA1nLaiXKbTfxdRXCvIzx/xmXBrZ5lmgwslPj/ViOa2wwSj2
         XX/L3DfebnqqgGcORM69ezRWUIK46uU+9BhxsThZtNKm6kr7uzUflhayGs9Nde/Bj1V4
         He6UVnmkLbPU8YrWT40xoraqMeGbnc+++NXnhBTizwPejYAcZMN4YPGerLJD7mGwZQCx
         JzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372202; x=1713977002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/Iet9vw4YRQbMJVvkHPoVsLlhmY94rpoQJA+SdfQnM=;
        b=jS9bzb9mx6JldRr+Zg03NO1k/pkqoHhJAb7ji0JPikL1E5doRutNXopqBCmlpFn9Ie
         +LM1kBTeS5QyJYpP0GgP/tkSJBk0TwMjL8ERsXTJBQLKe1YZRvZ8VPnCGE/gyCw5MxPC
         YaM5tSxt0Wq3X9oS5SJ3A4ZEPDJOjPXivXkaGWDfQtJS3NfheAGSdyX1+jbDUsqUJjba
         p+kW1k+9hD9sRnxpMwmpGQvZ3kKtwUnW6DPbRV+zNuA7q2ofVu0Jt6yglpRVMl9TQaIM
         TJgMkp3POhsb/Vyho40hCmEWUEOF3XTAC8BZZco5bWiXD65n+skGWpZgeV7MTKafdSbY
         Dnvw==
X-Forwarded-Encrypted: i=1; AJvYcCUi1iEOHHsSYrSLwyEG459vZzrHfvw16ZppcQQg8Ycs5F2vF06QYkvdGrk7MdTiIr42EKXUBmKXsnEzYzAPrqeuypvVsWwLzWi1dwHcQ/0=
X-Gm-Message-State: AOJu0YyN5NG1n4KkHHdRHmw9aNAkj2V0Andzuw0eVa6bfbpE1aokR2Q6
	JgqYBEGJV7ph89r/TdGhomss4i4qMuQwDkPg9/t7Ob+nbg0n/n+z
X-Google-Smtp-Source: AGHT+IEACBtqJTvVrgPx6/Q1vfGKcRSI9NOnasLhpuk4gABuDD8MRxRnAVzuUqH+rhlCqg86UJaBeA==
X-Received: by 2002:a17:906:5383:b0:a52:23b6:19c1 with SMTP id g3-20020a170906538300b00a5223b619c1mr22815ejo.76.1713372202169;
        Wed, 17 Apr 2024 09:43:22 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id e12-20020a170906844c00b00a4e393b6349sm8322896ejy.5.2024.04.17.09.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 09:43:09 -0700 (PDT)
Message-ID: <c7015899-da29-4357-9bab-6d1f68e43420@gmail.com>
Date: Wed, 17 Apr 2024 19:43:08 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
 <bc799ce8-f73d-475e-9858-5b2c9fee0fe3@gmail.com>
 <3bab3540ac644c879624ac200730fbee@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <3bab3540ac644c879624ac200730fbee@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2024 07:04, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>

[...]

>> +static void _rtl92de_read_adapter_info(struct ieee80211_hw *hw)
>> +{
>> +       struct rtl_priv *rtlpriv = rtl_priv(hw);
>> +       struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
>> +       struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
>> +       int params[] = {RTL8190_EEPROM_ID, EEPROM_VID, EEPROM_DID,
>> +                       EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR_MAC0_92D,
>> +                       EEPROM_CHANNEL_PLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
>> +                       COUNTRY_CODE_WORLD_WIDE_13};
>> +       int i;
>> +       u16 usvalue;
>> +       u8 *hwinfo;
>> +
>> +       hwinfo = kzalloc(HWSET_MAX_SIZE, GFP_KERNEL);
>> +       if (!hwinfo)
>> +               return;
>> +
>> +       if (rtl_get_hwinfo(hw, rtlpriv, HWSET_MAX_SIZE, hwinfo, params))
>> +               goto exit;
>> +
>> +       _rtl92de_efuse_update_chip_version(hw);
>> +       _rtl92de_read_macphymode_and_bandtype(hw, hwinfo);
>> +
>> +       /* Read Permanent MAC address for 2nd interface */
>> +       if (rtlhal->interfaceindex != 0) {
>> +               for (i = 0; i < 6; i += 2) {
>> +                       usvalue = *(u16 *)&hwinfo[EEPROM_MAC_ADDR_MAC1_92D + i];
>> +                       *((u16 *)(&rtlefuse->dev_addr[i])) = usvalue;
> 
> Copying u16 looks weird. I guess it would like to swap bytes (endian problem).
> At least it should be '__le16' or '__be16' because hwinfo[] is from efuse.
> 

It is weird. rtl_get_hwinfo() in efuse.c does the same thing.

I don't think this code is swapping the bytes. What reason can
it have to swap them anyway?

Maybe it's a (questionable) optimisation, only three copies
instead of six.

>> +               }
>> +       }
>> +       rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_ETHER_ADDR,
>> +                                     rtlefuse->dev_addr);
>> +       rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
>> +       _rtl92de_read_txpower_info(hw, rtlefuse->autoload_failflag, hwinfo);


