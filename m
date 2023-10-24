Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B9C7D5C5D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 22:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbjJXUZ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 16:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbjJXUZ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 16:25:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CDAD7F;
        Tue, 24 Oct 2023 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1UXtNveQEoqW90tJOyIfMQP3SasUg49M796K2bciGh0=;
        t=1698179121; x=1699388721; b=HwffRNGN41XiFhHwjS8Ed0sap2p/6XM44sVy0BuJnQ0y2cP
        iTGHPpNe2t/wOUXopk6+zy0/b95GFgoX+XWwiaYF1fT7dHN1jTsGZqikp/MwI0cKQT97zSm1kkyd+
        TzgL8sifYZIQbFc71EGjhqvrWE0h/hJG8QXOwhqnCvChb9CU+cCIuxenZ4eLPGbCz+otrRoJ8PJqH
        xpRvKlNJtFUaxDvUG+5VPRgCBXm8pWElw8DxBOIEHmf7pdZsnZAmhqi1l4DqrxI0sH118GSFcoUy3
        4JpRSIi/3TP6ZSHtMGMCtKD6JRZLJZs9thtPqmsSYRDoDzyIGhEbyfQ5QbHsNmHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qvNxn-00000001azr-20eK;
        Tue, 24 Oct 2023 22:25:19 +0200
Message-ID: <1020bbec6fd85d55f0862b1aa147afbd25de3e74.camel@sipsolutions.net>
Subject: Re: pull-request: wireless-2023-10-24
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Tue, 24 Oct 2023 22:25:18 +0200
In-Reply-To: <169817882433.2839.2840092877928784369.git-patchwork-notify@kernel.org>
References: <20231024103540.19198-2-johannes@sipsolutions.net>
         <169817882433.2839.2840092877928784369.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks Jakub.

> > Note that this introduces a merge conflict with -next,
> > which Stephen reported and (correctly) resolved here:
> > https://lore.kernel.org/linux-wireless/20231024112424.7de86457@canb.auu=
g.org.au/
> > Basically just context - use the ieee80211_is_protected_dual_of_public_=
action()
> > check from this pull request, and the return code
> > RX_DROP_U_UNPROT_UNICAST_PUB_ACTION from -next.

Are you planning to merge net into net-next really soon for some reason?

If not, I can resolve this conflict and we'll include it in the next
(and last) wireless-next pull request, which will be going out Thursday
morning (Europe time.)

johannes
