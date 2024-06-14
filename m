Return-Path: <linux-wireless+bounces-9003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A004B908611
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499101F26278
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BBB1850B0;
	Fri, 14 Jun 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kjxIjm43"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5C1836FC;
	Fri, 14 Jun 2024 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353204; cv=none; b=RAGOJgFw0vXwJ+Zuuo4SWuqkCCvsBlAIxClHtflJHj6jUn0ejCOzJdC1XwWp61bvMM2dQdckmM7qHY4SEZsNIgSElJXisji8BOsQ97OkRxrJwFT0Lghfs2x30yzHw+wfgrz2023gmQXVRr9abF8G63Cif7F0Bc8U0qyRy8sLen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353204; c=relaxed/simple;
	bh=h0S/+RKtX+8ma8OFYEofvkiKQvp4mAWM7WJnL6VEXUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeXdmWbyTuoyVMzbMkO3p7Rhoi3mRYJXAVeREUuZbSq8/WhP2qwHisTYMGROMDOxb6b2hLdOlTnQVMqgGX3VnzRiIRpBVZ9/afa2ZzqZXHW0h/8gq0bG/xa8chnLeUCXqVsfPkedvR9dWVYijmM+ac1TY4edaFzCpx2DzoAiNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kjxIjm43; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=g4Sbxzk3R+WtfowpSIKfFh9uV3XXl4AJmyTZPcpwMqU=;
	t=1718353202; x=1719562802; b=kjxIjm43HAxfJCoRvTLu5hJ/ejpzqPLh8ufmv/OPVxEQgCC
	UeeYPDIuBcOH6dLM2z92hwsDKsW5X3Ytyr2vn6Bpg7JmABYFeLkDVtk25EoPjE+V7JWrnj3IAHW/9
	7HfY9FU9UJ/2jI3f+HoRON3RiS+Oia4lishVWKLFdF49SJToxmmFhA+2LdAGtuZe7zl7GGPMHc9hi
	h2BEWiwGBHYmBJ0G1prrL3ZdeucV1qYjTtT3tjUAeABCty1lKbfUXWf5tN+/A3afJ3ua2iH6YILiJ
	DXAxwvzcEh1jW2ffHGbQ5D+V5GFdobmNnCWnaxmZbPjEMdeJtSST8s4kL4flvLdw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sI2AC-0000000DZpq-0ndW;
	Fri, 14 Jun 2024 10:20:00 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v5 2/4] tracing/timer: use __print_sym()
Date: Fri, 14 Jun 2024 10:19:14 +0200
Message-ID: <20240614081956.19832-7-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614081956.19832-6-johannes@sipsolutions.net>
References: <20240614081956.19832-6-johannes@sipsolutions.net>
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


