Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9891241EEDA
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 15:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhJANtU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 09:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhJANtS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 09:49:18 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D87C061775
        for <linux-wireless@vger.kernel.org>; Fri,  1 Oct 2021 06:47:34 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id u32so20573214ybd.9
        for <linux-wireless@vger.kernel.org>; Fri, 01 Oct 2021 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5mMr7KrDxXZPb/fUI8/D1KDchLzlnh9jE96UMc9WvnE=;
        b=ncoEvcq+9RxJsBM8+c1yt0XXTyU+Nxfu+qOlcq8VD1kEguxXBHc9qhRSzIVRs7U7gB
         PG7GvuWWvgWoxsc2K6BNffs3Qo6z1l+Yk57QTSeUpqPJ+N2qqQ4MsLmzxbsCU2cO8i2H
         6LqJ0yXcqkH2xBEcdMldbQT68iPqSoA2nmiAu/lMPJukVV+epPVH/Bl62fFggzzq7xVL
         46AKHgPIaTH5LC8OguaW4ld1K8f9V7v4nmRrQhi+GDNrsRTH0cOtJLO6cz3pHZq2EQ4G
         AzGWnJiZHNeIHjE6hbWighLPb7FseXxkaG0Mop4vO3XyB0PvDT77ork25sYrIuYKKhaO
         v/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5mMr7KrDxXZPb/fUI8/D1KDchLzlnh9jE96UMc9WvnE=;
        b=UmIalrGOeR5Htcl7dE8Zm689uc7uUFTYBOSqKeuFAncj1hIZj6BHu/r+cfhMuQI3EH
         25e2m05KcVv6k4TDfDheCGkaU3YUsGWax8By0bmgKyC7iBtH0surZxxtS7SHcOpMtw1N
         gbQ2kxZdizJIkMRny9ne/x4cJyJ0+rdSLOEomerg0Z2+LsKLcuaA3FjlSRriHtTHxJbf
         RKaJii0krwmvKxVMf9m1BNJVhs0ABXea67y7mvAA7i6XzwmrYzmz5zrjE6+rvTW022sK
         1gwqZr3kyIcIlfYVfZMKjRBTupg/lfaxOeMAuQCKONG13X6UBwYudn5a50v1FnODFCSk
         rOUA==
X-Gm-Message-State: AOAM531LdJM8mteDzrS6NH093ExPdMr2+3hyGsURE2qksmVF2z5G/asz
        N8aNJP8nbdava/GcWAe1EuMYCTxdMzpv+9BM2DpRY3U9drX7C1yf
X-Google-Smtp-Source: ABdhPJxrmrNxRHRVQsbRxCC7LS+Jaj5oiN8w+RAllKQSt1ahQdcE3Uzm69VQXmiNmbZmelGg0yM2FQW9jX5BgEFPlV8=
X-Received: by 2002:a25:dc05:: with SMTP id y5mr6615556ybe.493.1633096053957;
 Fri, 01 Oct 2021 06:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtR28JZaqNC053jEpoZGN37kRK9ReYX0Kt8+ukRGnO5z_Q@mail.gmail.com>
In-Reply-To: <CAJCQCtR28JZaqNC053jEpoZGN37kRK9ReYX0Kt8+ukRGnO5z_Q@mail.gmail.com>
From:   Chris Murphy <chris@colorremedies.com>
Date:   Fri, 1 Oct 2021 09:47:18 -0400
Message-ID: <CAJCQCtQBsa2KkeQ1vS+j_t4G6DV_uO5kHETerBrjh3SVHQUf8Q@mail.gmail.com>
Subject: Re: 5.15.0-0.rc2: suspicious RCU usage
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[    8.481619] iwlwifi 0000:00:14.3: loaded firmware version
46.6b541b68.0 9000-pu-b0-jf-b0-46.ucode op_mode iwlmvm
[    8.919971] iwlwifi 0000:00:14.3: Detected Intel(R) Wireless-AC
9560 160MHz, REV=0x318

linux-firmware-20210818-122.fc35.noarch

NOTE: it's a rawhide/36 kernel with Fedora 35 user space, but at the
moment 35 and 36 have the same firmware version.
-- 
Chris Murphy
