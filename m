Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD445F5069
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 09:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJEHmK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 03:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJEHmH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 03:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688CE5D113
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 00:42:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF20261592
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 07:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CF6C433D6;
        Wed,  5 Oct 2022 07:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664955725;
        bh=iIBmpeRNO+LqfqVHJ3ThkvAWOnHMn1Iy14BcurKLoHU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RpRBAOqK/6pnJ6ciUhedmnnxn7ncqMb/GdsXFecCKv2rdsDn+oQmZzYclSLfxR/E8
         Rt+pTJuD3zBxZZYev3FjoKtyq8p51rIPgg+n8svJI0s7frVabtJb7fQKxPDXAK7dJG
         fZiURQKg85QMrhcbYyi35/ziNi9IB1sf/Mg0F0EW5aqPCUGa5RlRA7u/2PLcAG4eDs
         SwkqTUClIc/vqL+oIWuLHlZ4Zxd6kRqG0S/r5cF/ZvHzyB0qr8KTQtJgR3jejDvcAe
         x1+rS2jj9jIB4m6weRbwi3osRzFKnNBruOphBvBuU5NXIRuca9E6d25S2OvU6p3JH5
         7Bx74UarGKoRA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] brcmfmac: add creating station interface support
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220929050614.31518-2-ian.lin@infineon.com>
References: <20220929050614.31518-2-ian.lin@infineon.com>
To:     Ian Lin <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>,
        <ian.lin@infineon.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166495571909.5945.9074519493480723249.kvalo@kernel.org>
Date:   Wed,  5 Oct 2022 07:42:03 +0000 (UTC)
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
> With RSDB device, it is able to control two station interfaces
> concurrently. So we add creating station interface support and
> allow user to create it via cfg80211.
> 
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>

3 patches applied to wireless-next.git, thanks.

2b5fb30f8ff5 brcmfmac: add creating station interface support
4388827b87d8 brcmfmac: support station interface creation version 1, 2 and 3
1562bdef9251 brcmfmac: Fix AP interface delete issue

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220929050614.31518-2-ian.lin@infineon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

