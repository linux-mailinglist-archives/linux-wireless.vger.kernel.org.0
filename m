Return-Path: <linux-wireless+bounces-31293-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOgdMxb8emlaAQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31293-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 07:20:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA77AC2FD
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 07:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B23D130065C4
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 06:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF4332861B;
	Thu, 29 Jan 2026 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zacbowling-com.20230601.gappssmtp.com header.i=@zacbowling-com.20230601.gappssmtp.com header.b="OROjp1rb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B1F2DAFBE
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769667604; cv=pass; b=BPFjip0AmXTREKG0kH4kXIMXN3qSOjI62h/VjGHZ3ldlNy3zxn4k6hWEORRhtGwg7pNb+u2yZWk3DgU9DnXWZ+LWI8Hn2gAOUR8z9JngY7WaW1iNNxwSdxQB3WZdusNSkQWQ6WdZa3mwHDmc+sQ53AwH7cWdrM6Y4VasLiZxARM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769667604; c=relaxed/simple;
	bh=N/yE/AkWga0RRkg258i/fQW+tauDgFFDR0LOrvz8a4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LH66ke2gsahaxVtdfjJdNdXg4uhfR9VLYTebF4tk5iH5GTa217tVNpSV2lR1pEXDq3/v60bzNYdg6WDc2nfWIcSqsFzmOYddsdKZFipkQbySJpmiPDD2G69PoekVQ0S265zHayQJysl2m5FsRZv5z7zmAjgQg2IMQKkvC/rPx9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=zacbowling-com.20230601.gappssmtp.com header.i=@zacbowling-com.20230601.gappssmtp.com header.b=OROjp1rb; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65832e566edso824321a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 22:20:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769667601; cv=none;
        d=google.com; s=arc-20240605;
        b=e2Anj4yAhh9vvzz2dHqke317evPN9216FSEnWoq5cq0RwdJAdfawRPTDvmracc+Mya
         kprEuc9J2rCL/PtNJz4m68jR6/NkGch6N89WGfCochGkIRj0a6zGCAjogpe25OKtwLdp
         xwafQ3IHer8m78OTEd0bcrhpQTynJTI6Afw4MC5ZNpKcHzbFo+wwNKhHNdpZ7RGjmONE
         Z8/sYAPn+L4M2v4O+NN1bhEVlDDBwbg+FCI05p5khz7Fs5O59u5rg+po7dv4Q510zeuV
         UqT18MES8JEYFzHYMVj9WOKgqzaVK9k9JrsTN0i5REH5m/PDOoo3v7kTTwYcXiX+AZIs
         mAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V4RXnm96yEH7qfYuotbWNpOt6c3/e9A15eAjPlBB3Xw=;
        fh=pWtr7nzRAv6XrCvrhbS32R4TpVG08RaqfmiZ4HjMC7Y=;
        b=gSyC6/3ti4cr07pBrV1VVifomGOc/Y+mnUe3jSFTN+NOmnnfbmvXwYeOFGo/Ydlfiv
         Z4gxdWCx1ghH/lSd/gRLwv9EsWjqUMhUnhqbEhvGqCm6PaeVdNxBJAWFffDR0QbRo9yU
         PeHDHr6+cSbn12/6bfeIhmY4CGklujz9XsNvRhCkg73DDN69lppk2aaxNX5pdfQFHETB
         f3JF6KqHnwoVhU4EXo6MAEvbpRFgjJg7Y/BvSwGTIrHGudkOW2EX9TfPdZnL7JNGbEFt
         rCRdkVvkxsz5P4Alp5Jm4w8SbwVZMBJ3Bv6RJ7FEyFPGNPomTNJL7BhNaVsj1M6+ksFn
         DnGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zacbowling-com.20230601.gappssmtp.com; s=20230601; t=1769667601; x=1770272401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4RXnm96yEH7qfYuotbWNpOt6c3/e9A15eAjPlBB3Xw=;
        b=OROjp1rboNuqCZT5bu9Ah5CS1ZeiIiKb8LK2oHtAquXAoqBqc+BiOqg2+eOqfzsHzG
         oAvL7uppZkszAn47ytIgxnu6bXwob08octVlbgUiO4xY8nuWghQjlQq9HWU8NTEzKilu
         THnRWv+gLBNe5EaBXkJ5QdJh8JZQSDY8Qx6Z9Nei6yAJ4oG7VbWZWLvxbAl7XoWfCDMB
         aK1A8XxKpRqKzpgDRPITAXrHnUet3+WYoowPxyk4UeLw1Vv4aGi89TxRhwsVq/1mjtUD
         8TwAHbK+3ZLUoORFRb1scCKualzhUfdGKFaKjgJLcgoIfFcNC+8jih1qZXQOkCb1swiT
         +Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769667601; x=1770272401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V4RXnm96yEH7qfYuotbWNpOt6c3/e9A15eAjPlBB3Xw=;
        b=r6wJJjXcLqShEoNePZlgUa39Uv1dF7Q2S7luyQ/y5t/bWm6vGio4yALW0Ul9Gc5QME
         fpOmSPy6ldrv2Klzl0n1T3xmu86pqnN98ItMqlSsWJDnr3/LMXqUTqQ5ZJoX9uiD4V2E
         O9VR4d2L2pctwaSoQ3Xi4u3oVisPOiQJzo0QNc21WHpPZ3My3Y4M/I6l89WmfMCS9YU+
         8lilq87WHELNsqq/ss9WNCPl0rbJW/fFsc8XejrOiqfPwfHxPO6AOYndHFpV5ILtSsEu
         QuKGjlFiqOLZ91x2Q2MNbLQmNlnETWWbqw9/j3DrKkn2S3HbWAe276vTVLuTVngHsQON
         /f7w==
