Return-Path: <linux-wireless+bounces-27573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC7FB8F398
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 09:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA3D3BC9B6
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9604221FCC;
	Mon, 22 Sep 2025 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SHWpZ4yx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD792F2914
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525058; cv=none; b=pYjAxvQJYCsiEUAtlxqDRz9Ghac1v56nMyhKwt2f5o+7orKOMTjQpIvtPuy2emtER7ucuoNSjy1Pxz1KJtQQQdPfqHLG2+NMGxTRc+gtLV6fBtNFJaLa7vjE7gHDEW0OIDPX4XCLuGs26G+cE18pb3aIxePJLgiMWYqElbKi8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525058; c=relaxed/simple;
	bh=bD33Q01ZQKDucVl6IJjE+WAbM2BPQQCytAe5dVOJ4Ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICYhwxOu3sYs3F6G2EbuNZMuQHRSSCeAnE1RlcC6ViNK9rBVqJiDLCvvJwqw9j5Y2YABKTRPm3OtgFYq+kOXbGyBMgFdklHFo3ubvsMtnjEDvEMLOZJjJ6Zjq90v88SdkjOQ2QIer7xbWQR0a2n2qtuIJkK5dDrflANpY26y72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SHWpZ4yx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58M7AcDZ24015240, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758525038; bh=JAjUfSgTAsPsk2+PlfL5VPu72GNHI9YtFa90yQ5RQXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SHWpZ4yxQaLyyNyiYvVaQW8RLTZKLUZ4wh6SjDjBka54adFMXqN/Gfc+X/DmumNKg
	 fgAwxD3jXs49flvvWtyYPVXwsYwtJki8QI2IF9/lj4Z+kMAqwEfaF4YRdAfNjh9yRo
	 3MNmkEcIVP1etWAtVLXr4VbIX/AitfRITjz+fJ554uyrFCfykuTvRsRf0H4Cg7wc7d
	 9kP4sHUvKQjdBcwP09eGhfn3DLgbR+02dfWBFB5zQJatsNugTo2Vmpy2N7H3cRNeMG
	 Ji2lS9BhKVbDXxxbCAyDTdyfYmI0vx2qgBbuQdJVGpGxGGxiQbssEA3PbvbfH+suuM
	 8aja1SlIMk3WQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58M7AcDZ24015240
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 15:10:38 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 22 Sep 2025 15:10:39 +0800
Received: from kevin-ThinkPad-T430s.realtek.com.tw (172.21.69.104) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Sep 2025 15:10:38 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <raja.mani@oss.qualcomm.com>
Subject: [PATCH v3 4/4] iw: bitrate: support link id
Date: Mon, 22 Sep 2025 15:10:17 +0800
Message-ID: <20250922071017.11954-5-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20250922071017.11954-1-kevin_yang@realtek.com>
References: <20250922071017.11954-1-kevin_yang@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

For MLD, support to assign link-id field. For non-MLD, just as before,
no need to assign it. If going to assign link-id field, need to place
it at the beginning of argv (i.e. right after "set bitrates").

	set bitrates [link-id <LINK ID>] ...

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
---
v3: place link-id field at the beginning of argv
v2: based on newly added parse_link_id() and add help text
---
 bitrate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitrate.c b/bitrate.c
index 16f118cce4ec..4ed7f2a42f14 100644
--- a/bitrate.c
+++ b/bitrate.c
@@ -618,9 +618,16 @@ static int handle_bitrates(struct nl80211_state *state,
 			   int argc, char **argv,
 			   enum id_input id)
 {
+	int ret;
+
+	ret = parse_link_id(msg, &argc, &argv);
+	if (ret)
+		return ret;
+
 	return set_bitrates(msg, argc, argv, NL80211_ATTR_TX_RATES);
 }
 
+#define DESCR_MLO "[link-id <LINK ID>] "
 #define DESCR_LEGACY "[legacy-<2.4|5> <legacy rate in Mbps>*]"
 #define DESCR_HT " [ht-mcs-<2.4|5> <MCS index>*]"
 #define DESCR_VHT " [vht-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*]"
@@ -630,6 +637,7 @@ static int handle_bitrates(struct nl80211_state *state,
 #define DESCR_LTF " [he-ltf-<2.4|5|6> <1|2|4>] [eht-ltf-<2.4|5|6> <1|2|4|6|8>]"
 
 #define DESCR \
+	DESCR_MLO \
 	DESCR_LEGACY \
 	DESCR_HT \
 	DESCR_VHT \
-- 
2.39.0


