Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EC74B089F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 09:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbiBJIlY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 03:41:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbiBJIlX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 03:41:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8A4F38
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 00:41:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2713B82299
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C5BC004E1;
        Thu, 10 Feb 2022 08:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644482480;
        bh=V0XuQcbFDT35HY8ptC9DGA/vUGKY53juZPgn+KgIufg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=D7YPrrBwTuuFD/0I2igHOraDiniE3D8osDezu7bVvalC2Jp+GeHwUTzyZjXnRmOux
         XsoW83XT0ZQlX8irUURN/w+w9BguUPeBiAvXpDPamGwgJVHcjWjLcsgx1w/QNHbYOF
         jI//RLFwksMBpgafMejUNQ2rBZw9Wzj3t/eMfHgASHJrslmSKKL04HD9DA0cT9ESMG
         /w9Yk4eF9S2CcUX3ISykYXcT7bYFT7QL34O/U26+5g+/x3ENwmG0I9l/UksJUNrJ6U
         /QQ+4kqqNjGmoHWS0oWKLmoVhaVI+rHM79fvJyamIG3xKfDky5HtcxzrA/CLGs67z2
         /gh6Oq7yB3ybQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] rtw89: extend role_maintain to support AP mode
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220207063900.43643-2-pkshih@realtek.com>
References: <20220207063900.43643-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164448247582.15541.17147486771846491607.kvalo@kernel.org>
Date:   Thu, 10 Feb 2022 08:41:19 +0000 (UTC)
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

> Fill mac_id and self_role depends on the operation mode.
> 
> In AP mode, echo connected station has an unique mac_id, and each vif also
> has one mac_id to represent itself.
> 
> The self_role is assigned to vif if the operation mode is decided, and
> RTW89_SELF_ROLE_AP_CLIENT is assigned to the connected STA in AP mode,
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

ff66964a9467 rtw89: extend role_maintain to support AP mode
2ab856cc3a6c rtw89: add addr_cam field to sta to support AP mode
fd7ee4c8ac14 rtw89: only STA mode change vif_type mapping dynamically
1b73e77db1d0 rtw89: maintain assoc/disassoc STA states of firmware and hardware
a52e4f2ce0f5 rtw89: implement ieee80211_ops::start_ap and stop_ap
d95d8d6bba72 rtw89: debug: add stations entry to show ID assignment
b478ff6bcb2d rtw89: declare AP mode support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220207063900.43643-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