X-Forwarded-Encrypted: i=1; AJvYcCXyG3PHpE/iWmnToN7cD0KA4RaUB0iscmhiSnxGzBvBZ13ZbbtGrTonhT7DiAhs4NsznLFbhwFWTJ0FfMExDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww2NPqJ6tTqCzRgcfCcbMwvvJ4Gl4tmqX7cWZrw/zWeGXQKehH
	hRNDXnVT7VlU0tKT9EF4naxc5tQ1hu/X+yJ2xX9uYh3dzBzkPlXxNq01q2PRlxPqICpNnLTLGEc
	ZPOZyBdxbNhQLlYWBI2IeymS1Jlp/Op8=
X-Gm-Gg: AZuq6aLIIbF+5WTTnOtZfzf40jNVOjuIliPN9KBY5JFIoBvf5rLpziBDKJXauwvgI8n
	XsXzriNgJbJVKXZ4CahZozN9/90xd2phpFjvzXnQVBz9P3uv9llBxj4uyIFkZnhICo1GiXd7CA6
	H7eThq9y/JeuB+PnSE+BYmQavOPfOhwpK/j3Bd+zk8LlE1XlP5hsfQVyOFQ/dXDrdSuaDl+lyIY
	mk/lb0nkeYJCPvbopj9xwypny5wyYC0e0krQ6fuKaf3akRnHRK2+9yRjJCFN02M5Mff2Hg1bTFo
	OJL/Dt98KMyMPd3dHWgx/kd4El42teXQsGNucp6Zwhgb8R5G59LlDNZ0Pw==
X-Received: by 2002:a05:6402:1465:b0:650:31ef:177b with SMTP id
 4fb4d7f45d1cf-658a60c2615mr4860143a12.34.1769667600616; Wed, 28 Jan 2026
 22:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
 <20260120201043.38225-1-zac@zacbowling.com> <20260120201043.38225-5-zac@zacbowling.com>
 <a1113ede-9575-433f-a9d4-f8e9c1c6f8ab@nbd.name>
In-Reply-To: <a1113ede-9575-433f-a9d4-f8e9c1c6f8ab@nbd.name>
From: Zac Bowling <zac@zacbowling.com>
Date: Wed, 28 Jan 2026 22:19:49 -0800
X-Gm-Features: AZwV_QizZvGlC6PpQzePntFypupV7Pq3HGHnJZPkV8fl3s91jhWPWm7IPluHHDg
Message-ID: <CAOFcj8S4vBGpgwamW_b9mGaHhL78O44_CdM++qqGJc89nEancA@mail.gmail.com>
Subject: Re: [PATCH 04/13] wifi: mt76: mt7921: add mutex protection in
 critical paths
