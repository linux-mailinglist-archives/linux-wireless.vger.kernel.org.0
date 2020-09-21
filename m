Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26CE271B21
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 08:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIUGyI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 02:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUGyI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 02:54:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB11C061755
        for <linux-wireless@vger.kernel.org>; Sun, 20 Sep 2020 23:54:08 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kKFiA-00849u-KG; Mon, 21 Sep 2020 08:54:06 +0200
Message-ID: <215a340b904177c779b7cdd2ecd291d7a0170265.camel@sipsolutions.net>
Subject: Re: [PATCH v2 11/22] cfg80211: parse S1G Operation element for BSS
 channel
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 21 Sep 2020 08:54:05 +0200
In-Reply-To: <ef2b1e8b8b2755793a8db2b00e4130a7@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
         <20200831205600.21058-12-thomas@adapt-ip.com>
         <c0d5ddf778f4e8814195b6982275577a8803433f.camel@sipsolutions.net>
         <ef2b1e8b8b2755793a8db2b00e4130a7@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-09-20 at 22:12 -0700, Thomas Pedersen wrote:
> On 2020-09-18 03:45, Johannes Berg wrote:
> > On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
> > > Extract the BSS primary channel from the S1G Operation
> > > element.
> > 
> > Out of curiosity, do you even need to?
> > 
> > I mean ... you know what channel you received it on, surely?
> 
> Consider the case where the BSS is operating @ 2Mhz, but primary is one 
> of
> the 1Mhz channels. The hardware (or driver) may not be able to tell you
> exactly which primary channel (upper or lower) the packet came in on.

Ah, OK, makes sense. Somehow based on a comment somewhere else I thought
you were saying that the channels are basically all unique in their
(center frequency, bandwidth) tuple, and was assuming you'd actually
have to scan them that way.

johannes

