Return-Path: <linux-wireless+bounces-21478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BFCA87327
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Apr 2025 20:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC573B0139
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Apr 2025 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E43A1EEA43;
	Sun, 13 Apr 2025 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="AwsSvqkV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F68635D
	for <linux-wireless@vger.kernel.org>; Sun, 13 Apr 2025 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744568739; cv=none; b=hxnf4fUqNwQBYZuFgLyh0DvhGz3MIfO0j0KUd1Xbn+YCxoDT9RrN4KOlBGigwvLPo8U512rUSNFldNAZtYF9Z+JxT2eVOUx5U4djvcoqan6J21rY68Ewtmv1EuAhTGTqC8cn5ay/ianRmMhU/nD9pyVeYK+R8hL8rOXyOrHQrvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744568739; c=relaxed/simple;
	bh=2kFlvAGzKtKZXCZojeJEk9XEUOcNw8sjLKuWvlUNTvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gB4h1STrYmdByZPANNAlOODaEEDEMoJKYp/+iSeOS2fEqPon/a98JuM916W0UozkuE9SWN4JKT56MFhLm34ulJ07IVfRZZw7MULLuuwHxqZLaR9uAdGuw2AhTrUeG9mFMB8D0GBJsE4OccRiT4zE3j/SwOoDkdZrEyxbNzLsFAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=AwsSvqkV; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.7.65.208])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 24F8B600B9;
	Sun, 13 Apr 2025 18:25:31 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EC1E6180069;
	Sun, 13 Apr 2025 18:25:29 +0000 (UTC)
Received: from arrendajo.lan (174-21-144-103.tukw.qwest.net [174.21.144.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 8218013C2B0;
	Sun, 13 Apr 2025 11:25:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8218013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1744568729;
	bh=2kFlvAGzKtKZXCZojeJEk9XEUOcNw8sjLKuWvlUNTvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AwsSvqkVdLz0zYB3/OvAiVTyciAuwqYMkDutNmR1bl8Lz0U7bRt/BevHSiS9CR8e2
	 P6RwRRMuZFrTo5yokn4+udHQ0TaNYZJJPaZwO8g1QUNu0oFwEeh+/uO1mNXoYE7ES8
	 RoDPHECHRH6r6afBx8BP/m4MCvDFKbJiE/km09qk=
From: Alex Gavin <alex.gavin@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Alex Gavin <alex.gavin@candelatech.com>
Subject: [PATCH iw 1/2] iw: scan: Decode additional WPA3 AKM suite types
Date: Sun, 13 Apr 2025 11:24:54 -0700
Message-ID: <20250413182515.10755-2-alex.gavin@candelatech.com>
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
X-MDID: 1744568730-SlWjjF7V7kXe
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1744568730;SlWjjF7V7kXe;<alex.gavin@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

These values are taken from the publicly-available WPA3
specification available on the WFA website.

Specific string choice attempts to match previous
printouts, rather than matching the specification
verbatim.

Signed-off-by: Alex Gavin <alex.gavin@candelatech.com>
---
 scan.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scan.c b/scan.c
index 6cf44d2..63babdc 100644
--- a/scan.c
+++ b/scan.c
@@ -885,6 +885,18 @@ static void print_auth(const uint8_t *data)
 		case 18:
 			printf("OWE");
 			break;
+		case 19:
+			printf("FT/PSK/SHA-384");
+			break;
+		case 20:
+			printf("PSK/SHA-384");
+			break;
+		case 24:
+			printf("SAE-EXT-KEY");
+			break;
+		case 25:
+			printf("FT/SAE-EXT-KEY");
+			break;
 		default:
 			printf("%.02x-%.02x-%.02x:%d",
 				data[0], data[1] ,data[2], data[3]);
-- 
2.47.2


