Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D626465BCA
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 02:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347173AbhLBBtl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 20:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344264AbhLBBtk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 20:49:40 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC75C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 17:46:18 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q3so33392685wru.5
        for <linux-wireless@vger.kernel.org>; Wed, 01 Dec 2021 17:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WReIc2OfZMgGlClBaCOEbqj9DmbdAk4n1kSlMlvB4rA=;
        b=DfQihgFkr2cDwDZQuxPAIPAVRBEvk8OIfvpY6wxEDsHzlhcYCFjfgvUkboaoYM/wsG
         XYtAJhYrUXfxDSnQmDvVmfc4D+lK8PpTK47gObPpAEDSe+nQJVpt4uEL49oTk1EAikLx
         fPURFLo3ImjuQYHhjteRprCe+p70Ihm1cw8DKYB6IH649mQJNRyWS+4mAW94ImiJ7Y0f
         7pwgDNEgDyPVDMw3ql4FxcH2G7g66J9wknHkT1dsF1Dbnx1QsRnFATSg9XeBbDouUpME
         is4iLDrGt8wqmaUh+pASZ2v/uW8vUyg9WKXad20UUMngvnx3ka48/fyLJZ2xqsbVANcS
         DnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WReIc2OfZMgGlClBaCOEbqj9DmbdAk4n1kSlMlvB4rA=;
        b=QZHQycHOoaPMk2TmoReECxNF4myYsxl2hKN+dQE8ilzX/qjQM5bCxEK0M1kD+jg1BR
         KbDSp22Pbhx+bXDZT7qLn21FXbde1MLc9ptGQqoafwFj7u7EjOeyUoXl8GiTPXrLRjls
         +/DWpsc5ydmZOeg+bRGxuae7fwfewrk+LQHTr3gyNcf/6Bxj0Iiq6Ri54P1j7ouGYl0R
         t6e5pYAqMPSw14iGtQ4ji4uk8txi20Zt4lPZBiq5U3DaU27awEDg0AORhnW5J7/g0koJ
         0oBAutTF/ICZMxX1HNdOKuISXAtfTIlqwEaQZ5KbpBYJUznJk0EPh+TIT0PjjcRXKhfi
         moqw==
X-Gm-Message-State: AOAM533K6mhUIbVgKWaQCDrV6vNnKvUfVPgTM4RtXx+6lNzPDrYv47Ps
        thGURThiKtWKwGucbY0V0vjL2of7uqHahQBhdnw=
X-Google-Smtp-Source: ABdhPJyrnX344Awet5IC+x6zXpCOrLLk6Cluu8uJT3mg6aSnn4hYYak7HQtxlsv37Ifj2Eg00Tf+SqjAwuVeJMyiAW0=
X-Received: by 2002:a5d:6508:: with SMTP id x8mr10608103wru.388.1638409577528;
 Wed, 01 Dec 2021 17:46:17 -0800 (PST)
MIME-Version: 1.0
References: <CACJOGMP0k1AH9Coz2DjZjkeoxPGjSyP60MYMSHrMN-hSJrrvTQ@mail.gmail.com>
 <74887ec8f49846f5ae8b40b4c213d2da@realtek.com> <CACJOGMOBaQ+vc37dnpS8JYEnE4v4bufSkw+_Or5FEzkTiKXfBQ@mail.gmail.com>
 <5dc56416-7564-6a11-d477-9841b27a7123@lwfinger.net> <9214bf22984642549219cd1810dca88f@realtek.com>
In-Reply-To: <9214bf22984642549219cd1810dca88f@realtek.com>
From:   Jeff Clay <jeffclay@gmail.com>
Date:   Wed, 1 Dec 2021 19:45:41 -0600
Message-ID: <CACJOGMN++6r-5oQgctc0spC11-O7NKM=8BdidTi0O-imJhCX-A@mail.gmail.com>
Subject: Re: Latency spikes in rtw89
To:     Pkshih <pkshih@realtek.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thank you! That has resolved the issue.

On Wed, Dec 1, 2021 at 6:16 PM Pkshih <pkshih@realtek.com> wrote:
>
>
> > -----Original Message-----
> > From: Larry Finger <larry.finger@gmail.com> On Behalf Of Larry Finger
> > Sent: Thursday, December 2, 2021 1:39 AM
> > To: Jeff Clay <jeffclay@gmail.com>; Pkshih <pkshih@realtek.com>
> > Cc: linux-wireless@vger.kernel.org
> > Subject: Re: Latency spikes in rtw89
> >
> > On 12/1/21 08:48, Jeff Clay wrote:
> > > Thank you for the information. Would the issue persist if I were to
> > > disable wireless power management?
> >
> > That is an easy experiment to try. Use the "disable_ps_mode=y' module option for
> > rtw89core.
> >
>
> Another way is to use 'iw wlan0 set power_save off'.
>
> --
> Ping-Ke
>
