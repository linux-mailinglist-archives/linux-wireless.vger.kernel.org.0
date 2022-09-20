Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9FB5BED94
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 21:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiITTXz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 15:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiITTXk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 15:23:40 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A42352453
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 12:23:39 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n124so5032591oih.7
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 12:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pxKrF2FePwfx28yk0Mi+SR3JHGFppaMqxPdkcNm6CKM=;
        b=nQwBOL15EvstozIdEiQauX8xdO3nc+qOmr5+3Onj67410U+m15m4PeulnkE+acq7S/
         qw07hDumyUObDfwxzUQN+jNd+MxSaL1AEjNmS1WZGUHl4XQPv2oOdqV4e8+J6eiPXwm9
         mkE8+W4rzCAGTaDa5EaqEIv2NoYVswIACTPFCKl4BSR+rpJGfV2vdP/j4gPmmRstuG1S
         wiUUTtW9FfrGX6mLUsA+e5OYPozefVfQrqgovKjiwccXqKtC+EqQF++WkmT0JcKAaqFe
         I7p2hIQotyvpj8I2FcGgXqP7kJ2qrAtzV0KAnaUP5Wf7buSzswDZjTcDdTOPyotbFdQ5
         pR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pxKrF2FePwfx28yk0Mi+SR3JHGFppaMqxPdkcNm6CKM=;
        b=IZpLXFd5vHF+w/NvnBxtph9c3zFOS8px4sI17gQ/KYWo55dVSD5zV8wJ7SjyRaj7gB
         YzsM5WyO3XZMxqIOhRPr6+qPioM5FdhYXwDnP9YU2QcYkB0u60RtpZb1tkvSedtAbzhj
         SmjWWA0e2chp5pGCqu2D4C0w4QXhcilRQsCZ+VNqf3FFv6yC3yPkIfhYzBliVRr4801Q
         IVAuHLqv0fNrUhm8CwGbvW+eyWJsEge7j6h2mLY3p3QkcehfwhZ9VUCsr7E+w927E4M2
         4W1/uvtkgos45GJER+eXABP8IFYjZ+1EveX+6TKgDKoRBx/USFUKf8pUL1fSf4toiJ2v
         bSCQ==
X-Gm-Message-State: ACrzQf1FCyjmzrF3L78xw+11f4cQw85QJegARHuk8qUGUmPdwsCryIUx
        csWd98NjsQGJLF3OJw9zrd5n27GtuMzHN91Ya4g=
X-Google-Smtp-Source: AMsMyM4kzO1dBzdFv5FnHgqHVxuS+X6VIwXIb8FWpk4usCmWTKRjTZisuc60fGThrZM2pruH4KJz7Wt5jcGmGmxLQr0=
X-Received: by 2002:a05:6808:1648:b0:333:45ae:3777 with SMTP id
 az8-20020a056808164800b0033345ae3777mr2427956oib.4.1663701818493; Tue, 20 Sep
 2022 12:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220915043527.737133-1-venkatch@gmail.com> <238a21a8-c97b-5a38-6c08-9057055bf73f@nbd.name>
 <CABHL29H75U-0dBP14d-6ds-xMPt1eqrvQPuMp3oY8qQS8Y3Dbw@mail.gmail.com>
 <9acc4159-8223-bbca-a83f-d075660ac6db@nbd.name> <CABHL29GB6DCrdu4FzRfBDSj9A7pwqnWE+wgH2xfkBMLjT3bAxA@mail.gmail.com>
 <f75ad975-8b76-f3e6-151b-6eda552c0431@nbd.name>
In-Reply-To: <f75ad975-8b76-f3e6-151b-6eda552c0431@nbd.name>
From:   Venkat Ch <venkatch@gmail.com>
Date:   Wed, 21 Sep 2022 00:53:27 +0530
Message-ID: <CABHL29GUgta4Ke3sxbongMSK__cruTaDYCXe1-yEDL3WA3mO9Q@mail.gmail.com>
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

 Following is the background of the problem, how I traced to
mutex_lock and why I propose rcu locks.

Issue:
 On a 10Mbps upload / 50 Mbps download connection, the following issue reported.

Video periodically freezes and/or appears delayed when on Zoom or Teams.
1. Video will freeze for 10 or 15 seconds periodically when on a call,
but audio continues and the session doesn't drop.
2. The video  still works but it appears delay (I move, but the video
of my movement is noticeably delay by a second or so)

Tracing to mutex_lock(sta_mutex):

 When I investigated, I found that the ucentral agent in openwifi
fetches the station list periodically.  Without the station list
fetch, the video quality is just fine. I investigated the station list
path and found this mutex_lock. I also see that earlier it was
rcu_lock which protected the station list in this path. In this
commit, https://github.com/torvalds/linux/commit/66572cfc30a4b764150c83ee5d842a3ce17991c9,
rcu lock was changed to mutex lock without providing any reason.

I also saw this comment just above the sta_mutex declaration.
        /* Station data */
        /*
         * The mutex only protects the list, hash table and
         * counter, reads are done with RCU.
         */
        struct mutex sta_mtx;

So I reverted back the mutex_lock with rcu_lock and it just worked
fine. We tested for more than 2 weeks before concluding this analysis.

I think the usage of mutex_lock is impacting the tx / rx path
somewhere and hence the issue. It is a challenge to trace the exact
function though.

Thanks & Regards
Venkat

On Wed, 21 Sept 2022 at 00:21, Felix Fietkau <nbd@nbd.name> wrote:
>
>
> On 20.09.22 20:27, Venkat Ch wrote:
> > Hi Felix,
> >
> >   Thank you. I browsed through the code. There seems to be sleep
> > operations wcn36xx platform.ath11k  does n't seem to have the sleep
> > operations in sta_statistics. We are using ath11k based chipset. Will
> > it impact things if we apply this patch for ath11k boards only as a
> > platform specific patch?
> I think it's a bad idea to keep this hack without understanding why it
> helps at all.
>
> - Felix



-- 
If you rest, you rust
