Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007352668B5
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 21:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgIKT1J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 15:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgIKT1G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 15:27:06 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637BAC061573
        for <linux-wireless@vger.kernel.org>; Fri, 11 Sep 2020 12:27:06 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id s92so7086154ybi.2
        for <linux-wireless@vger.kernel.org>; Fri, 11 Sep 2020 12:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkrenJ20WAQIAnSblJx2692F5wz44SL3O3vCoF7G/4E=;
        b=Zd7ltMRMuA00ALPWXrvyFjoL7tg/tvbHh0GUqrx0Q4pqHoxgCf2qrDKHsiUBGjNKd5
         ghWMwIarLbJWG+HHevo1Dchf59ZZOSPWeclpnoyasnoCbSH4l1ua1t9CU22URbs6lHjx
         GL1s9DZND5ub2ewoYYsF6XLiDDgYOnYYMaXlRPautLimyoRm36brnzrNeRnJjvSDqI0B
         AT43GX9FVecM7JRpFaAJ/Mqg9cUPcAwfXb7iXbc+YIRGZzDfL41xLBNU8BQfF6Pexkfv
         v1A7pWB5hVRyqVuxK+Q1u/uh/T/onDPJ5fqx0VQtYQkyrU+mDZ9JAlJXRkFxb2NTTMFH
         YxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkrenJ20WAQIAnSblJx2692F5wz44SL3O3vCoF7G/4E=;
        b=Pq/sKk0W7U66FWCoSeT1iUQK+1IbWtVmAMrcxsc/Fp/fIWj8Ur3wM/6AEo/lZilvOl
         tEo/fDvc6IyRWBaHCiDIn99dp5yWjX84DxBbNlEv7obtSFvOLlAVTt7B3cm0aiilTg4Y
         FbTmIJcelI71s0KhwRDgyEhKfG6uHovPokhAWnfGS49syrzSs3rxDdZlMq44kXtHHvKs
         lzoTzhZXsvKJuv1yHgoWnhU22pfeAjdL5oJYPIJzrqp+Ay3nzkvdbvHq5s/i7V2g80TJ
         jE5KunT78NfcJkHc0NZEMapfvOJd/D4wYnA7ruznPUobHMHO6Z3X1/zCLTlxSzIi3Tt/
         Pc/g==
X-Gm-Message-State: AOAM533aNnfapqkBD492/kNQRiNDlCHKJ9C2S79nwuPVaN+BNx8v0Y0N
        Z+7ZBUls03vQBS4GLeCyzy7aiCMNClMeHl+VIbw=
