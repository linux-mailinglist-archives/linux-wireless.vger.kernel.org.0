Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9119A1BB86C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 10:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgD1IGI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 04:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgD1IGH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 04:06:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47F6C03C1A9;
        Tue, 28 Apr 2020 01:06:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so20458518ljb.9;
        Tue, 28 Apr 2020 01:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e/ZfrxrHaYp4ZY3rObwWUQUSJ2Md/wwi7RL79f3Bw7g=;
        b=DmPwSr7xJlCyMCcEaFZybSuG7ZAcfiJwG34dztFSi3q5fNbsj8VzbwMLnIQ6mmWMAW
         5esvm2E5nriVmjw3lwhHrjGYII8gFN9PclS9ZJTllscECVx/+nL1VfL9yLftlXca4vnz
         hz1ht8NerFYx1CjyLpCsBkstnqGMIZM4VxRmr3ZQbf8GcmFfaUjgMjDS36exqvzZzSM8
         6ZN46nbAdhZsR6y7/F0ALFyhLNPLPbQbZCRgt/fFeTUhDZHrTZAPs5p3jwqepaBA8d8p
         baXAXMtaxcAmPZSerfJF1Voseb5pehgY7bJgt5DNtPlZwhiD0uTAuT0c6ZTS7dMq+6vT
         HBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e/ZfrxrHaYp4ZY3rObwWUQUSJ2Md/wwi7RL79f3Bw7g=;
        b=BZcKtEYsr/3MViHD4TXZLxZ3hwfWISkL2b96FV8EJ/bdxY/BcfoSnWiuJPBuNM122C
         JavIczOH9bmpe/uhaLoYuWSx26wQ/iUek7zfl2bWK6+HOPsj3MvP7gIFwT5oW+an9xlb
         PnldkZgdVZGpwKYpUP9gkMtthqM6GPMtsPPkh8fw5bsf5EH70xmj3LQOGzNMP/5Gmpez
         KgCJkUBDJajZvmtMc6YUOQyRuysdSU+pczHqgy5GB3E95JUg2pX+YtsCT85qeHIVuiwY
         NPYJHOvLCwuOIxwhhurQ6sBXQBkALcktf1xolUNCAbOMdE3U9y8yHG+oNqxuVuWqdz+I
         RAFg==
X-Gm-Message-State: AGi0PuYkfmG8UyBBLcr+xUjB0bKOlKNAXJtUI/p21TTwEKX/s7EVJaes
        7NKCgDMt9CW9D6lkNis4FkQ=
X-Google-Smtp-Source: APiQypI2pEdiPylKtG2Ev1FBU5piF1Pn+Gc4EEL7/7yFhPJGVS68CpPOD8Thq3mqNDJCz5aHdkYNcQ==
X-Received: by 2002:a2e:b0c5:: with SMTP id g5mr16867541ljl.203.1588061164257;
        Tue, 28 Apr 2020 01:06:04 -0700 (PDT)
Received: from curiosity (ip-195-182-157-78.clients.cmk.ru. [195.182.157.78])
        by smtp.gmail.com with ESMTPSA id k18sm16064282lfg.81.2020.04.28.01.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 01:06:03 -0700 (PDT)
Date:   Tue, 28 Apr 2020 11:10:31 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mac80211-next tree
Message-ID: <20200428081031.GA4287@curiosity>
References: <20200428122930.51b6a9c2@canb.auug.org.au>
 <c3922c972277ff627c0308a94dfe3f25ba3b333f.camel@sipsolutions.net>
 <20200428072543.GA2630@curiosity>
 <baae77876a4b73de83aa6dcc27257da231777c22.camel@sipsolutions.net>
 <20200428074527.GA3912@curiosity>
 <40afd04ed8fb49088268e7d3316d3fef9aa8dbd9.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40afd04ed8fb49088268e7d3316d3fef9aa8dbd9.camel@sipsolutions.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > Looks good. But I have a couple of questions:
> > 
> > - why cleanup vif->mgmt_frame_reg in wilc_mac_open ?
> 
> Otherwise wilc_update_mgmt_frame_registrations() will think there are no
> changes whatsoever, and do nothing.
> 
> > - previously wilc_wfi_p2p_rx was called only for PROBE_REQ and ACTION,
> >   now it will be called for all the other registred frames as well
> 
> 
> Huh, good catch. How about this?
> 
> https://p.sipsolutions.net/51183f5492f05ea6.txt

Ok, this one looks good to me.

Regards,
Sergey
