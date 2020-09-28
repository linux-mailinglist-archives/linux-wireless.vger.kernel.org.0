Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB8F27AC64
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 13:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgI1LDo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 07:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgI1LDo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 07:03:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6304BC061755
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 04:03:44 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kMqwX-00CRSX-Rz; Mon, 28 Sep 2020 13:03:42 +0200
Message-ID: <b7501579298642ec77a255a5571de505bec373af.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: Include supported RX/TX frames in split phy
 dumps only
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Martin Willi <martin@strongswan.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 13:03:40 +0200
In-Reply-To: <20200904091235.11342-1-martin@strongswan.org>
References: <20200904091235.11342-1-martin@strongswan.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Martin,

> With the recent additions of new features, non-split phy dumps exceed the
> maximum Netlink size of 4096 bytes. Depending on their feature set, not all
> radios are affected, but for example hwsim is.

Hmm, ok. I wonder which features in particular?

> While userspace dumping phys can request a split dump as a work around,
> legacy tools without split support may get oversized dumps. Much more
> problematic are phy new/del notifications, which are always limited to
> a page size: Generating these messages fails, and Netlink notifications
> are silently dropped. This breaks userspace relying on these events.

Right, not good.

> There is no single commit that broke these events, as their size highly
> depends on the phy feature set. Finding attributes to strip is challenging:
> The largest attributes are the frequency lists, but they are already
> reduced to the minimum and have rather useful information.

Right.

>  HE information
> probably could be stripped,

Right, bad. We should strip that entire stuff.

> but the saving is about 200 bytes, not enough
> to fix dumps for many cases. 

:(

> The next larger attributes are usually the
> RX/TX frame attributes. Removing these attributes can reduce a hwsim phy
> dump from 4576 to 3288 bytes, and it seems to be the most reasonable
> approach.

Well the problem with that approach is that it kinda results in a
different regression because the RX/TX stuff *was* present before split
wiphys were even introduced.

OTOH, I just checked, and back then wpa_supplicant wasn't using that
information, so it seems fair game to remove.

I've ended up with a patch that's a bit different - I'll post it in a
minute.

johannes

