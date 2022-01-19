Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0262F4934C1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jan 2022 07:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351670AbiASGBW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jan 2022 01:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349940AbiASGBO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jan 2022 01:01:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44B9C061574
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jan 2022 22:01:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62BB760ADB
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jan 2022 06:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF78C004E1;
        Wed, 19 Jan 2022 06:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642572073;
        bh=mtSq2jQ0wam87rCLJDrAT/LDjsioSOG/4ILc+0JuQ3I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nIBCsEG+8Vz2SJ8rc/TSv7jyNED69cM999lc/zl+v42hV98NAxj8JR1iHobsb9/jI
         cKjzZS3LVMZFqwT9V8x50Zn0r88Gn3T3Ke4urA5sfza8GXayc/SyUcwLQc3grlaGaT
         jIZnyM70tNPko0Np7rzv0Z4ZpD1IkWB+zXxCuvqDTZzwDtsUoqytW/w3aM5EMTClMf
         U0UmWiPAF3A5+bP861ZdAleLPKWxVoVeW47SkH5xhtowAKoVBPloiY/oL0kKlE0fs1
         mbsC2cxrijpnJ6hN7Z5axgoHyBKCnX2Og5E/5wctjV/mdwQgFZF15/UCvjDwCHZ1d4
         ssRjq/C+Syb4g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: Re: [PATCH] brcmfmac: firmware: Fix crash in brcm_alt_fw_path
In-Reply-To: <20220118154514.3245524-1-phil@raspberrypi.com> (Phil Elwell's
        message of "Tue, 18 Jan 2022 15:45:14 +0000")
References: <20220118154514.3245524-1-phil@raspberrypi.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 19 Jan 2022 08:01:08 +0200
Message-ID: <87h7a0gt7f.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Phil Elwell <phil@raspberrypi.com> writes:

> The call to brcm_alt_fw_path in brcmf_fw_get_firmwares is not protected
> by a check to the validity of the fwctx->req->board_type pointer. This
> results in a crash in strlcat when, for example, the WLAN chip is found
> in a USB dongle.
>
> Prevent the crash by adding the necessary check.
>
> See: https://github.com/raspberrypi/linux/issues/4833
>
> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
> Signed-off-by: Phil Elwell <phil@raspberrypi.com>

I think this should go to v5.17.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
