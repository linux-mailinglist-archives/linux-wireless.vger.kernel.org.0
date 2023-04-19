Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4BC6E7C84
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjDSOZm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 10:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjDSOZk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 10:25:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBA7B44F
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 07:25:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96A9763B9D
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 14:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16924C433D2;
        Wed, 19 Apr 2023 14:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914215;
        bh=1nPx7fxMdalYxaScwWE123owRTOo0GOSqgX38SXhNnE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ALTnYTaNMagQ4CQe5AwWCjPzWyipmyR73zIwQ25NhzjIpgPTbIcCMceg99ts6TryX
         u/ScZjw94jyjoK0HeR2TPAGw+p63JT2A/oftZcBUjdePgFDl098PUUxS136TaxdMQd
         uVIhJXNYzlSNQg7K9pIxiRS/r7UP2FXyk4+2gpks7V7wv8f6780CBlpFtt9Fe8veNZ
         qMK787giuUBddut2CekNnAgWtOfpWOva7ND1A0ZVptSmxOGXmTTSa/qZTNbj00+7DU
         WLLALggSswVxC5ARiCTJEv3jkWf2BUnokB3I5BFFRm2oqnieK99fwyBIpIfDVas/qU
         S+zNJGq/sbbxw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V3 1/2] wifi: ath11k: fix tx status reporting in encap
 offload
 mode
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230403195738.25367-2-quic_pradeepc@quicinc.com>
References: <20230403195738.25367-2-quic_pradeepc@quicinc.com>
To:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168191421217.18451.4017404228995663386.kvalo@kernel.org>
Date:   Wed, 19 Apr 2023 14:23:33 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> wrote:

> ieee80211_tx_status() treats packets in 802.11 frame format and
> tries to extract sta address from packet header. When tx encap
> offload is enabled, this becomes invalid operation. Hence, switch
> to using ieee80211_tx_status_ext() after filling in station
> address for handling both 802.11 and 802.3 frames.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

6257c702264c wifi: ath11k: fix tx status reporting in encap offload mode
2f0c9ac8362d wifi: ath11k: Fix incorrect update of radiotap fields

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230403195738.25367-2-quic_pradeepc@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

