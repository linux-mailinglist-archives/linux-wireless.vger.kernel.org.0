Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51A55FF2B0
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiJNQ6M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 12:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJNQ6L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 12:58:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFC61D587E
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+wWAKSwF3ux1y99cey98mf6LN5wafcQICJXODUhXrQw=;
        t=1665766690; x=1666976290; b=tBE+39GeJv1U/nfELJryxvNtXXmhYEeRUJptEYkOva89akk
        FvXfy8aVLetgcPxQujQzjFPadvsUneENB7f7iOyaTmdLZ08XBR1LfAiWgBjIK1R4ZQstXJGrj2KkU
        +Q5ZSapckapx5bKMNCtb2oxNeLMY+rN0uumjw1wzJYr7sYzmNEJGfB9/PN3d+YFZnhUDGLOyHy//z
        PR0skyItNSQGdWltnhIZlqPqUtFW46WmQdqutcKFLhN4JsQg7qeU/tB9kRgrpyj1SKs61EW05gkZ1
        W54NKKhtEsmKS/F5FiC0PDCU8wbsdrUtlu3vrkwvcdtCP0bjw9Jldw0dPuzfvxJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ojO0d-006hDC-1j;
        Fri, 14 Oct 2022 18:58:08 +0200
Message-ID: <5da63402ee109ab6df3e0cdbaab3ddaa2156ab8c.camel@sipsolutions.net>
Subject: Re: Splat from net/wireless/wext-core.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 14 Oct 2022 18:57:54 +0200
In-Reply-To: <988d4c5c-a9a4-2f16-aa3c-e15778c04d46@lwfinger.net>
References: <988d4c5c-a9a4-2f16-aa3c-e15778c04d46@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-10-14 at 11:49 -0500, Larry Finger wrote:
> Hi,
>=20
> With a recent pull from kernel mainline, I am getting a log splat shown b=
elow:
>=20
> [   29.369446] ------------[ cut here ]------------
> [   29.369447] memcpy: detected field-spanning write (size 16) of single =
field=20
> "&compat_event->pointer" at net/wireless/wext-core.c:623 (size 4)


Yeah fixed by commit e3e6e1d16a4c ("wifi: wext: use flex array
destination for memcpy()") I think?

johannes
