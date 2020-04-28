Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2276D1BB7DE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 09:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgD1HlC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 03:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgD1HlC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 03:41:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4138C03C1A9;
        Tue, 28 Apr 2020 00:41:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so20357125ljl.6;
        Tue, 28 Apr 2020 00:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VSTKTi7V/q8CR6GcenKRp2sd1IMvYmp6ucZc3EIquso=;
        b=kOyFEvAD625k7UDFOwe9BZLpS7/vLFtFjHy216Sutod4zwnaNSUlio82wfoFHL5dhN
         b7RYEGF6sTA+ekHf8CJ61EF4VXftF0do3jrp0G5QJK8tvzEKVuBNXv+1E85fY0AzNfY5
         580zwNW6D0bPed8EeHBjhLEykcpe51TLmbaqT0LyuzZ2ycDarJmHWFQ/jHwmGD4xB5I9
         4/NAYvgP/4YuWe8pa22A5pq3oJ4If2NyucXWPFv2OM19Ms2f04mVieBce2CWd4eDPWtP
         5onydc7U0x8nATzGI+IgEwzH8b4u9Ki5MPx/EgO2W4sGG6CC3dtKNqnNwZQ1Jp1olqUX
         tMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VSTKTi7V/q8CR6GcenKRp2sd1IMvYmp6ucZc3EIquso=;
        b=kF+kMhRmsSJIEqGn0QsANvcg/PsJk+23mwoHyH9DnU5dt03dMdzjjuL0cVDSY4fOGJ
         WS3npISCIczvff36PhFteHDjI+C8BK3R8mZXhDdwTNmSpkaRbrMNL6X+mkqslWnPoS+H
         fZ5FNrE/uQFvGDWY0Oa7IYRDYWjG7TXtPnTtsP2E8UhrDrcoMokHunPGhruirPXyD+Io
         1dYhpMgpRl/mJl01jKdAoH2zwPma36mVO2mPlN8Id2JbzQoAMlis01hL6Gt/EJvhrTWA
         eFmznKq9r06sRDw+CauqBruo1Ns2l0WaZ0xvWty/hfGQBO+Qy8WVfiXzDF5ZiP5olY25
         SKJg==
X-Gm-Message-State: AGi0PuYTdsfCpFcZyKsqqlhWn4ruCo6QJCs69YvqdBN9SFf1TLlpidKE
        Vgt2PgiNs7Ie2iCUMFeGQPA=
X-Google-Smtp-Source: APiQypJdmUu6b0MWQu3fBzo17XXGzEpTTUzA724t8KPOwQjDlXn6PmWYi7HieJOZZAHyE3DW8Yyhgg==
X-Received: by 2002:a2e:9616:: with SMTP id v22mr17013316ljh.62.1588059660206;
        Tue, 28 Apr 2020 00:41:00 -0700 (PDT)
Received: from curiosity (ip-195-182-157-78.clients.cmk.ru. [195.182.157.78])
        by smtp.gmail.com with ESMTPSA id b16sm13482050lfj.2.2020.04.28.00.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 00:40:59 -0700 (PDT)
Date:   Tue, 28 Apr 2020 10:45:27 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mac80211-next tree
Message-ID: <20200428074527.GA3912@curiosity>
References: <20200428122930.51b6a9c2@canb.auug.org.au>
 <c3922c972277ff627c0308a94dfe3f25ba3b333f.camel@sipsolutions.net>
 <20200428072543.GA2630@curiosity>
 <baae77876a4b73de83aa6dcc27257da231777c22.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baae77876a4b73de83aa6dcc27257da231777c22.camel@sipsolutions.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 28, 2020 at 09:24:16AM +0200, Johannes Berg wrote:
> On Tue, 2020-04-28 at 10:25 +0300, Sergey Matyukevich wrote:
> > On Tue, Apr 28, 2020 at 09:01:30AM +0200, Johannes Berg wrote:
> > > On Tue, 2020-04-28 at 12:29 +1000, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > After merging the mac80211-next tree, today's linux-next build (x86_64
> > > > allmodconfig) failed like this:
> > > > 
> > > > Caused by commit
> > > > 
> > > >   6cd536fe62ef ("cfg80211: change internal management frame registration API")
> > > 
> > > Yeah. I forgot about staging. I guess I'll throw in a quick fix.
> > > 
> > > johannes
> > 
> > Hello Johannes,
> > 
> > Could you please take a look at the following fix for this issue:
> > https://patchwork.kernel.org/patch/11509497/
> 
> Heh. I was just fixing it too, missed your patch. How do you like this
> fix?
> 
> https://p.sipsolutions.net/0638ee56c2e48a30.txt

Looks good. But I have a couple of questions:

- why cleanup vif->mgmt_frame_reg in wilc_mac_open ?

- previously wilc_wfi_p2p_rx was called only for PROBE_REQ and ACTION,
  now it will be called for all the other registred frames as well

Regards,
Sergey
