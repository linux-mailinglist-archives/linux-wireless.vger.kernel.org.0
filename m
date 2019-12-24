Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E638512A0CC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 12:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfLXLmo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Dec 2019 06:42:44 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40049 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfLXLmo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Dec 2019 06:42:44 -0500
Received: by mail-lf1-f67.google.com with SMTP id i23so14901803lfo.7
        for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2019 03:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OYWduoQaPz3/fAD9SEXfgk2ycSYLzq/KSQ7h5c0MpnI=;
        b=E/U0CPsd6ckk0OVSw/vaKIlpxRtVqTxPWqpI+AlRBcxknGomVvBPu/CYPTzv8LzP1V
         HdCQcbDw6tQjgC5I9xNPY+XdQ8QFIW9wklCUTwCC9Z/5W8rYmbXsG4/O3tUa7Y3lO7YZ
         fOW8AvRT41/Vtv9u0HYWOyfXN8WR6b3UdPIAgtMM0PeDFABvlq6XbVHu0N1jIwOFe3Rh
         5iqkUZCmaGX5Z7jeqzmJ52DRE0nSEnqqa3xEDyO1Wg6rvvJC7rZyf6lC2MyM64QPS+k3
         fkehmr6xG1BP8BKPI4nPOU2C/snFOWgnZad1MKxeBlRT2lSwk8HgltKAp2exWM8dl2+h
         vZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OYWduoQaPz3/fAD9SEXfgk2ycSYLzq/KSQ7h5c0MpnI=;
        b=Q44+520/VLXzqbpVhqnqNgbM63SWAwYnpA+QxF0fUDZyMmAM+/66grYejMxhrZFQWa
         9hHSWM/Xsyfzpb4lSr7CKsH37zdaZpK5J8P7miNnnh6oDvgat44/tQ4Um5EeKjQNGkmg
         SGlFCSAqBOIWwsJyuP/v0iuD7HpYk98yONt2nk6zY3dFmV96+ejHKIyX0PUgtPq/9aTY
         Pj36pY7B9N/bdGjTZn5qUinnR9KpCa4mOi75VAiFpq1O3/tk6TPwPqg4C72yt6sq67BV
         tPfGdf2HUSNB01f4QxX2NKd1p5yHC7jj1Cvn5EuYmzJW32KzoDxKRxej5N6uQnZScRS/
         CqvA==
X-Gm-Message-State: APjAAAVdfNnwGt6w4+H1tzcEAc69nwE3VYzWSS6lg3dO3h/Jy7I/FFGb
        ikZqHJJUxPzREvJYqvuQVLJ/1Num3jE=
X-Google-Smtp-Source: APXvYqxPjwMc8ECQF/WtFhUlOfrBHKEltqsxksOC/xe4EQGP+VBwD44jPiXMPRethGsxKyWjVEdTbw==
X-Received: by 2002:a19:888:: with SMTP id 130mr20125401lfi.167.1577187762454;
        Tue, 24 Dec 2019 03:42:42 -0800 (PST)
Received: from bars (ip-195-182-157-78.clients.cmk.ru. [195.182.157.78])
        by smtp.gmail.com with ESMTPSA id y14sm9860541ljk.46.2019.12.24.03.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Dec 2019 03:42:41 -0800 (PST)
Date:   Tue, 24 Dec 2019 14:42:41 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Orr Mazor <orr.mazor@tandemg.com>
Cc:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] subsystem: Fix radar event during another phy CAC
Message-ID: <20191224114241.uxfdifi2suocp2sa@bars>
References: <20191222145449.15792-1-Orr.Mazor@tandemg.com>
 <20191223105234.lgsupxfapbmxuvc5@bars>
 <AM6PR02MB36219B15C4F70980804728B0EF290@AM6PR02MB3621.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR02MB36219B15C4F70980804728B0EF290@AM6PR02MB3621.eurprd02.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Orr,

Thanks for detailed use-case clarification.

