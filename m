Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFE4577C99
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jul 2022 09:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiGRHb4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jul 2022 03:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiGRHbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jul 2022 03:31:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6E1834B
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 00:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B081061354
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 07:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABD2C341CD;
        Mon, 18 Jul 2022 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658129510;
        bh=g8HAlHQeDhXpBJg4ov/0sp2aRCVUjeBdLioC9+VWIGI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tLFu3ymiJ9zL/GML01HMxRJYqOS8Pz98comtGav+S9YADg0X06YVGBpmoHr8TcCmZ
         ltyLuJhEFaow+6yTDQrgSO5uQXg3kUhTzkb1oB6MMwxHGhQiBXuqQ33iVaEnAgavP6
         0QVfb4xfVtc9CDvypuLiasCPZbi0XXnuaXBBr3tHUNsDDgKROQatxEwAECEXQbvwIn
         AzcOYBx/XC4rsPb71ngUGFsfmJP3LS1DJ/46bIWvPdh8aKQUE+UB9Jh41spwIcPpSf
         0mVbjPIXuuPxvxsAYgR/kUq6amuXaYPaMI5LEdjcq4TA8KMnNTMftlS9XsBX2Fj1l+
         Ou34IHBRbZH/Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Maxime Bizon" <mbizon@freebox.fr>
Subject: Re: [PATCH] ath11k: Fix register write failure on QCN9074
In-Reply-To: <fc902e10-9d99-d272-84bf-87450678982a@quicinc.com> (Manikanta
        Pubbisetty's message of "Fri, 15 Jul 2022 15:40:41 +0530")
References: <20220608062954.27792-1-quic_mpubbise@quicinc.com>
        <87wncesne8.fsf@kernel.org>
        <fc902e10-9d99-d272-84bf-87450678982a@quicinc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 18 Jul 2022 10:31:46 +0300
Message-ID: <87r12iswpp.fsf@kernel.org>
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

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

>> I refactored ath11k_pci_get_window_start() a bit, please check my
>> changes here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=95094045d7f467aa8928307ea538d1fd9d15a239
>>
>
> Refactored code looks okay to me. Just one comment though, you may
> probably remove initialization of "u32 window_start =
> ATH11K_PCI_WINDOW_START;" in ath11k_pci_window_read32? It is removed
> in ath11k_pci_window_write32.

Good point, removed that now:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=70fbceb8841910a2af9a392a6b1f4eb53c3a6716

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
