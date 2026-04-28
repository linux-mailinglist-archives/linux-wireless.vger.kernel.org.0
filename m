Return-Path: <linux-wireless+bounces-35473-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCPVCJaG8GnuUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35473-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:06:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCDD482346
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D91C34E01E7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53361396D0A;
	Tue, 28 Apr 2026 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MUzc1MW6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC4390234
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368443; cv=none; b=C8X1MZXEALonWxvNqrlAsTZj6PApJwyDkQuy+O68kfZZiGrRPHyvt3nlxwXMyX34hBiu++FCRHu9W08eQ9MWTyg/yGwj5BvslvUqLODhoJH7E/B+JRfA0/awOvytpD0RuXPF6jfKq2KF3aAKO5g6kniOM9exqJTgnxt7l98061k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368443; c=relaxed/simple;
	bh=HxxekzH/vLMySBiCNmZ2aj4AEInQYv/xzNm4qdI76rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDGsWjHyTAv4u7FGx4wN+Ap/aE+IxNMwaL6Ejyf6irefcEBX8JiQxnSMWIwDvKVoSbkEMpQmz/5n7yeEPF3wmVIQAgOpELuyhD/wsY0oXVJ/rGAs4K2Q2w/uId2rFMg+eQwNl/Kg+/IDROYRIBRHZH8tvVrqtFNdJ69rFQs0cRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MUzc1MW6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FX5UAZL9KF6VUi1e6PXBO0kfDYs0z4g7xsHCFL6Fy+I=;
	t=1777368441; x=1778578041; b=MUzc1MW6EBgF6BDF6lWNY/lmNIq2QDFKTQCGLt5EWPknoJ+
	tJG6ZGk8wFw93/6XOTL/BfTohsOyU79uEClhhBKlSyTDbqOsIK2u5DeO85OYbqfuf/RJbZpll97UL
	t3aboA12jsXYr5oJdOzTOl+E48UQKjr3RITGfpvKxzlK4cGW6TxawzIEBZdDAmqAm7GTJ3hWGNo02
	ILk/z2gFIK1o3tNF44FOLtW0XwtiIEm+eu5hrQOe01Nzik3Q4aIqZaPoc+z8s4ZUiUqfyZwpNyYz8
	fwiA5eqUshXEdKpSpGx/j1tZGImwjH7FrNIwe2fDuCbQU6ZIUl0m5YOmr7xH1GAg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeit-0000000HLwg-0BdX;
	Tue, 28 Apr 2026 11:27:19 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 08/14] wifi: mac80211: add NPCA to chandef tracing
Date: Tue, 28 Apr 2026 11:25:36 +0200
Message-ID: <20260428112708.28625e191054.I4b3728e594710dd01f7f154faddf7d98d898a45f@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428092708.71740-16-johannes@sipsolutions.net>
References: <20260428092708.71740-16-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8BCDD482346
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35473-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Johannes Berg <johannes.berg@intel.com>

Add the NPCA parameters (NPCA primary channel and puncturing bitmap)
to the chandef tracing.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/trace.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 71cf88039bd4..562a4964afa3 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -44,7 +44,9 @@
 			__field(u32, n##center_freq1)					\
 			__field(u32, n##freq1_offset)					\
 			__field(u32, n##center_freq2)					\
-			__field(u16, n##punctured)
+			__field(u16, n##punctured)					\
+			__field(u32, n##npca_pri_freq)					\
+			__field(u16, n##npca_punctured)
 #define __CHANDEF_ASSIGN(n, c)								\
 			__entry->n##control_freq = (c) && (c)->chan ?			\
 				(c)->chan->center_freq : 0;				\
@@ -54,14 +56,18 @@
 			__entry->n##center_freq1 = (c) ? (c)->center_freq1 : 0;		\
 			__entry->n##freq1_offset = (c) ? (c)->freq1_offset : 0;		\
 			__entry->n##center_freq2 = (c) ? (c)->center_freq2 : 0;		\
-			__entry->n##punctured = (c) ? (c)->punctured : 0;
+			__entry->n##punctured = (c) ? (c)->punctured : 0;		\
+			__entry->n##npca_pri_freq = (c) && (c)->npca_chan ?		\
+				(c)->npca_chan->center_freq : 0;			\
+			__entry->n##npca_punctured = (c) ? (c)->npca_punctured : 0;
 #define __CHANDEF_PR_FMT(n)								\
-	" " #n "(%d.%03d MHz,width:%d,center: %d.%03d/%d MHz, punct:0x%x)"
+	" " #n "(%d.%03d MHz,width:%d,center: %d.%03d/%d MHz, punct:0x%x, npca:%u, npca_punct:0x%x)"
 #define __CHANDEF_PR_ARG(n)								\
 			__entry->n##control_freq, __entry->n##freq_offset,		\
 			__entry->n##chan_width, __entry->n##center_freq1,		\
 			__entry->n##freq1_offset, __entry->n##center_freq2,		\
-			__entry->n##punctured
+			__entry->n##punctured, __entry->n##npca_pri_freq,		\
+			__entry->n##npca_punctured
 
 #define CHANDEF_ENTRY		__CHANDEF_ENTRY()
 #define CHANDEF_ASSIGN(c)	__CHANDEF_ASSIGN(, c)
-- 
2.53.0


