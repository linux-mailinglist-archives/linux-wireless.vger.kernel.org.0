Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0715F35917B
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 03:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhDIBci (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 21:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIBci (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 21:32:38 -0400
Received: from mail-qv1-xf62.google.com (mail-qv1-xf62.google.com [IPv6:2607:f8b0:4864:20::f62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36BDC061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 18:32:25 -0700 (PDT)
Received: by mail-qv1-xf62.google.com with SMTP id bs7so1420775qvb.12
        for <linux-wireless@vger.kernel.org>; Thu, 08 Apr 2021 18:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5tMkEaIx1BRtRrp8ezLQPqg1hZvgFv5MMyk2qNjviBo=;
        b=IOOHn+wrUT9pYG/aetruqaFSSF+EU92KFhczZD31idONVQAVMgJqnrz076zeNRLB6o
         uFZq/Yso0oEAp78eW0BymB1Ejzr6JQHw6osVq9KBrtQW6wDwZPe+DjOzeDAwFJrAHX7y
         DlMeqAyq0xdxTbMf4yeXqTuXmSLDjuOPHlB+vZufvLDPa2yBMWqurT5/fzjXlEfzjymL
         jco5bQA93/Nsar2WsmD5k33eZR4XlVyg+7TFac79NDdfg8YqorqEQ1vnM9N874edu6sQ
         iI6w1Ru79DN9Hr56WHc7p7obu+g0Na06Q0UAukgw/ajeimOgG5lrJLcl7H2+qn+OqznF
         AHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5tMkEaIx1BRtRrp8ezLQPqg1hZvgFv5MMyk2qNjviBo=;
        b=cMW3R46/vi4jJ8dLFupUljR6Gga509sHxIkce+XMMwDn0fvKKZcyIw+nLRvlTd+oMn
         HyGukL9Os0ZWQdUnC/mIou7jdvoAxp9PKtj/LLPD+XS56aKtrcMDvrSzNbJXM08+OqRE
         xdbrlcV25r515VNadIb2LN64bhAtPKkv3TCAgJX3+1VJ1z4RcKY3xeswoVeP9se0RQ1p
         dzS2J1LfuEVyISdUTqGLFHXwBg0G8yuhBRGQPN/d0YCLCjDWvU44NGwka2rWph6CcxrO
         5uBWLjcV8uq47oo/4bbVZi2nmJwTG85//XPNXMzWbkbLC68ECNBmlZB3K2tm2mAEjIYB
         KpiQ==
X-Gm-Message-State: AOAM532aUit4FTreCSGsABwQeb5jzNXrxK2K4RemefQ2BtiNgT3Y9/4H
        ztnFtqHM0ytuMWCg9DzGZApSyK+B4Tc7i1gp8yvDoOESNTetkQ==
X-Google-Smtp-Source: ABdhPJy26WIYOrz+2S0nhJWKBP26qIsNKn0oXs7SRySZU11Cmd5KGQErVndwg1DNvO/HPLdZKwc0+8WpCUIL
X-Received: by 2002:a05:6214:134a:: with SMTP id b10mr4980366qvw.62.1617931945101;
        Thu, 08 Apr 2021 18:32:25 -0700 (PDT)
Received: from bdawood (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp-relay.gmail.com with ESMTPS id r15sm507151qkp.8.2021.04.08.18.32.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Apr 2021 18:32:25 -0700 (PDT)
X-Relaying-Domain: morsemicro.com
Date:   Fri, 9 Apr 2021 11:32:19 +1000
From:   Bassem Dawood <bassem@morsemicro.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: Enable power save after receiving NULL packet
 ACK
Message-ID: <20210409013218.GE9075@bdawood>
References: <20210227055815.14838-1-bassem@morsemicro.com>
 <9282f2d2c6c8302de0c53dfb90743bd97e5a5a32.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9282f2d2c6c8302de0c53dfb90743bd97e5a5a32.camel@sipsolutions.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 08, 2021 at 03:26:06PM +0200, Johannes Berg wrote:
> On Sat, 2021-02-27 at 16:58 +1100, Bassem Dawood wrote:
> > Trigger dynamic_ps_timer to re-evaluate power saving once a null function
> > packet (with PM = 1) is ACKed.
> 
> Can you please say what this fixes/why the change is needed?
> 
> johannes
> 

Sure.

For drivers that declare PS_NULLFUNC_STACK, when sleeping, mac80211 would send a nullfunc (with PS bit set). It won't notify the driver yet (waiting for the NULLFUNC ACK).


a/net/mac80211/mlme.c: void ieee80211_dynamic_ps_enable_work(struct work_struct *work) 

	if (ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK) &&
	    !(ifmgd->flags & IEEE80211_STA_NULLFUNC_ACKED)) {
		if (drv_tx_frames_pending(local)) {
			mod_timer(&local->dynamic_ps_timer, jiffies +
				  msecs_to_jiffies(
				  local->hw.conf.dynamic_ps_timeout));
		} else {
			ieee80211_send_nullfunc(local, sdata, true);
			/* Flush to get the tx status of nullfunc frame */
			ieee80211_flush_queues(local, sdata, false);
		}
	}

	if (!(ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS) &&
	      ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK)) ||
	    (ifmgd->flags & IEEE80211_STA_NULLFUNC_ACKED)) {
		ifmgd->flags &= ~IEEE80211_STA_NULLFUNC_ACKED;
		local->hw.conf.flags |= IEEE80211_CONF_PS;
		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
	}

On reception of the ACK, mac80211 will set the  IEEE80211_STA_NULLFUNC_ACKED flag, but won't re-evaluate dynamic_ps_enable_work. So drivers won't get notified to sleep (until ieee80211_dynamic_ps_enable_work is re-evaluated through any other path).

a/net/mac80211/status.c:static void __ieee80211_tx_status(struct ieee80211_hw *hw,
				  struct ieee80211_tx_status *status,
				  int rates_idx, int retry_count) 

	if (ieee80211_is_any_nullfunc(fc) &&
	    ieee80211_has_pm(fc) &&
	    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS) &&
	    !(info->flags & IEEE80211_TX_CTL_INJECTED) &&
	    local->ps_sdata && !(local->scanning)) {
		if (info->flags & IEEE80211_TX_STAT_ACK) {
			local->ps_sdata->u.mgd.flags |=
					IEEE80211_STA_NULLFUNC_ACKED;
		} else
			mod_timer(&local->dynamic_ps_timer, jiffies +
					msecs_to_jiffies(10));
	}

This change makes sure  ieee80211_dynamic_ps_enable_work is evaluated once a NULLFUNC is ACKED for a more conssitent notification of the driver.

Regards,
Bassem
