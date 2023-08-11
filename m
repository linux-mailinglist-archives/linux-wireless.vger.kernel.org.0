Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E8777899A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 11:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjHKJTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 05:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjHKJTf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 05:19:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0012D61
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4Sar5Lcc0N8EDoByeYYF1XXtTNCXfHKAoUEecHC/FLw=;
        t=1691745574; x=1692955174; b=aKKcgHGeDXY1m7VUTqExfkHGUaMZKiFBg3wWpU6nHNWXmwU
        QDQ2ltsLcRBCSkZRlAMIrc6+RZI+1uUZwDqZ7gWA18W6bxVZvSvcOo4VhU7dzBMoUIIIHJoQuZaol
        L62/lEOZR9XLLuoIRKmZR67qDtaerVyj1piusZ3mC5kXW0GHIKyEKFtNmZymItMVTu3xbG2YKU8hZ
        lOwaL2Fup49nnBmDt7vlR5FUzlQnTV3qPjJZaVjH6cxDqmWmDCSvssXcSWuJde9NjKbY2Io7k9K4+
        ba2JMyxCmsoMK8rLYBSmwAD6CGdwA60XsANs9Odv4xzMILfGcPu73Ou0fpI/rdcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qUOIt-000p9a-32;
        Fri, 11 Aug 2023 11:19:32 +0200
Message-ID: <30ad9d872e0555d801e9b22c9a72edb0f62a61a6.camel@sipsolutions.net>
Subject: Re: parsing the multi-link element with STA profile wifi: mac80211:
 support MLO authentication/association with one link
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     ath11k@lists.infradead.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Fri, 11 Aug 2023 11:19:31 +0200
In-Reply-To: <b5de662d-fd49-7b94-f617-89d4761c175b@quicinc.com>
References: <48715509-62fd-2307-e38f-176234b482c1@quicinc.com>
         <f240b33d507daf898480b0a11eb27d4475e45164.camel@sipsolutions.net>
         <571d8ecf-2ca6-8b7b-6e15-be12c56e9f88@quicinc.com>
         <e40ee96ab2a8d9d079d3a06b7b1c615ab25a2403.camel@sipsolutions.net>
         <2842f57c-e383-fb9e-d994-95336cb65e0d@quicinc.com>
         <6a33a41b5aa6c98d95ff934fbb6a10dfe78e6e6e.camel@sipsolutions.net>
         <2d3a6578-68c5-a0f3-b18b-bce2e67d3fdc@quicinc.com>
         <b5de662d-fd49-7b94-f617-89d4761c175b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-07-26 at 14:30 +0800, Wen Gong wrote:
> Hi Johannes,
>=20
> I guess you have already fix it in some patch, right?
>=20

No, I don't. We've not seen this, it's not been a priority.

<rant>

Look, I told you how I think you can fix it _literally_ three months
ago. I was on vacation for pretty much exactly half of that time. And
during that time you ask if _I_ have a fix? What have you been doing for
the past three months that prevented you from fixing it?

Upstream is supposed to be a collaborative effort, not a place where
I/we do the work and you keep asking me to make the changes you need for
you!

Sure, it there's a bug, and we should probably be fixing it  too, but if
that's not high on our list right now because we don't experience it,
then I don't see why you don't just send a patch!

I even get that you might not know whether something is a bug, and when
we determine that it is, how to fix it. But we cleared that up three
months ago, and all you've done in this thread is ask whether I have a
fix for you. Why?

johannes
