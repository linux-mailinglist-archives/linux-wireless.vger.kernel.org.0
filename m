Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303035F3DE5
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 10:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJDILu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 04:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJDIL3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 04:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95D24DF0B
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 01:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5254761242
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 08:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9E3C433D6;
        Tue,  4 Oct 2022 08:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664870990;
        bh=B7Ou4u94LVCGNPh+66cKVQNMbGeaHF8S44RdIyYIFGA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rPr+GQVkxS+M79nHfpCMgq7+aAS9taAD44kkyGAkFlmhVbIf9qix+2IzgDkk2EdUe
         rWop/CkzIhF2JGaQN0aFFHcx9vn/0szj2tGzZuHhXJoiolVnZhqPfkC+qH82+5zAbK
         j4+kmdS8J+E92szpiS37h9t0CW8tILTTCvldLbssj7A8oIBXcR6JT7q455JoxBmieR
         lvF2FZwNNuRm9WKy7R0MT0MwOBjiGgTMDQoqT9oJMcVjbEq8L//U6rbRPplo8f30QX
         Rb/IBV1J9yZXd6aXKhutvrEU8ZL2xPqQ/odQvSOCrf8i5uIBzqwiK1q+eKZ5rmkojm
         14jN+//VEDjnw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: rtl8xxxu: Support new chip RTL8188FU
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <b14f299d-3248-98fe-eee1-ba50d2e76c74@gmail.com>
References: <b14f299d-3248-98fe-eee1-ba50d2e76c74@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Jes Sorensen <Jes.Sorensen@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166487098808.9318.5188288716066074608.kvalo@kernel.org>
Date:   Tue,  4 Oct 2022 08:09:49 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> This chip is found in the cheapest USB adapters, e.g. 1.17 USD with
> VAT and shipping from China included.
> 
> It's a gen 2 chip, similar to the RTL8723BU, but without Bluetooth.
> Features: 2.4 GHz, b/g/n mode, 1T1R, 150 Mbps.
> 
> The vendor driver rtl8188fu version 4.3.23.6_20964.20170110 [0]
> was used as reference. The CD shipped with the device includes a
> newer driver, version 5.11.5-1-g12f7cde4b.20201102, but that one
> couldn't complete the WPA2 key exchange thing for whatever reason.
> 
> [0] https://github.com/kelebek333/rtl8188fu
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Patch applied to wireless-next.git, thanks.

c888183b21f3 wifi: rtl8xxxu: Support new chip RTL8188FU

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/b14f299d-3248-98fe-eee1-ba50d2e76c74@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

