Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1747310CD
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 09:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245010AbjFOHdp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 03:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244856AbjFOHdT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 03:33:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE81BD4
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 00:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BF1563274
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 07:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58719C433C0;
        Thu, 15 Jun 2023 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686814379;
        bh=+54sRTulTDcQyrmLFvPzrEc5jKHyclMpBX1rU9atwg4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BnpG3PLRW5SNuX8lAhh+1OUFs53WuXGEUDzfNOqFEucl4BQWETByWPyVimz8Dgi9w
         awG0sOVyeCnWfi0OQIaNWjXHd8gsT/peNj0H1oWyTPR3QHchGE9HST8l7BT882TqMn
         UGLdHhjrZdv8GlXR1GXaY2b1vm2tHpvECajfS9dohxXj0wzhSNZAwoQOE6ZMXf4zCP
         FPCAQL8reL0cKD+xKILo9dfVcR0yxL/QbjKevQ2EL9naam4RhRSUWQNRnCJUQ+9Cnj
         aFbVtHfn0E4KpHXe7jXq1xKO6RNwtfNjq4+PnNVO2ZAvXlHQeP5AVspT36qMw7nknO
         bGmoH3uRaKlkw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: brcmfmac: handle possible WOWL configuration
 error
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230607161611.85106-1-dmantipov@yandex.ru>
References: <20230607161611.85106-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168681437386.8111.5132863492672751351.kvalo@kernel.org>
Date:   Thu, 15 Jun 2023 07:32:58 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Convert 'brcmf_configure_wowl()' to return 's32' which may be
> an error raised by 'brcmf_fil_iovar_data_set()', pass the
> value to 'brcmf_cfg80211_suspend()' and adjust related code.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Using s32 for an error value is strange for me, usually we use int.

This patchset feels like random cleanup which makes me wary. How are these 3
patches tested? 

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230607161611.85106-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

