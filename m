Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD01624FE8
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2019 15:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfEUNRK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 May 2019 09:17:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42293 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEUNRJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 May 2019 09:17:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hT4de-0003es-QC; Tue, 21 May 2019 13:17:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wilc1000: remove redundant masking of pkt_offset
Date:   Tue, 21 May 2019 14:17:06 +0100
Message-Id: <20190521131706.30236-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The masking update of pkg_offset is redundant as the updated
value is never read and pkg_offset is re-assigned on the next
iteration of the loop.  Clean this up by removing the redundant
assignment.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/wilc1000/wilc_wlan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_wlan.c b/drivers/staging/wilc1000/wilc_wlan.c
index 95eaf8fdf4f2..dcd728557958 100644
--- a/drivers/staging/wilc1000/wilc_wlan.c
+++ b/drivers/staging/wilc1000/wilc_wlan.c
@@ -709,9 +709,6 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wilc, u8 *buffer, int size)
 			break;
 
 		if (pkt_offset & IS_MANAGMEMENT) {
-			pkt_offset &= ~(IS_MANAGMEMENT |
-					IS_MANAGMEMENT_CALLBACK |
-					IS_MGMT_STATUS_SUCCES);
 			buff_ptr += HOST_HDR_OFFSET;
 			wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len);
 		} else {
-- 
2.20.1

