Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED244E789C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 17:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbiCYQF5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359567AbiCYQFz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 12:05:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47AB3EAB6
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yMAPFSA+Ih8GIc2c5GQDeXNSvNCWIB+Ei3ovhBAqMrY=;
        t=1648224260; x=1649433860; b=t+uoKBJJlsavcxxNdh3XaSC/FCcPqTLoa+87J1BKK7W0FO/
        wX8p+79r6pGBrZZugKLhoKu+R+8QJP7Iyu5HJ+sH95cJWDj/mludNHkzWAykddddgbM04NLrCFSl9
        v+xg967B6h61FwW8x9zbuiBBRK7KmLKbflY6c6nOYEVo3vYZcW+BqJyPgWn9cagUkpXKmfo1sF4Vc
        rgbzErfaN39u34EDHVA7/lrlMdFaTWfCDq1GocLAOm1nKISZKqQ4ij2WnRSUBmCwNNKR81djSFWwS
        KI2GRINATx5lLHi3DDgspN/ld7EdBxU/XqpGCCW2Kwo2gZ3h4KW43uHrva5jLOkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nXmQC-000PI4-ID;
        Fri, 25 Mar 2022 17:04:16 +0100
Message-ID: <1c6d5a1f033ef079cef4e3aaf6ead9f946da4db0.camel@sipsolutions.net>
Subject: Re: [BUG] deadlock in nl80211_vendor_cmd
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        William McVicker <willmcvicker@google.com>
Cc:     linux-wireless@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Fri, 25 Mar 2022 17:04:15 +0100
In-Reply-To: <2b2fa5d9-238a-81fa-8978-94bd9753b73e@quicinc.com>
References: <0000000000009e9b7105da6d1779@google.com>
         <99eda6d1dad3ff49435b74e539488091642b10a8.camel@sipsolutions.net>
         <5d5cf050-7de0-7bad-2407-276970222635@quicinc.com>
         <YjpGlRvcg72zNo8s@google.com>
         <ada45791b8792f37d4167d24a7fc440f77c2167f.camel@sipsolutions.net>
         <2b2fa5d9-238a-81fa-8978-94bd9753b73e@quicinc.com>
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

On Fri, 2022-03-25 at 08:59 -0700, Jeff Johnson wrote:
> On 3/25/2022 5:09 AM, Johannes Berg wrote:
> > On Tue, 2022-03-22 at 21:58 +0000, William McVicker wrote:
> > > 
> > > It would be nice if nl80211_vendor_cmd() could support taking the RTNL lock if
> > > requested via the vendor flags. That would require moving the wiphy lock to
> > > nl80211_vendor_cmds() so that it could take the RTNL and wiphy lock in the
> > > correct order. Is that something you'd be open to Johannes?
> > 
> > Not very, to be honest. If we had a good use case for it, maybe, but
> > you're not even saying quite what the use case is :)
> 
> I believe Will and I are up against the same issues. Out-of-tree Android 
> drivers use a large number of vendor commands to support the 
> requirements of the Android framework. Prior to 5.12 these vendor 
> commands would always be called with the rtnl lock held, and in some 
> cases the implementation of the vendor commands care about that, 
> especially when calling back into the kernel. In particular we are faced 
> with the issue that there are some kernel APIs that require that the 
> rtnl lock be held, and as a result of the lock infrastructure change we 
> can no longer call those APIs from vendor commands. That is a pretty 
> severe limitation to work around.

I'm not really sure how sympathetic I am to an out-of-tree use case I
cannot even see, and I'd probably consider problematic in the first
place :)

Your easiest option might be to just patch NL80211_FLAG_NEED_RTNL into
your kernel for vendor commands and call it a day?

johannes
