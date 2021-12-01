Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D10465066
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 15:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhLAOwr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 09:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbhLAOwq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 09:52:46 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB61AC061748
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 06:49:25 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q3so29978295wru.5
        for <linux-wireless@vger.kernel.org>; Wed, 01 Dec 2021 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xt3T5vfNow3BwvaK+nGuJ71E64yKHfyAgkgC4Ws3fQ0=;
        b=ZH7LO3V+kDGPmyYVE6KJmsgtK4a8hqJ53OIVoZa4fRqSgE/paLHYYUVp1MFeMsy4h4
         RnWmwaV/86kVf8DQpC9ukj7IwXGXBPKIbQctm+SR9PYCsXPMNECi6eSNY9h46mNd0wRM
         gc2Y6HJeEditTEJ9FG3cD31SfOdXVmw/Cs5JIpTnv+dMFeFkMZseHUETxtYGvNPnSC3d
         A6J+IE8iLPH+Vl7Isj4hq1X8rnRa111ldBJdxOfSwOaJTt/A5VilllhFqpXMnkerR9IH
         DP6l8dUdGnFrVPKx2krhNNmhMXtDxxr9f5+gOt6eL2dshnQvq43+y3SljbGP97UClqdp
         eijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xt3T5vfNow3BwvaK+nGuJ71E64yKHfyAgkgC4Ws3fQ0=;
        b=y376CKLttsGy7P3W4zu2DB/Qlb6u4vR7KZpP9bw9vGhE1sAeI2U7MVJto4WkNs7jj1
         GEeZpcqIiJMHq1OVOEPTj9VA1wX7DxqAO6pd9pdve2JGBah0tB94wQK50L4TOnLXsNHf
         lQfc3fgZVL/DZDLrHL5hXqrJZcyH+rTBQm1aGi5aOeSD9r4pl+5xlTh8GUHKRszggXm4
         idlcVrEfdsVMhl0ZfYmStxKD/TCeXq6NAcJs8S6mO7uSI9JGjmB9ESU2G4WrCoehoE12
         Jt1hgTfOA60c+kjKAP+heN+JdaW/j5T8OG97WLyf83eWvl0/c+NN5oiRUG0c9fcuJNGn
         F58A==
X-Gm-Message-State: AOAM531NI4aNH9LxsAWqf0xUFlFBDsyQPNA0lTD8GHjXW3BLPS7JIzF0
        lRQK49EqoZYCNgWVL/nxOzqvoWbW1MJXqm4HgZ6+GGt5CGOYZg==
X-Google-Smtp-Source: ABdhPJzvYiES2x9d8VsHHbw9j0lmIyLvbkFIRw5/kQlTf15N7yR2tUirRASh7CkM2dSslGdWmcxATCww8AeZqyfvnsA=
X-Received: by 2002:a5d:6508:: with SMTP id x8mr7017945wru.388.1638370164352;
 Wed, 01 Dec 2021 06:49:24 -0800 (PST)
MIME-Version: 1.0
References: <CACJOGMP0k1AH9Coz2DjZjkeoxPGjSyP60MYMSHrMN-hSJrrvTQ@mail.gmail.com>
 <74887ec8f49846f5ae8b40b4c213d2da@realtek.com>
In-Reply-To: <74887ec8f49846f5ae8b40b4c213d2da@realtek.com>
From:   Jeff Clay <jeffclay@gmail.com>
Date:   Wed, 1 Dec 2021 08:48:48 -0600
Message-ID: <CACJOGMOBaQ+vc37dnpS8JYEnE4v4bufSkw+_Or5FEzkTiKXfBQ@mail.gmail.com>
Subject: Re: Latency spikes in rtw89
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thank you for the information. Would the issue persist if I were to
disable wireless power management?

On Tue, Nov 30, 2021 at 7:33 PM Pkshih <pkshih@realtek.com> wrote:
>
>
> > -----Original Message-----
> > From: Jeff Clay <jeffclay@gmail.com>
> > Sent: Wednesday, December 1, 2021 3:16 AM
> > To: linux-wireless@vger.kernel.org
> > Subject: Latency spikes in rtw89
> >
> > Hi, I am using the rtw89 driver for Realtek 8852AE in my Lenovo T14
> > AMD Gen2. I have obtained and installed this driver from source at
> > https://github.com/lwfinger/rtw89/tree/main I am having an issue where
> > the latency during a ping test to hosts on my LAN spikes to 200ms or
> > above. According to lwfinger, this is known and acceptable
> > https://github.com/lwfinger/rtw89/issues/85  However, I am hoping I
> > may be able to work with you to resolve this issue as a tester.
>
> We know this, and it is due to power saving; i.e. tradeoff between
> latency and power saving. We are thinking how to improve it entirely.
>
> --
> Ping-Ke
>
