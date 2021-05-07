Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E6F3761C5
	for <lists+linux-wireless@lfdr.de>; Fri,  7 May 2021 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhEGIUM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 May 2021 04:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236047AbhEGIUJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 May 2021 04:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620375549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PL+gzNM9T97qiW8YYbHLIHWWQdJk8jXPZhrNPI3PmAc=;
        b=bcIhP5lDZT/Xf22AJLaiyXC5pq5PR92JJT1I5yUlm87WVadrD7Sf5yAdRRgSTC5GEXHWXh
        90h60CE8DxK9AVJzaTm0k2Eux+mPwOik942VQzVDX1sw5LYKpLbpqch2wRqFhPdU/Cp9Uk
        z7IdcBx3yAK4XNPltJRZDaSI+OOwrjI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-BfJKoDSXOueS20ZpEwgYdg-1; Fri, 07 May 2021 04:19:05 -0400
X-MC-Unique: BfJKoDSXOueS20ZpEwgYdg-1
Received: by mail-ed1-f71.google.com with SMTP id s20-20020a0564025214b029038752a2d8f3so4065444edd.2
        for <linux-wireless@vger.kernel.org>; Fri, 07 May 2021 01:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PL+gzNM9T97qiW8YYbHLIHWWQdJk8jXPZhrNPI3PmAc=;
        b=G2iDGCulbyZ4Se5CGdbEvqaFl79GWwD4bseR0exbTf4Re/lWPWqBTCwtvykTroZv+6
         p6yYfOGBJL6rw6kzp4ZsShcvV/xBDZoEtM9/LaowaYJmtkfVowTXCnNtSvtXMsgWAikf
         G0QpmwJ01jqsJFzSb6TnEtYwF0OA8kIo7dDp0pC2MOJBJ3cdS/3b9/r5NOWnNOeur61F
         TNmy6+DC2B3ryj6l0DcNGnYJYeyz8cIxdN+5Co458nl0EBUQT0vDmHQNs/bx3BCu0ciQ
         n1j+RMo6yDHVsBY2K2HswRoIA4jXsjesw+G+m4Ep6fJuZtxJYG3AlGExAgvAy9f77LZn
         OoqA==
X-Gm-Message-State: AOAM5312bqu6zJcpYh/L3KnJmRRG4QDSL9ZZZjj7b/yZtMrAK+mfJMSs
        HeBSpq/4vAziXZvS+BlrZIVUx5RvGxUlmfdgqjJLXZYzwB7zW7INvhOo+MGKPw4plO3gdicZ9I0
        h9ho0oK9yf5XfmJaWk1c2dfG+uqA=
X-Received: by 2002:a17:906:3c51:: with SMTP id i17mr2879292ejg.314.1620375544490;
        Fri, 07 May 2021 01:19:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhPx1RSOZ+Rx0brFtevKJx9YL87rp2Anlc29W+izURH6iPYu7vuFMwawGY7d5ANN2lP1775A==
X-Received: by 2002:a17:906:3c51:: with SMTP id i17mr2879269ejg.314.1620375544211;
        Fri, 07 May 2021 01:19:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id me3sm2973766ejb.49.2021.05.07.01.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 01:19:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 068D818070D; Fri,  7 May 2021 10:19:03 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     kernel test robot <rong.a.chen@intel.com>,
        linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, make-wifi-fast@lists.bufferbloat.net,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kan Yan <kyan@google.com>, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: [PATCH v7] mac80211: Switch to a virtual time-based airtime
 scheduler
In-Reply-To: <20210507055512.GC2687475@shao2-debian>
References: <20210507055512.GC2687475@shao2-debian>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 07 May 2021 10:19:02 +0200
Message-ID: <87r1ijufbd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

kernel test robot <rong.a.chen@intel.com> writes:

> Hi "Toke,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on mac80211-next/master]
> [also build test WARNING on next-20210505]
> [cannot apply to mac80211/master v5.12]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Toke-H-iland-J-rgensen/mac80211-Switch-to-a-virtual-time-based-airtime-scheduler/20210505-224557
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
> config: i386-randconfig-s002-20210505 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://github.com/0day-ci/linux/commit/4ff38b3940e58b3d8e44594f44f2f700e5b930b5
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Toke-H-iland-J-rgensen/mac80211-Switch-to-a-virtual-time-based-airtime-scheduler/20210505-224557
>         git checkout 4ff38b3940e58b3d8e44594f44f2f700e5b930b5
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=i386 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>>> net/mac80211/tx.c:4020:6: sparse: sparse: context imbalance in 'ieee80211_txq_may_transmit' - wrong count at exit

Oops, seems the unlock somehow got moved to above the out: label - will
fix!

-Toke

