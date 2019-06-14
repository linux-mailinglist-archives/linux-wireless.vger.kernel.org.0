Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22BB45A42
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 12:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfFNKVI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 06:21:08 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:39614 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfFNKVI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 06:21:08 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hbjKO-0005VQ-An; Fri, 14 Jun 2019 12:21:00 +0200
Message-ID: <a50de3e52ece8a636ae902b1a5b901d0d3cd068f.camel@sipsolutions.net>
Subject: Re: [PATCH v3 wireless-drivers 1/3] mt76: usb: fix rx A-MSDU support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name
Date:   Fri, 14 Jun 2019 12:20:59 +0200
In-Reply-To: <20190614101115.GA2669@localhost.localdomain> (sfid-20190614_121121_297269_B8C7CB69)
References: <cover.1560461404.git.lorenzo@kernel.org>
         <66fc02e45fb5ce0d6176395b5ac43acbd53b3e66.1560461404.git.lorenzo@kernel.org>
         <20190614072449.GA3395@redhat.com>
         <20190614101115.GA2669@localhost.localdomain>
         (sfid-20190614_121121_297269_B8C7CB69)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-06-14 at 12:11 +0200, Lorenzo Bianconi wrote:

> Looking at __ieee80211_amsdu_copy() now I got why other drivers copy hdrlen +
> 8, thx :)
> In our case reuse_frag is true in __ieee80211_amsdu_copy, so we will end up
> copying 32B + ether_len. Anyway I think 32 is a little bit too low and we could get
> better performances increasing it a little bit.
> A typical use case (e.g IPv6 + TCP):
> 
> IPv6 = 40B, TCP = 32B --> so 72B..I guess 128B is a good value :)
> @Felix, Johannes: what do you think?

I think while we might *allocate* more, I don't think we should *copy*
more, since then the TCP payload will no longer be in pages.

It'd probably be better to implement leaving enough tailroom (allocate
128), but copying nothing, unless the *entire* packet fits.

johannes

