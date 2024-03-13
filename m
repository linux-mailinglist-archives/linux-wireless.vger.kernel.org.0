Return-Path: <linux-wireless+bounces-4711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C287B48C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 23:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC3BB21425
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 22:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541595A10A;
	Wed, 13 Mar 2024 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ3bCiKN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DC35F55C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370052; cv=none; b=C/bXv5cPCrm7yNAy8ON4VtT7Ja/6rgaTd1TKY3My8/GzT4BSUTwvGAjVlrIcGPsPe+3hWQNC6gYAaf1GsLSg4fqSvgDQwuSbQDlC5ywKctkuQonu6BuWthMpzAEUiBg1PPHc+C/UbBCqcZ5ANYMFaj8wvbVMWJ1mpD3wwnKf0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370052; c=relaxed/simple;
	bh=VfTSM43w+WUg9vXqXFLekxfMcp6LPAnPotTTMYsrpa0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bhpip5CeSMlFILtujhckYLp+GYMzzvtgQEGJ4uzDnbGWeLGb2xg1j9B1d299JwaEz4435u5cnV2ZRayLhGEztWel5XDpmaN45tpyyJjqaRV8foLEBl3il6H709bIo9lyqK1Xz2Bb+DdXC0czFDIZfd8U7+BvI1IIPJVKm0ESIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ3bCiKN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e82c720f8so370044f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 15:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710370048; x=1710974848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KJ2w5FSfVhsOvGaIKx5jdqh3C417ekXUz7f8HvFq7hA=;
        b=DJ3bCiKNcvovq50DmCSaweSpMjpH8BaBNDba8HfYo2BGRnAoSxT7n+RMLY6JMtiyQZ
         FurbzqhfLBkO+fAO6EgZzVBKwRUGZX2I7Gn2rThRO23AYDMQLPruST7Z/UNlFaxpS9Pc
         eHp+dOgxtNPWZwwD7ZzdLs2e9Cdd8madHyrhF3mCMWb9GPwYLi94AJrt61e9De9hFES0
         TEEx1WzeNkjsNVN9+36F0O2++tk5RK2g0CILM/CO/aNG9g9G+hQ/2aPg71shm4UWRa20
         NTnQkBfUwuZ+/ErfmIWPnC62S+xT7Rf8Y7n00H/Lr+JnJlmyfj7vtYaAEvCJGiHwcUOA
         tD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710370048; x=1710974848;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ2w5FSfVhsOvGaIKx5jdqh3C417ekXUz7f8HvFq7hA=;
        b=SbHNH1G50PBJ8yQdNE725HQ6EPdByuakKXN+AoiEs1nntsEaLBbi7GT/bfwSvZoaDy
         AKxfCZJxAjt82KXL85+ZrKSHmNz629NtO99/Fk8rDB5tf7+ldIGgIwK07F8D5ShbaCRj
         OaYDB08BMpyw6m821ij9mCpL20PfZRo8UdvLTwsw/YEC8bz5jtDG1xad1tpOj61/vvP+
         YW28WkztIPHEfJSfIzbEh0TViz2dyaoOEeIVAVEQBc4dar/xOmQ3T78Y25jYuo/rNXca
         ZRUGBwks3naj6JXBomlSeesrA+DI3oCj1bVanfp9sSH+A+R4i89b+dRbDP9nfOFufMGR
         F1og==
X-Forwarded-Encrypted: i=1; AJvYcCXqjobPFHBhmPeaFNSpyS8/aOjFJBL4eIUJDmsS/vhkb9DUiSrHc0pz+eta4N6VuWdng+FulrXWEsFkbQ+nqJ2lmjSZNJ8zrWt6DdoSLqs=
X-Gm-Message-State: AOJu0YxICyx3hkRDaphi6wG6ZCprJSSvkAwJBqKlGrAZZaQYklPynvKK
	WnwTaQrrXdGayy4YnHyxWWnJg6v94Bxd5pNrg+QDrHMYBmcwSxvk
X-Google-Smtp-Source: AGHT+IHBYSeaCeS6HMDBrEZJbEKJQb9Dqe3slYhkGKznfCP36wY5gnv3OxWdJ2PM+xC0Xp2Q1WDidw==
X-Received: by 2002:a05:6000:4021:b0:33e:3bf3:a097 with SMTP id cp33-20020a056000402100b0033e3bf3a097mr9333wrb.26.1710370047696;
        Wed, 13 Mar 2024 15:47:27 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056000060500b0033e49aebafasm176437wrb.3.2024.03.13.15.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:47:27 -0700 (PDT)
