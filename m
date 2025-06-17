Return-Path: <linux-wireless+bounces-24195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CED0ADC561
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51BB165694
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0BA293C44;
	Tue, 17 Jun 2025 08:49:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3028FFF3
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150174; cv=none; b=q8dCRLU+kBBv++5YYaMyEaLbf2+PvpjIy5itWMuyadHW42CTqEifjo3QyF7cvVMH59o6Nlvstjlvrar+fu4reEHnEQFAB4FYgN4Ysn0lAnv5vew4HnYZNeA8iui6Dz32P98doMZsufZVt3sl4DDQPA+5pU7sWvaxKUvSiQp26pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150174; c=relaxed/simple;
	bh=Zb0FAtKn57hylXZbbwWlQKoYiVchTs5O181iCBXBun0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ie6lIGe5beBu3jlrLcFRlgr9+Eg5VSuEMG+smbwlQTDl0weAfP34zFjgzaQDhfV1upDxyT+W65OcfYSuTwcErj2gaghjY+LJYNqO9mAinr3WzyPtm9hjv33SUO+Hhk8yz+viPv1BevLNCHpUUWMYbMIHsSo0o4wEtPh2qRZOqKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddcc14b794so35633095ab.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 01:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750150170; x=1750754970;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W442XvOuTnKTzRsQQgphpGuH6koS5hmx6kx/lqAmOV8=;
        b=saR2zduntAw9jBH6IJ2TgBuR1Kz9oDPIM4OzQ4HezaTiTQ8kBU9ZiLZIQZsYJVsoTE
         1PcoHjV15kjdeHSx79D3st0UgzCuG+kJycby1zeVRTwp2T+IT4B2xA++Ji1gnppS+5WJ
         lA3UVnL+Jvvu20dvHnP8ej2GI6gyFa+Qr7Hr5Z78T3UQh7zKaEbUsGMT+OHzu6dB8MwL
         Iph3kp7+a1mYpi/eHnTTLi+gBAqQzi/kQZa/CvzwDYWni7xL3RFQkQ8nkxTYR8nkqRO2
         TH9b2B0cHOqN82KLDeIXgA7g4RNYYEYysZWuMc3ystXChvulW+5lU2o/qT/q8IJKaRaR
         hYHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX80rZzKVncwbi3dptCwLMKW+D8EW5RyyzEV+ipI52dei5vSsMWL9C8TkPVtVWeNz/nHMWLlRqrnhprcbX43w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0U6XcH0SjLZixHAwZ1+I6mw5miAtee/p3LWk2l1CpCmn7lRQy
	1+yIF6oNF5nyunn8A3fk55D4Q0WLCURGWMTtfZC7F5H4xOgP2sj8u7lZ1nyF3cXPoHRzYNp29mS
	0JmXnf8oQsxuLwfxfC37YwFmIIUx0bVc1Arzu+fTO2SKUMLLtXUGdmh3lhwA=
X-Google-Smtp-Source: AGHT+IE7SjhnqW/aUQPmgFzqARYXbsP7C8v1bPBoREOWYWln4AHxLYz387BrFlZQDcX0Jn+xm2MvQgny32eRCIBd4Lc/fPD8So9r
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:3dd:b762:ed1b with SMTP id
 e9e14a558f8ab-3de07d7ae51mr135662965ab.16.1750150169929; Tue, 17 Jun 2025
 01:49:29 -0700 (PDT)
Date: Tue, 17 Jun 2025 01:49:29 -0700
In-Reply-To: <20250617104902.146e10919be1.I85f352ca4a2dce6f556e5ff45ceaa5f3769cb5ce@changeid>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68512c19.050a0220.2608ac.0012.GAE@google.com>
Subject: Re: [PATCH wireless] wifi: mac80211: don't WARN for late
 channel/color switch
From: syzbot <syzbot+468656785707b0e995df@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net
Cc: johannes.berg@intel.com, johannes@sipsolutions.net, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> From: Johannes Berg <johannes.berg@intel.com>
>
> There's really no value in the WARN stack trace etc., the reason
> for this happening isn't directly related to the calling function
> anyway. Also, syzbot has been observing it constantly, and there's
> no way we can resolve it there - those systems are just slow.
>
> Instead print an error message (once) and add a comment about what
> really causes this message.
>
> Reported-by: syzbot+468656785707b0e995df@syzkaller.appspotmail.com
> Reported-by: syzbot+18c783c5cf6a781e3e2c@syzkaller.appspotmail.com
> Reported-by: syzbot+d5924d5cffddfccab68e@syzkaller.appspotmail.com
> Reported-by: syzbot+7d73d99525d1ff7752ef@syzkaller.appspotmail.com
> Reported-by: syzbot+8e6e002c74d1927edaf5@syzkaller.appspotmail.com
> Reported-by: syzbot+97254a3b10c541879a65@syzkaller.appspotmail.com
> Reported-by: syzbot+dfd1fd46a1960ad9c6ec@syzkaller.appspotmail.com
> Reported-by: syzbot+85e0b8d12d9ca877d806@syzkaller.appspotmail.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> #syz test

