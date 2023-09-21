Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AD27AA487
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 00:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjIUWLh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 18:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjIUWLN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 18:11:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E78883F64
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:37:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AB7C116B6;
        Thu, 21 Sep 2023 08:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695284006;
        bh=w9s/3KqBpjc+F0htGHCCTEf8hPrclIy6Ux/UJYVbORQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Ei62OwSI5BJtGMKOvLHwcgpMcK03iM0jFtMjxnhziKeQ6VyBRnnPr7mlFLqaa8aK4
         0rmGiTaP5je9/33SGtvX1mqGzCoASfdKaZ5VznUz+YAnXNB1LcRc0ePrVdsTilJYqk
         VYoTonLcgmMIIDbVtVN6XiUOjP489vTCNCK4SDrqm0enm4PgZT2acobznd6LnSVl2X
         SBouwkYil8zhOdewkLFtgTGXtxZmzcIbxFDMKJqdMSDDJQtILbnFIGTZcRmZNN8zDp
         AeYvgU2S7qX9ZI1Ledk+BNcDabxA4izd7LHgge275L9RHhSJkwv+Z7Lx6XzKHXn1WW
         4SyzIwcp2FCRg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: drop NULL pointer check in
 ath11k_update_per_peer_tx_stats()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230906093704.14001-1-dmantipov@yandex.ru>
References: <20230906093704.14001-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        ath11k@lists.infradead.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169528400337.1539628.7739014266024869825.kvalo@kernel.org>
Date:   Thu, 21 Sep 2023 08:13:25 +0000 (UTC)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'user_stats' is a fixed-size array of 'struct htt_ppdu_user_stats'
> in 'struct htt_ppdu_stats', any of its member can't be NULL and so
> relevant check may be dropped.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

ac13a7842ab4 wifi: ath11k: drop NULL pointer check in ath11k_update_per_peer_tx_stats()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230906093704.14001-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

