Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734D81FC8D
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 00:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfEOWYq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 18:24:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36158 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfEOWYq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 18:24:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id c3so1595519otr.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2019 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXM509T5Ix9zp+/0yCHBKAbzDcetcmqfYqZzPBVSTQM=;
        b=T7SOABmQH0gtOfqOhfQoEc+lfzg8LAya9p24FLlEqJKNYQyJPY1LPjYQkJKwxfKHVs
         zjzjd+E+dFHoWaIGcK1c0EHBgVQmcyVUv7lrm632XWYL1wjinLdFy948M4KjywVAfi9E
         b5ptJQDggAjUdfIAji78D7ozhYPKrCDfhn2X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXM509T5Ix9zp+/0yCHBKAbzDcetcmqfYqZzPBVSTQM=;
        b=lunATZcQQK4A+XxuFMv3xKPRWky084wJnX8tR+6u+09leTXgQyWz1KL80xJQWOgyvb
         M1IHmSmqqhVbUsaL462OciQxuaNt6Avpbti50vBkc1J+hrXfcRXlKlL73NiU0nwlbj/1
         qwt5k4QYiPSeGcyNZPLwTLZgcIXwMlV9JFLJO4tdXW8oV8R3vCY8XuF17d+FmX3ZTNbW
         Yvx8urMLuOJ5dYOi1WZyeQbk+4lGjmnORUg/EFJmwZZ3Gput3E56m9BntY0ZHrwonK5p
         3VARlppCix/mFXogI1Tz7s5M5Lg9zxK4ZGxQS0VWyUiWl1dXDC9APTOj4sXOeTi+TKik
         v+ag==
X-Gm-Message-State: APjAAAWziRy/7jP6q5dzBX8B6DuOZ8Niz2/HAPRCYY+Vrz2+Pm8Xs1Vg
        jlXBc8oVKVgD4SbONmFV7c3c48jRDe8DfffXuzsQm+Tj2ek=
X-Google-Smtp-Source: APXvYqyKyZ417LBwlwI2jM+9HYP8eIdQ5noN21JoxjTSFWa7RrFp4GjS28EY5Z4PYkTHn/qtNM5s7BPX4NW1SMvtEE8=
X-Received: by 2002:a9d:6954:: with SMTP id p20mr6500375oto.337.1557959085233;
 Wed, 15 May 2019 15:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <1557958906-1432-1-git-send-email-thomas@eero.com>
In-Reply-To: <1557958906-1432-1-git-send-email-thomas@eero.com>
From:   Thomas Pedersen <thomas@eero.com>
Date:   Wed, 15 May 2019 15:24:33 -0700
Message-ID: <CADjYELxD=2QQgEK+PhSSvCoj_ybBwZdaT5dp1rKroGdjSPfy3g@mail.gmail.com>
Subject: Re: [PATCH] mac80211: mesh: fix RCU warning
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Peter Oh <peter.oh@bowerswilkins.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 15, 2019 at 3:21 PM Thomas Pedersen <thomas@eero.com> wrote:
>
> ifmsh->csa was being dereferenced without the RCU read
> lock held.
>
> fixes the following warning:
>
> [   74.930435] =============================
> [   74.932066] WARNING: suspicious RCU usage
> [   74.933671] 4.20.13 #5 Tainted: G        W
> [   74.935804] -----------------------------
> [   74.937427] net/mac80211/mesh.c:1218 suspicious rcu_dereference_check() usage!
> [   74.940473] other info that might help us debug this:
> [   74.943654] rcu_scheduler_active = 2, debug_locks = 1
> [   74.946311] 5 locks held by kworker/u8:3/107:
> [   74.948087]  #0: 000000007623c1f0 ((wq_completion)"%s"wiphy_name(local->hw.wiphy)){+.+.}, at: process_one_work+0x1a2/0x610
> [   74.952464]  #1: 00000000077b4215 ((work_completion)(&sdata->csa_finalize_work)){+.+.}, at: process_one_work+0x1a2/0x610
> [   74.957228]  #2: 00000000e02b12da (&wdev->mtx){+.+.}, at: ieee80211_csa_finalize_work+0x2f/0x90
> [   74.959870]  #3: 00000000e6855095 (&local->mtx){+.+.}, at: ieee80211_csa_finalize_work+0x47/0x90
> [   74.962937]  #4: 00000000bb5e3bca (&local->chanctx_mtx){+.+.}, at: ieee80211_csa_finalize_work+0x51/0x90

Sorry the commit message is a little out of date, I actually tested on
5.1.0-rc7-wt as well.

> Signed-off-by: Thomas Pedersen <thomas@eero.com>
> ---
>  net/mac80211/mesh.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
> index 766e5e5..70aeb34 100644
> --- a/net/mac80211/mesh.c
> +++ b/net/mac80211/mesh.c
> @@ -1220,10 +1220,12 @@ int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata)
>         ifmsh->chsw_ttl = 0;
>
>         /* Remove the CSA and MCSP elements from the beacon */
> +       rcu_read_lock();
>         tmp_csa_settings = rcu_dereference(ifmsh->csa);
>         RCU_INIT_POINTER(ifmsh->csa, NULL);
>         if (tmp_csa_settings)
>                 kfree_rcu(tmp_csa_settings, rcu_head);
> +       rcu_read_unlock();
>         ret = ieee80211_mesh_rebuild_beacon(sdata);
>         if (ret)
>                 return -EINVAL;
> --
> 2.7.4
>


-- 
thomas
