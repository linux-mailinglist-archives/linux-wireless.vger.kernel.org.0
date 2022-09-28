Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE205ED543
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 08:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiI1Grs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 02:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiI1GrO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 02:47:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A1B1A070;
        Tue, 27 Sep 2022 23:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80E0AB81F0F;
        Wed, 28 Sep 2022 06:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E835AC433D6;
        Wed, 28 Sep 2022 06:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664347500;
        bh=3OtZGS4Gxcz9XdgxbonrsQhm0Hknpe+IQAG8Vb8NAgg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PjgayOFOnH0Gp3WSFD9/mCFgVUoZosjgxe7OPfwfPAshzl3czK3BK+MqD5FtXhPB7
         Qm+4MJ7vFq/V213rlzbObmIVxnFWzwSF5yvOl55p1Tpx3+mQ4PLXwjhrCvCMnIXoG2
         aWExIysUMmdi8BnoKKGjcxBt9y74xnWaym6Hm9eO79t298F5KuvIQue2WfJKrnatfn
         C2KzFY1XpQs3NovWcon3BIToWjDyIbcNFr0EHI9cEWaEuEhrpOm2lW8QPrEF9T+uum
         +v8vV1NMrR7PrDlcfA2Ri4show8DdFbmg27wxufokKlnfvguGzxJEEowQV/0wlZHtO
         kBE9iYx9/6MBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] ipw2x00: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <YzIeULWc17XSIglv@work>
References: <YzIeULWc17XSIglv@work>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166434749574.25202.6652499859897924556.kvalo@kernel.org>
Date:   Wed, 28 Sep 2022 06:44:57 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/220
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-next.git, thanks.

413cda95648d ipw2x00: Replace zero-length array with DECLARE_FLEX_ARRAY() helper

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YzIeULWc17XSIglv@work/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

