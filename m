Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9E6CFFD6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 11:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjC3Jbp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 05:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjC3Jbn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 05:31:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC4E6EAD
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 02:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EDAE61F71
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 09:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B39C433D2;
        Thu, 30 Mar 2023 09:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680168701;
        bh=QGy8yd9c2UIH6059uLBoARlihfw+Z+0rgDf4BkwQM/0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=vFZAl0NzwKZvfEcA9CSBapjEfBKqvyZjCJYgmev0mDFvC34CLEK8mzTqDtyU0ScS4
         AQ9jbg1+upWPUo3RrsGQgCSY2ekHPukpjyNBCbldWZ3seE095eFG+B0u0jXfnxJeTN
         +DfQ5YDObI2d+a0rq/cU26BBWIIrcn0VKLBJKRnkHogVep++h/uW9+zFzzFhYNmtqh
         UxO6uO4+NC5C6wwI0gz92Qy338PxRWWXhL6zYjcfnRNAueFLFtHIgsTPxE0GyWNFot
         08FpegRbfAWO7KHoFYh3h/OzdRxLF+i3gSh1b/bHvl2f2dl11mfrgsszfdJ97dqAqE
         jtA+KK4xzJUUQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8BD9FA22CA7; Thu, 30 Mar 2023 11:31:38 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     thomas.huehn@hs-nordhausen.de, nbd@nbd.name, kvalo@kernel.org,
        johannes.berg@intel.com, lorenzo@kernel.org,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: Re: [PATCH] ath9k: fix per-packet TX-power cap for TPC
In-Reply-To: <20230330071854.757154-1-jelonek.jonas@gmail.com>
References: <20230330071854.757154-1-jelonek.jonas@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 30 Mar 2023 11:31:38 +0200
Message-ID: <87wn2ymvph.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Jelonek <jelonek.jonas@gmail.com> writes:

> Fix incorrect usage of plain rate_idx as index into the max (power) per
> rate lookup table.
>
> For transmit power control (TPC), the ath9k driver maintains internal
> tables (in struct ath_hw) to store the max allowed power level per rate.
> They are used to limit a given TX-power according to regulatory and user
> limits in the TX-path per packet. The tables are filled in a predefined
> order, starting with values for CCK + OFDM rates and followed by the
> values for MCS rates. Thus, the maximum power levels for MCS do not
> start at index 0 in the table but are shifted by a fixed value.
>
> The TX-power limiting in ath_get_rate_txpower did not apply this shift,
> thus retrieved the incorrect maximum power level. For example, the
> maximum power for OFDM rate 0 was used for MCS rate 0. If STBC was used,
> the power was mostly limited to 0 because the STBC table is zeroed for
> legacy CCK/OFDM rates. This patch fixes this table lookup.
>
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

So what effect does this bug have in practice? Also, how did you test
the patch? :)

-Toke
