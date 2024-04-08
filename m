Return-Path: <linux-wireless+bounces-5970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5289BB14
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 11:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A207B20C2C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 09:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37BC3A1D3;
	Mon,  8 Apr 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX0zuTjn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B93A1B6
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566891; cv=none; b=OqKE1YNnRYF4CKNB5qyRdRHiBYBqkmek5iiRDlv/Q09gBkOeOeGWdbdYS4pnLVcdSSqF51HyHNTev/s1rYcDxpQKdYEcHK8E8lac31AYjlBy4ePVvE40U15PbCT9PsVAl/etaNjAAGwW1zS5EvAOZkh+jJTgZXnqvypXzMWFVKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566891; c=relaxed/simple;
	bh=lMM7lXU18SSdCllbPlmhKuC/zyOM3EncpM8CE02k78M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USLLMWhdDX8t55FAQSgqH/LR9L7zzki5QnsacbRHVPf0Sp9EVEowQL1h9gsTC2qGqVn8QSpAPEvu51YF+WrxyjOSyhR7DLHuH66MPh46TDB5VzgxGw9Y4uMSD20lduayNTaLkru6RM9WlNBqb1C64mmxlBOSuIDHfgmNXYjwm5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX0zuTjn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-345e1c645c4so184890f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Apr 2024 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712566888; x=1713171688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBla0YTZhen5WbXxI3wT/JyTJNM41P97D7kc8E5jobM=;
        b=AX0zuTjnHMKLc0F+2KiMmE9nINp9t8diidTcQQe5buAJe2vHOUNu0YZuORY66VT6lj
         h4dWa3PMjHbpaSQo3t8jCni1P5DA8UAL3SjsWXg3gBpQlHLnytY4cjeCIZUS8qssskSE
         ReeN/1z7E0LPUmnhrAJM+tHaRSI1v9mAVNwrjbboNNi16MMa41S1UQ1+/bs78XtD5HLw
         WmkOXhJuMLmIXmBu/ZOAfClfnPOK8X0d8nSfSZ4Y+rwyrpdNLbepX0UyHUqI3kZACbMH
         4jdyxSsH8MiyLkMyOMjjG+J9rBmYNdjT+Ll3c6e0XF1QmG4yAhPnOtOG8RFGmvKw6y/4
         IWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712566888; x=1713171688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBla0YTZhen5WbXxI3wT/JyTJNM41P97D7kc8E5jobM=;
        b=kYWKF01CoTPSyYPbHpN60HbsOMjjVrApBQpX8pO9NasJq+FP02vzjf3jSZm0ByH9qv
         GWF9hODU4KHhNIpnCu8NUWmcyb8J9zpYO8EnxKd2EPkw6cKKe0l7bFpdI4I6SuuwzjcL
         Ulv/SuDKSYOLhwLK4ns9QXKz911IK3N9b6oIqp5KYgBQBg7GITqz7lad7++xul4E6YtR
         0Xpf0gRfiXcAxhLLA2hXEtZ4o8DLktbW+E5mosw3xqZmLr+qhjxexGGPizjx314NV/mT
         tO9rMMcJvfIChiBr2TMVQWgAPOYheP68dDtXF6Jo3tiS4alQOMBQYqNbmWfaZJfNR82J
         /zaQ==
X-Gm-Message-State: AOJu0YwIMqiQk4xDJs/s2cl6//1DD+Gz3KjkQe/qtMAEDPVQbgL7/nDb
	tVekkxBjPsGgmf1RoxmwBHUuNuVLzNeRWLjEjbue6Z/5OQ6hsbzP
X-Google-Smtp-Source: AGHT+IHi0fWKL1qBVYjNY2OTtV+Ih9z4yrK7XgW5DOiqbRf4CKe3j6tZSVuaCtLiJSInpxmNu8HfXg==
X-Received: by 2002:a5d:4d85:0:b0:343:9308:3af8 with SMTP id b5-20020a5d4d85000000b0034393083af8mr4861244wru.23.1712566887944;
        Mon, 08 Apr 2024 02:01:27 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.5])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d6710000000b00343956e8852sm8452312wru.42.2024.04.08.02.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 02:01:27 -0700 (PDT)
