Return-Path: <linux-wireless+bounces-31012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C0DD3C2A7
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 09:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DE875A8BFD
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 08:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59A83BC4D1;
	Tue, 20 Jan 2026 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLqVSIbX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8723BC4C7
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897537; cv=none; b=GxNPUjFCiNk9IFMU6YRELH72a5S1rpUg6KH1AR+RAwvw7/7IRPdVYS4vK7A0XPELqmNLV19wRR2QU4wFjMTHXZpZdShF8is9yhJFdehM7ELZeIHLv3YFZmEayXZw43WmHOhCs6jv9ytFkGwnLMq+2mkEW4P/cGELigZWIZNJ5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897537; c=relaxed/simple;
	bh=C43VXqk9GnJNPUWh5LRNiprjeaEeARcvp4X4kA4WuOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+oTbsCUYutCOue0tCwRnW/BULGYGBdmkv/bZc0L9M7zsn4U3W7oDMSJ26esXBzzlQ9xJUPbL4XC1BQONZ3qhzG9+t2/qsIgDDg1vMxkzWCdl/9xgZuToG4MQoe5wbKj0SJVDwu+n17PobWldlgibcq3HrFqy+HgpOhrkgqtMYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLqVSIbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EDCC19425
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768897537;
	bh=C43VXqk9GnJNPUWh5LRNiprjeaEeARcvp4X4kA4WuOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lLqVSIbXEUMBDpeLNYJS0Y3t/8Mlp3Uch8UyIMz9yA1N+wGkPCoBPQanE7TnizKEJ
	 An31TdJxXx/wS4ZhvN7Qo9V5QjW1KWGoMjh9hV95xjuyhv2v9pCc6QEFUaiIYO4b0s
	 PUAN/cr+MgPXa1HKh2RaRidHPMJH/RJzZFbtdq2w8d/4fyRlLD+vSUjfsj6iO2pUU8
	 iNDyEelg3HqIu1hgkepyGNuPP6YvsYIP/x+XAtrQgMZpTdUODAS2vDk72t2UMpLKMA
	 jcv+7fpsKyn/EwcVDbflSOsS8nv/tRBFiKGuNkxt/vmxfBmC8jfcQu0ESl32Q3qi2H
	 fR4W539VSyp1Q==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-598f8136a24so5792385e87.3
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 00:25:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsX+HnVdLjitLpM8Axk9b6UZwqf/ywYQ0Qo57uA4z5WAAVEU5y3xiyXBL79UYjzEJ6JX4iSOSM/kUki5Yagg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3gO1wn6hCma+NmTBHxp0kdPBCj87Hl6NSaL8brqargIx/lse2
	qkYZ7IsEzWvhsgUdpI8GyMf4BomuMmvkhcH78sTcD6dfmEbMnrraY2yQ1OibTgBKfplIqgzIAfT
	6SuZQMzALIlOJpLF4SD/GPhn4Z/iwF0E=
X-Received: by 2002:a05:6512:114f:b0:59b:b25d:5c38 with SMTP id
 2adb3069b0e04-59bb25d5cdbmr4645470e87.7.1768897535467; Tue, 20 Jan 2026
 00:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260120062854.126501-1-zac@zacbowling.com> <20260120062854.126501-12-zac@zacbowling.com>
In-Reply-To: <20260120062854.126501-12-zac@zacbowling.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 20 Jan 2026 02:25:23 -0600
X-Gmail-Original-Message-ID: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
X-Gm-Features: AZwV_Qiq2kAii4UrcFAe4RI0CA6Ih68D7tpt-8hVRj2bSY2AWW1miq1tr9ZgKls
Message-ID: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
Subject: Re: [PATCH 11/11] wifi: mt76: mt7925: fix ROC deadlocks and race conditions
To: Zac <zac@zacbowling.com>
Cc: deren.wu@mediatek.com, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	lorenzo@kernel.org, nbd@nbd.name, ryder.lee@mediatek.com, 
	sean.wang@mediatek.com, stable@vger.kernel.org, linux@frame.work, 
	zbowling@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 12:29=E2=80=AFAM Zac <zac@zacbowling.com> wrote:
>
> From: Zac Bowling <zac@zacbowling.com>
>
> Fix multiple interrelated issues in the remain-on-channel (ROC) handling
> that cause deadlocks, race conditions, and resource leaks.
>
> Problems fixed:
>
> 1. Deadlock in sta removal ROC abort path:
>    When a station is removed while a ROC operation is in progress, the
>    driver would call mt7925_roc_abort_sync() which waits for ROC completi=
on.
>    However, the ROC work itself needs to acquire mt792x_mutex which is
>    already held during station removal, causing a deadlock.
>
>    Fix: Use async ROC abort (mt76_connac_mcu_abort_roc) when called from
>    paths that already hold the mutex, and add MT76_STATE_ROC_ABORT flag
>    to coordinate between the abort and the ROC timer.
>

