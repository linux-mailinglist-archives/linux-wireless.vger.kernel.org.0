Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F814972D8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 08:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfHUGt3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 02:49:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35814 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfHUGt3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 02:49:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so940553wmg.0;
        Tue, 20 Aug 2019 23:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=qHmnifucWhjp23s3a4oAMHwPWOuCsbyJNm6S+/4qM8o=;
        b=hLj1EbaWDhxqhO76myPYLaHncGIAVJPFCYVT3y6bi0kxarjxWEYPSQZpH/0+SzLH9N
         AZKL3hidq+A57+4PLERJVqwmWeQ19iRwT1n1Xj/MKV8cLQ24xkoVgT6E9diivM2g8m3w
         d+hRIZ6Z7tuSL1MS6GuGXa9raRftXFbEAt+htZs2aMgCN+KpSWX/smIfbS0zQiKABYry
         AbCx0fe/14C8pAxi/HlJ4eqkOPjiEImaHmnKmDZVRP7k0QVaCq2Uo0sXu7hpRH6GjxuQ
         hT3p1YNmUgdDs+TUYKKMybwZivuxT0zrmm6Ww9dQeg8HFJGwuWBAOQbjc5FRnu9GcrEU
         +NNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=qHmnifucWhjp23s3a4oAMHwPWOuCsbyJNm6S+/4qM8o=;
        b=YyEWbRdCVm6ybGH/HzBs7WHnVAgD0cRkoIZTA9q77Kmydw3YA4dbfH1n7RJkWzt7w2
         XgImLendLClHQhWx6ZiGG/LSZttjo3AhEuSV53otxkufb5jiZuajPadlIEkJq31zymdR
         vLEEIIpJ9hRiQENVsWR9N+PrIrbrh3+iROsz42zAVBisgeBpU8Py2fi0cgjjCWUxkPxS
         fYIbD2dZTAqvSl11BUC5w3cUZSiFwjRQmwnoJ9xBFEHSngb2Jmk/P+0mYAZfRTfbJ6Yh
         y4knCwq0LwBxo4+RY902UOpRFi3TC7GbrbYtCCC/c9qebAs5cioWdEjaDLHmxTtRma/R
         YnCQ==
X-Gm-Message-State: APjAAAX8SO+zzwi3JFe6FuMHqCyp6PrKRCWDtIA85QP7UbDq1GAhsBvb
        kmyZQ3N1drMap8iXx/zQ48Cd/2n7XKe4kdGcIi0=
X-Google-Smtp-Source: APXvYqyuUFV+klctwIHlDjy8e7cOg3MvKi+wPwZeC967kGWWOmNnAYP6ILHMwgJTQs6Y17O5Md0Jq6M9lJyRvvJvPgs=
X-Received: by 2002:a05:600c:10ce:: with SMTP id l14mr4025608wmd.118.1566370167053;
 Tue, 20 Aug 2019 23:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190817041258.GA1641@chirva-slack.chirva-slack>
 <87y2zsf9ps.fsf@depni.sinp.msu.ru> <20190817214448.GB1070@chirva-slack.chirva-slack>
 <1b1e573e6502c97851838a3b27ac0b272198926c.camel@intel.com>
In-Reply-To: <1b1e573e6502c97851838a3b27ac0b272198926c.camel@intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 21 Aug 2019 08:49:15 +0200
Message-ID: <CA+icZUU6nX7KVir1CFBxZuVB-aHzw-QETKpDEwVsJD_X=1v1bg@mail.gmail.com>
Subject: Re: PROBLEM: 5.3.0-rc* causes iwlwifi failure
To:     Luciano Coelho <luciano.coelho@intel.com>
Cc:     Stuart Little <achirvasub@gmail.com>,
        Serge Belyshev <belyshev@depni.sinp.msu.ru>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 20, 2019 at 12:45 PM Luciano Coelho
<luciano.coelho@intel.com> wrote:
>
> On Sat, 2019-08-17 at 17:44 -0400, Stuart Little wrote:
> > After some private coaching from Serge Belyshev on git-revert I can
> > confirm that reverting that commit atop the current tree resolves the
> > issue (the wifi card scans for and finds networks just fine, no dmesg
> > errors reported, etc.).
>
> Sorry for the delay in responding, I had to go and dig in our FW
> sources to see what was going on.
>
> Unfortunately when this feature was implemented in the FW, we forgot to
> add the usual flag (capabilities TLV) that we add to let the driver
> know whether the command is supported or not.  So we need to match on
> the FW version instead, but apparently that doesn't work for all
> different NICs.
>
> I'll have to look into all NIC/FW-version combinations that we have and
> update the iwl_mvm_sar_geo_support() function accordingly, which is,
> BTW, the easier place for you to change if you want to workaround the
> issue.

For the records (here: Linux v5.2.y)

"iwlwifi: Add support for SAR South Korea limitation"
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-5.2.y&id=2b9d99b399d5e4cd516973a4c56035fb0e2ee744

- Sedat -
