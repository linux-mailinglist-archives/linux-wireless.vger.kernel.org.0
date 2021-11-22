Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF50458DCB
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 12:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbhKVLvC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 06:51:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:33714 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239414AbhKVLvB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 06:51:01 -0500
Received: by mail-il1-f200.google.com with SMTP id c17-20020a92b751000000b0027392cd873aso10262090ilm.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 03:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=h3Lpre+VmeeOi8jOAw/w4zZTa1s6SBF77qSq/7dLtkY=;
        b=eRpYgFcnu6jVqD5yXGKX1LdB2wWhyWaTAx9okXsWLuyEwmr9oTY1W55+AQYQ4QpArO
         ztnBvVLWHnGq/nES5MnJNNWlhILCwFjljAiRVjIZxvI9/PY2DDizjzmYnCpZ9pbDEgSC
         J4WOCdU4Lbvw5cpVmKMYT7/WKEXNaPRSILB3Omeo+NGl3bxl/tV4Fjsg+GaWIyVQCPbg
         szmFORU7il574FNyGONtk2SJhNnC6z0WPQEbqpnEObaD0B8vAKYZfX9Q9BHmwDYX9fWk
         Qlx2d4xHJXpqjbNTRaDmks3pOXj8RVJn/G7/ztZqtF1WKl3W7Rm15VtiwHOYR+ebpETZ
         FZiw==
X-Gm-Message-State: AOAM533wc0yUXxVTig85DblfDOL3KBwSzfMEJTOOWtUgVuFrNd8aO/gZ
        rVH6IPII2tX+OauTK4/cGrwpinLZ2tWW+b2bMPRSYyd2hS7G
X-Google-Smtp-Source: ABdhPJxsS+DH/pc7U4/093cVEDmgazrYHYAz4al52L1nerB0WX/LkyVGsAFQYc2BUQowpmaJGpGpoC7P1M2lGSdRIwzAPd8V7aC7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e2:: with SMTP id l2mr6073585iln.251.1637581675316;
 Mon, 22 Nov 2021 03:47:55 -0800 (PST)
Date:   Mon, 22 Nov 2021 03:47:55 -0800
In-Reply-To: <20211122124737.dad29e65902a.Ieb04587afacb27c14e0de93ec1bfbefb238cc2a0@changeid>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c4c1805d15f320b@google.com>
Subject: Re: [PATCH] mac80211: track only QoS data frames for admission control
From:   syzbot <syzbot+614e82b88a1a4973e534@syzkaller.appspotmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Johannes Berg <johannes.berg@intel.com>
>
> For admission control, obviously all of that only works for
> QoS data frames, otherwise we cannot even access the QoS
> field in the header.
>
> Syzbot reported (see below) an uninitialized value here due
> to a status of a non-QoS nullfunc packet, which isn't even
> long enough to contain the QoS header.
>
> Fix this to only do anything for QoS data packets.
>
> #syz: test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git master

This crash does not have a reproducer. I cannot test it.

> Reported-by: syzbot+614e82b88a1a4973e534@syzkaller.appspotmail.com
> Fixes: 02219b3abca5 ("mac80211: add WMM admission control support")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/mac80211/mlme.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 54ab0e1ef6ca..37f7d975f3da 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -2452,11 +2452,18 @@ static void ieee80211_sta_tx_wmm_ac_notify(struct ieee80211_sub_if_data *sdata,
>  					   u16 tx_time)
>  {
>  	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
> -	u16 tid = ieee80211_get_tid(hdr);
> -	int ac = ieee80211_ac_from_tid(tid);
> -	struct ieee80211_sta_tx_tspec *tx_tspec = &ifmgd->tx_tspec[ac];
> +	u16 tid;
> +	int ac;
> +	struct ieee80211_sta_tx_tspec *tx_tspec;
>  	unsigned long now = jiffies;
>  
> +	if (!ieee80211_is_data_qos(hdr->frame_control))
> +		return;
> +
> +	tid = ieee80211_get_tid(hdr);
> +	ac = ieee80211_ac_from_tid(tid);
> +	tx_tspec = &ifmgd->tx_tspec[ac];
> +
>  	if (likely(!tx_tspec->admitted_time))
>  		return;
>  
> -- 
> 2.33.1
>