Hi Zac,

Thanks for your continued efforts on the driver.
We=E2=80=99ve sent a patch to address the mt7925 deadlock at the link below=
:
https://lists.infradead.org/pipermail/linux-mediatek/2025-December/102164.h=
tml
We plan to send the same fix to mt7921 as well.

I had a couple of questions and suggestions:
1. Would it be possible to rebase your patchset on top of this fix
(and any other pending patches that are not yet merged)? We noticed
some conflicts when applying the series, and rebasing it this way
would make it easier for nbd to integrate the full patchset.
2. Could you please elaborate on the test scenarios that would trigger
ROC rate limiting for MLO authentication failures? If I recall
correctly, ROC operations are typically handled sequentially unless
multiple interfaces are created on the same physical device. In that
case, how many virtual interfaces and which operating modes (GC/STA or
multiple STAs) are required to reproduce the issue?

I will try to prepare an out-of-tree branch with the current pending
patches to help your patchset integrate more smoothly. Thanks for
collecting community issues and fixes and incorporating them into the
driver.

             Sean

> 2. ROC timer race during suspend:
>    The ROC timer could fire after the device started suspending but befor=
e
>    the ROC was properly aborted, causing undefined behavior.
>
>    Fix: Delete ROC timer synchronously before suspend and check device
>    state before processing ROC timeout.
>
> 3. ROC rate limiting for MLO auth failures:
>    Rapid ROC requests during MLO authentication can overwhelm the firmwar=
e,
>    causing authentication timeouts. The MT7925 firmware has limited ROC
>    handling capacity.
>
>    Fix: Add rate limiting infrastructure with configurable minimum interv=
al
>    between ROC requests. Track last ROC completion time and defer new
>    requests if they arrive too quickly.
>
> 4. WCID leak in ROC cleanup:
>    When ROC operations are aborted, the associated WCID resources were
>    not being properly released, causing resource exhaustion over time.
>
>    Fix: Ensure WCID cleanup happens in all ROC termination paths.
>
> 5. Async ROC abort race condition:
>    The async ROC abort could race with normal ROC completion, causing
>    double-free or use-after-free of ROC resources.
>
>    Fix: Use MT76_STATE_ROC_ABORT flag and proper synchronization to
>    prevent races between async abort and normal completion paths.
>
> These fixes work together to provide robust ROC handling that doesn't
> deadlock, properly releases resources, and handles edge cases during
> suspend and MLO operations.
>
> Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for =
mt7925 device")
> Signed-off-by: Zac Bowling <zac@zacbowling.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
>  .../net/wireless/mediatek/mt76/mt7925/main.c  | 175 ++++++++++++++++--
>  drivers/net/wireless/mediatek/mt76/mt792x.h   |   7 +
>  3 files changed, 170 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index d05e83ea1cac..91f9dd95c89e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -511,6 +511,7 @@ enum {
>         MT76_STATE_POWER_OFF,
>         MT76_STATE_SUSPEND,
>         MT76_STATE_ROC,
> +       MT76_STATE_ROC_ABORT,
>         MT76_STATE_PM,
>         MT76_STATE_WED_RESET,
>  };
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7925/main.c
> index cc7ef2c17032..2404f7812897 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> @@ -453,6 +453,24 @@ static void mt7925_roc_iter(void *priv, u8 *mac,
>         mt7925_mcu_abort_roc(phy, &mvif->bss_conf, phy->roc_token_id);
>  }
>
> +/* Async ROC abort - safe to call while holding mutex.
> + * Sets abort flag and lets roc_work handle cleanup without blocking.
> + * This prevents deadlock when called from sta_remove path which holds m=
utex.
> + */
> +static void mt7925_roc_abort_async(struct mt792x_dev *dev)
> +{
> +       struct mt792x_phy *phy =3D &dev->phy;
> +
> +       /* Set abort flag - roc_work checks this before acquiring mutex *=
/
> +       set_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
> +
> +       /* Stop timer and schedule work to handle cleanup.
> +        * Must schedule work since timer may not have fired yet.
> +        */
> +       timer_delete(&phy->roc_timer);
> +       ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
> +}
> +
>  void mt7925_roc_abort_sync(struct mt792x_dev *dev)
>  {
>         struct mt792x_phy *phy =3D &dev->phy;
> @@ -473,6 +491,17 @@ void mt7925_roc_work(struct work_struct *work)
>         phy =3D (struct mt792x_phy *)container_of(work, struct mt792x_phy=
,
>                                                 roc_work);
>
> +       /* Check abort flag BEFORE acquiring mutex to prevent deadlock.
> +        * If abort is requested while we're in the sta_remove path (whic=
h
> +        * holds the mutex), we must not try to acquire it or we'll deadl=
ock.
> +        * Clear the flags and only notify mac80211 if ROC was actually a=
ctive.
> +        */
> +       if (test_and_clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state)) =
{
> +               if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state)=
)
> +                       ieee80211_remain_on_channel_expired(phy->mt76->hw=
);
> +               return;
> +       }
> +
>         if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
>                 return;
>
> @@ -500,14 +529,93 @@ static int mt7925_abort_roc(struct mt792x_phy *phy,
>         return err;
>  }
>
> +/* ROC rate limiting constants - exponential backoff to prevent MCU over=
load
> + * when upper layers trigger rapid reconnection cycles (e.g., MLO auth f=
ailures).
> + * Max backoff ~1.6s, resets after 10s of no timeouts.
> + */
> +#define MT7925_ROC_BACKOFF_BASE_MS     100
> +#define MT7925_ROC_BACKOFF_MAX_MS      1600
> +#define MT7925_ROC_TIMEOUT_RESET_MS    10000
> +#define MT7925_ROC_TIMEOUT_WARN_THRESH 5
> +
> +/* Check if ROC should be throttled due to recent timeouts.
> + * Returns delay in jiffies if throttling, 0 if OK to proceed.
> + */
> +static unsigned long mt7925_roc_throttle_check(struct mt792x_phy *phy)
> +{
> +       unsigned long now =3D jiffies;
> +
> +       /* Reset timeout counter if it's been a while since last timeout =
*/
> +       if (phy->roc_timeout_count &&
> +           time_after(now, phy->roc_last_timeout +
> +                      msecs_to_jiffies(MT7925_ROC_TIMEOUT_RESET_MS))) {
> +               phy->roc_timeout_count =3D 0;
> +               phy->roc_backoff_until =3D 0;
> +       }
> +
> +       /* Check if we're still in backoff period */
> +       if (phy->roc_backoff_until && time_before(now, phy->roc_backoff_u=
ntil))
> +               return phy->roc_backoff_until - now;
> +
> +       return 0;
> +}
> +
> +/* Record ROC timeout and calculate backoff period */
> +static void mt7925_roc_record_timeout(struct mt792x_phy *phy)
> +{
> +       unsigned int backoff_ms;
> +
> +       phy->roc_last_timeout =3D jiffies;
> +       phy->roc_timeout_count++;
> +
> +       /* Exponential backoff: 100ms, 200ms, 400ms, 800ms, 1600ms (cappe=
d) */
> +       backoff_ms =3D MT7925_ROC_BACKOFF_BASE_MS <<
> +                    min_t(u8, phy->roc_timeout_count - 1, 4);
> +       if (backoff_ms > MT7925_ROC_BACKOFF_MAX_MS)
> +               backoff_ms =3D MT7925_ROC_BACKOFF_MAX_MS;
> +
> +       phy->roc_backoff_until =3D jiffies + msecs_to_jiffies(backoff_ms)=
;
> +
> +       /* Warn if we're seeing repeated timeouts - likely upper layer is=
sue */
> +       if (phy->roc_timeout_count =3D=3D MT7925_ROC_TIMEOUT_WARN_THRESH)
> +               dev_warn(phy->dev->mt76.dev,
> +                        "mt7925: %u consecutive ROC timeouts, possible m=
ac80211/wpa_supplicant issue (MLO key race?)\n",
> +                        phy->roc_timeout_count);
> +}
> +
> +/* Clear timeout tracking on successful ROC */
> +static void mt7925_roc_clear_timeout(struct mt792x_phy *phy)
> +{
> +       phy->roc_timeout_count =3D 0;
> +       phy->roc_backoff_until =3D 0;
> +}
> +
>  static int mt7925_set_roc(struct mt792x_phy *phy,
>                           struct mt792x_bss_conf *mconf,
>                           struct ieee80211_channel *chan,
>                           int duration,
>                           enum mt7925_roc_req type)
>  {
> +       unsigned long throttle;
>         int err;
>
> +       /* Check rate limiting - if in backoff period, wait or return bus=
y */
> +       throttle =3D mt7925_roc_throttle_check(phy);
> +       if (throttle) {
> +               /* For short backoffs, wait; for longer ones, return busy=
 */
> +               if (throttle < msecs_to_jiffies(200)) {
> +                       msleep(jiffies_to_msecs(throttle));
> +               } else {
> +                       dev_dbg(phy->dev->mt76.dev,
> +                               "mt7925: ROC throttled, %lu ms remaining\=
n",
> +                               jiffies_to_msecs(throttle));
> +                       return -EBUSY;
> +               }
> +       }
> +
> +       /* Clear stale abort flag from previous ROC */
> +       clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
> +
>         if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
>                 return -EBUSY;
>
> @@ -523,7 +631,11 @@ static int mt7925_set_roc(struct mt792x_phy *phy,
>         if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, 4 * HZ)) {
>                 mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
>                 clear_bit(MT76_STATE_ROC, &phy->mt76->state);
> +               mt7925_roc_record_timeout(phy);
>                 err =3D -ETIMEDOUT;
> +       } else {
> +               /* Successful ROC - reset timeout tracking */
> +               mt7925_roc_clear_timeout(phy);
>         }
>
>  out:
> @@ -534,8 +646,27 @@ static int mt7925_set_mlo_roc(struct mt792x_phy *phy=
,
>                               struct mt792x_bss_conf *mconf,
>                               u16 sel_links)
>  {
> +       unsigned long throttle;
>         int err;
>
> +       /* Check rate limiting - MLO ROC is especially prone to rapid-fir=
e
> +        * during reconnection cycles after MLO authentication failures.
> +        */
> +       throttle =3D mt7925_roc_throttle_check(phy);
> +       if (throttle) {
> +               if (throttle < msecs_to_jiffies(200)) {
> +                       msleep(jiffies_to_msecs(throttle));
> +               } else {
> +                       dev_dbg(phy->dev->mt76.dev,
> +                               "mt7925: MLO ROC throttled, %lu ms remain=
ing\n",
> +                               jiffies_to_msecs(throttle));
> +                       return -EBUSY;
> +               }
> +       }
> +
> +       /* Clear stale abort flag from previous ROC */
> +       clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
> +
>         if (WARN_ON_ONCE(test_and_set_bit(MT76_STATE_ROC, &phy->mt76->sta=
te)))
>                 return -EBUSY;
>
> @@ -550,7 +681,10 @@ static int mt7925_set_mlo_roc(struct mt792x_phy *phy=
,
>         if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, 4 * HZ)) {
>                 mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
>                 clear_bit(MT76_STATE_ROC, &phy->mt76->state);
> +               mt7925_roc_record_timeout(phy);
>                 err =3D -ETIMEDOUT;
> +       } else {
> +               mt7925_roc_clear_timeout(phy);
>         }
>
>  out:
> @@ -567,6 +701,7 @@ static int mt7925_remain_on_channel(struct ieee80211_=
hw *hw,
>         struct mt792x_phy *phy =3D mt792x_hw_phy(hw);
>         int err;
>
> +       cancel_work_sync(&phy->roc_work);
>         mt792x_mutex_acquire(phy->dev);
>         err =3D mt7925_set_roc(phy, &mvif->bss_conf,
>                              chan, duration, MT7925_ROC_REQ_ROC);
> @@ -874,14 +1009,14 @@ static int mt7925_mac_link_sta_add(struct mt76_dev=
 *mdev,
>         if (!mlink)
>                 return -EINVAL;
>
> -       idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1)=
;
> -       if (idx < 0)
> -               return -ENOSPC;
> -
>         mconf =3D mt792x_vif_to_link(mvif, link_id);
>         if (!mconf)
>                 return -EINVAL;
>
> +       idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1)=
;
> +       if (idx < 0)
> +               return -ENOSPC;
> +
>         mt76_wcid_init(&mlink->wcid, 0);
>         mlink->wcid.sta =3D 1;
>         mlink->wcid.idx =3D idx;
> @@ -901,14 +1036,16 @@ static int mt7925_mac_link_sta_add(struct mt76_dev=
 *mdev,
>
>         ret =3D mt76_connac_pm_wake(&dev->mphy, &dev->pm);
>         if (ret)
> -               return ret;
> +               goto err_wcid;
>
>         mt7925_mac_wtbl_update(dev, idx,
>                                MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
>
>         link_conf =3D mt792x_vif_to_bss_conf(vif, link_id);
> -       if (!link_conf)
> -               return -EINVAL;
> +       if (!link_conf) {
> +               ret =3D -EINVAL;
> +               goto err_wcid;
> +       }
>
>         /* should update bss info before STA add */
>         if (vif->type =3D=3D NL80211_IFTYPE_STATION && !link_sta->sta->td=
ls) {
> @@ -920,7 +1057,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *=
mdev,
>                         ret =3D mt7925_mcu_add_bss_info(&dev->phy, mconf-=
>mt76.ctx,
>                                                       link_conf, link_sta=
, false);
>                 if (ret)
> -                       return ret;
> +                       goto err_wcid;
>         }
>
>         if (ieee80211_vif_is_mld(vif) &&
> @@ -928,28 +1065,34 @@ static int mt7925_mac_link_sta_add(struct mt76_dev=
 *mdev,
>                 ret =3D mt7925_mcu_sta_update(dev, link_sta, vif, true,
>                                             MT76_STA_INFO_STATE_NONE);
>                 if (ret)
> -                       return ret;
> +                       goto err_wcid;
>         } else if (ieee80211_vif_is_mld(vif) &&
>                    link_sta !=3D mlink->pri_link) {
>                 ret =3D mt7925_mcu_sta_update(dev, mlink->pri_link, vif,
>                                             true, MT76_STA_INFO_STATE_ASS=
OC);
>                 if (ret)
> -                       return ret;
> +                       goto err_wcid;
>
>                 ret =3D mt7925_mcu_sta_update(dev, link_sta, vif, true,
>                                             MT76_STA_INFO_STATE_ASSOC);
>                 if (ret)
> -                       return ret;
> +                       goto err_wcid;
>         } else {
>                 ret =3D mt7925_mcu_sta_update(dev, link_sta, vif, true,
>                                             MT76_STA_INFO_STATE_NONE);
>                 if (ret)
> -                       return ret;
> +                       goto err_wcid;
>         }
>
>         mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
>
>         return 0;
> +
> +err_wcid:
> +       rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
> +       mt76_wcid_mask_clear(dev->mt76.wcid_mask, idx);
> +       mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
> +       return ret;
>  }
>
>  static int
> @@ -1135,7 +1278,8 @@ static void mt7925_mac_link_sta_remove(struct mt76_=
dev *mdev,
>         if (!mlink)
>                 return;
>
> -       mt7925_roc_abort_sync(dev);
> +       /* Async abort - caller already holds mutex */
> +       mt7925_roc_abort_async(dev);
>
>         mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
>         mt76_connac_pm_wake(&dev->mphy, &dev->pm);
> @@ -1530,6 +1674,8 @@ static int mt7925_suspend(struct ieee80211_hw *hw,
>         cancel_delayed_work_sync(&dev->pm.ps_work);
>         mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
>
> +       /* Cancel ROC before quiescing starts */
> +       mt7925_roc_abort_sync(dev);
>         mt792x_mutex_acquire(dev);
>
>         clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
> @@ -1876,6 +2022,8 @@ static void mt7925_mgd_prepare_tx(struct ieee80211_=
hw *hw,
>         u16 duration =3D info->duration ? info->duration :
>                        jiffies_to_msecs(HZ);
>
> +       cancel_work_sync(&mvif->phy->roc_work);
> +
>         mt792x_mutex_acquire(dev);
>         mt7925_set_roc(mvif->phy, &mvif->bss_conf,
>                        mvif->bss_conf.mt76.ctx->def.chan, duration,
> @@ -2033,6 +2181,7 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, st=
ruct ieee80211_vif *vif,
>         if (old_links =3D=3D new_links)
>                 return 0;
>
> +       cancel_work_sync(&phy->roc_work);
>         mt792x_mutex_acquire(dev);
>
>         for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wi=
reless/mediatek/mt76/mt792x.h
> index 8388638ed550..d9c1ea709390 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
> @@ -186,6 +186,13 @@ struct mt792x_phy {
>         wait_queue_head_t roc_wait;
>         u8 roc_token_id;
>         bool roc_grant;
> +
> +       /* ROC rate limiting to prevent MCU overload during rapid reconne=
ction
> +        * cycles (e.g., MLO authentication failures causing repeated ROC=
).
> +        */
> +       u8 roc_timeout_count;           /* consecutive ROC timeouts */
> +       unsigned long roc_last_timeout; /* jiffies of last timeout */
> +       unsigned long roc_backoff_until;/* don't issue ROC until this tim=
e */
>  };
>
>  struct mt792x_irq_map {
> --
> 2.52.0
>

