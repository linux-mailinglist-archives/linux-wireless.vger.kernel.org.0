Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E79B07302D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 15:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfGXNqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 09:46:50 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:54140 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfGXNqt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 09:46:49 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hqHbT-0006r8-Te; Wed, 24 Jul 2019 15:46:47 +0200
Message-ID: <9ce1c5ae216a3eee207a39e2c052b415454066a2.camel@sipsolutions.net>
Subject: Re: [RFC V2 0/8] nl80211: add 6GHz band support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 24 Jul 2019 15:46:45 +0200
In-Reply-To: <16c243667a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> (sfid-20190724_154045_005700_42DE9EB6)
References: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
         <fbacce3dd78c2154ee21c4f26f76a18a18349f45.camel@sipsolutions.net>
         <16c243667a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
         (sfid-20190724_154045_005700_42DE9EB6)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-07-24 at 15:40 +0200, Arend Van Spriel wrote:
> 
> > > The only place I could find an
> > > issue with this is in cfg80211_wext_freq(). Not sure how to deal with
> > > that so it is not part of this series.
> > 
> > Just finally break wext and say if you want to use 6 GHz you need to use
> > nl80211? :)
> 
> Probably is true for he support as well. Not sure. Have not been using wext 
> for the last decade ;-)

Me neither, our official releases don't even support it.

Btw, there's a compiler warning introduced by the first patch, I think
the fix is trivial though to add the 6GHZ in one place in mac80211
already.

johannes

