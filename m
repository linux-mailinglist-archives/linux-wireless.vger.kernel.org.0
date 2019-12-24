Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEC312A2FF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 16:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfLXPhp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Dec 2019 10:37:45 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35701 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfLXPhp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Dec 2019 10:37:45 -0500
Received: by mail-lj1-f194.google.com with SMTP id j1so13740710lja.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2019 07:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8/UFKuoDSwg/SsLw0xJhouaOBENLckWSUmxLBZ3VKcw=;
        b=NL/K055Jz2ZElHYgRZFQmYSeoBT36wzCAbj/It1T5znzoSsXK0YtD+UvL2gyIlWoty
         afBIKKXC1FQy/2yOMAlvfrHrNOe+cWrR5HMsTTOjXzGYlWyfQG31lKa9UBQA+xILKdjc
         2t40OPYZbm45DUqvQ2cdW0NEtyHCoWYcW1BuLAYVHc6RaZvOZpPBbT1iXJPy+Z6Ihie6
         4M6fNu4GTvaAVQh3GTr/WOdzbe/5O+g8fQqXDFdKy4sD74qm7xoTqVWLDZAT39+upLp8
         Rv07qoDdjUse7adxhlmt16RJhrHnhIs8FvGI1KECNkYiNy9pCck1IPf8gRZo7pLxBK5E
         hW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8/UFKuoDSwg/SsLw0xJhouaOBENLckWSUmxLBZ3VKcw=;
        b=rJetabA2qWel+hsJCU604OeCCAZclbv/XV2CuRrT2UJBFwH3RET3PV4QqWgrqisdd8
         lsF3yAJmGKwXHQljS3ldBx/cg6T7hVBFHjt51qLGDjIInAoALnGiKjyYAJuO+Cq9a9HP
         JGdGyZ68Mp4FFdcPBaVmc7oFkQwhkFWVNzLdQBbzVh2Rm2XOk6mi5z0j8LnGim4DqOyK
         zr53hOZT1eIglbTW6YFVjKp44k+HFjJ5ej5V7no95UcrOC9EdjSb4U9njECFWonMn2hf
         vSwgT5VDkzHeJoWvbzlVaKXe6AscfWBE3YPyoP5gQRSvx1CpTerbABSNAfvt6o7cB+zY
         1OBA==
X-Gm-Message-State: APjAAAWyqdD7aHlK11jh9ODkjx6FJMsz87hKyWlEuiQPTQxdjgyUo8CL
        AafVgRJnRZ/ViDK8iREXyfM=
X-Google-Smtp-Source: APXvYqxdJFpKq/P8IU1VahCjbI5h6zBjxGzhpjDAl7WgzgWTK7UuCRJSJ3DgGxSeOvWPK47VYZfhAw==
X-Received: by 2002:a2e:95c4:: with SMTP id y4mr21224097ljh.38.1577201862097;
        Tue, 24 Dec 2019 07:37:42 -0800 (PST)
Received: from bars (ip-195-182-157-78.clients.cmk.ru. [195.182.157.78])
        by smtp.gmail.com with ESMTPSA id i17sm8347430ljd.34.2019.12.24.07.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Dec 2019 07:37:41 -0800 (PST)
Date:   Tue, 24 Dec 2019 18:37:40 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Orr Mazor <orr.mazor@tandemg.com>
Cc:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] subsystem: Fix radar event during another phy CAC
Message-ID: <20191224153740.c6gybca7sulmitzq@bars>
References: <20191222145449.15792-1-Orr.Mazor@tandemg.com>
 <20191223105234.lgsupxfapbmxuvc5@bars>
 <AM6PR02MB36219B15C4F70980804728B0EF290@AM6PR02MB3621.eurprd02.prod.outlook.com>
 <20191224114241.uxfdifi2suocp2sa@bars>
 <AM6PR02MB362166B19724CB89D587751DEF290@AM6PR02MB3621.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR02MB362166B19724CB89D587751DEF290@AM6PR02MB3621.eurprd02.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> >> >> In case a radar event of CAC_FINISHED or RADAR_DETECTED happens
