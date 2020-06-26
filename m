Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520C020AE3E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 10:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgFZIK6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 04:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgFZIK6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 04:10:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD42C08C5C1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2020 01:10:58 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jojRm-00CLIn-L0; Fri, 26 Jun 2020 10:10:54 +0200
Message-ID: <7ea684a4d2d430030295bf9646238e03ad46e4cd.camel@sipsolutions.net>
Subject: Re: [PATCH 7/9] wmediumd: add the ability to write a pcapng file
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bob Copeland <me@bobcopeland.com>
Cc:     me@bcopeland.com, linux-wireless@vger.kernel.org
Date:   Fri, 26 Jun 2020 10:10:43 +0200
In-Reply-To: <20200626031006.GC14303@bobcopeland.com> (sfid-20200626_051012_737630_02B423F6)
References: <20200625130844.22893-1-johannes@sipsolutions.net>
         <20200625150754.554b7fc226a1.I14409b6cb5998e7bd087c1329952fbfa1a30d45e@changeid>
         <20200626031006.GC14303@bobcopeland.com>
         (sfid-20200626_051012_737630_02B423F6)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-06-25 at 23:10 -0400, Bob Copeland wrote:
> On Thu, Jun 25, 2020 at 03:08:42PM +0200, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > Add the ability to write a pcapng file containing all the data.
> > The radiotap header is currently very minimal with only the
> > frequency and the signal strength.
> > +	if (!filename)
> > +		return;
> > +
> > +	ctx->pcap_file = fopen(filename, "w+");
> 
> I know it doesn't actually matter, but would be nice to close this
> somewhere.

Hah, true.

I guess we could now add to the control socket a way to quit wediumd
that doesn't involve killing it, and then that starts being a bit more
relevant :)


johannes

