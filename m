Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648CC4DAA7C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 07:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344005AbiCPGOm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 02:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbiCPGOk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 02:14:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCCA29C8F
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 23:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC17FB819DE
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 06:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6DCC340E9;
        Wed, 16 Mar 2022 06:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647411201;
        bh=/gEn69FCXVyKJWnF/AyvAgLAHPy0NbgHxDfUNtsFnIQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=m5V+cOhV24K7n6z9Uby3kV4XgKuEC0JAkijn0tWdLK6Whpiy7P44RUhixsl41yxxi
         +wzoR9htC/YqjmIPy/Svons+dX5hlAMkIWjfJ52Qsk9IOO7GLC/biV6IkoLYXm09GY
         Bq5rtsHmX6IJXRxFRtE5xlBJs00jwRsmUkbrZhO0+CvF7dR5mLb8+h1MRYY0mXbdBo
         hShrCmMMQIv9DdEwbYS1VdveGqcJRtfJeb7BoHZkGE93UOCt+ek7HRINell3bY5gAP
         uV7rHWarck4O67wFKRAmWiGyZvAbhdsf6XB9ZXikUBSaveBKUC0aLkMmIuVaqrPyV4
         KIPCQQOhuJAUQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Carl Huang <cjhuang@codeaurora.org>
Subject: Re: [PATCH] ath11k: acquire ab->base_lock in unassign when finding the peer by addr
References: <20220314215253.92658-1-dossche.niels@gmail.com>
Date:   Wed, 16 Mar 2022 08:13:16 +0200
In-Reply-To: <20220314215253.92658-1-dossche.niels@gmail.com> (Niels Dossche's
        message of "Mon, 14 Mar 2022 22:52:53 +0100")
Message-ID: <87o826pgqr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On what hardware and firmware version did you test this?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
