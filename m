Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B03E19E702
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Apr 2020 20:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgDDSQO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Apr 2020 14:16:14 -0400
Received: from mx.sdf.org ([205.166.94.20]:63353 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgDDSQO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Apr 2020 14:16:14 -0400
Received: from sdf.org (IDENT:lkml@faeroes.freeshell.org [205.166.94.9])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 034IFgcI029629
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 4 Apr 2020 18:15:42 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 034IFfdc000897;
        Sat, 4 Apr 2020 18:15:41 GMT
Date:   Sat, 4 Apr 2020 18:15:41 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, Ajay.Kathat@microchip.com,
        gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        Adham.Abozaeid@microchip.com, johannes@sipsolutions.net,
        lkml@sdf.org
Subject: Re: [PATCH v3] staging: wilc1000: Use crc7 in lib/ rather than a
 private copy
Message-ID: <20200404181541.GC11944@SDF.ORG>
References: <20200326152251.19094-1-ajay.kathat@microchip.com>
 <20200402082745.GG2001@kadam>
 <20200402153034.GB2013@SDF.ORG>
 <20200403091029.GC2001@kadam>
 <20200403234028.GA11944@SDF.ORG>
 <20200404172537.GI2066@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404172537.GI2066@kadam>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Apr 04, 2020 at 08:25:37PM +0300, Dan Carpenter wrote:
> On Fri, Apr 03, 2020 at 11:40:28PM +0000, George Spelvin wrote:
>> I understand that it's addressed more to patch authors than
>> maintainers forwarding them, but I've read that thing a dozen times,
>> and the description of S-o-b always seemed to be about copyright.
> 
> It's to say that you didn't add anything which you shouldn't have, for
> example, secret SCO UnixWare stuff.

Yes, I'm familiar with the (irritating) history.  Which is why I
had the idea stuck in my head that that it was all about copyright
and if you didn't add anything copyrightable, an S-o-b wasn't
required.  No more than I'd ask for one from the administrator
of the e-mail system which delivered it.

submitting-patches.rst says "sign your work".  It didn't occur to
me to sign something that wasn't my work.

>> So I had assumed that edits which were below the de minimus standard
>> of copyright didn't need a separate S-o-b.
>> 
>> Am I right that there should be an S-o-b from everyone from the
>> patch author to the patch committer (as recorded in git)?  And the
>> one exception is that we don't need S-o-b for git pulls after that,
>> because the merge commits record the information?
> 
> Yes.  Also if people added their S-o-b for git merges it would change
> the git hash for the patch which would suck.

I understand the technical difficulties, but lawyers aren't always
deterred by such things. :-)  Seriously, it's clear there has to
be an exception; the question was about the scope of the exception.

Thank you for your patience clarifying this stuff for the nth time.
