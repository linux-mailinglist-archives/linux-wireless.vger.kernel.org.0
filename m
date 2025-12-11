Return-Path: <linux-wireless+bounces-29679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67033CB7643
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 00:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DED1300A6FD
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 23:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A32A883F;
	Thu, 11 Dec 2025 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubvIHz+F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D413B8D45
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765496063; cv=none; b=ZzX2MhlCy6Jb60UPcyPmRWOGI3vaNIv/hpR219MIpgXsYod6bM7RxaE2TTFgdrf6gItmr/n+DPLjFEfp5MTyEyh7OXmf7G8uQUnXDb1T1aOkVM1tduJdandrD3nYAmpjLUMfzWakwPTFBV6zpOnuGMeWkrrsc2/Bn87TXmp0tKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765496063; c=relaxed/simple;
	bh=vn95PIaMLj6upgO5jMwgVKMQ1smNCYmC4ZDr1a/82Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQ0vm8wK2fY2OS+DdPbOunSsASlRDBScvwqY7X2DTxJiP1cydp2TkaQMKJyPrp2D71QLF/vAtFvJ+vyO/7RVsWNB/WFG5e8ysEF3fY1pPp28nfJBX2C9KY6bhKh2Zkcp75FsSSguaK8T7h8m82J7NCaluUVyHcbfda6XVzlCccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubvIHz+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86857C19421
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 23:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765496062;
	bh=vn95PIaMLj6upgO5jMwgVKMQ1smNCYmC4ZDr1a/82Iw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ubvIHz+F1DDKY2LB0WZyytp+iqtNs3qy1BOeOM5ioX1N5WJdTxzKTyLZuhoX0ekEr
	 L3FnTX1iBYaZTu8uFnjJ9MqsBJzh/HqgU/m0Y3N8ZUS+9gUocvOuGaG9uGjEhJVXGQ
	 WxwUumUMQ3vLp6008fmEGaXFmk3SbkIdY4mqrLVf/CdNHX+iNwDQGQH99wWZI27xYF
	 ReErjsk8chIZxkpTKS/yO6CTHzj4IXLPtWwXh8lgYmv9DartuvAnOtiAkD3YyH4skn
	 6msDcFiXPZmc68YFSRYWk3KRhpJv+j0sErAG95ZpgLwR5IBBvlnQOhCXMaGB7YIKQw
	 Q3Udc4XdPb8MQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-598eaafa587so751726e87.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 15:34:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxIFHr1e2DTqGdXHRcos/8G29RweIBUPXrZBLRAloste1N2y3TmeBaN0MpCRCr/NG255/0QmD5LYLvwxu3FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7SXH8eKGoRzCxV20aqAqFJlgXV+WldW+z+o4d6MtDvQwGMlwb
	3PzPheaM2U2fehy2V+Tb/wfNVE+AY82LMQxn2SDHiFXhn9Rbh6ObnSD6sAcd1/tm6t2ZFw+tYGm
	0Tu03jkwqz3P20FFS04BNmdDQfhda8mU=
X-Google-Smtp-Source: AGHT+IEvQ91wmXN8XI7iCFfPklQkxRZiF0PCp/6Y8Gf/it+S6o+vKGFQFDujWCI6SAYtL+noliTTyYPhy2jqxa8s2Uk=
X-Received: by 2002:a05:651c:a0a:b0:37a:4c29:3a90 with SMTP id
 38308e7fff4ca-37fd05f238dmr820841fa.0.1765496060863; Thu, 11 Dec 2025
 15:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211124344.4172470-1-leon.yen@mediatek.com>
In-Reply-To: <20251211124344.4172470-1-leon.yen@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 11 Dec 2025 17:34:09 -0600
X-Gmail-Original-Message-ID: <CAGp9Lzo6DnBN+x-HGGDBJE2x-pqm6TPp77qch_VrFgq=cgKzQw@mail.gmail.com>
X-Gm-Features: AQt7F2qoFrXbjs6uKgJY9lNoURXQF9CRVoAGd6ZNwW-075Q2iDyH-RPqdeD-40s
Message-ID: <CAGp9Lzo6DnBN+x-HGGDBJE2x-pqm6TPp77qch_VrFgq=cgKzQw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt792x: Fix a potential deadlock in high-load situations
To: Leon Yen <leon.yen@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, deren.wu@mediatek.com, 
	sean.wang@mediatek.com, mingyen.hsieh@mediatek.com, michael.lo@mediatek.com, 
	allan.wang@mediatek.com, quan.zhou@mediatek.com, sarick.jiang@mediatek.com, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

Nice catch! But I think this approach can still lead to deadlock.
If both workers fire at the same time, they may both see other =3D=3D 0,
both set their own state to 1, both start running, and then both try
to call cancel_delayed_work_sync() on each other.
Then since atomic_set/atomic_read are weakly ordered, we don=E2=80=99t real=
ly
get proper exclusivity on SMP without something stronger.
And given that ps_work is a low-level piece used all over the place,
blocking on it isn=E2=80=99t ideal. A non-blocking cancel avoids the "both
wait on each other" situation.

