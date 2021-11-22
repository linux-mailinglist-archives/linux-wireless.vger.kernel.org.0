Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40BE458A67
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 09:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhKVIV1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 03:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhKVIVY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 03:21:24 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A417C061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 00:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/6iM9yvGmkW4u277vp1RG12hC1QxxxTIES9p+GkwwBE=;
        t=1637569094; x=1638778694; b=QDHjziJ6bGxSuyKcKB1WzedaqAGpR54Nl3aJ/nL6Mc8hqur
        U7hpeysjd9inYF7W81OfH396sK/MKtW6V9SH4Z3pvhN07Hms06U0Rsg1incnbXoC86K+mY95dVa2f
        tRsoZwqgrMeA8q/aCGiGRT8e8DRu2w8Tk/drwmNmTSW6ab+M0CqnnHO4ABmRHj5ew6PN1hVCeGx9m
        aT7SfyqSSu0qaOVr6Jck9BOx9VVNBh4eebNVhxy1Edo38p3GtKRJZZ7td07VxitjAR8u8DDDTmv92
        AxKviSM6rMREEQb7nFEYP8qmC3WV/CnYgvT5fmDzzJfZqykAZFCylR6sAyrJ1jgg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mp4Wh-001BA1-OZ;
        Mon, 22 Nov 2021 09:18:11 +0100
Message-ID: <a54298c0b747ba562caa47f271f058b9831810ee.camel@sipsolutions.net>
Subject: Re: [PATCH mac80211] cfg80211: check nla_parse_nested return code
 in nl80211_set_sar_specs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        cjhuang@codeaurora.org
Date:   Mon, 22 Nov 2021 09:18:10 +0100
In-Reply-To: <3b6fee130e2d264242463cff063bcfb6d6f5da83.1637494779.git.lorenzo@kernel.org>
References: <3b6fee130e2d264242463cff063bcfb6d6f5da83.1637494779.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2021-11-21 at 12:41 +0100, Lorenzo Bianconi wrote:
> Check error code returned by nla_parse_nested in nl80211_set_sar_specs
> routine before parsing SAR sub-specs.
> 

I don't think we need to. The policy already states it:

        [NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),


Since we always parse the top-level already in the generic netlink code,
it will recurse down here by way of that policy link, and then it will
already be validated as much as nla_parse_nested() can do again - so we
only do it again here to actually get access to the pointers.

johannes
