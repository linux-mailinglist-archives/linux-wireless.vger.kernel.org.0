Return-Path: <linux-wireless+bounces-11846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887C395CDB8
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A73281F40
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0079B185B46;
	Fri, 23 Aug 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="FEelb19e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FA3184532
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419540; cv=none; b=Ov1IlnrsYFdcQ92hs0qw0WIRx0HIUC0Q6A59TZeolG/52OTHehuohamegxY8BbA8zk9CUa5R2zuHyEnX0gUVN8qeVhLjiRJ6gYavJhxbIDdlgXSO04mVErw+C3YSDeAN7kX3ZwqERz5FwFqhLE4A6TYmm+GaoM0OUfplRKaPHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419540; c=relaxed/simple;
	bh=Ms/AMgVS4CDgtoEwImzVWejNY/HDWjKW4hxSXd7TToY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OVGtftkoUenwoymJFIGszNAIRaHiz7IBCzW3rvYB2C56ULxMRlAt4NC3R9TSjmsNUyg+sKDtuN7oNrUTQqEwQDMHTGT6NfkkDLLYeHBc5Wgfhv/UCKXtYhwU6fgo1I1/M9Kj2cDXAWo/ccxvVolKCgYGvx3KPOy0mfFA5ziojlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=FEelb19e; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202408231315231f05036793832bbfd4
        for <linux-wireless@vger.kernel.org>;
        Fri, 23 Aug 2024 15:15:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Y89vCzptwdnKNk2K+D/h3ihBLRWAp2Sx0m64kgur5ac=;
 b=FEelb19ekzvjDFavKw8HJ9pZpgkVffPYiXt0XF7GHC2zYjbEvbJew6OgMW/Km2V79nq5Ch
 9a0bGbklp9Jya4trAs8NLPzBPDyS6jRfcQwf+JT2GbUjtgIU6ugK8fe7KqcnOgFcdoCMhK+Y
 BmdQKmAmjDTRDJHc00+mYgThHooOAuoWN5c8okjrZR2JQdeh4qHGQlBMi0ExGSRCGi3+0ZVT
 WZnZVkLqjdCnTvHtCZj9NhJb01YrrLUTe+3mkf8nGm8jzAWTc1bpqNpP6LdFRCa8dkjBlp0n
 LGbSqsbbETWt+lsYwXEgsG//uwjQ5Axr3u12cFUoasDnaLjWDB/Z/Jfg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-wireless@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>,
	Kalle Valo <kvalo@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: wfx: repair open network AP mode
Date: Fri, 23 Aug 2024 15:15:20 +0200
Message-ID: <20240823131521.3309073-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

RSN IE missing in beacon is normal in open networks.
Avoid returning -ENODEV in this case.

Steps to reproduce:

$ cat /etc/wpa_supplicant.conf
network={
	ssid="testNet"
	mode=2
	key_mgmt=NONE
}

$ wpa_supplicant -iwlan0 -c /etc/wpa_supplicant.conf
nl80211: Beacon set failed: -22 (Invalid argument)
Failed to set beacon parameters
Interface initialization failed
wlan0: interface state UNINITIALIZED->DISABLED
wlan0: AP-DISABLED
wlan0: Unable to setup interface.
Failed to initialize AP interface

After the change:

$ wpa_supplicant -iwlan0 -c /etc/wpa_supplicant.conf
Successfully initialized wpa_supplicant
wlan0: interface state UNINITIALIZED->ENABLED
wlan0: AP-ENABLED

Cc: stable@vger.kernel.org
Fixes: fe0a7776d4d1 ("wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/wireless/silabs/wfx/sta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index 216d43c8bd6e..7c04810dbf3d 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -352,8 +352,11 @@ static int wfx_set_mfp_ap(struct wfx_vif *wvif)
 
 	ptr = (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->data + ieoffset,
 				      skb->len - ieoffset);
-	if (unlikely(!ptr))
+	if (!ptr) {
+		/* No RSN IE is fine in open networks */
+		ret = 0;
 		goto free_skb;
+	}
 
 	ptr += pairwise_cipher_suite_count_offset;
 	if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
-- 
2.46.0