> >during
> >> >> another phy is during CAC we might need to cancel that CAC.
> >> >> If we got a radar in a channel that another phy is now doing CAC on
> >> >> then the CAC should be canceled.
> >> >> If, for example, 2 phys doing CAC on the same channels, or on
> >> >> comptable channels, once on of them will finish his CAC the other
> >> >> might need to cancel his CAC, since it is no longer relevant.
> >> >>
> >> >> To fix that the commit adds an callback and implement it in mac80211
> >> >> to end CAC.
> >> >> This commit also adds a call to said callback if after a radar event
> >> >> we see the cac is no longer relevant
> >> >
> >> >>  net/mac80211/cfg.c      | 23 +++++++++++++++++++++++
> >> >>  net/wireless/rdev-ops.h | 10 ++++++++++
> >> >>  net/wireless/reg.c      | 24 +++++++++++++++++++++++-
> >> >>  net/wireless/trace.h    |  5 +++++
> >> >>  5 files changed, 66 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h index
> >> >> 4ab2c49423dc..68782ba8b6e8 100644
> >> >> --- a/include/net/cfg80211.h
> >> >> +++ b/include/net/cfg80211.h
> >> >> @@ -3537,6 +3537,9 @@ struct cfg80211_update_owe_info {
> >> >>   *
> >> >>   * @start_radar_detection: Start radar detection in the driver.
> >> >>   *
> >> >> + * @end_cac: End running CAC, probably because a related CAC
> >> >> + *   was finished on another phy.
> >> >> + *
> >> >
> >> >Maybe it makes sense to follow existing naming convention here and to
> >use
> >> >something like 'stop_radar_detection' ?
> >>
> >> I think 'stop_radar_detection' might be misleading as we don’t stop
> >radar_detection,
> >> we only end cac, normal radar detection will continue.
> >
> >Ok, good point.
> >
> >
> >> >>   * @update_ft_ies: Provide updated Fast BSS Transition information to
> >the
> >> >>   *   driver. If the SME is in the driver/firmware, this information can be
> >> >>   *   used in building Authentication and Reassociation Request frames.
> >> >> @@ -3863,6 +3866,8 @@ struct cfg80211_ops {
> >> >>                                        struct net_device *dev,
> >> >>                                        struct cfg80211_chan_def *chandef,
> >> >>                                        u32 cac_time_ms);
> >> >> +     void    (*end_cac)(struct wiphy *wiphy,
> >> >> +                             struct net_device *dev);
> >> >
> >> >...
> >> >
> >> >> +static void cfg80211_check_and_end_cac(struct
> >> >> +cfg80211_registered_device *rdev) {
> >> >> +     struct wireless_dev *wdev;
> >> >> +     /* If we finished CAC or received radar, we should end any
> >> >> +      * CAC running on the same channels.
> >> >> +      * the check !cfg80211_chandef_dfs_usable contain 2 options:
> >> >> +      * either all channels are available - those the CAC_FINISHED
> >> >> +      * event has effected another wdev state, or there is a channel
> >> >> +      * in unavailable state in wdev chandef - those the RADAR_DETECTED
> >> >> +      * event has effected another wdev state.
> >> >> +      * In both cases we should end the CAC on the wdev.
> >> >> +      *
> >> >> +      */
> >> >> +     list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
> >> >> +             if (wdev->cac_started &&
> >> >> +                 !cfg80211_chandef_dfs_usable(&rdev->wiphy, &wdev-
> >> >>chandef))
> >> >> +                     rdev_end_cac(rdev, wdev->netdev);
> >> >> +     }
> >> >> +}
> >> >> +
> >> >
> >> >IIUC, this code does not match your commit message. You are stopping
> >CAC
> >> >on all the virtual wireless interfaces on the same PHY, but not CACs on
> >> >different PHYs. Meanwhile CAC does not need to be started on multiple
> >> >virtual interfaces. For instance, in multiple BSSID configuration, hostapd
> >> >performs CAC only on primary interface.
> >> >
> >>
> >> regulatory_propagate_dfs_state will call cfg80211_check_and_end_cac
> >> only on phys != current phy.
> >> So for each phy != current we will call mac80211 end_cac (if needed)
> >> which in turn will end the cac on all that phys’ interfaces.
> >
> >Ok, so regulatory_propagate_dfs_state iterates over other PHYs from the
> >same regulatory region updating state of DFS channel reported by the
> >original PHY. Unless I am missing something, in this case there are two
> >possible ways to proceed with CAC running on other PHYs:
> >
> >- to stop CAC on other PHYs with the same channel/bandwidth in both
> >  RADAR_DETECTION and CAC_FINISHED cases
> >- to stop CAC on other PHYs if their channel has just become unusable
> >  due to RADAR_DETECTION event reported by the original PHY
> >
> >So it looks like you have chosen a more conservative second option.
> >But then I don't quite understand your comment for the new function
> >cfg80211_check_and_end_cac: why do you say that CAC_FINISHED case
> >is also covered here ?
> >
> 
> CAC_FINISHED is covered here:
> If there is an unavailable channel cfg80211_chandef_dfs_usable will return false - this covers RADAR_DETECTED.
> If all channels are available cfg80211_chandef_dfs_usable will also return false,
> as they are not usable, they are available - this covers CAC_FINISHED.
> Basically cfg80211_chandef_dfs_usable checks if we need to do CAC,
> it is also used in nl80211_start_radar_detection in order to make sure we actually need CAC.

Ok, thanks for clarification. So in the end this is the first option:
CAC on other PHYs is stopped in both cases including 
RADAR_DETECTION and CAC_FINISHED.

Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

Regards,
Sergey
