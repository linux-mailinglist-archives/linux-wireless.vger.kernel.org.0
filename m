Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957932A91D4
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 09:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgKFIzs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 03:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgKFIzs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 03:55:48 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D998CC0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 00:55:47 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kaxX6-002BV4-E5; Fri, 06 Nov 2020 09:55:44 +0100
Message-ID: <5c39eaec897af4d7b1005d1f7cb80552c3404e54.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: add optional argument to parse 6G band channel
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 06 Nov 2020 09:55:30 +0100
In-Reply-To: <1602283770-8026-1-git-send-email-pradeepc@codeaurora.org>
References: <1602283770-8026-1-git-send-email-pradeepc@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-10-09 at 15:49 -0700, Pradeep Kumar Chitrapu wrote:
> Channel numbers of 6G band overlaps with those of 2G or 5G bands.
> Therefore, an optional argument "6G" is added and expected next
> to channel number to map it to correct 6GHz frequency. If not
> specified, defaults to matching 2G or 5G frequency.
> 
> example:
> iw wlanX set channel 149 6G 80MHz  --> maps to 6695 MHz
> iw wlanX set channel 149 80MHz     --> maps to 5745 MHz

Hm. I can't really say I like this much.

Is it _really_ needed? I mean, we mostly specify the frequency today, so
... why not just always do that for 6 GHz?

johannes

