Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E3F765975
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 19:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjG0RDe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 13:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjG0RD1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 13:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A46D30CF
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9458561EEC
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 17:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DCDC433C7;
        Thu, 27 Jul 2023 17:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690477405;
        bh=ulOPHPt2ESLg3S9AYD+Q3mhjU2BjGUrZpgQLshsMjCE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YaIf8QtxGqZmrVop9laBq3zt1zyEX5GQ4YCfJK+1aGGtdk3n4ZbIeeSTwCa8sJAIB
         U79y3GPogTyN6PSCj583dtQtj5IzTBQSkOp1rIwNiKGslzVReC2fS8AbPUxraAi/+F
         zaEDUqXx8gP5SnhXoDInThqfiWjLPo2ZITFANtSKFo4oKZGkcn6NRN/JN5J3B4etZS
         xxrhT2fDX5rWQVuKo8BDMXOaaT6LVt+81fT1oiGmKx8SO080dJFrpnI/u4xw3oSCnc
         PyY3StptAPSyJlHogEl2eGcUabEu+HNdX5jcfFz1FQg6FqSYLCoUFveT2+ycASTS7n
         FOv4XgTtILpRg==
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
Message-ID: <169047740218.3806341.10132470501256281430.kvalo@kernel.org>
Date:   Thu, 27 Jul 2023 17:03:23 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

This added a new warning:

drivers/net/wireless/ath/ath12k/mac.c:6762: networking block comments don't use an empty /* line, use /* Comment...

Please remember to run ath12k-check. I fixed this in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230714092555.2018-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

