Return-Path: <linux-wireless+bounces-21477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C66A87328
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Apr 2025 20:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ABE87A56E5
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Apr 2025 18:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C131CDFAC;
	Sun, 13 Apr 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="F0/YaqiA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B94438B
	for <linux-wireless@vger.kernel.org>; Sun, 13 Apr 2025 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744568738; cv=none; b=JSxSv0f3guyHhQN6nc0KmTGXncPDcyFQszr6CV68xjuI99XZQn76qRVysW3cDTw4nBActHMrR/L14x7UpmWeiQOXZFMUiNIkf6t0iPoKPOduQXs/EorIJ1/N4jqWCP1GrT3Kc4nnnCExE/SXs3U2NaW7YNbx531Sd8zJyol1mxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744568738; c=relaxed/simple;
	bh=z71MQYHjtpY2vQBVcSOUWjqrKzTKFCAZmPIbohcx92k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtfTsYehiXkoDDdEAYunyeHwHACUEeQwb7CorKP2uO0yvS4vHQdYENFUX9YE1skMpfG8Tbz+yUl5VTAqRilZofg2ci7PdjjMgX6xP1x88NpUgqNuq8cHyEfYkrjMY9xUSTBci0e+6PYRX1a+BnIy4bxe7aF1GOR0ZjPte3NVDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=F0/YaqiA; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.110.50.147])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id F161E600E1;
	Sun, 13 Apr 2025 18:25:29 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0580A800069;
	Sun, 13 Apr 2025 18:25:28 +0000 (UTC)
Received: from arrendajo.lan (174-21-144-103.tukw.qwest.net [174.21.144.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 5924613C2B0;
	Sun, 13 Apr 2025 11:25:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5924613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1744568728;
	bh=z71MQYHjtpY2vQBVcSOUWjqrKzTKFCAZmPIbohcx92k=;
	h=From:To:Cc:Subject:Date:From;
	b=F0/YaqiAH8A2vMiZdDCW+sTUT2oJXYsi5u7gwUMErJbh6WGsW7BndG+BRH0Fup1es
	 PF0g1XcvTrF4UAW1T9pMJF0VNMT+FefI0Aeffm2NNxbNlxi+gY+deSOspEJYmk2owB
	 Uu/WoKNJLpPnQTZyaKK2TjyB6zaNSWs2UEtpGKFY=
From: Alex Gavin <alex.gavin@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Alex Gavin <alex.gavin@candelatech.com>
Subject: [PATCH iw 0/2] iw: scan: Decode additional WPA3 AKM suites and group ciphers
Date: Sun, 13 Apr 2025 11:24:53 -0700
Message-ID: <20250413182515.10755-1-alex.gavin@candelatech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1744568729-U0KJ27EsQvQd
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1744568729;U0KJ27EsQvQd;<alex.gavin@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

Alex Gavin (2):
  iw: scan: Decode additional WPA3 AKM suite types
  iw: scan: Decode additional WPA3 group ciphers

 scan.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
2.47.2


