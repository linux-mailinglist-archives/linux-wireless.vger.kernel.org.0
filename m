Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0578552ADE
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 08:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345576AbiFUGOl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 02:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345148AbiFUGOi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 02:14:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E6D15FFE
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 23:14:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 994BFB811BE
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 06:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9805FC3411D;
        Tue, 21 Jun 2022 06:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655792075;
        bh=fATC/UrjRl0bb7PcN7rFehYcM85nnlZDViE5oVIQH1o=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Z51R2PmP4EctVnHQseLBkd1nc1jaPvE3Byf3is9eC9fcO9dTy6Dw/EQjItNINh7Bt
         C91CxzE7h8oUMgKFMQfUOr2F6rGAwtbzMtmcEowwnHxyaOMhWymcHwGM2dkVDjXY9b
         278Vv8sPcJbJpq1q9+g1Qv+oKxAyTS+BXSMPDLhx9+Xkmd+N9lU0IgMLDxiiF9le5k
         ShhPEdjpxK2t0qw9U9lGg0syGI6lzZyXJtASBZkGjM+197VFv1Y6/NPiPHsZbFqRyT
         X+R+N1w9D4Wgql6+XHBmlsVgwe8sFB+6BDzTaiIHNRggQwXjc+MeZwUFAI/cB6uWBP
         tzF1I2PDESIoA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: iwlegacy: 4965: fix potential off-by-one overflow in
 il4965_rs_fill_link_cmd()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220608171614.28891-1-aleksei.kodanev@bell-sw.com>
References: <20220608171614.28891-1-aleksei.kodanev@bell-sw.com>
To:     Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc:     linux-wireless@vger.kernel.org,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165579205706.12213.6904673480327173075.kvalo@kernel.org>
Date:   Tue, 21 Jun 2022 06:14:34 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alexey Kodanev <aleksei.kodanev@bell-sw.com> wrote:

> As a result of the execution of the inner while loop, the value
> of 'idx' can be equal to LINK_QUAL_MAX_RETRY_NUM. However, this
> is not checked after the loop and 'idx' is used to write the
> LINK_QUAL_MAX_RETRY_NUM size array 'lq_cmd->rs_table[idx]' below
> in the outer loop.
> 
> The fix is to check the new value of 'idx' inside the nested loop,
> and break both loops if index equals the size. Checking it at the
> start is now pointless, so let's remove it.
> 
> Detected using the static analysis tool - Svace.
> 
> Fixes: be663ab67077 ("iwlwifi: split the drivers for agn and legacy devices 3945/4965")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>

Patch applied to wireless-next.git, thanks.

a8eb8e6f7159 wifi: iwlegacy: 4965: fix potential off-by-one overflow in il4965_rs_fill_link_cmd()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220608171614.28891-1-aleksei.kodanev@bell-sw.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

