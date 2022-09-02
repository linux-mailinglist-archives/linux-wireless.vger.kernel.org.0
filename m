Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404685AAA31
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 10:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiIBIh3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 04:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbiIBIhP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 04:37:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEF6C2FAE
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 01:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCEBCB82A07
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 08:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E5DC433D6;
        Fri,  2 Sep 2022 08:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662107778;
        bh=vrXhMaFtESzSKJTp35JvUWUAOSbyvPKO30+wLmS9mIk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FRT/WAt3qS+Hw8lWZ+MqFxnjfbxnMXmY/AAcaUcDYkaSHvVF7Wk2pJ8ipfnjZjhVh
         tr0c4Q8XTcFuYp9EIVESVZTABYc67YbUaTr3ajW7W79+9qLivLlttrg9K26dneyCBc
         ouL9fwO8wNC5+fRf9p9Z+sElNEhtDVkjQTIRgGB4O2p466KDd9XhGOH5eN51ATd8VP
         GWnsukBwVcwalo0Q3dsJ5s7l1Jvl1kujGP+BISXhqbxCnljoELbJrUwyCUuUT+0Zuy
         pAtNkXgo0dn+nhtCfbbEhxfHeviNv1/f5Z4oNga1kO2DI8dFtrjUjxjMVnLmko05e2
         qsP0lj7sdlaVQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/5] wifi: rtw89: add retry to change power_mode state
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220819064811.37700-2-pkshih@realtek.com>
References: <20220819064811.37700-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <leo.li@realtek.com>, <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166210777544.24345.4788231399815899200.kvalo@kernel.org>
Date:   Fri,  2 Sep 2022 08:36:17 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> When starting to send heavy traffic in low power mode,
> driver will call multiple tx wake notify to wake firmware
> within a short time. In this situation, firmware may miss
> power mode change request from driver and leads to status
> error. So we change driver to call power_mode_change at most
> three times to make sure firmware could get the request.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

48c0e34755a1 wifi: rtw89: add retry to change power_mode state
704052f55ffe wifi: rtw89: 8852c: set TBTT shift configuration
8f308ae3342c wifi: rtw89: pci: fix PCI PHY auto adaption by using software restore
843059d8193c wifi: rtw89: pci: enable CLK_REQ, ASPM, L1 and L1ss for 8852c
9e3d242fd3b4 wifi: rtw89: pci: correct suspend/resume setting for variant chips

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220819064811.37700-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

