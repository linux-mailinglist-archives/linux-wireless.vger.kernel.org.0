Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7D43A34A5
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 22:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhFJUQ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 16:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJUQ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 16:16:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80473C061574
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jun 2021 13:14:31 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lrR4O-0050UP-TU; Thu, 10 Jun 2021 22:14:29 +0200
Message-ID: <e787fefd695aed489f30978a9e950d9a7390a7b1.camel@sipsolutions.net>
Subject: Re: Is the extra_tx_headroom guarenteed ?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Steven Ting <steventing@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 10 Jun 2021 22:14:28 +0200
In-Reply-To: <f045bc11c75e4603bf58f3d596448c7e@realtek.com> (sfid-20210607_051714_758886_6CCCA7F4)
References: <f045bc11c75e4603bf58f3d596448c7e@realtek.com>
         (sfid-20210607_051714_758886_6CCCA7F4)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> We encountered a problem that we use the extra_tx_headroom to reserve the headroom
> which we put the txdesc in.
> 
> Current workaround is that we check our needed headroom size by skb_headroom()
> in the driver layer.
> 
> Is extra_tx_headroom in struct ieee80211_hw always guaranteed?

It _should_ be, IMHO. Having the check in all the drivers would be
pointless.

> The header file describes:
> * @extra_tx_headroom: headroom to reserve in each transmit skb
> *      for use by the driver (e.g. for transmit headers.)
> 
> But when the skb goes through the ieee80211_amsdu_realloc_pad(), it does not
> take care of the extra_tx_headroom, i.e. the original reserved headroom might be
> eaten.

OK, so I guess that's a bug there.

> Does the ieee80211_amsdu_realloc_pad() lacks some check for extra_tx_headroom
> or the extra_tx_headroom in mac80211 is not guaranteed?

I would say it lacks the checks - want to send a patch?

> Furthermore, for the packet that would not be aggregate in A-MSDU and ndev->needed_headroom
> is not guaranteed, in this case whether mac80211 layer still guarantee the extra_tx_headroom ?

Yes, this case should be handled.

johannes

