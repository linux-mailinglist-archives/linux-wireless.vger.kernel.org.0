Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BA950D17F
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Apr 2022 13:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbiDXLeR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Apr 2022 07:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiDXLeN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Apr 2022 07:34:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1865C4DF54
        for <linux-wireless@vger.kernel.org>; Sun, 24 Apr 2022 04:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09763B80DD7
        for <linux-wireless@vger.kernel.org>; Sun, 24 Apr 2022 11:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B91CC385A7;
        Sun, 24 Apr 2022 11:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650799869;
        bh=QdhsHLvch1FYOVY6aiz/d1ryaf2amGul9PKXu9pvhxk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eAV7+lQEOKFRKDTe24zFck0cHJvCMwrHpQvrC2Yoq/GNb2CDqosoNXuNo0fFvTEmC
         NzsN+24fYXSxV6+w3VEnXwx1nWtunUq1xEykXasPlOvfEnnX9tE/kRxyNtgOo5ovIW
         Ax97aZuadztrZlujmhaijnJxs9ssZArEsooe8nJb9rqp0ewDV0T0hVMtqjAJS6vOtM
         gQiAyptiLLFKjkYpw6FPULSlCGx2prhXoSPwBpjYjTf7SVGWyhTrpZQ6N8YKharO5r
         llYRNDN4XuM0oaTQg139mprVSa6aNMUECea900xVXnuUAhMtsuO/0kDkyHuJjIZU1g
         ZOEr5tc5lb9vw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/14] rtw89: pci: add variant IMR/ISR and configure
 functions
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220421120903.73715-2-pkshih@realtek.com>
References: <20220421120903.73715-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165079986600.25321.3742178852141815562.kvalo@kernel.org>
Date:   Sun, 24 Apr 2022 11:31:08 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> 8852CE uses different but similar IMR/ISR registers, and its masks are also
> different in various states, so add config_intr_mask ops to configure masks
> according to under_recovery or low_power states.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

14 patches applied to wireless-next.git, thanks.

948e521c7285 rtw89: pci: add variant IMR/ISR and configure functions
e1757e804501 rtw89: pci: add variant RPWM/CPWM to enter low power mode
837202684657 rtw89: pci: reclaim TX BD only if it really need
c83dcd0508e2 rtw89: pci: add a separate interrupt handler for low power mode
98816def1973 rtw89: ser: re-enable interrupt in threadfn if under_recovery
52edbb9fb78a rtw89: ps: access TX/RX rings via another registers in low power mode
d7259cdbd055 rtw89: pci: allow to process RPP prior to TX BD
fc5f311fce74 rtw89: don't flush hci queues and send h2c if power is off
16b44ed0ffd3 rtw89: add RF H2C to notify firmware
cd89a47105dc rtw89: 8852c: configure default BB TX/RX path
af0cac159b1c rtw89: 8852c: implement chip_ops related to TX power
3ecca403d9bf rtw89: 8852c: implement chip_ops::get_thermal
f4ae7ccc2bbf rtw89: 8852c: fill freq and band of RX status by PPDU report
2fb822f82a59 rtw89: 8852c: add chip_ops related to BTC

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220421120903.73715-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

