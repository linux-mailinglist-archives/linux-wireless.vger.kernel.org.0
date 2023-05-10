Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EC46FDC5C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbjEJLL7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 07:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjEJLL6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 07:11:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66AAB0
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 04:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9knHFr7otlMBFfqKoMSKVuSBAyhiYea7O0k8x1nSNpQ=;
        t=1683717117; x=1684926717; b=qJiDDyoRfLeSzmb3W72XI8jBOM0IPuAqeyt3dGcrtLPDm66
        xUPAH6wgVRsjkVfy6omaH9jjtJN5U9WmSAxpslK1IJu9qd3Hm8yKokU6RJqtSxF4mnXSxyjcQOn6O
        y8T1T4lYVUpPXet1BYH/wPa4v8Knx6FO3v42SEbB1Uqp+EhTlLYfLcgbR2tE7AF5Y9hVEE1GnHvnE
        Wo9abXT1iO4RmBRlhR2Izzyv2dWp1vYdAU5nswvoO76lTqw2Kbuf/LaN/ottCldjFzc2dAVySbP1O
        Sw4S/2wNITSFytn+pvhobSbGqwLWm87OhzE+xsB7DqOG1iTb7vkwc9ufy7rpcnqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pwhjf-005Mjg-14;
        Wed, 10 May 2023 13:11:55 +0200
Message-ID: <3fc1b7605f6a5e66184cb02781b3eba3e82e9ae9.camel@sipsolutions.net>
Subject: Re: wireless locking simplifications
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Date:   Wed, 10 May 2023 13:11:54 +0200
In-Reply-To: <12d77a1427cb4c0888783d8544772e3c2d1a8908.camel@sipsolutions.net>
References: <f3471853cd7063a4bd2d783caa14706ee9115748.camel@sipsolutions.net>
         <ZFV6fTH_7umEa5H0@slm.duckdns.org>
         <12d77a1427cb4c0888783d8544772e3c2d1a8908.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
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

On Wed, 2023-05-10 at 12:58 +0200, Johannes Berg wrote:
> Hi Tejun,
>=20
> > There isn't currently but workqueue already does something similar for
> > freezing by temporarily setting max_active to zero, so if you apply a p=
atch
> > like the following
>=20
> Thanks for that! I came up with a bit of a different patch, see below.
>=20

But ... this raises another interesting thing.

Now I have to call workqueue_resume() somewhere. But that means I need
two versions of wiphy_unlock(), one that does the resume and one that
doesn't, which is interesting. I can track it I think though.

This is probably a stretch ;-) But what would you think about a
workqueue variant that gets a mutex pointer to hold for all work
structs? Then we'd not really have to worry about that in each of them.
But it's not great to implement, I just tried a bit.

johannes
