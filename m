Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF245BF94D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 10:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiIUIbs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Sep 2022 04:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiIUIbn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Sep 2022 04:31:43 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3377EFD3
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 01:31:41 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so3430592otu.7
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LdfLsQzbDkIurGyxKIpF+YTKTJf6SRMX4DwgzZoBHWg=;
        b=OOKFH6VV4PfkT7wuvUJ4ouAYu4MuMTpMelF5fH2R3tS0lGACNxaefTqN2zt4Vk7VqM
         eLh7ktRefZORHQkG0dK53HszfEzKRjURSqTKmAEu7bGsjP4KRLoDxIcPXQToRzJrNmDG
         7WGntKGbOtY74r034pZGjERtqkJuk7HEwZK7Hm5RmPA1RG2x3mXxNobiiUohqjktbyH5
         2NcUiIuZ5BeKUZPZw45ewpbnhGiJqACG22O+DbiihntgBN75k6VifWc8TKBJWQ3kMoE7
         jwgWiAsYDNzK95zfAObnTccQW4RvOuv5tIpBrOTl7BJ3smPmNpDLV6g9NmiV7hgCtBU5
         OsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LdfLsQzbDkIurGyxKIpF+YTKTJf6SRMX4DwgzZoBHWg=;
        b=CvgnqypQbb0fmXU86UDufLmo42qY2wPBDMmdfet6ciMGBAlRSNNGRSXwkrXlFDtws0
         QNyxX7+tyrSAlzv13OTsO+ecWTXrcKNILlKMVgumM+aLdYDjeRgE/M/8nxIJPlccy10I
         if1xut70NE8HGgSgoOEat6GBlPbJZ6Awx3JX5A9GB2iI9dxfT2WEWmY0o3u5pE7A9lb7
         CqLkqxBqJihKydW4x7gytN7dX+7bS3dkQosyFC9gesv+9x/mQpHxt5lDmZOcvvP12SL7
         qnxlWm8uT6Xw3ZNENcE5ikaUnOCNoLgiXFkg6w0b4T0ytHaqX8b0WMXMDXggWCPc2Tmj
         9xmg==
X-Gm-Message-State: ACrzQf2yR0jGvsPRDkaIUojVME6lrZUOemZT2tdRLqjZsTCvV26Ps5vg
        Y0yUIYUVW+11iIKXDkISxZOeE6EBoxAWC0xPrzssH6ba7z8=
X-Google-Smtp-Source: AMsMyM4jpAcjbGbdqMczxcAojgQ7XQj8C77hIRymTYnpMnJCTwMyXSR8PxxKC9d+RKB6CNvllzNb4lob+NUu8/Y2dMU=
X-Received: by 2002:a05:6830:3910:b0:656:3fb5:e600 with SMTP id
 br16-20020a056830391000b006563fb5e600mr11968617otb.173.1663749100265; Wed, 21
 Sep 2022 01:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220915043527.737133-1-venkatch@gmail.com> <238a21a8-c97b-5a38-6c08-9057055bf73f@nbd.name>
 <CABHL29H75U-0dBP14d-6ds-xMPt1eqrvQPuMp3oY8qQS8Y3Dbw@mail.gmail.com>
 <9acc4159-8223-bbca-a83f-d075660ac6db@nbd.name> <CABHL29GB6DCrdu4FzRfBDSj9A7pwqnWE+wgH2xfkBMLjT3bAxA@mail.gmail.com>
 <f75ad975-8b76-f3e6-151b-6eda552c0431@nbd.name> <CABHL29GUgta4Ke3sxbongMSK__cruTaDYCXe1-yEDL3WA3mO9Q@mail.gmail.com>
 <4040f674-8430-69ba-1b6f-f9fd92da413d@nbd.name>
In-Reply-To: <4040f674-8430-69ba-1b6f-f9fd92da413d@nbd.name>
From:   Venkat Ch <venkatch@gmail.com>
Date:   Wed, 21 Sep 2022 14:01:29 +0530
Message-ID: <CABHL29FkAKk7=MJ6J=wUzXkuYJ=M5DYE0nk5sHWxwz26FuYjrg@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mac80211: Fix performance issue with mutex_lock
To:     Felix Fietkau <nbd@nbd.name>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Venkat Chimata <venkata@shasta.cloud>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Felix,

 Thanks again for patiently discussing things. I clearly understand
what you said about locks. Now that we know the background of the
problem, do you suggest any potential solution or any potential
direction that I should start investigating? Please let me know.

Thanks & Regards
Venkat

On Wed, 21 Sept 2022 at 13:35, Felix Fietkau <nbd@nbd.name> wrote:
>
>
> On 20.09.22 21:23, Venkat Ch wrote:
> > Hi Felix,
> >
> >   Following is the background of the problem, how I traced to
> > mutex_lock and why I propose rcu locks.
> >
> > Issue:
> >   On a 10Mbps upload / 50 Mbps download connection, the following issue reported.
> >
> > Video periodically freezes and/or appears delayed when on Zoom or Teams.
> > 1. Video will freeze for 10 or 15 seconds periodically when on a call,
> > but audio continues and the session doesn't drop.
> > 2. The video  still works but it appears delay (I move, but the video
> > of my movement is noticeably delay by a second or so)
> >
> > Tracing to mutex_lock(sta_mutex):
> >
> >   When I investigated, I found that the ucentral agent in openwifi
> > fetches the station list periodically.  Without the station list
> > fetch, the video quality is just fine. I investigated the station list
> > path and found this mutex_lock. I also see that earlier it was
> > rcu_lock which protected the station list in this path. In this
> > commit, https://github.com/torvalds/linux/commit/66572cfc30a4b764150c83ee5d842a3ce17991c9,
> > rcu lock was changed to mutex lock without providing any reason.
> The reason seems clear to me, even though it was not explicitly stated
> in the commit message: in sta_set_sinfo it introduces a call to a driver
> op that is allowed to sleep.
>
> > I also saw this comment just above the sta_mutex declaration.
> >          /* Station data */
> >          /*
> >           * The mutex only protects the list, hash table and
> >           * counter, reads are done with RCU.
> >           */
> >          struct mutex sta_mtx;
> >
> > So I reverted back the mutex_lock with rcu_lock and it just worked
> > fine. We tested for more than 2 weeks before concluding this analysis.
> >
> > I think the usage of mutex_lock is impacting the tx / rx path
> > somewhere and hence the issue. It is a challenge to trace the exact
> > function though.
>
> I don't see any critical part in the tx/rx path which depends on the
> sta_mtx lock. My guess is that for some reason your change is simply
> accidentally papering over the real bug, which may be somewhere else
> entirely, maybe even in the driver. A freeze for 10-15 seconds
> definitely does not sound like simple lock contention on the mutex,
> since a single station dump will be much faster than that.
>
> - Felix



-- 
If you rest, you rust
