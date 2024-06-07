Return-Path: <linux-wireless+bounces-8701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F60C9009E9
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 18:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F72A1C22441
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED5A19AD58;
	Fri,  7 Jun 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qiJy566S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F719A29C;
	Fri,  7 Jun 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776336; cv=none; b=m5wEdrmklY93MxGukQlWlQhT0S9Tbr8tgnOkdfSEorZLB828YBS5aHf9G/fcQ33Mlamx5/liAxx6llXFjxRmP/apwjdtb5ROyM6QnsKHrX9Bce06/JP1vwm3QPQXj/cw0CquBhEKH1kEZqpOGEAOH99S7gr7P8Eb+dUpOnCoPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776336; c=relaxed/simple;
	bh=h0S/+RKtX+8ma8OFYEofvkiKQvp4mAWM7WJnL6VEXUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGrY1MMwWpzk/U02utln2/4mMq1WOZ96bOMAplN+Hb2luY4HE6pAAPVQaxgs4YLduyyBlEVhV6F8jHTzbjhQgj1uphhQYJDtzChVHN9KMhTfFFZlauIE3oSSWd6275ZcSg3ZFKwmB9VXRCbdsdsaM2ibppamqD1bNKiaadOnu6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qiJy566S; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=g4Sbxzk3R+WtfowpSIKfFh9uV3XXl4AJmyTZPcpwMqU=;
	t=1717776334; x=1718985934; b=qiJy566SVxP3/ApiSl/Js2nB2RMDCpbprDrymzWPc5unZdq
	6HXPk8wJikrbE4TBmH61bwfuRJecXJcNNGuLy4l/BktA6TKziu8/B+eqw0tbtmUUXX808aHgf1TqN
	LvqF3nxyTHS89s4cuTD0g42qfx8h6gorqw/2aNB1hl9iMy3QzPtSIqbQYhEpFxEexnGS3vRIvjpJ3
	d8P0TltBVqjA4z7eD0QHn5XbQMOIy44/jgY+S9+QZXV8C+Vj3nJwb8roy/Drg7LD1KdHtqCohFmBR
	1GcBma4Nn312G4LzSIzkMT+vI4zDRUnoCLIaDfWm4eAVq5azn5cJOsxFI/4ns4Sw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sFc5r-00000001Iyu-3QFa;
	Fri, 07 Jun 2024 18:05:32 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v4 2/4] tracing/timer: use __print_sym()
Date: Fri,  7 Jun 2024 18:04:24 +0200
Message-ID: <20240607160527.23624-8-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607160527.23624-6-johannes@sipsolutions.net>
References: <20240607160527.23624-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Use the new __print_sym() in the timer tracing, just to show
how to convert something. This adds ~80 bytes of .text for a
saving of ~1.5K of data in my builds.

Note the format changes from

print fmt: "success=%d dependency=%s", REC->success, __print_symbolic(REC->dependency, { 0, "NONE" }, { (1 << 0), "POSIX_TIMER" }, { (1 << 1), "PERF_EVENTS" }, { (1 << 2), "SCHED" }, { (1 << 3), "CLOCK_UNSTABLE" }, { (1 << 4), "RCU" }, { (1 << 5), "RCU_EXP" })

to

print fmt: "success=%d dependency=%s", REC->success, __print_symbolic(REC->dependency, { 0, "NONE" }, { 1, "POSIX_TIMER" }, { 2, "PERF_EVENTS" }, { 4, "SCHED" }, { 8, "CLOCK_UNSTABLE" }, { 16, "RCU" }, { 32, "RCU_EXP" })

since the values are now just printed in the show function as
pure decimal values.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/trace/events/timer.h | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 1ef58a04fc57..d483abffed78 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -402,26 +402,18 @@ TRACE_EVENT(itimer_expire,
 #undef tick_dep_mask_name
 #undef tick_dep_name_end
 
-/* The MASK will convert to their bits and they need to be processed too */
-#define tick_dep_name(sdep) TRACE_DEFINE_ENUM(TICK_DEP_BIT_##sdep); \
-	TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
-#define tick_dep_name_end(sdep)  TRACE_DEFINE_ENUM(TICK_DEP_BIT_##sdep); \
-	TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
-/* NONE only has a mask defined for it */
-#define tick_dep_mask_name(sdep) TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
-
-TICK_DEP_NAMES
-
-#undef tick_dep_name
-#undef tick_dep_mask_name
-#undef tick_dep_name_end
-
 #define tick_dep_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
 #define tick_dep_mask_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
 #define tick_dep_name_end(sdep) { TICK_DEP_MASK_##sdep, #sdep }
 
+TRACE_DEFINE_SYM_LIST(tick_dep_names, TICK_DEP_NAMES);
+
+#undef tick_dep_name
+#undef tick_dep_mask_name
+#undef tick_dep_name_end
+
 #define show_tick_dep_name(val)				\
-	__print_symbolic(val, TICK_DEP_NAMES)
+	__print_sym(val, tick_dep_names)
 
 TRACE_EVENT(tick_stop,
 
-- 
2.45.2


