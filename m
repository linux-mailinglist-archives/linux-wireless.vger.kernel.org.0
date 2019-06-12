Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A388A42C6B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 18:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440275AbfFLQe7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 12:34:59 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33456 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438250AbfFLQe7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 12:34:59 -0400
Received: by mail-it1-f193.google.com with SMTP id v193so5158772itc.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Mhrmu7ANLynrFAwomC5nV6Kvu395sgmRbmqA4wipUw=;
        b=pApSugJBQb4mOg4taoJjqnVLFy4QHgnijz4cpkN33bj5GopPF592uKAD3tF6FoTTMw
         VeEbr1PWPJNXVIz951CzxoXQEK7LnrZ5hkEBNc9da433JdD5JhuMGAE5X3Rn6rsie5dP
         Oy5lrbgIbdB7WtF6R3GS0z5p0BxBbM/qBZ9MktxwtqTCdc/uyA8SIxR2YlE/fWdHIGVY
         AcsU3Zn+KOMSn4Eu5qDkfsQsUdXWfTUsp6jA303yowzFGVcLVhbOlrqTHQjgEDDYtR6m
         e1vcaTWF1d3HFzQLwODt90mqX2aEoW7+TfKwkGUKB2KW+FJ4Q1cjlYC/Xzc+O1p/XhI9
         AKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Mhrmu7ANLynrFAwomC5nV6Kvu395sgmRbmqA4wipUw=;
        b=RAWQdeO/hLNkCfMcBZtBJl3q/EhP9aZSi1fl/ZWBrBUDz6T27wJn8Ug5Vvr35cDsf/
         /DiO8q/K1gEYqM8hTeuk9f75YdxsjqEVwpzTOZTz1neJGCVV1mjxB01l5w67bNA5p2AP
         go8OgOUZv2nXdRAiJfFGZkIujKeVEv/a5ywgEoMU3JDsa1YuvJH2RyeZh5nUIu3orsUI
         zInBsvk0DP4Hsv9WkK4xo+jhwiyrapRng7RfToGtGfv/WqGl5I8fx9vAQOlpPbZh7q1W
         9eHougGZkNqfkKh9nrmzxnkT9HC7beM+okjKneCdP9Ko+10ZFamBWX3q0OUOcnWbvVax
         QVig==
X-Gm-Message-State: APjAAAVP+Dqb2AUJ8u/88Oo9pa5Yj5eC9i9AMsMu+3rhTSYpKUizXuaa
        1xrz2W7Xbfu81xZdry/pAsmiMlNq+Zk=
X-Google-Smtp-Source: APXvYqxCBtaRUZmftKoBiKLRUUPq6jJpjplSuQVcrDzIw29zgEL+YnVV4yZZK0jcJsf/s/vSO6n1Dw==
X-Received: by 2002:a02:70d6:: with SMTP id f205mr40851639jac.138.1560357298610;
        Wed, 12 Jun 2019 09:34:58 -0700 (PDT)
Received: from hash ([2607:fea8:5ac0:1dd8:230:48ff:fe9d:9c89])
        by smtp.gmail.com with ESMTPSA id b188sm133239itc.19.2019.06.12.09.34.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 09:34:58 -0700 (PDT)
Received: from bob by hash with local (Exim 4.92)
        (envelope-from <me@bobcopeland.com>)
        id 1hb6DB-00044z-9o; Wed, 12 Jun 2019 12:34:57 -0400
Date:   Wed, 12 Jun 2019 12:34:57 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Sven Eckelmann <seckelmann@datto.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/3] ath11k: register HE mesh capabilities
Message-ID: <20190612163457.GB4090@localhost>
References: <20190611180247.19524-1-sven@narfation.org>
 <20190611180247.19524-4-sven@narfation.org>
 <1919330.hVZVHELXip@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1919330.hVZVHELXip@bentobox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 11, 2019 at 09:52:20PM +0200, Sven Eckelmann wrote:
> On Tuesday, 11 June 2019 20:02:47 CEST Sven Eckelmann wrote:
> [...]
> > ---
> > This doesn't work currently as expected. No HE rates are used between
> > the two HE mesh peers:
> [...]
> 
> There seems to be also an ordering problem. ath11k_peer_assoc_h_he is only 
> called before ieee80211_he_cap_ie_to_sta_he_cap is called. So ath11k_bss_assoc 
> will not have the information whether the remote has HE support or not.
> 
> Looks like I have adjust mesh_sta_info_init to get this somehow to 
> ath11k_peer_assoc_h_he. Maybe through ath11k_sta_rc_update but this is not 
> called by mesh_sta_info_init at the moment. Just because 
> rate_control_rate_init is called and not rate_control_rate_update.
> 
> The easiest method seems to adjust the check at the end of mesh_sta_info_init 
> to 
> 
> 	if (!test_sta_flag(sta, WLAN_STA_RATE_CONTROL) &&
> 	    !ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL)) {
> 		rate_control_rate_init(sta);
> 	} else {
> 		rate_control_rate_update(local, sband, sta, changed);
> 	}

Maybe we should just do this?

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 76f303fda3ed..6f8bde840bb9 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -42,7 +42,7 @@ void rate_control_rate_init(struct sta_info *sta)
 	ieee80211_sta_set_rx_nss(sta);
 
 	if (!ref)
-		return;
+		goto out;
 
 	rcu_read_lock();
 
@@ -59,6 +59,7 @@ void rate_control_rate_init(struct sta_info *sta)
 			    priv_sta);
 	spin_unlock_bh(&sta->rate_ctrl_lock);
 	rcu_read_unlock();
+out:
 	set_sta_flag(sta, WLAN_STA_RATE_CONTROL);
 }


That was my intent, anyway -- that NSS always got set before
rate_control_rate_update() even if using HW rate control.

> 	if (!test_sta_flag(sta, WLAN_STA_RATE_CONTROL))
> 		rate_control_rate_init(sta);
> 
>    /* inform drivers about changes */
> 	rate_control_rate_update(local, sband, sta, changed);
> 
> Both will at least cause a call to ath11k_peer_assoc_prepare + 
> ath11k_wmi_send_peer_assoc_cmd but unfortunately the ath11k firmware hangs 
> afterwards.

I think this would be OK.

-- 
Bob Copeland %% https://bobcopeland.com/
