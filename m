Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD2C149E7D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 05:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgA0EZF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 23:25:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41155 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0EZF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 23:25:05 -0500
Received: from mail-yb1-f199.google.com ([209.85.219.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1ivvxP-0001W5-76
        for linux-wireless@vger.kernel.org; Mon, 27 Jan 2020 04:25:03 +0000
Received: by mail-yb1-f199.google.com with SMTP id o82so6784164ybc.18
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2020 20:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ncNHyL05RjLNXt8zPvZ6gJhRQry1ZuLpxwmOk+lMSv0=;
        b=EIsTOtn7pfMGJrSDoT0suk5DZZibJDY1ls6lXyyDnGSFQjZxs0GKxoFbdF2PFKcK+J
         FARFNZvv6wpFzlIx7+CDM/t8VzU36fBXMbuBOfaiMF7QZSB9iZa1Vtv/mU988DInlmYe
         ANG9kNYVSUef2UiKo70rgHbLgPWSEIVVR26nvfqHaM7yu8NsLP5Eo9QQ7qWwXuuP73fL
         +U1yTRuzKqOIt2P2RLqAX6CtHCWLkmR80tlw/U8jwSoc4haHHyoLuQEGXaKjQR7J4OP/
         iOhPfuLE2Bm3e3cUQUiK6pjqWUR+c1yldGra7iYa4FBgZXwauKWn46wvgpicaRth8Hn6
         KHmw==
X-Gm-Message-State: APjAAAXf+ohMhxy1P4MJylOTrW+Wcg3ZVMOH0goDwwcYiRZHNIDBEyYS
        WvRUEVAoVnQl2J3IYeqxJ0AkIK1Bj6MQowWzAFqvyHYmlVillf+ah+Mg2pwSwH04h2+jNON+Wt/
        b3m+HpRakQhU/xFuX1DzquSLXOPqOm3joBNeAGCRnZyWP
X-Received: by 2002:a0d:eb50:: with SMTP id u77mr11534921ywe.104.1580099102205;
        Sun, 26 Jan 2020 20:25:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqzyJLZoyuqcw+WzSTIUDazMlu8K6H2zwi2qtBnivkB4ZI+J3Vay4l5kKXYFs2DUsxo5Q669yA==
X-Received: by 2002:a0d:eb50:: with SMTP id u77mr11534912ywe.104.1580099101880;
        Sun, 26 Jan 2020 20:25:01 -0800 (PST)
Received: from localhost ([2605:a601:af9b:a120:2508:7928:f79b:3f69])
        by smtp.gmail.com with ESMTPSA id x184sm5798210ywg.4.2020.01.26.20.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 20:25:01 -0800 (PST)
Date:   Sun, 26 Jan 2020 22:25:00 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Dmitry Tunin <hanipouspilot@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wireless-regdb: update regulatory rules for
 Kazakhstan (KZ)
Message-ID: <20200127042500.GE3730@ubuntu-xps13>
References: <1567189484-27536-1-git-send-email-hanipouspilot@gmail.com>
 <20191029144815.GR30813@ubuntu-xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029144815.GR30813@ubuntu-xps13>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 29, 2019 at 09:48:15AM -0500, Seth Forshee wrote:
> On Fri, Aug 30, 2019 at 09:24:44PM +0300, Dmitry Tunin wrote:
> > Update according to the regulatory rule of January 21, 2015
> > 
> > http://egov.kz/cms/ru/law/list/V1500010730
> > https://tengrinews.kz/zakon/pravitelstvo_respubliki_kazahstan_premer_ministr_rk/svyaz/id-V1500010730/
> > 
> > No DFS or TPC is mentioned in the document. Neither is 80 MHz channel width.
> > 
> > Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
> 
> Thanks for the patch. I don't agree with all of your changes though,
> please see details below.

Hi Dmitry - it's been a while since I sent this last email. I wanted to
check if you had any responses to my comments below, or if you intend to
send a v3 patch.

Thanks,
Seth

> 
> > ---
> >  db.txt | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/db.txt b/db.txt
> > index 37393e6..491598e 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -717,13 +717,13 @@ country KY: DFS-FCC
> >  	(5735 - 5835 @ 80), (30)
> >  
> >  # Source:
> > -# http://mic.gov.kz/sites/default/files/pages/pravila_prisvoeniya_polos_chastot_no34.pdf
> > -# http://adilet.zan.kz/rus/docs/P000001379_
> > -country KZ: DFS-ETSI
> > -	(2402 - 2482 @ 40), (20)
> > -	(5150 - 5250 @ 80), (20), NO-OUTDOOR, AUTO-BW
> > -	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW
> > -	(5470 - 5725 @ 80), (20), NO-OUTDOOR, DFS
> > +# http://egov.kz/cms/ru/law/list/V1500010730
> > +# https://tengrinews.kz/zakon/pravitelstvo_respubliki_kazahstan_premer_ministr_rk/svyaz/id-V1500010730/
> > +country KZ:
> > +	(2400 - 2483.5 @ 40), (20)
> > +	(5150 - 5350 @ 160), (23), NO-OUTDOOR
> > +	(5470 - 5850 @ 160), (20), NO-OUTDOOR
> 
> The documents you provided reference this document:
> 
> https://egov.kz/wps/poc?uri=mjnpa:document&language=ru&documentId=V1500010375#z7
> 
> Which says that bands 5150-5350 MHz and 5470-5725 MHz should conform to
> WRC-12 resolution 229:
> 
> https://www.itu.int/dms_pub/itu-r/opb/act/R-ACT-WRC.9-2012-PDF-E.pdf
> 
> This indicates that 5250-5350 MHz and 5470-5725 MHz must either have TPC
> or reduce the maximum EIRP by 3 dBm, which for this database means
> reducing the maximum power by 3 dBm for these bands. It also states that
> these bands must implement the mitigation measures from ITU-R M.1652-1
> in these bands, i.e. DFS.
> 
> So it appears to me that the existing DFS requirements are correct.
> I think 5150-5250 MHz can be raised to 23 dBm, and 5250-5350 MHz needs
> to remain at 20 dBm due to the TPC requirement. WRC-12 does mandate TCP
> for 5470-5725 MHz, but also a maximum EIRP of 1W, so since 100 mW is far
> less than half of that I suspect we can leave that at 20 dBm.
> 
> > +	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
> 
> This addition looks fine to me.
> 
> Thanks,
> Seth
> 
> >  
> >  country LB: DFS-FCC
> >  	(2402 - 2482 @ 40), (20)
> > -- 
> > 2.7.4
> > 
