Return-Path: <linux-wireless+bounces-5936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750EC89B0AE
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Apr 2024 14:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2571C203B6
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Apr 2024 12:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2C920DCB;
	Sun,  7 Apr 2024 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB9j5KEg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2C1DFCB
	for <linux-wireless@vger.kernel.org>; Sun,  7 Apr 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712491422; cv=none; b=uuYa0TQUHYeVEd4miLb113gcYhKvYOSWLrlSiPbodd3k1GtJmTDqpZcWhxmGQFf2iXZPFFe+pGUKYaPChjD7a1PN8zQw32DkJ2FNaExcsT7raaYodTpSmJqo/8XWaotQ2GcfzENrLBoW+nwU4LpfR1fAX6Er2KKARpxpZRgC7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712491422; c=relaxed/simple;
	bh=Dvyt/DFUm/Ne+iRbKcDV99BJH8TIeZc3P225zGWCGaY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p4cR1RYzzZ3XF9l45SDfL1p2tNltw4/VrsHHMESDBNKylnyiTSW1R5XOq53xRMxAD3JevIk9+QOs+4q5cFJRFibLtkL6MZ4pDeNppSM5SijftySP2BK2A22UkMYhthaPQtOcOr0gcL4QtJrebjLdlTO7g0yHi9I3lmvcVeFeibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB9j5KEg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4162b5ba2bbso23278935e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 07 Apr 2024 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712491419; x=1713096219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0IB3UxPs50urWwM/qqU0ESX/IZ0GLc9HfubxnJYvCIY=;
        b=OB9j5KEgRv4nKugfdCpuSaRrmrZLCzwJbW8CkFU/g2PH1PyPDVv2mX4+Lwe0de4xmz
         AxO4DdPKgwzEKqcFep7NdMFSkfDSl1mVjKVe9Gj2Mp8esarg9z2IZhTTwyw0s/M0YaeA
         8VelhZCHgiD9bP4inv09egB1n3nmyeL/DWsGQmXmWaTEGZz8YKZ1m4vRtq3BDpdA5Mg2
         1BLudDd5lz5svSlVzbxJF7ec3+BYBxYfjHJlANSHoR0AWQM07la4XY80XH3+wRWupiCE
         xC58qJ2yPiIGXgcnHDdK/J0L1qzibMgwoHFKZxfuikSP46ViNuDL+etTtbN3lQdp46Jr
         G/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712491419; x=1713096219;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IB3UxPs50urWwM/qqU0ESX/IZ0GLc9HfubxnJYvCIY=;
        b=VPSOCrykkwEgy2iUIGXf1tcEIAsQ/qKiTJqz4JzaQMZB2aN9geQgue/NiI461DDskO
         CKxfyKAsa2bjCZn7tBFK75l/GNwk6T2aEyvcOEIEA6f8xGrsmmCkek2tN9WA3VmNla/l
         fJiskRE4MltbBEq9prqqmoQ3E5jtp7WCCP6IQAfRJtljW99tmCI4BAA2kfn/PchpgA8a
         qlf+EmGQnwDVH4yRUTBLm5KJBxLjIQxb/YggVltOVRgHIem8JZhyiU/zMniwCfhrw5YK
         hRafWBIKo2YcG/G7Unx7yABhheSSrbtHZwP2Z/2ALqDWdV+YPJoZ2/PXmfpgW3ZFsGHy
         PL0g==
X-Gm-Message-State: AOJu0YwaLfqAXS8XEWgu+CgYPeVP0Wv6pg4grJTH25PireWCLBs7n5B/
	RletMUziDRW3xrU2gEIGrJ6HpEpr/Ylzvin4hxq9L4T8kqPyysQI
X-Google-Smtp-Source: AGHT+IGO7Qbf+rpFrU/c/B02EzbzzYzcbETLxcmSejpwaPocO/GCVlB7oiPwROSIfi9WE9HSgfiplQ==
X-Received: by 2002:a05:600c:1c8b:b0:416:6a8c:b7cd with SMTP id k11-20020a05600c1c8b00b004166a8cb7cdmr280505wms.6.1712491419260;
        Sun, 07 Apr 2024 05:03:39 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.5])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c19cc00b0041469869d11sm13170796wmq.47.2024.04.07.05.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 05:03:38 -0700 (PDT)
Message-ID: <321c6855-2e58-48ae-b131-a3f6d7041713@gmail.com>
Date: Sun, 7 Apr 2024 15:03:37 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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
Content-Language: en-US
In-Reply-To: <7741a59a6ebf4e0f8c55b0f5c3f55a41@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/04/2024 04:21, Ping-Ke Shih wrote:
>>
>> I asked linux-usb and they said the two interfaces are probed
>> and disconnected one at a time, so it should be fine without
>> another mutex:
>>
>> https://lore.kernel.org/linux-usb/2024032907-smokeless-imperial-f3f9@gregkh/
> 
> Thanks for the clarification. Then, will you dynamically allocate mutex
> by first interface with ref_cnt=1, and second interface obtains mutex from
> first interface and increases ref_cnt=2?
> 
> When USB disconnection, decrease ref_cnt and if ref_cnt==0 free the mutex 
> no matter which one disconnect first. 
> 
> My thinking above is the same as yours?
> 

