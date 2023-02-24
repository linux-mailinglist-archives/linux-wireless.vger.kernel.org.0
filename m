Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2BD6A1DD4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 15:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBXOyd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 09:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBXOyc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 09:54:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22481F746
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 06:54:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A797618EA
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 14:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F153C433A0;
        Fri, 24 Feb 2023 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677250470;
        bh=1kMgqLhHUiXtC2VnyR4OdoH2n+IV/DAzN4ozBkQZ1+I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CSk9nonCNQniRawxp0DZRNdOL4wJwqCVksw889+OP+ueoYNFjvw051TSe+8nZ9sZ3
         UmL7XFo0y0onve6ZzbjWP2DyqjyFkmWV1o5HICIMvqKtUxXsa+GZihaCuagsUllQDq
         cg2zos78w+rs/o3s+UL2xumlRUQIptZMObq7yQjguXs8lhPBPsNjg5ORMI0UPEHojx
         dGAS8EkVErnv2dGi5IBgJ5D9Th8ruzbxqAOykqnG/Qg08fUZVLQWgDFKuJg00mV977
         tHTvfuPcJzwkhYtXoPvpjgvhanDRndpEO6uzwntWir5xzVXn1ckIls4oI3MItOqNoD
         Pab/kMBEhRMcA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Enable low power mode when WLAN is not active
References: <20230203060128.19625-1-quic_mpubbise@quicinc.com>
Date:   Fri, 24 Feb 2023 16:54:26 +0200
In-Reply-To: <20230203060128.19625-1-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Fri, 3 Feb 2023 11:31:25 +0530")
Message-ID: <878rgnru59.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Currently, WLAN chip is powered once during driver probe and is kept
> ON (powered) always even when WLAN is not active; keeping the chip
> powered ON all the time will consume extra power which is not
> desirable for battery operated devices. Same is the case with non-WoW
> suspend, chip will not be put into low power mode when the system is
> suspended resulting in higher battery drain.
>
> Send QMI MODE OFF command to firmware during WiFi OFF to put device
> into low power mode.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
>
> Manikanta Pubbisetty (3):
>   ath11k: Fix double free issue during SRNG deinit
>   ath11k: Move hardware initialization logic to start()
>   ath11k: Enable low power mode when WLAN is not active

Please add "wifi:" to all patches.

And please add "wifi: ath11k:" to the cover letter.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
