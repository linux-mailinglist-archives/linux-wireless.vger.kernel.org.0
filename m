Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B5F5B31ED
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 10:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiIIIjF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 04:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiIIIjD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 04:39:03 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6A312FBA2
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 01:38:57 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1662712735; bh=N/ilnw/z9un/lpAI2LbnB2098WXoWdTiZTkSpDnCLVk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dekgAE+SjQqQv+Xmn/skXgDUjnsqj64JHLkzT8lHHo6zacRbbiSTicOOVwMhRIAGD
         Q39p5NVTcA6/y9MD/m9nOxJ00BY7HN5MhI9+crj09/ZDv1TZLNeiE8G8Y353Korba6
         93gLwOPuih4yClDsAVc5xlS33hC/9BxkTAXbZWWFBZ21nSj/aeJqNSoym5MiljxJ26
         2DYhlm6TL4tzS2fewsN+XvXtPsALOFbZSynkqSmhnjIqktTHMufHL4lBo43IOKgiQM
         hiIINwmrQ9CuCi3ZUc+I7PNhLUL41aqDscfYB4qRJx+m2rmbLu072o64AU5XlKQGBM
         DlD3rdPozwTNw==
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ayala Beker <ayala.beker@intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: Mark IWLMEI as broken
In-Reply-To: <87k06daysx.fsf@kernel.org>
References: <20220907134450.1183045-1-toke@toke.dk> <87k06daysx.fsf@kernel.org>
Date:   Fri, 09 Sep 2022 08:26:51 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87o7vpcbbo.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> The iwlmei driver breaks iwlwifi when returning from suspend; the bug
>> report[0] has been open for four months now, and now fix seems to be
>
> s/now/no/? I can fix that.

Yeah, oops, sorry...

>> forthcoming. Since just disabling the iwlmei driver works as a workaroun=
d,
>> let's mark the config option as broken until it can be fixed properly.
>>
>> [0] https://bugzilla.kernel.org/show_bug.cgi?id=3D215937
>
> So does the bug only happen with iwd? Should I mention that in the
> commit log? It would be good to describe the conditions when the bug
> happens.

Well, what happens is that the interface ends up in the 'down' state
after coming back from suspend. And iwd doesn't touch the interface
state, but wpa_supplicant does, so the user-visible "my WiFi doesn't
work" thing only happens on iwd...

>> Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation =
with CSME")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> I assigned the patch to me on patchwork and will queue for v6.0.

Great, thanks!

-Toke
