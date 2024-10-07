Return-Path: <linux-wireless+bounces-13641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F65993707
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 21:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A61A1C20FDC
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F267D1D9A43;
	Mon,  7 Oct 2024 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Fr/YhSnd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB71DE2C6
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728328477; cv=none; b=nbcxUZYi7CKBjhtnaMDLBgjum7/qGzEhUg1vMnDo5YUHJWGzSyZu9pILqSvt38NQ5+gFigs7UMrqFEeM+JKLjS5H+FFI5G2vft7IVYHMMIJleqnUpbbWv6hs7ofuASafHWYdVMvEhscIZQq5DadB6ANwQA8cu0D2U63TtgNrcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728328477; c=relaxed/simple;
	bh=blrkVRzZFBeIC/bw+QiDu+l00Dw/II3vbodZ9d3/t1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iq61nBF5yE1O7NZdZfYSPpzXmQDzFkqdExx4Q64MtbT1csKyrsd6+onDFXnYGAVlySy36Br+ULKLF5zjhoqUAi1/DUuLSQMs1SZl3igBb2ww8bAJtLY6DN444SGeFvdRO36Yrt37S1nyjEfx7XXcz2yJWysiHqw03CxYNWlTvVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Fr/YhSnd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=+J2+DCeR3UMVRjy1NM5MlXBgt39zCp64Wa9AanJOGVo=; t=1728328476; x=1729538076; 
	b=Fr/YhSndPKGANpyXGGIvl6Nh7nNySUjcxuU5VpW1TWPsu/L0ahytgNfMLcXA14ZZGDmwIZWl4fE
	rsEvX+inga9zQVwSZkzzIxVeiY9xLTy0RJpK2+jwSBiSicsl37P/T6iEPDr+Sv77xJr2NcEtF65nT
	UNH9shoF6zpuCESjnX23MOhF4mk61kLn7KJoiiGiQk44u4+8eo15xjrCyqIoBvea+puppkZ8gUzei
	EYwqdSlL0p4OBsqmD4DbCh0AAxOV+zmWiQlpbrY2eYFe7l0HTHR+z9mzv887B5b5D/fm3JzmOxOPC
	6gfOKipfntBjLe7bA92eMF7GlgseNMPiIq+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxtBh-00000003VJ0-1Yul;
	Mon, 07 Oct 2024 21:14:33 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: cfg80211: stop exporting wext symbols
Date: Mon,  7 Oct 2024 21:14:30 +0200
Message-ID: <20241007211431.8d4a7242ce92.I66ceb885ddfa52c368feeea1ea884bf988c525f2@changeid>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

CFG80211_WEXT_EXPORT is no longer needed, if we only make
ipw2200 return the static name for SIOCGIWNAME itself.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/ipw2x00/Kconfig   |  1 -
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 10 +++++++++-
 net/wireless/Kconfig                         |  9 +--------
 net/wireless/scan.c                          |  2 --
 net/wireless/wext-compat.c                   |  9 ---------
 net/wireless/wext-compat.h                   |  6 ------
 6 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/Kconfig b/drivers/net/wireless/intel/ipw2x00/Kconfig
index ce34118f1e90..5e98be664d38 100644
--- a/drivers/net/wireless/intel/ipw2x00/Kconfig
+++ b/drivers/net/wireless/intel/ipw2x00/Kconfig
@@ -65,7 +65,6 @@ config IPW2100_DEBUG
 config IPW2200
 	tristate "Intel PRO/Wireless 2200BG and 2915ABG Network Connection"
 	depends on PCI && CFG80211
