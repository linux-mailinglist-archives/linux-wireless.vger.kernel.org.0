Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C515F3E56
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 10:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiJDI25 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 04:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJDI2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 04:28:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0951B24958
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 01:28:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23BF3CE1021
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 08:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D5BC433D6;
        Tue,  4 Oct 2022 08:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664872124;
        bh=l3zd4QFiBi+c8RPjWU1fgVu5XnoQv3saRVvbTC9lmAk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=maHd3Qeer8kwyEBPr1n7i7pgxP4/pUpe/USD0eWIfJbaOaw5BDq+2T4JUGiNbnyu7
         1DXT13zJnKZcNZjGfAczFIZgk/sU3uOK5tFe3bYyEpntHNsimBEWGDiOdV6SlctAVA
         wEE6WywoleyQsJElq9KbBrcVSUcp2SWBfjGx4xFcp3ZIOOaM/aAukPc8PZBjdkINab
         +aKIxBIfXTQiYsvlm6/KGxbElseh5jeat4odxFemIAsxQdyEAhUlW9rritfiF9YWqW
         P1ovma2mUM9TAvK8aEMulsNxSTao97KLagoFoQdk8wB0xpzx4G0KDsdJksmMuaQL4z
         h1sUAorfTxrJA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] brcmfmac: add a timer to read console periodically in
 PCIE bus
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220929031001.9962-2-ian.lin@infineon.com>
References: <20220929031001.9962-2-ian.lin@infineon.com>
To:     Ian Lin <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>,
        <ian.lin@infineon.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166487211864.2137.8224376186570535551.kvalo@kernel.org>
Date:   Tue,  4 Oct 2022 08:28:42 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ian Lin <ian.lin@infineon.com> wrote:

> From: Wright Feng <wright.feng@cypress.com>
> 
> Currently, host only reads console buffer when receiving mailbox data or
> hit crash with PCIE bus. Therefore, we add timer in PCIE code to read
> console buffer periodically to help developer and user check firmware
> message when there is no data transmission between host and dongle.
> 
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>

3 patches applied to wireless-next.git, thanks.

dcb485dfc83b brcmfmac: add a timer to read console periodically in PCIE bus
2aca4f3734bd brcmfmac: return error when getting invalid max_flowrings from dongle
5671c8b56c32 brcmfmac: dump dongle memory when attaching failed

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220929031001.9962-2-ian.lin@infineon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

