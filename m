Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE5E19C605
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 17:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389255AbgDBPgF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 11:36:05 -0400
Received: from mx.sdf.org ([205.166.94.20]:50283 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732754AbgDBPgF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 11:36:05 -0400
Received: from sdf.org (IDENT:lkml@faeroes.freeshell.org [205.166.94.9])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 032FUYud026016
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Thu, 2 Apr 2020 15:30:35 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 032FUYVI019469;
        Thu, 2 Apr 2020 15:30:34 GMT
Date:   Thu, 2 Apr 2020 15:30:34 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        johannes@sipsolutions.net, Adham.Abozaeid@microchip.com,
        lkml@sdf.org
Subject: Re: [PATCH v3] staging: wilc1000: Use crc7 in lib/ rather than a
 private copy
Message-ID: <20200402153034.GB2013@SDF.ORG>
References: <20200326152251.19094-1-ajay.kathat@microchip.com>
 <20200402082745.GG2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402082745.GG2001@kadam>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 02, 2020 at 11:27:45AM +0300, Dan Carpenter wrote:
> I don't know how this patch made it through two versions without anyone
> complaining that this paragraph should be done as a separate patch...

I often fold comment (and spacing/formatting) patches in to a main
patch, when touching adjacent code anyway and it doesn't cause
distracting clutter.

This seemed like such a case, which is why I submitted it as one.
But it's a bit of style thing.

>> Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
>> Cc: linux-wireless@vger.kernel.org
>> Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>
>> Signed-off-by: George Spelvin <lkml@sdf.org>
>> ---
> 
> This should have you Signed-off-by.  The Reviewed-by is kind of assumed
> so you can drop that bit.  But everyone who touches a patch needs to
> add their signed off by.

Er... all he did was add "staging: " to the front of the title.

That's not a change to the code at all, and as trivial a change
to the commit message as adding "Reviewed-by:" to the end.
We don't need S-o-b for such things or we'd end up in a horrible
infinite recursion.
