Return-Path: <linux-wireless+bounces-28948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38505C5B752
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36DF5357553
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8DC2E2851;
	Fri, 14 Nov 2025 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fPvyjW8o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE6E2DF14B
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100136; cv=none; b=j6cSf0I75CuLghZyQUMI4GIwo6/DP5dEUcsCKen88/f0IJ9kPt5BLWwLI7ZaND4UGNIIfsN60Sa/VdBjhr5omOQ/GAhTMKo0iQII0eU+X6ZKMNq60fmGY/ErJO8BM2VzYnho0hd6HgqpefNlJWCw9YVIslfxmmI2uAJY7Pt04XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100136; c=relaxed/simple;
	bh=5XENyXXux18NaHBSmY94VPFtIEubN01hL6dpKs8QKJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIahSV5mjRUISsVDH7jS5bkPDPV3+72lJhwBUWrXLuUaVgr5S4ZghVzfzZlSq3OVqopB15JV9GqBdx9vuViuKT+N70z2qFBN/JLFYbG5Sx1fa6xUWgOCCpzQvhybvBIVrcavt1noaq9Ah4sl+cXDGDna4xcm8GyeSl5Tl1eQ/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fPvyjW8o; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE6292m81037202, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100129; bh=7HWW7QP5HggAHnSGzcogfB65ScbpS4I/IxVlF54s9OE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=fPvyjW8ohEbD7/Nv0tl/0J1amamkETYl3hbnXGLVtehqHriMQ6cbkK9v2JQEk8htf
	 yEXdkxMgmNtR1AtdnssojFgBfFMPkJJ5Q3TMO3+Im/RAWQjk9DApk77ZtXiZce1nKS
	 1KbqSxCmDR6h+CJD0pqOWGJJ7IFzNzds3LZ8gz04dTXIzFN5D3xLZiGY1ynI5CoTPA
	 k29Xm5h3YE/ls18ZD37pF8ELwGgM0GESG3kE5gDeglGDmF7vzCLIFSBOa9QQ7PYTEz
	 3AGNjgBaQEXbogaubinVLJrSnUekkzPZ6l7YaJXLWlhpdTfVbNP+Zhnwqm6MAojhiu
	 QI2KrWFB13U/Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE6292m81037202
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:02:09 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:02:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 01/14] wifi: rtw89: flush TX queue before deleting key
Date: Fri, 14 Nov 2025 14:01:15 +0800
Message-ID: <20251114060128.35363-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114060128.35363-1-pkshih@realtek.com>
References: <20251114060128.35363-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chih-Kang Chang <gary.chang@realtek.com>

In the wpa_supplicant rekey flow, it sends an EAPOL packet 4/4 through
nl80211_tx_control_port() and triggers wake_tx_queue() in the driver.
Then, it sends nl80211_new_key() to configure a new key in mac80211.
However, in wake_tx_queue(), a workqueue is used to process the TX packet,
which might cause the driver to process the EAPOL packet later than
nl80211_new_key(). This results in the EAPOL packet 4/4 being transmitted
with the new key and IV, causing it to be dropped by the AP. Therefore,
needs to flush TX queue before deleting the old key to ensure that the
EAPOL 4/4 packet is transmitted using the old key.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 6f7571c7c274..4a7364432428 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -969,6 +969,7 @@ static int rtw89_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		}
 		break;
 	case DISABLE_KEY:
+		flush_work(&rtwdev->txq_work);
 		rtw89_hci_flush_queues(rtwdev, BIT(rtwdev->hw->queues) - 1,
 				       false);
 		rtw89_mac_flush_txq(rtwdev, BIT(rtwdev->hw->queues) - 1, false);
-- 
2.25.1