X-Google-Smtp-Source: ABdhPJyK5GF6rf0EOVRG2pO5D/9yB+pfg/6fh5b49Qj/kOiPTjPqgV72YYJ4sXkkI9YEQhtq2bH4fuKfslGEimpyHDA=
X-Received: by 2002:a25:a081:: with SMTP id y1mr4618185ybh.370.1599852425669;
 Fri, 11 Sep 2020 12:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAD_iCC8EyWV8bLdJ+VsRdMHOa6ccOOOOUMM6nMwDk16LtMppcg@mail.gmail.com>
 <PR2PR08MB464983615CFB2AF2B3BCD644D12E0@PR2PR08MB4649.eurprd08.prod.outlook.com>
 <CAD_iCC-=rvC6mC8pOKNKqrrWQv2wt9BXVMQB2DR1QKcGp_KbiQ@mail.gmail.com>
 <CABPxzYJ=vJB4pnCC__G6Luhdp_m51Z_nKq80HFxEfN6cdsKQbw@mail.gmail.com>
 <CAD_iCC-koZwPCew4+n4nk8Ou_jWC2BxxcSDy_rf9KnO4Q=MO=g@mail.gmail.com>
 <CABPxzY+tfkjKETjdKJE7AjY6ELFfsLw4utVWOfXwxuV4C+RK8w@mail.gmail.com>
 <CAD_iCC-=9XU-DbfUorUtSRzCOEW=gr83T8ZSMvJn_xFgoMWvew@mail.gmail.com>
 <CABPxzYJmL7x1Hfx9Yf+4XT6xngWNmYC9ZGGvDYqLo7y2bNtCow@mail.gmail.com>
 <CAD_iCC9Vu55FG5vHSWF=H8v-ZZKQoyin8B-1zBtaJ+2MeJqCjg@mail.gmail.com>
 <CABPxzYKVK3OK6nKMrLrBfdy-Yz1v_bbyhHHLCkxnFzWtFBSGaA@mail.gmail.com>
 <CAD_iCC8XDNXfDmghhXyK8auFg5WinqaACpbpbiZ4g0toaDoeiw@mail.gmail.com>
 <CABPxzYK-HN-Q3wREn+6qAkiHAnkuyqz-g6m9XpUtaMd8ckHQPg@mail.gmail.com>
 <CAD_iCC-LMnDeL-e-i2GPYe9fRruWxkKvHEsNGDERv2j8eN1YFw@mail.gmail.com>
 <CABPxzYJVwjPGrHitstWkgiL+kEB9AeTMy_e5nu7FNXVv4ZNk-A@mail.gmail.com>
 <CAD_iCC_1TV_wQK+xOWk48eaJhWo82CZgTL-g4jg7tOdVxvqEZw@mail.gmail.com>
 <CABPxzY+2OO6nptyE+oH+COLe3pVgKhji=H1trP7m_bcpVqEe7Q@mail.gmail.com>
 <CAD_iCC-x9J4UB5aVR85WNi4OwaXQiU28+4B1AD176zDu8DBhwQ@mail.gmail.com>
 <CABPxzY+oy=p4QLHfyVMprigHOpTJEJGsJ-Bsti5b9Ly=eDy+cQ@mail.gmail.com>
 <CAD_iCC-mCo58fs1v+bqyB=NRXkQDTa20R=NGe+SwTP2s7NPfOA@mail.gmail.com>
 <CABPxzYKckJ94+96YsTY4Y7D7_z-Pk=b+T1tvu5BzaoVjVi0apw@mail.gmail.com>
 <CAD_iCC8StVW7Yh9f8fm2Da7LcN6LQzR=ssp+1E8-=YYCM-5tOQ@mail.gmail.com>
 <CABPxzYKFUN-hyhJnxG_-EcD0L0bsp8rn+b+tyt_ReAf11vzKng@mail.gmail.com> <fd8fafe85f2d75a2563e5be766cce1f45424e2bf.camel@sipsolutions.net>
In-Reply-To: <fd8fafe85f2d75a2563e5be766cce1f45424e2bf.camel@sipsolutions.net>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Sat, 12 Sep 2020 00:56:54 +0530
Message-ID: <CABPxzYLEZ5KU5x3w9rex3SQqj+TwGXFOXnC_QXdEu9NLfcRHMQ@mail.gmail.com>
Subject: Re: Configuring WiFi6 in hostapd
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Sugandh Huthanahally Mohan <sugandhgowda@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        luciano.coelho@intel.com,
        Cedric Izoard <Cedric.Izoard@ceva-dsp.com>,
        "Hostap@lists.infradead.org" <Hostap@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 11, 2020 at 10:41 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Fri, 2020-09-11 at 20:37 +0530, Krishna Chaitanya wrote:
>
> > > [  228.315290] iwlwifi 0000:03:00.0: 0x00002078 | ADVANCED_SYSASSERT
> > > [  228.315294] iwlwifi 0000:03:00.0: 0x00A0A200 | trm_hw_status0
> > > [  228.315297] iwlwifi 0000:03:00.0: 0x00000000 | trm_hw_status1
> > > [  228.315300] iwlwifi 0000:03:00.0: 0x004F8E3C | branchlink2
> > > [  228.315303] iwlwifi 0000:03:00.0: 0x004E4FF4 | interruptlink1
> > > [  228.315307] iwlwifi 0000:03:00.0: 0x004E4FF4 | interruptlink2
> > > [  228.315310] iwlwifi 0000:03:00.0: 0x07000101 | data1
> > > [  228.315313] iwlwifi 0000:03:00.0: 0x48308403 | data2
> > > [  228.315316] iwlwifi 0000:03:00.0: 0x00000005 | data3
>
> This means that we got an invalid TX rate, notably an HE rate was
> requested/configured on a MAC configuration that didn't have HE.
>
> I think I saw some patches in this area (configuring the MAC to be HE)
> fly by internally recently, but not sure... Luca probably knows.
Ah okay. This was reported on 5.4 kernel, do you think is it worth
trying on latest iwlwifi-next tree? Or as you are referring to the internal tree
the issue is present in the latest as well?
> johannes
>
