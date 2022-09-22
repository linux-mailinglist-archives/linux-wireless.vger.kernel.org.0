Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD935E5C7D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 09:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiIVHdp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 03:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiIVHdn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 03:33:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE90CA0247
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 00:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 822B5B834BE
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 07:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CE1C433D6;
        Thu, 22 Sep 2022 07:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663832020;
        bh=NtUVFVS5gh4WMHKUCifTp8QSCyfeIHcPPtmlPDPG3rk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GE1T3ylpsFIUxunffMTpo4ZXVMFDqwREAQDJOBIBadBe8YVH2DvUlSSvMaHRCcWqK
         qghnYDZpPfLMIsfy1/g2BKlPAUJ9ZrKGxtuROucXAEJ0obfQrqnPzWrE5iTchTuMUQ
         ae6/Fw0DVKWVBUjGa8r997PM73wgdtOp8gIjYSrWppcz3zWOgv3dxZmoVtiZLVSjG3
         w7JUtv98DRiwLx7Sx8Xa9zB2vrerh3ZniXI9T4Omf90BjJmIQQC03PGU43M+bUJBdU
         5hMR4rgdKqUK/s5xx83S9W71eaZLgFIE7mfu6YngkHPeqQETB5aauDY8MIolCOjSpz
         8RcTKp8zIVPbQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: ath11k: retrieve MAC address from system
 firmware if
 provided
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220920003117.841442-1-junyuu@chromium.org>
References: <20220920003117.841442-1-junyuu@chromium.org>
To:     Jun Yu <junyuu@chromium.org>
Cc:     ath11k@lists.infradead.org, quic_jjohnson@quicinc.com,
        linux-wireless@vger.kernel.org, Jun Yu <junyuu@chromium.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166383201294.5334.14513414529811662280.kvalo@kernel.org>
Date:   Thu, 22 Sep 2022 07:33:38 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jun Yu <junyuu@chromium.org> wrote:

> Devices may provide their own MAC address via system firmware (e.g.,
> device tree), especially in the case where the device doesn't have a
> useful EEPROM on which to store its MAC address (e.g., for integrated
> ahb WCN6750).
> 
> Use the generic device helper to retrieve the MAC address, and (if
> present) honor it above the MAC address advertised by the card.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Jun Yu <junyuu@chromium.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

176239a9a2e3 wifi: ath11k: retrieve MAC address from system firmware if provided

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220920003117.841442-1-junyuu@chromium.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

