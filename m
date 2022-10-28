Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21627610CBF
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Oct 2022 11:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJ1JJw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Oct 2022 05:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJ1JJt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Oct 2022 05:09:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2331274A
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ibWBru5Dt8J5i4ipz9z6rQ2sTn075x9p4L+SeJ4yZbU=;
        t=1666948189; x=1668157789; b=XjVr3d4z5B62GgrwwSyU+xH8i2FdgdQzBSydFUNE7xy3HIo
        Z6ZKByuSHISUHT+OVN+8c3MKrHRcFJ7UpSh9BS39iK9FQKeLnLFx6Y8ht35orFRy9G/xZj6IF/NtY
        /JDp/9O+i9nKOT5wr1myptKht5W+MXDy1JmrGNMe3HadWRi1SZEA7WlYJbQo6HV63bRalFiPrlr09
        AguoEwE3nlMlZUoQ7EafeqZl9cpPdw0CT3TmnqwCIscltJvY4278aPa26KrPk3sR8RNc1VQa2VYNS
        WXEJeBc0l9mcB8/ggX17mU9ZPN2WFa5p5N9fVe1k8XMFy5XHCgtfKuWv38VlEMYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ooLN4-001IEH-2w;
        Fri, 28 Oct 2022 11:09:47 +0200
Message-ID: <10227c7575951aed46d1970da8b0922757d47bce.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: bcma/brcm80211: Use the proper include
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Date:   Fri, 28 Oct 2022 11:09:45 +0200
In-Reply-To: <20221026075653.105387-1-linus.walleij@linaro.org>
References: <20221026075653.105387-1-linus.walleij@linaro.org>
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

On Wed, 2022-10-26 at 09:56 +0200, Linus Walleij wrote:
> Surely this belongs in the
> BCMA driver: we cannot have all drivers performing cosistency
> checks on the internals of things they are passed.
>=20

"Surely this doesn't belong"?

johannes
