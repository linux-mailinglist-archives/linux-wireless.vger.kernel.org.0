Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814BF15A57
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 07:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfEGFmQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 01:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbfEGFmO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 01:42:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B1B2206A3;
        Tue,  7 May 2019 05:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207734;
        bh=iL2UrK33nvVkAGSSO9tvV67FB6ijQogTXc3Jh8cDVAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrU6+ohRmj8LSKdoSPUsipn1Qx8TxZOuhn9xxEPCSlEQ6lZpTtxSxZzvaIguxOw3Y
         uxhmP8LbeYGhySG/gE83TJFaZUcr35l6mtA8hnDdbcgJya3KPbmtK0zKTFffvkWJQS
         4udOuvCAn6/QGv1/hFPCVrmUXjL+kH6ObhMUy+tk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Gomez <dagmcr@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 24/25] spi: ST ST95HF NFC: declare missing of table
Date:   Tue,  7 May 2019 01:41:21 -0400
Message-Id: <20190507054123.32514-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507054123.32514-1-sashal@kernel.org>
References: <20190507054123.32514-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Daniel Gomez <dagmcr@gmail.com>

[ Upstream commit d04830531d0c4a99c897a44038e5da3d23331d2f ]

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo drivers/nfc/st95hf/st95hf.ko | grep alias
alias:          spi:st95hf

After this patch:
modinfo drivers/nfc/st95hf/st95hf.ko | grep alias
alias:          spi:st95hf
alias:          of:N*T*Cst,st95hfC*
alias:          of:N*T*Cst,st95hf

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/st95hf/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index c2840e412962..850e75571c8e 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -1074,6 +1074,12 @@ static const struct spi_device_id st95hf_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, st95hf_id);
 
+static const struct of_device_id st95hf_spi_of_match[] = {
+        { .compatible = "st,st95hf" },
+        { },
+};
+MODULE_DEVICE_TABLE(of, st95hf_spi_of_match);
+
 static int st95hf_probe(struct spi_device *nfc_spi_dev)
 {
 	int ret;
@@ -1260,6 +1266,7 @@ static struct spi_driver st95hf_driver = {
 	.driver = {
 		.name = "st95hf",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(st95hf_spi_of_match),
 	},
 	.id_table = st95hf_id,
 	.probe = st95hf_probe,
-- 
2.20.1

