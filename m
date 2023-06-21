Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BA5738190
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjFUJvq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 05:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjFUJvO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 05:51:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A74D2135
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 02:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26EC5614D7
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 09:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D0FC433C9;
        Wed, 21 Jun 2023 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687341006;
        bh=GsAq+y5tCvFZTechrPjoClrPvVVMBESr1hPugT4GwHU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=r5wPzCcFtVUSZIncOx8zB4f4IIDRc4T0W1PO3KsL6f2aE6+sKu4o+cUYgzMb6RoMv
         Wr0cU3fWkQ9kLcGTlc1fsv3YmHPtIbOgY4erciENyMRnVnpP045416CuMZhau13RIk
         kQ9cjrfsBDKZuegXE59QP9FgognRkmBtP6KGgnBRqTGP/a4huBnryLcyf0+GGs5oCG
         Opm2eMObx33RNXrhZ0K576O8O4T73SLyuk89cMPC282CAWbYjMbgG+nbbYmGXk5ug7
         /Xy3uECzM6rc+3QiNCRNnMdGnAWxjxPC+qAMTIx9Au5E7XaBzNC9OditD0mM/Y4HyJ
         DUNZKqs9eV8MA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: TX power stuffs replace confusing naming of
 _max
 with _num
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230616060523.28396-1-pkshih@realtek.com>
References: <20230616060523.28396-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <168734099989.549389.6098439772933270478.kvalo@kernel.org>
Date:   Wed, 21 Jun 2023 09:50:05 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Some old declarations about TX power stuffs were named with confusing
> `_max`. But, they mean "the number of". So we change them to be named
> with `_num`.
> 
> (No logic is changed.)
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

b4a283fb6227 wifi: rtw89: TX power stuffs replace confusing naming of _max with _num

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230616060523.28396-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

