Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB747D68F8
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 12:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbjJYKj0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 06:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbjJYKjP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 06:39:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7304330C6
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 03:36:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB672C433C9;
        Wed, 25 Oct 2023 10:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698230216;
        bh=7Rl8C1Uk+dHF25r0wiSnC9dy7aLIzE0A9eteM9RTuhE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=t/LRDwuWt0ezmpb2wvHnc5DDZMgIQnEDcDTVNVdrkiy6kOp7SuZEjOP57Qkl6rv6E
         TjqijEbsR1lNpoyT+puU7pPXDFON4zEa/Myq3E8L0CCKxV7v13syy6lZqdk6wUy4iv
         0RH0chClhab/vd4KPTnXDE3mi1v482d4duuaeGrrOSnoeC5ndSqLF//dhvu1kUX+I+
         iT/hM/f2Amg4ARaEF7fHQ81MUkMae+I2EHRsQGz9iQjgAMogdS25gW9cq76xx/k94e
         Jt1f5Vg1NL89WTtutCU5hLSCfnunomCnNLrgJxxFQQbvYBotjYTdAHwsXkLXhawS+2
         j+EPTbHrt7WBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Revert "wifi: ath11k: call ath11k_mac_fils_discovery()
 without condition"
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231023164120.651151-1-kvalo@kernel.org>
References: <20231023164120.651151-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169823021370.891844.8029663919365856343.kvalo@kernel.org>
Date:   Wed, 25 Oct 2023 10:36:55 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> This reverts commit e149353e6562f3e3246f75dfc4cca6a0cc5b4efc. The commit caused
> QCA6390 hw2.0 firmware WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1 to crash
> during disconnect:
> 
> [71990.787525] ath11k_pci 0000:72:00.0: firmware crashed: MHI_CB_EE_RDDM
> 
> Closes: https://lore.kernel.org/all/87edhu3550.fsf@kernel.org/
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f59065401602 Revert "wifi: ath11k: call ath11k_mac_fils_discovery() without condition"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231023164120.651151-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

