Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9F77B83AC
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjJDPeZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 11:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjJDPeY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 11:34:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6607793
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mJVDX3StT92iZZZB1DwyeljX4JE7L2QJNwBNTCnTGZc=;
        t=1696433661; x=1697643261; b=OkoGh65t7JcftZihjgtYYv/Xtyt9O398R5wvQAM+MlDInrm
        82zKpkqpgUijXSbXVXTnLHlM+7ezc0OR2uVPTXDeWu1eTXJErb966W62Hm94JjaJ9XTPwDCb9XbF9
        S5cn2jzoIsZSx99dG/L3Jl3lMtK8duDyGppyZMskSjKZ4yahaaFG1eawR7CiuJEpdm/O5zKqAtFPJ
        5tCbAh0kISBCLhUDA8QttM5u8lA6U0HZCU0Q+vzHYPpfWIY1969qpPwhXLc+DYDFAOcpr6i6NO+MF
        nEgTBCDgBLoD/9J9XK9ed2jH66uQ7mUc31eHbdbH+AbjjO03qQdgQP8C9YeZhzsw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qo3tB-00435L-2G;
        Wed, 04 Oct 2023 17:34:17 +0200
Message-ID: <a0da9cf2365b4478eddc7c1d6e9ee8565e4e2a1f.camel@sipsolutions.net>
Subject: Re: Microcode SW error since Linux 6.5
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Peer, Ilan" <ilan.peer@intel.com>,
        "anarcat@debian.org" <anarcat@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Date:   Wed, 04 Oct 2023 17:34:16 +0200
In-Reply-To: <0c07b6bf-a9cc-4dc0-b71c-a2257e501e5f@leemhuis.info>
References: <87ttrncuc8.fsf@angela.anarc.at>
         <60e2c052f3cedc5c80964e4be90c50cdaa899a87.camel@sipsolutions.net>
         <87jzsf9dme.fsf@angela.anarc.at>
         <0190dde1170bd1ee810e99b9799678f4f5b8f30e.camel@sipsolutions.net>
         <8734z29jx7.fsf@angela.anarc.at>
         <7bd483fd0d004aed37931561a7faa2e176ca3fac.camel@sipsolutions.net>
         <5d0904a4-bc0d-42dd-aae8-6b50e5c567ba@leemhuis.info>
         <42e000913e3af714c77fb7a55dd898733e271be0.camel@intel.com>
         <0c07b6bf-a9cc-4dc0-b71c-a2257e501e5f@leemhuis.info>
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

Thorsten,

You know ... when you started this regression tracking project, I
actually naively thought it might be a good idea, and _help_ us.

Honestly though, now after seeing it for a while, for me it's done the
opposite.

Pretty much all interactions we have with it are like this:

> (2) Would have been great if that fix would have had a stable tag to
> ensure a quick backport to 6.5. :-/ Made me wonder if this is an
> accident, but doesn't look like it:
>=20
> $ git log --oneline --grep 'CC:.*stable@vger.kernel.org' mainline/master
>  -- drivers/net/wireless/intel/iwlwifi/ | wc -l
> 11
>=20
> Is there a reason why iwlwifi patches nearly never contain stable tags?
> Reminder: a "Fixes:" tag alone does not guarantee that the fix is
> backported.

Yeah, that's wrapped in a "question", but really it's not, it's a
demand. You're demanding that we do our job differently, you might say
better, but you're demanding things of us.

Seeing this seriously makes me want to reconsider being a maintainer at
all. Why bother? All people do is feel entitled to you doing _more_.

Never mind that the the whole phrasing/reminder thing is pretty
condescending, like we don't know that?

Yeah, sure, I can already see how you're going to apologise, say you
didn't mean it that way, you're just doing your job etc., like last time
when you did the same to Kalle, etc. And I'm pretty sure we're _far_
from the only ones.

But honestly, _you_ chose this job. _You_ chose to be demanding in this
way. _You_ chose to complain to people about these things. _You_ decided
(as far as I can tell) to demand that stable maintenance was now the
subsystem maintainer job, rather than the stable maintainer's job.

This isn't helping. In fact, it's the exact opposite of helping.

You _could_ have decided that the patch was indeed worth it for stable,
submitted it there (once in mainline), and then maybe send a nudge
saying something like "I've proposed this patch for stable, it would've
been nice if you could add a Cc tag for future similar patches", or so?
But no, you decided to complain, counted wrongly (*), accused us of not
doing a job (that you signed us up for to boot!), etc.

(*) I'll leave it as an exercise to figure out why, because really, this
email isn't about the actual count or proportion patches or anything,
it's about the fact that you decided to count at all.

And also, "Cc'ing netdev because it's not merged" - have you paid any
attention at all? There are conferences going on, some parts of the
world have fall/autumn vacations, etc. It's been what, a week? Even
Linus noted there wasn't a net pull request, but I'll note that nowhere
did he actually _complain_ about that, unlike you. Relax!


So ... in summary: Can you please just stop? In fact, I'm tempted to
just ask you to simply stop rendering your services unto wireless, but I
haven't spoken with Kalle about it now.

Thanks,
johannes
