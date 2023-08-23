Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE0D785F51
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjHWSLn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjHWSLn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 14:11:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36ADCC7
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 11:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 329A865DD2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 18:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA70C433C8;
        Wed, 23 Aug 2023 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692814300;
        bh=nT7ZQ9rjHf4O6jIk1+HoHbO4AocK4v+azCB1BoCnWzo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dfnXgqyVmjSjtc8txCVK/E1IBDCIGZbOBk7d/lUQW82KQEO8lyThkoLos2bShYx8V
         xHJT3N6WXdCKehHhNjK1iOzw37sDyJPCY7Sw1gIn9pI1wXej2mbHIwvmlAkPZnxhgN
         zYfuKOBXkMJ/PJZ9+nZEkmHzn/G53X0UrSDoDxzgTyXuX7iDZK+sElLz3Cdz6DA3kl
         QQcItw5aQpSNCO7sDhqEOf7TQWxEQ49viGfot52mT7kdBlmPuu513stbxgZNUu9sSG
         qNiuCodGmvF6+KWYyBsoszZXNVE2iK3bmxp5DuSqBKIADASItKMj+Wm3s63jZE8vcY
         5IZKqzUU7DWEA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: enable 320 MHz bandwidth for 6 GHz band in
 EHT
 PHY capbility for WCN7850
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230809100124.14732-1-quic_wgong@quicinc.com>
References: <20230809100124.14732-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169281429747.1470109.16590001848593498133.kvalo@kernel.org>
Date:   Wed, 23 Aug 2023 18:11:39 +0000 (UTC)
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

> 320 MHz bandwidth is reported only for single PHY mode for WCN7850, get it
> from WMI_HOST_HW_MODE_SINGLE ath12k_wmi_caps_ext_params and report it for
> 6 GHz band.
> 
> After this patch, "iw list" show 320MHz support for WCN7850:
> EHT Iftypes: managed
>         EHT PHY Capabilities: (0xe26f090010768800):
>                 320MHz in 6GHz Supported
>         EHT bw=320 MHz, max NSS for MCS 8-9: Rx=0, Tx=0
>         EHT bw=320 MHz, max NSS for MCS 10-11: Rx=0, Tx=0
>         EHT bw=320 MHz, max NSS for MCS 12-13: Rx=0, Tx=0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

Fails to compile:

drivers/net/wireless/ath/ath12k/wmi.c: In function 'ath12k_wmi_tlv_mac_phy_caps_ext_parse':
drivers/net/wireless/ath/ath12k/wmi.c:4199:48: error: 'const struct ath12k_wmi_caps_ext_params' has no member named 'eht_cap_phy_info_5G'; did you mean 'eht_cap_phy_info_5ghz'?
 4199 |                         support_320mhz = caps->eht_cap_phy_info_5G[0] &
      |                                                ^~~~~~~~~~~~~~~~~~~
      |                                                eht_cap_phy_info_5ghz
make[7]: *** [scripts/Makefile.build:243: drivers/net/wireless/ath/ath12k/wmi.o] Error 1
make[6]: *** [scripts/Makefile.build:480: drivers/net/wireless/ath/ath12k] Error 2
make[5]: *** [scripts/Makefile.build:480: drivers/net/wireless/ath] Error 2
make[4]: *** [scripts/Makefile.build:480: drivers/net/wireless] Error 2
make[3]: *** [scripts/Makefile.build:480: drivers/net] Error 2
make[2]: *** [scripts/Makefile.build:480: drivers] Error 2
make[1]: *** [/home/kvalo/projects/atheros/ath10k/src/ath/Makefile:2032: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230809100124.14732-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

