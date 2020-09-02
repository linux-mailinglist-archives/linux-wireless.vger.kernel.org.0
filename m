Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4354225B0A4
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 18:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgIBQFP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBQFO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 12:05:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B116C061244
        for <linux-wireless@vger.kernel.org>; Wed,  2 Sep 2020 09:05:13 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ls14so22034pjb.3
        for <linux-wireless@vger.kernel.org>; Wed, 02 Sep 2020 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=IKyzVIbOX2AWy+lmvRgM1BZapxbY1hELuehnxPy+Ohw=;
        b=FnHfhctdJmvz6+RndSJ9UdVP9O8dxHsf2IekTzralxUyNm2BSvFzFzQnu2TeCddEmQ
         7djBerJL1SJLMDJztjbEvnIPCw+SheQ+lwCi3nV0A9ecoKpZZngUCGKbxZ8l8PN/g//e
         ryW2Sx4R86uNNZThfbBrWmbTFPs7ZQFBggiJgR7JeblrUgbfeYrd93/3CV1HpJiMASee
         8b9af9jq2Rq9kDlk5bY72doSVahO7Eitjod0gm71Esl4tk4kVcmON7xoeuUHSN5xAFJj
         RbifOSNNgiLDIEzfTIjfuc/XT8bdIsj2gfdg5Hxp3nNLvPnF+gQ2mYsp4XgvyCjCYyS2
         33Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IKyzVIbOX2AWy+lmvRgM1BZapxbY1hELuehnxPy+Ohw=;
        b=q5qLMY9NpzyhXo3Lc10wOEkqRlOadxNvxPxpFOgojErCn2bS/h1z9wry6Lm+Gev2wz
         lKQ9ISx72sdOTETudAO46arOME6cYb9TUJVHEOizk0gX/IYKFoi8OTK5hcr0AHd2w2Hy
         Ws+byrD7Jrz09AidCtZsoykzETmsOKmquaMsqK/GPCB8EqaggXITR7xmsFrTx/1ZCfv8
         p+MR9I/1Gyo/dlQgT8dVjfbf87lPGhDBbv80M85HLhiQe9huRXwIaxcdBBP0Qkrn0Tqn
         cLiOQL6h7Ty3xJBV/UvMt6ywi2O+/yQB1LvrBBq9x5ep6DZKJE8kHctT9YRT8MtIE/1A
         52Fg==
X-Gm-Message-State: AOAM533bqgdivyu4TUAvkb53tSXMsPQ3CX88TDaUmmb5CuyGapEPOowe
        RIdyajDUXPP+T7vVjy9KhyRrg9Ke0Iw=
X-Google-Smtp-Source: ABdhPJzGm8oAMk3tL4PURhRvVBNOEucBiTJX7ThZLDwVC0MXZ3UHNBivf+pBKbmuuXZc7nIb+AoQ1Q==
X-Received: by 2002:a17:90a:ac15:: with SMTP id o21mr2934016pjq.173.1599062712885;
        Wed, 02 Sep 2020 09:05:12 -0700 (PDT)
Received: from localhost.localdomain (h208-100-161-218.bendor.broadband.dynamic.tds.net. [208.100.161.218])
        by smtp.gmail.com with ESMTPSA id w6sm5511748pgr.82.2020.09.02.09.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 09:05:11 -0700 (PDT)
Message-ID: <669a2ea710dfdb646ff18e2d26a0541abcfb9436.camel@gmail.com>
Subject: Re: mac80211_hwsim crash
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 02 Sep 2020 09:05:10 -0700
In-Reply-To: <6ead6cbadacd476600fc80eb209681c219834aef.camel@sipsolutions.net>
References: <5252d41eae98ad26b0be91ec602da969ab8e7c8e.camel@gmail.com>
         (sfid-20200902_000333_211507_BFB2FC83) <6ead6cbadacd476600fc80eb209681c219834aef.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-09-02 at 08:36 +0200, Johannes Berg wrote:
> On Tue, 2020-09-01 at 15:03 -0700, James Prestwood wrote:
> > [ 1335.541174] CPU: 0 PID: 982 Comm: hwsim Not tainted 5.8.0 #1
> > [ 1335.553946] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS
> > 1.13.0-2.fc32 04/01/2014
> > [ 1335.588370] RIP: 0010:hwsim_cloned_frame_received_nl+0x141/0x2c0
> 
> It'd help if you could run ./scripts/decode_stacktrace.sh or use gdb
> or
> something like that.

I was able to decode the stacktrace, but my kernel isn't built with
debug symbols so its no more useful than what I had before. I guess I
didn't specify exactly before, but I was able to printk debug the
offending line of code (where data2->channel is NULL):

if (rx_status.freq != data2->channel->center_freq &&
	(!data2->tmp_chan ||
	 rx_status.freq != data2->tmp_chan->center_freq)) {
		mutex_unlock(&data2->mutex);
		goto out;
}

My 'fix' (hack) was to check data2->channel for NULL before this if
statement, and unlock the mutex/goto out if channel was NULL. So
bascially just drop the frame. I really don't think this is the right
way of doing it but I'm not familiar with how/when channel is set and
if its normal for it to be NULL. If this is fine I can send a patch but
it doesnt feel right to me.

Thanks,
James

> 
> johannes
> 
> 