> >> In case a radar event of CAC_FINISHED or RADAR_DETECTED happens during
> >> another phy is during CAC we might need to cancel that CAC.
> >> If we got a radar in a channel that another phy is now doing CAC on
> >> then the CAC should be canceled.
> >> If, for example, 2 phys doing CAC on the same channels, or on
> >> comptable channels, once on of them will finish his CAC the other
> >> might need to cancel his CAC, since it is no longer relevant.
> >>
> >> To fix that the commit adds an callback and implement it in mac80211
> >> to end CAC.
> >> This commit also adds a call to said callback if after a radar event
> >> we see the cac is no longer relevant
> >
> >>  net/mac80211/cfg.c      | 23 +++++++++++++++++++++++
> >>  net/wireless/rdev-ops.h | 10 ++++++++++
> >>  net/wireless/reg.c      | 24 +++++++++++++++++++++++-
> >>  net/wireless/trace.h    |  5 +++++
> >>  5 files changed, 66 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h index
> >> 4ab2c49423dc..68782ba8b6e8 100644
> >> --- a/include/net/cfg80211.h
> >> +++ b/include/net/cfg80211.h
> >> @@ -3537,6 +3537,9 @@ struct cfg80211_update_owe_info {
> >>   *
> >>   * @start_radar_detection: Start radar detection in the driver.
> >>   *
> >> + * @end_cac: End running CAC, probably because a related CAC
> >> + *   was finished on another phy.
> >> + *
> >
> >Maybe it makes sense to follow existing naming convention here and to use
> >something like 'stop_radar_detection' ?
> 
> I think 'stop_radar_detection' might be misleading as we don’t stop radar_detection, 
> we only end cac, normal radar detection will continue. 

Ok, good point.


> >>   * @update_ft_ies: Provide updated Fast BSS Transition information to the
> >>   *   driver. If the SME is in the driver/firmware, this information can be
> >>   *   used in building Authentication and Reassociation Request frames.
> >> @@ -3863,6 +3866,8 @@ struct cfg80211_ops {
> >>                                        struct net_device *dev,
> >>                                        struct cfg80211_chan_def *chandef,
> >>                                        u32 cac_time_ms);
> >> +     void    (*end_cac)(struct wiphy *wiphy,
> >> +                             struct net_device *dev);
> >
> >...
> >
> >> +static void cfg80211_check_and_end_cac(struct
> >> +cfg80211_registered_device *rdev) {
> >> +     struct wireless_dev *wdev;
> >> +     /* If we finished CAC or received radar, we should end any
> >> +      * CAC running on the same channels.
> >> +      * the check !cfg80211_chandef_dfs_usable contain 2 options:
> >> +      * either all channels are available - those the CAC_FINISHED
> >> +      * event has effected another wdev state, or there is a channel
> >> +      * in unavailable state in wdev chandef - those the RADAR_DETECTED
> >> +      * event has effected another wdev state.
> >> +      * In both cases we should end the CAC on the wdev.
> >> +      *
> >> +      */
> >> +     list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
> >> +             if (wdev->cac_started &&
> >> +                 !cfg80211_chandef_dfs_usable(&rdev->wiphy, &wdev-
> >>chandef))
> >> +                     rdev_end_cac(rdev, wdev->netdev);
> >> +     }
> >> +}
> >> +
> >
> >IIUC, this code does not match your commit message. You are stopping CAC
> >on all the virtual wireless interfaces on the same PHY, but not CACs on
> >different PHYs. Meanwhile CAC does not need to be started on multiple
> >virtual interfaces. For instance, in multiple BSSID configuration, hostapd
> >performs CAC only on primary interface.
> >
> 
> regulatory_propagate_dfs_state will call cfg80211_check_and_end_cac
> only on phys != current phy.
> So for each phy != current we will call mac80211 end_cac (if needed)
> which in turn will end the cac on all that phys’ interfaces.

Ok, so regulatory_propagate_dfs_state iterates over other PHYs from the
same regulatory region updating state of DFS channel reported by the
original PHY. Unless I am missing something, in this case there are two
possible ways to proceed with CAC running on other PHYs:

- to stop CAC on other PHYs with the same channel/bandwidth in both
  RADAR_DETECTION and CAC_FINISHED cases
- to stop CAC on other PHYs if their channel has just become unusable
  due to RADAR_DETECTION event reported by the original PHY

So it looks like you have chosen a more conservative second option.
But then I don't quite understand your comment for the new function
cfg80211_check_and_end_cac: why do you say that CAC_FINISHED case
is also covered here ?


Regards,
Sergey
