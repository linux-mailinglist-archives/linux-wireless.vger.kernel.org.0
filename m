Return-Path: <linux-wireless+bounces-19283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE42AA3F901
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7035F421778
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEBA23A6;
	Fri, 21 Feb 2025 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onet.pl header.i=@onet.pl header.b="MWBNxwQ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpo92.poczta.onet.pl (smtpo92.poczta.onet.pl [213.180.149.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805BD29CE6
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.180.149.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152192; cv=none; b=W63GtHgfHHS1bEcxxh+caUqeIQkyghLbxqp16o1cSuVAkGkbm1ZCvJfbYm7cx62/BkiA49z0QP2w5kauWFDYqXsLvUey7dtJpGBv+5CuU37+1iII+kF/2NBHC4GprXdSmQSlCrHuKYjtvV0tKWFez+nF8cLZWJ9hov1xnSInLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152192; c=relaxed/simple;
	bh=Cldg1LGwfg0rOsCplzJXyP4bx3TFpjuMuyMpCrSRyq4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=msY7I0rMvlA+dD+sY60KXLI6qElNx8QFQJfUpclTvPxPmIo1tJ0G5Emco44YYxindUldCvSbEI4r4/JbEHOAs8L8AqELPxzLaQ/AzjGEhFopv5t26HsyQQ8XXkiSeaXrNuo32ynO8+1aU/5vIpFVDdROPRPiGJH9J3tVX3aD7lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onet.pl; spf=pass smtp.mailfrom=onet.pl; dkim=pass (1024-bit key) header.d=onet.pl header.i=@onet.pl header.b=MWBNxwQ0; arc=none smtp.client-ip=213.180.149.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onet.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onet.pl
Received: from DESKTOP (77-255-105-178.dynamic.inetia.pl [77.255.105.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukasz.michalski@onet.pl)
	by smtp.poczta.onet.pl (Onet) with ESMTPSA id 4YzvMj5ny8z20TW;
	Fri, 21 Feb 2025 16:35:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onet.pl; s=2011;
	t=1740152115; bh=y6r8+ehpLpMxc79uGOsdqqteBbVTeTdIegxgRS0aDjk=;
	h=From:To:Subject:Date:From;
	b=MWBNxwQ0Zz5TWVmGkhsstEQO7Z+A25tu9BLy0+LseVsV9ODNtwX2Re/4o0Fu+0WYP
	 Qq/zdtjXE+Tz7dPV6FY18bdDGNuqyrYV8vwmY8OfCXZNV2WDfGkZZhzc+MS2aeQWQl
	 q7H7Mt65AcANGZ0Q4viEU085O8Hd+qWv8tfVmXwE=
From: <lukasz.michalski@onet.pl>
To: <linux-wireless@vger.kernel.org>,
	<nbd@nbd.name>,
	<lorenzo@kernel.org>
Subject: wifi: mt76: mt7915: fix broken background radar implementation
Date: Fri, 21 Feb 2025 16:35:11 +0100
Message-ID: <003401db8476$348684c0$9d938e40$@onet.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AduEdOPGlKcG53eRQ62dz7IoNCU8Iw==
Content-Language: pl

Currently enabling background radar in hostapd results in unreachable AP.
There is because of mistake in enabling background radar implementation for
mt7915 mcu driver - 3rd and 4th parameters are swapped.
mt76_connac_mcu_rdd_cmd requires rx_sel as a fourth parameter but this
parameter is provided as third argument.
Fix was tested on mt7981 and background radar works now correctly. Other
mt76 drivers do not have similar issues.
The issue was also described here:
https://github.com/openwrt/mt76/issues/958

Signed-off-by: Lukasz Michalski <lukasz.michalski@onet.pl>
---
 drivers/net/wireless/mt76/mt7915/mcu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mt76/mt7915/mcu.c
b/drivers/net/wireless/mt76/mt7915/mcu.c
index 9d790f23..a2bad361 100644
--- a/drivers/net/wireless/mt76/mt7915/mcu.c
+++ b/ drivers/net/wireless/mt76/mt7915/mcu.c
@@ -2718,8 +2718,8 @@ int mt7915_mcu_rdd_background_enable(str
 	int err, region;
 
 	if (!chandef) { /* disable offchain */
-		err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_STOP,
MT_RX_SEL2,
-					      0, 0);
+		err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_STOP, 0,
+					      MT_RX_SEL2, 0);
 		if (err)
 			return err;
 
@@ -2745,8 +2745,8 @@ int mt7915_mcu_rdd_background_enable(str
 		break;
 	}
 
-	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_START, MT_RX_SEL2,
-				       0, region);
+	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_START, 0,
+				       MT_RX_SEL2, region);
 }
 
 int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)


