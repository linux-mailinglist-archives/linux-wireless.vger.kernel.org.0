Return-Path: <linux-wireless+bounces-27427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFCEB7C4CB
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B9417916B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 05:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2194F269D18;
	Wed, 17 Sep 2025 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DZEuPFPY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C827D770
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088579; cv=none; b=YUcQHbcIfwfDopMg1wzhaPbIDaaCpZoQWU3dFCbgU2JZOJQo9yUL+lVoKJX4IoePab+pxCbGkBMFN9QlgkhIkqmIu3WpgYfFjW8CiLs81nTHNZBuMzV5ht+55Uwmj6DtbuKx8aRyKfpXS3tecMsxmzXc/XPKmeDgcIK2Dm9cCwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088579; c=relaxed/simple;
	bh=DxKukQFq/ZQC/mxP1RrMMVfdKmqbYXwoNfHcQg5W7es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odsUnKjPSuQhVm9Z8cHhoMobUg+JH7e5xLadH8mCjdR7awJKJhCPL5IKoowge5MoQQvAI3H6SalsYYaGt6ZjYmQSKEd2OLtegfboC/EbgHl+X9CXlZtynIZveLWOa0pkcRdShma+vA8ETFScQcAcXRFxvwRjTtvmyiQxtt0dhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DZEuPFPY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58H5u1Cz93954276, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758088561; bh=LONM7qK2eu2W3fUj3ApLMOfTs/CrnpFm4yqMBoeBw1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DZEuPFPYyJnDCs8HOmv/NOWdbghMjgsjvynrgIySS45Or5JJ7PABuF34RlKnMG/bB
	 kyJFA0on5bTDPyyBBaDEe5z6bzGsx9hkj5SPNF9Dn+EcD/+JcrFbRIBZSmgAjSFApZ
	 BGnE9ib09u3EijieKWETNZA4q1BbmbXbl+kgasSMUTSYLC93STtOkbfhFclfY292S4
	 GqvF7liqWF7lUtFwHlInuN6TVQmrdkR41IKc34Nms8OKCVZwEJjLwi6jqbl02Hi2G/
	 iRMKzhinJkfrehS89x9tI8VQ9ldPcfVJ9I12pEjMWgiCKEhWYZHKezc4zepgHhI3OB
	 LuvGcyEAhKJMQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58H5u1Cz93954276
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:56:01 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 17 Sep 2025 13:56:01 +0800
Received: from kevin-ThinkPad-T430s.realtek.com.tw (172.21.69.104) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Sep 2025 13:56:01 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <raja.mani@oss.qualcomm.com>
Subject: [PATCH v2 6/6] iw: bitrate: support link id
Date: Wed, 17 Sep 2025 13:55:43 +0800
Message-ID: <20250917055543.27499-7-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20250917055543.27499-1-kevin_yang@realtek.com>
References: <20250917055543.27499-1-kevin_yang@realtek.com>
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
no need to assign it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
---
v2: based on newly added parse_link_id() and add help text
---
 bitrate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitrate.c b/bitrate.c
index 16f118cce4ec..144faeac88be 100644
--- a/bitrate.c
+++ b/bitrate.c
@@ -618,6 +618,12 @@ static int handle_bitrates(struct nl80211_state *state,
 			   int argc, char **argv,
 			   enum id_input id)
 {
+	int ret;
+
+	ret = parse_link_id(msg, &argc, argv);
+	if (ret)
+		return ret;
+
 	return set_bitrates(msg, argc, argv, NL80211_ATTR_TX_RATES);
 }
 
@@ -628,6 +634,7 @@ static int handle_bitrates(struct nl80211_state *state,
 #define DESCR_EHT " [eht-mcs-<2.4|5|6> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*]"
 #define DESCR_GI " [sgi-2.4|lgi-2.4] [sgi-5|lgi-5] [he-gi-<2.4|5|6> <0.8|1.6|3.2>] [eht-gi-<2.4|5|6> <0.8|1.6|3.2>]"
 #define DESCR_LTF " [he-ltf-<2.4|5|6> <1|2|4>] [eht-ltf-<2.4|5|6> <1|2|4|6|8>]"
+#define DESCR_MLO " [link-id <LINK ID>]"
 
 #define DESCR \
 	DESCR_LEGACY \
@@ -637,6 +644,7 @@ static int handle_bitrates(struct nl80211_state *state,
 	DESCR_EHT \
 	DESCR_GI \
 	DESCR_LTF \
+	DESCR_MLO \
 	/* end of DESCR */
 
 COMMAND(set, bitrates, DESCR,
-- 
2.39.0


