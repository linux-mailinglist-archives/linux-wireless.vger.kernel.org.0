Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8AB521D6C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbiEJPHg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 11:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345593AbiEJPGA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 11:06:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6802432CBBF
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=K3OSba5esavcG+b77SPhzMiMQ7qM3cVFxkSq6HFhFF0=;
        t=1652193077; x=1653402677; b=mfoKsOAoj+cw4/fC8MCr8pHxsS4m6QW6tOhRTQu0GDEFjm5
        Wy+0SViczCQbR/QzLcHewSN5lipQQLdse2fQt06f6bHcFa2piATM3U2yt9iMYTm6h2340l0QVi1Gq
        LX/ARbX4Bzl3k6ojU/d1j1O3of71ZlSC+FiEcBYctsQRz9gSSNjYlU8n7XAUidp6+qmmjut7KuYRf
        QTqZSplNAKuLHQBM++mwkVX1GRBAB49rNTY7ojIfF6Pso/G8CvYpjMgRe87SToPbbUjIJe+qZocu2
        RTNVovFBp4zh0U1LbgTM8mpB72/vNvH+mEr0EfUVIdYoTSGAM13bWL48yKD+qjhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1noQtL-007pep-0e;
        Tue, 10 May 2022 16:31:11 +0200
Message-ID: <4281590ec280540e52202e052a23cbba3a33a474.camel@sipsolutions.net>
Subject: Re: AP + STA on DFS channel breaks DFS detection.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 10 May 2022 16:31:09 +0200
In-Reply-To: <c937f0dc-5be7-8986-01a5-152c6b20e868@candelatech.com>
References: <c937f0dc-5be7-8986-01a5-152c6b20e868@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-04-27 at 14:32 -0700, Ben Greear wrote:
> I am using 5.17.4+ kernel, MT7915 radios.  One radio (wiphy0) is acting as AP on
> channel 132.  It starts, does CAC and starts working fine.
> 
> Then, I bring up a station on wiphy1 (on same machine).  The STA connects to the AP
> on wiphy0 and starts running traffic for a short time (usually < 1 minute).  And then
> the AP gets stopped.  I don't think this is specific to connecting AP to STA on same machine,
> probably if STA connected to another AP on channel 132 it would have same issue.
> 
> I think I have tracked this down by adding prints and WARN_ON to find
> the interesting state changes.  It looks like when the STA changes its
> regdom (probably because it is admin-up and/or associated to the AP), then the state of the
> channel's dfs_state is reset.  Channel objects are per band, not per wiphy.

Actually, they are per wiphy, unless the driver sets up something else?
I couldn't really figure out the code there, but it looked dynamically
allocated, so not sure...

> And then a bit later, a timer kicks off and decides that CAC has not completed
> (because it already completed earlier on the AP, but chan->dfs_state was lost,
> and STA will not do CAC anyway.)
> 
> So, question is, how in the world to fix this properly!
> 

Good question!

But I'm not sure your description of this is quite right - the point
isn't that the channels are shared, the point is that you're getting to
update_all_wiphy_regulatory() which does update _all_ of the devices,
since you've just switched the regulatory domain.

I guess if the rules are identical on a given channel before/after the
regdomain switch, we might get away with not resetting the dfs_state?

johannes
