Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D160E3FB9B9
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Aug 2021 18:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbhH3QFL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 12:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbhH3QFL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 12:05:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E26C061575
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 09:04:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so383617wma.0
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3npUBe0XXavbP8WJVaMhY8ZrHdW9iFAEaPwrx+1F2i0=;
        b=kv/ORKs5fUBu03T9lYN00LUW3/FMATroXsOwxoFjOFNug/sQgvDLh0tctoL2fXQxYo
         SR289eCcNIv147Ay4HyVDUI03bgCZfwuGWbf5TohJc3zLcKM/OuApjauGDs/FCdO5K09
         mG7HqNmiPPl7E/a1EN1+ShguTllaaD/IqrtEGg7R7RAE3sknnKruk7tLkQ2mwg7sWS/f
         F7aGQC53inGpcPCSFItJ2qopObAYSW9zbBdh2RqGdTsHZ84b9CBphrZpRHq2C7VrPz5q
         odtFR3mLTRPaHqThfGnRyXUqUqsTrW64wk8zWZUr0fqk6zCpxzZo7aXiUCBoOqc5L3zG
         k3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3npUBe0XXavbP8WJVaMhY8ZrHdW9iFAEaPwrx+1F2i0=;
        b=kzWwu1/XJBW7P+ME+bsne0qdZSftim5TOLlW+lJPrpGWs7eBtaiZKgy5K8bKpWg4i2
         VYspkaA7fM9PFQ2fB1aEN/NeX3qUv1+7sKNp+yAv+fK27JL5F3yuDK3PTvOnthX3p+Zh
         OMxGzrWz0RUZAmBadqAEwCtu1+hXKqqj0MLMHMjSy46j+YzuRaxQUS4wnz9NBij9G066
         xdCVV+mqmHaSbl6UlTAbHJsofzBBXLiy9KmLVjuF0Vyr/jGHPJ7uIK/eNNbaawwSfJnK
         mGpsavqsDO3kDal5H5OihEsVq6QMb/EF06es5g74OjNNKlzrx0V+9bRnZMWLPOwCA3Nk
         vW8w==
X-Gm-Message-State: AOAM532D/o6GcU2OTHiy15HeWQpSMtL85cXrriq0v5UpTiNazP0dZrqj
        iqME6eOLVZXzqa4CYmjdSFpBqK1gViOo8p4mnM2pkUmToN8=
X-Google-Smtp-Source: ABdhPJwaWkgvsaMall0VM9NOjtmefWQszHwRhhuB9zaGdOGdRexopmsYFCb6Sec9eOkCckSGGtgDjC9xfGjhONmwnnA=
X-Received: by 2002:a05:600c:14c6:: with SMTP id i6mr14912005wmh.99.1630339455825;
 Mon, 30 Aug 2021 09:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <a8cddf24-ecfc-088e-27f4-98cbbb5fb67c@penguintechs.org>
 <87y28sqq4l.fsf@codeaurora.org> <843e7689-fa1e-441b-c49a-ed7291046d5f@freebox.fr>
 <87tujgqcth.fsf@codeaurora.org> <87mtp47073.fsf_-_@codeaurora.org>
 <YSenaxWzxRkYkucv@kroah.com> <20210826074850.16768dee@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87eeag6yjr.fsf@codeaurora.org> <87y28o5cw4.fsf@codeaurora.org>
 <20210826111207.364d0ba5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <87sfyv5abg.fsf@codeaurora.org>
In-Reply-To: <87sfyv5abg.fsf@codeaurora.org>
From:   Nicolas Schichan <nschichan@freebox.fr>
Date:   Mon, 30 Aug 2021 18:04:04 +0200
Message-ID: <CAHNNwZD2dLC9dWui7kAEg8R04U0LVdQJMJCyugkHA6rdfRwGLQ@mail.gmail.com>
Subject: Re: [regression] Re: 5.14 rc6 broken for QCA6390 on Dell XPS 13 9310
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Wren Turkal <wt@penguintechs.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 27, 2021 at 2:41 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> > Done, thank you!
>
> Thank you waiting for me :)
>
> I just tested commit 7e9965cddea8 from Linus' tree on Dell XPS 13 9310
> laptop with QCA6390 and ath11k works without problems. So the issue
> should be solved in the final v5.14 release.
>

Good evening,

I have tested loading ath11k on v5.14.0 and I can confirm that the
driver loads fine now, with a phy and wlan interface being created as
a result.

Thanks and best regards,

-- 
Nicolas Schichan
