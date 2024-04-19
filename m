Return-Path: <linux-wireless+bounces-6559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9F08AA8A6
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 08:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ACBB1F214AE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 06:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31AF37168;
	Fri, 19 Apr 2024 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="m1esG93l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E079F9
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509519; cv=none; b=gMQ7r3yhfJhfbGsyPy0n8029v2kdscVYPi6YSHIidiEM5EC5fjLJnrAMjudPTaYxQ4hfYgyFc0cZWllrRay3+dUhFOSJE6bZ3vxfNbaicDx9A9H3Rhyc5hsGh+bPe/0vp6z516Abn9rYRTu8xP1L0T7Q7QdiTOM2MbDOU3siTnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509519; c=relaxed/simple;
	bh=03lI0Ly3upmowqWTIwWWZJZyfLiDT2RZo87ZoGOVN2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pd/14gI19f1GFkr5KKrr/pQBCbfTsnfmDy3hnh6WfdPDDv7aQSD1qeg07JIGHppWgxrUGI+zTugxgqAVwlcKXIk8XP5U0+TyZlsb2Rxz5QU5Eo3fdgE+63hvOoVkghXhjaZD96lTszxJJOIHuazzemr/+Lx3aEaz4lXYccqnZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=m1esG93l; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=OoBWeQwQ6jUbDeoHnpMsWidxSQjy5qN1LeZvtgEdDME=; t=1713509516; x=1714719116; 
	b=m1esG93lpSXJxgYe/ZiLvQiFq1vhAcsbdtdjE4AKz6GRZpaLlK6mh86n0ZTDVIVzJ0y/co+WEG3
	RPxcxmUD8p3qFeoAQSNApUi1r3O2XwePbmoYrfbIvjl9pMORBmD7GweOWxZfPng7XIvB31qvgie/y
	aL49FQ/J1r+THC7Nl4DTgmC0C5gA1CE/bWUxHncvBEk137Q98DaPoW+zbI5d7IeXaWKUkz6I/JBUC
	2cCecbClw4sf4Sehz3RUowhRa4VF0bTh4TV2vv94axuBTNKTaG4nSfivdIUv7dxBfO2ot3iwtYdxI
	wpLsdYsA1gHZVWKsEICp2XKEf05VRdV8LTSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rxi6A-0000000Dqcj-1BP2;
	Fri, 19 Apr 2024 08:51:50 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] Revert "wifi: iwlwifi: bump FW API to 90 for BZ/SC devices"
Date: Fri, 19 Apr 2024 08:51:47 +0200
Message-ID: <20240419085147.cd756fadab03.Ibccbb65be8e05b516cae1b9fb27a959662f9f51a@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Revert the API version bump, the kernel doesn't actually have
all the code to deal with that version yet.

Fixes: 653a90f6b226 ("wifi: iwlwifi: bump FW API to 90 for BZ/SC devices")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 072b0a5827d1..eca1457caa0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	90
+#define IWL_BZ_UCODE_API_MAX	89
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	80
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 9b79279fd76c..dbbcb2d0968c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	90
+#define IWL_SC_UCODE_API_MAX	89
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	82
-- 
2.44.0


