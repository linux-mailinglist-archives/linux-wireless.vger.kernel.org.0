Return-Path: <linux-wireless+bounces-8178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E119D8D171B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB2B1C22E98
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915DE13E3E4;
	Tue, 28 May 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0j++Yg4X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3D13D880;
	Tue, 28 May 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887889; cv=none; b=YWczj3uRAGho9szdEJHwT7meqnBFSAyA+Mvx4WdIGj9WnptZSPzI/RR/55+rlOzMYdY2v9SUVmKw+qMggylWisO49QG/vgxvnTsRZcI/XbBxKsmRSCK0CEoSnuPWLrqE/U7+EDZjkPFbGRg5IzIFcIG3A0SAddi/IClJyULQ/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887889; c=relaxed/simple;
	bh=x1k4gsqI+QHKZYqcjtRet4AtaX2EO5HGhcwTJVyOrA8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=fSTteYFzjxNBTLt5QxjRNOyLGj++EvG8Yzimc0YpLhoLFbeSGLDdvFbOm2UV2uDqIyvPSRlv7JJPmk7+GhNz39I/Vl3Thv5aoWl80aImL4SpSrA6R+XgQ/li/O2inWAQ1JwSAtzrTvnTqEUWNGQGOCXOblPWheKQuAeKJORiyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0j++Yg4X; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UhjKQTZ4N5nNFgPTwE1YDpUmEfTGwnyBm7+TW+XXveY=; b=0j++Yg4X0Uc54LA0/icRYLrayu
	gpl3/s6FkxMROSylQSv7C5dJ+GwWcgOfOFn0stvpGjymKAeoYWTNXnzMdonC9POeyJbYr+8nKuDsU
	PB8TKd9YJnzh3CU+mRhtVQo4OtZAFcfxU/lMpK58Yxkfem6DfXjz01mL4SgP5bhAydPXE3erKYBIi
	3veBYti41cPd3KUw5dOofHo3BIWdjgs1CqAaa6qbqdpez56yRh+YQR5ZwxRcLskznZtwGWYXs+YWQ
	dKElDZhYEHUcFI2EkCK5L5snvN++HJTirdvje0FiGE8b3Jbgv3xv4Qo5q62DLXIc9Z2JCa2K6hcrT
	BjQMenCg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43032 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sBsy0-0004Y8-0A;
	Tue, 28 May 2024 10:18:00 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sBsy2-00E8vo-KK; Tue, 28 May 2024 10:18:02 +0100
In-Reply-To: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	 Michael Nemanov <michael.nemanov@ti.com>,
	 linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 5/8] wifi: wlcore: store AP encryption key type
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sBsy2-00E8vo-KK@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 10:18:02 +0100

Updates for WL18xx firmware 8.9.1.x.x need to know the AP encryption
key type. Store this when a new key is set. Patch extracted from:

https://git.ti.com/cgit/wilink8-wlan/build-utilites/tree/patches/kernel_patches/4.19.38/0023-wlcore-Fixing-PN-drift-on-encrypted-link-after-recov.patch?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/wireless/ti/wlcore/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 3defe49c5120..8f82666f379c 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -3537,6 +3537,10 @@ int wlcore_set_key(struct wl1271 *wl, enum set_key_cmd cmd,
 			return ret;
 		}
 
+		/* Store AP encryption key type */
+		if (wlvif->bss_type == BSS_TYPE_AP_BSS)
+			wlvif->encryption_type = key_type;
+
 		/*
 		 * reconfiguring arp response if the unicast (or common)
 		 * encryption key type was changed
-- 
2.30.2


