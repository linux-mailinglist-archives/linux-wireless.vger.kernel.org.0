Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5507191C7
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 06:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjFAEXh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 00:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjFAEXO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 00:23:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03256134
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 21:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9421560FB2
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 04:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63682C433EF;
        Thu,  1 Jun 2023 04:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685593374;
        bh=Xv2fMCbkmd0ylm+6FVJm8o9GXvKs9p+1igAMlybCEJg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FydQYeLEblK/9STm89lIJo/mrbWbaltouJW7/LNfPbTVhrehbL2JmnDxVgKhqVgiD
         HYCgkYU8Os3EunMACCSOnUtMkoZEKnLbBiAwC7jKiP0gkN90kYy9/WDHzWuSMKaKKt
         0tY6E3XjHf9wXglkAS1SVHZptLjznq0Ia3MgFSPXoBRA4kKfISFE9aSlka0a6JCtWr
         KeisgMVCiNzxmjmqFn2P7DZDn5AvVuJnwa3zMCseM3TtgwfL4dT6PSj15GJT6Ynp4F
         G3KCavfFwTaN+X3N/1/TVxpTRenuj+/VD0ai2DAWaOgk3POyrV2SMPy+43i/8D/YPb
         n2aww1Kj7j4nw==
From:   Kalle Valo <kvalo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mt76: mt7921:  Support temp sensor.
References: <20230519163611.1640585-1-greearb@candelatech.com>
Date:   Thu, 01 Jun 2023 07:22:48 +0300
In-Reply-To: <20230519163611.1640585-1-greearb@candelatech.com> (greearb's
        message of "Fri, 19 May 2023 09:36:11 -0700")
Message-ID: <87leh3ke07.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

greearb@candelatech.com writes:

> From: Ben Greear <greearb@candelatech.com>
>
> Allow sensors tool to read radio's temperature, example:
>
> mt7921_phy17-pci-1800
> Adapter: PCI adapter
> temp1:        +72.0=C2=B0C
>
> Signed-off-by: Ben Greear <greearb@candelatech.com>

Cosmetic issues in the title, there are two spaces after "mt7921:" and
no need for period at the end. This is the recommended style:

wifi: mt76: mt7921: Support temp sensor

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
