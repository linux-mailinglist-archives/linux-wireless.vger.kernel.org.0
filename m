Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4172A751918
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 08:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjGMGwa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 02:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjGMGw3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 02:52:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95C9E5F
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jul 2023 23:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=NHHbJSnOITp8Dpo6v+IMM/EbFGGBg8x4E38KZzH/dww=;
        t=1689231147; x=1690440747; b=QDu9MOTnCGtZcZtJ0YBdibU4EmWQp0Ish7NKCKx+p47DqyJ
        bhyq0waiagEhlnH4vLVwO7Mz9/eyvbSBEn8qy36gUAxtxJOrq49GFxGbNRNiwxOpSOwaiCC7A9FA0
        nVFjND+lOTm7U/dPSGcSSmhWHkf+sfRFopuSzC4DOTq0DpfJnmUTtqthsIPY8bnRD7WgUZe9vk5Ab
        +bM10HKCl79wDPBy+DnSXGLz14/Ld3XD4jZisXX6T+JbGaVhdj1tZzHoOvxRtYKGsXXbmVBdywRIb
        CwlxHMGVKGuI/Yepegd8t8M9Jt/irXcXt/plS//3pMYDGRoNOUxVysVJku0MwmIg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qJqBY-000yZD-2V;
        Thu, 13 Jul 2023 08:52:20 +0200
Date:   Thu, 13 Jul 2023 08:52:16 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     JUN-KYU SHIN <jk.shin@newratek.com>, linux-wireless@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_wifi=3A_mac80211=3A_fix_error_h?= =?US-ASCII?Q?andling_when_channel=5Fswitch_on_S1G_band?=
In-Reply-To: <20230712173724.607067c7@kernel.org>
References: <20230705141206.22a74fa3@kernel.org> <20230711080918.20114-1-jk.shin@newratek.com> <20230712173724.607067c7@kernel.org>
Message-ID: <E8117F40-49CB-4878-B314-57D228CB2C54@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Yeah I'm home for this week, so really just a few more days=2E

I think it can wait, I'm not even sure there's a driver that fully support=
s S1G band upstream yet? Other than hwsim, but that doesn't _really_ matter=
=2E Well, arguably it's a whole new feature for S1G, so doesn't matter much=
 anyway=2E=20

Also, I'd be a bit worried that the comment there means we didn't push the=
 frequency offset through all the APIs, so it would still not work with the=
 patch? Jun-Kyu, did you actually try this? If so, how?=20

But I haven't been able to take a closer look=2E

johannes=20

On 13 July 2023 02:37:24 CEST, Jakub Kicinski <kuba@kernel=2Eorg> wrote:
>On Tue, 11 Jul 2023 17:09:18 +0900 JUN-KYU SHIN wrote:
>> When channel_switch is performed to a channel with a freq_offset,
>> such as 909=2E5 MHz, channel_switch fails with the "-EOPNOTSUPP" error=
=2E
>> Since freq_offset is used in the S1G band, it should not be treated
>> as an error only with the freq_offset condition=2E
>>=20
>> Fixes: b6011960f392 ("mac80211: handle channel frequency offset")
>> Signed-off-by: JUN-KYU SHIN <jk=2Eshin@newratek=2Ecom>
>
>Johannes, since you seem to be around - yes/no/can wait? :)
>

--=20
Sent from my phone=2E 
