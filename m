Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40D076D47C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 19:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHBRAi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 13:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHBRAh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 13:00:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89E61712
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 10:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CCAB61961
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 17:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA56EC433C7;
        Wed,  2 Aug 2023 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690995635;
        bh=4ck9yYVimHcNVcAHTcJwYDRKebArzZRF+tFOsMwiOio=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ldII4BBkkxhQxUgzmIwIGVopa4r/yq+UOohCY/RqzjS/yIDEPchrWdIcQ+XWQi2TK
         FUSuBDXTLog0q/cT1D6yymh5pI6WpcMeRHiAh63V2t42Ta6XOuex49Yphz+kBpotlr
         WJRHu6oUlnuk/dL8yyElOEptxdJqpv3BM+rNu87tcpvswF1GnG9f8qv0bpvcOAs7H4
         4lwDN4AeHvQ9iAUrfqIDVfRuqho1zazs8T+BYBI1T33rRitERChP8ohMkokEnth3Lu
         3731hgVPE5/2sLwjG2Oq3I1VrxwAaqiiod6/kc1o54XbIvPfCvEVm3hFQrHE0YUOXp
         UviLh8X9jmlpg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: trigger station disconnect on hardware
 restart
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230714092555.2018-1-quic_wgong@quicinc.com>
References: <20230714092555.2018-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169099563293.463701.1018312535527006346.kvalo@kernel.org>
Date:   Wed,  2 Aug 2023 17:00:34 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Currently after the hardware restart triggered from the driver, the
> station interface connection remains intact, since a disconnect
> trigger is not sent to userspace. This can lead to a problem in
> targets where the wifi mac sequence is added by the firmware.
> 
> After the target restart, its wifi mac sequence number gets reset to
> zero. Hence AP to which our device is connected will receive frames
> with a wifi mac sequence number jump to the past, thereby resulting
> in the AP dropping all these frames, until the frame arrives with a
> wifi mac sequence number which AP was expecting.
> 
> To avoid such frame drops, its better to trigger a station disconnect
> upon target hardware restart which can be done with API
> ieee80211_reconfig_disconnect exposed to mac80211.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

68c35cc39b41 wifi: ath12k: trigger station disconnect on hardware restart

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230714092555.2018-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