Message-ID: <a674d357-c917-413a-a4fb-1ee22f43d9ff@gmail.com>
Date: Thu, 14 Mar 2024 00:47:25 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 2/3] wifi: rtlwifi: Adjust rtl8192d-common for USB
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
 <d70dc39c-a3e5-43f6-9cb4-612d08035c57@gmail.com>
 <fdd95844c3a127356bab4250dfc46b16041829ee.camel@realtek.com>
Content-Language: en-US
In-Reply-To: <fdd95844c3a127356bab4250dfc46b16041829ee.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 05:46, Ping-Ke Shih wrote:
> On Wed, 2024-03-13 at 00:20 +0200, Bitterblue Smith wrote:
>>
>> A few of the shared functions need small changes for the USB driver.
>>
>> Also, add a few macros to wifi.h and initialise rtlhal.interfaceindex
>> for USB devices.
> 
> 
> Please run checkpatch.pl that reports
>   "total: 0 errors, 11 warnings, 27 checks, 8045 lines checked"
> I think these are newly introduced by this patch. 
> 
> 
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  .../wireless/realtek/rtlwifi/rtl8192d/def.h   |   2 +
>>  .../realtek/rtlwifi/rtl8192d/fw_common.c      |  19 +++
>>  .../realtek/rtlwifi/rtl8192d/hw_common.c      |  46 ++++--
>>  .../realtek/rtlwifi/rtl8192d/phy_common.c     |  26 ++-
>>  .../realtek/rtlwifi/rtl8192d/phy_common.h     |   6 +
>>  .../wireless/realtek/rtlwifi/rtl8192d/reg.h   | 156 +++++++++++++++---
>>  drivers/net/wireless/realtek/rtlwifi/usb.c    |   3 +
>>  drivers/net/wireless/realtek/rtlwifi/wifi.h   |   5 +
>>  8 files changed, 222 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/def.h
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/def.h
>> index 21726d9b4aef..ee45f51fcf71 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/def.h
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/def.h
>> @@ -116,6 +116,8 @@ enum version_8192d {
>>  #define IS_92D_E_CUT(version)          ((IS_92D(version)) ?            \
>>                                  ((GET_CVID_CUT_VERSION(version) ==     \
>>                                  CHIP_92D_E_CUT) ? true : false) : false)
>> +#define IS_NORMAL_CHIP(version)        \
>> +       ((version & NORMAL_CHIP) ? true : false)
> 
> #define IS_NORMAL_CHIP(version) !!(version & NORMAL_CHIP)
> 
>>
>>  enum rf_optype {
>>         RF_OP_BY_SW_3WIRE = 0,
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
>> index e333275c51c3..ac48bd9dcc9f 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
>> @@ -94,9 +94,22 @@ EXPORT_SYMBOL_GPL(rtl92d_fw_free_to_go);
>>  void rtl92d_firmware_selfreset(struct ieee80211_hw *hw)
>>  {
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>> +       struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
>>         u8 u1b_tmp;
>>         u8 delay = 100;
>>
>> +       if (rtlhal->interface == INTF_USB) {
>> +               delay *= 60;
> 
> Out of curiosity, how did you decide this factor 60?
> 

Just because the out-of-tree driver uses a delay of 300 ms:
https://github.com/lwfinger/rtl8192du/blob/2c5450dd3783e1085f09a8c7a632318c7d0f1d39/hal/rtl8192d_hal_init.c#L329-L346

rtl8192de uses 100 * 0.05 ms. Multiplying by 60 gives 300 ms.

> Let's define a name such as RTL_USB_DELAY_FACTOR to be clear. 
> 
>> +
>> +               rtl_write_byte(rtlpriv, REG_FSIMR, 0);
>> +
>> +               /* We need to disable other HRCV INT to influence 8051 reset. */
>> +               rtl_write_byte(rtlpriv, REG_FWIMR, 0x20);
>> +
>> +               /* Close mask to prevent incorrect FW write operation. */
>> +               rtl_write_byte(rtlpriv, REG_FTIMR, 0);
>> +       }
>> +
>>         /* Set (REG_HMETFR + 3) to  0x20 is reset 8051 */
>>         rtl_write_byte(rtlpriv, REG_HMETFR + 3, 0x20);
>>         u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
>> @@ -107,6 +120,12 @@ void rtl92d_firmware_selfreset(struct ieee80211_hw *hw)
>>                 udelay(50);
>>                 u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
>>         }
>> +
>> +       if (rtlhal->interface == INTF_USB) {
>> +               if ((u1b_tmp & BIT(2)) && delay == 0)
> 
> #define BIT_FEN_CPUEN BIT(10)
> 
> Because BIT(2) of REG_SYS_FUNC_EN + 1 is BIT(10)
> 
> 
>> +                       rtl_write_byte(rtlpriv, REG_FWIMR, 0);
>> +       }
>> +
>>         WARN_ONCE((delay <= 0), "rtl8192de: 8051 reset failed!\n");
>>         rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
>>                 "=====> 8051 reset success (%d)\n", delay);
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
>> index ada08f82adff..b9bc2fdde5e2 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
>> @@ -622,9 +622,14 @@ static void _rtl92de_read_macphymode_from_prom(struct ieee80211_hw *hw,
>>  {
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>>         struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
>> -       u8 macphy_crvalue = content[EEPROM_MAC_FUNCTION];
>> +       bool is_single_mac = true;
>>
>> -       if (macphy_crvalue & BIT(3)) {
>> +       if (rtlhal->interface == INTF_PCI)
>> +               is_single_mac = !!(content[EEPROM_MAC_FUNCTION] & BIT(3));
>> +       else if (rtlhal->interface == INTF_USB)
>> +               is_single_mac = !(content[EEPROM_ENDPOINT_SETTING] & BIT(0));
>> +
>> +       if (is_single_mac) {
>>                 rtlhal->macphymode = SINGLEMAC_SINGLEPHY;
>>                 rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
>>                         "MacPhyMode SINGLEMAC_SINGLEPHY\n");
>> @@ -663,6 +668,7 @@ static void _rtl92de_efuse_update_chip_version(struct ieee80211_hw *hw)
>>                 rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "D-CUT!!!\n");
>>                 break;
>>         case 0xCC33:
>> +       case 0x33CC:
>>                 chipver |= CHIP_92D_E_CUT;
>>                 rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "E-CUT!!!\n");
>>                 break;
>> @@ -679,14 +685,22 @@ static void _rtl92de_read_adapter_info(struct ieee80211_hw *hw)
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>>         struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
>>         struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
>> -       int params[] = {RTL8190_EEPROM_ID, EEPROM_VID, EEPROM_DID,
>> -                       EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR_MAC0_92D,
>> -                       EEPROM_CHANNEL_PLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
>> -                       COUNTRY_CODE_WORLD_WIDE_13};
>> +       int params_pci[] = {RTL8190_EEPROM_ID, EEPROM_VID, EEPROM_DID,
>> +                           EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR_MAC0_92D,
>> +                           EEPROM_CHANNEL_PLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
>> +                           COUNTRY_CODE_WORLD_WIDE_13};
>> +       int params_usb[] = {RTL8190_EEPROM_ID, EEPROM_VID_USB, EEPROM_PID_USB,
>> +                           EEPROM_VID_USB, EEPROM_PID_USB, EEPROM_MAC_ADDR_MAC0_92DU,
>> +                           EEPROM_CHANNEL_PLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
>> +                           COUNTRY_CODE_WORLD_WIDE_13};
> 
> static const int params_xxx[], and the const should propagate into rtl_get_hwinfo().
> 
>> +       int *params = params_pci;
>>         int i;
>>         u16 usvalue;
>>         u8 *hwinfo;
>>
>> +       if (rtlhal->interface == INTF_USB)
>> +               params = params_usb;
>> +
>>         hwinfo = kzalloc(HWSET_MAX_SIZE, GFP_KERNEL);
>>         if (!hwinfo)
>>                 return;
>> @@ -858,7 +872,7 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
>>                                                         1 : 0;
>>         enum wireless_mode wirelessmode = 0;
>>         bool shortgi = false;
>> -       u32 value[2];
>> +       u8 rate_mask[5];
>>         u8 macid = 0;
>>         u8 mimo_ps = IEEE80211_SMPS_OFF;
>>
>> @@ -966,12 +980,17 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
>>                 break;
>>         }
>>
>> -       value[0] = (ratr_bitmap & 0x0fffffff) | (ratr_index << 28);
>> -       value[1] = macid | (shortgi ? 0x20 : 0x00) | 0x80;
>> +       *(u32 *)&rate_mask = (ratr_bitmap & 0x0fffffff) |
>> +                                    (ratr_index << 28);
> 
> 'u32' is weird to me. Shouldn't it be __le32?
> But I prefer a struct of rate_mask. 
> 

