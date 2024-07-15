Return-Path: <linux-wireless+bounces-10227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE89315ED
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 15:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D3C282CE9
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 13:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E3218D4D3;
	Mon, 15 Jul 2024 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="DDYoZV1T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mr85p00im-ztdg06021101.me.com (mr85p00im-ztdg06021101.me.com [17.58.23.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA018C180
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050781; cv=none; b=ViCCLpuMIM+csqRG3ee8Jhrtsyt1NQbUMI/sEa1r+UBKaNd7g0tMaDxsqwQFNwvJL2PMqoMXF62nEvuVqVX70M/6AGPrZOXmBuFl4BGceJks2YaMcEmEfXem0nLQzOcgd980sqC7/xsZ42JQWvkdlp18dIady1jP914GQIryQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050781; c=relaxed/simple;
	bh=d5rRAftrCLl1mUZDOS2Tnb6S+czH5FxVJuKEEqQoHNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ld464aJVGnEKCdiG6eeurjKqzrZyaebiEpc96xigcW/bjdIQ8TANqot2/v433UNXp3Eh1enqxHRJQ0vN5fEtXwdEzPtXJgQcFe9gqulM9YMZ6XhLLSSuO4CJ0Gu/A9oyVqlq3EHJNplydhMjd0OfxrpUVjBS9cuhNZ92jk92J2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=DDYoZV1T; arc=none smtp.client-ip=17.58.23.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1721050779;
	bh=3Wx+ye09OH2qUovDpgdt/TWExmZv8ijCOyu8ixZ3Bcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=DDYoZV1TOwWV0l67M2FcZyu3qUVZ2Dg8fIEDuvZpd/X2pQOOOm3XNWUG19BcSDm8X
	 jdAJj3u1A9hJUDUQyz5YUOydSGjqgR7EUDNhMrE0rgX2l/ipXrSSohQ1O4AFmc1DCP
	 HHjIKHmXg/+GixuFsJ4Qs3IdrRfyPhkkknuoK0QyHorbkcW99lC1oQfQSnerSXa/vC
	 00I20eP7SctBgF6IuKUueqt5kguXzzDwXJlSkBUlC6J7SV/fUw0agcFCPTqJieSsQ3
	 vRFiundeiqmaG8URgJLswAe2bhe1YB9/9ePokaRtB5zoQ0aLFwTDQq43cFR9GU+2bN
	 pxHK9QPzQ3xeQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021101.me.com (Postfix) with ESMTPSA id ACD5280140;
	Mon, 15 Jul 2024 13:39:34 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 15 Jul 2024 21:39:19 +0800
Subject: [PATCH] wifi: rfkill: Correct parameter type for
 rfkill_set_hw_state_reason()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-rfkill_fix-v1-1-a9f2d56b4716@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIYmlWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0NT3aK07MycnPi0zApdY2PTxLREo1QLi+REJaCGgqJUoDDYsOjY2lo
 AcQsEhVwAAAA=
To: Johannes Berg <johannes@sipsolutions.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: Fe6RiO1nDP25ClQiAdC6fIWWPu91dHoP
X-Proofpoint-GUID: Fe6RiO1nDP25ClQiAdC6fIWWPu91dHoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=868 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407150108
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Change type of parameter @reason to enum rfkill_hard_block_reasons for
API rfkill_set_hw_state_reason() according to its comments.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/linux/rfkill.h | 5 ++---
 net/rfkill/core.c      | 7 +------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/rfkill.h b/include/linux/rfkill.h
index 373003ace639..4f7558267541 100644
--- a/include/linux/rfkill.h
+++ b/include/linux/rfkill.h
@@ -147,7 +147,7 @@ void rfkill_destroy(struct rfkill *rfkill);
  * Prefer to use rfkill_set_hw_state if you don't need any special reason.
  */
 bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
-				bool blocked, unsigned long reason);
+		bool blocked, enum rfkill_hard_block_reasons reason);
 /**
  * rfkill_set_hw_state - Set the internal rfkill hardware block state
  * @rfkill: pointer to the rfkill class to modify.
@@ -279,8 +279,7 @@ static inline void rfkill_destroy(struct rfkill *rfkill)
 }
 
 static inline bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
-					      bool blocked,
-					      unsigned long reason)
+		bool blocked, enum rfkill_hard_block_reasons reason)
 {
 	return blocked;
 }
diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 7a5367628c05..f8ed6431b2f5 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -539,18 +539,13 @@ bool rfkill_get_global_sw_state(const enum rfkill_type type)
 #endif
 
 bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
-				bool blocked, unsigned long reason)
+		bool blocked, enum rfkill_hard_block_reasons reason)
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
base-commit: 338a93cf4a18c2036b567e9f613367f7a52f2511
change-id: 20240715-rfkill_fix-335afa2e88ca

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


