Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D09276D699
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 20:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjHBSM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 14:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjHBSM1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 14:12:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80EB1717
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 11:12:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7989F61A87
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 18:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F964C433C8;
        Wed,  2 Aug 2023 18:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690999943;
        bh=n7Q2nVitV5nLmFby6edzvadJxOcKVgcXIGzgQeo4jXc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AbNRiypnnPdL7o5IfWvI7huX8gqcl4MJG14jA7dKVz16/wnUPlRHmrPkcHKXRjCFV
         MhOwsED1VrD+7Ply/rszrW1eyP5tQiWiP6y7eFZxYRqqOM/gKSTuBTqqYO7w9TGKDO
         olBcnnL4ZTX2J4DCLfA8UGqESHo01bfOMRUQ80BzlYa9fGqukpaH8hjcudOjnCIjM8
         kHuKntEaHXb66BCgNj54jQmLtm5H+hmYnMCwe+Rgjz+s4kGOMVfIgjJIwYXshWOMTx
         EM04y0fslNZa2YeV8/MVJblU0154nmc3d6JrU0tChoNCpwnFRs4Wk3KQ6yNPflGMNu
         YcFBr9V7/lycg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: Update entry for rtl8187
References: <20230801170052.6432-1-Larry.Finger@lwfinger.net>
        <20230801170052.6432-2-Larry.Finger@lwfinger.net>
Date:   Wed, 02 Aug 2023 21:12:21 +0300
In-Reply-To: <20230801170052.6432-2-Larry.Finger@lwfinger.net> (Larry Finger's
        message of "Tue, 1 Aug 2023 12:00:51 -0500")
Message-ID: <87cz05uxdm.fsf@kernel.org>
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

> As Herton Ronaldo Krzesinski and Hin-Tak Leung are no longer active,
> remove them as maintainers for rtl8187.
>
> The git tree entry is also updated.
>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d0553ad37865..432818a1f9ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18523,13 +18523,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.g
>  F:	drivers/net/wireless/realtek/rtl818x/rtl8180/
>  
>  RTL8187 WIRELESS DRIVER
> -M:	Herton Ronaldo Krzesinski <herton@canonical.com>
> -M:	Hin-Tak Leung <htl10@users.sourceforge.net>
>  M:	Larry Finger <Larry.Finger@lwfinger.net>
>  L:	linux-wireless@vger.kernel.org
>  S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
>  W:	https://wireless.wiki.kernel.org/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
>  F:	drivers/net/wireless/realtek/rtl818x/rtl8187/

Actually it would be better to remove the git tree (T line) altogether.
get_maintainer.pl script will take take the git tree from the subsystem
entry anyway:

NETWORKING DRIVERS (WIRELESS)
M:	Kalle Valo <kvalo@kernel.org>
L:	linux-wireless@vger.kernel.org
S:	Maintained
W:	https://wireless.wiki.kernel.org/
Q:	https://patchwork.kernel.org/project/linux-wireless/list/
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
F:	Documentation/devicetree/bindings/net/wireless/
F:	drivers/net/wireless/


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
