Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABC02B1827
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 10:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKMJXM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 04:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgKMJXM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 04:23:12 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B890C0613D1;
        Fri, 13 Nov 2020 01:23:12 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kdVIR-006rOM-33; Fri, 13 Nov 2020 10:23:07 +0100
Message-ID: <820f10c46841ac79c78d5952ebbc816fd710b4fd.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: reject/clear user rate mask if not usable
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org, kirtika@google.com,
        linux-wireless-owner@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org
Date:   Fri, 13 Nov 2020 10:23:05 +0100
In-Reply-To: <bc1db8cd25acd698ec586ed11c9865ac@codeaurora.org>
References: <20170308132022.4216-1-johannes@sipsolutions.net>
         <07179008e9369bc81e152009ca85191d@codeaurora.org>
         <5decc452-7b2a-db1d-c5eb-04ab6bb61553@broadcom.com>
         <4b8f37fde23262547edb6ed4635cf89b@codeaurora.org>
         <cfee0b47ad026c74a105d3adf2923357bbc5e96e.camel@sipsolutions.net>
         <83dd20def685d303106f285400367b6e@codeaurora.org>
         <798cea679ae1df5a2ab9b59dd81c8e2b3ca2d6e3.camel@sipsolutions.net>
         <30e2e578983e4df447e0c26c5bba0aba@codeaurora.org>
         <0e60e4cdc036a5ef7394848d212a6e3f499c386f.camel@sipsolutions.net>
         <256c487bb8c8c191a88d806e6125296e@codeaurora.org>
         <365b1abcfd043a3b0c356ec9f8c7c44acd5a79d2.camel@sipsolutions.net>
         <6caaa87ba3f37bd424e92d03c2340689@codeaurora.org>
         <e4bd954afa503835e072ef71aa61c59e04ecbc40.camel@sipsolutions.net>
         <bc1db8cd25acd698ec586ed11c9865ac@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> > Yes but you have to iterate all the stations and check they belong to
> > the interface and all that I think?
> > 
> Maybe not need.
> if NL80211_IFTYPE_STATION and NON-WLAN_STA_TDLS_PEER, it has only 1 
> station for the ieee80211_vif
> by my understand.

Well, yes, but there's no counter.

So you need to iterate to see if there are any additional TDLS peers (in
addition to the STA entry for the AP).

johannes

