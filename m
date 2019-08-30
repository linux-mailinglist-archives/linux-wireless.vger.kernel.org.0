Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59217A30D3
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfH3HTT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 03:19:19 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:59630 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbfH3HTT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 03:19:19 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3bBl-0008KG-Kb; Fri, 30 Aug 2019 09:19:17 +0200
Message-ID: <b97b57bdd07fa5cfdc07d5fd451d506b20e0cd0e.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: Add new fields to wiphy structure
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Amar Singhal <asinghal@codeaurora.org>, jouni@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, jjohnson@codeaurora.org,
        rmanohar@codeaurora.org
Date:   Fri, 30 Aug 2019 09:19:16 +0200
In-Reply-To: <1567116559-17419-1-git-send-email-asinghal@codeaurora.org>
References: <1567116559-17419-1-git-send-email-asinghal@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-08-29 at 15:09 -0700, Amar Singhal wrote:
> A channel is completely defined by (oper_class, channel number) tuple,
> and not just by center frequency. Operating class also tells about the
> bandwidth supported by the channel. Therefore add the operating class and
> channel number to the wiphy structure.

We don't split out the channels that way, so this doesn't seem like the
right approach.

Instead, we list the *frequencies*, and then have flags for the
permitted bandwidths. We already support things like "no-HT40+" and
could possibly extend that to others, if it were _really_ possible,
though in practice those limitations are usually not present in devices,
just in the spec, and we can rely on hostapd/wpa_s to take care of them.

Even if you do have those limitations, this isn't the right way to go
about it, because it'll be very confusing to userspace to see the same
frequency multiple times. It'd also cause a bunch of problems with
scanning (listing the same channel twice) etc.

Since you haven't explained why you want to do this I cannot offer any
further guidance, but this cannot be the right approach.

johannes

