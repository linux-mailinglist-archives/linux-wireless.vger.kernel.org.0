Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CFE27D5CD
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgI2Scn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2Scn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 14:32:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2023EC061755
        for <linux-wireless@vger.kernel.org>; Tue, 29 Sep 2020 11:32:43 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kNKQZ-00DG0S-Cr; Tue, 29 Sep 2020 20:32:39 +0200
Message-ID: <8cb48d6d229aa1d01f815c3a2336799b780b510d.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: process S1G Operation element before HT
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 29 Sep 2020 20:32:38 +0200
In-Reply-To: <20200929181948.22894-1-thomas@adapt-ip.com>
References: <20200929181948.22894-1-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-09-29 at 11:19 -0700, Thomas Pedersen wrote:
> The sband->ht_cap was being processed before S1G Operation
> element.  Since the HT capability element should not be
> present on the S1G band, avoid processing potential
> garbage by moving the call to
> ieee80211_apply_htcap_overrides() to after the S1G block.

Ah, heh. I hadn't even realized that.

What I meant though was something else: we have

        if (s1g_oper && sband->band == NL80211_BAND_S1GHZ) {
		...
		goto out;
	}

	// process ht cap overrides (after this patch)

	// check HT oper

	// check VHT oper

	// ...

So given that first condition, if you actually have an S1G AP *without*
S1G operation element (for some reason), you'd start processing HT, VHT,
and whatever else capabilities, sending us down a misleading and likely
very confusing path, which seems like it should be avoided?

johannes

