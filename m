Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD0C539501
	for <lists+linux-wireless@lfdr.de>; Tue, 31 May 2022 18:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346117AbiEaQdQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 May 2022 12:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346078AbiEaQdP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 May 2022 12:33:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A7122531
        for <linux-wireless@vger.kernel.org>; Tue, 31 May 2022 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=rp9guynhM7LjpEUF+LCmA5Uyq8VDCNWfWSbe/NoUFCc=;
        t=1654014793; x=1655224393; b=g56pKxC0vhjzHf1r4ULzDfHJVQTbkD2XCQ+KEJMFtxWvbnX
        4hHMWCQFFfIQkOQMjnJH3JbbOe9o+rLSdzqkjVFwY7hm9ZO62iVmRqZpf+X2QVwrFnrWjkdQgB8pc
        /5B/Qr5ijh04yrgb+kH6y/AHLXcoVQSD1sG9102AVdY8JhE1VcdwJgtLsYc9lQboMwAPnytw1bFQz
        Dl0aGrNc8eOlMFf+oLIf7uYNuP4vHIUHCzTTt9jqWuxaeRdWF6sc/CkcwGcF5R5wkogOfzNCXq0Ff
        3z8CWdgxeaipSR0UQn1PW0//L/Sw8Rfv2sfHZ1tw4M3ZpzaDsWgpkMyyI1YLooyA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nw4nv-009aO1-6d;
        Tue, 31 May 2022 18:33:11 +0200
Message-ID: <8392dbd0cc395258dc55b2a2c5a3b863e8fbcb70.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4] initial interface-related MLO work
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 31 May 2022 18:33:10 +0200
In-Reply-To: <ed095171-3617-3066-e3df-8091f84078a2@quicinc.com>
References: <20220520113242.129546-1-johannes@sipsolutions.net>
         <ed095171-3617-3066-e3df-8091f84078a2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-05-31 at 09:31 -0700, Jeff Johnson wrote:
>=20
> Thanks Johannes,
> This is a great start, and looks good to me and my team!
>=20

Awesome, thanks for taking a look!

I should note that I've got WAY more stuff brewing in the MLD branch:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/=
log/?h=3Dmld

so I guess I should send that out soon ...

johannes