I did not consider using a ref_cnt variable. I made the first
probe allocate the things and the first disconnect frees them:


static struct usb_interface *rtl92du_get_other_intf(struct ieee80211_hw *hw)
{
	struct usb_interface *intf;
	struct usb_device *udev;
	u8 other_interfaceindex;

	/* See SET_IEEE80211_DEV(hw, &intf->dev); in usb.c */
	intf = container_of_const(wiphy_dev(hw->wiphy), struct usb_interface, dev);

	other_interfaceindex = 1 - intf->altsetting[0].desc.bInterfaceNumber;

	udev = interface_to_usbdev(intf);

	return usb_ifnum_to_if(udev, other_interfaceindex);
}

static int rtl92du_init_shared_data(struct ieee80211_hw *hw)
{
	struct usb_interface *other_intf = rtl92du_get_other_intf(hw);
	struct rtl_priv *rtlpriv = rtl_priv(hw);
	struct rtl_priv *other_rtlpriv = NULL;
	struct ieee80211_hw *other_hw = NULL;

	if (other_intf)
		other_hw = usb_get_intfdata(other_intf);

	if (other_hw) {
		/* The other interface was already probed. */
		other_rtlpriv = rtl_priv(other_hw);
		rtlpriv->curveindex_2g = other_rtlpriv->curveindex_2g;
		rtlpriv->curveindex_5g = other_rtlpriv->curveindex_5g;
		rtlpriv->mutex_for_power_on_off = other_rtlpriv->mutex_for_power_on_off;
		rtlpriv->mutex_for_hw_init = other_rtlpriv->mutex_for_hw_init;

		if (!rtlpriv->curveindex_2g || !rtlpriv->curveindex_5g ||
		    !rtlpriv->mutex_for_power_on_off || !rtlpriv->mutex_for_hw_init)
			return 1;

		return 0;
	}

	/* The other interface doesn't exist or was not probed yet. */
	rtlpriv->curveindex_2g =
		kzalloc(TARGET_CHNL_NUM_2G * sizeof(*rtlpriv->curveindex_2g),
			GFP_KERNEL);
	rtlpriv->curveindex_5g =
		kzalloc(TARGET_CHNL_NUM_5G * sizeof(*rtlpriv->curveindex_5g),
			GFP_KERNEL);
	rtlpriv->mutex_for_power_on_off =
		kzalloc(sizeof(*rtlpriv->mutex_for_power_on_off), GFP_KERNEL);
	rtlpriv->mutex_for_hw_init =
		kzalloc(sizeof(*rtlpriv->mutex_for_hw_init), GFP_KERNEL);

	if (!rtlpriv->curveindex_2g || !rtlpriv->curveindex_5g ||
	    !rtlpriv->mutex_for_power_on_off || !rtlpriv->mutex_for_hw_init) {
		kfree(rtlpriv->curveindex_2g);
		kfree(rtlpriv->curveindex_5g);
		kfree(rtlpriv->mutex_for_power_on_off);
		kfree(rtlpriv->mutex_for_hw_init);
		rtlpriv->curveindex_2g = NULL;
		rtlpriv->curveindex_5g = NULL;
		rtlpriv->mutex_for_power_on_off = NULL;
		rtlpriv->mutex_for_hw_init = NULL;
		return 1;
	}

	mutex_init(rtlpriv->mutex_for_power_on_off);
	mutex_init(rtlpriv->mutex_for_hw_init);

	return 0;
}

static void rtl92du_deinit_shared_data(struct ieee80211_hw *hw)
{
	struct usb_interface *other_intf = rtl92du_get_other_intf(hw);
	struct rtl_priv *rtlpriv = rtl_priv(hw);

	if (!other_intf || usb_get_intfdata(other_intf)) {
		/* The other interface doesn't exist or was not disconnected yet. */
		kfree(rtlpriv->curveindex_2g);
		kfree(rtlpriv->curveindex_5g);
		if (rtlpriv->mutex_for_power_on_off)
			mutex_destroy(rtlpriv->mutex_for_power_on_off);
		if (rtlpriv->mutex_for_hw_init)
			mutex_destroy(rtlpriv->mutex_for_hw_init);
		kfree(rtlpriv->mutex_for_power_on_off);
		kfree(rtlpriv->mutex_for_hw_init);
	}
}

static int rtl92du_init_sw_vars(struct ieee80211_hw *hw)
{
	const char *fw_name = "rtlwifi/rtl8192dufw.bin";
	struct rtl_priv *rtlpriv = rtl_priv(hw);
	int err;

	if (rtl92du_init_shared_data(hw))
		return 1;

	[...]

	return 0;
}

static void rtl92du_deinit_sw_vars(struct ieee80211_hw *hw)
{
	struct rtl_priv *rtlpriv = rtl_priv(hw);

	kfree(rtlpriv->rtlhal.pfirmware);
	rtlpriv->rtlhal.pfirmware = NULL;

	rtl92du_deinit_shared_data(hw);
}

