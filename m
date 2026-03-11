Return-Path: <linux-wireless+bounces-32964-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBHgOiQvsWkVrwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32964-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 10:00:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A225FDF9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 10:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4ECC301F5C8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 08:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A38E3C553B;
	Wed, 11 Mar 2026 08:59:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2AE3C454B
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.30.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219592; cv=none; b=TaGVLmV8GeOT2c5rDlvYNNP02FLs6fq+GoA4Tet/8B/zgobBWot6RhtIriuDoFFEHHFttTI0WYQLi+1t1N3vn7rN4VvYVISGesQCvc0KUQgRde4Gfm6m/Gcf81rkoW8QOSFLijBt2C+a/SkephLUQQMCep44NZA6cnOpZFB0cBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219592; c=relaxed/simple;
	bh=C3Z+XgZYlZf6QMcYI2BykTOGu9ZTBFCrHhrSpQyKz94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aKjWIFyCElDxQ5ZQCfVy6K64MlEnTAFJBLo96XGTumJU2c9tMDgwgkfGZc2BJRX02dJ4I5y5GaCl1Ct+Ati9hdVVr6P+50V23XmfEvZKXz1xAWFdIPuyuxZJLA+if1INFExQ1BqRUs6EBdLEj7rwFeIooGQO+n8Z02UyIckvSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=wens.tw; arc=none smtp.client-ip=140.112.30.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wens.tw
Received: by wens.tw (Postfix, from userid 1000)
	id 188365FDBB; Wed, 11 Mar 2026 16:54:01 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: druth@google.com,
	Ping-Ke Shih <pkshih@realtek.com>,
	wireless-regdb@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Gaurav Kansal <gaurav.kansal@nic.gov.in>,
	Degrader Snehil <degradersnehil@gmail.com>
Subject: [PATCH] wireless-regdb: Update regulatory rules for India (IN) on 6GHz
Date: Wed, 11 Mar 2026 16:51:40 +0800
Message-ID: <20260311085141.1634383-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0A1A225FDF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,realtek.com,lists.infradead.org,vger.kernel.org,sipsolutions.net,nic.gov.in,gmail.com];
	TAGGED_FROM(0.00)[bounces-32964-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.087];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nic.gov.in:email]
X-Rspamd-Action: no action

The Government of India has officially opened this band for licence-exempt
use via Gazette Notification G.S.R. 47(E), dated January 20, 2026,
published January 21, 2026, issued by the Ministry of Communications
under the Indian Telegraph Act, 1885 and the Indian Wireless Telegraphy
Act, 1933.

Gazette details:
  Title   : Use of Low Power and Very Low Power Wireless Access System
            including Radio Local Area Network in Lower 6 GHz Band
            (Exemption from Licensing Requirement) Rules, 2026
  File No : 24-04/2025-UBB
  Gazette : No. 47, CG-DL-E-21012026-269488
  Signed  : Devendra Kumar Rai, Joint Secretary, Ministry of Communications
  URL : https://www.dot.gov.in/static/uploads/2026/02/88f0ac8c74eb6f6907934d17d0015ab5.pdf

The Gazette defines two device classes for 5925–6425 MHz:

  1. Low power indoor
     - Max EIRP         : 30 dBm
     - Max PSD          : 11 dBm/MHz
     - Max bandwidth    : 320 MHz
     - Restriction      : Indoor use only (Rule 5)

  2. Very low power outdoor
     - Max EIRP         : 14 dBm
     - Max PSD          : 1 dBm/MHz
     - Max bandwidth    : 320 MHz
     - Restriction      : None

Additional operational restrictions per Rule 5 of the Gazette:
  - Band is prohibited on oil platforms
  - Indoor use prohibited on land vehicles, boats and aircraft below 10,000 ft
  - Communication with and control of drones/UAS is prohibited
  - Contention-based protocol is mandatory for all devices (Rule 4)

Out-of-band emission limit: -27 dBm/MHz outside 5925–6425 MHz (Rule 6)

For now, add a rule for 6 GHz LPI. As the database does not support PSD
information, the EIRP needs to be limited so that transmissions over a
20 MHz channel does not exceed the PSD requirements. This limits the
max EIRP to just 24 dBm.

Reported-by: Gaurav Kansal <gaurav.kansal@nic.gov.in>
Reported-by: Degrader Snehil <degradersnehil@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 db.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/db.txt b/db.txt
index e2842db..d54ef78 100644
--- a/db.txt
+++ b/db.txt
@@ -985,6 +985,7 @@ country IN:
 	(5250 - 5350 @ 80), (24), DFS
 	(5470 - 5725 @ 160), (24), DFS
 	(5725 - 5875 @ 80), (30)
+	(5925 - 6425 @ 320), (24), NO-OUTDOOR
 
 # Source:
 # https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968f-0050569b0899
-- 
2.47.3


