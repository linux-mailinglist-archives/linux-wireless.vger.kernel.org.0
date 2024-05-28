Return-Path: <linux-wireless+bounces-8181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 601858D1722
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160FF285C4B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF27A140395;
	Tue, 28 May 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xDk3Smty"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10865140386;
	Tue, 28 May 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887903; cv=none; b=NyhgoBa7hkTyXSyt8SyDhCMfhGB5LyX5/qjLUxzdY8NhJuOYod6uKAO/TMIDYGu/JWHkTBNh2TJio6h6N6KcBgR8t37z7MfvKX4rCvpY+FVtXhO6es4FOR4ldpreP1SKfhZgOxrBed42Zv56tzQZAmvwF0xpR8pwISt6AwCuJfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887903; c=relaxed/simple;
	bh=LKu4LRyGZp0SuwvyOaS9H+olC5GTu4VF+Xc85CYC4ek=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PLL4LxNo2VxCPdI0UQ3SkL64aB6mRVctGJ3d4SiPwh2HygcX3e5sUoQPpttfxzyaCWG8SC3RaD+nBLSeGBuDAFtSR/R55hmuON87sTVW98p0HN8mkeWDkFXFEI2qAr6e6DT0836Gngnj7OEnvNvKmrsNg9tWCDyDYUegguwlEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xDk3Smty; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FlOsQt51ODlcWfSttNCMN/vZL8f8s6mIoZE3qIAvgdY=; b=xDk3SmtyjuJIz+pzkFgfJlAaJq
	JdvH9tfZ/3H8bqYWRwMvRrAPoeE52mOi5iw9VYATIfsa09vhaDzpktUgvVlO15ZJTrDs1VrhzAT3Z
	zQJFkq240k8ZjORkB+wHJpd6n/o211D4bSyoVuPyo57ahuH5BuE+0brCukMzSy+vqDCGZlW3YIXl2
	tRVShTsTMLAtS3Txi5TgbQ9P/8h7TrGUW+5dSiJBQB3da5kkFC/NEFZUD6fu3Zy69eUygopnDOby1
	xxE3LCjV7kchdNfCQNUZIGbRKkgviNIfZu+VQKaOR2vxvgK280j8I3hvFdP2w7iKM7HpCgPHJakV9
	kE0jooaw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53394 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sBsyF-0004Ya-0q;
	Tue, 28 May 2024 10:18:15 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sBsyH-00E8w6-Vu; Tue, 28 May 2024 10:18:18 +0100
In-Reply-To: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	 Michael Nemanov <michael.nemanov@ti.com>,
	 linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 8/8] wifi: wl18xx: allow firmwares > 8.9.0.x.58
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sBsyH-00E8w6-Vu@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 10:18:17 +0100

wlcore firmware versions are structured thusly:

	chip.if-type.major.sub-type.minor
e.g.	  8    9       0       0     58

With WL18xx ignoring the major firmware version, looking for a
firmware version that conforms to:

	chip >= 8
	if-type >= 9
	major (don't care)
	sub-type (don't care)
	minor >= 58

Each test is satisfied if the value read from the firmware is greater
than the minimum, but if it is equal (or we don't care about the
field), then the next field is checked.

Thus it doesn't recognise 8.9.1.x.0 as being newer than 8.9.0.x.58
since the major and sub-type numbers are "don't care" and the minor
needs to be greater or equal to 58.

We need to change the major version from "ignore" to "0" for this later
firmware to be correctly detected, and allow the dual-firmware version
support to work.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/wireless/ti/wl18xx/wl18xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wl18xx/wl18xx.h b/drivers/net/wireless/ti/wl18xx/wl18xx.h
index 7fed96d71b27..de6c671c4be6 100644
--- a/drivers/net/wireless/ti/wl18xx/wl18xx.h
+++ b/drivers/net/wireless/ti/wl18xx/wl18xx.h
@@ -13,7 +13,7 @@
 /* minimum FW required for driver */
 #define WL18XX_CHIP_VER		8
 #define WL18XX_IFTYPE_VER	9
-#define WL18XX_MAJOR_VER	WLCORE_FW_VER_IGNORE
+#define WL18XX_MAJOR_VER	0
 #define WL18XX_SUBTYPE_VER	WLCORE_FW_VER_IGNORE
 #define WL18XX_MINOR_VER	58
 
-- 
2.30.2