This crash does not have a reproducer. I cannot test it.

> ---
>  net/mac80211/debug.h |  5 ++++-
>  net/mac80211/tx.c    | 29 +++++++++++++++++++++--------
>  2 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/net/mac80211/debug.h b/net/mac80211/debug.h
> index 5b81998cb0c9..ef7c1a68d88d 100644
> --- a/net/mac80211/debug.h
> +++ b/net/mac80211/debug.h
> @@ -1,10 +1,11 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Portions
> - * Copyright (C) 2022 - 2024 Intel Corporation
> + * Copyright (C) 2022 - 2025 Intel Corporation
>   */
>  #ifndef __MAC80211_DEBUG_H
>  #define __MAC80211_DEBUG_H
> +#include <linux/once_lite.h>
>  #include <net/cfg80211.h>
>  
>  #ifdef CONFIG_MAC80211_OCB_DEBUG
> @@ -152,6 +153,8 @@ do {									\
>  		else							\
>  			_sdata_err((link)->sdata, fmt, ##__VA_ARGS__);	\
>  	} while (0)
> +#define link_err_once(link, fmt, ...)					\
> +	DO_ONCE_LITE(link_err, link, fmt, ##__VA_ARGS__)
>  #define link_id_info(sdata, link_id, fmt, ...)				\
>  	do {								\
>  		if (ieee80211_vif_is_mld(&sdata->vif))			\
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index d8d4f3d7d7f2..d58b80813bdd 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -5,7 +5,7 @@
>   * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
>   * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
>   * Copyright 2013-2014  Intel Mobile Communications GmbH
> - * Copyright (C) 2018-2024 Intel Corporation
> + * Copyright (C) 2018-2025 Intel Corporation
>   *
>   * Transmit and frame generation functions.
>   */
> @@ -5016,12 +5016,25 @@ static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
>  	}
>  }
>  
> -static u8 __ieee80211_beacon_update_cntdwn(struct beacon_data *beacon)
> +static u8 __ieee80211_beacon_update_cntdwn(struct ieee80211_link_data *link,
> +					   struct beacon_data *beacon)
>  {
> -	beacon->cntdwn_current_counter--;
> +	if (beacon->cntdwn_current_counter == 1) {
> +		/*
> +		 * Channel switch handling is done by a worker thread while
> +		 * beacons get pulled from hardware timers. It's therefore
> +		 * possible that software threads are slow enough to not be
> +		 * able to complete CSA handling in a single beacon interval,
> +		 * in which case we get here. There isn't much to do about
> +		 * it, other than letting the user know that the AP isn't
> +		 * behaving correctly.
> +		 */
> +		link_err_once(link,
> +			      "beacon TX faster than countdown (channel/color switch) completion\n");
> +		return 0;
> +	}
>  
> -	/* the counter should never reach 0 */
> -	WARN_ON_ONCE(!beacon->cntdwn_current_counter);
> +	beacon->cntdwn_current_counter--;
>  
>  	return beacon->cntdwn_current_counter;
>  }
> @@ -5052,7 +5065,7 @@ u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif, unsigned int link_i
>  	if (!beacon)
>  		goto unlock;
>  
> -	count = __ieee80211_beacon_update_cntdwn(beacon);
> +	count = __ieee80211_beacon_update_cntdwn(link, beacon);
>  
>  unlock:
>  	rcu_read_unlock();
> @@ -5450,7 +5463,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
>  
>  		if (beacon->cntdwn_counter_offsets[0]) {
>  			if (!is_template)
> -				__ieee80211_beacon_update_cntdwn(beacon);
> +				__ieee80211_beacon_update_cntdwn(link, beacon);
>  
>  			ieee80211_set_beacon_cntdwn(sdata, beacon, link);
>  		}
> @@ -5482,7 +5495,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
>  				 * for now we leave it consistent with overall
>  				 * mac80211's behavior.
>  				 */
> -				__ieee80211_beacon_update_cntdwn(beacon);
> +				__ieee80211_beacon_update_cntdwn(link, beacon);
>  
>  			ieee80211_set_beacon_cntdwn(sdata, beacon, link);
>  		}
> -- 
> 2.49.0
>

