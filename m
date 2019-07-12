Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212DE66AB9
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 12:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfGLKI6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 06:08:58 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.3]:36140 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbfGLKI6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 06:08:58 -0400
Received: from [67.219.246.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-east-1.aws.symcld.net id DB/E5-10895-83C582D5; Fri, 12 Jul 2019 10:08:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRWlGSWpSXmKPExsXi5LtOQNciRiP
  W4Mx2QYtHl44xW7xZcYfdgclj85J6j8+b5AKYolgz85LyKxJYM76dusBWMJu94ueuHsYGxi1s
  XYxcHEICqxklWva3QTlrGCWOn/3ADOFsAHJOtrB0MXJysAnoSPx+9IgdxBYRUJD4NekjG4jNL
  KAi8WTyLrC4sECQxK2Fy8BsFgFVia9TF4D18gpYS/z70cAMYksIyEv8XLGJHSIuKHFy5hMWiD
  nyEs1bZzND2BISB1+8ALOFBJQlJh15zQjRqyBxeMlv5gmM/LOQtM9C0j4LSfsCRuZVjGZJRZn
  pGSW5iZk5uoYGBrqGhka6hrqGZpZ6iVW6SXqlxbqpicUluoZ6ieXFesWVuck5KXp5qSWbGIFh
  m1LAuHIH49+Zb/QOMUpyMCmJ8k7mU48V4kvKT6nMSCzOiC8qzUktPsQow8GhJMH7NEojVkiwK
  DU9tSItMwcYQzBpCQ4eJRFenWigNG9xQWJucWY6ROoUoy7H2u1LFjELseTl56VKifP6ghQJgB
  RllObBjYDF8yVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrxGIFN4MvNK4Da9AjqCCegIVT8
  1kCNKEhFSUg1MTUtmis058Edsp0gf7z3uA6bCU9mTGyqSQs8k3b+wKWlTGtvVzuki7183rX06
  N7Mo2dXK6IFOSCfvnjielq4TPHyyov877be+ZuWefXrRPPbcvc4R2V1f5H+Y7XRMvVvDxblu2
  sZtU7f/fzH1Udwvh0mKP0Jm+vWpiV2fMfnhta36/HL3jV4FZRrVebw8d5hjh0F2782OGcZJR8
  4vnbVXVSBJ5UPaxebvjrfvdqrv/FgndpqFoenDrOUrRR4avHuRHndfyKvBYr/FWpdY/8SnAvH
  z0iwz1IoeV9uteOp1+NZW+UTJsKYpook5jyf1F6xWl/j1Lzq0J3nLvVAeVbW8KPmvHyRMVm//
  Jf1eZIuSEktxRqKhFnNRcSIAW3QlUGIDAAA=
X-Env-Sender: Isaac.Hermida@digi.com
X-Msg-Ref: server-3.tower-385.messagelabs.com!1562926135!1490048!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24681 invoked from network); 12 Jul 2019 10:08:56 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-3.tower-385.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 12 Jul 2019 10:08:56 -0000
Received: from MTK-SMS-XCH04.digi.com (10.10.8.198) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 12 Jul 2019
 05:08:55 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH04.digi.com
 (10.10.8.198) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 12 Jul
 2019 05:08:55 -0500
Received: from log-cln-ihermida.digi.com (10.101.2.100) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 12 Jul 2019 12:08:53 +0200
From:   Isaac Hermida <isaac.hermida@digi.com>
To:     <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH][master/pending] ath10k: assign new interfaces type to parent type
Date:   Fri, 12 Jul 2019 12:08:46 +0200
Message-ID: <20190712100846.11158-1-isaac.hermida@digi.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.101.2.100]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is needed to have the AP mode working for SDIO.
Tested with lastest master/pending code on a QCA6564 chip with firmware
firmware-sdio-6.bin_WLAN.RMH.4.4.1-00011-QCARMSWP-2

Signed-off-by: Isaac Hermida <isaac.hermida@digi.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index e43a566eef77..2c4f8da98b24 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5150,6 +5150,9 @@ static int ath10k_add_interface(struct ieee80211_hw *hw,
 	arvif->ar = ar;
 	arvif->vif = vif;
 
+	// assign type of the new interface to the parent type (SDIO, PCI, etc)
+	ar->dev_type = arvif->ar->bus_param.dev_type;
+
 	INIT_LIST_HEAD(&arvif->list);
 	INIT_WORK(&arvif->ap_csa_work, ath10k_mac_vif_ap_csa_work);
 	INIT_DELAYED_WORK(&arvif->connection_loss_work,
