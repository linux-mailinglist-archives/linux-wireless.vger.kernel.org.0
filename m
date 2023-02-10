Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565C3691EDF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Feb 2023 13:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjBJMNo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Feb 2023 07:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjBJMNn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Feb 2023 07:13:43 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAC75C4B1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Feb 2023 04:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=M2nh510caYP0iWno/JthUVqfjLGpoB0x9i0PGMtZbi0=;
        t=1676031222; x=1677240822; b=sOqdLMVPwyFuyzsuNotlAlKE4we8KQ/4Kz9rIFZNqc8CKpp
        KDKY08LHgY4UV+UXPMuA2JOHwTO6wRuJ/Iey2t3PZ2/fP+ZsQ+kHqzjOCkD8/5fI+YzYFsW97450k
        fcuEC7C+sdkwI+s/Aw0vuGy0YtkcrAMOqG75YrZVtsfBG1aV/TP96nSbhCz2B6D4sUssysXQfbkzY
        wEgtDW7g5pOteHVaBDG/FGUlK+OTPSjEH3mO/mzJCYSRAN7qMn3n1nsyyKjQrXWi9hHIgvFeYeTPt
        vBvQbZ8pHL10481duqLjCuKJt9r5oHlo3VWWppNIoTBSlS2nFBBXkaihIgdBvTMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pQSHb-008Hdt-15;
        Fri, 10 Feb 2023 13:13:39 +0100
Message-ID: <35950fde52b5578e83b713cf8c90d4fc5fb77605.camel@sipsolutions.net>
Subject: Re: Reassociation is broken via CMD_CONNECT
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 10 Feb 2023 13:13:38 +0100
In-Reply-To: <52d15e34cf20ddb372b2791c18776405f57d2516.camel@gmail.com>
References: <52d15e34cf20ddb372b2791c18776405f57d2516.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

Hi James,

Sorry, lost track of the mailing list a bit.

> "previous BSSID, to be used in ASSOCIATE and CONNECT commands to
> specify a request to reassociate within an ESS, i.e., to use
> Reassociate Request frame"
>=20
> But this actually isn't true when using CMD_CONNECT. The kernel does a
> full re-connect if PREV_BSSID is provided (easily verified by kernel
> logs which show an Authenticate frame being sent).

The authentication frame doesn't really have anything to do with whether
you use associate or reassociate? It's still required, unless you did
FT, but that's orthogonal?

Feels like it's working as designed?

johannes
