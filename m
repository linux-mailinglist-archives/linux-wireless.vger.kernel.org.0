Return-Path: <linux-wireless+bounces-28850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B11C4EAAC
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 16:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7595218923B3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397A130C635;
	Tue, 11 Nov 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="FOs5a2oN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7662FBE0E
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873100; cv=pass; b=Xx9YmVlbqmj75mmfvRbaeCcdkiXo3jRr0ms8N3UxKzrlGZThoGzZSPu91TZe9p8ZKEv3SzXcYHiBkRXNI9eSpC3fkgy09S6JIlgW3JwhAZVVCBV13C6YNV4Yrw4l24zxkX/871cHT+F7wvnYjvPqeHNsFtwKvD/ENMI8yyPH6aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873100; c=relaxed/simple;
	bh=dnumpvYq5Ee0tmP6jcSnYlL37wE7OLPlaqtIWAGA4/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbSsIdvy/X+D0+yUrtjHfaR+pPgXQz8BUbhDrNrpwK3CCwQ6ffO7Q42DDOIjHExtMLHvvDnX7dE7zwo8SWfj6UY0WeB458YJ8SO+C4TmoxLgIaH92WjL+jmzfIidPv0SPuRJ5QAxjQgX6SwWm4ms0+Z60lYm3X5exJHWohUxzjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=FOs5a2oN; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762873096; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hqxMqcbQMnNSW+0cE6l7+MMWroSFh5/bgvGVg0YCaVPqH6dryxIomnJqRY3NAj8CAZr9eKPefX7X1uuAaPK5cAOjl0gsujraNqaMDRHKwVXpvM30j+R8WkdjFqpVLaGmZFQY2vVI1041G/rGYoamSXbw0jWIh4sjOx2qSj17DKk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762873096; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8zU3pGFGBb31dy1SWNvVkfQchxNx9Oshz1yh8hR/Qs4=; 
	b=TrUBe8PQA4Aqcb5j7tmxAF9wCs1MVBmzwNp0Pa1kJ5Vat6PhM53rnJov/+y2AINfCNLJj3CjyfgV2U82zz3H+QFqaMthJrXMVDoF0bC4nX3lbRW1cjtyIToTn5Dz4SfN4NYo81tAUaDQgB/oKbzzF/yCVnBAMzpzV8ecL5Thtrk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762873095;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8zU3pGFGBb31dy1SWNvVkfQchxNx9Oshz1yh8hR/Qs4=;
	b=FOs5a2oNnO8JX84cMQTvUQUkaus95d7AKXo8y1IwFPELW5I/RMlkrR6OD6QnYN55
	wfEydMsqnT6BpvbpgCKkcdkZQgqX7+JfaruNtAvHrqn7/edYog6xa2glKhH3JI88vhu
	w4nGawPSzUHlmKISoabmnnADIdx3JUVM6FKmPyGk=
Received: by mx.zohomail.com with SMTPS id 1762873093421540.5600783536864;
	Tue, 11 Nov 2025 06:58:13 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v3 3/5] wifi: mac80211: utilize the newly defined CMAC constants
Date: Tue, 11 Nov 2025 22:57:57 +0800
Message-ID: <20251111145759.111691-4-m@xv97.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111145759.111691-1-m@xv97.com>
References: <20251111145759.111691-1-m@xv97.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Make use of the added constants to reduce duplication.

Signed-off-by: Chien Wong <m@xv97.com>
---
 net/mac80211/aes_cmac.c | 4 ++--
 net/mac80211/aes_gmac.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
index adce68ea0981..01fb8b6c5dfb 100644
--- a/net/mac80211/aes_cmac.c
+++ b/net/mac80211/aes_cmac.c
@@ -16,8 +16,8 @@
 #include "key.h"
 #include "aes_cmac.h"
 
-#define CMAC_TLEN 8 /* CMAC TLen = 64 bits (8 octets) */
-#define CMAC_TLEN_256 16 /* CMAC TLen = 128 bits (16 octets) */
+#define CMAC_TLEN IEEE80211_CMAC_128_MIC_LEN
+#define CMAC_TLEN_256 IEEE80211_CMAC_256_MIC_LEN
 #define AAD_LEN 20
 
 static const u8 zero[CMAC_TLEN_256];
diff --git a/net/mac80211/aes_gmac.h b/net/mac80211/aes_gmac.h
index c739356bae2a..09378e52c7a6 100644
--- a/net/mac80211/aes_gmac.h
+++ b/net/mac80211/aes_gmac.h
@@ -9,7 +9,7 @@
 #include <linux/crypto.h>
 
 #define GMAC_AAD_LEN	20
-#define GMAC_MIC_LEN	16
+#define GMAC_MIC_LEN	IEEE80211_GMAC_MIC_LEN
 #define GMAC_NONCE_LEN	12
 
 struct crypto_aead *ieee80211_aes_gmac_key_setup(const u8 key[],
-- 
2.51.2


