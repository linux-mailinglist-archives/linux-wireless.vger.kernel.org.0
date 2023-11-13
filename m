Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183A97EA085
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 16:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjKMPud (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 10:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKMPuc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 10:50:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37B610FB
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 07:50:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4A5C433C8;
        Mon, 13 Nov 2023 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699890629;
        bh=1RionFtnSpOWW7o/YkL7qWHsAndOMy/fEzDSsI29GyY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=l14qTkClnv23z7dwoUV0IrByBgqhpqmRjvktjRHdbOQd5mAojRYtndqHbyEYei7h8
         s1l/2qF7LXzNvrAjLkbFY5fJpaUmtRwgPcz9MND73EfpXs+LnW9sNVXO62yZvGN/XF
         GNU9qIp7SUHwC1uYjKjv3MAzNI7iuFqeqIAe7SK30mfdgmk+6qPz7XDBISyuPi0Pfn
         8PIV/tM2oqNaEKKu3bzXFqsqGR73koq+Z4hKZd1f3zOUD+YxhQSA+UyXBw6+8odf5S
         7KNV3Ob5/ZLQ9NUcjmuZvmn/wOmrd/jwoASUbMlPIsM3/tQ+ufYQz+97oK2+D2gJ1y
         k/a7TRu/KqhHA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: add support to allow broadcast action from
 RX
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231017165306.118779-1-prestwoj@gmail.com>
References: <20231017165306.118779-1-prestwoj@gmail.com>
To:     James Prestwood <prestwoj@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        James Prestwood <prestwoj@gmail.com>,
        ath10k@lists.infradead.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169989062657.3473659.188127753057713210.kvalo@kernel.org>
Date:   Mon, 13 Nov 2023 15:50:28 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

James Prestwood <prestwoj@gmail.com> wrote:

> Advertise support for multicast frame registration and update the RX
> filter with FIF_MCAST_ACTION to allow broadcast action frames to be
> received. Broadcast action frames are needed for the Device
> Provisioning Protocol (DPP) for Presence and PKEX Exchange requests.
> 
> Signed-off-by: James Prestwood <prestwoj@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

On what hardware and firmware did you test with this? As there's so many
different combinations in ath10k we use Tested-on tag to document that.

https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#tested-on_tag

As ath10k hardware and firmware can work very differently from each other I'm
suspicious if this feature really work in all of them.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231017165306.118779-1-prestwoj@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

