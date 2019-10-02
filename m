Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA05C44B4
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 02:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfJBAAL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 20:00:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44695 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbfJBAAL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 20:00:11 -0400
Received: by mail-io1-f66.google.com with SMTP id w12so24597196iol.11
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 17:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8XuORGyon1VOMPog0b9ChPguzhG8P8i4vzM4Xv8Uqzc=;
        b=kdX1+Dmx5NsPMOpihunGR2OJCSfrr4JjlntcxD7R+ALz1L+MwnXxobTL70wA2xhkk5
         DwZP8QdL0TeschpMkiVMjuu0HecXiTkp3/TUQUxR8jfV5r7muksNi7KIp1pnfeT1qLrK
         pccYQLe4dgK6uIpaQvVp3OawufdrG1ZyQ4SkHuzQf8Bg9tJT7PXAPfYD76GF4AbNmBQB
         hukUohuq02OJtHqySKMVLikBHYIhgnF8f+waZEVJ2RfBsJ2nU4ThtkOaxhjbHxr8Ujqa
         M0zgmpiK+fQjANVvcglvdKACVKLEB04RBxa9ReB0MAA9/Lah5GA2/d2gXIec4qthEjmA
         s1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8XuORGyon1VOMPog0b9ChPguzhG8P8i4vzM4Xv8Uqzc=;
        b=nBnERP99y3FyWmPEmiqPM8OriVDx18bqIk0fL9fXrBd1uD4dpnR3ku+RgX3zCOPzsa
         UFwyq/0va3rGVf0DTyc0D5NwJQ1/N+iydZfxfi2YONUVr5cxQgw9ZA/vu2Cmkd4EngVe
         FvjAmW4OVqyHlmcxF69AdlEy9e8O6yopailRPE4gy+W2df3rn0zSPggbALCW3kNyOJOg
         k4tart31UU1y/B0fh7wEeV6wd4daIYJr4y8tAu9kmK9r67/obkf87Kharx9a8HeHJXUm
         3k5m+L12FsVUw+cN36P4xTWTLV7T5tWJT17yiz6kp8sflXGx+M1rNZ6zE6xiOaeXMeRP
         Dfqg==
X-Gm-Message-State: APjAAAXxKPvXf5ZN+P9q7AGUDqiC6Uda2aBd9/i78Y8TdB0PNFbRjkZe
        tCKw1vX5pdpRcs9+zGBpKy3SPg==
X-Google-Smtp-Source: APXvYqzJARkEVuAEFbC8zVztAVf2Nk11aZ/GxPqcZs2fEKZIz912KOLJmKEHDG8oiQFWxDzoU4ZwHQ==
X-Received: by 2002:a02:638a:: with SMTP id j132mr1092256jac.100.1569974409183;
        Tue, 01 Oct 2019 17:00:09 -0700 (PDT)
Received: from hash.lan ([2607:fea8:5ac0:1dd8::d25])
        by smtp.gmail.com with ESMTPSA id m21sm7456621iob.82.2019.10.01.17.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 17:00:08 -0700 (PDT)
Received: from bob by hash.lan with local (Exim 4.92.2)
        (envelope-from <me@bobcopeland.com>)
        id 1iFS3r-0005XC-GC; Tue, 01 Oct 2019 20:00:07 -0400
Date:   Tue, 1 Oct 2019 20:00:07 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Ramon Fontes <ramonreisfontes@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Krishna Chaitanya <chaitanya.mgit@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
Message-ID: <20191002000007.GA20953@localhost>
References: <CABPxzYLrTC3kS86iyfq+RY=XEgjedu2MWPtn+i+H50jPz3oh3w@mail.gmail.com>
 <39d646206446159a2b0a67ee7d8667483ade0733.camel@sipsolutions.net>
 <CABPxzYL0i+YbKh-xMXsS-xWeQvwfFUvv7vGhugM1e+OFMOSHSg@mail.gmail.com>
 <CAK8U23bbiGhmDg-ChDJtbRVVc_6njVdoUjfAhqM+V3yfQXTC4Q@mail.gmail.com>
 <CABPxzY+8Jjvjv0x79yzo+rL3nONTZSkROK1T+gMqq5nhXb=7-g@mail.gmail.com>
 <CAK8U23bb9C+16zuGi+uAYxUg-goddiSZfDAJUYeC1Xpu=jud+Q@mail.gmail.com>
 <df3b53f157e113e309360ed40b1f36b9f08f4d8c.camel@sipsolutions.net>
 <CAK8U23YMeFcQPLfWTMijyJaiX1V+NO9FWmq70nhS+bLVNxFYkg@mail.gmail.com>
 <616a319e4b8623508f6cd00fcfca8303f494a2de.camel@sipsolutions.net>
 <CAK8U23Yrdw8dtO2jDQMMECWpnp=8LEOPqbfL5NQt4sjz3VjsDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8U23Yrdw8dtO2jDQMMECWpnp=8LEOPqbfL5NQt4sjz3VjsDQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 01, 2019 at 02:01:06PM -0300, Ramon Fontes wrote:
> > Now that I look at that, I think most likely the reason is commit
> > 119f94a6fefc ("cfg80211: Address some corner cases in scan result
> > channel updating") which was backported to the 4.18 series.
> 
> The problem is now fixed! :)
> Thank you so much for your support Johannes.
> 
> Sorry for my ignorance but where can I follow up with these wmediumd changes?
> https://p.sipsolutions.net/6c52392b5e31d9d1.txt
> 
> Btw, I've created a PR for this in the Bob's repo:
> https://github.com/bcopeland/wmediumd/pull/21/files

Thanks, I merged that.

-- 
Bob Copeland %% https://bobcopeland.com/
