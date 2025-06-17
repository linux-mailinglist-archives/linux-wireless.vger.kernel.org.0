Return-Path: <linux-wireless+bounces-24190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477E0ADC55A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376123A6702
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6F8291166;
	Tue, 17 Jun 2025 08:49:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB51028FABE
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150173; cv=none; b=Bqu5JZtBmfbs/qeNI/q1TIOE+GRqCjcBIrTwJgMlGm1jPO7VfnGr2KZIBjhtDHnQ6gGbXT4RLHVWM0j0Og7GuwcRuDCjYYqgfj9qOMep82z0nk7WndVjRRAnuvy3U+6QdZ65synzC+0hUksKa43DdqF71r/Hj5likLxWB6ln/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150173; c=relaxed/simple;
	bh=Zb0FAtKn57hylXZbbwWlQKoYiVchTs5O181iCBXBun0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=NHpolIxYPhtOKQ9O7fz4sQ2lHm/1J2ALVlLSKdMxyyOx2Sx7QcAnsN23tGq89tcvFxqB6H+aBP+WmyK8cllHO1B+kfFdVHcQGkWKMsJxxvdWQZeSUQSMGDQCgDxZjxlb+uHsn2oRn95XOszfntBTQI3oufbcW+a1nqPD1lQIesA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddbd339f3dso58876955ab.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 01:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750150170; x=1750754970;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W442XvOuTnKTzRsQQgphpGuH6koS5hmx6kx/lqAmOV8=;
        b=cYWzG3eJKl7LyuNujb0AU1/mXeOIkOFAXdIe/ABkrzFfIv/R7GAYZ+IihAbWfs4ONg
         8dRJ9Do0c2NiGY86QVbMaJlmW1n1xUuAlJ9nN1YQhIorXp9ROSQCCn/4bk/x0HE5CeRO
         rb0TcNzqrlOgKFdANpDaDhkaF88LdyB8ZgIf4byf+De+fjMGygeYcAM+sK5A0HdTTCws
         H860ilXbd6RFtFV3Esg9zf2rOJRyAaOSQHLF+BN6cttyeOxTiJFkgTG5OeU7FwoQvzat
         weVRXU2f9RPY8cBgL3dZTYLakXI2wPSmRvltRTNB9+Gjeahrb85A4CJuURYTSI7o4N2i
         7syg==
X-Forwarded-Encrypted: i=1; AJvYcCWjmrh9fexzjSueXFZD85OiA/E9QUKRF2qAYXnQ+B9AaI+ieUct07mw3c71xJW811OxkRE2I1Cd61FPl5KkGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhM+2xLXp7HDIJYTB1wgIMMvZukz/XxcqFBTWtricsWBuNCDSf
	qeFyMMHzQeggnHoCm/x0tX6ZnmcNEZcQeXOLhtepWqW4EVefNWWXPgTs/jiDWJw3JTeWt87ZpTV
	wlp/jqTEuM2vcphC/3BoOTq+FYqibf54BAHUkJcpkJWL3/O6WrKR00xQz9u4=
X-Google-Smtp-Source: AGHT+IGvySCvRhjncevfuunYrJFN5T2vtn5B4bWW43XiuECltLl/7W0DgszhIuN7hV2wTxEYWN2zDUU5IjKQyZfhLL/drmW0e3JA
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:3dd:d653:5a05 with SMTP id
 e9e14a558f8ab-3de07d01da0mr148791545ab.3.1750150169938; Tue, 17 Jun 2025
 01:49:29 -0700 (PDT)
Date: Tue, 17 Jun 2025 01:49:29 -0700
In-Reply-To: <20250617104902.146e10919be1.I85f352ca4a2dce6f556e5ff45ceaa5f3769cb5ce@changeid>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68512c19.050a0220.2608ac.0014.GAE@google.com>
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

