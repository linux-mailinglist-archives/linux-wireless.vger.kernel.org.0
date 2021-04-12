Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9274135C5B9
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 13:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbhDLLxY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 07:53:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44632 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237792AbhDLLxX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 07:53:23 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVv7l-000Kze-8E; Mon, 12 Apr 2021 14:53:03 +0300
Message-ID: <fce2a3554e227bc9116948e36477f4b657e9ebff.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Date:   Mon, 12 Apr 2021 14:53:00 +0300
In-Reply-To: <87v98rlod8.fsf@codeaurora.org>
References: <ee6d5faebc25c8fa447cf870cbc80b4236178756.camel@coelho.fi>
         <87v98rlod8.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: pull-request: iwlwifi-next 2021-04-12
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-04-12 at 14:43 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > Here's the first batch of patches intended for v5.13.  This includes
> > the four last patchsets I sent out for v5.13 with the usual development
> > work.  It also includes Emmanuel's series for adding the iwlmei driver,
> > including one patch by Alexander Usyskin in the misc drivers directory.
> > (which Greg asked us to push via our tree).
> 
> But no Acked-by from Greg? I would like to have that in the commit log.

Ugh, sorry, I thought Emmanuel had taken care of this and didn't check.
I'll check with him what's the situation with Ack'ing this.


> >  include/net/cfg80211.h                                 |   11 +-
> >  net/wireless/core.c                                    |    7 +-
> 
> Why are you changing cfg80211? Has this been checked with Johannes, at
> least I don't see any acks from him? I prefer making cfg80211 changes
> via Johannes' tree, smaller risk of conflicts that way.

Hmmm, this is a patch that I already sent to Johannes too, but I had a
mistake in it (some backport stuff slipped through).  I guess I'll send
him a v2 and then we need to wait with this pull-req until mac80211-
next reaches wireless-drivers-next... :(


> Also every commit seems to have Change-Id tag.

Argh.  Sorry about that.  Another of my hooks that was not installed on
my new machine.

--
Luca.