Message-ID: <519e6717-3a58-4814-932d-8b246fd39f37@gmail.com>
Date: Mon, 8 Apr 2024 12:01:26 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>, "kvalo@kernel.org" <kvalo@kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <2eb79c8c-cf2c-4696-b958-e8d961628e17@gmail.com>
 <f86a40493745a53ff73083f87b3e8fae215eac77.camel@realtek.com>
 <66565618-3638-47e5-afe5-3530214da0c9@gmail.com> <87ttkrzf1m.fsf@kernel.org>
 <5696990a-4450-4d92-bbda-1d9ca3a9a619@gmail.com>
 <4672072ef782ae1200886a190c740e0f3ccec2c8.camel@realtek.com>
 <7873dee1-46a8-48a7-9059-bc300ac98c23@gmail.com>
 <1f8ebed6a04a4fbebf33b0a3edc2f50b@realtek.com>
 <ff3b97d0-118c-42b3-be0b-47cfcf06ab74@gmail.com>
 <7741a59a6ebf4e0f8c55b0f5c3f55a41@realtek.com>
 <321c6855-2e58-48ae-b131-a3f6d7041713@gmail.com>
 <21299940bf9342ae9c82916084ea7d9e@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <21299940bf9342ae9c82916084ea7d9e@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 05:45, Ping-Ke Shih wrote:
> 
>> I did not consider using a ref_cnt variable. I made the first
>> probe allocate the things and the first disconnect frees them:
> 
> The allocation seems fine, but I feel we should free shared data by second
> disconnect because the other intf can still use them, no?
> 

Maybe. Sure, the second disconnect can free them.

>>
>>
>> static struct usb_interface *rtl92du_get_other_intf(struct ieee80211_hw *hw)
>> {
>>         struct usb_interface *intf;
>>         struct usb_device *udev;
>>         u8 other_interfaceindex;
>>
>>         /* See SET_IEEE80211_DEV(hw, &intf->dev); in usb.c */
>>         intf = container_of_const(wiphy_dev(hw->wiphy), struct usb_interface, dev);
>>
>>         other_interfaceindex = 1 - intf->altsetting[0].desc.bInterfaceNumber;
> 
> The value of bInterfaceNumber for two instances are 0 and 1, right? Then
> '1 - x' to get each other -- that looks a little tricky ;-) 
> 

The vendor driver assumes bInterfaceNumber can only be 0 or 1.
I can make it more explicit:

	if (intf->altsetting[0].desc.bInterfaceNumber == 0)
		other_interfaceindex = 1;
	else
		other_interfaceindex = 0;

>>
>>         udev = interface_to_usbdev(intf);
>>
>>         return usb_ifnum_to_if(udev, other_interfaceindex);
>> }
>>
> 
> [...]
> 
>>
>> static void rtl92du_deinit_shared_data(struct ieee80211_hw *hw)
>> {
>>         struct usb_interface *other_intf = rtl92du_get_other_intf(hw);
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>>
>>         if (!other_intf || usb_get_intfdata(other_intf)) {
>>                 /* The other interface doesn't exist or was not disconnected yet. */
> 
> For the USB adaptor with single one interface, you don't have other_intf.
> Then, just free them.
> 
> If the USB adaptor has two interfaces, it has both other_intf and
> usb_get_intfdata(other_intf), so you want to free them. But, I wonder if both 
> interfaces can enter this branch?
> 

They can't both enter this branch because after the first
disconnect usb_get_intfdata() will return NULL.

> Also as I mentioned above, how can you ensure other_intf isn't still using the
> shared data?
> 

I can make the second disconnect free the shared data by
checking if usb_get_intfdata() returns NULL:

	if (!other_intf || !usb_get_intfdata(other_intf)) {
		/* The other interface doesn't exist or was already disconnected. */
		kfree(rtlpriv->curveindex_2g);

