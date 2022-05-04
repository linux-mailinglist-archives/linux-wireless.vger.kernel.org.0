Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12788519EF2
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 14:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343689AbiEDMLz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 08:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiEDMLy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 08:11:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CCC1DA62
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=SUIn19lzU7IWZNYnrnGxpOKaAcQze9QaTvK006Bds4Y=;
        t=1651666099; x=1652875699; b=BII7edSJzr7Bi7Fy/cxwWut8pdvYbDjOTUybzGHJPWHhmbu
        SMWXvH7BoqpNO1fRg6EvIQ4IJGJFZgghjN+9uWGOnNS44Nl093IOFt754EaxAmnIzdMPfhtwVhe5A
        3sJeUJPXzkgnUZVLYk6Cny+cpvPGqjCcIXQredO+MeiW/N1VFxmoo3LaGaheMYxr3jMVUrYhfnF6h
        RzVKuqcTC01bWeEwSha0jKf8i1aCwxYquQweEqo5DB+udhw9s+sqwjAJVvSH03OKF1tBDElA3az9Z
        duu4MAB37ty5Bao8HsRQdTFfvcmFg8iaIbjT+2ttmW9U6aWNyfyTPJ9FaP4XFakA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmDnl-0021re-Ev;
        Wed, 04 May 2022 14:08:17 +0200
Message-ID: <58fdd62041c0388740cabea5a421c5417f959124.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] cfg80211: validate RU puncturing bitmap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 04 May 2022 14:08:16 +0200
In-Reply-To: <6cf56be5-16d6-2bcd-150f-bf29f98b7f1b@quicinc.com>
References: <20220214223051.3610-1-quic_alokad@quicinc.com>
         <20220214223051.3610-3-quic_alokad@quicinc.com>
         <a9813545a25cd63f71cc31476230514a80350802.camel@sipsolutions.net>
         <6cf56be5-16d6-2bcd-150f-bf29f98b7f1b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
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

On Tue, 2022-02-15 at 16:37 -0800, Aloka Dixit wrote:
> > 
> > Conceptually, I'm wondering if it really belongs into the chandef? Can
> > you explain why it's part of the channel configuration? If you've got
> > two chandefs with the same control channel, CCFS and bandwidth, but
> > different puncturing, does it really make sense to treat them as two
> > separate channel contexts, e.g. in mac80211? It seems strange to do
> > that.
> 
> Added it here so that any command working with chandef will be updated 
> without any other change.
> Example: During channel switch, user can provide a puncturing bitmap 
> with a new option I added in userspace, and because it is part of 
> chandef, the same code path validates it for that command automatically.

Yeah but is it really a CSA/chanswitch if the puncturing changes? I
don't think so?

> Regarding if different puncturing pattern should be considered as a new 
> context - yes, depending on if it is HE or non-HE mode, the new bitmap 
> may be invalid and the operation should fail.
> 

That wasn't really the question though. Consider this:

Say you have STA + STA, if the first STA is connected to an AP with no
puncturing, and the second STA is connected to an AP where the channel
and bandwidth are the same, but some puncturing is done, should that
really be two channel contexts as far as mac80211 is concerned, and thus
require channels=2 in the interface combinations etc.? It doesn't seem
right to me.

Or consider AP + STA, where the AP is set up for some channel but the
STA is connecting to an AP on the exact same channel, but with
puncturing... Again, same thing, I don't think it should consume two
channel resources.

johannes
