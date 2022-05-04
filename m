Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3ED5196EB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 07:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbiEDFdC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 01:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiEDFdB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 01:33:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309B923BD0
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 22:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2E60B82351
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 05:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F79C385A5;
        Wed,  4 May 2022 05:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651642163;
        bh=plJ2nLfSySznqojpxRhT+kGpcXE6KjRIL+dyHw4JFe8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eScqYcliO+0L+yxDDYbIAIsq95jxra7DkDz8VOGyreOZq9ai4Qp0mba4oWoUMY8Re
         o0Nzq8vVFMJD9YUOHUXucqQsOmbnPmLBfTdGgObkq7v2ekKxtKZvJW776mjV4e5kt9
         R1UxQG/Y3jM/1wV4/mmRHA67BhNfOWNaXc6HD86masfMBeooI+3M8FLw50JHzlu+Se
         Q5HDGib3qp/I7a5+TjoserL7fJ3hRm1sMunlvBHThTtZtu0RwvmwD6Sv/VtWdatp03
         XC/hy8iX49xXg2pXOS1AZqhv941lu+Wm1Ezv6i3g+MxvqbP0rK64EJAw9I/PqM77q6
         gm/uQGw+KwT2w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v2] wfx: avoid flush_workqueue(system_highpri_wq) usage
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <f15574a6-aba4-72bc-73af-26fdcdf9fb63@I-love.SAKURA.ne.jp>
References: <f15574a6-aba4-72bc-73af-26fdcdf9fb63@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     =?utf-8?b?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165164215752.17573.5008530399127165115.kvalo@kernel.org>
Date:   Wed,  4 May 2022 05:29:22 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> Flushing system-wide workqueues is dangerous and will be forbidden.
> Replace system_highpri_wq with per "struct wfx_dev" bh_wq.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Acked-by: Jérôme Pouiller <jerome.pouiller@silabs.com>

Patch applied to wireless-next.git, thanks.

eeff214dbfcb wfx: avoid flush_workqueue(system_highpri_wq) usage

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/f15574a6-aba4-72bc-73af-26fdcdf9fb63@I-love.SAKURA.ne.jp/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

