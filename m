Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5B6784236
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 15:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjHVNi4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjHVNi4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 09:38:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4BA184
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 06:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B3FB656CE
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 13:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B551C433C7;
        Tue, 22 Aug 2023 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692711533;
        bh=uexKtloXyd93gJLNAXEG+ZIKfALMNDl4g9VWYf4xG+c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=P72QGMp+69vQctJnqES44KEHQ5CG5+Ow5f6kaPYZfDHvpEX0+JxgPhErMSPcDy7Fl
         ZyTaKBxwaXN4Y+d7svNBipvbbXSbxa5asUNL74kPkJXP8StpYRYt3YkUEMCAqFlu98
         7arKQ+KSHD9HrAMr9yukb8aLgh/oudRosnhMQlQDMphodoNU4gZyK15F2hDMpNsUx/
         SEPf8OqwBc4HTV+IJMYtu4fPDj9a23WBZRSfjvpE8d2sOdU1lgdeOy4blZXyjFWHyT
         QUAT4HM6se0Pcxc3BQWs76t1A0LskkzGuTUAR0agsfrnAoHLrSZVbKlJ/G6GXM0BCt
         86yucWSznYt0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] ath9k: Remove unnecessary ternary operators
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230731124455.2039184-1-ruanjinjie@huawei.com>
References: <20230731124455.2039184-1-ruanjinjie@huawei.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     <toke@toke.dk>, <linux-wireless@vger.kernel.org>,
        <ruanjinjie@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169271153075.680890.758285038780567671.kvalo@kernel.org>
Date:   Tue, 22 Aug 2023 13:38:52 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ruan Jinjie <ruanjinjie@huawei.com> wrote:

> Ther are a little ternary operators, the true or false judgement
> of which is unnecessary in C language semantics.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b2fd72aafb13 wifi: ath9k: Remove unnecessary ternary operators

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230731124455.2039184-1-ruanjinjie@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

