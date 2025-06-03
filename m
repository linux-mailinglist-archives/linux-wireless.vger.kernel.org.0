Return-Path: <linux-wireless+bounces-23547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0384ACC465
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 12:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77131892C68
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A257D221DAE;
	Tue,  3 Jun 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="CViFD/tl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CEF1F5434
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946898; cv=none; b=BiZWCpglRMqzEd8ia16bZsOLlg8Z74eqjfzxzeWysb7KVgXcZcXsMEbO/6Z6LVL43Q8SXisigDeN+bGimjnHpkCfgxu5AFqZjZLWL+KKGeuFnq/2qCciH5lsNPuHvY0FS7DIEaBbbHTvFzs0cyufRSBJ2h0OmGtdQL/3XTbwXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946898; c=relaxed/simple;
	bh=LtFNAnv1fhSgfREEeWt2GJCgNDECYHE0AT3Z2T+3m4c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QtkNfhiCdBnT4clBpL52voBBMlEZRtSstc4z5edu86PNa6JHWgHQWKropuAyBu4j0Bpa8zffGq73mSd5kTm815lx1n7hoQ4vXHJII72lUqcnqCoy/mUlrzvCtJ5tVQqsjQ24RNB6uTjgHoMCwdLN+uVyWG9K+uupEeGWJuyDJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=CViFD/tl; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1748946897; x=1780482897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LtFNAnv1fhSgfREEeWt2GJCgNDECYHE0AT3Z2T+3m4c=;
  b=CViFD/tl0SscHel709ZGqBVTOsgeI6DLcFUFK0kdZ36aIdEJS1pXq2K1
   414KIktLvW3TFo6PYLJ5T/wY74vT96Vdel0xGGhL+zkyBmNpwXjDYNhs0
   s9k3j25daa1OLXlXhaupzY0Fl281BJ3yrsTM1y+W+zZAt2T6w/FqNNtS6
   Y=;
X-CSE-ConnectionGUID: ADY58vFpQGO7WFfrIIsHwA==
X-CSE-MsgGUID: QfbC4Bo5Tma8rbjZfRlc7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="53472925"
X-IronPort-AV: E=Sophos;i="6.16,205,1744063200"; 
   d="scan'208";a="53472925"
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 12:33:46 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 12:33:45 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 12:33:43 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 0/5] wifi: cfg80211: Add support to indicate changed AP BSS parameters to drivers
Date: Tue, 3 Jun 2025 16:02:47 +0530
Message-ID: <20250603103252.18039-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
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

v1:
 - brcmfmac: support AP isolation to restrict reachability between stations
   Link: https://lore.kernel.org/linux-wireless/20250423175125.7233-1-gokulkumar.sivakumar@infineon.com/


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

 drivers/net/wireless/ath/wil6210/cfg80211.c   |  7 +++
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 47 +++++++++++++++++++
 .../wireless/microchip/wilc1000/cfg80211.c    |  6 +++
 include/net/cfg80211.h                        | 30 ++++++++++++
 net/mac80211/cfg.c                            | 14 ++++++
 net/wireless/nl80211.c                        | 28 +++++++++--
 6 files changed, 127 insertions(+), 5 deletions(-)

-- 
2.47.0


