Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC697B219D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 17:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjI1Ppf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjI1Ppa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 11:45:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05050DD
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 08:45:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F521C433C8;
        Thu, 28 Sep 2023 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695915926;
        bh=yHNkxiAAIzBp3oCMDHb2rEM1ouYfuQia29ntrGpeQR4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pv9J2YimpM88uArDa0c5hTj8y7ulzFzNDozF6uz4DcPIrHHMYVV3TJ2CdEH0N35AE
         SILaijUyJzDyOzDWOKwLietyGAvvM+eDDeG2hNcPXT6LozTVwO9rCSVOsp4kNGzYTk
         liPq1EY0LvAfgqqU6cWeWTIv8iQ/yvGclpgkAQWNdugVEPDY7Z1GShlvyTGItx8IHx
         6llurfEIJvl0Z1FDJa1cL1jYQhnsqm2IZu3qRV7BEAwHEFsCew8I7LdrDdXl1KhkN0
         KE0tsy5PqMi6EHti3fOmGNYs73Ot00DJPtgCMIJbw6h4ONSKsuq8qugsqZHCC5emax
         pqjM8CZb0lznw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: consistently use kstrtoul_from_user()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230920115447.38355-1-dmantipov@yandex.ru>
References: <20230920115447.38355-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591592363.3096214.434817849719589486.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 15:45:25 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Use 'kstrtoul_from_user()' in 'ath11k_write_file_spectral_count()'
> and 'ath11k_write_file_spectral_bins()' and so simplify both ones.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Do not submit duplicate patches without marking them as v2 and including
a list of changes. Otherwise it's difficult for me to track what you have submitted.

This should have been marked as v2 but I already applied v1:

https://patchwork.kernel.org/project/linux-wireless/patch/20230824075121.121144-4-dmantipov@yandex.ru/

Patch set to Superseded.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230920115447.38355-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