I don't like this either, but it was easy to copy from rtl8192cu.

Something like this?

#define RAID_MASK		GENMASK(31, 28)
#define RATE_MASK_MASK		GENMASK(27, 0)
#define SHORT_GI_MASK		BIT(5)
#define MACID_MASK		GENMASK(4, 0)
	
struct rtl92d_rate_mask {
	__le32 rate_mask_and_raid;
	u8 macid_and_short_gi;
} __packed;

>> +       rate_mask[4] = macid | (shortgi ? 0x20 : 0x00) | 0x80;
>>         rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
>> -               "ratr_bitmap :%x value0:%x value1:%x\n",
>> -               ratr_bitmap, value[0], value[1]);
>> -       rtl92d_fill_h2c_cmd(hw, H2C_RA_MASK, 5, (u8 *) value);
>> +       "Rate_index:%x, ratr_val:%x, %5phC\n",
>> +               ratr_index, ratr_bitmap, rate_mask);
>> +       memcpy(rtlpriv->rate_mask, rate_mask, 5);
> 
> 5 ==> sizeof(rtlpriv->rate_mask)
> 
>> +       /* rtl92d_fill_h2c_cmd() does USB I/O and will result in a
>> +        * "scheduled while atomic" if called directly
>> +        */
>> +       schedule_work(&rtlpriv->works.fill_h2c_cmd);
>>         if (macid != 0)
>>                 sta_entry->ratr_index = ratr_index;
>>  }
>> @@ -1015,7 +1034,8 @@ bool rtl92de_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
>>         bool actuallyset = false;
>>         unsigned long flag;
>>
>> -       if (rtlpci->being_init_adapter)
>> +       if (rtlpriv->rtlhal.interface == INTF_PCI &&
>> +           rtlpci->being_init_adapter)
>>                 return false;
>>         if (ppsc->swrf_processing)
>>                 return false;
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
>> index 487628ac491b..1e39940a3ba7 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
>> @@ -81,11 +81,13 @@ u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
>>         rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
>>                 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
>>                 regaddr, rfpath, bitmask);
>> -       spin_lock(&rtlpriv->locks.rf_lock);
>> +       if (rtlpriv->rtlhal.interface == INTF_PCI)
>> +               spin_lock(&rtlpriv->locks.rf_lock);
> 
> Does it mean USB never read/write RF registers simultaneously? How can you
> ensure that? 
> 

