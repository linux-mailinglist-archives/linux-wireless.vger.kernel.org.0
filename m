Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1ECB271D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 23:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfIMVQY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 17:16:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46161 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfIMVQY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 17:16:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id t1so13770935plq.13
        for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2019 14:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YUuz0V7V7oa0s38GRBhksIbT5ZdpiR5vkrUs8FdjOf0=;
        b=N0le8tizLl2mMsbCviqEdW+mOskA2nNdaNj3IYOFs6xh6/TL3B1v0/G3fOl02VRw1O
         5aO/w58RWzdstmiB3by7qgnzFiCdrRWic2VqH41KkAXUvRPZY7HW1TeHbaobx/mUrBVV
         Pe9HkgDED7AH68uHDTFFFd1XN3eFnJRqcY9y0T3pKmQV6bluzQtOW/N7q62jSUf2jLfd
         EWLSYAx5r0meCD7dpgHH+dgKQ8G8TPjdgIrqv5qmuwtX4LABy+LFtKpj3UCA7K4ENPj3
         abPj3/GITlDf8BYEQ4bcDFEV1RVlMlI72lkijByj4wjpJmObKjpFcFKIuUsRZ9HTtgcN
         fnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YUuz0V7V7oa0s38GRBhksIbT5ZdpiR5vkrUs8FdjOf0=;
        b=XzFOhAYDuXB1W5IfdJyHBlyNDF8eMtAxToBU8PvTbHtQU/SxqNUkn0j4fkXAoF/kf3
         tKFPsTXMDDsADuSLw7pPCnJ47gy0gMsAcNaqNbU5Smg2v7+hU7wDy7DdFkXQc69X/cHF
         /ouN5ru0bdYYSddXtU/Lbc/IcGLKhdDoPSz6wp4sW+WDvw9gE1531HCDngDZJ03M+Ex1
         xWWQDpg+bOLQshcvwB5ZTdyD+o0CDBrSrp3qW8QO6GQnXi+6XSFS2WJsHFLUwtdyEfcD
         UXLVSsAnvuloQfy9tbUMv1235zwjZEoF5DYz17RQfH7LhTzvhhbbvGIWtt/itzCAD2lr
         lNLA==
X-Gm-Message-State: APjAAAVn9xRZbjbBKOuVYBmzuIDCuRjfcFQQU9bOfp7wfPD/E2tBZyAs
        eZ0y32z7SWDaEi87giIXfnI=
X-Google-Smtp-Source: APXvYqzLNndXSjQBbfqXbMWEM9oj5hDLj227FoPRWogWIV1qq8AR9v5NXHnoekgT6IFk3OgzO3hoAw==
X-Received: by 2002:a17:902:a618:: with SMTP id u24mr48138629plq.342.1568409382767;
        Fri, 13 Sep 2019 14:16:22 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.googlemail.com with ESMTPSA id q21sm32491131pfh.18.2019.09.13.14.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Sep 2019 14:16:22 -0700 (PDT)
Message-ID: <b43f737c06a392957e6f651d59282a3f36fd05e5.camel@gmail.com>
Subject: Re: [PATCH 1/2] nl80211: Add LIVE_ADDR_CHANGE feature
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Fri, 13 Sep 2019 14:14:27 -0700
In-Reply-To: <47aaaccf7d8fb58587f0cfbe38acd18e1420dc9a.camel@sipsolutions.net>
References: <20190913195908.7871-1-prestwoj@gmail.com>
         (sfid-20190913_220113_419728_36032050) <6c85d9b108825939afb84ebc8a708a211f7e2b98.camel@sipsolutions.net>
         <38c222129dd182de4c55e536a89eada7f58a1bf1.camel@gmail.com>
         (sfid-20190913_225826_111097_E5ED9AB1) <47aaaccf7d8fb58587f0cfbe38acd18e1420dc9a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-09-13 at 23:01 +0200, Johannes Berg wrote:
> On Fri, 2019-09-13 at 13:56 -0700, James Prestwood wrote:
> > Hi,
> > 
> > On Fri, 2019-09-13 at 22:48 +0200, Johannes Berg wrote:
> > > On Fri, 2019-09-13 at 12:59 -0700, James Prestwood wrote:
> > > > Add a new feature bit signifying that the wireless hardware
> > > > supports
> > > > changing the mac address while the underlying net_device is
> > > > UP.  Note
> > > > that this is slightly different from IFF_LIVE_ADDR_CHANGE as
> > > > additional
> > > > restrictions might be imposed by the hardware.  Typical
> > > > restrictions
> > > > are:
> > > > 	- No connection is active on this interface, e.g.
> > > > carrier is
> > > > off
> > > > 	- No scan is in progress
> > > > 	- No offchannel operation is in progress
> > > 
> > > Hmm, what do you need this patch for?
> > > 
> > > IFF_LIVE_ADDR_CHANGE should be sufficient to discover it?
> > 
> > Because userspace needs to know if this is supported?
> > IFF_LIVE_ADDR_CHANGE is a private flag... AFAIK userspace has no
> > way of
> > obtaining this.
> 
> Oh, annoying.
> 
> But that doesn't really mean that nl80211 is an appropriate place to
> advertise it, IMHO?

The intention of the flag was not soley related to
CMD_CONNECT/CMD_AUTHENTICATE. Its an indication that the
hardware/driver supports a live address change. If you don't want it
here could you suggest a better location for it?

> 
> And in nl80211 you'd need the flag for if you actually have the
> "change
> MAC address during connect" attribute.
> 
> johannes
> 

