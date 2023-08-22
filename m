Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD5078408D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 14:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbjHVMRM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 08:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjHVMRL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 08:17:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDA6199
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Yf6HaOv/fb1s3bBWpEKw7DTF+GNxqNl6lXlXMYGVnW0=;
        t=1692706623; x=1693916223; b=hDelK8n3OPP0waBTembiVPTK3KXezh3Uk52434gXi2T2dCu
        c7dNiPTwTrk2OfnPv3/2p/W12qz0KkpaKlFF+V8M16eHpLe4vN4DtA1wMVbKU/MIb39k1+X2dgrTA
        9gw44D5FeDNM1lIm5SYYTBmfpxk0sDFNvXKZcbHqz3o58tco3kBDaGBk1faHhK26dCwZQHlNBNEhj
        Zy9KVjGVzzdyEkhlUbcEEiLWxAM0phi3PMHArfWdDsoXoko4hPzKkEWpsGafc5P0WtkV+v3Hh6DEt
        gV+CjyVzHvBcSJPv6p+HqfMd8NaYnI2yJ8qGP8X57fZtEp/koL8ajuIFuA085oqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qYQJd-0056zM-36;
        Tue, 22 Aug 2023 14:16:58 +0200
Message-ID: <3e6b00ff897ebe2e46a56f029808d8106d6aa2cd.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211_hwsim: do not ignore the value returned
 by nla_put_u32()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Date:   Tue, 22 Aug 2023 14:16:56 +0200
In-Reply-To: <339891ad481cfdcfa48a726da80202b3121a6000.camel@sipsolutions.net>
References: <20230814092128.14330-1-dmantipov@yandex.ru>
         <339891ad481cfdcfa48a726da80202b3121a6000.camel@sipsolutions.net>
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

<zOn Tue, 2023-08-22 at 14:15 +0200, Johannes Berg wrote:
> On Mon, 2023-08-14 at 12:21 +0300, Dmitry Antipov wrote:
> > In 'mac80211_hwsim_vendor_cmd_test()', do not ignore the value
> > returned by 'nla_put_u32'. This follows commit b970ac68e0c4
> > ("wifi: mac80211_hwsim: check the return value of nla_put_u32").
> >=20

Which, btw, that did too, so I'm just going to revert it as completely
pointless.

johannes
