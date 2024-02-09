Return-Path: <linux-wireless+bounces-3403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998784F971
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 17:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515DB28714F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142A574E04;
	Fri,  9 Feb 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="dyLONyD5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C076F73161
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.3.6.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495411; cv=none; b=kadLsx4Y8Qpsu8hTrBuc9j1GBKu6KfrnypphmrdPkmpb/iiSWxvFCIUsXDrLurc13pZS/ihkc/Eg7BWer9avK29S7KbvsMVUpfgBTxgHNYLTm2muL9EPZDAvFApTpc1SA0CQLytwYXCDZQQwPBRlqpYD2OxDdXIXFfchEBy6UWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495411; c=relaxed/simple;
	bh=EpOO3GMFvb0k3nDos5VeUna1s5ystjnSdwdvSk24bHs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fdT59H72+ZK/px8Xfp2Y53UohkrcdBEA/glFG+g0hBYLTfur8AgkC72MTSJNwbY95prQqLqOdC4B/ud9QE/blDh5Z5jCpwZijscPNnzd667d1LbEx1Aep66LbSSgvtp/n0PGG4Uiw3zq9j/bLc/5+C8pZoCbsBL95KTAuRCK6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io; spf=pass smtp.mailfrom=tuta.io; dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b=dyLONyD5; arc=none smtp.client-ip=81.3.6.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w1.tutanota.de (Postfix) with ESMTP id B824AFBFC30;
	Fri,  9 Feb 2024 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1707494832;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=Q9X+dskE7PENUs7yc3UZWejOGmchbflexQvZpdQlIb4=;
	b=dyLONyD5wYyjAKDQTa1bFvCqVmLS1rQ/35K5YIJlbCmDXesOzHLk70oNWu/wkdzv
	QDnnZR1qNgP7+nVDi0zwFOa3jL9rw5Kgikqkgu/p4X3znmkpnaU7sqdgFo5TqHbGwXI
	Xv4MAxGhIvxRpO0dB/qVWcHDM6LqsLpIf6mc1i+sgBcezyL28+m5hR13ksrAjq6UoZc
	ha24eNaLquRkOh6oX1+5N5uMH/Id/wXMXiPvHUyzzWAqMy9Q2dGVBasTsh4SrDCIjkO
	ANKQ/rjjF1lF6FatPeBuMlGootaff373haJY6580LeGzBvOu/Rhx1WOLdGm5DeXx/MA
	OaOKPc07rw==
Date: Fri, 9 Feb 2024 17:07:12 +0100 (CET)
From: marco.rodolfi@tuta.io
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	Linux Wireless <linux-wireless@vger.kernel.org>,
	Jay Sweat <jjsweat@outlook.com>
Message-ID: <NqDbrXQ--3-9@tuta.io>
In-Reply-To: <161bc4c6ffe14a36ad76f214fe533eef@realtek.com>
References: <NlE3B0K--3-9@tuta.io> <60d366ff-8145-4f9d-a9f3-e27b82da31c2@lwfinger.net> <NlEvkht--3-9@tuta.io> <161bc4c6ffe14a36ad76f214fe533eef@realtek.com>
Subject: RE: Wireless P2P support for rtw88 families cards
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Just recently managed to run a couple of tests on lwfinger fork of the driver, which still required a small modification to expose P2P to the host like:
diff --git a/main.c b/main.cindex f589029..e8d7079 100644--- a/main.c+++ b/main.c@@ -110,7 +110,9 @@ static const struct ieee80211_iface_limit rtw_iface_limits[] = { 	}, 	{ 		.max = 1,-		.types = BIT(NL80211_IFTYPE_AP),+		.types = BIT(NL80211_IFTYPE_AP) |+				 BIT(NL80211_IFTYPE_P2P_CLIENT) |+				 BIT(NL80211_IFTYPE_P2P_GO), 	} }; @@ -2366,6 +2368,9 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw) 	if (rtwdev->chip->id == RTW_CHIP_TYPE_8822C) { 		hw->wiphy->iface_combinations = rtw_iface_combs; 		hw->wiphy->n_iface_combinations = ARRAY_SIZE(rtw_iface_combs);+		hw->wiphy->interface_modes = hw->wiphy->interface_modes |+				BIT(NL80211_IFTYPE_P2P_CLIENT) |+				BIT(NL80211_IFTYPE_P2P_GO); 	}  	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
I've limited this only on my specific chipset instead of all the supported chips, since just below there was a filter on the 8822c chip.

Initial tests seems good to me, P2P is exposed to userspace and a short test using wpa_supplicant show activity + my android phone seems to see the wireless direct network just fine and the connect prompts come in the wpa_supplicant logs, but pairing seems to always failing even inserting the code shown in the console. Not sure if I have to whitelist stuff from wpa_cli, can't really find much as user guide on the web regarding Wireless Direct.

I've tried mirrorcast as another usecase, but I can't seem to get it working correctly, the wpa_supplicant logs just claim that it can't be enabled on a non active interface during initialization (might just be an issue with mirrorcast itself rather than anything else tho).

I've posted this to a Deck user forums where other people had expressed their desire to test this, so I might get additional feedback to say if this is all that's needed to the driver or if it requires other stuff to be added.

No dmesg errors are printed anywhere, so this looks already quite good to me for now.

I'll probably follow this up soon as more data comes in,

Marco.


Dec 11, 2023, 02:30 by pkshih@realtek.com:

>
>
>> -----Original Message-----
>> From: marco.rodolfi@tuta.io <marco.rodolfi@tuta.io>
>> Sent: Sunday, December 10, 2023 2:55 AM
>> To: Larry Finger <Larry.Finger@lwfinger.net>
>> Cc: Linux Wireless <linux-wireless@vger.kernel.org>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: Re: Wireless P2P support for rtw88 families cards
>>
>> Oh, so there is already a test in. It's not in the main driver since it's missing testing or it's not that
>> much stable?
>>
>
> I don't have time to develop and test P2P on rtw88 that contains many chips.
>
> As thread [1], I did suggest some test cases, and I think Jay is testing.
>
> [1] https://lore.kernel.org/linux-wireless/1f6b255e8c8a4d9c9d2af80c93b7acf0@realtek.com/
>


