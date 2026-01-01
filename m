Return-Path: <linux-wireless+bounces-30254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C63CECB5E
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 01:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B88CC3013947
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 00:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1635623A9BD;
	Thu,  1 Jan 2026 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGd1B72J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B0155A5D
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767228102; cv=none; b=FB3BZknViojFEqZskSv0HO2YLfO1dSH0EAEGhS5ky01+F1U460zB+EYNDHphL+HDOsnJ+aKckreWJdknRP7rF0l5LutO37rCz2PgHKrRurhmkJrv3XZ4h4IjOsRkMhNYHBNNDLss7WdubUXhAkQg4pKA1E01U4FaOkwQrv00i+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767228102; c=relaxed/simple;
	bh=MCBRGB4H6O7KEpf5+wdKGGxYrafxhmV7aLse7bQ/PhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKn2Q7LDNCaNR4QQZ0/mGPye2hqusJ5CsyZUh9Mumpd8maoGqNUTsDCgl+qn12u7bWq34P//yBvj6juP0maTE3MYXK0AQTf9H35EhqErKVReBC2U7KvsR+RbXjxcOqCtz5PVH0TP0c3cWlYgTL7e1o7eb44gtpDKxjjN5KxFuI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGd1B72J; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so1718211666b.2
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767228098; x=1767832898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zzksPKZPWZUHlNBpPimtH9Rx1z4lA3vMPadPMifw6g=;
        b=EGd1B72JIA+0I4PtVoo2qTbrPB83kEJWcjw9bEQd5iPleHTPImWwZjicdUlLRvrjnD
         hYYUUamSpQsgN6bDszDdeb9+KNip49jaYRw9pSQ4NYxGuFuzGVM2PzFu9uSVKjxiG6Aj
         hZE0uvJp09vT1baVFDZWPl3012D9/2l3435az9aKGD99aOqq6G4pwsyF2PZxuX6ZgKFo
         lvxegTQ+0VADIkKfSUswzSn2rmvG7mK+SgYxxzD7wMW24qUfxYJaBy6UH4PqkOoF9GI2
         BNlsy6zCggYO3Hk/djot/RBOV/EbH6oq2K+OZQ1WpFZyowe/BCaOpavOKdmCX0bRK96c
         AwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767228098; x=1767832898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4zzksPKZPWZUHlNBpPimtH9Rx1z4lA3vMPadPMifw6g=;
        b=XUB8Lhp6DViMdgE+8r+EViSG5EGMr88QuErx7X49CT1lhMzzYgd8MEFkHu6xWCWx3d
         MyfY9qQMnjo+X6h0rwGGsaHsAcPaRoIVxV7GYkKF8AiJu7YrXoEF10hyGbrvHm7pO2eK
         atrKu4bYJWm6MRkGt8gurh6QozL53H2P7FBR4JBxlzRWjmATrCemCaqKrBhR7jGsAaxx
         SRrGgzl10Cv1jilE80aIdg2t2VkTijURtcQObix5/TNeQDxEPuVmQXVgMT/uI8cJc5rR
         Eujk1DxcYzjJVJU4XO2XGg1wM8zMRUZhsgHyVrLWNXLoKOtMhOc+9Q3Oa8dP4AoAaNS7
         oPBg==
X-Forwarded-Encrypted: i=1; AJvYcCUy5evYFZV0IxYtElIADTg5JZa8X+ZxCYc3K1mJHkcSFR/AOs9nkdKFzkW8J1WB+H0fFfjHRalTI2ZBovbQ8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkt+Ln+NVEUrUibk6qR+il6Pa/d7VQl/8zHM/qfOpkAxO7/QU3
	G7S/56NG5BMu6qdwBXxO/kq61FXJDPeHocsyCVK4WZtZ+umMvRAc4Xl3eAMNHHB4ZiJtSuXqQfI
	TTGVViRXt9T4EbDdsZYBuPw8glm37dixNhd7OS0kDlQ==
X-Gm-Gg: AY/fxX5wb9HzTYi2yU1a0229U8bvq6WCPCnhb96IxlfcykqqAiXhKtPD5VsqfxtzcbL
	2400UqsZgpaBIiCKD1kzwWGXpSRbo/YI/JIicNcaB/6wWpKS//Z8eMX0+WTnneicT1oKgolv41G
	yYTJGscI7Q/k1bJOOFWJaZ/tv2qiaR+/7DYQVqNhW1MS9/2OmxXwh1Azr8BM+g42oDp+7hklZCQ
	QU/u9MhRwMC+7x1k6ePPDQqR/oH7MbuPhG3DgOeMg+MqUP6NSvulFHSacRiB1mGdgVgc9xP1FdE
	vMia0wYY6l5EFbiupzhR/hLfeo/Y5tuAjckOx+mhltIlqW29e4ObcOgf03lCQxnFmC0=
X-Google-Smtp-Source: AGHT+IEsDAjrzY7RYgrHd/ztJQ1jHCf1aLEL7TFb54prQWsJy57fUQAi+XFSKVoGBeMqqqjI2GIY9k7RUSPJXb6X6lE=
X-Received: by 2002:a17:907:720f:b0:b73:8639:cd96 with SMTP id
 a640c23a62f3a-b8036f3a367mr3846484166b.24.1767228098167; Wed, 31 Dec 2025
 16:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231223702.30957-1-zbowling@gmail.com> <20260101002321.19332-1-zbowling@gmail.com>
