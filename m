Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA685A427B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 07:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiH2Fob (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 01:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2Fo3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 01:44:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3F546D9D;
        Sun, 28 Aug 2022 22:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1A036102D;
        Mon, 29 Aug 2022 05:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73919C433C1;
        Mon, 29 Aug 2022 05:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661751866;
        bh=eMFwRL1X5gaSXzg8P/8guBiK06GEhxZZRq4kWRJ6818=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kYqOaQOzKmbNNxs1C1nr+5/MxUnIIKIfxJv02W35Vjl1dvEEw9dJ1e+Ypq7MzOwl1
         N4dIspThogbIDT7O3rlvkhBkVaP0Tn5et3n2tt8tAa+sVD1SIi0jh1jP9XAkVy6KJw
         drwWPQg7EMZb0U21PdgpZkoPZywEln/xoyZS/vEGS6FMeOofjwt5QmfsVmvmhvky0X
         CnW9MkiKBcbPFvtHt+HgwaxzumV3T2aL9sCTBPFQ8UXduk1rviVKuDkAxUMTwC52cn
         8TjiGEGplhSTsBxcNdsrkP+q3rTWB8M1ZCaH3b7hMvCSvBTSVRd6fN1Yx/uGQhD/He
         LuRyyEz06kIFA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Sasha Levin <sashal@kernel.org>, linux-wireless@vger.kernel.org,
        stable-commits@vger.kernel.org, aleksei.kodanev@bell-sw.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.0] wifi: iwlegacy: 4965: corrected fix for potential off-by-one overflow in il4965_rs_fill_link_cmd()
References: <20220813203952.1914688-1-sashal@kernel.org>
        <20220814075703.GA847900@wp.pl> <YvkRBQYLQI2QrnBn@sashalap>
        <20220815073737.GA999388@wp.pl>
Date:   Mon, 29 Aug 2022 08:44:15 +0300
In-Reply-To: <20220815073737.GA999388@wp.pl> (Stanislaw Gruszka's message of
        "Mon, 15 Aug 2022 09:37:37 +0200")
Message-ID: <871qszhads.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <stf_xl@wp.pl> writes:

> This reverts commit a8eb8e6f7159c7c20c0ddac428bde3d110890aa7 as
> it can cause invalid link quality command sent to the firmware
> and address the off-by-one issue by fixing condition of while loop.
>
> Cc: stable@vger.kernel.org
> Fixes: a8eb8e6f7159 ("wifi: iwlegacy: 4965: fix potential off-by-one overflow in il4965_rs_fill_link_cmd()")
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

Thanks, I'll queue this for v6.0.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
