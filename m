Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB876F9AA5
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 21:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfKLU25 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 15:28:57 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39319 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLU25 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 15:28:57 -0500
Received: by mail-qv1-f65.google.com with SMTP id v16so6957060qvq.6
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 12:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yTI0ONFOXQ2oCePDvomAjLQd/y1rIidUrIGAr+qJApw=;
        b=T8+mZNZ02TXm865XP/k6GiTW9YFrYvvrMdNZ2RLj9wlULAvkqVnnC3NfeppbnU68t7
         jrDqPcMNBoii9AKwNFm0KhtuyGiQFsPHag5qAfpVUxxmyq0hldwQ/MwOME7L9srurnpu
         v18F+Dfi1PcxI99QA1Do0FG0+yUdMhYqGtv7fhp/oGVbR3xO1CvyPOpRMu0wRgaIR3jW
         C2IyKVOvF9kasKXNCvsBSMTAC+KanLBbd56Dm52yBOyvLXniXfM2+N+03QU1hRT269Iu
         8ELEi2p9z6QY3P53abb2fhnznRZdT6w0udguN26op93KMnX13Bsn2BqcAf2Mb1GFB9C1
         RPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yTI0ONFOXQ2oCePDvomAjLQd/y1rIidUrIGAr+qJApw=;
        b=XRoLp8CQqC3VfOGCGKXzhKnGk5qh9f+UdWN9GNVSic2W1JsIYRnxwNpdzw5+0amLyS
         dnW6DMf/sdTm5VVaBvo967KkKE/NMIt/Zl2/Xwsvkb+e/+s4Yl2zjYJfDXLhTSNve4KP
         Hv02w1q/X8L6Y1Iba1AvwGeFN55cpfWzy5Ui+nEao7tSSPGqmHnYAjbmMXi+8a6GgNEu
         9J19UfiWP2n+SMMXBPiFQpQjxqyujg0x4Z7TsIVi4YmR6jJUewdfedAjviYlHDKEwUMW
         mJ8LghOkAWW1K/TM7iljrGqSCcEzZ/2Qm4hIpDVYQjaaz1l+EVgFuhzcUZRRB3k4Dg9B
         zbFg==
X-Gm-Message-State: APjAAAXa2Tstyi6fyToWq1trdjWwiHwDMENKfs2rUJ9Gj6oLYBoLpROC
        JJA9HMo07DlvATQQ+UAHu81rIhr2
X-Google-Smtp-Source: APXvYqxhUezmpXvHA0bwnVD+a0qrAANP2RPgfdG4dujQqdhN7syR7bCqCyqII2aMvYDdZ1lO9HZrvQ==
X-Received: by 2002:ad4:57d4:: with SMTP id y20mr31033711qvx.63.1573590534552;
        Tue, 12 Nov 2019 12:28:54 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::fa23])
        by smtp.gmail.com with ESMTPSA id n21sm13511690qtn.33.2019.11.12.12.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 12:28:53 -0800 (PST)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: [PATCH] rtl8xxxu: Add support for Edimax EW-7611ULB
Date:   Tue, 12 Nov 2019 15:28:50 -0500
Message-Id: <20191112202850.32041-1-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A number of people have reported the Edimax EW-7611ULB works fine.

Signed-off-by: Jes Sorensen <Jes.Sorensen@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index c6c41fb962ff..e74b204440cd 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6001,7 +6001,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		}
 		break;
 	case 0x7392:
-		if (id->idProduct == 0x7811)
+		if (id->idProduct == 0x7811 || id->idProduct == 0xa611)
 			untested = 0;
 		break;
 	case 0x050d:
@@ -6205,6 +6205,8 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192eu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0xb720, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8723bu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xa611, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8723bu_fops},
 #ifdef CONFIG_RTL8XXXU_UNTESTED
 /* Still supported by rtlwifi */
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8176, 0xff, 0xff, 0xff),
-- 
2.21.0

