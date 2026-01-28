Return-Path: <linux-wireless+bounces-31267-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAy2HYLpeWkF1AEAu9opvQ
	(envelope-from <linux-wireless+bounces-31267-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 11:48:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1415C9FACB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 11:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24EE2303B4D8
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7350A2DC798;
	Wed, 28 Jan 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.in header.i=@nic.in header.b="e95eDnid"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relayout15.nic.in (relayout15.nic.in [164.100.14.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0CD28CF6F
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=164.100.14.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597227; cv=none; b=hNVMavylQtmvRpnUMkZYDo7oTqG+8p6ljee1ThqBWR0bZf/UFK+HXLJm+GC5n4xCqXZNbAPF0WFp71w8/JvQUjna3g9sGtj1pK7CsvlLbYM8IBwDnKfjJgDitGLfkTP/EqUfnCllIdDUEMahjCsqhmVz7hv25BMuIAT2GNoNxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597227; c=relaxed/simple;
	bh=3NDOijO22Tft7cIxE6M7OHKY8F0iaf8RKCkERV1nsbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GgIPTcIb5If3ARFCnsYuDHnOLlbMrMzH5seLj6hziI82xrsc+xcxjkGfg7130za8t43mef+gSWyfNzbiPDGJzIbtG0IMRySy71tf2ThzmzdO7RnSeVPeVHwc2rWaPv23YyaBj26Uqoa1D4r0i4OjMaFZsF8xiRVyKaKrkDB5bsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.in; spf=pass smtp.mailfrom=nic.in; dkim=pass (1024-bit key) header.d=nic.in header.i=@nic.in header.b=e95eDnid; arc=none smtp.client-ip=164.100.14.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nic.in
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=nic.in; i=@nic.in; q=dns/txt; s=NIC; t=1769597223;
  x=1801133223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3NDOijO22Tft7cIxE6M7OHKY8F0iaf8RKCkERV1nsbA=;
  b=e95eDnidKgQcnlh7QnuNAoCGoUE1uqZw70HzhZUlrXhcdaUQ0Z3nemvU
   atWBEHvp6nnhNXPRfpxP+GvKAmo8u7lT2XPtjIjtNqwLVLmwx56QwuQ+L
   i5RDTZUnAgqB8BnckpB3tpWuGXRVqbtVsW5PsL8AI8xnuaFSEqigQb7+a
   E=;
X-IPAS-Result: =?us-ascii?q?A2AkAADkiuNo/yh6KAo+HBwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?AmBNgcBAQsBg0GBZYRUg1iERIlVnh2Bfw8BAQEBAQEBAQE9HQQBAYRBRoxJJ?=
 =?us-ascii?q?zQJDgECBAEBAQEDAgMBAQEBAQEQAQEGAQEBAQEBBgWBIYYJRg2GXQIlDwFGK?=
 =?us-ascii?q?AgFAiYCaQiDAgGCchQGQat5gTIaAmU7gx8DBAcBBg8KCxraI4FQBoEbLgGBa?=
 =?us-ascii?q?YZnAYR8cIJIgi+CT4EUAYNogVABgRABAQEBAReBKDsJJ4MOgmkEgiKBFoQOg?=
 =?us-ascii?q?iiJe4F6jgFIgQIcA1ksAVUTDQoLBwWBYwM1DAsuFW4yDg+BJ4ULhB4rT4UCg?=
 =?us-ascii?q?RiDUyJrDwaBFYNaBolmD4ImAwsYDUgRLDcUGwY9AW4HmFSDSmEDKioClVETk?=
 =?us-ascii?q?jmhEQeQPZU5TZd9A5JqAZkGjFqBLoh6jH1ZhlGBZBwCAwkHgR+DCFIZlQYRg?=
 =?us-ascii?q?iyrCnACOgIHAQoBAQMJk2cBAQ?=
IronPort-Data: A9a23:zS7MT6JSnIf7zu7TFE+RmJQlxSXFcZb7ZxGr2PjKsXjdYENS1mZTn
 2JJUG+OOvmPamKnc41+PYSw/U1X68PVyIU2SFAd+CA2RRqmi+KcXo3BcR2Y0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+lH3dOGJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYx6TSEK1rlV
 e3a8pW31GCNhmYc3lI8s8qrtB5ptfLujzIU1nRWiSdj5QK2e9E9VfrzFInpR5fKatA88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NpltIGbVx0jMKP2pfkGWQUCEXFXPZ9oweqSSZS/mZT7I0zub3/3x/xkFwcwPIZd8ettHSdI9
 PdeKTZlghKr3rrwnOr9E7M2wJh7RCXoFNp3VnVIwjjEF/84B5PKRb7D4fde3Tx2h8Ym8fP2P
 pFCOGAxMkueC/FJEktKMa0Tnb2Vv2e8c2ZUjxHJmrAx+HeGmWSd15CoarI5YOeiQcRTg1bdu
 WPc8mD0GQoyKtOS03yG/2iqi+uJmjn0MKoNFae18vNxmxiJy2MfAjUSVECnur+4jECkUt5SI
 kBS/TAhxYAt+UqwZtrwRRu1pDiDpBF0ZjZLO7Rirl3VjPOOuUDFXgDoUwJ8VTDvj+duLRRC6
 7NDt4mB6eBH2FFNdU+gyw==
IronPort-HdrOrdr: A9a23:fgurGK6YPgVHIZu7JQPXwNfXdLJyesId70hD6qm+c3Fom6uj5q
 KTdZUgpHzJYVkqN03I9erqBEDiexPhHPxOj7X5VI3KNDUO01HFEGgN1+HfKkXbehHDyg==
X-Talos-CUID: 9a23:QtFYBWxGQ2fhRP0mrkdiBgUVB+s7aHfTwk3tPlSyFTxrGJSVe3GprfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AhjWu1w04jOLDm2XVCT+huXmuAzUj//mXN20My6g?=
 =?us-ascii?q?/pYqEbiBXeGuiljKsXdpy?=
X-IronPort-Anti-Spam-Filtered: true
Received: from unknown (HELO tlslabs.nic-cert.nic.in) ([10.40.122.40])
  by relayin.nic.in with ESMTP; 28 Jan 2026 15:55:30 +0530
From: gaurav.kansal@nic.in
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	Gaurav Kansal <gaurav.kansal@nic.in>
Subject: [PATCH] wireless-regdb: add IN rules for lower 6 GHz (5925-6425 MHz) LPI and VLP
Date: Wed, 28 Jan 2026 15:55:24 +0530
Message-ID: <20260128102525.872517-1-gaurav.kansal@nic.in>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kansal@nic.in,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-31267-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[nic.in:?];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	DMARC_DNSFAIL(0.00)[nic.in : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.673];
	R_DKIM_TEMPFAIL(0.00)[nic.in:s=NIC];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wikipedia.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gauravkansal.in:url,dot.gov.in:url]
X-Rspamd-Queue-Id: 1415C9FACB
X-Rspamd-Action: no action

From: Gaurav Kansal <gaurav.kansal@nic.in>

    DoT / Gazette notification (20 Jan 2026) delicensed lower 6 GHz (5925-6425 MHz).
    Add rules for:
     - Low Power Indoor (LPI) 5925-6425 MHz, up to 1000 mW (30 dBm) EIRP, NO-OUTDOOR
     - Very Low Power (VLP) 5925-6425 MHz, up to 25 mW (14 dBm) EIRP

    References:
     - DoT / Gazette notification (Jan 20, 2026)
       https://blog.gauravkansal.in/2026/01/Gazette%20on%20the%20Use%20of%20Low%20Power%20and%20Very%20Low%20Power%20Wireless%20Access%20System%20in%20Lower%206%20GHz%20band%20-%202026.pdf
       https://blog.gauravkansal.in/2026/01/Opening-India-Lower-6-GHz-Band-for-Wireless-Use:-A-Strategic-Regulatory-Landmark.html
       https://en.wikipedia.org/w/index.php?title=List_of_WLAN_channels#India_2
     - Linux wireless-regdb db.txt format docs
    Signed-off-by: Gaurav Kansal gaurav.kansal@nic.in
---
 db.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/db.txt b/db.txt
index dc72989..0f90f6e 100644
--- a/db.txt
+++ b/db.txt
@@ -974,12 +974,20 @@ country IL: DFS-ETSI
 # Source:
 # https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
 # https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-1048e-dated-22102018
+# Info about 6 GHz added by Gaurav Kansal (gaurav.kansal@nic.in)
+# Lower 6 GHz delicensed for India: 5925-6425 MHz (on 21.Jan.2026)
+# LPI: Low Power Indoor (indoor only) — 1000 mW = 30 dBm EIRP
+# VLP: Very Low Power (outdoor allowed at very low EIRP) — 25 mW = 14 dBm EIRP
+# https://blog.gauravkansal.in/2026/01/Opening-India-Lower-6-GHz-Band-for-Wireless-Use:-A-Strategic-Regulatory-Landmark.html
+# https://blog.gauravkansal.in/2026/01/Gazette%20on%20the%20Use%20of%20Low%20Power%20and%20Very%20Low%20Power%20Wireless%20Access%20System%20in%20Lower%206%20GHz%20band%20-%202026.pdf 
 country IN:
 	(2402 - 2482 @ 40), (30)
 	(5150 - 5250 @ 80), (30)
 	(5250 - 5350 @ 80), (24), DFS
 	(5470 - 5725 @ 160), (24), DFS
 	(5725 - 5875 @ 80), (30)
+	(5925 - 6425 @ 320), (1000 mW), NO-OUTDOOR, AUTO-BW
+        (5925 - 6425 @ 320), (25 mW), AUTO-BW
 
 # Source:
 # https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968f-0050569b0899
-- 
2.47.3


