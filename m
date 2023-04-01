Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F826D2D22
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 03:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjDABq2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 21:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjDABpo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 21:45:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D8525455;
        Fri, 31 Mar 2023 18:44:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 737A1B83312;
        Sat,  1 Apr 2023 01:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFA6C433A0;
        Sat,  1 Apr 2023 01:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680313462;
        bh=cJsINUV4O0+bfXc26jmWZ2cSVuNdMVSmedNNpH0y7mI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AoUj+NaL9blpVxBnuZZD2qPfnHSGaHdAiO2oDMYmQoNUqmkcPbl0WxZIXiAeitoPG
         Gk2W08htgOsn08KkluWdhVexcqsnxNUxTfHb9a9PHk+hZktIo52/UztB6d05aLkX62
         jMaexSuPxg3MhiRdhvm1nN7vMKXeyFDdIq3dy/gcl9TIZ4csJD0/WRxndwBlBkf7xA
         3wF6Taqy3eLUNyHUpCbXtO29oufAkZRi8KCUjOqt7w+Yryv/bP20wBWE6jPc4x+4pZ
         b+eqf5SHCedfAf2n8OUsbLjoKVMF1pYrUG/o4yg2yIdKqtcUfwLaP+KkRTvGM7NVAM
         F+Upx4UqCfhBw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        amitkarwar@gmail.com, ganapathi017@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/7] wifi: mwifiex: mark OF related data as maybe unused
Date:   Fri, 31 Mar 2023 21:44:12 -0400
Message-Id: <20230401014417.3357252-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230401014417.3357252-1-sashal@kernel.org>
References: <20230401014417.3357252-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 139f6973bf140c65d4d1d4bde5485badb4454d7a ]

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/net/wireless/marvell/mwifiex/sdio.c:498:34: error: ‘mwifiex_sdio_of_match_table’ defined but not used [-Werror=unused-const-variable=]
  drivers/net/wireless/marvell/mwifiex/pcie.c:175:34: error: ‘mwifiex_pcie_of_match_table’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230312132523.352182-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 2 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index b0024893a1cba..50c34630ca302 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -183,7 +183,7 @@ static const struct mwifiex_pcie_device mwifiex_pcie8997 = {
 	.can_ext_scan = true,
 };
 
-static const struct of_device_id mwifiex_pcie_of_match_table[] = {
+static const struct of_device_id mwifiex_pcie_of_match_table[] __maybe_unused = {
 	{ .compatible = "pci11ab,2b42" },
 	{ .compatible = "pci1b4b,2b42" },
 	{ }
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 7fb6eef409285..b09e60fedeb16 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -484,7 +484,7 @@ static struct memory_type_mapping mem_type_mapping_tbl[] = {
 	{"EXTLAST", NULL, 0, 0xFE},
 };
 
-static const struct of_device_id mwifiex_sdio_of_match_table[] = {
+static const struct of_device_id mwifiex_sdio_of_match_table[] __maybe_unused = {
 	{ .compatible = "marvell,sd8787" },
 	{ .compatible = "marvell,sd8897" },
 	{ .compatible = "marvell,sd8997" },
-- 
2.39.2

