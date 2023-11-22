Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34BE7F4F57
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 19:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjKVSW6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 13:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKVSW4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 13:22:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C2D101
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 10:22:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17796C433C8;
        Wed, 22 Nov 2023 18:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700677373;
        bh=BN7rd/tFqCbZXrOesCyWAkSFr6Mf/2JkzS1pjZzr/EI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CQgVo1J1VdjQa0NfgheujtzrBa00ttQsAMm8T2MeXE74ANXCBsS9vAJbdwSsbiFYq
         ZHXjBlZlaIQkyum9GA6jtkC0R8Q0eSSX/DwGFQyPlO6oJZgPriMcCNJiBS4yG6Geze
         uF7Vng7pn+bDHMLBsZNPWAHhO8fHwOtOGDyrE84D5/4ES2AcpvduuIECgmMz6buc+g
         bor25aDTNti3diNxO+qzyrQteX4mvYuXlVyTDOyzd4t5Ratwg1yQFl+gj86QXzjI9L
         3U15gQt1tx8v/VID+ERyMRyVW7ioUf3U+Rhq5OrbRVkyT/48uFVq7c72m5nUVTmnKD
         mZ2X0aXq9TFUg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: simplify __ath10k_htt_tx_txq_recalc()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231102115459.69791-1-dmantipov@yandex.ru>
References: <20231102115459.69791-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170067737021.158537.658295083023097640.kvalo@kernel.org>
Date:   Wed, 22 Nov 2023 18:22:51 +0000 (UTC)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'ieee80211_txq_get_depth()' allows NULL for 2nd and
> 3rd arguments, simplify '__ath10k_htt_tx_txq_recalc()' by
> dropping unused 'frame_cnt'. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

08500f6eaa91 wifi: ath10k: simplify __ath10k_htt_tx_txq_recalc()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231102115459.69791-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

