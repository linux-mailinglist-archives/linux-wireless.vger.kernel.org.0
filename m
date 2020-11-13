Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365972B1744
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 09:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKMIgD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 03:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKMIgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 03:36:03 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C951C0613D1;
        Fri, 13 Nov 2020 00:36:03 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kdUYo-006q7y-OT; Fri, 13 Nov 2020 09:35:58 +0100
Message-ID: <0e60e4cdc036a5ef7394848d212a6e3f499c386f.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: reject/clear user rate mask if not usable
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org, kirtika@google.com,
        linux-wireless-owner@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org
Date:   Fri, 13 Nov 2020 09:35:57 +0100
In-Reply-To: <30e2e578983e4df447e0c26c5bba0aba@codeaurora.org>
References: <20170308132022.4216-1-johannes@sipsolutions.net>
         <07179008e9369bc81e152009ca85191d@codeaurora.org>
         <5decc452-7b2a-db1d-c5eb-04ab6bb61553@broadcom.com>
         <4b8f37fde23262547edb6ed4635cf89b@codeaurora.org>
         <cfee0b47ad026c74a105d3adf2923357bbc5e96e.camel@sipsolutions.net>
         <83dd20def685d303106f285400367b6e@codeaurora.org>
         <798cea679ae1df5a2ab9b59dd81c8e2b3ca2d6e3.camel@sipsolutions.net>
         <30e2e578983e4df447e0c26c5bba0aba@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-11-13 at 16:35 +0800, Wen Gong wrote:
> 
> > I guess if we really want to redefine the user rate mask to not apply 
> > to
> > control frames, then we can relax this?
> > 
> Yes, for AP mode, it is hard to calculate the usable rates over all 
> stations.
> But for STATION mode, it can set 54M because AP support it, so it should 
> not reject it.
> If add a check for nl80211_iftype of ieee80211_vif in 
> ieee80211_set_bitrate_mask, it can
> solve this like this:
> if (sdata->vif.type != NL80211_IFTYPE_STATION && 
> !(mask->control[band].legacy & basic_rates))


That would forgo the check completely - we'd still need to check against
the *supported* rates.

johannes