So I=E2=80=99d suggest switching to:

@@ -375,7 +378,8 @@ void mt792x_pm_power_save_work(struct work_struct *work=
)
        }

        if (!mt792x_mcu_fw_pmctrl(dev)) {
-               cancel_delayed_work_sync(&mphy->mac_work);
+               cancel_delayed_work(&mphy->mac_work);
                return;
        }

to break the waiting loop.

This should make things safer without changing the overall flow, and
keeps the code easier to read and maintain.
Any pending mac work will get canceled, and if a mac work is already
running, it will schedule another ps_work once it completes.

                  Sean

On Thu, Dec 11, 2025 at 6:44=E2=80=AFAM Leon Yen <leon.yen@mediatek.com> wr=
ote:
>
> A deadlock may occur between two works, ps_work and mac_work, if their wo=
rk
> functions run simultaneously as they attempt to cancel each other by
> calling cancel_delayed_work_sync().
>
> mt792x_mac_work() ->   ...  -> cancel_delayed_work_sync(&pm->ps_work);
> mt792x_pm_power_save_work() -> cancel_delayed_work_sync(&mphy->mac_work);
>
> In high-load situations, they are queued but may not have chance to be
> executed until the CPUs are released. Once the CPUs are available, there
> is a high possibility that the ps_work function and mac_work function wil=
l
> be executed simultaneously, resulting in a deadlock.
>
> This patch ensures that the ps_work function and mac_work function can ru=
n
> exclusively by adding two flags to indicate their running status.The work
> function will reschedule itself if the opposite is currently running.
>
> Signed-off-by: Leon Yen <leon.yen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h        |  1 +
>  drivers/net/wireless/mediatek/mt76/mt76_connac.h |  1 +
>  drivers/net/wireless/mediatek/mt76/mt792x_mac.c  | 13 +++++++++++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index d05e83ea1cac..0414a4898d80 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -892,6 +892,7 @@ struct mt76_phy {
>  #endif
>
>         struct delayed_work mac_work;
> +       atomic_t mac_work_running;
>         u8 mac_work_count;
>
>         struct {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/n=
et/wireless/mediatek/mt76/mt76_connac.h
> index 813d61bffc2c..eefa0147f883 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> @@ -107,6 +107,7 @@ struct mt76_connac_pm {
>         struct mutex mutex;
>
>         struct delayed_work ps_work;
> +       atomic_t ps_work_running;
>         unsigned long last_activity;
>         unsigned long idle_timeout;
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt792x_mac.c
> index 71dec93094eb..22345031e262 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
> @@ -15,6 +15,10 @@ void mt792x_mac_work(struct work_struct *work)
>                                                mac_work.work);
>         phy =3D mphy->priv;
>
> +       if (atomic_read(&phy->dev->pm.ps_work_running))
> +               goto out;
> +       atomic_set(&mphy->mac_work_running, 1);
> +
>         mt792x_mutex_acquire(phy->dev);
>
>         mt76_update_survey(mphy);
> @@ -27,8 +31,10 @@ void mt792x_mac_work(struct work_struct *work)
>         mt792x_mutex_release(phy->dev);
>
>         mt76_tx_status_check(mphy->dev, false);
> +out:
>         ieee80211_queue_delayed_work(phy->mt76->hw, &mphy->mac_work,
>                                      MT792x_WATCHDOG_TIME);
> +       atomic_set(&mphy->mac_work_running, 0);
>  }
>  EXPORT_SYMBOL_GPL(mt792x_mac_work);
>
> @@ -356,6 +362,11 @@ void mt792x_pm_power_save_work(struct work_struct *w=
ork)
>         mphy =3D dev->phy.mt76;
>
>         delta =3D dev->pm.idle_timeout;
> +
> +       if (atomic_read(&mphy->mac_work_running))
> +               goto out;
> +       atomic_set(&dev->pm.ps_work_running, 1);
> +
>         if (test_bit(MT76_HW_SCANNING, &mphy->state) ||
>             test_bit(MT76_HW_SCHED_SCANNING, &mphy->state) ||
>             dev->fw_assert)
> @@ -376,9 +387,11 @@ void mt792x_pm_power_save_work(struct work_struct *w=
ork)
>
>         if (!mt792x_mcu_fw_pmctrl(dev)) {
>                 cancel_delayed_work_sync(&mphy->mac_work);
> +               atomic_set(&dev->pm.ps_work_running, 0);
>                 return;
>         }
>  out:
>         queue_delayed_work(dev->mt76.wq, &dev->pm.ps_work, delta);
> +       atomic_set(&dev->pm.ps_work_running, 0);
>  }
>  EXPORT_SYMBOL_GPL(mt792x_pm_power_save_work);
> --
> 2.45.2
>
>

