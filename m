Return-Path: <linux-wireless+bounces-21479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9CA87329
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Apr 2025 20:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C123B88B1
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Apr 2025 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BFB8635D;
	Sun, 13 Apr 2025 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ZOcjnBoD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55F21DB125
	for <linux-wireless@vger.kernel.org>; Sun, 13 Apr 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744568740; cv=none; b=DY0tPpUaXSsKcsj90rH8wsUDlUw2oivFBSphkO8YQn3VVLU47t8Oda55kWYe7DLDG9LhOqh4dxQuqW8gmS/PCBYZyqzmRK/M2lTvA9MtcRqv2XSDqm12eJrlxWo6C1bNskw8MAuxRcve+Cr71Vh6bsyqwWmIN5/E9+YTH+YA/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744568740; c=relaxed/simple;
	bh=Dwt5Ro1spF9Iv4mxppwvYBB4ss2h2Uvm+6L7QixRLpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiJdPb63agSAstM0qHa7rKQ0DIsbY73fgwkwk42pLBtgMFP9QmF3oJ5Nx4yuA1epdXK0oFQ/0al1nmJLXXp8XdXNo/fZnPs7T6arN6Yv5OAnK3Nw9E7tQrhdCZM/oGAAmxiOwrbLoOGy6nGa2FzIgtNYgdCzayuXV7OlL7Bi6Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ZOcjnBoD; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.110.50.141])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 718A5600BD;
	Sun, 13 Apr 2025 18:25:32 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 20DB680075;
	Sun, 13 Apr 2025 18:25:30 +0000 (UTC)
Received: from arrendajo.lan (174-21-144-103.tukw.qwest.net [174.21.144.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 630A813C2B0;
	Sun, 13 Apr 2025 11:25:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 630A813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1744568730;
	bh=Dwt5Ro1spF9Iv4mxppwvYBB4ss2h2Uvm+6L7QixRLpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZOcjnBoDk6g/fIDBNcyZ1HXpdMVeM+8qEncVNPhqdqU7ZtQpCKxIw5z9pXgwqu8C8
	 4iLHa/DnL7Ou4+C/Bl0kRNOF3+0TRhgxW3e++AY1HM2kJXPRlUIZhLTeYrTXt1cT0b
	 wUuk60eJ8HcigzA5Z3odoXEpWA7p5dfqZF+AlVPc=
From: Alex Gavin <alex.gavin@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Alex Gavin <alex.gavin@candelatech.com>
Subject: [PATCH iw 2/2] iw: scan: Decode additional WPA3 group ciphers
Date: Sun, 13 Apr 2025 11:24:55 -0700
Message-ID: <20250413182515.10755-3-alex.gavin@candelatech.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250413182515.10755-1-alex.gavin@candelatech.com>
References: <20250413182515.10755-1-alex.gavin@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1744568732-elhT-HY0DLa6
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1744568732;elhT-HY0DLa6;<alex.gavin@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

These values are taken from the publicly-available WPA3
specification available on the WFA website.

The values also match hostapd keys 'group_cipher'
and 'group_mgmt_cipher'.

Signed-off-by: Alex Gavin <alex.gavin@candelatech.com>
---
 scan.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scan.c b/scan.c
index 63babdc..c2c04ac 100644
--- a/scan.c
+++ b/scan.c
@@ -807,6 +807,18 @@ static void print_cipher(const uint8_t *data)
 		case 8:
 			printf("GCMP");
 			break;
+		case 9:
+			printf("GCMP-256");
+			break;
+		case 11:
+			printf("BIP-GMAC-128");
+			break;
+		case 12:
+			printf("BIP-GMAC-256");
+			break;
+		case 13:
+			printf("BIP-CMAC-256");
+			break;
 		default:
 			printf("%.02x-%.02x-%.02x:%d",
 				data[0], data[1] ,data[2], data[3]);
-- 
2.47.2


