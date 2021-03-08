Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D663309B6
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Mar 2021 09:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbhCHIrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Mar 2021 03:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhCHIq4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Mar 2021 03:46:56 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90042C06174A
        for <linux-wireless@vger.kernel.org>; Mon,  8 Mar 2021 00:46:56 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d11so6924252qtx.9
        for <linux-wireless@vger.kernel.org>; Mon, 08 Mar 2021 00:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HMWGRd2ELv0LyBzrEW5sQY+FOXybr/XG3AI+w+7jmJk=;
        b=HAAM8jjJIv0kx2PEl+F+pFWpFHTz6Er7Zb8xAUloxO9brARUbpVIh8mww56be5uNsi
         86yTwNzUy7intoIbDKZY1XYtlR7IVU26cybODDLjjn8VU0pkVHSujyLiNWdeTZUZ/Gqd
         2vzyBgSxZkCV5Cl9wJnpXImEVH8nJXAfqA6C7Gf4JjHRXnn/7Yr7MFHSMIYUGDaZ7UD3
         V6fbg6CyymiVjwuJkFnL6mArHWOxEF7ymLJWu2l0LZLoDFNMHrELTAM//l3zJhE0AtVp
         6gGgOn52qQq0L4JqOZyKIxcCWtSFWSuxMK31qCdmhI5wbaWYvyUbs8JaurilvX1W4qyG
         PlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HMWGRd2ELv0LyBzrEW5sQY+FOXybr/XG3AI+w+7jmJk=;
        b=sQxEQT3v6fW9g8OLJmWWAmwAGYTa06nM87yQl0zyu4Y/5FZVwBAGDgghXcbQvSy201
         NarWU2atBacDzoxRzrRFXiypL9FTXu+B72It+JbbnlzqWUUTFIIfpFoICPM0pdJwbNTA
         jxW9/1bjgdTfVyE8WUO2dJadrtJpSfokPhy2UBUkLW4TwtN7SRxMA6s+Ui/ok3sJ1WEz
         GItqoSaPcElx5FnP353JBm9SH6mz+LXL4P5Agnkf4fnxfbCXkiniA3etzj8kNrdVG/cf
         E8w6PbQg0pTSA5aqc115Uu/wQYqoQKvIQn6qMUBiD+lJpVlW0umNWfdIAnuaUdy+07c0
         9/Dg==
X-Gm-Message-State: AOAM530cTX/+eqemGZODwmb79OyL1AsOx5Sf+ZYKFOVNooYsEC2IlFxo
        Yp8oR49QiOaneO1BuqZby4ecodnXczy+Cg4ia+s=
X-Google-Smtp-Source: ABdhPJzXj+HMlJIVtn5EPatkNAUUnHxbBwtBb6mVX/zih5iA/hk1cz1lpc1BIbZfpN1NG5K2wGL+2n/lRKk1Js1v9ps=
X-Received: by 2002:ac8:5d50:: with SMTP id g16mr19546954qtx.321.1615193215768;
 Mon, 08 Mar 2021 00:46:55 -0800 (PST)
MIME-Version: 1.0
References: <CANgQ54cmG4mCx42i1ErXMJpv=2OmOGjjEgv=8oy90CpKcwkpZg@mail.gmail.com>
 <1615007321.1826.14.camel@realtek.com>
In-Reply-To: <1615007321.1826.14.camel@realtek.com>
From:   =?UTF-8?B?6YKx5ZCN56Kp?= <ccchiu77@gmail.com>
Date:   Mon, 8 Mar 2021 16:46:42 +0800
Message-ID: <CANgQ54dyKk_uoy_VWGxxTZd++5UaC7Tdq48dUzSPdVOE6H8iGQ@mail.gmail.com>
Subject: Re: Questions for TX power get/set implementation of realtek WiFi
To:     Pkshih <pkshih@realtek.com>
Cc:     "yhchuang@realtek.com" <yhchuang@realtek.com>,
        Andy Huang <tehuang@realtek.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "reto.schneider@husqvarnagroup.com" 
        <reto.schneider@husqvarnagroup.com>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=886=E6=97=A5 =E9=
=80=B1=E5=85=AD =E4=B8=8B=E5=8D=881:09=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 2021-03-02 at 10:21 +0000, =E9=82=B1=E5=90=8D=E7=A2=A9 wrote:
> > Hi guys,
> >     I'm planning to implement the get_txpower hook function of the
> > struct ieee80211_ops and handle the IEEE80211_CONF_CHANGE_POWER for
> > rtl8xxxu driver. So that users can get the information of the current
> > tx power limit and set a new limit value with iw commands.
> >
> >     I found there's phy_txpwr_idx_to_dbm() of each driver in
> > realtek/rtlwifi to translate the tx power index parsed from efuse to
> > tx power level in dBm. Does the power level translated represent the
> > current tx power limit in dBm? In my RTL8188CUS module, the power
> > index of CCK/OFDM from efuse for each channel is basically 36/38, thus
> > the translated txpower level is 11dBm. Is this the expected value for
> > the default txpower limit value? Or do I need some other formula to
> > compute?
>
> Basically, you can use a linear equation to translate power level in dBm =
to
> tx power index written to hardware registers.
>   y =3D ax + b
> where,
>   y: tx power index written to registers
>   x: tx power level in dBm
>   a: a constant, 2
>   b: a constant induced by the value programmed in efuse that is used to
>      adapt modules differences of RF characters.
>
Thanks so much. So it means that the txpwr_idx_to_dbm and dbm_to_idx
functions in rtlwifi family driver are basically correct. Except they
use the constant
b -7 for CCK and -8 for OFDM instead of the value in efuse. I should have
this value from efuse.

> >
> >     And for the handler of IEEE80211_CONF_CHANGE_POWER, can I
> > translate the hw->conf.power_level with the phy_dbm_to_txpwr_idx
> > functions I found in some rtlwifi family drivers, then directly set
> > the txpower index with phy_set_txpower_index functions which write
> > power index to bbreg for different rates (CCK and OFDM)? Are there
> > some invalid values I should take care of because the TCP RX
> > performance seems to be extremely low when I write the power index
> > value translated from 20dBm to bbreg. Any suggestions for what I
> > should handle before writing the bbreg?
>
> The power level you're going to set must be less or equal to original
> one, because it's the hard limit of hardware capability. If the power
> level is too large, the receiver can't understand the signal. Then,
> they can't exchange data that leads low performance as you see.
> I think the performance would be okay if you connect to a near AP and
> power level 10dBm is adapted.
>

Thanks for clarification. So the power index from efuse is basically the
hard limit of the tx power for each channel (and rate)? That explains
my performance issue while I override it with higher value. Thanks

Chris
>
> ---
> Ping-Ke
>
