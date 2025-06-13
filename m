Return-Path: <linux-wireless+bounces-24097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87E1AD983C
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Jun 2025 00:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9545716B7E2
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160F8226D18;
	Fri, 13 Jun 2025 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yQanFMp6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E262E11D4
	for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749853852; cv=none; b=V9YAK2NAU1E3ydrcjW+BDGEfmuh22W3oJvT/Fr+7nCj92w/EFKk8aChM8ZPmDURuonZIkD3dn0ifZBuDZsumC0uwmOvvwBvEIB7u5315Jr2Wb8UoMTm4DgPDxT6RV9pADRCErSnDIfPBWWrnupf8kkcA9HXXxWFTk148On+waVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749853852; c=relaxed/simple;
	bh=KxmZikZ5dPhZTB4L9FFkKeMlBrI+wgwu0Z6CoS80IAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFaYx/xOtKHO8sv892qH9RT9w6nD1qvHlZuVm0s21PXIEbvlXkOTj86h7gsIsbaLk7vkwFRJ9zBGtj++RGxHPDAF0QcV+8gTWAxgqpaSuqiEd6tnS7UIotJvcrlwg/rL0NJN+Be5df60OKFJsb4W+T7/uWJoTl26vssQxDOAFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yQanFMp6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=N6LkW5zxf/BEllnAkTU2i0o+TdadPhHLAzb8yA8TZSo=; t=1749853850; x=1751063450; 
	b=yQanFMp6FMm4ZvDwLM0qlx418ZUGAOeHEzbGGYSJyBdI9TF8VtgxUn2PqeAxWhpziae1MLL0hGR
	UHqjV5ciXiVgFoQidvotznOV+KkhG+mEHCvFXRNyGl/FyXWoDWbG/0OZdAQ112g1xKVNpf6Bi/5Bv
	dioJtMpTy8OW/WVBc6s9EL7t/HbDEIjGCLbSZOxFdQXkF+YXGrO7/d4+2JiY8FE2a/I5XeE9u1tWu
	rYfsWsLC4MjEtkp7nD39ObnYvjbEzzZ82eKTFUGoHyp2YTtDgftBr1mQJl62szH7I6yLXoMjvpuEG
	pB5dLPe+5+uR/qLXzwPDtPLdmTbRFY1wo+vw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uQCv2-000000074oR-1hbl;
	Sat, 14 Jun 2025 00:30:40 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com
Subject: [PATCH wireless] wifi: remove zero-length arrays
Date: Sat, 14 Jun 2025 00:30:37 +0200
Message-ID: <20250614003037.a3e82e882251.I2e8b58e56ff2a9f8b06c66f036578b7c1d4e4685@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

All of these are really meant to be variable-length, and
in the case of s1g_beacon it's actually accessed. Make that
one in particular, and a couple of others (that aren't used
as arrays now), actually variable.

Reported-by: syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com
Fixes: 1e1f706fc2ce ("wifi: cfg80211/mac80211: correctly parse S1G beacon optional elements")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index ce377f7fb912..22f39e5e2ff1 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1278,7 +1278,7 @@ struct ieee80211_ext {
 			u8 sa[ETH_ALEN];
 			__le32 timestamp;
 			u8 change_seq;
-			u8 variable[0];
+			u8 variable[];
 		} __packed s1g_beacon;
 	} u;
 } __packed __aligned(2);
@@ -1536,7 +1536,7 @@ struct ieee80211_mgmt {
 					u8 action_code;
 					u8 dialog_token;
 					__le16 capability;
-					u8 variable[0];
+					u8 variable[];
 				} __packed tdls_discover_resp;
 				struct {
 					u8 action_code;
@@ -1721,35 +1721,35 @@ struct ieee80211_tdls_data {
 		struct {
 			u8 dialog_token;
 			__le16 capability;
-			u8 variable[0];
+			u8 variable[];
 		} __packed setup_req;
 		struct {
 			__le16 status_code;
 			u8 dialog_token;
 			__le16 capability;
-			u8 variable[0];
+			u8 variable[];
 		} __packed setup_resp;
 		struct {
 			__le16 status_code;
 			u8 dialog_token;
-			u8 variable[0];
+			u8 variable[];
 		} __packed setup_cfm;
 		struct {
 			__le16 reason_code;
-			u8 variable[0];
+			u8 variable[];
 		} __packed teardown;
 		struct {
 			u8 dialog_token;
-			u8 variable[0];
+			u8 variable[];
 		} __packed discover_req;
 		struct {
 			u8 target_channel;
 			u8 oper_class;
-			u8 variable[0];
+			u8 variable[];
 		} __packed chan_switch_req;
 		struct {
 			__le16 status_code;
-			u8 variable[0];
+			u8 variable[];
 		} __packed chan_switch_resp;
 	} u;
 } __packed;
-- 
2.49.0


