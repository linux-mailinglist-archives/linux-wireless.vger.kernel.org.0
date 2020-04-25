Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63451B8780
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 17:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgDYPwp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 11:52:45 -0400
Received: from mailomta9-sa.btinternet.com ([213.120.69.15]:27432 "EHLO
        sa-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726076AbgDYPwo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 11:52:44 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20200425155239.FQKM30279.sa-prd-fep-047.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Sat, 25 Apr 2020 16:52:39 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=j.oldman998@btinternet.com
X-Originating-IP: [31.51.225.56]
X-OWM-Source-IP: 31.51.225.56 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrheeggdejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofestddtredtredttdenucfhrhhomheplfhohhhnucfqlhgumhgrnhcuoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqnecukfhppeefuddrhedurddvvdehrdehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehhvghnrhihrdhhohhmvgdpihhnvghtpeefuddrhedurddvvdehrdehiedpmhgrihhlfhhrohhmpeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeolhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeolhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeomhessghuvghsrdgthheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry.home (31.51.225.56) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5E3A290C0D5574D3; Sat, 25 Apr 2020 16:52:39 +0100
From:   John Oldman <john.oldman@polehill.co.uk>
To:     m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Oldman <john.oldman@polehill.co.uk>
Subject: [PATCH] :ssb scan.c: Fixed block comments coding style issues
Date:   Sat, 25 Apr 2020 16:52:33 +0100
Message-Id: <20200425155233.19624-1-john.oldman@polehill.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixed coding style issues

Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
---
 drivers/ssb/scan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ssb/scan.c b/drivers/ssb/scan.c
index 6ceee98ed6ff..b97a5c32d44a 100644
--- a/drivers/ssb/scan.c
+++ b/drivers/ssb/scan.c
@@ -400,7 +400,8 @@ int ssb_bus_scan(struct ssb_bus *bus,
 #ifdef CONFIG_SSB_DRIVER_PCICORE
 			if (bus->bustype == SSB_BUSTYPE_PCI) {
 				/* Ignore PCI cores on PCI-E cards.
-				 * Ignore PCI-E cores on PCI cards. */
+				 * Ignore PCI-E cores on PCI cards.
+				 */
 				if (dev->id.coreid == SSB_DEV_PCI) {
 					if (pci_is_pcie(bus->host_pci))
 						continue;
@@ -421,7 +422,8 @@ int ssb_bus_scan(struct ssb_bus *bus,
 				if (bus->host_pci->vendor == PCI_VENDOR_ID_BROADCOM &&
 				    (bus->host_pci->device & 0xFF00) == 0x4300) {
 					/* This is a dangling ethernet core on a
-					 * wireless device. Ignore it. */
+					 * wireless device. Ignore it.
+					 */
 					continue;
 				}
 			}
-- 
2.17.1

