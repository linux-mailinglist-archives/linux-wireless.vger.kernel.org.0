Return-Path: <linux-wireless+bounces-2466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF9A83BC54
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 09:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20441F2A24F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F818638;
	Thu, 25 Jan 2024 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TzrJfaTZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC61B943;
	Thu, 25 Jan 2024 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172714; cv=none; b=OIYrkwtuTJmsZ3eCoisU3vxhBRwdAObLjH3H/rX+7fj3bx5lHkCCO/69R+nKMd60NM0X8WldVMqYtTm7mhrjM0z3o1vvvrrMfQbB5hANb3A0+/IOkcfGQ7k2sIvMwGlBJvCZUAL9AidqJKSz2bu98jAIZ5i1vCynrqEj3qv5H58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172714; c=relaxed/simple;
	bh=7PCQSSn9qQi0UDs0EZ6lPNb92aGeRUr/+gsVqO3dGHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWSQ3isRpHFRjOpjSvS09Z+WNHyNZc4S/V+k80l1e8khw4OdThMLse21Q0fZHej3A9eHz1DDfVIzWE96UWzX/30mqJ4e2jfIQedhF7WxCb3Em0XIAxl+jk3RT+RUW8d/vUnRSS2AVuJ25aWpFVu6oRZlgJxrUHQWWwLfZh8v/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TzrJfaTZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=JD9SLA41zLmXEitLPQ1L3S0RBoSKdOW+bAptf63pn0c=; t=1706172711; x=1707382311; 
	b=TzrJfaTZwI/NwJopZCcMTtn3xcTbWpafCr23X/v2Ng07G5ypcnZAUF9dRE7bofi4c9GQY+Y00cC
	68JrFqG4pbmWelzfU1PewJEKw+hPDHYgfKxMxNc2cex+P43FiI1uc3Ewy3O44lZpIIcKji0RR6ZWf
	Ag07DpQz+rffRCttKL2nSOwJ5542cwhUadCWskqJn1PbkrMkLsSsu4P0iggxkvH7jnTAyWhku9j+u
	aootUI1GVOkjP/JPCg6tapYL+5+GwtkXjAd1cBnzHMduJEyO0YLK2+4Dzwjx1PJ7DdalVc/Gsz1yV
	Z/9QnQfwJjGFvBzcKC6su14JSdoPVTIPC3Bg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rSvSY-0000000HKuJ-0xOq;
	Thu, 25 Jan 2024 09:51:42 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Jouni Malinen <j@w1.fi>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: fix wiphy delayed work queueing
Date: Thu, 25 Jan 2024 09:51:09 +0100
Message-ID: <20240125095108.2feb0eaaa446.I4617f3210ed0e7f252290d5970dac6a876aa595b@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When a wiphy work is queued with timer, and then again
without a delay, it's started immediately but *also*
started again after the timer expires. This can lead,
for example, to warnings in mac80211's offchannel code
as reported by Jouni. Running the same work twice isn't
expected, of course. Fix this by deleting the timer at
this point, when queuing immediately due to delay=0.

Reported-by: Jouni Malinen <j@w1.fi>
Cc: stable@vger.kernel.org
Fixes: a3ee4dc84c4e ("wifi: cfg80211: add a work abstraction with special semantics")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 409d74c57ca0..3fb1b637352a 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010		Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -1661,6 +1661,7 @@ void wiphy_delayed_work_queue(struct wiphy *wiphy,
 			      unsigned long delay)
 {
 	if (!delay) {
+		del_timer(&dwork->timer);
 		wiphy_work_queue(wiphy, &dwork->work);
 		return;
 	}
-- 
2.43.0


