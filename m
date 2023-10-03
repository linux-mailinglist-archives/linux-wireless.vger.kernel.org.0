Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851377B682A
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 13:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbjJCLmg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 07:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjJCLmf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 07:42:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16A8E
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 04:42:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6CAC433C7;
        Tue,  3 Oct 2023 11:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696333352;
        bh=Q1xOLxKyZL8kRwVEN0hcfdgtI5QC9qs7FDwpY47b/sY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=H3ySXxDaLD1n36QLf8Vb1iQ7E4vesGVh6778xmYsqrISf2MNRK2I4x4Jc2Zm+g/Bg
         YNmnY0tF0YxDsGTt8OzHMx1SczjGDbtSLl7+XsWUIaD36+JLXl08jijMPnxFbL3n9g
         hGoqsfb8CYYsVFvVkkWnEHJ90domieDgdwiy3RIGF8+UBSUO5gw0al8BnDq3KtoUEt
         d8GO9QX8IFfOChsjP1KjQn3R0sYUyJF5BV4LHXVuppzvM7bmMZuEhF8og3oUL5J7x1
         1sBTopx7ghaDUBNhNvSH6KRMFyKlPYdPGvDlq82Y9SZAeAonYbFD0S2aTFbmRrwujM
         t3Je7Nzz6I8Jg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rt2x00: fix MT7620 low RSSI issue
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <TYAP286MB031571CDB146C414A908A66DBCFEA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
References: <TYAP286MB031571CDB146C414A908A66DBCFEA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Shiji Yang <yangshiji66@outlook.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169633334878.28914.17925626923351270601.kvalo@kernel.org>
Date:   Tue,  3 Oct 2023 11:42:30 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shiji Yang <yangshiji66@outlook.com> wrote:

> On Mediatek vendor driver[1], MT7620 (RT6352) uses different RSSI
> base value '-2' compared to the other RT2x00 chips. This patch
> introduces the SoC specific base value to fix the low RSSI value
> reports on MT7620.
> 
> [1] Found on MT76x2E_MT7620_LinuxAP_V3.0.4.0_P3 ConvertToRssi().
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

2ecfe6f07e8e wifi: rt2x00: fix MT7620 low RSSI issue

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/TYAP286MB031571CDB146C414A908A66DBCFEA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

