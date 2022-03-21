Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9A24E2493
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 11:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344287AbiCUKq7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 06:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiCUKq6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 06:46:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EC763D4
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 03:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5188B811BE
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 10:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF93C340E8;
        Mon, 21 Mar 2022 10:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647859530;
        bh=qlSsmxZgmgoVlxrDmTqHEBFYP6zE8LzIg5s79c49TmA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=A+B6mNF7/4WRvDlGMwbGcxosKKyVWZNdKI98m5WYcScq8e+O6hE2zDW8d/G9J8+id
         N92XBBYnqDupo89cwDKcRoOX0HUMr9sypt/06hXHQthmYX6dAxmnwgYOuK6b/DSbal
         deP4mqMSlSNbwoupY491RKerE3udhXMmp5FjxOBnlodLkXo8JjqitQpS0ryfLggCtb
         CbE78mO70r7OiL8LudkM3/tV1GqKFXVvlfM2FOQp7+zjp90hGzKmCNcIBruI4562jG
         KV3e8Sp9cmrI2cOggXJf7aZ8y3RpHluGHe2JQi8lEwc3Ej2pzvzbIrR1k4dLlR2nLp
         WyXzxtUqHG5Rw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Carl Huang <cjhuang@codeaurora.org>
Subject: Re: [PATCH] ath11k: acquire ab->base_lock in unassign when finding the peer by addr
References: <20220314215253.92658-1-dossche.niels@gmail.com>
Date:   Mon, 21 Mar 2022 12:45:25 +0200
In-Reply-To: <20220314215253.92658-1-dossche.niels@gmail.com> (Niels Dossche's
        message of "Mon, 14 Mar 2022 22:52:53 +0100")
Message-ID: <87zgljmvne.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Niels Dossche <dossche.niels@gmail.com> writes:

> ath11k_peer_find_by_addr states via lockdep that ab->base_lock must be
> held when calling that function in order to protect the list. All
> callers except ath11k_mac_op_unassign_vif_chanctx have that lock
> acquired when calling ath11k_peer_find_by_addr. That lock is also not
> transitively held by a path towards ath11k_mac_op_unassign_vif_chanctx.
> The solution is to acquire the lock when calling
> ath11k_peer_find_by_addr inside ath11k_mac_op_unassign_vif_chanctx.
>
> Fixes: 701e48a43e15 ("ath11k: add packet log support for QCA6390")
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> ---
>  drivers/net/wireless/ath/ath11k/mac.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 07f499d5ec92..5db2333478a2 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -7077,9 +7077,15 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
>  	WARN_ON(!arvif->is_started);
>  
>  	if (ab->hw_params.vdev_start_delay &&
> -	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR &&
> -	    ath11k_peer_find_by_addr(ab, ar->mac_addr))
> -		ath11k_peer_delete(ar, arvif->vdev_id, ar->mac_addr);
> +	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
> +		struct ath11k_peer *peer;

In the pending branch I moved the declaration to the beginning of the
function and added this to the commit log:

"I am currently working on a static analyser to detect missing locks and
this was a reported case. I manually verified the report by looking at
the code, but I do not have real hardware so this is compile tested
only."

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
