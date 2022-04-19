Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FA150786C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Apr 2022 20:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356764AbiDSSTZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Apr 2022 14:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356531AbiDSSTD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Apr 2022 14:19:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ABB3F331;
        Tue, 19 Apr 2022 11:13:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7050B81866;
        Tue, 19 Apr 2022 18:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B67C385A9;
        Tue, 19 Apr 2022 18:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650392000;
        bh=0up0+3ng2gkf9fVKVYD32dBPHhE8G+CBylS47GayzIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVGxooWH8gk/NdSfBlPMd4AsaguMBe7T1ME6O/V8H8o9n3En5zunSsuuV8nQdR5yu
         u6b6DpSgzZ6ZCHFQPcK+y7QAznEdIJZmFgVQtGncxQSxU6Cdzt3MWXtnhl2bAJe0Ue
         YpVeOeaDfJzVi4fJaXWcZ9T6SNN4PZO7dgNbdPCKspEVMGcpfI/RNc9hzwc7elhiFE
         j7AWumOCwHcyPfwmPrnObpNyuwjpc5iPZTjoNWTuA3RgLZfGKbzJ6I7/RfulbbZrmi
         bCrN2nBpFixwH8bO/lEGjezd6VgDUT8L9lQrnvwpzR1KpmfRyMz5I7QrJp+GQlyw9E
         nixMLKbTpFAnA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com, netdev@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Sasha Levin <sashal@kernel.org>, pabeni@redhat.com,
        linus.walleij@linaro.org, mbrugger@suse.com,
        tongtiangen@huawei.com, sean.anderson@seco.com,
        shenyang39@huawei.com, mike.rudenko@gmail.com, angus@akkea.ca,
        linux-wireless@vger.kernel.org, SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH AUTOSEL 5.15 12/27] brcmfmac: sdio: Fix undefined behavior due to shift overflowing the constant
Date:   Tue, 19 Apr 2022 14:12:27 -0400
Message-Id: <20220419181242.485308-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419181242.485308-1-sashal@kernel.org>
References: <20220419181242.485308-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Borislav Petkov <bp@alien8.de>

[ Upstream commit 6fb3a5868b2117611f41e421e10e6a8c2a13039a ]

Fix:

  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c: In function ‘brcmf_sdio_drivestrengthinit’:
  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:3798:2: error: case label does not reduce to an integer constant
    case SDIOD_DRVSTR_KEY(BRCM_CC_43143_CHIP_ID, 17):
    ^~~~
  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:3809:2: error: case label does not reduce to an integer constant
    case SDIOD_DRVSTR_KEY(BRCM_CC_43362_CHIP_ID, 13):
    ^~~~

See https://lore.kernel.org/r/YkwQ6%2BtIH8GQpuct@zn.tnic for the gory
details as to why it triggers with older gccs only.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Arend van Spriel <aspriel@gmail.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: netdev@vger.kernel.org
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/Ykx0iRlvtBnKqtbG@zn.tnic
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 5d156e591b35..f7961b22e051 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -557,7 +557,7 @@ enum brcmf_sdio_frmtype {
 	BRCMF_SDIO_FT_SUB,
 };
 
-#define SDIOD_DRVSTR_KEY(chip, pmu)     (((chip) << 16) | (pmu))
+#define SDIOD_DRVSTR_KEY(chip, pmu)     (((unsigned int)(chip) << 16) | (pmu))
 
 /* SDIO Pad drive strength to select value mappings */
 struct sdiod_drive_str {
-- 
2.35.1

