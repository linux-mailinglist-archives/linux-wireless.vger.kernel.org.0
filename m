Return-Path: <linux-wireless+bounces-11268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0468A94E000
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 06:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28ED31C20ADF
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 04:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DBB12E71;
	Sun, 11 Aug 2024 04:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yR97CCBO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F72125D5
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 04:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723351675; cv=none; b=VJ2vRiytBhupC5ifWM2SFLWvIhBZzaGuidY0hjxaDKgiBeFzL8odTV3LMlBcXscJBLu8PAZ1Vodc95H2ScChtq032pCX5tYlqXapRq04RSUjAhG0xI3UWaiOjMU+lc7n+z2QvtJy7e+TmGe24Q9C8hOaUCgCu0DRry7AWExJrog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723351675; c=relaxed/simple;
	bh=WoClrAp6/PDEPBO+fOKBj7MIutBkmR70T8FmVhfwHKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g8o+nZkIOcgYvXo5GMuL6yspOyd7jeLQ7fL5oJKTSWtAyL6+tzQTZnGHS4By5BObgUHdtMv6ju15dVoWf+kdzabSKZkOharrVGddrPiH4WycaJTbBGi8GsUEUXJkMeX11+N/yRSjLxMXHlajhH7jYH6jlFNVooQLTsEzLI3ql7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yR97CCBO; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723351673;
	bh=ChF3NJJHe5glh40340pDkN0lWNi8wdR9eqNWQFsg3gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=yR97CCBOtE4Iy0XYyNoEKhyDToSpTult/mhnVrLRbNleYVY6jni+Lph5x1LqNUieP
	 dXw1D5M3p7XT/MiY4qFldn5ERG1MxjZB+ao2DvJMrMfEXtk48DW7CN7K4gzFc2/aX8
	 KqHdcd98CisnKrtm90p01P2vYjliP4fs8s5YUZDbbiTO2i/I1oWQ3Ny6Y/8Mzdkjcr
	 Sv0ZeH/2tNZF7XT7oNY2E+NSe8mACpnGONvfVDm5eE6BKW8hFJckIjjnTySpjDaozW
	 LH0v0KoD0l4fnWaW2QkXNktXGRiUfuyd/TEQTYcIl/a6bHUga/qww+V5964jNgvx0D
	 m7CgG0620jL7w==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 174D1180169;
	Sun, 11 Aug 2024 04:47:45 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 12:47:26 +0800
Subject: [PATCH v2] wifi: rfkill: Correct parameter type for
 rfkill_set_hw_state_reason()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-rfkill_fix-v2-1-9050760336f4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAF1CuGYC/22MQQ6CMBAAv0L2bA0tFNCT/yDE1LKVjdhKq42G9
 O9Wzh5nkpkVAnrCAMdiBY+RAjmbQewK0JOyV2Q0ZgZRirpsuWTe3Giez4berKqkMkpg12kFOXh
 4zHqb9UPmicLT+c/2jvxn/24iZ5ypgxGjbC51y5vT8iJNVu+1u8OQUvoCcNSKwqYAAAA=
To: Johannes Berg <johannes@sipsolutions.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>, Zijun Hu <zijun_hu@icloud.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: aFkN8vTURkYiH0M8XK_lgUN5YSWV8baT
X-Proofpoint-GUID: aFkN8vTURkYiH0M8XK_lgUN5YSWV8baT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_03,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110036
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Change type of parameter @reason to enum rfkill_hard_block_reasons
for API rfkill_set_hw_state_reason() according to its comments, and
all kernel callers have invoked the API with enum type actually.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Fix indentation issue and correct commit message
- Git rebase over the following commit:
  Commit: cc32e9fb380d ("Merge tag 'rtw-next-2024-08-09' of https://github.com/pkshih/rtw")
- Link to v1: https://lore.kernel.org/r/20240715-rfkill_fix-v1-1-a9f2d56b4716@quicinc.com
---
 include/linux/rfkill.h | 5 +++--
 net/rfkill/core.c      | 8 ++------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/rfkill.h b/include/linux/rfkill.h
index 373003ace639..997b34197385 100644
--- a/include/linux/rfkill.h
+++ b/include/linux/rfkill.h
@@ -147,7 +147,8 @@ void rfkill_destroy(struct rfkill *rfkill);
  * Prefer to use rfkill_set_hw_state if you don't need any special reason.
  */
 bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
-				bool blocked, unsigned long reason);
+				bool blocked,
+				enum rfkill_hard_block_reasons reason);
 /**
  * rfkill_set_hw_state - Set the internal rfkill hardware block state
  * @rfkill: pointer to the rfkill class to modify.
@@ -280,7 +281,7 @@ static inline void rfkill_destroy(struct rfkill *rfkill)
 
 static inline bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
 					      bool blocked,
-					      unsigned long reason)
+					      enum rfkill_hard_block_reasons reason)
 {
 	return blocked;
 }
diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 7a5367628c05..13a5126bc36e 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -539,18 +539,14 @@ bool rfkill_get_global_sw_state(const enum rfkill_type type)
 #endif
 
 bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
-				bool blocked, unsigned long reason)
+				bool blocked,
+				enum rfkill_hard_block_reasons reason)
 {
 	unsigned long flags;
 	bool ret, prev;
 
 	BUG_ON(!rfkill);
 
-	if (WARN(reason & ~(RFKILL_HARD_BLOCK_SIGNAL |
-			    RFKILL_HARD_BLOCK_NOT_OWNER),
-		 "hw_state reason not supported: 0x%lx", reason))
-		return rfkill_blocked(rfkill);
-
 	spin_lock_irqsave(&rfkill->lock, flags);
 	prev = !!(rfkill->hard_block_reasons & reason);
 	if (blocked) {

---
base-commit: cc32e9fb380d8afdbf3486d7063d5520bfb0f071
change-id: 20240715-rfkill_fix-335afa2e88ca

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


