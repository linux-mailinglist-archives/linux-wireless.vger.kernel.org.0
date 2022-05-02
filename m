Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2E7517117
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 15:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385451AbiEBODC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 10:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385436AbiEBODB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 10:03:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDE012775;
        Mon,  2 May 2022 06:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83E9CB81147;
        Mon,  2 May 2022 13:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85F8C385AC;
        Mon,  2 May 2022 13:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651499970;
        bh=rkki7fnxVJwM629ZKQOfs9gIhaGKzLdyqKlPakAN4hM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=T+BOSzFlGc7iDXXXBtehvAu37zdckd4dI18jZULA+9M2pTdwj5WEJTkd2+Rm/Vayb
         DCbvssOTw4h9PoJf9c4AM/Lblnf3Y1LGkTRAwjWRRhG+owhl3PHr64jKHc4UBd+lL6
         KHr8QtjrWN16Mkq4a5wWAQazkjBrempjMyixCeeCnktOC8Z2co9PF1JZ5yUt1sNPR0
         IDx8rEEZao/MS8ItdrZGGp0t7xMx66vXXdpqxKskkjpYo7ZwXzRmb/w0OZ6ll0piKi
         b+GNFWWk56UG9Fna6JT6VAMoUKmtthhWhyjdSkSrE6+5QaOrBJ0ISgKGrrTR4lWn/g
         2njidFcTA+2wQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 1/9] dt: bindings: net: add bindings of WCN6750 for
 ath11k
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220429170502.20080-2-quic_mpubbise@quicinc.com>
References: <20220429170502.20080-2-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <mka@chromium.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165149996655.16977.4961291350588382970.kvalo@kernel.org>
Date:   Mon,  2 May 2022 13:59:28 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> WCN6750 is the WLAN chip on Qualcomm Snapdragon SoC SC7280;
> Though being a PCIe based solution, it is not attached to
> the APSS processor (Application Processor SubSystem), it is
> instead attached to another tiny processor called WPSS Q6
> processor (Wireless Processor SubSystem) on the SC7280 MSM,
> where the WLAN firmware runs, and it is the WLAN firmware
> running on the Q6 processor which enumerates WCN6750, as a
> result APPS processor would never know such a device being
> present in the system and would not detect the WCN6750
> hardware unless and otherwise WCN6750 is registered as a
> platform device. This is the reason behind adding WCN6750
> WLAN node in the device tree.
> 
> Add WCN6750 wireless driver support, its based on ath11k driver.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

9 patches applied to ath-next branch of ath.git, thanks.

00fd24089b81 dt: bindings: net: add bindings of WCN6750 for ath11k
92c1858e4399 ath11k: Move parameters in bus_params to hw_params
d1e1edfde035 ath11k: Add HW params for WCN6750
56c8ccf331bd ath11k: Add register access logic for WCN6750
676f8905fff9 ath11k: Fetch device information via QMI for WCN6750
73d3e71306fe ath11k: Add QMI changes for WCN6750
49890d9c93d5 ath11k: HAL changes to support WCN6750
e67ba1973917 ath11k: Datapath changes to support WCN6750
00402f49d26f ath11k: Add support for WCN6750 device

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220429170502.20080-2-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

