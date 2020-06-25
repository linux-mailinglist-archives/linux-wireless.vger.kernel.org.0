Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEDE209B6F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 10:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390004AbgFYIke (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 04:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgFYIke (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 04:40:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9041C061573
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 01:40:33 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1joNQs-00BmTB-F8; Thu, 25 Jun 2020 10:40:30 +0200
Message-ID: <b57135152b6d88729b23d9a8d9726a59f0ed44cc.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: flush scan entries upon suspend
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, emmanuel.grumbach@intel.com
Date:   Thu, 25 Jun 2020 10:40:29 +0200
In-Reply-To: <iwlwifi.20200623211013.df306f28bb0f.Ib56a98fa55090cc2d9952463f2c292a0a101f3cb@changeid>
References: <iwlwifi.20200623211013.df306f28bb0f.Ib56a98fa55090cc2d9952463f2c292a0a101f3cb@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-06-23 at 21:10 +0300, Luca Coelho wrote:
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> 
> When we suspend, we can't really remember our BSS table.

Sure we can. We do today :-)

Yes, I know why you want this for iwlwifi, but this commit message isn't
good. And if you had a good commit message, you'd know that it's
actually only needed for iwlwifi, not for basically anyone else.

And, in fact, it's not even needed for iwlwifi because if you had WoWLAN
then the firmware stays running and you don't need it.

> Purge all the data.

We age it already since commit cb3a8eec0e66. That should be sufficient
for most devices.

And in fact, if it weren't, then this should have removed the ageing
that's now completely pointless :)

> Export this function to allow driver to purge the BSS table
> in case they feel the need to.
> iwlwifi will need to do that.

I think we should just have a patch to purge it, without the call in
sysfs.c, and do then iwlwifi can call it in the right places (when it
resets the firmware.)

Note this won't even be _perfect_ because there are reasons (like being
connected) that mean the entry is not removed even when flushing, so
that should probably be documented.

johannes

