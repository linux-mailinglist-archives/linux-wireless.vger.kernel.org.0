Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D126A66823
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfGLIDH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 04:03:07 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:54390 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfGLIDG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 04:03:06 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hlqWG-0005M7-MJ; Fri, 12 Jul 2019 10:03:04 +0200
Message-ID: <f5ace7f72e058b33adcccad1bb5ba07c21751386.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] nl80211: Add support for EDMG channels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexei Lazar <ailizaro@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Date:   Fri, 12 Jul 2019 10:03:03 +0200
In-Reply-To: <b3b97ea0dbe2fe115976c2728a041171@codeaurora.org>
References: <1561458567-31866-1-git-send-email-ailizaro@codeaurora.org>
         <1561458567-31866-2-git-send-email-ailizaro@codeaurora.org>
         <77b693b163faf61d72b2734b97081734f0345211.camel@sipsolutions.net>
         <b3b97ea0dbe2fe115976c2728a041171@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Alexei,

> Channels is a bitmap of 2.16GHz (normal) channels 1..6
> bw_config defines the allowed combinations (bonding) of these "normal"
> channels.

But bw_config is not itself some sort of bitmap, it's just a kind of
enum value, right? Maybe we should actually use an enum for it rather
than having the hardcoded values?

> Let's say driver reports support for channels number 1,2,3 
> (channels=0x7).
> Example #1: driver reports bw_config=5
> bw_config=5 allows combinations of 1 or 2 channels.
> It means driver can operate in one of these combinations:
> Channel 1 only
> Channel 2 only
> Channel 3 only
> Channels 1+2 (cb2)
> Channels 2+3 (cb2)

OK.

> The primary channel BTW must be one of the operational channels so if
> driver choose channels 1+3 then primary channel cannot be 2.

Makes sense.

> > It seems to me that you should, however, expose n_bonded_ch to
> > userspace? We do expose all the details about the bitrate normally, see
> > nl80211_put_sta_rate(). We do calculate the bitrate to expose that too,
> > but do expose all the details too.
> > 
> > Hmm. Looking at that, it looks like DMG doesn't actually do that. So
> > perhaps not, though it seems to me that it ought to be possible?
> 
> We will look into that and address in separate patch.

Right, separate patch definitely makes sense. Thanks!

> > > +	/* check bw_config against contiguous edmg channels */
> > > +	switch (chandef->edmg.bw_config) {
> > > +	case 4:
> > > +	case 8:
> > > +	case 12:
> > > +		if (max_continuous < 1)
> > > +			return false;
> > > +		break;

I think that indeed this could be clearer if you have an enum.

johannes

