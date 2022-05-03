Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113AB517CD5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 May 2022 07:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiECFgB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 May 2022 01:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiECFf7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 May 2022 01:35:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61E86383
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 22:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E3BD6154E
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 05:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14246C385A9;
        Tue,  3 May 2022 05:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651555947;
        bh=V4fsb/Y32PF6lSgD08L06lHAZnmFRx1QqQuwOHirZ2w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Xu2Frw8ynt/gn4In1RxGcYvqizHYDpDQL3Ey5brVIN+kOuCtoH6YOuhatIp3njmJd
         fcAgrYSOCWGDIdmcwxM2FKvsmRS9VPDPxYUpYouVdeOrm7NBO+aX5RmAruC7dT1iVg
         KNz4dJGOozVCf/72xqA0I2WoqTmDGnJrclktt8sI9ZBMiqmwBIi44a/u43AmmbjPkF
         uVyLc4SHLrosOGWBl0elD3/3RuFze5wEP9h6J4HOGArinW2ao50sMAFe+qR+jxC+wV
         47T6sTa0hM2v/muwbCGSv2QjBgPC6tlBksCrxLZJ+9+gBqH+DlYkiwo6TRf7mt55fg
         85ckShb9eG66Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/8] rtw89: 8852c: rfk: add RFK tables
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220502235408.15052-2-pkshih@realtek.com>
References: <20220502235408.15052-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165155594485.23375.12221972503203207176.kvalo@kernel.org>
Date:   Tue,  3 May 2022 05:32:26 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> These tables are used by RFK (RF calibration) to set parameters. These
> parameters can trigger certain calibration, or configure/reset settings
> before and after RF calibrations.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

ec424639d41b rtw89: 8852c: rfk: add RFK tables
76599a8d0b7d rtw89: 8852c: rfk: add DACK
fb8177d729f2 rtw89: 8852c: rfk: add LCK
e5efc4d55c20 rtw89: 8852c: rfk: add TSSI
30052c5a1c99 rtw89: 8852c: rfk: add RCK
ac91be975616 rtw89: 8852c: rfk: add RX DCK
2da8109d9885 rtw89: 8852c: rfk: add IQK
da4cea16cb13 rtw89: 8852c: rfk: add DPK

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220502235408.15052-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

