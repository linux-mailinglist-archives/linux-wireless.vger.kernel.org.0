Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD0C74E779
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 08:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjGKGlE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 02:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjGKGlC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 02:41:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF09E6E
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 23:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97B7561333
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 06:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BB3C433C8;
        Tue, 11 Jul 2023 06:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689057657;
        bh=EMDQ8n6s4uVXebs8rlUmtF4sMjk0GSqW8H9dqH1D4xw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=U6w3eiqNJbpZGPDgguPFC94bPKjKwkv0p1fbs2L1cLUVhmTTMl/H2zntoK71IB9Bm
         ey14lsKP7Q5y5LZTGASj0uSuWxCLSRXHK7snbsiCo8Y+Dy46pPMhePVCF/UZX7dJFL
         mMH60fPJXnJ5tbZi42BX9/mcjOB7JYfDkCdhRyz2FGHDRXdd4IwINIXfP0nbaBeoCy
         wcNLn4lzy2GzS//ymXHlGhnkISE2Z5MyVqeKqnoVU0am5UzaexfMPSNGmsUMVNOX8l
         wcBNYcihRBOA8NB990/0k8klkPYpncJ77u+AxceGp3Fy369Dfi1jzwuqiOvGNBRIs2
         8tPX/g6/2WABw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arowa Suliman <arowa@chromium.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Arowa Suliman <arowa@google.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] wifi: ath11k: Add crash logging
References: <20230710230546.3544912-1-arowa@google.com>
Date:   Tue, 11 Jul 2023 09:40:53 +0300
In-Reply-To: <20230710230546.3544912-1-arowa@google.com> (Arowa Suliman's
        message of "Mon, 10 Jul 2023 16:04:53 -0700")
Message-ID: <87wmz77xxm.fsf@kernel.org>
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

Arowa Suliman <arowa@chromium.org> writes:

> Change crash logging from debug to informational and add warning when
> firmware crash MHI_CB_EE_RDDM happens.

Why? What's the reason why you want to change this? The commit log
should always describe that.

> Tested-on: Qualcomm WCN6855

This is not correct format:

https://wireless.wiki.kernel.org/en/users/drivers/ath11k/submittingpatches#tested-on_tag

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306141105.c1e82Q0y-lkp@intel.com/

The robot only reported problems with your patch, it didn't report the
original problem. So you should remove these two lines.

> Signed-off-by: Arowa Suliman <arowa@google.com>

From and s-o-b have different email addresses.

Also this seems to a second version of your patch so you should have
marked it as v2 and include a changelog what changed from v1.

Please read our documentation from the wiki link below how to submit
patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
