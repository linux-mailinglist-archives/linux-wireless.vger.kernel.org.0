Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884E62E7D4B
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Dec 2020 01:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgLaAGN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Dec 2020 19:06:13 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:47710 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgLaAGM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Dec 2020 19:06:12 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 3ECE413C2B4;
        Wed, 30 Dec 2020 16:05:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3ECE413C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1609373132;
        bh=MYYA1lu2bURnsdzJW7BUzNGdF1aE8TOYYJCaWgBJ7dY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nnFhaZsrTckJu3W0gfEqBcvvLDHPixR+8uXwR6PqWJXxpMl+Gd/8nKOujiGQn5vIp
         CdZjLcjDzS32AQXA+3WNzvayrzTi+vpJlFieVE6rh5cA6nC8HR+cOuoCZCw0MDW3Et
         6kQtUrQkMwVadz6Mr4IxCWOvjlei8mMjtKArEh2M=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     luca@coelho.fi, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 3/6] iwlwifi: Allow per-device fwcfg files.
Date:   Wed, 30 Dec 2020 16:05:20 -0800
Message-Id: <20201231000523.14963-3-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201231000523.14963-1-greearb@candelatech.com>
References: <20201231000523.14963-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This allows one to set the NSS and some
other low-level features for ax200 radios.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c
index 223c716d9fce..e2ae509d1650 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c
@@ -246,12 +246,16 @@ void iwl_dbg_cfg_load_ini(struct device *dev, struct iwl_dbg_cfg *dbgcfg)
 	const struct firmware *fw;
 	char *data, *end, *pos;
 	int err;
+	char fname[128];
 
 	if (dbgcfg->loaded)
 		return;
 
-	/* TODO: maybe add a per-device file? */
-	err = firmware_request_nowarn(&fw, "iwl-dbg-cfg.ini", dev);
+	snprintf(fname, 127, "iwl-dbg-cfg-%s.ini", dev_name(dev));
+	fname[127] = 0;
+
+	/* TODO: maybe add a per-device file?  Yes, did that. --Ben */
+	err = firmware_request_nowarn(&fw, fname, dev);
 	if (err)
 		return;
 
-- 
2.20.1

