Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9963F5CFAC
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 14:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfGBMlA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 08:41:00 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:37828 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfGBMlA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 08:41:00 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hiI5i-0007rp-GK; Tue, 02 Jul 2019 14:40:58 +0200
Message-ID: <b2aa2ee9af4cf4cd2c29139122044fcfae077079.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] cfg80211: fix duplicated scan entries after channel
 switch
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Date:   Tue, 02 Jul 2019 14:40:57 +0200
In-Reply-To: <20190702115005.ulcfohbi4mkwpt2c@bars>
References: <20190613112128.834-1-sergey.matyukevich.os@quantenna.com>
         <7c8b3493cd2c48beae5a12e23964c8d3ca181d04.camel@sipsolutions.net>
         <20190702115005.ulcfohbi4mkwpt2c@bars>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sergey,

On Tue, 2019-07-02 at 11:50 +0000, Sergey Matyukevich wrote:

> Thanks for review! Summarizing your comments, here are the options
> and some of their highlights:
> 
> 1. replace old entry with the new entry
>    - no easy way to update ifmgd->associated w/o rework of mac80211 csa

Yes, this one's the tricky one. I don't think you can make this work
easily.

> 2. keep old entry, remove new entry
>    - this is what suggested RFC patch does
>    - works, but update of current_bss entry after csa may be delayed

Correct.

> 3. keep old entry, update it using data from new entry, then remove new entry
>    - this looks like a better approach
> 
> Unless I am missing something, the last option can be implemented on top of
> the current RFC patch w/o extra complexity. The required bss entry update is
> what cfg80211_bss_update function does when bss in question already exists.
> So it should be possible to reuse that code.

Agree, you just need to sort of invert it, or call it like this:

 * relink the old entry, unlink a new entry (if any)
 * bss_update() with the new entry if there was one
 * it should free one of the entries if I remember correctly

> I will post RFC patch v2 after more testing for both mac80211 and
> fullmac cases.

Sounds good, thanks a lot for working on this!

johannes

