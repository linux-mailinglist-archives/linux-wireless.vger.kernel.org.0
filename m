Return-Path: <linux-wireless+bounces-16099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2C29E9C73
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B007A28444B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12A815252D;
	Mon,  9 Dec 2024 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dipier.ro header.i=@dipier.ro header.b="BxHgg+xn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from qs51p00im-qukt01071502.me.com (qs51p00im-qukt01071502.me.com [17.57.155.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31604152E0C
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763754; cv=none; b=abaKKmE/Sv1i76ho6NGAwtICSCHcPmKhKRoQ97q1qCwbktUazaejNVWADAXxnz89jZLryPLuMIHZg4Zq3zjDmCWWD2j6kKVC2GQh3dhXaCm/qrgIHlv45xWZGZb4OnubW5D2bmANtZ76rb4C2s5I4iEXyMv+Gm2/WzdPl2X2jZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763754; c=relaxed/simple;
	bh=gRwOE5hGnQ3OMzY7tCzJ7/9N5frjAoaCIM8UhDy3mYc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=L2wcr/BCOvx30ql6m2llPj/u4CxFv6MHsbW+Ua/hpL/toupb9n4dqnC8H+6aXwVUP4CYW6QwIVO0lTT6wfd0yDJMEhvXQMVdQ8J3IuZcAMKKdF3eILfsndpi+qFCQWHPPvlqHOe+qZQXook+JmEZAzJ550QgbyfsgPsSlpfDDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dipier.ro; spf=pass smtp.mailfrom=dipier.ro; dkim=pass (2048-bit key) header.d=dipier.ro header.i=@dipier.ro header.b=BxHgg+xn; arc=none smtp.client-ip=17.57.155.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dipier.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dipier.ro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dipier.ro; s=sig1;
	t=1733763752; bh=FKhrpIUmEQktQ66Pi5QIstHWcM46OciWNPxUSEpxgSA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:
	 x-icloud-hme;
	b=BxHgg+xnvITDR9Jk2O7GBTyoNfDLjaAi/p0Izskfr40Om+oU20kCgz30TfBgPf0b5
	 6CD4lKhdnhsAqUOXny+X8/xMw2WXE65OYLl2CY33/KINkKNRuTuWB5it07I+biZE/n
	 2Mwl1xhT+LFqmuXLuiOhPg9rvLhFcqryq3T7S8bNNsXxHJagBtXz8bjm9KXYeUU2wv
	 dLFfijYCtOkHn/KKum+O649nxcznsd636SVWblbRiRx0qqjGEn1vlOwRcsTO/etnp3
	 35tiFcgdyajUX7lRH+wASfrwwcUIzpyrr7XDVLbeVkstNVTAMFSseU4o47WgUrtuif
	 h12qzBzCuyduA==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071502.me.com (Postfix) with ESMTPSA id 79E7466803DA;
	Mon,  9 Dec 2024 17:02:30 +0000 (UTC)
From: Avgustina DiPierro <tina@dipier.ro>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.2\))
Subject: [PATCH] wireless-regdb: Update regulatory rules for Armenia (AM) on
 2.4 and 5 GHz
Message-Id: <EC8B2D35-4EE1-42B1-91D0-46F788EF6C61@dipier.ro>
Date: Mon, 9 Dec 2024 21:02:17 +0400
Cc: wireless-regdb@lists.infradead.org
To: linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3826.300.87.4.2)
X-Proofpoint-ORIG-GUID: E-a5PuBRSGVKhEETKUHckZYbPOv7O_W8
X-Proofpoint-GUID: E-a5PuBRSGVKhEETKUHckZYbPOv7O_W8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_12,2024-12-09_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1030 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=740
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412090133

1. For 2.4 GHz range, based on reworded subparagraph 9 from
  https://www.psrc.am/contents/document/4749

  * 2400 - 2483.5
    - 100 mW EIRP

2. For 5 GHz range, based on amended subparagraph 10 from
  https://www.psrc.am/contents/document/11375
  which also supersedes the previous document

  * 5150 - 5350
    - 100 mW EIRP
    - indoor use only
    - DFS required
    - TPC required, reduce limit by 3 dBm to 17 dBm

  * 5470 - 5875
    - 100 mW EIRP
    - indoor use only
    - DFS required
    - TPC required, reduce limit by 3 dBm to 17 dBm

Signed-off-by: Avgustina DiPierro <tina@dipier.ro>
---
 db.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index e282e3b..7e6c3b0 100644
--- a/db.txt
+++ b/db.txt
@@ -81,10 +81,13 @@ country AL: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 
+# Source:
+# 2.4 GHz https://www.psrc.am/contents/document/4749
+# 5 GHz https://www.psrc.am/contents/document/11375
 country AM: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 20), (18)
-	(5250 - 5330 @ 20), (18), DFS
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5350 @ 160), (17), NO-OUTDOOR, DFS
+	(5470 - 5875 @ 160), (17), NO-OUTDOOR, DFS
 
 country AN: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.45.2


