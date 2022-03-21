Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752E34E2461
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 11:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346338AbiCUKde (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 06:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346327AbiCUKde (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 06:33:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6DFDCA86
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 03:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6865CB81200
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 10:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B42C340E8;
        Mon, 21 Mar 2022 10:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647858725;
        bh=7ubJutBW2/q/fizJQLmvyldAnHZkqBrN10ep4adrdIk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MfaPX2jRF7vLAj+ug9g0bq8gJNaG7IrjxPos6H+BNQHkeKNdDTKlmQ7kheTk546AD
         nMqy4xf9EswJEzsL94NwKOrn2HzYw/5nIMh5jvMRBBuK6Pf+ROtTQDqg/PYBzp7XGB
         36zQRzpbKIMu3Lh1pYsDnrhEGm1n2PRtx83G36wYi020Rn1CD5vH2d3ZBJ7iOWij7q
         EJiSWb8EV1qN3YdOfA/5l7t2BKEHjjwLlG8VpXT/ADV+Fll4ap9aScUNF5ik5NkecF
         4Tcg3uD2U6PcB04yjuur/KhRz2bjXHrODjwxdEwAoa5hyns+GFpavQrdgEGkfKcMCL
         SBshaECyDphQg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] ath11k: add handler for board-2.bin without variant and read SMBIOS
References: <20220315104721.26649-1-quic_wgong@quicinc.com>
Date:   Mon, 21 Mar 2022 12:31:58 +0200
In-Reply-To: <20220315104721.26649-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 15 Mar 2022 06:47:19 -0400")
Message-ID: <878rt3oau9.fsf@kernel.org>
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

Wen Gong <quic_wgong@quicinc.com> writes:

> v6:
>    1. rebased to ath.git ath-202203101556
>    2. add error message if could not find any board data at last.
>    3. change "ath11k: add read variant from SMBIOS for download board data" for
>       add struct ath11k_smbios_bdf, strlen(), not mix defines and function declarations.
>
> v5:
>    1. rebased to ath.git ath-202112161538
>    2. fix warning "failed to fetch board data for bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=DE_1901 from ath11k/QCA6390/hw2.0/board-2.bin"
>
> v4:
>    1. add helper function ath11k_core_create_fallback_board_name()
>    2. rebased to ath.git ath-202112071521
>
> v3:
>    1. add patch "ath11k: add fallback board name without variant while searching board-2.bin"
>    2. reabsed to latest ath.git master ath-202111221436
>
> v2: rebased to latest ath.git master ath-202111170737
>
> When it does not have matched board name with variant in board-2.bin,
> ath11k will fallback to search without variant.
>
> Also read the variant from SMBIOS.

Thanks, I now tested this patchset and looks to work perfectly now.

BTW, please add the change log here, that is after the description but
before the patch list below. In other words, the cover letter needs to
have the desription as the first thing.

> Wen Gong (2):
>   ath11k: add fallback board name without variant while searching
>     board-2.bin
>   ath11k: add read variant from SMBIOS for download board data
>
>  drivers/net/wireless/ath/ath11k/core.c | 116 +++++++++++++++++++++++--
>  drivers/net/wireless/ath/ath11k/core.h |  20 ++++-
>  drivers/net/wireless/ath/ath11k/qmi.c  |   4 +
>  3 files changed, 132 insertions(+), 8 deletions(-)
>
>
> base-commit: d845cf007bdf8b2bf41522e1ecd0eb804e553d57
> -- 
> 2.31.1

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
