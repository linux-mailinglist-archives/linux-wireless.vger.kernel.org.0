Return-Path: <linux-wireless+bounces-23568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA89ACCB0C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 18:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3E13A89A6
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAC923E325;
	Tue,  3 Jun 2025 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="FRGsZm8N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5311423C8D6
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967159; cv=none; b=ORDGYWn2YSCW281To7zyI9JEFSyRi5rZiPj8efQG8IodPkunWXXIoOuYetlpq/FHNKxL4V3rL1hGlSb++3footMX04cQzDem9kA56tTSgBAxcnWe2pDrgWPU/NjwZI0i23JtRuRCPb/xzUv+Yqj8db5O41ocUxmhMafiYbYdomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967159; c=relaxed/simple;
	bh=3PiEDIYHtCQ+1wMROHydqx0LPGdXprXodMC6eeRYosc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hyr47XO9p0WaPth0kVAabGPdanyaHXK9C6aPW489oeKhBPHjtSpLHQIn/+iUtgpjOZWRsaBvGY1IX2ZMWjhnqd91Xof8UqmYWHITYIhJtB52ztYc9tCHxjJf9gdYAY6JKytOxHdYdKn7QjS/6L47Za0qGtoq2PUbM1BubpS8jxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=FRGsZm8N; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1748967158; x=1780503158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3PiEDIYHtCQ+1wMROHydqx0LPGdXprXodMC6eeRYosc=;
  b=FRGsZm8NvxpB+f+wsRW8VTK3NDD4CwmEVN6QUI3DAdOdL4WoLYj5bNwF
   oEhR982eme0GPhKN+Rfcq7hqHlELUUhxWdNIj/6apqdD88ZO0qwPxvNeA
   xJxhGM98RJ9RV1aG+gGpT9/gOdNZimvV0X1QF9MuEAo7UTZhqekRDDdKI
   4=;
X-CSE-ConnectionGUID: PPYX4LKRQ4yXcUVFbo6WYQ==
X-CSE-MsgGUID: estYr/e6Rsyx45F695w9aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="97700322"
X-IronPort-AV: E=Sophos;i="6.16,206,1744063200"; 
   d="scan'208";a="97700322"
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:11:23 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 18:11:22 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 18:11:20 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v3 0/5] wifi: cfg80211: Add support to indicate changed AP BSS parameters to drivers
Date: Tue, 3 Jun 2025 21:40:52 +0530
Message-ID: <20250603161057.19101-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE817.infineon.com (172.23.29.43) To
 MUCSE827.infineon.com (172.23.29.20)

In cfg80211, added provision for the drivers which registers the callback 
.change_bss() cfg80211_ops, to find which set of AP BSS params are changed
by the userpsace in the SET_BSS operation. With this the drivers can decide
to reject the operation if any of the changed AP BSS param is not supported
for explicit configuration. This helps ensuring that the driver does not
partially handle the AP BSS params and avoid misleading the userspace that
the SET_BSS operation is fully successful.

Also introduced the "changed" bitmask check in all the drivers that are
currently registering to .change_bss() cfg80211_ops. This would make the
condition for handling SET_BSS operation equally stirct across all drivers.

CHANGE LOG:
v3:
 - In drivers, added individual check for the CFG80211_BSS_PARAM_CHANGED_*
   flag before handling the corresponding AP BSS param from the userspace.
   This avoids the case where driver unnecessarily checks the value of
   all the supported AP BSS params, even if the userspace did not pass some
   of those params in the SET_BSS request. This addresses a review comment.
   Link: https://lore.kernel.org/linux-wireless/5095079184a282ae552c50c8c121a632d51b0419.camel@sipsolutions.net/

v2:
 - Rephrased the subject line for this v2 patchset cover letter to include
   new changes introduced for addressing review comments. Kindly refer the
   below mentioned v1 section for the reference to the previously submitted
   patch Link.

 - cfg80211: in a new patch in v2, introduced the "changed" bitmask for
   AP BSS parameters as suggested in Johannes's review comment in v1 patch.
   Link: https://lore.kernel.org/linux-wireless/29fa5ea7f4cc177bed823ec3489d610e1d69a08f.camel@sipsolutions.net/

 - brcmfmac & wil6210: added "changed" bitmask check for the supported
   "ap_isolate" param and reject the entire SET_BSS operation if the
   userspace passes any other unsupported AP BSS parameter.

 - brcmfmac: added changes to get the current "ap_isolate" param value from
   firmware before attempting to set the new value from userspace. If the
   new value is already set, skip this operation.

 - wilc1000: in a new patch in v2, added "changed" bitmask check for the
   SET_BSS operation, and return -EOPNOTSUPP instead of 0, if the userspace
   attempts to change any AP BSS param. This helps to avoid misleading the
   userspace that the operation is fully successful.

 - mac80211: in a new patch in v2, added "changed" bitmask check for the
   supported AP BSS params, and return -EOPNOTSUPP if any unsupported
   param is set by the userspace.
 
 - Link: https://lore.kernel.org/linux-wireless/20250603103252.18039-2-gokulkumar.sivakumar@infineon.com/

v1:
 - brcmfmac: support AP isolation to restrict reachability between stations

 - Link: https://lore.kernel.org/linux-wireless/20250423175125.7233-1-gokulkumar.sivakumar@infineon.com/


Gokul Sivakumar (4):
  wifi: cfg80211: Add support to indicate changed AP BSS parameters to
    driver
  wifi: wil6210: reject SET_BSS if any changed AP BSS param is not
    supported
  wifi: wilc1000: reject SET_BSS if any changed AP BSS param is not
    supported
  wifi: mac80211: reject SET_BSS if any changed AP BSS param is not
    supported

Wright Feng (1):
  wifi: brcmfmac: support AP isolation to restrict reachability between
    stations

 drivers/net/wireless/ath/wil6210/cfg80211.c   | 10 +++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 47 ++++++++++++++++
 .../wireless/microchip/wilc1000/cfg80211.c    |  6 +++
 include/net/cfg80211.h                        | 30 +++++++++++
 net/mac80211/cfg.c                            | 54 +++++++++++++------
 net/wireless/nl80211.c                        | 28 ++++++++--
 6 files changed, 154 insertions(+), 21 deletions(-)

-- 
2.47.0


