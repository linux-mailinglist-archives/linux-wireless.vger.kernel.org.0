Return-Path: <linux-wireless+bounces-21162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EA8A7CB8D
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Apr 2025 20:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A82188EC64
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Apr 2025 18:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11591A76BC;
	Sat,  5 Apr 2025 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="NzCsiTaE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE64160783
	for <linux-wireless@vger.kernel.org>; Sat,  5 Apr 2025 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743878901; cv=none; b=bm/Se5LofJs4T9FvWzfb3h+FbByqda3Hg2PbISHxSUEfCpPHhjc/8qHsQ/JMyVDGV31FtOqUBbMGqSn8+jRppOlhP67L9iZ/dfixZR6mAJ/ZAKg+83FsK1F/EcOjkcJYCWzn3O+r1jSM3RlIHDlT4Ij6lZjaFwqV+S5zo3LX224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743878901; c=relaxed/simple;
	bh=v8RViTZRbtApVOT/DclwTjZo3K79mr9ZP1w+bZTFNUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tCdEatEsuUfMVeaeOmO0uXUHnS7K6TfRH1I7ChnPzQIAzvfrpFAmf8YaEr6QjBCxVjsI8DnGPpMSRY2qCLeg8IrvjD51JcpNHlAP2f9rwdwdsLVmdR7Z0JVTtIFAlpu2hILmN0SjiUMtBtnrZUPY/0Y4p097lF8Juwq5Es5hM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=NzCsiTaE; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 33500 invoked from network); 5 Apr 2025 20:48:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1743878889; bh=UzPzJxOPJXobyWkeuPHE+ERxY9/VLsR5mTkNuASlJuc=;
          h=From:To:Cc:Subject;
          b=NzCsiTaEn6rfkDcBthkIRg61HNUW/GtiA/rcNCwEI7RU/kYNTKKklHXXB6ITTz3uI
           8zvBr2ufZqxASgR2zrLQJvj0IwBvEV4zAAZyBwES2R1MUh9XCvdGWmYoKD4sxPmbi7
           uBLbD29mi4fXKTn3JRsd5d93KlBEYKCJzJQJJi10sIK9pt2gRiqqQfzo8SLLF2RTdh
           4SIy39NOfPvZ4ofqgiN0NeQYPdh8JzyAEMhhqrH0yfLc6n3DkhPLShF6NkKcdEdEkj
           177WolXxKXg85KAmcus2g6eC7sZXbCZxAI5FqHRaUEfLx1pI41YL/Wo035+mm3PD0T
           SffTYNLgNt2Pw==
Received: from 83.5.244.88.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.5.244.88])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes@sipsolutions.net>; 5 Apr 2025 20:48:09 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: johannes@sipsolutions.net,
	ilan.peer@intel.com,
	christopher.a.wills@intel.com,
	slakkavalli@datto.com,
	john@phrozen.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH iw,v2 0/3] iw: fix HE and EHT information on Big Endian platformas
Date: Sat,  5 Apr 2025 20:48:04 +0200
Message-Id: <20250405184807.701728-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 087077b0e0718edef62d86f0599e903f
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [gbMU]                               

IE fields are encoded in Little Endian and are not correctly
printed on Big Endian platforms.

v2:
 - added EHT capabilities patch
 - minor code formatting changes

Aleksander Jan Bajkowski (3):
  iw: fix HE capabilities on Big Endian platforms
  iw: fix HE operation on Big Endian platforms
  iw: fix EHT capabilities on Big Endian platforms

 util.c | 50 +++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

-- 
2.39.5