To: Felix Fietkau <nbd@nbd.name>
Cc: sean.wang@kernel.org, deren.wu@mediatek.com, kvalo@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux@frame.work, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[zacbowling-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	TAGGED_FROM(0.00)[bounces-31293-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[zacbowling-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nbd.name:email,zacbowling.com:email]
X-Rspamd-Queue-Id: 5AA77AC2FD
X-Rspamd-Action: no action

You are right. I caught that too. After reordering, when I went from
the 24-something patch version of this series earlier this month to
this smaller 11-patch series, to make it easier to follow again, that
happened. It's already gone in my new v7 series. We lock somewhere
else up in the stack now.

I'm cleaning up this whole stack again, dropping the ROC_ABORT back
off hack, because I think actually the solution isn't at this layer at
all, but possibly in the mac80211 layer.

Zac Bowling

On Tue, Jan 27, 2026 at 2:59=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> On 20.01.26 21:10, Zac wrote:
> > From: Zac Bowling <zac@zacbowling.com>
> >
> > Add proper mutex protection for mt7921 driver operations that access
> > hardware state without proper synchronization. This fixes multiple race
> > conditions that can cause system instability.
> >
> > Fixes added:
> >
> > 1. mac.c: mt7921_mac_reset_work()
> >     - Wrap ieee80211_iterate_active_interfaces() with mt792x_mutex
> >     - The vif_connect_iter callback accesses hw_encap state
> >
> > 2. main.c: mt7921_remain_on_channel()
> >     - Remove mt792x_mutex_acquire/release around mt7925_set_channel_sta=
te()
> >     - The function is already called with mutex held from mac80211
> >     - This was causing double-lock deadlock
> >
> > 3. main.c: mt7921_cancel_remain_on_channel()
> >     - Remove mt792x_mutex_acquire/release
> >     - Function is called from mac80211 with mutex already held
> >
> > 4. pci.c: mt7921_pci_pm_complete()
> >     - Remove mt792x_mutex_acquire/release around ieee80211_iterate_acti=
ve_interfaces
> >     - This was causing deadlock as the vif connect iteration tries
> >       to acquire the mutex again
> >
> > 5. usb.c: mt7921_usb_pm_complete()
> >     - Same fix as pci.c for USB driver path
> Changelog should be below "---" after the commit description, so it
> doesn't get picked up.
>
> > These changes prevent both missing mutex protection and mutex deadlocks
> > in the mt7921 driver.
> >
> > Fixes: 5c14a5f944b9 ("wifi: mt76: mt7921: introduce remain_on_channel s=
upport")
> > Signed-off-by: Zac Bowling <zac@zacbowling.com>
>
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers=
/net/wireless/mediatek/mt76/mt7921/main.c
> > index 5fae9a6e273c..196fcb1e2e94 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > @@ -373,6 +373,11 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
> >
> >       timer_delete_sync(&phy->roc_timer);
> >       cancel_work_sync(&phy->roc_work);
> > +     /* Note: caller must hold mutex if ieee80211_iterate_interfaces i=
s
> > +      * needed for ROC cleanup. Some call sites (like mt7921_mac_sta_r=
emove)
> > +      * already hold the mutex via mt76_sta_remove(). For suspend path=
s,
> > +      * the mutex should be acquired before calling this function.
> > +      */
> >       if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
> >               ieee80211_iterate_interfaces(mt76_hw(dev),
> >                                            IEEE80211_IFACE_ITER_RESUME_=
ALL,
> > @@ -619,6 +624,7 @@ void mt7921_set_runtime_pm(struct mt792x_dev *dev)
> >       bool monitor =3D !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
> >
> >       pm->enable =3D pm->enable_user && !monitor;
> > +     /* Note: caller (debugfs) must hold mutex before calling this fun=
ction */
> >       ieee80211_iterate_active_interfaces(hw,
> >                                           IEEE80211_IFACE_ITER_RESUME_A=
LL,
> >                                           mt7921_pm_interface_iter, dev=
);
> > @@ -765,6 +771,9 @@ mt7921_regd_set_6ghz_power_type(struct ieee80211_vi=
f *vif, bool is_add)
> >       struct mt792x_dev *dev =3D phy->dev;
> >       u32 valid_vif_num =3D 0;
> >
> > +     /* Note: caller (mt7921_mac_sta_add/remove via mt76_sta_add/remov=
e)
> > +      * already holds dev->mt76.mutex, so we must not acquire it here.
> > +      */
> >       ieee80211_iterate_active_interfaces(mt76_hw(dev),
> >                                           IEEE80211_IFACE_ITER_RESUME_A=
LL,
> >                                           mt7921_calc_vif_num, &valid_v=
if_num);
>
> It looks like these comments should be replaced with
> lockdep_assert_held, so that these assumptions can be verified
> automatically instead of doing so by hand.
>
>
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/=
net/wireless/mediatek/mt76/mt7921/pci.c
> > index ec9686183251..9f76b334b93d 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > @@ -426,7 +426,9 @@ static int mt7921_pci_suspend(struct device *device=
)
> >       cancel_delayed_work_sync(&pm->ps_work);
> >       cancel_work_sync(&pm->wake_work);
> >
> > +     mt792x_mutex_acquire(dev);
> >       mt7921_roc_abort_sync(dev);
> > +     mt792x_mutex_release(dev);
> The next patch is removing those...
>
> - Felix

