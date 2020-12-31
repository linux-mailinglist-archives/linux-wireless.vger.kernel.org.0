Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB1B2E7D4C
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Dec 2020 01:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgLaAGN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Dec 2020 19:06:13 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:47714 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgLaAGN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Dec 2020 19:06:13 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 73E6813C2B6;
        Wed, 30 Dec 2020 16:05:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 73E6813C2B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1609373132;
        bh=74F9uF2DehkgCi3NHdxvUf7tsGOzy0XtDg//ckS2sGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4DcRPQmf2jaH/+i0yL6EQTgJym82gy888o5h8z26u9Iw11VqYdtJ6ckb6HbFaQ7S
         f4GmOt7K0DY28zG1s2XM9E5BipfYz4h5WM1SXMiCBkq9pedf6e4UKRtKNHBXRsF2w8
         DdC1sWcC3uNOv671UJaa/1HM9O/ihJqRAO9uItYE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     luca@coelho.fi, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 4/6] iwlwifi:  Add BusName to debugfs
Date:   Wed, 30 Dec 2020 16:05:21 -0800
Message-Id: <20201231000523.14963-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201231000523.14963-1-greearb@candelatech.com>
References: <20201231000523.14963-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This gives us an easier way to know the fwcfg
file that may be loaded per device.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 3395c4675988..eb256ad143cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -760,6 +760,8 @@ static ssize_t iwl_dbgfs_fw_ver_read(struct file *file, char __user *user_buf,
 			 mvm->fwrt.trans->name);
 	pos += scnprintf(pos, endpos - pos, "Bus: %s\n",
 			 mvm->fwrt.dev->bus->name);
+	pos += scnprintf(pos, endpos - pos, "BusName: %s\n",
+			 dev_name(mvm->fwrt.dev));
 
 	ret = simple_read_from_buffer(user_buf, count, ppos, buff, pos - buff);
 	kfree(buff);
-- 
2.20.1

