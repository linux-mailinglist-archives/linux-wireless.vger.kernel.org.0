Return-Path: <linux-wireless+bounces-24193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E954ADC563
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679291894A8D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F89293B63;
	Tue, 17 Jun 2025 08:49:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEFA290083
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150174; cv=none; b=CEmuMayrTjSD+UBb324A+j89v9MD2FbwTWapHY9z4OZYV1Oc35XpM/5Tr2aMWSVEFFkVpdSbgvrR88Gup5yXbvqY9v2vbYKfSWfq1om3feevqTDJyNiNkITtX7rE8IC6O+l1WSlt4Ft3Y+uFV+m8POKNfEHGzzUPw7rDd2O9HO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150174; c=relaxed/simple;
	bh=Zb0FAtKn57hylXZbbwWlQKoYiVchTs5O181iCBXBun0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Cij9Jt3ozOmwakGDutz9CtJqAMqrej6M5xHnkjEsf5MzO0ZsxEUl+st4FRz45pyIQRJCT7DNbrFI+sD/fyD4/KDlCIlpAjFa0Toa9SASd7VE9fpT//xIHe95dRC707v/X4IDXEpL0Nktbm+jt3TuOKqJ3obGcyVI8pRuLz2mOFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddcc7e8266so65920685ab.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 01:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750150170; x=1750754970;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W442XvOuTnKTzRsQQgphpGuH6koS5hmx6kx/lqAmOV8=;
        b=M1kucHN6WaHnKx4UW75U9L4Jb3ExUOMll4vRztq35E5wPcneDEkEtAG+sVdBOTH3dR
         EK1h8PcYuMs8O2UbUwzHN1Cv1IY4I2hE3/IDtCSKZquC2K6UB39wOijELCy5yJ2YFaAf
         XwaISQsHbgmJkyBRcqK7+iVfL8cVM+sE5+RiPLhyVLXg20l7X9/cNajc5YEDmZYK5Xcy
         2Ukhk53eK6TPawm0FXKMZcHvFeit3zEVf41Kvun6k1jQNkM4Ie8nJ9zASvW1mMzKbKXF
         v/x9M1yrZZ1s7p0kjL3WV43OgZwlLIsSyXM+UgmNqYzAP12TRZfDHkoucFMSUCpjFe7J
         AXeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt2yLNcoRKpLtZ/L46jk5o9AsSUBybW7K5ctMrErjeqnLlJWbQLotFMBjKgf4IQ/fVevc3P/SkJzLcGEbgtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpkfqcxyjwYAX/Cr7/HEpnVpCTuqXMisB11IlyMwS0TyCLkKmo
	697WMzgp2f5FKNNXvdzlN12EKMpLW2X+Fc+H608f8F//BslWQS0SIKwOIpfscI4C6Yqzdh2YxOY
	McxZgF2EQVBo6PTOxc+Z6SJ4CddP/L7XexyDOqzQ7uMtx359l0P1hiO4FH4w=
X-Google-Smtp-Source: AGHT+IGAu21FMDEJyBQU4DF023V1RuA0o7K5LoA+qdssp0spmapsA51hAMFStS3+SmMiuhnPpjK1z+Joppr6M4B252hMrt1Ki8rR
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c25:b0:3dc:875e:ed8d with SMTP id
 e9e14a558f8ab-3de07b16577mr124141745ab.4.1750150169940; Tue, 17 Jun 2025
 01:49:29 -0700 (PDT)
Date: Tue, 17 Jun 2025 01:49:29 -0700
In-Reply-To: <20250617104902.146e10919be1.I85f352ca4a2dce6f556e5ff45ceaa5f3769cb5ce@changeid>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68512c19.a70a0220.395abc.020d.GAE@google.com>
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

