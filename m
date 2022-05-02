Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A0D51711E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385464AbiEBOEZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 10:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385484AbiEBOEC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 10:04:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6091E3882
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 07:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68AAF60BFA
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 14:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A22C385A4;
        Mon,  2 May 2022 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651500031;
        bh=Kdi+0fTwzL/PkfV5aJDO2b+5i3BnraJliQJBvXkWYT8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=n6Nn4aJP7+ktUx/3/V6gu+foCSSGxQSXt/2SnyM55J87BtGX++l5P1689QHMc3Spg
         DcK1RXXyGsGtl9D6JiV62U4Pp8O1E3Uy0wpFhHEZdRnV1z/V011si5KCNgh3lY3j7n
         2TngyGN9dPVI2CtuhTR12MmyAucjvGpDjWGqwBrGVxKf0fWcLF/5NDNQPj5qvleC3/
         6+JbwR5+a8kEsCZE3PaGh7qi9ZW0MedYXIrnJjKoPgo9sfzjPCqlmZyw3tYK48IRw0
         wjCfEOJmfxpnEcL9qvohaoOSpWQMeB0H0da2KCI8mDYfZ43nutaVPY4+worIgfbAJw
         j08N4Cz4F4UxQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-next 2/3] wifi: ath10k: remove a copy of the
 NAPI_POLL_WEIGHT define
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220429174643.196994-3-kuba@kernel.org>
References: <20220429174643.196994-3-kuba@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        ath10k@lists.infradead.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165150002658.16977.2818999103130463906.kvalo@kernel.org>
Date:   Mon,  2 May 2022 14:00:30 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> wrote:

> Defining local versions of NAPI_POLL_WEIGHT with the same
> values in the drivers just makes refactoring harder.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

52bcfd1b239b ath10k: remove a copy of the NAPI_POLL_WEIGHT define
3b3299a1080e wil6210: use NAPI_POLL_WEIGHT for napi budget

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220429174643.196994-3-kuba@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

