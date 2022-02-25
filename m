Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37044C4175
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Feb 2022 10:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbiBYJ37 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Feb 2022 04:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238185AbiBYJ36 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Feb 2022 04:29:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1EB18CC4D
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 01:29:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B58F5B82A89
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 09:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEE9C340EF;
        Fri, 25 Feb 2022 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645781364;
        bh=fFmwYiQA9Ze3GRlC81umDN9MBSnEvIX59FSyWJ7HclQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Jy78vQ0VFHm97fEBzezbGistgI3HWem4u3xcijZY2DEyjNGON7s0+5+gQs+YsaE3Z
         vF9DfLbYnoAVAF2WH85kzAVI5SB3C55nWkkBKhAtr16Xn9UZ+9MT0hcsuTQ5d0x1OI
         c3Ir90+yxyKrIxYox364Pv+csWMmjtB/5f9NKd74hzvS48iFFeGPx/enJGimnVWvCP
         k5oZ4wvZ2vQwMZRgVowvBuBoF5eMzgi+WXK1l71p4sH6UV36DuFY7NIaB3Jy7kwPMa
         Id6R0sj8nL9oV5Weq6HI/OGv9cmA8GIOyt7bX/RQOVqnwK+8Q1BVjvhVLdv64ArCWd
         Q6+12oT1tQyAQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2022-02-24
In-Reply-To: <cb7c44ba-3a49-a0fa-b203-e23a8761a3bf@nbd.name> (Felix Fietkau's
        message of "Thu, 24 Feb 2022 14:42:57 +0100")
References: <cb7c44ba-3a49-a0fa-b203-e23a8761a3bf@nbd.name>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 25 Feb 2022 11:29:19 +0200
Message-ID: <87ee3rthu8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's a replacement for my second pull request for 5.18.
> It fixes the MT7986 include issue and adds a DFS fix
>
> - Felix
>
> The following changes since commit a0061be4e54b52e5e4ff179c3f817107ddbb2830:
>
>    rtw88: change rtw_info() to proper message level (2022-02-22 17:31:13 +0200)
>
> are available in the Git repository at:
>
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-02-24
>
> for you to fetch changes up to 00a883e6806e394638d344ba281c2727d6ffcbd4:
>
>    mt76: fix dfs state issue with 160 MHz channels (2022-02-24 14:40:23 +0100)
>
> ----------------------------------------------------------------
> mt76 patches for 5.18
>
> - bugfixes
> - mt7915 thermal management improvements
> - SAR support for more mt76 drivers
> - mt7986 wmac support on mt7915
>
> ----------------------------------------------------------------

Pulled, thanks Felix.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
