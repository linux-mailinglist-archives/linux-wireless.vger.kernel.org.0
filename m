Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3A37EEEB1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 10:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345803AbjKQJcO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Nov 2023 04:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345746AbjKQJbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Nov 2023 04:31:51 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0FE1BDB
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 01:31:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBy-0002W0-M9; Fri, 17 Nov 2023 10:31:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBv-009e8J-Bm; Fri, 17 Nov 2023 10:31:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBv-002yjW-1I; Fri, 17 Nov 2023 10:31:11 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel@pengutronix.de, Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Loic Poulain <loic.poulain@linaro.org>,
        wcn36xx@lists.infradead.org, Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
        Wang Yufen <wangyufen@huawei.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH wifi-next 0/6] wifi: Convert to platform remove callback returning void
Date:   Fri, 17 Nov 2023 10:30:57 +0100
Message-ID: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=F9Oxsx0QIJmkT38mUHzi9AwJy4rp6SebAFM9G77g8Jw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzLRhZMpN9DscQc/Acv1vmk3igI2Pvvo9Tzoe 5Cxm2rYGeWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVcy0QAKCRCPgPtYfRL+ TkkIB/9uaICn2CG/t+EHavYz+BD1rZTP1jDpIOy2VAQCFDCmPISU+qpaURWrMPloUJigTbMxhsy a8mKyOTQ1bpLexlOJwAf7P38lZYzZQnIc5jyBa3tI1YQXbMAeBzFP1SahXKBenwwYgEGyA+LryF zS7i6Npvf74UQox7GVqjcYQv1p5mQkb20j/2BHEhMZHNhrOM4VwNqMtmQkAggBrFG5lyXKpQs06 Yq13B4hO1mkEHFrzPrfZRzsYuxdlnYJrSQ0APgQuhbYPgcHKzLwEcPV0wH8CxVgJeLKMY+zq80c 5PvZhGx4TCKCmUY2Jkhdep9dzBu/zH23irbSifSzvsTBm9A+
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

this series converts the platform drivers below drivers/net/wireless to
make use of .remove_new().

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.
The TL;DR; is to make it harder for driver authors to leak resources
without noticing.

Best regards
Uwe

Uwe Kleine-König (6):
  wifi: ath11k: Convert to platform remove callback returning void
  wifi: ath5k: Convert to platform remove callback returning void
  wifi: ath9k: Convert to platform remove callback returning void
  wifi: wcn36xx: Convert to platform remove callback returning void
  wifi: brcmfmac: Convert to platform remove callback returning void
  wifi: mt76: Convert to platform remove callback returning void

 drivers/net/wireless/ath/ath11k/ahb.c                     | 6 ++----
 drivers/net/wireless/ath/ath5k/ahb.c                      | 8 +++-----
 drivers/net/wireless/ath/ath9k/ahb.c                      | 6 ++----
 drivers/net/wireless/ath/wcn36xx/main.c                   | 6 ++----
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 6 ++----
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c           | 7 ++-----
 drivers/net/wireless/mediatek/mt76/mt7615/soc.c           | 6 ++----
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c           | 6 ++----
 8 files changed, 17 insertions(+), 34 deletions(-)

base-commit: eff99d8edbed7918317331ebd1e365d8e955d65e
-- 
2.42.0

