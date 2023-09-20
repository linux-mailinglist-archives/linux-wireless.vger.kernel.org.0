Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0FC7A8398
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjITNjY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 09:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjITNjX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 09:39:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDF9B9
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 06:39:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0C8C433C8;
        Wed, 20 Sep 2023 13:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695217157;
        bh=M6RshhLbzetmH2nFUPQwMg7KWrCKQHdVfZRtDrFUBls=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WsO99o8RA9Ht0g10U0Axlr1P1a9/idNH2bFt1j6UV3rP08ehvcNqaJqbBZYDVntEv
         sVZ0//QN5mW4nuK8M2X3yiYOOi2P+I0+BoEh/Uu9TCkht5ZQOHlNJl2s8hh9AnW0n6
         XAAgPRBsUs6T66m7iFjndk7qT48eFd4Cz2qkIm6M0oGkVYhUOlTglfLQ5hqt2OnbD3
         ZaOxmcPG2CLMf88NfyMZDsbS8A5I0DJVs25ZPTIkn2kynBb07NmQfrtJ2oYQDc4qPh
         A8wgZyYws2eg3YWVTQYH7t+KH8cKFT++mu2jAzPaLp5/ynzzWepwe74bQEEfDYyhU4
         L3qXUfeuk3aMA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: add chip id board name while searching
 board-2.bin for WCN6855
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230830060226.18664-1-quic_wgong@quicinc.com>
References: <20230830060226.18664-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169521715461.1118199.17273674544092350994.kvalo@kernel.org>
Date:   Wed, 20 Sep 2023 13:39:16 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Sometimes board-2.bin does not have the board data which matched the
> parameters such as bus type, vendor, device, subsystem-vendor,
> subsystem-device, qmi-chip-id and qmi-board-id, then wlan will load fail.
> 
> Hence add another type which only matches the bus type and qmi-chip-id,
> then the ratio of missing board data reduced.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1133af5aea58 wifi: ath11k: add chip id board name while searching board-2.bin for WCN6855

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230830060226.18664-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

