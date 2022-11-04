Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072156194FA
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Nov 2022 12:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiKDLAO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Nov 2022 07:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiKDLAL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Nov 2022 07:00:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4622C12A
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 04:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F1674CE2B97
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 11:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA40C433D7;
        Fri,  4 Nov 2022 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667559599;
        bh=OCzrjcJ5SpGF1a1EOZ7wMu5OKuYntYJoowPIU/RMdq8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=p/UwPtyP+fC2vAhucDGz7smP2zCQUDeblsBRwYH3EVmVakqG91InUpaCYyhZexc4e
         cRSjYpwHQnG1fgZo0yUrB1kH6Rgf9i4lxaA8fuc1N16p+XSnAErSGTiE/0kDHPaiZM
         0P/H22t4xzG1FfXXawp+5gbGf++bbvpGH1qBo14WnJt7wOUbBXvu3WIGoUhlKhc4LR
         Phi8Ebd24sKFnyhmJ2gne1VAxU6CIrtp287E4Do6RBOig7Xrv4wLOt44ucwAnAN/1z
         5airC9KkxBLfdGjnb2HZVq3BlmP/lqiCI7XmLG/WZ5JLJ2d9AXLT0UBnrvR3TQrkWY
         rSZToJIlNAhSw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bcma: Fail probe if GPIO subdriver fails
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221028093000.239020-1-linus.walleij@linaro.org>
References: <20221028093000.239020-1-linus.walleij@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166755959644.3283.4423066704295737181.kvalo@kernel.org>
Date:   Fri,  4 Nov 2022 10:59:58 +0000 (UTC)
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> wrote:

> We currently register the BCMA core even if the GPIO portions
> fail. There is no reason for this: the GPIO should register
> just fine, if it fails the BCMA driver should fail.
> 
> We already gracefully handle the case where the GPIO driver is
> not compiled in.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied to wireless-next.git, thanks.

74a473007ce5 bcma: Fail probe if GPIO subdriver fails

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221028093000.239020-1-linus.walleij@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

