Return-Path: <linux-wireless+bounces-35454-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFGWERh98GlSUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35454-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:25:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DF1481572
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B517305E713
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1103D813F;
	Tue, 28 Apr 2026 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XCjLWOje"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15C33D8135
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367363; cv=none; b=RmdCotemU99selLvihEAix/o1U+fpGOruLOV4G1Q407DsXxwOcQ8RulWO5AHPBlQZkKlDVprSJlbeCUTH70HD6O3caXiaD1n5pv5oAo5GFzlzAItOJK/yOxpyL0OC+einu5g2B8RF7lixPGqM2NEddevjew8BH2gRDjrfS0UYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367363; c=relaxed/simple;
	bh=8GAPvAvgo+bqbCaoU40BfsVzI11nHN+kUupNYXsF7LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrvwR9eS3rAPAYv/saXbjJ2r5qaGcMvFn8Qg40a+Zv6V3x11R5XTOV0DcN0vqzorebrFJxfk1AX13SoigEboFKwQ9Yq0E/e8iMMGypRdFZnroudaOp9SoxvS4UiVzQDSTuZXfOxHayEECeGnWFLOvtOYJ7leuI9IePpd04L61g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XCjLWOje; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mOlvqH9E3OYlE5qC1fCSzo9YMoyc9saUMKfAlef90Gw=;
	t=1777367361; x=1778576961; b=XCjLWOje4fEkYbtdlWWl4t6X2BiWCACmrh+gjCyTY/O+mvN
	orzae1skNjihmJI82BPxiKAKPfynvZGzipSFwfAcqjpx1ZrAHYIQACKfrnUI//5S12x3kyUh9Ja1J
	QtIZvql3cPLvEboFYiHmFq3cyBDetphoRrtoka6Z3HZ/bdALPQjt0Jmv/2FGlXZ0emt70lD/QfftC
	fMIuaau6sehyboP/gz5+S/wrMGTqoTuwJGujXxCI/x6RH3DWEzprx/PatczkAXecrRiZIWdU2DkWr
	FvO5vNckCGxLbNnbcg5TMsUaZW4PVTN06JSH9UEauA26Zpzr2IMRR1vvqst484Xw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeRT-0000000HGH2-1rsm;
	Tue, 28 Apr 2026 11:09:19 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 1/5] wifi: ieee80211: define UHR ML-PM extended MLD capability
Date: Tue, 28 Apr 2026 11:06:56 +0200
Message-ID: <20260428110915.c6b6a06016cf.I7ebd97397507d320124547017e21191b55c5d34d@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428090915.54717-7-johannes@sipsolutions.net>
References: <20260428090915.54717-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 49DF1481572
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35454-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]

From: Johannes Berg <johannes.berg@intel.com>

UHR defines bit 8 to mean multi-link power management, add
a definition for it. Also reindent the other definitions to
use tabs, not spaces.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211-eht.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index 335e78bd4b5d..87d92fb86fab 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -9,7 +9,7 @@
  * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
  * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (c) 2018 - 2025 Intel Corporation
+ * Copyright (c) 2018 - 2026 Intel Corporation
  */
 
 #ifndef LINUX_IEEE80211_EHT_H
@@ -750,11 +750,13 @@ static inline u16 ieee80211_mle_get_mld_capa_op(const u8 *data)
 }
 
 /* Defined in Figure 9-1074t in P802.11be_D7.0 */
-#define IEEE80211_EHT_ML_EXT_MLD_CAPA_OP_PARAM_UPDATE           0x0001
-#define IEEE80211_EHT_ML_EXT_MLD_CAPA_OP_RECO_MAX_LINKS_MASK    0x001e
-#define IEEE80211_EHT_ML_EXT_MLD_CAPA_NSTR_UPDATE               0x0020
-#define IEEE80211_EHT_ML_EXT_MLD_CAPA_EMLSR_ENA_ON_ONE_LINK     0x0040
-#define IEEE80211_EHT_ML_EXT_MLD_CAPA_BTM_MLD_RECO_MULTI_AP     0x0080
+#define IEEE80211_EHT_ML_EXT_MLD_CAPA_OP_PARAM_UPDATE		0x0001
+#define IEEE80211_EHT_ML_EXT_MLD_CAPA_OP_RECO_MAX_LINKS_MASK	0x001e
+#define IEEE80211_EHT_ML_EXT_MLD_CAPA_NSTR_UPDATE		0x0020
+#define IEEE80211_EHT_ML_EXT_MLD_CAPA_EMLSR_ENA_ON_ONE_LINK	0x0040
+#define IEEE80211_EHT_ML_EXT_MLD_CAPA_BTM_MLD_RECO_MULTI_AP	0x0080
+/* defined by UHR Draft P802.11bn_D1.3 Figure 9-1147 */
+#define IEEE80211_UHR_ML_EXT_MLD_CAPA_ML_PM			0x0100
 
 /**
  * ieee80211_mle_get_ext_mld_capa_op - returns the extended MLD capabilities
-- 
2.53.0


