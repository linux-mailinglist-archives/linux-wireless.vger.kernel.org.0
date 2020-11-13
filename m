Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0366B2B170D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 09:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKMIQy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 03:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgKMIQy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 03:16:54 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B35DC0613D1;
        Fri, 13 Nov 2020 00:16:54 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kdUGI-006pgI-UN; Fri, 13 Nov 2020 09:16:51 +0100
Message-ID: <798cea679ae1df5a2ab9b59dd81c8e2b3ca2d6e3.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: reject/clear user rate mask if not usable
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org, kirtika@google.com,
        linux-wireless-owner@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org
Date:   Fri, 13 Nov 2020 09:16:50 +0100
In-Reply-To: <83dd20def685d303106f285400367b6e@codeaurora.org>
References: <20170308132022.4216-1-johannes@sipsolutions.net>
         <07179008e9369bc81e152009ca85191d@codeaurora.org>
         <5decc452-7b2a-db1d-c5eb-04ab6bb61553@broadcom.com>
         <4b8f37fde23262547edb6ed4635cf89b@codeaurora.org>
         <cfee0b47ad026c74a105d3adf2923357bbc5e96e.camel@sipsolutions.net>
         <83dd20def685d303106f285400367b6e@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-11-13 at 16:14 +0800, Wen Gong wrote:
> On 2020-11-13 15:38, Johannes Berg wrote:
> > On Fri, 2020-11-13 at 10:08 +0800, Wen Gong wrote:
> > > > Which was the intent of this change, wasn't it?
> > 
> > Indeed. Permitting this leads to warnings later.
> > 
> > > We need to set the tx rate to fixed at a single rate, e.g.,
> > > 54M/48M/36M... for a test case.
> > > I do not want a clear error message, I want to the 54M rate pass/set
> > > success to lower wlan driver.
> > > Then lower wlan driver can handle it.
> > 
> > No, that will not happen. You should configure your test AP to actually
> > support 54M.
> Yes, the AP support 54M, but it is not basic rate, so 
> ieee80211_set_bitrate_mask will reject 54M
> because fail for check (mask->control[band].legacy & basic_rates).

Ah. So this is what I said in the original commit message even:

> Technically, selecting basic rates as the criterion is a bit too
> restrictive, but calculating the usable rates over all stations
> (e.g. in AP mode) is harder, and all stations must support the
> basic rates. Similarly, in client mode, the basic rates will be
> used anyway for control frames.

I guess if we really want to redefine the user rate mask to not apply to
control frames, then we can relax this?

johannes

