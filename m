Return-Path: <linux-wireless+bounces-30746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E924D19953
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 15:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614F230940EE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1449B2BE639;
	Tue, 13 Jan 2026 14:42:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FC82BE05E
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315327; cv=none; b=I1JNbYHJW3+pYbogpiBBYWlcchvRpKvwGKzzju+MC/dU89SNlMc0O9q0NzLTlak9XznrYYZNIeaRXo1Bnq1NvNqfFg1Ahru2l4MQpoKGpY3AynLvX57IasW8jPuFQ3v5fa3v0mzq+WxCH41dKxqk6jqvMm80l1b0MQk1CF1vLRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315327; c=relaxed/simple;
	bh=Hg8kC0A8qvRbIdYhngkTGjK0IPrcKxQ9GXulwk4BCgE=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Wq5vYhnxeQNHDVlXDZYRUnQQjLncZdH+i44tcQCbIO8Ecj8QvkNgixi8WBEd6B4NqlZwC53+JMUyXAFTtdsxKBA2ObiXMsnQDy//4k+7ZGm41yCy16yX5gvY9VtVTFV46sn5zQddOIoziM1GKcZnWCGbTNDu5bzmUFn8C+Ae+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A16D15341
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:42:02 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 93657542A; Tue, 13 Jan 2026 15:42:02 +0100 (CET)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from sara (h-62-63-215-216.A163.priv.bahnhof.se [62.63.215.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id D6BA8533F;
	Tue, 13 Jan 2026 15:42:00 +0100 (CET)
Date: Tue, 13 Jan 2026 15:42:00 +0100 (CET)
From: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@lysator.liu.se>
To: Johannes Berg <johannes@sipsolutions.net>
cc: linux-wireless@vger.kernel.org
Subject: [PATCH] iw: Print Toffset as signed value
Message-ID: <e703cbeb-99ec-b50a-a337-ea3f366a58bb@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1941676392-1768315135=:16459"
Content-ID: <8dd37621-5db0-5944-b324-2f4d10e557b3@lysator.liu.se>
X-Virus-Scanned: ClamAV using ClamSMTP

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1941676392-1768315135=:16459
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <1c42f353-ac4b-0e1b-8277-5f24e6b5f873@lysator.liu.se>


Signed-off-by: Peter Åstrand <astrand@lysator.liu.se>
---
 station.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/station.c b/station.c
index a07ead6..5adf6bf 100644
--- a/station.c
+++ b/station.c
@@ -376,8 +376,8 @@ static void print_nested_sta_handler(struct nlattr *link_sinfo[NL80211_STA_INFO_
 		printf("%sbeacon signal avg:\t%d dBm", indent,
 		       (int8_t)nla_get_u8(link_sinfo[NL80211_STA_INFO_BEACON_SIGNAL_AVG]));
 	if (link_sinfo[NL80211_STA_INFO_T_OFFSET])
-		printf("%sToffset:\t%llu us", indent,
-		       (unsigned long long)nla_get_u64(link_sinfo[NL80211_STA_INFO_T_OFFSET]));
+		printf("%sToffset:\t%lld us", indent,
+		       (long long)nla_get_s64(link_sinfo[NL80211_STA_INFO_T_OFFSET]));
 
 	if (link_sinfo[NL80211_STA_INFO_TX_BITRATE]) {
 		char buf[100];
-- 
2.30.2


Br,
Peter Åstrand
--8323329-1941676392-1768315135=:16459--

