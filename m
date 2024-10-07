Return-Path: <linux-wireless+bounces-13606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF86992F88
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 16:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8821C22AFA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3A41D47BD;
	Mon,  7 Oct 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="a5levdGk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A40F50F
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311909; cv=none; b=p7tvZ8Ljsv5BR1zdrAAC+epi0iYyim4IZNFVKLvzpInQxyuClQyUXflwQ7K6k6o8gJ77lsOKn/aBjVt2Mmv6ldnPIcvnEWFZbyqohza77wjC7Vdrgb/B/XG37oTMLfHaSyI3gj4ugiVqLy/IWGbCBGcKDyrm1MFzfcmNNFnZ1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311909; c=relaxed/simple;
	bh=UFsbITkKd7J4TQOYiYeGzXBIFFAqeeUu6h1L84BXNJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TuPl87wzit5b0P+WA1dybXPHY0kmkN5M0BtsZ9o8AlkUofmuK+2zwRiqgltHO/+6bG44UzkP1u0moo41UQaG1H/4Pa2miRHMQTG0P3ve65FvR2A3xY1YY7LdZnZrrnBWoqJZnX38esXEBLeo/K+eyuRsI61jWX3cPUX8uiTrD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=a5levdGk; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1728311908; x=1759847908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UFsbITkKd7J4TQOYiYeGzXBIFFAqeeUu6h1L84BXNJY=;
  b=a5levdGkcDbes5hSrzAC1O2/NDk2CH0xCRwdogVGf8+4MxXOb5Zj9RmH
   901xLMpfoLY+IRTDmDwN7hYEw8TumwI/6EmmN1oJguNHAoIoD7fWm1slz
   eumO5/nvdkRwj+/NvglxK7FaEkoF2dEK1+cVJNxsbxfWW1+gvG3gDm3Uy
   o=;
X-CSE-ConnectionGUID: 8JAL8242QLGJa1RkXKteqg==
X-CSE-MsgGUID: Vp/12qECSlWVOobXVg85Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="89802420"
X-IronPort-AV: E=Sophos;i="6.11,184,1725314400"; 
   d="scan'208";a="89802420"
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:37:17 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 7 Oct
 2024 16:37:16 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 7 Oct 2024 16:37:14 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Kalle Valo <kvalo@kernel.org>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <Vinoth.Sampath@infineon.com>,
	<Syed.Hussain@infineon.com>, <Double.Lo@infineon.com>,
	<Carter.Chen@infineon.com>, <wlan-kernel-dev-list@infineon.com>,
	<brcm80211@lists.linux.dev>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] MAINTAINERS: wifi: brcm80211: add Infineon DEV list for communication & maintenance
Date: Mon, 7 Oct 2024 20:06:42 +0530
Message-ID: <20241007143642.112942-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE815.infineon.com (172.23.29.41) To
 MUCSE827.infineon.com (172.23.29.20)


The Infineon E-Mail distribution list <wlan-kernel-dev-list@infineon.com>
is a replacement for the obsolete list <SHA-cyfmac-dev-list@infineon.com>,
which got removed from the BRCM80211 section in the MAINTAINERS file.

The new distribution list can be used by the community to contact Infineon
WLAN Kernel DEV team, and also for Infineon team to get notified with the
activity in the upstream kernel brcm80211 subsystem.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77fcd6f802a5..adfbf5af9eb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4475,6 +4475,7 @@ M:	Arend van Spriel <arend.vanspriel@broadcom.com>
 L:	linux-wireless@vger.kernel.org
 L:	brcm80211@lists.linux.dev
 L:	brcm80211-dev-list.pdl@broadcom.com
+L:	wlan-kernel-dev-list@infineon.com
 S:	Supported
 F:	drivers/net/wireless/broadcom/brcm80211/
 F:	include/linux/platform_data/brcmfmac.h
-- 
2.34.1


