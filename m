Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A865586726
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Aug 2022 11:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiHAJyI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Aug 2022 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHAJyH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Aug 2022 05:54:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5935F23BEB
        for <linux-wireless@vger.kernel.org>; Mon,  1 Aug 2022 02:54:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F81DB80EBD
        for <linux-wireless@vger.kernel.org>; Mon,  1 Aug 2022 09:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD63C433C1;
        Mon,  1 Aug 2022 09:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659347643;
        bh=l40el6459SHjrebvT1GqZMt1vHJrkK5DkamYsX0vbxo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dw8wtNKZgtl/7EUGAqAHyWPgyW2GUw3vxAoNvJZdJZk7eyK8JXNvnrcZGc50n/fgy
         3RI57iJOvn3RgK6abnmX9cP93kzoK4hS9PPvHCE7pUVc+ENwt/eXwhwo4pKYo8jsHL
         4qGWF75nvu5w6YwaNilzCh6PgDMphm7PG5wV4xA2WCK8uyZIR2+5YM+EJPnglAE7Wi
         MxXTyn1p2FQtV5TX15OH8wOAPALBWiULvXSns5zfVeqD+za+ICkhP+2rukLjTjfdxn
         DAl89MTNoy0vNcWxFx1tBQGEhq21b6Hdbnl0ceJT+oO30D0LO1++LHM6GT6wOhOpes
         3pkuUXDmGAHDw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Sriram R <quic_srirrama@quicinc.com>
Cc:     <johannes@sipsolutions.net>, <nbd@nbd.name>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] mac80211: Mesh Fast xmit support
References: <20220801070418.5420-1-quic_srirrama@quicinc.com>
Date:   Mon, 01 Aug 2022 12:54:00 +0300
In-Reply-To: <20220801070418.5420-1-quic_srirrama@quicinc.com> (Sriram R.'s
        message of "Mon, 1 Aug 2022 12:34:18 +0530")
Message-ID: <875yjcjnlz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sriram R <quic_srirrama@quicinc.com> writes:

> Currently Fast xmit is supported in AP, STA and other device types where
> the destination doesn't change for the lifetime of its association by
> caching the static parts of the header that can be reused directly for
> every Tx such as addresses and updates only mutable header fields such as
> PN. This technique is not directly applicable for a Mesh device type
> due to the dynamic nature of the topology and protocol. The header is
> built based on the destination mesh device which is proxying a certain
> external device and based on the Mesh destination the next hop changes.
> And the RA/A1 which is the next hop for reaching the destination can
> vary during runtime as per the best route based on airtime.  To
> accommodate these changes and to come up with a solution to avoid
> overhead during header generation, the headers comprising the MAC, Mesh
> and LLC part are cached whenever data for a certain external destination
> is sent. This cached header is reused every time a data is sent to that
> external destination.
>
> To ensure the changes in network are reflected in these cached headers,
> the Mesh Proxy path table and Mesh path table changes are monitored
> and corresponding headers are updated or flushed as applicable so that
> the header used for a frame towards a certain destination is valid.
>
> Old headers are flushed by the mesh housekeeping timers and based on the
> cache size.
>
> Only 6addr frame headers are cached currently.
>
> Tested with ath11k driver.
>
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> ---
> v2: Moved to static header cache size of 512 entries
>     Rearranged entry struct to avoid padding
>     Used GFP_ATOMIC while entry allocation in tx path
>     Compile tested from previous version - only above trivial changes
>
>  net/mac80211/ieee80211_i.h  |  20 ++
>  net/mac80211/mesh.c         |   2 +
>  net/mac80211/mesh.h         |  46 +++++
>  net/mac80211/mesh_hwmp.c    |   8 +-
>  net/mac80211/mesh_pathtbl.c | 396 ++++++++++++++++++++++++++++++++++++
>  net/mac80211/rx.c           |   9 +-
>  net/mac80211/tx.c           |  89 ++++++++
>  7 files changed, 566 insertions(+), 4 deletions(-)

The title should be:

wifi: mac80211: Mesh Fast xmit support

But I suspect Johannes can fix that so no need resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
