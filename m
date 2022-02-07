Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281F54ABF58
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 14:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbiBGNVL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 08:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442559AbiBGMVR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 07:21:17 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364C7C103134
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 04:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5iruwTdRJgw2y2OON6pfPW9g0iRfME00PvvehymnB7w=;
        t=1644235807; x=1645445407; b=TLNT7Ds3Phuwh2J+vt2hU+vOJ4WJJjqEecuj+km6p+T+p1F
        hk1mRGQBYvGAY1mXE6qlxMhcoeGJkt2rNRQBvG6k14TUmzog61Ty9FVJ/Nw3dN32MUbYC47iPO+Mk
        s0ekUpOaNjRHQz9+kSmLkaj4rJgaCPCnqnBpteEf9SSDSXpJD0gr8u+jOjs+TBIDgC/ueJdXMCGGO
        63BPETdT1PkE/ALswUYkzrangOjFkm7wiruednXxlWdg+4uNMSDo6VH9w225iezY/WLpJTyMRtRYa
        MeVv6AhoSCstAc1B+QvVuLKF8m4khRj+MSIu+UfVrUTk020WTPUtfgYmSYLLyqJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nH2qJ-00Fc5r-9u;
        Mon, 07 Feb 2022 13:10:03 +0100
Message-ID: <12a77901c0f6b218c802db7434466d5eb49bcb46.camel@sipsolutions.net>
Subject: Re: [PATCH 04/19] ieee80211: Add EHT (802.11be) definitions
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>, Jia Ding <quic_jiad@quicinc.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>
Date:   Mon, 07 Feb 2022 13:10:02 +0100
In-Reply-To: <d51984f5-a035-36a5-75f6-3bff67d60b12@quicinc.com>
References: <20220204220255.448224-1-johannes@sipsolutions.net>
         <20220204230119.1ee92202ac30.Id30a3ef2844b296efbd5486fe1da9ca36a95c5cf@changeid>
         <d51984f5-a035-36a5-75f6-3bff67d60b12@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for the review!

On Mon, 2022-02-07 at 12:37 +0530, Veerendranath Jakkam wrote:
> On 2/5/22 3:32 AM, Johannes Berg wrote:
> > From: Ilan Peer <ilan.peer@intel.com>
> > 
> > Based on Draft P802.11be_D1.3.
> 
> 
> "Based on Draft P802.11be_D1.0".
> 
> based on documentation and MACRO definitions, These changes are aligned 
> with P802.11be_D1.0

Hmm. I thought I squashed in all the later update patches, but maybe we
forgot things!

> 
> > +/* EHT beamformee SU number of spatial streams <= 80MHz is split between octet 0
> > + * and octet 1
> > + */
> > +#define IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE_SS_80MHZ  0x80
> > +
> > +#define IEEE80211_EHT_PHY_CAP1_SU_BEAMFORMEE_SS_80MHZ  0x03
> > +#define IEEE80211_EHT_PHY_CAP1_SU_BEAMFORMEE_SS_160MHZ 0x1c
> > +#define IEEE80211_EHT_PHY_CAP1_SU_BEAMFORMEE_SS_320MHZ 0xe0
> > +
> 
> 
> Append _MASK for the macros representing multi bit fields like above?
> 

I guess that'd make some sense.

> Or we can use GENMASK() to represent values
> 

I don't like GENMASK() that much to be honest, it always feels confusing
which way around the arguments should be and whether the edges are
included or not, and then I don't feel we gain much from it?

johannes
