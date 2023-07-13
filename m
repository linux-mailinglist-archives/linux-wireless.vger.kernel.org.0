Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2505752A14
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 19:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjGMR4s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 13:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGMR4r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 13:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D862722
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 10:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7425B61B11
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 17:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C377C433C8;
        Thu, 13 Jul 2023 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689271005;
        bh=XOm7h67SEFjPll5LwXucwRWSAmJfBKZbmCSZdC4SY/c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OnEAiGDiUNFexGX9go7GWytA0ObHN73KVCUXJC9JmLBLBJhAGoZhBRTQa8sf7TNE0
         rQu5G7iS+tI6Gqa2ie9FpXNzDGkjE2HyC7LxEgwLUszoQaW0o2zGXnD2bRrRwi4Gfi
         aaBRBCl4L+30ANVH2pI0bc3pTwacWKTNRT2AybK0zfpsrTyuGUxkOmlJtw9CorVT4e
         OxsOLUee1FnvNUuSwmoOEovq8cklDsBJmZRJD1WNw+mAUVm3wO6jviMJBe+0/MYVDm
         0zmKbvjOrh8KRsBnYwcAMNi24n1AVgxLkqXEoVi0/9KNFLEpzk7xyd5zGPtjJwkIn3
         Pn74IxGfvL4Vg==
Date:   Thu, 13 Jul 2023 10:56:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Pink Perfect <pinkperfect2021@gmail.com>
Cc:     amitkarwar@gmail.com, kvalo@kernel.org, ganapathi017@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
Message-ID: <20230713105644.49444826@kernel.org>
In-Reply-To: <CAKNAPeOvG1MVD0y5xuZpN8mSEzvrzcvRhdyrTJhju-_Z1nGV0g@mail.gmail.com>
References: <20230713023731.2518507-1-pinkperfect2021@gmail.com>
        <CAKNAPeOvG1MVD0y5xuZpN8mSEzvrzcvRhdyrTJhju-_Z1nGV0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 13 Jul 2023 10:44:56 +0800 Pink Perfect wrote:
> Sorry, forgot to change the signoff name, after you review this patch I c=
an
> submit a new one

Do you mean change to "Pink Perfect", is that the name you'd sign
legal documents with?

> On Thu, Jul 13, 2023 at 10:37=E2=80=AFAM pinkperfect <pinkperfect2021@gma=
il.com>
> wrote:
>=20
> > Make sure mwifiex_process_mgmt_packet and its callers
> > mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet
> > not out-of-bounds access the skb->data buffer.
> >
> > Fixes: 2dbaf751b1de ("mwifiex: report received management frames to
> > cfg80211")
> >
> > Signed-off-by: pinkperfect <pinkperfect2021@gmail.com>

No empty lines between tags, please.

You mentioned reporting the problem to chromeos, since mwifiex
"maintainters" seem to be AWoL, would someone from their team
possibly be willing to venture a review tag for the patch?
