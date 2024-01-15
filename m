Return-Path: <linux-wireless+bounces-1924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C4282D9D3
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 14:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E0E1F2265E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383DC1773B;
	Mon, 15 Jan 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="STlw+97/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZS10GzSt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1A17753
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <87e04cfe-f8ed-40da-bb2c-edccfe385b6e@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705324359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPGOnDj14iJPgX8XTAeYcQCVAZyjF5Baq4nHAVUrRQg=;
	b=STlw+97/PRCH3F5fRDNek3RRCfoSZPrtk3oKahYL9qhNMYzt8DiLGxMXRvj/Dc1+k4MRTY
	sdxy2KTXMUxoJbM5Bsu9gxrDHzxNIt3I7fpW5seqAA8GGswWZS5oTdllRHSis+WH6hVDbg
	8yE67aHWbpc4X/VI7BJvp6u+M5aVz9/hrmI/Q/pbedjQbDs0N+6t2HnOfORaZuaQIeGz4a
	Y7TQ4lUZEn6L5NGneYkQ43FM/qRzivQdunRZ1OHMsRjqz+ssQ3Ermd/BkpJ0KPXe+H8Br+
	Z0VxAH8E6qZbyWcwfh+nKZ/rLCGoxB5Pa5HJgqyHXoYYp6Z8g++DphgqU0Uy0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705324359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPGOnDj14iJPgX8XTAeYcQCVAZyjF5Baq4nHAVUrRQg=;
	b=ZS10GzSt7DQgepFR+E/WVxgNoKXyM0uq7CiqVimRZjDoqw+xwPtXW2M8l7g2yMpu4K/ksW
	Bx5hJIgesyNnJDDQ==
Date: Mon, 15 Jan 2024 14:12:39 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 19/21] wifi: rtl8xxxu: add hw crypto support for AP
 mode
Content-Language: de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Zenm Chen <zenmchen@gmail.com>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
 <20231221164353.603258-20-martin.kaistra@linutronix.de>
 <92fa5949e8094739883e665abb23ac01@realtek.com>
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <92fa5949e8094739883e665abb23ac01@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ping-Ke,

Am 12.01.24 um 07:52 schrieb Ping-Ke Shih:
> Hi Martin,
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Friday, December 22, 2023 12:44 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [PATCH v2 19/21] wifi: rtl8xxxu: add hw crypto support for AP mode
>>
> 
> [...]
> 
> Zenm reported [1] his RTL8192EU and RTL8192FU don't work in station mode,
> and cause is this patch. Please try if you can reproduce the symptom, and
> apply my suggestion to see if help.
> 
> [1] https://lore.kernel.org/linux-wireless/20240112045104.12282-1-zenmchen@gmail.com/T/#me0940f522249becf49f25bc281f1992c523673f6

I managed to find two other Realtek USB Wifi devices that are supported by the 
rtl8xxxu driver (RTL8188EU and RTL8192CU) and I can reproduce the issue with 
both of them.

I also tried creating a patch with your suggestions and this seems to help.

Looking at it more closely however, I think the main problem is, that 
fops->max_sec_cam_num is not set for the other variants. Without the additional 
patch, this causes rtl8xxxu_get_free_sec_cam() to return 0 for pairwise and 
group key and so using the same spot for both key entries.

I then created a patch using the numbers suggested by Bitterblue Smith in [1] 
and using 32 for RTL8723AU and RTL8192CU like the rtlwifi driver seems to do. 
This also seems to solve the issue reported, even without reserving the first 4 
slots for group keys.

Do you think we need both patches?

[1] 
https://lore.kernel.org/linux-wireless/f73b5afc-d69f-4a7c-8bf0-877a45327e0b@gmail.com/

> 
>>
>> +static int rtl8xxxu_get_free_sec_cam(struct ieee80211_hw *hw)
>> +{
>> +       struct rtl8xxxu_priv *priv = hw->priv;
> 
> We need to reserve entries 0~3 for keys that aren't pairwise key.
> 
>> +
>> +       return find_first_zero_bit(priv->cam_map, priv->fops->max_sec_cam_num);
>> +}
>> +
>>   static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>                              struct ieee80211_vif *vif,
>>                              struct ieee80211_sta *sta,
>>                              struct ieee80211_key_conf *key)
>>   {
>> +       struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
>>          struct rtl8xxxu_priv *priv = hw->priv;
>>          struct device *dev = &priv->udev->dev;
>>          u8 mac_addr[ETH_ALEN];
> 
> [...]
> 
>> @@ -6899,16 +6915,28 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>
>>          switch (cmd) {
>>          case SET_KEY:
>> -               key->hw_key_idx = key->keyidx;
>> +
>> +               retval = rtl8xxxu_get_free_sec_cam(hw);
>> +               if (retval < 0)
>> +                       return -EOPNOTSUPP;
>> +
> 
> if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
> 	key->hw_key_idx = retval;
> else
> 	key->hw_key_idx = key->keyidx;
> 
>> +               key->hw_key_idx = retval;
>> +
>> +               if (vif->type == NL80211_IFTYPE_AP && !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
>> +                       rtlvif->hw_key_idx = key->hw_key_idx;
>> +
>>                  key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
>>                  rtl8xxxu_cam_write(priv, key, mac_addr);
>> +               set_bit(key->hw_key_idx, priv->cam_map);
>>                  retval = 0;
>>                  break;
>>          case DISABLE_KEY:
>>                  rtl8xxxu_write32(priv, REG_CAM_WRITE, 0x00000000);
>>                  val32 = CAM_CMD_POLLING | CAM_CMD_WRITE |
>> -                       key->keyidx << CAM_CMD_KEY_SHIFT;
>> +                       key->hw_key_idx << CAM_CMD_KEY_SHIFT;
>>                  rtl8xxxu_write32(priv, REG_CAM_CMD, val32);
>> +               rtlvif->hw_key_idx = 0xff;
>> +               clear_bit(key->hw_key_idx, priv->cam_map);
> 
> Shouldn't swap these two statements? I missed that during reviewing.

I don't think that would make a difference. rtlvif->hw_key_idx is set for use in 
rtl8xxxu_tx() and the second line uses key->hw_key_idx to clear the map entry.

> 
> 
>>                  retval = 0;
>>                  break;
>>          default:
>> --
>> 2.39.2
> 



