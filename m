Return-Path: <linux-wireless+bounces-4706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C99F87B478
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 23:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04F3B20D93
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C2E59B4B;
	Wed, 13 Mar 2024 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCSJ8rau"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE705490C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369626; cv=none; b=B+MwgZNyxKzBt2q6NlwkuViD/4XX9Z7mCiJlRfklL/iG8AMrnZ6mWbM+E17PvCDg8aAV30erXbHWOiyBpeVt+N3xpuurGkkZXXCYhdCpgvECMp/p51cwzz6Y/ssaQjEZiHyu2sjE+NV7UjF99mOeAWvD+69gyTf7VJFnwyG3Vfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369626; c=relaxed/simple;
	bh=206kvk4cDvyrs+OwjczxwOLRRngcHHv6jzVaN1MY0po=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VXSUtUKtApvo0zai3HweA/jP1BY7RDbHbFi8fRTl7EKtQ2F/pa8OSuDyYvmsCAKQhxY3qioJHQbrf1qaCR1yXHD6I5y6CsiboFrj8YMr5wqPbUpm1duTA4jSGRXBHYHPufzTUPgtlHoM+8z4xkkWH0RJgbdZtcWpUmllVddCpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCSJ8rau; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e17342ea7so180304f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 15:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710369623; x=1710974423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ueZz7929FxoEprIDsqieXIupVf3U6O8ESKwYDnzmPYw=;
        b=OCSJ8rauwK/MuooV2+sF4Zi/pNASgUMJxcWWfEi3fDL20RM97cijiJyAKTZ/ND15K0
         fr8orE/Vl5cm9qPcO8sdMPkcoJhQGwQ8/GLRJB86nULdcqh+lsRihsQe8F7IGpWtBwor
         MHqNg8i2SsXi0sIVAKnRERV0sFpkjbHrNkCNphlnhgTDJfciVfZdsTCU273JBWI1y7Lu
         I8RmuDZBd08fOSyPAMlSDMp8AlMrxy32aPrDW0LsylxOROgMkKqRMgSAz5PIcGwjd3R0
         Y5O+O9sh8f+23Srowt7vFp9RrjKt/1UE8zcPQEV1fRjtBi6kgaWvC+c2GhtK1CgZlLKB
         u2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369623; x=1710974423;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueZz7929FxoEprIDsqieXIupVf3U6O8ESKwYDnzmPYw=;
        b=jDHh+lMFY994emDZxK0IW/0Nu/F8diKsam+e3+GDiSTAfSrGJwfGEgb6L676ICqbR9
         RLMGZwhpyN8cqt0nrxAtgUw7wnvdD2yUkHoFYFDfsD8suwxg5/XzPDayRdsdueT+Wa9q
         Z/rST7oU9h+lcBwi4sVL15yGyKAeYy7KGFL5QT3TU3VmC8llJG1q53Y0IItSN5q0R4wU
         ubr2yHLwBIo8yNMDWzZGXsno5nDGDBGdiR1ebfXqb1S3HqQ5aXzDThT8SJwQmo6ABmDh
         870sck+zjNWOTL4w26L2zFAvfst+2kHRw2v4/SY2jPmEhyZqfTwZQZI984E5aO5AmZ8n
         Dz7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsFZPLyZudgG4FEbAbBoHN9E/yQnu+hsGYdQZOIwngO7l/zmN715yXWqBu//NQbAIj6JeQAFY86SBQIOf7GmMy1RMpV8NQOi7o4l6zqNM=
X-Gm-Message-State: AOJu0Yx+HEjiLGUi/Rzo2adkIT6cr4945kOl2Jc9KBu1Jq3gcUfKHvIT
	WSnZBJ0JP0jdg0bJQnXkixlPWVN9mTXMrS+VrscoxaBiX67oCnUsYxVZ1VZ/
X-Google-Smtp-Source: AGHT+IH6JXuj2iHMeoOUYRNDmyFAtTst3kLo07MnYx/ZGieiAV/0IkCvRLLjeox/04hISt8iivlngg==
X-Received: by 2002:adf:e885:0:b0:33e:c271:8ca3 with SMTP id d5-20020adfe885000000b0033ec2718ca3mr694wrm.10.1710369623328;
        Wed, 13 Mar 2024 15:40:23 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bu29-20020a056000079d00b0033e456f6e7csm167144wrb.1.2024.03.13.15.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:40:23 -0700 (PDT)
Message-ID: <198972bc-bed3-449c-b879-716d59f65793@gmail.com>
Date: Thu, 14 Mar 2024 00:40:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
 <19743f05-5c95-41ad-bdb9-3694e5d2bb41@gmail.com>
 <c23608da2932896f7beb8fc29247efa5b2e92be0.camel@realtek.com>
Content-Language: en-US
In-Reply-To: <c23608da2932896f7beb8fc29247efa5b2e92be0.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 05:53, Ping-Ke Shih wrote:
> On Wed, 2024-03-13 at 01:21 +0200, Bitterblue Smith wrote:
> 
>>
> 
>> rtl92d_dm_check_txpower_tracking_thermal_meter() is actually
>> unused in rtl8192de. Should I just delete it?
>>
>> I don't remember why I made it static, but that introduced
>> a warning.
> 
> 
> I feel we can set rtlpriv->dm.txpower_tracking = false, and then uncomment
> /* rtl92d_dm_check_txpower_tracking_thermal_meter(hw); */
> 

That sounds good.

> 
> More, this function appears twice: 
> 
> $ git grep rtl92d_dm_check_txpower_tracking_thermal_meter
> rtl8192de/dm.c:static void rtl92d_dm_check_txpower_tracking_thermal_meter(struct ieee80211_hw *hw)
> rtl8192de/dm.c:         /* rtl92d_dm_check_txpower_tracking_thermal_meter(hw); */
> rtl8192du/dm.c:void rtl92d_dm_check_txpower_tracking_thermal_meter(struct ieee80211_hw *hw)
> rtl8192du/dm.c:         rtl92d_dm_check_txpower_tracking_thermal_meter(hw);
> 
> I suppose you should move rtl92d_dm_check_txpower_tracking_thermal_meter()
> to dm_common.c. 
> 

I didn't move the TX power tracking to dm_common.c because
it calls two functions which are different in the PCI driver
and the out-of-tree USB driver. (The USB driver is a few years
newer.)

* rtl92d_phy_lc_calibrate()
* rtl92d_phy_iq_calibrate()

I suppose if rtl92d_dm_check_txpower_tracking_thermal_meter()
takes two function pointers, it can be moved:

void rtl92d_dm_check_txpower_tracking_thermal_meter(struct ieee80211_hw *hw,
						    void (*lc_calibrate)(struct ieee80211_hw *hw),
						    void (*iq_calibrate)(struct ieee80211_hw *hw))

Or, struct rtl_hal_ops already has phy_lc_calibrate member.
I could add phy_iq_calibrate too.


