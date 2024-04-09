Return-Path: <linux-wireless+bounces-6002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839FE89D7B5
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 13:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A1C1C2132B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 11:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C874A8562E;
	Tue,  9 Apr 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfgvMU8k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8484D02
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661411; cv=none; b=qjK+BFVpKPeEf3rmxwIP5JexRGsYp+cCK5HA4t1N+t1ehe+59NhfoB2tCLfjUiuihOXq4Uljy9nzKlOPwmz4DzGdV20J9+IFrf02ugRjpYEPF59RbFx6qzxngsJLoVrQ1BvMAcqIirV5Q11rCjoRGrh9jl2a4LObiySyp7rGhEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661411; c=relaxed/simple;
	bh=+FYLvlWXzlY2Y+I0vK0OvKTukjsQBR729bzy6aZFBSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7LDiJCcIbW3tuN8h/VjMKGI8iQPtRXBzy5wOiPSqolymq9kjkezRsjf7mhZ2U3DguYzFpNMK6gE4qg+yjS1blLQm0nb4zetNWc4AW2ZFkxs8u8uWOyuvrhe0Ho+FxKGiIntTwAzp+S3dbXlQn3I0AE2BbEtL9v4bx3duEKYYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfgvMU8k; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51fea60c0bso43583566b.3
        for <linux-wireless@vger.kernel.org>; Tue, 09 Apr 2024 04:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712661408; x=1713266208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbv2FFP6IjSxUeJ8VtfFtr82fldAXn1hyih+xqFuJPc=;
        b=NfgvMU8kiqOPw6qQucRERS4oXo36ium2UNKhWbEBe/Hk6EwoRWc+80Ov6vj99Qsz+N
         6XgcddnRBoySiPnz6EP0o6pt0cciJDKuwBNRYOKdAGkYDvc+A5l7MnqoR0Lc3aEbg73e
         ycqu3ZvUIR3yUqIu5xm9bhgVjPyX8uD3WMZ0TkFodbdhShOr9MV0TMSL0rWOh0pzXxZb
         rr9QjJVnAakQXE8wetm2UgKEgwHsb/fKhNba2IsfH6XDzMLgcPCCvouA3iiZAHwU5GMA
         dcUWw0ORNL9ZJ8VCDLREeZ+LcIpxJPI2kQyU2o3a8Kqad4UrkPosbE2rFevndkEHOx7j
         tjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712661408; x=1713266208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbv2FFP6IjSxUeJ8VtfFtr82fldAXn1hyih+xqFuJPc=;
        b=FY/2Y7zrAdzjRUEWfRV8GvXuCVDcFOya4u6Pu+so96T+KvagB6l1ttsu38sSbth2Fo
         BIu7SLjsJBxnG90c4Jkgvz5Q9vCjjik1RUZHxwB1rxAIL1HBn4mVq3Cz7AswD4I6vFYg
         r1QQS1N8Mv8USOAijh7fWpEbK0kf1ctp4jLgHcw2KJwoSKSQGJ0ry1EAv0Uxs4Ijx0+2
         90U4BbYSVexnB5Ddhm3I4TaMoC1+jqsKiz+jZ5y7GY9jCZwZR18rf8HvXFW1zg0H2nAi
         3KvzT9c0D+E/EMF80+f7KXe/Z2I6VD3JKbplWOHc1mCZSlO5LOUDKPbwZW18vz/YqSAe
         a+SA==
X-Gm-Message-State: AOJu0Yxg36Q2N2QnEB0ECJ5A03EQYoRa1i/3py5XAf4F+imKPEHFITQ7
	3rCJLQo6Hs2pS77pt7viidNVuCYPijKEii7N64aD5tGO5zl3cfhfVmbHl2Ua
X-Google-Smtp-Source: AGHT+IEBiNy/WTykuIZmoUIq5+BgjVD541T7Kfj0K+SueBECrfrs6h8DjxgEXkL04/FuA8zI9HlvUA==
X-Received: by 2002:a17:907:25c1:b0:a51:ddd1:183d with SMTP id ae1-20020a17090725c100b00a51ddd1183dmr4527036ejc.66.1712661408147;
        Tue, 09 Apr 2024 04:16:48 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id x1-20020a170906134100b00a519ec0a965sm5528612ejb.49.2024.04.09.04.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 04:16:47 -0700 (PDT)
Message-ID: <ab85199c-e82b-4ecf-994c-77fb418429bd@gmail.com>
Date: Tue, 9 Apr 2024 14:16:46 +0300
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
 <519e6717-3a58-4814-932d-8b246fd39f37@gmail.com>
 <253da7b1650d47b59114c635e7ad8dc3@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <253da7b1650d47b59114c635e7ad8dc3@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 03:27, Ping-Ke Shih wrote:
> 
> 
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> 
>>
>> On 08/04/2024 05:45, Ping-Ke Shih wrote:
>>>>
>>>>
>>>> static struct usb_interface *rtl92du_get_other_intf(struct ieee80211_hw *hw)
>>>> {
>>>>         struct usb_interface *intf;
>>>>         struct usb_device *udev;
>>>>         u8 other_interfaceindex;
>>>>
>>>>         /* See SET_IEEE80211_DEV(hw, &intf->dev); in usb.c */
>>>>         intf = container_of_const(wiphy_dev(hw->wiphy), struct usb_interface, dev);
>>>>
>>>>         other_interfaceindex = 1 - intf->altsetting[0].desc.bInterfaceNumber;
>>>
>>> The value of bInterfaceNumber for two instances are 0 and 1, right? Then
>>> '1 - x' to get each other -- that looks a little tricky ;-)
>>>
>>
>> The vendor driver assumes bInterfaceNumber can only be 0 or 1.
>> I can make it more explicit:
>>
>>         if (intf->altsetting[0].desc.bInterfaceNumber == 0)
>>                 other_interfaceindex = 1;
>>         else
>>                 other_interfaceindex = 0;
>>
> 
> That looks easier to understand. 
> 
>>>
>>>>
>>>> static void rtl92du_deinit_shared_data(struct ieee80211_hw *hw)
>>>> {
>>>>         struct usb_interface *other_intf = rtl92du_get_other_intf(hw);
>>>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>>>>
>>>>         if (!other_intf || usb_get_intfdata(other_intf)) {
>>>>                 /* The other interface doesn't exist or was not disconnected yet. */
>>>
>>> For the USB adaptor with single one interface, you don't have other_intf.
>>> Then, just free them.
>>>
>>> If the USB adaptor has two interfaces, it has both other_intf and
>>> usb_get_intfdata(other_intf), so you want to free them. But, I wonder if both
>>> interfaces can enter this branch?
>>>
>>
>> They can't both enter this branch because after the first
>> disconnect usb_get_intfdata() will return NULL.
>>
>>> Also as I mentioned above, how can you ensure other_intf isn't still using the
>>> shared data?
>>>
>>
>> I can make the second disconnect free the shared data by
>> checking if usb_get_intfdata() returns NULL:
>>
>>         if (!other_intf || !usb_get_intfdata(other_intf)) {
>>                 /* The other interface doesn't exist or was already disconnected. */
>>                 kfree(rtlpriv->curveindex_2g);
> 
> Will usb_get_intfdata(other_intf) return NULL if the intf disconnected? 
> If yes, that looks good to me. 
> 
> 

It should. rtl_usb_disconnect() has usb_set_intfdata(intf, NULL);
at the end. Also usb_unbind_interface() in drivers/usb/core/driver.c
does the same after calling rtl_usb_disconnect().

