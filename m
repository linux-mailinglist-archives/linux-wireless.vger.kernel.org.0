Return-Path: <linux-wireless+bounces-2891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BB844362
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 16:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16E9287FA0
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBC412A14C;
	Wed, 31 Jan 2024 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FSlRn3kz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9B12AAFA
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716154; cv=none; b=dTqRPVqRWTLos+v//jFGZ0sp+9rENWgnFw9ONa8gLVWzV4rFRASBU/Ivn/aqE2cE2KzLxQepnRdYFr1oeD33d+bNIRCwS1slPZs5yz2oWxUS3zJI8mRkMPPdNm2ojR0ym3uDdC+bhttmKfHz0ooGADY0RZuU99YJRdDtXmB3NvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716154; c=relaxed/simple;
	bh=krfzuACLKn/lGUPHSbQT92gX9GV8xJdwc6ZIjW03dlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQz1bb4tNVPLisF4cxBuvy3iPfPzjopBTwHTiDpLzlhPLMRB4kDHj50xdYxWhaldeWSCG3vYDGfk4ENm6S4+DVm6loF9St2Fa4UpEju2Ivdl93RO+lr64UxdIdMd42ULd8uwuyZbKzOII1AUM6oiYYbCw2ayusW3WN/JXfSsVzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FSlRn3kz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=NAiZaiQuX4trHkagYsYq5DnsvFXQVYz3x+051IIS0d8=; t=1706716152; x=1707925752; 
	b=FSlRn3kz1OpT3+7t+QS6iSnLjjtO2t81Z1K6usJtSqYGJvjU9Dd7VMZpZTpHFBnOu+Cl8z/ptQg
	3yQrnQfhAWmVKp+oBw4yJ6A0cIvmUW2OCcKYeXmZjtUjcdbk5FoVsDmBbkiSQfqoRqM1N19i8nu3T
	gqK6EfHm5RzR3NYctmP4LgWPN5J5M7Q5SuA9yZcpHKAWP4SyutCTbE/42WiV+Q2hJtcJfqzhIyHmn
	Z1I5xz73X/o86Y75Ae6dtGr3IpmaHx1F/Zv3WZlNZkZmTcOOLycGcR1iYlGqXfC5+FP+w6u/7ec+V
	LEviCZwt+h/UPsA0AOoMylHdPT7jx3cdz1RQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rVCpp-00000007JC6-0e54;
	Wed, 31 Jan 2024 16:49:09 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: remove unused MAX_MSG_LEN define
Date: Wed, 31 Jan 2024 16:49:07 +0100
Message-ID: <20240131164907.ea5b740a190e.I6fec386e937610ec7867edcae23729ad1996c8b5@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This got unused when the tracing was converted to dynamic
strings, so the define can be removed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/trace_msg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mac80211/trace_msg.h b/net/mac80211/trace_msg.h
index c9dbe9aab7bd..aea4ce55c5ac 100644
--- a/net/mac80211/trace_msg.h
+++ b/net/mac80211/trace_msg.h
@@ -16,8 +16,6 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM mac80211_msg
 
-#define MAX_MSG_LEN	120
-
 DECLARE_EVENT_CLASS(mac80211_msg_event,
 	TP_PROTO(struct va_format *vaf),
 
-- 
2.43.0


