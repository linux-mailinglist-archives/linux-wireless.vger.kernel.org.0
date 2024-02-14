Return-Path: <linux-wireless+bounces-3577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D3854721
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 11:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803091C20365
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F032717580;
	Wed, 14 Feb 2024 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bayrepo.ru header.i=@bayrepo.ru header.b="SIChlB2F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893A1757A
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906520; cv=none; b=VqPKsiZTyx0Q0Hxh/ZNSCqvG9rgILrnxXYBB7CAjVffEPnw1flsQxAowFOHttoUxq00s95D0wmepTp9SljXMZ4XQRZUdLJ5nS5VsAHyT0WQvtzNIiy8Xm5uSsF1Lxs/RUbnmCKxY29aqlRzecbe6GM4ftE6CSlyBbRrA3jXC5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906520; c=relaxed/simple;
	bh=PpcHfW/ZggwkH9WEwy5MJQ6P/5eC8Lg83LzSg790zy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpgXSoMgc1AD/90n43jhRTt/vOoeuGMp51OADOnbsCDOihgp5lqyRgloOjLA4+Ka8jdiC6vOw1kwK+idwHa6zkEC1ipZtEmrgNdkZvWAL3sq2p+I7akfS8acWXH7iHgIl+S6vTgL6i41hWueNv43XKQNn76gPUACMfUMRoc9Myk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayrepo.ru; spf=pass smtp.mailfrom=bayrepo.ru; dkim=pass (1024-bit key) header.d=bayrepo.ru header.i=@bayrepo.ru header.b=SIChlB2F; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayrepo.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bayrepo.ru
Received: from mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5d87:0:640:2b2e:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 4C7C95E68D;
	Wed, 14 Feb 2024 13:28:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PSlj0FxOemI0-MqU0VB50;
	Wed, 14 Feb 2024 13:28:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bayrepo.ru; s=mail;
	t=1707906506; bh=5uTlJyK9lU4Q+F6A5n46inWCGUwcq5aW3FTy6THqbuE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=SIChlB2FZFTZLnTivoQfpGSWbJZAfYvmLPFf6+gU91nCJFjNBIl7tj2eZ5JmBFxox
	 XjfsKH7yIxZ+OemzYMsdudysFeJ3hyGMs5NnFhl8xA3J7cyoPdVbeZq45nK1wFAIry
	 TtCtrFDXpp8zoZ8z3q8J9n+S0CO9HxMJWxrDkHRA=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net; dkim=pass header.i=@bayrepo.ru
Message-ID: <9032fcc0-e2c4-1e97-1eec-02c3727d3b2e@bayrepo.ru>
Date: Wed, 14 Feb 2024 13:28:24 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: brcmfmac: do not cast hidden SSID attribute value
 to boolean
Content-Language: ru, en-US
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: Arend van Spriel <aspriel@gmail.com>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240208085121.2430-1-a@bayrepo.ru>
 <170775233602.2851594.8173116143852900695.kvalo@kernel.org>
 <9667b492-d3d3-4b04-bef4-f507387a9261@broadcom.com>
From: Alexey Berezhok <a@bayrepo.ru>
In-Reply-To: <9667b492-d3d3-4b04-bef4-f507387a9261@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

12.02.2024 19:00, Arend van Spriel wrote:
> On 2/12/2024 4:38 PM, Kalle Valo wrote:
>> Alexey Berezhok <a@bayrepo.ru> wrote:
>>
>>> In 'brcmf_cfg80211_start_ap()', not assume that
>>> NL80211_HIDDEN_SSID_NOT_IN_USE is zero but prefer
>>> an explicit check instead. Compile tested only.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Signed-off-by: Alexey Berezhok <a@bayrepo.ru>
>>
>> Patch applied to wireless-next.git, thanks.
>>
>> f20073f50dfd wifi: brcmfmac: do not cast hidden SSID attribute value 
>> to boolean
> 
> Alexey,
> 
> Can you do a follow-up patch addressing my comment? If not I will do it 
> myself.
> 
> Regards,
> Arend
> -- 
> https://patchwork.kernel.org/project/linux-wireless/patch/20240208085121.2430-1-a@bayrepo.ru/

Hello, do you mean this kind of modification:
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c 
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 63f6e9436..d8f7bd5ce 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5269,7 +5269,7 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, 
struct net_device *ndev,
                 }

                 err = brcmf_fil_iovar_int_set(ifp, "closednet",
-                                             settings->hidden_ssid);
+                                             (settings->hidden_ssid == 
NL80211_HIDDEN_SSID_NOT_IN_USE? 0 : 1));
                 if (err) {
                         bphy_err(drvr, "%s closednet error (%d)\n",
                                  (settings->hidden_ssid != 
NL80211_HIDDEN_SSID_NOT_IN_USE) ?

If so, I will make additional patch.

Regards,
Alexey


