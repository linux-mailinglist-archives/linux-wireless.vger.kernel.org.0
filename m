Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B35C738027
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjFUJwJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 05:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjFUJvx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 05:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD46C1BF5
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 02:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75BFA614C7
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 09:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB4BC433C0;
        Wed, 21 Jun 2023 09:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687341089;
        bh=he2zCCcZEu66zXPFYtyv0DbtMBtHlTW/QLUPaB9nj5s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XWU1KDKqPNfPVvf1sqKsNWwThTvzpyJ7B8xNZdbZ/i8fwNXOiTbgcBYEkV67itGCx
         nnD3DyFOvISaI+IRi3DFjGoGEASE1xWnwz6dgWpsZuOjfNcSPPfHbJfjQe+hTVvDli
         IydzJ3UkyyrCKGFHBg4FSgHp2fukj5L0Zqwb/mgJ5b96y5OgIlpblG3fyUM71xhPAc
         +GuYutQCddNfi1fArN62/4DNOlwLLZa8t8bz7jQORz/H1TGTSFHSSIJSgF3lpnczUG
         0poAcs07czmZhVnj/fQxDD5Wg59Oj/wW8XHCXuDtw4x7HGpP+6dPkLgbKqWfVIefNM
         fdnxQYVQu2ZCg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] MAINTAINERS: mt76: add git tree
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230614144704.505553-1-kvalo@kernel.org>
References: <20230614144704.505553-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <168734108738.549389.14962690457105154708.kvalo@kernel.org>
Date:   Wed, 21 Jun 2023 09:51:29 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> Felix has a git tree for mt76 patches, document that.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

3 patches applied to wireless-next.git, thanks.

5fdaeca73eb2 MAINTAINERS: mt76: add git tree
30e67ed6e1d7 MAINTAINERS: ath9k: add git tree
d5b9a2102075 MAINTAINERS: ath11k: add wiki and bugreport page

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230614144704.505553-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