-	select CFG80211_WEXT_EXPORT
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	select FW_LOADER
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 0008b4615731..c0e9d2109e34 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -6463,6 +6463,14 @@ static int ipw_set_rsn_capa(struct ipw_priv *priv,
  * WE-18 support
  */
 
+static int ipw_wx_get_name(struct net_device *dev,
+			   struct iw_request_info *info,
+			   union iwreq_data *wrqu, char *extra)
+{
+	strcpy(wrqu->name, "IEEE 802.11");
+	return 0;
+}
+
 /* SIOCSIWGENIE */
 static int ipw_wx_set_genie(struct net_device *dev,
 			    struct iw_request_info *info,
@@ -9826,7 +9834,7 @@ static int ipw_wx_sw_reset(struct net_device *dev,
 
 /* Rebase the WE IOCTLs to zero for the handler array */
 static iw_handler ipw_wx_handlers[] = {
-	IW_HANDLER(SIOCGIWNAME, cfg80211_wext_giwname),
+	IW_HANDLER(SIOCGIWNAME, ipw_wx_get_name),
 	IW_HANDLER(SIOCSIWFREQ, ipw_wx_set_freq),
 	IW_HANDLER(SIOCGIWFREQ, ipw_wx_get_freq),
 	IW_HANDLER(SIOCSIWMODE, ipw_wx_set_mode),
diff --git a/net/wireless/Kconfig b/net/wireless/Kconfig
index 8c8bd8b75708..2d67b5f2010e 100644
--- a/net/wireless/Kconfig
+++ b/net/wireless/Kconfig
@@ -185,19 +185,12 @@ config CFG80211_CRDA_SUPPORT
 	  If unsure, say Y.
 
 config CFG80211_WEXT
-	bool "cfg80211 wireless extensions compatibility" if !CFG80211_WEXT_EXPORT
+	bool "cfg80211 wireless extensions compatibility"
 	select WEXT_CORE
-	default y if CFG80211_WEXT_EXPORT
 	help
 	  Enable this option if you need old userspace for wireless
 	  extensions with cfg80211-based drivers.
 
-config CFG80211_WEXT_EXPORT
-	bool
-	help
-	  Drivers should select this option if they require cfg80211's
-	  wext compatibility symbols to be exported.
-
 config CFG80211_KUNIT_TEST
 	tristate "KUnit tests for cfg80211" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 59a90bf3c0d6..8ba618f4734f 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3594,7 +3594,6 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 	kfree(creq);
 	return err;
 }
-EXPORT_WEXT_HANDLER(cfg80211_wext_siwscan);
 
 static char *ieee80211_scan_add_ies(struct iw_request_info *info,
 				    const struct cfg80211_bss_ies *ies,
@@ -3966,5 +3965,4 @@ int cfg80211_wext_giwscan(struct net_device *dev,
 
 	return res;
 }
-EXPORT_WEXT_HANDLER(cfg80211_wext_giwscan);
 #endif
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 2371069f3c43..def4ce063d68 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -30,7 +30,6 @@ int cfg80211_wext_giwname(struct net_device *dev,
 	strcpy(wrqu->name, "IEEE 802.11");
 	return 0;
 }
-EXPORT_WEXT_HANDLER(cfg80211_wext_giwname);
 
 int cfg80211_wext_siwmode(struct net_device *dev, struct iw_request_info *info,
 			  union iwreq_data *wrqu, char *extra)
@@ -69,7 +68,6 @@ int cfg80211_wext_siwmode(struct net_device *dev, struct iw_request_info *info,
 
 	return ret;
 }
-EXPORT_WEXT_HANDLER(cfg80211_wext_siwmode);
 
 int cfg80211_wext_giwmode(struct net_device *dev, struct iw_request_info *info,
 			  union iwreq_data *wrqu, char *extra)
@@ -105,7 +103,6 @@ int cfg80211_wext_giwmode(struct net_device *dev, struct iw_request_info *info,
 	}
 	return 0;
 }
-EXPORT_WEXT_HANDLER(cfg80211_wext_giwmode);
 
 
 int cfg80211_wext_giwrange(struct net_device *dev,
@@ -220,7 +217,6 @@ int cfg80211_wext_giwrange(struct net_device *dev,
 
 	return 0;
 }
-EXPORT_WEXT_HANDLER(cfg80211_wext_giwrange);
 
 
 /**
@@ -281,7 +277,6 @@ int cfg80211_wext_siwrts(struct net_device *dev,
 	wiphy_unlock(&rdev->wiphy);
 	return err;
 }
-EXPORT_WEXT_HANDLER(cfg80211_wext_siwrts);
 
 int cfg80211_wext_giwrts(struct net_device *dev,
 			 struct iw_request_info *info,
@@ -296,7 +291,6 @@ int cfg80211_wext_giwrts(struct net_device *dev,
 
 	return 0;
 }
-EXPORT_WEXT_HANDLER(cfg80211_wext_giwrts);
 
 int cfg80211_wext_siwfrag(struct net_device *dev,
 			  struct iw_request_info *info,
@@ -327,7 +321,6 @@ int cfg80211_wext_siwfrag(struct net_device *dev,
 
 	return err;
 }
-EXPORT_WEXT_HANDLER(cfg80211_wext_siwfrag);
 
 int cfg80211_wext_giwfrag(struct net_device *dev,
 			  struct iw_request_info *info,
@@ -342,7 +335,6 @@ int cfg80211_wext_giwfrag(struct net_device *dev,
 
 	return 0;
 }
-EXPORT_WEXT_HANDLER(cfg80211_wext_giwfrag);
 
 static int cfg80211_wext_siwretry(struct net_device *dev,
 				  struct iw_request_info *info,
@@ -413,7 +405,6 @@ int cfg80211_wext_giwretry(struct net_device *dev,
 
 	return 0;
 }
-EXPORT_WEXT_HANDLER(cfg80211_wext_giwretry);
 
 static int cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 				   struct net_device *dev, bool pairwise,
diff --git a/net/wireless/wext-compat.h b/net/wireless/wext-compat.h
index c02eb789e676..8251ca5df8ae 100644
--- a/net/wireless/wext-compat.h
+++ b/net/wireless/wext-compat.h
@@ -5,12 +5,6 @@
 #include <net/iw_handler.h>
 #include <linux/wireless.h>
 
-#ifdef CONFIG_CFG80211_WEXT_EXPORT
-#define EXPORT_WEXT_HANDLER(h) EXPORT_SYMBOL_GPL(h)
-#else
-#define EXPORT_WEXT_HANDLER(h)
-#endif /* CONFIG_CFG80211_WEXT_EXPORT */
-
 int cfg80211_ibss_wext_siwfreq(struct net_device *dev,
 			       struct iw_request_info *info,
 			       struct iw_freq *wextfreq, char *extra);
-- 
2.46.2


