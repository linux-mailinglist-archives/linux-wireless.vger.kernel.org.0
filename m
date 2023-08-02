Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896F776D69A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 20:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjHBSMw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 14:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjHBSMv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 14:12:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B9189
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 11:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66332619F1
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 18:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3F4C433C7;
        Wed,  2 Aug 2023 18:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690999969;
        bh=n2emxNzxjOyTOp7MY5KjFiFAF594kXP/QXHtWMKwy/s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZdthPBUQ8p6N3pKhKoY5LdzvNF56se5z201/uLC9b7S/HWApJmjC2yzsCr70RmYT/
         tIeUNxN65mec+vSU57BZXM74EDtaGJQc9g04mrZK2jTsziaXYGTalaVFky/iomkAIe
         gCi9ai6BKNg7IbrZMVnkA1CYpvtQwF7EgVEw1l9Qhgtbl2z+4WmGH1FjTGVXVDh5ox
         KNibE6JfAC+DR2v4gS9jO1+3p/h473H1yusoNN0QYqsusJsbEq8S4IYWPI8MMJEA82
         qcHUWCKgDOtVbGDFGtrBZhRGCnAqMgwVCKyz1Ie++bczOo6OCKgm1tpz8SXC2GzB4n
         NwvdtQHeMb50g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: Update tree entry for rtl8180
References: <20230801170052.6432-1-Larry.Finger@lwfinger.net>
        <20230801170052.6432-3-Larry.Finger@lwfinger.net>
Date:   Wed, 02 Aug 2023 21:12:47 +0300
In-Reply-To: <20230801170052.6432-3-Larry.Finger@lwfinger.net> (Larry Finger's
        message of "Tue, 1 Aug 2023 12:00:52 -0500")
Message-ID: <878ratuxcw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> This entry is obsolete. Update to current location.
>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 432818a1f9ad..9b5f24070fd7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18519,7 +18519,7 @@ RTL8180 WIRELESS DRIVER
>  L:	linux-wireless@vger.kernel.org
>  S:	Orphan
>  W:	https://wireless.wiki.kernel.org/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
>  F:	drivers/net/wireless/realtek/rtl818x/rtl8180/

Same here, better to remove the git tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
