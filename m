Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437154DAE40
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 11:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355144AbiCPKbT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 06:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243190AbiCPKbT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 06:31:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000D45D5DD
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 03:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OEI24XL99P4h/59hQGCvtYQwH41FrBPjviFy7mCJix0=;
        t=1647426604; x=1648636204; b=fWBModcayd9Nr/RMrqFM9CAXS2hJzjh0yZACiZ7DV1YuiQ0
        N15ZsbDpB5csR/K1qM77E/dqtw6CpY9r/NLQLal0u86X/iMKPg0iSGexjtD4TvcHhmz8rofdmSGRL
        loF8I3wPvv1pH3UKFDISUDRhMtAqdKYhT0nbPECxVZNbWbo0OeP+MxuLUPm5CQMeI3oyN1ZFAjjPl
        y733t3s/lAVyFbDPzmuSqEYBUlNdTUARP7WO+MTsC3RbsQzIMSdQCK2oAEqDUXPL4/Y9WVp8pdcGG
        GRhN9Ds2SpKx/SygvMHA42d6zGEglBiJUNWXDvP27Q9Mol++vjpCxveNIwImqK4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nUQum-00DvkS-DI;
        Wed, 16 Mar 2022 11:30:00 +0100
Message-ID: <520961736af888cabdd106c7d86ee2153fea77f5.camel@sipsolutions.net>
Subject: Re: [PATCH] rfkill: keep rfkill event compatibility with old
 userspace applications
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 16 Mar 2022 11:29:59 +0100
In-Reply-To: <20220315124811.237037-1-jtornosm@redhat.com>
References: <20220315124811.237037-1-jtornosm@redhat.com>
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

Hi,

It'd be nicer if you were to actually reply in the thread. Now I even
have to copy/paste because you put everything into the signature :(
Don't make it so hard to interact!

> >    On Tue, 2022-03-15 at 11:26 +0100, Jose Ignacio Tornos Martinez wrote:
> >    > Old userspace applications (for example bluez version before c939747f543a),
> >    > that still use the original format for rfkill events (with 8 bytes size /
> >    > RFKILL_EVENT_SIZE_V1) and are not requesting any specific size but a large
> >    > one, are broken because they are checking the received size.
> >
> >    ... because they're *not* checking the received size.
> 
>  
> I really wanted to say "because they're checking the received size", that is,
> because older bluez is expecting 8, and as bluez bluez is receiving 9, it was
> rejecting the event, and therefore it is broken.

Well, ok, then "because they're incorrectly checking the received size".

> I tested g-s-d without their fixes and it keeps on working fine because
> although the message was buffered, it took 8 byte event size and when it read
> immediately again, it got another message with 1 byte that was rejected (8
> bytes expected size) and this way exit from the loop.

Not sure that's how it works? Before the fixes there in g-s-d, it would
have accumulated the extra bytes until they were 8 bytes and a new
message was formed, or something like that, no?

Anyway, you can still argue we broke it by changing the size.

> Yes I agree with you, it would be enough and easy to always send the 8
> bytes
> events from the kernel as before (at least for RHEL).
> But, I am just trying to do it in a more compatible way, because as
> you said
> we do not know the behavior of all applications using the rfkill.

But you're doing it *less* compatible. If you want to be perfectly
compatible, you have to revert the entire new event size. You're just
hacking around the edges to make the two broken cases you found work. I
really don't think that's a good idea.

At the time, I was tempted to add an ioctl, so you'd have to do

 ioctl(fd, RFKILL_I_READ_THE_DOCS_ABOUT_STRUCT_SIZES,
       RFKILL_AND_I_PROMISE_TO_READ_NON_STREAMING);

to get extended messages out at all ... Maybe should've done that. Right
now, nobody really has to care about the extra field at all anyway.

But honestly, compared to fixing two or three userspace applications
(bluez and g-s-d, systemd just had an API not ABI issue that we could
work around) seemed simpler?

johannes
