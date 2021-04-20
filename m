Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE6B3651B0
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Apr 2021 06:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhDTE7R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Apr 2021 00:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhDTE7Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Apr 2021 00:59:16 -0400
Received: from mail-ot1-x363.google.com (mail-ot1-x363.google.com [IPv6:2607:f8b0:4864:20::363])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BFEC06174A
        for <linux-wireless@vger.kernel.org>; Mon, 19 Apr 2021 21:58:45 -0700 (PDT)
Received: by mail-ot1-x363.google.com with SMTP id o13-20020a9d404d0000b029028e0a0ae6b4so15713972oti.10
        for <linux-wireless@vger.kernel.org>; Mon, 19 Apr 2021 21:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pWpKHX8THAEOIdZg5NCOkyWurVXXxftkOCrq63r1kyM=;
        b=1vFxwjTetw3A9qVsiI81Jog6fj2UelymU7Z4lyFqHFeJ3lzqE+clBPo29MuZ8Hw1oL
         nUeM+jjocT3c/S0CFcY7Cw/Vl/wjTjQWb7cidLUqswNsHXgdJAMWMnaLKNIzTW08i9vU
         XCD39g9M7+zP7nr0nXY3O8MhkJRPgLIlS0s3ZHU05ASakaJ7+HHwesBftOLPuFt93ig5
         NtQ2MfKrEJ1CpGRFwlWQGwSlqFEUKB8e3GaCE1SfiBTbaSG6cFlWyFAw++b4dJPgtafU
         JH9u+LwwdkYmdUHDl58hQA0h7nfmAfoLJzzR/Oq3kT+WlsmNFDbtZ8ayS4xMZ6eox5W9
         aBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pWpKHX8THAEOIdZg5NCOkyWurVXXxftkOCrq63r1kyM=;
        b=mcwW5MARTyKZ2RcwKdseAtSRFcIzg54SCoB5dD4tFL9I3diZEV27885paPLJzzFZxh
         RlP+lRo3wyPiGlZuIG/mhoZYcyf8FsJkF5CxsTQt5tDksMt+j0w68G/klDziBDZS88f5
         1GVinMm+GRGjHWSBe9IG4boCH1i+Mueg6vvABn/8z4rZVv9eIX0XjomrKrLWT0nCJ0bt
         54tzCZCnxSykOiMZDUuPI039MRUk9cHv7H11SlksfjjwGHB6NplUkzvxvBb8j+BCXCRg
         ZaWiI9A7UyPsf+5tXW3FRKYbOIuvkCtv4lWSiYRehHbWBLxixp8A8kEsP6s/EMcoPD56
         iK1Q==
X-Gm-Message-State: AOAM532ysyurvXvyen5ptHRDhXAfUnFz3A2piGgGCZ8Gmr+GPXtlJoVM
        pGK4MEGtzzCP1Hq9mVD9mhaaLkYUqLu6K/kKC/MNwzuHMkLEoA==
X-Google-Smtp-Source: ABdhPJz+C2El2srtJunZs33C+WE8ak/fnONFnt0QqqDskzAP8rGbLMAq+8qcFSXzrnTfcQT1H0O8e4unXJKJ
X-Received: by 2002:a9d:d05:: with SMTP id 5mr18024877oti.312.1618894724923;
        Mon, 19 Apr 2021 21:58:44 -0700 (PDT)
Received: from bdawood (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp-relay.gmail.com with ESMTPS id v12sm380462otj.13.2021.04.19.21.58.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Apr 2021 21:58:44 -0700 (PDT)
X-Relaying-Domain: morsemicro.com
Date:   Tue, 20 Apr 2021 14:58:39 +1000
From:   Bassem Dawood <bassem@morsemicro.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: Enable power save after receiving NULL packet
 ACK
Message-ID: <20210420045838.GA16360@bdawood>
References: <20210227055815.14838-1-bassem@morsemicro.com>
 <9282f2d2c6c8302de0c53dfb90743bd97e5a5a32.camel@sipsolutions.net>
 <20210409013218.GE9075@bdawood>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409013218.GE9075@bdawood>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 09, 2021 at 11:32:19AM +1000, Bassem Fahmy wrote:
> On Thu, Apr 08, 2021 at 03:26:06PM +0200, Johannes Berg wrote:
> > On Sat, 2021-02-27 at 16:58 +1100, Bassem Dawood wrote:
> > > Trigger dynamic_ps_timer to re-evaluate power saving once a null function
> > > packet (with PM = 1) is ACKed.
> > 
> > Can you please say what this fixes/why the change is needed?
> > 
> > johannes
> > 
> 
> Sure.
> 
> For drivers that declare PS_NULLFUNC_STACK, when sleeping, mac80211 would send a nullfunc (with PS bit set). It won't notify the driver yet (waiting for the NULLFUNC ACK).
> 
> 
> a/net/mac80211/mlme.c: void ieee80211_dynamic_ps_enable_work(struct work_struct *work) 
> 
> 	if (ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK) &&
> 	    !(ifmgd->flags & IEEE80211_STA_NULLFUNC_ACKED)) {
> 		if (drv_tx_frames_pending(local)) {
> 			mod_timer(&local->dynamic_ps_timer, jiffies +
> 				  msecs_to_jiffies(
> 				  local->hw.conf.dynamic_ps_timeout));
> 		} else {
> 			ieee80211_send_nullfunc(local, sdata, true);
> 			/* Flush to get the tx status of nullfunc frame */
> 			ieee80211_flush_queues(local, sdata, false);
> 		}
> 	}
> 
> 	if (!(ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS) &&
> 	      ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK)) ||
> 	    (ifmgd->flags & IEEE80211_STA_NULLFUNC_ACKED)) {
> 		ifmgd->flags &= ~IEEE80211_STA_NULLFUNC_ACKED;
> 		local->hw.conf.flags |= IEEE80211_CONF_PS;
> 		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
> 	}
> 
> On reception of the ACK, mac80211 will set the  IEEE80211_STA_NULLFUNC_ACKED flag, but won't re-evaluate dynamic_ps_enable_work. So drivers won't get notified to sleep (until ieee80211_dynamic_ps_enable_work is re-evaluated through any other path).
> 
> a/net/mac80211/status.c:static void __ieee80211_tx_status(struct ieee80211_hw *hw,
> 				  struct ieee80211_tx_status *status,
> 				  int rates_idx, int retry_count) 
> 
> 	if (ieee80211_is_any_nullfunc(fc) &&
> 	    ieee80211_has_pm(fc) &&
> 	    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS) &&
> 	    !(info->flags & IEEE80211_TX_CTL_INJECTED) &&
> 	    local->ps_sdata && !(local->scanning)) {
> 		if (info->flags & IEEE80211_TX_STAT_ACK) {
> 			local->ps_sdata->u.mgd.flags |=
> 					IEEE80211_STA_NULLFUNC_ACKED;
> 		} else
> 			mod_timer(&local->dynamic_ps_timer, jiffies +
> 					msecs_to_jiffies(10));
> 	}
> 
> This change makes sure  ieee80211_dynamic_ps_enable_work is evaluated once a NULLFUNC is ACKED for a more conssitent notification of the driver.
> 
> Regards,
> Bassem

Hi Johannes,

Following up on this. Is the explaination clear or you need more description?

Regareds,
Bassem
