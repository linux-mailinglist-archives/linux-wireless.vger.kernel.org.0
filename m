Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980572A854C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 18:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKERuJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 12:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKERuJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 12:50:09 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B54C0613CF
        for <linux-wireless@vger.kernel.org>; Thu,  5 Nov 2020 09:50:08 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 11so2497560ljf.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 Nov 2020 09:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xO9CxuCBhvzW1Ws/k0RGfox8BGRk7k3EPcuheLJVEXQ=;
        b=eM6mW5wfPzXfLK9fEWdWGAuJ9juIpbP3AHmE8CqLT9E5gpu7/PdKVywuzekXaeMYqj
         B2/TkSvZ8edTnPC/JzXaNp4IRPj7p2rfDwyboE2a9bUdvJjoMRmduJx0Fi2apJWCmtD2
         CN702xPwCQ4+rLrZfqG0ZsmlPh30bXZ04Nyw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xO9CxuCBhvzW1Ws/k0RGfox8BGRk7k3EPcuheLJVEXQ=;
        b=Oj44W+4G7fxirtejNyXnYZu7EjpthAz3GBYOpIOtFHg4clDQzCVnrd79K7U0B+bMH9
         rvM61IHyiy773ReevsVGb2oJshH55D8WqqPtLHi84FTuGVyg3EUfaNbs+a6czfM+lvG+
         8SeLwKfpXBzEAm18uLDjjrdyEWBTO4ZfpNHbs7YuanFoxiOYJRsL/BqFEfdp3cXN0yUN
         ioOrJrhuyLeykfCCLqVIXggFgBxqmEvzN+7IETJ94WhxVS1RAvtmsPfBZhkbNEwRqQOJ
         YzRozbytyCUdt7y8EJUMgQIskrn3+ApVn+eXOszNyWCmjQzHo/sWZIkxa0Z2upISLZgT
         sebA==
X-Gm-Message-State: AOAM530Vs1dHhwFvKclUW3LSHYiWIfnrjCliq98b8yaJS7DzDxwo+q/k
        HgdZTVDd0VQ19OegvTnBHN0Nv2SfrUhlgA==
X-Google-Smtp-Source: ABdhPJx8FhmDth63FiyF602DOc6C0Pv9sUMH+z0M6P0eQdFw8GyPzIrhhFhMfSUaG905u5CV7Z1vPA==
X-Received: by 2002:a2e:9f16:: with SMTP id u22mr1268758ljk.86.1604598605869;
        Thu, 05 Nov 2020 09:50:05 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id n5sm64429lfl.175.2020.11.05.09.50.02
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 09:50:05 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id l10so2487374lji.4
        for <linux-wireless@vger.kernel.org>; Thu, 05 Nov 2020 09:50:02 -0800 (PST)
X-Received: by 2002:a2e:89cc:: with SMTP id c12mr1219652ljk.136.1604598601912;
 Thu, 05 Nov 2020 09:50:01 -0800 (PST)
MIME-Version: 1.0
References: <1600753775-4745-1-git-send-email-cjhuang@codeaurora.org>
 <1600753775-4745-2-git-send-email-cjhuang@codeaurora.org> <20201104231128.GA3212577@google.com>
 <6563d6ac38368de40cd07ae36f230a86@codeaurora.org>
In-Reply-To: <6563d6ac38368de40cd07ae36f230a86@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 5 Nov 2020 09:49:49 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMAqF=OWDoQBD=WbwG9WmZsJwmOcjLESkRnLBu6GgqyHQ@mail.gmail.com>
Message-ID: <CA+ASDXMAqF=OWDoQBD=WbwG9WmZsJwmOcjLESkRnLBu6GgqyHQ@mail.gmail.com>
Subject: Re: [RFC 2/2] ath10k: allow dynamic SAR power limits via common API
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Abhishek Kumar <kuabhs@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 5, 2020 at 3:27 AM Carl Huang <cjhuang@codeaurora.org> wrote:
> On 2020-11-05 07:11, Brian Norris wrote:
> > On Tue, Sep 22, 2020 at 01:49:35PM +0800, Carl Huang wrote:
> >> +    if (ar->tx_power_2g_limit == 0 || ar->tx_power_5g_limit == 0)
> >
> > ath10k_mac_txpower_recalc() doesn't care about this -- why should you?
> > This also seems especially weird, because one of the 2 could be valid
> > nonzero values, and yet you're silently rejecting it. Regardless, the
> > following seems wrong:
> >
> Per current design, it's required for userspace to always set meaningful
> power limitations.

Well, that wasn't specified anywhere (in the docs nor in the nl80211
implementation); if one wanted to enforce that, it should probably go
in the nl80211 layer, not the driver implementation. Otherwise, we're
very prone to varying driver implementations (not a good thing).

> Now in V2, 0 will be treated as "don't have SAR on this range".

OK... I guess that's reasonable, although that should be explicitly
called out in nl80211.h.

Brian
