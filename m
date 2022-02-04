Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238D94A9B24
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 15:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359383AbiBDOnL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 09:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiBDOnL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 09:43:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428EEC061714
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 06:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XUDQ1ffi52OMMAXRbR+/veHo7msEalJEJibRXcVIj00=;
        t=1643985791; x=1645195391; b=iEH3BO8ytcB/Rw/x9vU74WL4hDduDy//+uzrdA7aP4XkBDB
        87HamUFxoaoo3jqB7leIQxS5nX0yeTjQmC+JH0NGXAbTXjnzYXBvz78NIcaGowTAE0nDlGw3cSVEE
        UmCZk+z8q6xRZEslswMw8MvHspB7ObNbTNsEG35ObkaM7H/GQ6knA8jjnfMnR6JOo9UlRRNfTMiDU
        2SbxnUuwkFUZSdroDS3Q0ftwkHKxg4y6NbNVoPFDxHq1w0tt3EkyJCGPp49SBiHUlLUAiXw9Wbkjl
        8BkUF17bDas/dVdX0JNz+HDTIGpdk0pN4Ju/tF6BEh15mtfJ6S2sTKQ0DbSdINng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nFznp-00EVzm-K6;
        Fri, 04 Feb 2022 15:43:09 +0100
Message-ID: <91d3b826accb22194c9fa3134cd1f3137950e863.camel@sipsolutions.net>
Subject: Re: [PATCH 3/6] nl80211: add support to send EHT capabilities from
 userspace
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, quic_vikram@quicinc.com,
        quic_alokad@quicinc.com, quic_jiad@quicinc.com,
        quic_periyasa@quicinc.com, quic_msinada@quicinc.com,
        quic_srirrama@quicinc.com
Date:   Fri, 04 Feb 2022 15:43:07 +0100
In-Reply-To: <382a29fe-dea3-7d32-2aeb-16ba18e9da28@quicinc.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
         <1640163883-12696-4-git-send-email-quic_vjakkam@quicinc.com>
         <5ede1e1ad04b6359eafb658e827abf6a8343355f.camel@sipsolutions.net>
         <0644274d-7a9f-642c-eef2-02c662a5adcc@quicinc.com>
         <0c0ba8cebb877384172b5bd314cbbbb035d1f348.camel@sipsolutions.net>
         <382a29fe-dea3-7d32-2aeb-16ba18e9da28@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-02-04 at 20:07 +0530, Veerendranath Jakkam wrote:
> 
> There are some references for NSS > 8, ex: Table 9-33a, P802.11be_D1.3 
> hence I used 81.

Right, the spec confuses me. In a lot of places it reserves enough space
for 8 < NSS <= 16, but then it has e.g. Table 36-40 with 4 bits, but
saying "for up to 8 spatial streams" (MU-MIMO). And even for OFDMA it
states in a lot of places that the maximum is only 8.

> Please let me know if you would like this to be changed to 51
> 
Nah, don't worry. I think it probably doesn't even really *matter*, we
can safely leave it at 81 anyway (I had evidently miscalculated as 80
before, so I was confused).

We also already had some patches in this area, and I'm just working on a
combination - e.g. in your first patch I don't like the use of FIELD_GET
so much, preferring uXX_get_bits(), but Ilan already had patches here
that deal with that.

For many of the other patches, Ilan and you arrived at a literally bit-
identical version of things!

So I think I'm going to pick a couple of things from him and a couple of
things from you, and send out a combined series. Perhaps later today, if
I manage to get it done.

Also in your later nl80211 patch I'm thinking we should combine the
HE/EHT GI settings etc., there's no point duplicating all the enums,
though we might want to do some renaming.

Sounds OK?

johannes