In-Reply-To: <20260101002321.19332-1-zbowling@gmail.com>
From: Zac Bowling <zbowling@gmail.com>
Date: Wed, 31 Dec 2025 16:41:27 -0800
X-Gm-Features: AQt7F2pI_dhOs-zbE7FGIXVKviexl5P5mc0QK9CuuCDaL6zAWkJg3ebgrIT0Ccc
Message-ID: <CAOFcj8Sad3pLohFfRdj5jzK3Zs3FAjFVBuzH=80i_m1YqSbpfA@mail.gmail.com>
Subject: Re: [PATCH 3/3] wifi: mt76: mt7925: fix missing mutex protection in
 runtime PM and MLO PM
To: zbowling@gmail.com
Cc: deren.wu@mediatek.com, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	lorenzo@kernel.org, nbd@nbd.name, ryder.lee@mediatek.com, 
	sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Note, this is an update to the original patch I sent.

In this v2 patch, I moved mutex protection from inside
mt7925_roc_abort_sync() to the
call site in pci.c. The previous approach caused a self-deadlock when
roc_abort_sync was
called from the station remove path, which already holds the mutex.

I created a repo with all these patches if that makes it easier:
https://github.com/zbowling/mt7925

These bugs also exist in the mt7921 driver, which this mt7925 driver
seems to fork from.
These lock patterns match the much older mt7615 driver and other wifi drive=
rs.

Zac Bowling

Zac Bowling


On Wed, Dec 31, 2025 at 4:23=E2=80=AFPM Zac Bowling <zbowling@gmail.com> wr=
ote:
>
> From: Zac Bowling <zac@zacbowling.com>
>
> Two additional code paths were identified that iterate over active
> interfaces and call MCU functions without proper mutex protection:
>
> 1. mt7925_set_runtime_pm(): Called when runtime PM settings change.
>    The callback mt7925_pm_interface_iter() calls mt7925_mcu_set_beacon_fi=
lter()
>    which in turn calls mt7925_mcu_set_rxfilter(). These MCU functions req=
uire
>    the device mutex to be held.
>
> 2. mt7925_mlo_pm_work(): A workqueue function for MLO power management.
>    The callback mt7925_mlo_pm_iter() was acquiring mutex internally, whic=
h
>    is inconsistent with the rest of the driver where the caller holds the
>    mutex during interface iteration. Move the mutex to the caller for
>    consistency and to prevent potential race conditions.
>
> The impact of these bugs:
> - mt7925_set_runtime_pm(): Can cause deadlocks when power management
>   settings are changed while WiFi is active
> - mt7925_mlo_pm_work(): Can cause race conditions during MLO power save
>   state transitions
>
> Note: Similar bugs exist in the mt7921 driver and should be fixed in a
> separate patch series.
>
> Reported-by: Zac Bowling <zac@zacbowling.com>
> Tested-by: Zac Bowling <zac@zacbowling.com>
> Signed-off-by: Zac Bowling <zac@zacbowling.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7925/main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7925/main.c
> index 3001a62a8b67..9f17b21aef1c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> @@ -751,9 +751,11 @@ void mt7925_set_runtime_pm(struct mt792x_dev *dev)
>         bool monitor =3D !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
>
>         pm->enable =3D pm->enable_user && !monitor;
> +       mt792x_mutex_acquire(dev);
>         ieee80211_iterate_active_interfaces(hw,
>                                             IEEE80211_IFACE_ITER_RESUME_A=
LL,
>                                             mt7925_pm_interface_iter, dev=
);
> +       mt792x_mutex_release(dev);
>         pm->ds_enable =3D pm->ds_enable_user && !monitor;
>         mt7925_mcu_set_deep_sleep(dev, pm->ds_enable);
>  }
> @@ -1301,14 +1303,12 @@ mt7925_mlo_pm_iter(void *priv, u8 *mac, struct ie=
ee80211_vif *vif)
>         if (mvif->mlo_pm_state !=3D MT792x_MLO_CHANGED_PS)
>                 return;
>
> -       mt792x_mutex_acquire(dev);
>         for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
>                 bss_conf =3D mt792x_vif_to_bss_conf(vif, i);
>                 if (!bss_conf)
>                         continue;
>                 mt7925_mcu_uni_bss_ps(dev, bss_conf);
>         }
> -       mt792x_mutex_release(dev);
>  }
>
>  void mt7925_mlo_pm_work(struct work_struct *work)
> @@ -1317,9 +1317,11 @@ void mt7925_mlo_pm_work(struct work_struct *work)
>                                               mlo_pm_work.work);
>         struct ieee80211_hw *hw =3D mt76_hw(dev);
>
> +       mt792x_mutex_acquire(dev);
>         ieee80211_iterate_active_interfaces(hw,
>                                             IEEE80211_IFACE_ITER_RESUME_A=
LL,
>                                             mt7925_mlo_pm_iter, dev);
> +       mt792x_mutex_release(dev);
>  }
>
>  void mt7925_scan_work(struct work_struct *work)
> --
> 2.51.0
>

