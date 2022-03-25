Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998E64E72BD
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 13:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357495AbiCYMJn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347349AbiCYMJl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 08:09:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F241F5FBC
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 05:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5B5wAq5LfyAkih3V2BMgc+HmWAEd6qH7oOxOQfkzsDc=;
        t=1648210087; x=1649419687; b=S47SHmZR3y62K4Mc2WoIbu1mce9AVQL554ybkrsDjxemM7y
        NLQr/i9UBbmlYP8rVlwvYaDqDWP+0ReodbFJ3mwadqqx3wB1LAaIIc2EWMNLrS2vvopCQL23+X4Zw
        ShDrL65KnxX5YyyPO9I5gvYOOuinVwOSMfH2AgBHcCm+Gn6+EtpF74vMmOjOecRH5vx83g2siIusu
        aCQoKda4U3mS6viu195VUqciijOnN1jp4FL9y9bO9DlDutf5nLRLbhG2czVVfOrhALUE8NY6yW1uh
        I67oDYHdWYw+W228DuRuGgcPJr0FmkldlPrb71g3QZnjE+rRNK9wegQne4K1bx+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nXijb-000Jne-I1;
        Fri, 25 Mar 2022 13:08:03 +0100
Message-ID: <365254338aba8caa588096e532ed54d094b06345.camel@sipsolutions.net>
Subject: Re: [BUG] deadlock in nl80211_vendor_cmd
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>, willmcvicker@google.com,
        linux-wireless@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Fri, 25 Mar 2022 13:08:02 +0100
In-Reply-To: <5d5cf050-7de0-7bad-2407-276970222635@quicinc.com>
References: <0000000000009e9b7105da6d1779@google.com>
         <99eda6d1dad3ff49435b74e539488091642b10a8.camel@sipsolutions.net>
         <5d5cf050-7de0-7bad-2407-276970222635@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
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

On Tue, 2022-03-22 at 14:31 -0700, Jeff Johnson wrote:
> On 3/21/2022 1:07 PM, Johannes Berg wrote:
> [..snip..]
> 
> > > I'm not an networking expert. So my main question is if I'm allowed to take
> > > the RTNL lock inside the nl80211_vendor_cmd callbacks?
> > 
> > Evidently, you're not. It's interesting though, it used to be that we
> > called these with the RTNL held, now we don't, and the driver you're
> > using somehow "got fixed" to take it, but whoever fixed it didn't take
> > into account that this is not possible?
> 
> On this point I just want to remind that prior to the locking change 
> that a driver would specify on a per-vendor command basis whether or not 
> it wanted the rtnl_lock to be held via NL80211_FLAG_NEED_RTNL.

No, that flag isn't on a per-vendor-command basis. It was set for all
the vendor commands though, in nl80211, so the driver wouldn't have had
the rtnl_lock()/unlock() at all.

johannes
