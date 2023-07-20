Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B07575A6FD
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jul 2023 08:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjGTGzp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 02:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGTGzo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 02:55:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A5B1711
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jul 2023 23:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF268618E1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 06:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A44C433C7;
        Thu, 20 Jul 2023 06:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689836141;
        bh=Y7xhXA8cRIFiZM+O3xe+B7rVetwM5gUm3s6BbKfNQNU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JaH4OPDH0zd4O03ZXzlucCErb/V4qBZRqniOYIJsYqYjY7lFBD66UQtFRdRObtFm+
         Ft++6VErQBRhnwEWjaJmM88dfRy6GhZP/Qwl1I5ONdWwTSLyPgxhnyRsvQSdodKFX4
         BpMvbv7OMHmd94RnguAjb0IFPc4aWovnpg0RWTp/fEmRPT3QSRNgbF44VvVybpvOVi
         7jtl9hxhkrdLcyBcQ//PJpqmvGOXOCD9gXS6tqrNQAeyOYVqsp0+X+1ogPqZjs/063
         MaV/Lp59Y5hwo1a9q6xjMpMdoqjV2yS/eywQf1SjEe3UvSBdBIXftR0PL4W7tieWOA
         9uFqmB5NlWS1A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Pink Perfect <pinkperfect2021@gmail.com>, amitkarwar@gmail.com,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
References: <20230713023731.2518507-1-pinkperfect2021@gmail.com>
        <CAKNAPeOvG1MVD0y5xuZpN8mSEzvrzcvRhdyrTJhju-_Z1nGV0g@mail.gmail.com>
        <20230713105644.49444826@kernel.org>
Date:   Thu, 20 Jul 2023 09:55:38 +0300
In-Reply-To: <20230713105644.49444826@kernel.org> (Jakub Kicinski's message of
        "Thu, 13 Jul 2023 10:56:44 -0700")
Message-ID: <87sf9j3wd1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 13 Jul 2023 10:44:56 +0800 Pink Perfect wrote:
>> Sorry, forgot to change the signoff name, after you review this patch I =
can
>> submit a new one
>
> Do you mean change to "Pink Perfect", is that the name you'd sign
> legal documents with?
>
>> On Thu, Jul 13, 2023 at 10:37=E2=80=AFAM pinkperfect <pinkperfect2021@gm=
ail.com>
>> wrote:
>>=20
>> > Make sure mwifiex_process_mgmt_packet and its callers
>> > mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet
>> > not out-of-bounds access the skb->data buffer.
>> >
>> > Fixes: 2dbaf751b1de ("mwifiex: report received management frames to
>> > cfg80211")
>> >
>> > Signed-off-by: pinkperfect <pinkperfect2021@gmail.com>
>
> No empty lines between tags, please.
>
> You mentioned reporting the problem to chromeos, since mwifiex
> "maintainters" seem to be AWoL, would someone from their team
> possibly be willing to venture a review tag for the patch?

We have four maintainers for mwifiex and total silence:

MARVELL MWIFIEX WIRELESS DRIVER
M:      Amitkumar Karwar <amitkarwar@gmail.com>
M:      Ganapathi Bhat <ganapathi017@gmail.com>
M:      Sharvari Harisangam <sharvari.harisangam@nxp.com>
M:      Xinming Hu <huxinming820@gmail.com>
L:      linux-wireless@vger.kernel.org
S:      Maintained
F:      drivers/net/wireless/marvell/mwifiex/

I'm very close of marking this driver as orphan unless anyone steps up.
This is not how to maintain a driver.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