I don't know. It seems to work fine. The out-of-tree driver
doesn't have locks here:
https://github.com/lwfinger/rtl8192du/blob/2c5450dd3783e1085f09a8c7a632318c7d0f1d39/hal/rtl8192d_phycfg.c#L637

rtl8xxxu and rtl8192cu don't have locks either.

>>         original_value = _rtl92d_phy_rf_serial_read(hw, rfpath, regaddr);
>>         bitshift = calculate_bit_shift(bitmask);
>>         readback_value = (original_value & bitmask) >> bitshift;
>> -       spin_unlock(&rtlpriv->locks.rf_lock);
>> +       if (rtlpriv->rtlhal.interface == INTF_PCI)
>> +               spin_unlock(&rtlpriv->locks.rf_lock);
>>         rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
>>                 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
>>                 regaddr, rfpath, bitmask, original_value);
>> @@ -105,7 +107,8 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
>>                 regaddr, bitmask, data, rfpath);
>>         if (bitmask == 0)
>>                 return;
>> -       spin_lock(&rtlpriv->locks.rf_lock);
>> +       if (rtlpriv->rtlhal.interface == INTF_PCI)
>> +               spin_lock(&rtlpriv->locks.rf_lock);
>>         if (rtlphy->rf_mode != RF_OP_BY_FW) {
>>                 if (bitmask != RFREG_OFFSET_MASK) {
>>                         original_value = _rtl92d_phy_rf_serial_read(hw,
>> @@ -116,7 +119,8 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
>>                 }
>>                 _rtl92d_phy_rf_serial_write(hw, rfpath, regaddr, data);
>>         }
>> -       spin_unlock(&rtlpriv->locks.rf_lock);
>> +       if (rtlpriv->rtlhal.interface == INTF_PCI)
>> +               spin_unlock(&rtlpriv->locks.rf_lock);
>>         rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
>>                 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
>>                 regaddr, bitmask, data, rfpath);
>> @@ -642,6 +646,8 @@ static void rtl92d_phy_set_io(struct ieee80211_hw *hw)
>>         case IO_CMD_PAUSE_DM_BY_SCAN:
>>                 rtlphy->initgain_backup.xaagccore1 = de_digtable->cur_igvalue;
>>                 de_digtable->cur_igvalue = 0x37;
>> +               if (rtlpriv->rtlhal.interface == INTF_USB)
>> +                       de_digtable->cur_igvalue = 0x17;
>>                 rtl92d_dm_write_dig(hw);
>>                 break;
>>         default:
>> @@ -698,22 +704,28 @@ void rtl92d_phy_config_macphymode(struct ieee80211_hw *hw)
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>>         struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
>>         u8 offset = REG_MAC_PHY_CTRL_NORMAL;
>> +       u8 temp = 0xf0;
> 
> 'tmp' instead. Or 'phy_ctrl', or 'ctrl' would be clear. 
> 
>> +
>> +       if (rtlhal->interface == INTF_USB) {
>> +               temp = rtl_read_byte(rtlpriv, offset);
>> +               temp &= ~(BIT(0) | BIT(1) | BIT(2));
>> +       }
>>
>>         switch (rtlhal->macphymode) {
>>         case DUALMAC_DUALPHY:
>>                 rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
>>                         "MacPhyMode: DUALMAC_DUALPHY\n");
>> -               rtl_write_byte(rtlpriv, offset, 0xF3);
>> +               rtl_write_byte(rtlpriv, offset, temp | BIT(0) | BIT(1));
>>                 break;
>>         case SINGLEMAC_SINGLEPHY:
>>                 rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
>>                         "MacPhyMode: SINGLEMAC_SINGLEPHY\n");
>> -               rtl_write_byte(rtlpriv, offset, 0xF4);
>> +               rtl_write_byte(rtlpriv, offset, temp | BIT(2));
>>                 break;
>>         case DUALMAC_SINGLEPHY:
>>                 rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
>>                         "MacPhyMode: DUALMAC_SINGLEPHY\n");
>> -               rtl_write_byte(rtlpriv, offset, 0xF1);
>> +               rtl_write_byte(rtlpriv, offset, temp | BIT(0));
>>                 break;
>>         }
>>  }
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
>> index 071776d05eb9..5649a11f4405 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
>> @@ -41,6 +41,9 @@ static inline void rtl92d_acquire_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
>>  {
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>>
>> +       if (rtlpriv->rtlhal.interface == INTF_USB)
>> +               return;
>> +
>>         if (rtlpriv->rtlhal.interfaceindex == 1)
>>                 spin_lock_irqsave(&rtlpriv->locks.cck_and_rw_pagea_lock, *flag);
>>  }
>> @@ -50,6 +53,9 @@ static inline void rtl92d_release_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
>>  {
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>>
>> +       if (rtlpriv->rtlhal.interface == INTF_USB)
>> +               return;
>> +
> 
> Why USB doesn't need the lock? I guess USB could be "scheduled while atomic",
> but this lock is to ensure read/write as expected.
> 

I don't know. The calls to AcquireCCKAndRWPageAControl and
ReleaseCCKAndRWPageAControl are commented out and their
implementations are missing from the out-of-tree driver:
https://github.com/lwfinger/rtl8192du/blob/2c5450dd3783e1085f09a8c7a632318c7d0f1d39/hal/rtl8192d_phycfg.c#L2622-L2624

> If you have explanation, please add them to commit message. 
> 
> 
>>         if (rtlpriv->rtlhal.interfaceindex == 1)
>>                 spin_unlock_irqrestore(&rtlpriv->locks.cck_and_rw_pagea_lock,
>>                         *flag);
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h
>> index 2783d7e7b227..1f2daf779539 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h
>>
> 
> [...]
> 
>> +
>> +#define _TXDMA_HIQ_MAP(x)                      (((x) & 0x3) << 14)
> 
> GENMASK(15, 14) ?
> 
>> +#define _TXDMA_MGQ_MAP(x)                      (((x) & 0x3) << 12)
>> +#define _TXDMA_BKQ_MAP(x)                      (((x) & 0x3) << 10)
>> +#define _TXDMA_BEQ_MAP(x)                      (((x) & 0x3) <<  8)
>> +#define _TXDMA_VIQ_MAP(x)                      (((x) & 0x3) <<  6)
>> +#define _TXDMA_VOQ_MAP(x)                      (((x) & 0x3) <<  4)
>> +
>> +#define QUEUE_LOW                              1
>> +#define QUEUE_NORMAL                           2
>> +#define QUEUE_HIGH                             3
>> +
>> +#define _HPQ(x)                                        ((x) & 0xFF)
> 
> 
> #define HPQ_MASK GENMASK(7, 0)
> u32_get_bits(x, HPQ_MASK) ?
> 
> 
> 
>> +#define _LPQ(x)                                        (((x) & 0xFF) << 8)
>> +#define _PUBQ(x)                               (((x) & 0xFF) << 16)
>> +#define _NPQ(x)                                        ((x) & 0xFF)
>> +#define LD_RQPN                                        BIT(31)
>> +
>>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c
>> b/drivers/net/wireless/realtek/rtlwifi/usb.c
>> index 6e8c87a2fae4..2ea72d9e3957 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
>> @@ -979,6 +979,9 @@ int rtl_usb_probe(struct usb_interface *intf,
>>         usb_priv->dev.intf = intf;
>>         usb_priv->dev.udev = udev;
>>         usb_set_intfdata(intf, hw);
>> +       /* For dual MAC RTL8192DU, which has two interfaces. */
>> +       rtlpriv->rtlhal.interfaceindex =
>> +               intf->altsetting[0].desc.bInterfaceNumber;
> 
> So, you will see two USB adapters when you plug 8192DU?
> 

When you plug the dual MAC version, lsusb will show one device,
with two interfaces. rtl_usb_probe() is called twice. This is
copied from linux-hardware.org:

Bus 003 Device 004: ID 0bda:8193 Realtek Semiconductor Corp. RTL8192DU 802.11an WLAN Adapter
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0bda Realtek Semiconductor Corp.
  idProduct          0x8193 RTL8192DU 802.11an WLAN Adapter
  bcdDevice            0.00
  iManufacturer           1 Realtek
  iProduct                2 801.11n NIC
  iSerial                 3 ...
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0037
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x89  EP 9 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x0a  EP 10 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0 
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)


Mine is the single MAC version:

Bus 001 Device 007: ID 0bda:8194 Realtek Semiconductor Corp. 802.11n NIC
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 [unknown]
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0bda Realtek Semiconductor Corp.
  idProduct          0x8194 802.11n NIC
  bcdDevice            0.00
  iManufacturer           1 Realtek
  iProduct                2 802.11n NIC
  iSerial                 3 00e04c000001
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x002e
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           4
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               3


> 
>>         /* init cfg & intf_ops */
>>         rtlpriv->rtlhal.interface = INTF_USB;
>>         rtlpriv->cfg = rtl_hal_cfg;
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h
>> b/drivers/net/wireless/realtek/rtlwifi/wifi.h
>> index 9fabf597cfd6..c45463744f16 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
>> +++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
>> @@ -20,6 +20,7 @@
>>  #define        MASKBYTE1                               0xff00
>>  #define        MASKBYTE2                               0xff0000
>>  #define        MASKBYTE3                               0xff000000
>> +#define        MASKH3BYTES                             0xffffff00
>>  #define        MASKHWORD                               0xffff0000
>>  #define        MASKLWORD                               0x0000ffff
>>  #define        MASKDWORD                               0xffffffff
>> @@ -48,6 +49,10 @@
>>  #define        MASK20BITS                              0xfffff
>>  #define RFREG_OFFSET_MASK                      0xfffff
>>
>> +/* For dual MAC RTL8192DU */
>> +#define        MAC0_ACCESS_PHY1                        0x4000
>> +#define        MAC1_ACCESS_PHY0                        0x2000
>> +
>>  #define RF_CHANGE_BY_INIT                      0
>>  #define RF_CHANGE_BY_IPS                       BIT(28)
>>  #define RF_CHANGE_BY_PS                                BIT(29)
>> --
>> 2.43.2

