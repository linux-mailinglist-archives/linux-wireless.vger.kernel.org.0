Return-Path: <linux-wireless+bounces-22091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94546A9D674
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 01:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5104A588E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 23:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC142980CA;
	Fri, 25 Apr 2025 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hX21OGZD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB80D297A40;
	Fri, 25 Apr 2025 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745625234; cv=none; b=Mv0+5I3dr8+1J3HthkgOQ6fFCAMVmXBWbwt32ltLHsD9ijPx7cT5v4VUlvSD4/jo7Mxez07VVlOq49cUrGppJ9d+jmSI29XIODr9qq3XS3S8AjJyjMgheJJbHCwQ6S38n/i/RWnDIpXHIVwQn27LWl3zd/Ty8I7e3rO581ZAWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745625234; c=relaxed/simple;
	bh=uqmOtj3YthVieYStT88qtrwuQ31WMgaqo6uSwy+CxVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeDfVN1wlgykkPBolZvre71LBf1qQZf09NXhEL3izUaVLJ2z2h1zRt+gMFzU4hJHQf9XxIFXxKEGn8Cqv6QWZbm2Edv9apvvGysG9pSyv6f9AbAymdWjJagV9vvVrU4O2vHJvAssdo7T2487MbZ2XNkBueWKJ2vKJbe24RBTpkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hX21OGZD; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=l/GKx28/1j1UV1MQlN4cqj9ybn8wlDRc1W1XQUhGrJs=; b=hX21OGZDguhvTJpa
	elEYddx6CJoKbcjtP/KQuj9TBsKeFzPOp6lFCzGtwcjlMcYkuQUa5TVju0ZuIa0xULHpRNPyFv5/k
	oKYGTWOsAluzGHpTBXY7SLRd5ObSRr6wi0EUToGNEMqqWgMzOK3fy9S1jd1c1Bsl6TXVBFtaCFTZg
	FQihsZ7mKNIhzAQB8aNdf4QA8SRj+n6/uUeeS7hrFe/plP5JK4ZcK4f9phUBCbwCZwiHpcWy3BATJ
	Dp6mFz3k1cA+tDFZluB05UEES04uapcX67kV9IqFfG4ro45jg3PUCof9NlspbD17ceJMqbw3WWTEa
	SyiLHhzJH6JbyVmWTg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u8SrV-00Dznj-0b;
	Fri, 25 Apr 2025 23:53:41 +0000
From: linux@treblig.org
To: pkshih@realtek.com,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/3] wifi: rtlwifi: Remove unused rtl_usb_{resume|suspend}
Date: Sat, 26 Apr 2025 00:53:38 +0100
Message-ID: <20250425235340.288340-2-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425235340.288340-1-linux@treblig.org>
References: <20250425235340.288340-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

rtl_usb_resume() and rtl_usb_suspend() are trivial stubs that were
added in 2011's
commit 2ca20f79e0d8 ("rtlwifi: Add usb driver")
but aren't wired up anywhere (though commit 442888c706e9 ("rtlwifi:
rtl8192cu: Add routines dm, fw, led and sw")  added commented
out assignments).

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 12 ------------
 drivers/net/wireless/realtek/rtlwifi/usb.h |  2 --
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index f5718e570011..d35ed56d6db9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1077,15 +1077,3 @@ void rtl_usb_disconnect(struct usb_interface *intf)
 	ieee80211_free_hw(hw);
 }
 EXPORT_SYMBOL(rtl_usb_disconnect);
-
-int rtl_usb_suspend(struct usb_interface *pusb_intf, pm_message_t message)
-{
-	return 0;
-}
-EXPORT_SYMBOL(rtl_usb_suspend);
-
-int rtl_usb_resume(struct usb_interface *pusb_intf)
-{
-	return 0;
-}
-EXPORT_SYMBOL(rtl_usb_resume);
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.h b/drivers/net/wireless/realtek/rtlwifi/usb.h
index b66d6f9ae564..b873bbc9c4c2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.h
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.h
@@ -138,7 +138,5 @@ int rtl_usb_probe(struct usb_interface *intf,
 		  const struct usb_device_id *id,
 		  const struct rtl_hal_cfg *rtl92cu_hal_cfg);
 void rtl_usb_disconnect(struct usb_interface *intf);
-int rtl_usb_suspend(struct usb_interface *pusb_intf, pm_message_t message);
-int rtl_usb_resume(struct usb_interface *pusb_intf);
 
 #endif
-- 
2.49.0


