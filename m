Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475FBB0B00
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 11:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfILJLs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 05:11:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42875 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730185AbfILJLr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 05:11:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id c17so9389106qtv.9
        for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2019 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEVrMHSfJtogStN1Xu1alrJktvw6GAivaNKUvNSvqiI=;
        b=uwhocuUXvhEfH69GKAiZ8Xo8PJ6JFf3wKJLlMn0XuRgSlLsndrpBYaoetABW4uMU6l
         W9NJ/mcrj6QU0BAQ6JRJ2JUnsFPoziLSlUSeSv6VItskkHpzyxrkqylK7OjO5BOzODKB
         SM3eoNOY4kY5dewRiQSl8n6Dgh2HBLUvCdUk7WDaPtsThB22vjTHYIa9IEB8+cTlRMIt
         M3HH2bIkHqqd7M3HbmDyf51ltkF2D0cqzHZio2e5q5OZWoB+C6vSPlugk1g3VnMLFcbE
         NW0/Llc1Nh+DdPE+boXwREvr1UtIbk7PylYLc1WYR35mGCI99NKJafVas+BmPRuxUeM/
         a9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEVrMHSfJtogStN1Xu1alrJktvw6GAivaNKUvNSvqiI=;
        b=p4Se0Y6Wr0yR4gV2RdX9nvzKI/EdtWn5ApHpAUoNSRaxRi4SV0p4B67qF6eHl8rOcB
         4/HuWBFypwMiNI2N2IY6QMgY/DPSXq6/FRLQlL5j4RRsumTqczS2A0gA+jWnhpXHe+li
         9zZKT/BFfEYXbwWoG+L68nPeRBx2MnFps+tFHRl5ORGwxvd3Yascrx84E8v4WQaBH5oo
         GgmvxEUlDzFG1PA3S5kuP8ODMZGcF5B3/F7Ufl2GnCAzYpN0GT/9epebuGSFysCs4QPV
         CtUPNOG+uHyCGOrZIHP9lrn6A28TK+xfiuBnwI1jk8MVy6AIktBf/6bclZNNt900Buz6
         hcJg==
X-Gm-Message-State: APjAAAUQfgUVvMnq/+94TaTxy3EKZuVPCRzsrKY9LOhmyCv1zlpSA7LB
        hlOMkW3HJ5qbEd6qBf2K8m1Jlo2p2wpUyOF94lTaOQ==
X-Google-Smtp-Source: APXvYqy8JumoXQv64fBpR2GU4a7OLIWPCqtBssZQ2XwfKDoLVO9yPHc1VizLXwxMeyolG+T90pjmAvhk7pAdsnCzJRw=
X-Received: by 2002:a05:6214:88e:: with SMTP id cz14mr12586805qvb.120.1568279506360;
 Thu, 12 Sep 2019 02:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <1568270355-29727-1-git-send-email-yhchuang@realtek.com>
 <1568270355-29727-3-git-send-email-yhchuang@realtek.com> <CAB4CAwde2ciT8AtYOXP3NJw=fq3uano_GQYXNKjcL+M+hKeWhA@mail.gmail.com>
 <F7CD281DE3E379468C6D07993EA72F84D18D2D2B@RTITMBSVM04.realtek.com.tw>
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D18D2D2B@RTITMBSVM04.realtek.com.tw>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 12 Sep 2019 17:11:35 +0800
Message-ID: <CAB4CAwdw95yr-zgPA-3Wor2FRMu5YoetFJiLbjWWqUzo-wj2yg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rtw88: report RX power for each antenna
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 12, 2019 at 3:43 PM Tony Chuang <yhchuang@realtek.com> wrote:

> > >
> > > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > >
> > > Report chains and chain_signal in ieee80211_rx_status.
> > > It is useful for program such as tcpdump to see if the
> > > antennas are well connected/placed.
> > >
> > > 8822C is able to receive CCK rates with 2 antennas, while
> > > 8822B can only use 1 antenna path to receive CCK rates.
> > >
> > > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
Reviewed-by: Chris Chiu <chiu@endlessm.com>
