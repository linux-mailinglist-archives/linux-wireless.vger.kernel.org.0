Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06DF6D45ED
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 15:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjDCNgt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjDCNgo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 09:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592C91025F
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 06:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCF3F61B8C
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 13:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6C5C433D2;
        Mon,  3 Apr 2023 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680529001;
        bh=LBhVsuQk7H0HhCsrNJd5M3couUqj8lNk7mtStDxrbcM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=C9h0eTSpqed1CRKmq6P70oAUzIAAsATnfJA8hsHchRxyg176OcKvKgQFScTitzhqr
         jAo1nidxjrLOeUFo/3TyGKLddEQK0kywjuxlrsDSHbx7YCOZGON0gcjPZIPAZpG6BE
         NSqFXkum24TwmkNgs/tcVJsCh3FH16o9ziaxKRC7tfY/5384+vKLQuDx9M4nrFKEdw
         dsa7PIl1Z9ajGiwi/itcVAuGKaxhq31Roh4ReNayvHU4F3KQYlqsaLHmuRWlagIc6y
         K32NZ/71WwjDZ1g8oIBXM9h1s+a7dIHNWf2n85xLudz7T3p5keS0BWnMghtSrX1k1t
         uvxwagMXD/Rkw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rtw89: add counters of register-based H2C/C2H
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230316063956.71687-1-pkshih@realtek.com>
References: <20230316063956.71687-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168052899889.11825.13843164993686537391.kvalo@kernel.org>
Date:   Mon,  3 Apr 2023 13:36:40 +0000 (UTC)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The register-based H2C/C2H are used to exchange information between driver
> and firmware, but only apply to narrow area because its data size is
> smaller than regular packet-based H2C/C2H.
> 
> This kind of H2C/C2H must be paired. To identify if any H2C/C2H is missing,
> update counters to help diagnose this kind of problems.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

e749ef968f14 wifi: rtw89: add counters of register-based H2C/C2H

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230316063956.71687-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

