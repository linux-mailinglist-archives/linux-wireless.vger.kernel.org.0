Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 302DA19B4ED
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 19:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbgDARyC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 13:54:02 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:46340 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgDARyC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 13:54:02 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jJhYt-00CpUg-QA; Wed, 01 Apr 2020 19:53:59 +0200
Message-ID: <693acec3b0c76583e82579e7cc95a22274c3b1da.camel@sipsolutions.net>
Subject: Re: [RFC 3/7] mac80211: handle channel frequency offset
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 01 Apr 2020 19:53:58 +0200
In-Reply-To: <7b3b34dd-882a-73e7-f857-8e581c3f7bc0@adapt-ip.com>
References: <20200401062150.3324-1-thomas@adapt-ip.com>
         <20200401062150.3324-4-thomas@adapt-ip.com>
         <7fc6331597f53f5d100f3aa7e29434c20cf6fe90.camel@sipsolutions.net>
         <7b3b34dd-882a-73e7-f857-8e581c3f7bc0@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-04-01 at 10:39 -0700, Thomas Pedersen wrote:
> On 3/31/20 11:59 PM, Johannes Berg wrote:
> > On Tue, 2020-03-31 at 23:21 -0700, Thomas Pedersen wrote:
> > > ie. ignore
> > > for mesh, ibss, HT/VHT specific stuff, TDLS, etc.
> > 
> > This makes sense, but I don't see that you prevent using mesh, ibss and
> > perhaps TDLS on s1g channels?
> > 
> > Or do we not expect drivers/devices that support this, as well as S1G
> > channels?
> 
> Well it's really orthogonal to S1G (maybe a new 2412.5Mhz channel opens
> up :)). We should probably return an error 'if (chan->freq_offset)' or
> so for features which have not yet been tested / implemented for
> frequency offset.

OK, fair enough.

johannes

