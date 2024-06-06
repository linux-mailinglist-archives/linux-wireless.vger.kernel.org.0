Return-Path: <linux-wireless+bounces-8644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB0C8FF5DF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 22:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1511F23876
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B4196446;
	Thu,  6 Jun 2024 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="V9Xc/4qC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D513AD30;
	Thu,  6 Jun 2024 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705992; cv=none; b=Oey5pIq9HrriAkvDK6duFrJuq2iI/Y00BFCLGO9EX6FiZgYtvsCeJYmFxaezA1lSTjreCag8kzo2clACOen9TQTCzveV2nDNMeOrBpjWrxwlVoNj5moVahYbPTkMcSKr7E1wL+CFZRe6XAOgINRZLli3ZFODyxLPJhu6q6D4Rl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705992; c=relaxed/simple;
	bh=yokXtXFUfqclyFGAp2a6WDFNNDfrpZ77U7BOeMXwYEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nwb4HZeZI8OcSQ029OIpJH/OUoELh4LuRCkBFFKZyGCvgm9+6rGZmj6GYePJYBnHv7cuehbdMkoSGNnjpXwsIWrAR/62+U8qAr52WJZfoUH2hsuKnoH0BOSSRgrMG3W/Z56nsLyLbWoWghtg25DmnacOOEMBJsVq+AHFj/uGfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=V9Xc/4qC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7H/FqwBpM+5q3YJTobEqpfZakcN/zmH9Xcq0xGw6tnc=;
	t=1717705989; x=1718915589; b=V9Xc/4qCBdRnAr05QMtYkKQjQqixFJZsY5cDohfENeAC0uQ
	oda2LDJAzHt/yD/WF1FIB5XiynEXuWYp5c9bqwx58qToBGa8lRbZjmmBKu0wxlzoWt4MhJFtdEFRu
	z0GnJkG0GP77NSniYtlFUPGCkeDB33QCpO+zfCig5Xlj8nLfxtBtAwi7Jvo7cEvontQOLLMOV2qGQ
	IGB9R1mj9byvaJBjVlI3zTfFER/DIaX+4byU9JY/xcq+UlNZsgMSGcXr6B4MlClUgSGTObXJL/xQc
	BrZ/P6tAlgHw4Bn+txXcicwq2z2VVcRYB3rfZps/BSJ9PAZTXLI2zmqk6rmsBPCQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sFJnB-0000000HDhM-0WfF;
	Thu, 06 Jun 2024 22:33:01 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 2/4] tracing/timer: use __print_sym()
Date: Thu,  6 Jun 2024 22:32:02 +0200
Message-ID: <20240606203255.49433-8-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606203255.49433-6-johannes@sipsolutions.net>
References: <20240606203255.49433-6-johannes@sipsolutions.net>
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
2.45.1


