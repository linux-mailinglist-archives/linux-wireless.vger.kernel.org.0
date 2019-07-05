Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDAA560B9E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2019 21:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfGETBS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Jul 2019 15:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfGETBS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Jul 2019 15:01:18 -0400
Received: from localhost.lan (unknown [151.66.63.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FB3921670;
        Fri,  5 Jul 2019 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562353277;
        bh=2jPbqhPv4idGsUkwi5oWKVTctrNzIjO1bzEoBQoN/Ws=;
        h=From:To:Cc:Subject:Date:From;
        b=sTMN3O04RPphSvA94knhsHNc+AaPGVB+h6ECbe2ayQuKZgeaYtDlpHGop4Umyw7ie
         STsN6wEbDzO4+FqPpPvTAwxSUowEdhYx8ze2rBjDsfSxFLumyJOyI2C7rUZNg+4sls
         9+Wy0ITB9GRmgCnth7p0xPBXIhrG2YBYrP6cHpTg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sidhayn@gmail.com, sgruszka@redhat.com
Subject: [PATCH] mt76: mt76x0u: add support to TP-Link T2UHP
Date:   Fri,  5 Jul 2019 21:01:04 +0200
Message-Id: <dfb97adb52811bed530449c22a172724ed992771.1562353065.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce support to TP-Link T2UHP
https://wikidevi.com/wiki/TP-LINK_Archer_T2UHP

Tested-by: Sid Hayn <sidhayn@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 627ed1fc7b15..b007bcd2e999 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -32,6 +32,7 @@ static struct usb_device_id mt76x0_device_table[] = {
 	{ USB_DEVICE(0x20f4, 0x806b) },	/* TRENDnet TEW-806UBH  */
 	{ USB_DEVICE(0x7392, 0xc711) }, /* Devolo Wifi ac Stick */
 	{ USB_DEVICE(0x0df6, 0x0079) }, /* Sitecom Europe B.V. ac  Stick */
+	{ USB_DEVICE(0x2357, 0x0123) }, /* TP-LINK T2UHP */
 	{ USB_DEVICE(0x2357, 0x0105),
 	  .driver_info = 1,	     }, /* TP-LINK Archer T1U */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0E8D, 0x7630, 0xff, 0x2, 0xff)}, /* MT7630U */
-- 
2.21.0

