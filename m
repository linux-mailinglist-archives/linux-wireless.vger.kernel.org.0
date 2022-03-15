Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B11A4D99A2
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Mar 2022 11:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347579AbiCOKwW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 06:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347580AbiCOKwM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 06:52:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F01C52E6C
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 03:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+S5YvJ3U/eRuqTlqpQ18IM1Ds/mTfrhwMT8mxTaKRE0=;
        t=1647341380; x=1648550980; b=qyEUP9AR34e2YMS4E0T6KEfBL8znbyV+/EiJ0pfAinbFvHS
        7euWYh0zxKrHlYhZnS4Q36ayVfpWuGuzmmPfrG/xu2LUI7BXiaYC6WgGBeYSrmc564BkO5m6+5g9m
        wGj/kMOFdbRDT7hYArbAsJ3ZZ8MskEamsKOCBcc1JQKAIXG4T/UEm+YqpOcqZ8fGyUhMNrLplqTC7
        75KVPVqiy2CADewT99dHLXCSMQ/ebPI88J6Nbtw/wFQBRTgR7MfvdZogAaNH8cZ5I+VvhRsz7QjfT
        JBGiwXKD8nhdANuDY9E0Ge9X3OsTUxwT8TSUTZ+rguCUPlG3owRpchmb+0mEwa/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nU4kB-00DSu1-As;
        Tue, 15 Mar 2022 11:49:35 +0100
Message-ID: <9eeb781a2d04d8fdef41611674ed91029382885d.camel@sipsolutions.net>
Subject: Re: [PATCH] rfkill: keep rfkill event compatibility with old
 userspace applications
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 15 Mar 2022 11:49:34 +0100
In-Reply-To: <20220315102641.233703-1-jtornosm@redhat.com>
References: <20220315102641.233703-1-jtornosm@redhat.com>
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

On Tue, 2022-03-15 at 11:26 +0100, Jose Ignacio Tornos Martinez wrote:
> Old userspace applications (for example bluez version before c939747f543a),
> that still use the original format for rfkill events (with 8 bytes size /
> RFKILL_EVENT_SIZE_V1) and are not requesting any specific size but a large
> one, are broken because they are checking the received size.

... because they're *not* checking the received size.

g-s-d by the way is even more broken before the fixes, because it
assumes that this thing is a stream protocol, rather than individual
messages. This was never OK, it just happened to work anyway.

> In order to avoid this compatibility issue, we can try to adapt by checking
> specific unusual requested sizes:
> - bluez: 32
> - gnome-settings-daemon: 1024
> If this is the case, we will consider that we have to use the original size
> (RFKILL_EVENT_SIZE_V1) and old applications will be able to work as ever.
> For other values, we will follow the new behavior with extended events.

Now, however, applications that do use 32 or 1024 as the buffer size,
the latter of which, btw, is just the default glib size, not related to
g-s-d, will never be able to get the new data. They don't really need it
for now, but if we add anything else and keep this workaround,
applications will have to work around the kernel *again* and change
their read buffer size - which in the case of g-s-d, as I said above,
isn't even a conscious choice but comes from glib.

> No other applications have been identified that behave in this way, so
> reserved event sizes are defined.

I'm going to assume that you're doing this for RHEL, in which case I'm
not sure this even addresses your requirements - if there's an
application with read size 64 that you don't know about, it would still
possibly be broken?

I tend to think if you need a stable guarantee here you should probably
just revert the kernel patch instead.


I know there's no good choice here. This thing was intended to be
forward and backward compatible, but implementations got it wrong. We
therefore had a regression, but it was noticed fairly late after being
introduced, and so it was a bit difficult to revert. Also, there was
really no good other choice - perhaps we could have added /dev/rfkill2,
but ...

Ultimately, all the userspace folks basically said "oh yeah we got this
wrong" and fixed it pretty much immediately.

johannes
