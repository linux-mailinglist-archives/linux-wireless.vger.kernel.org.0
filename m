Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EB07A830D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjITNRD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 09:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbjITNRB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 09:17:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A68BE4
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 06:16:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A575CC433C8;
        Wed, 20 Sep 2023 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695215785;
        bh=X6WSxYFOQ44zCks4qQvECXYOseDhapHvD4J4nF2i2IQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qS3Nd8sjZ8g/1Zn1JAyKnaLpZp1zIhVoNqczKeL0lV7BthWrT3dfa75uLrtvp/H2u
         08wlOIfhtU8pCQjaf4Xv8fZC5qk1i0YtjefkkQJwrqNQ8DVVGS65+DHd4ba/Nl4gp1
         XWmDXlSRFnVz8LcxHKOTLEqLbC/JltRmOV3N2/Hj/uVM24W1dHCvefZRDwzXzsVv/p
         762AvlNy3t2qdSLwvNNvPAPbpIVtXiea3HbVA30jrTZgjyalR8o31aHkNfjfcAoabs
         O2KLYulxMdk1p/a9MY4ku+fx4EP3Ujo6t99FRUsJoNyYU75d0wiOgzVH+4SBT/AWUt
         +LGPHDaS0zkjQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] wifi: ath9k: simplify ar9003_hw_process_ini()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230823182401.196270-1-dmantipov@yandex.ru>
References: <20230823182401.196270-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169521578189.1118199.3983270452388999341.kvalo@kernel.org>
Date:   Wed, 20 Sep 2023 13:16:23 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since commit 8896934c1684 ("ath9k_hw: remove direct accesses to channel
> mode flags") changes 'ar9550_hw_get_modes_txgain_index()' so it never
> returns -EINVAL, and 'ar9561_hw_get_modes_txgain_index()' never returns
> negative value too, an extra check in 'ar9003_hw_process_ini()' may be
> dropped.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

e6a1107bf5eb wifi: ath9k: simplify ar9003_hw_process_ini()
352281e4a0a0 wifi: ath9k: use u32 for txgain indexes

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230823182401.196270-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

