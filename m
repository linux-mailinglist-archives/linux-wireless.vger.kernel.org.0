Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4ABA2DDB40
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 23:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgLQWZ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 17:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgLQWZ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 17:25:28 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C71C0617A7
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 14:24:48 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id q22so268594pfk.12
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 14:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FddPVaFthL4eYBtEYJxiDk/v9Sz7IGRrAfmIr7YH5kU=;
        b=mBanfuG2gNqY8/e6kX428ecgXtrq1Hhgtgh3Kgr06MX0JL5rZgZBp7qDnL/JS3Kvf3
         mMb1p+oDu23YKrXqkAeKOHYtsmj9SsXdlFR+70RbdS8rsCNJ4qdl5nulZLil4lO0NHTd
         f51qpQQffWSH8R965jLY+KDQBWr2xWYRybSrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FddPVaFthL4eYBtEYJxiDk/v9Sz7IGRrAfmIr7YH5kU=;
        b=M5NL6A7CZ8D9/eW6Qv/6d7JYRJ4SBeumZH55ieWZNtewPMBcMRR5JGijBEGQk+s+fj
         qAwkWvb72TpeE0eRssbHLbVPuS+dHPXs0wd6RplgPefNanKhsVp8eRhMYeNsansI9fPz
         yptZkymLh+kYHIYwLR94EBGW08RupVtXrg0iEFdMWQMj5KV3mUkNLQ74LUjPTCsi9Xfe
         GXPDuRncxRYkITzFb7lcZCohe4A0lH5sQetPoqkjs5zXC9UFHDpdqUROIYrHmaTujWwY
         51vd/0f3cUT6p2DXGi3S3hyoJq2OqEJru6uJ0zJMK7+Bq2EVyr/cXBUdEbvyvZfDxw7k
         ki6Q==
X-Gm-Message-State: AOAM532j/6XAtFqaMo3ek9tfmN04oO08ehEVBUVzt0vBJ89iZIny/KRK
        Kh+cZBG2i+29fspUr5WxGU1qGg==
X-Google-Smtp-Source: ABdhPJwK9wTmnZIHuMjcdHRA37ZdgUOZIdb4Rh734ONEykhvdRCref4kS//ATnPrZU3O1wxVvvqodA==
X-Received: by 2002:aa7:8486:0:b029:19e:307f:2941 with SMTP id u6-20020aa784860000b029019e307f2941mr1008725pfn.26.1608243887595;
        Thu, 17 Dec 2020 14:24:47 -0800 (PST)
Received: from google.com ([2620:15c:202:201:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id c205sm6775165pfc.160.2020.12.17.14.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 14:24:46 -0800 (PST)
Date:   Thu, 17 Dec 2020 14:24:43 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     Youghandhar Chintala <youghand@codeaurora.org>,
        johannes@sipsolutions.net, ath10k@lists.infradead.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuabhs@chromium.org,
        dianders@chromium.org, pillair@codeaurora.org
Subject: Re: [PATCH 0/3] mac80211: Trigger disconnect for STA during recovery
Message-ID: <X9vaqxub2F/8YPT8@google.com>
References: <20201215172113.5038-1-youghand@codeaurora.org>
 <18dfa52b-5edd-f737-49c9-f532c1c10ba2@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18dfa52b-5edd-f737-49c9-f532c1c10ba2@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Dec 15, 2020 at 10:23:33AM -0800, Ben Greear wrote:
> On 12/15/20 9:21 AM, Youghandhar Chintala wrote:
> > From: Rakesh Pillai <pillair@codeaurora.org>
> > 
> > Currently in case of target hardware restart ,we just reconfig and
> > re-enable the security keys and enable the network queues to start
> > data traffic back from where it was interrupted.
> 
> Are there any known mac80211 radios/drivers that *can* support seamless restarts?
> 
> If not, then just could always enable this feature in mac80211?

I'm quite sure that iwlwifi intentionally supports a seamless restart.
From my experience with dealing with user reports, I don't recall any
issues where restart didn't function as expected, unless there was some
deeper underlying failure (e.g., hardware/power failure; driver bugs /
lockups).

I don't have very good stats for ath10k/QCA6174, but it survives
our testing OK and I again don't recall any user-reported complaints in
this area. I'd say this is a weaker example though, as I don't have as
clear of data. (By contrast, ath10k/WCN399x, which Rakesh, et al, are
patching here, does not pass our tests at all, and clearly fails to
recover from "seamless" restarts, as noted in patch 3.)

I'd also note that we don't operate in AP mode -- only STA -- and IIRC
Ben, you've complained about AP mode in the past.

Brian
