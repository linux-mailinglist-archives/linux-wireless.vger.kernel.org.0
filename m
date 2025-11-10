Return-Path: <linux-wireless+bounces-28793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6DCC47504
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 15:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121F33B0E61
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D082264BA;
	Mon, 10 Nov 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="Ns7V55A2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA288757EA
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785955; cv=pass; b=B0MluRifF+rYEpoxmyMl+XGMS+NRJP4p7x+e6x9iivtA0CU66XOs/YsbMgPXSz146uxLPSh/9sgjooi8WI90W+hzhr5r2nN96mjYOyeIrHMY9KAIZkN4LgSZWxw7akylGHu+cUbcEQA1Kybh3j3HOeVjpsPhIiQgrZTIKmGk1ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785955; c=relaxed/simple;
	bh=6E7oDcVJ1n130wHcRU9PLYYmia/xm8jpbRpTr9SeOkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoPhiul7BLQSe9va32Lwxsn+/2z/qFLTrIHo6aIC25oBwLgWf0Mjdz8Bj3LKDZmpo3tGstDLxlEhjgJN7bXMPW+TQ2aCIRM9rgtpHIbtnZriHi//Mqoh3dty3Pvc7CwKvkHj761CjJjIxFQt4fX7++bYbk+WJ5+4ZENacmRPuwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=Ns7V55A2; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762785952; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fMunakoJqgAak8odfM3aLc+1r89cklHRRhS9Xni63R9LSeMCrhPNzy9YY6tBfpJZfVwGAlsBd1s1JEXZyK0hbdGFf6Pb8SeZvSiClfdzHzZ1i1IOYxsikw4my252m4QIGFv5G6Lr0dcEzNuYQRIRiuOA0XCZch98LOH1YXi14fE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762785952; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vhRIQhjYKB44IdQMAvOaYtpXVHVlzkgpsof1aOL2AEA=; 
	b=P3i3yOz0E+odm98RnptReXWsbqDl3aezO98aL4a3UT6KhBR3w9nJjQ5/IWwjXFe6Q39ty6XBxfXjW+r46NnIutaA9V7UStiiddynFfnTJBqCIRm5u+sXNZ5aPpaluTjKvehLZL6PQMjZYW++Wis46HhIjQRQlhs63msfO0iTn6M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762785952;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vhRIQhjYKB44IdQMAvOaYtpXVHVlzkgpsof1aOL2AEA=;
	b=Ns7V55A2IF+054O28WYQ2ewby9lkcVgN8U9E3rwv2bvbjb9acp8swcPciDxnoRfX
	GJd9OJMNrcnTldYKi7+XK71VjiWlkyExKLn0jMNmTO8tKJQLKrijK/i6nsS54+7XI2E
	UA8gy0waGGOQ2RROhNnc4Z4Nvchcg2Ygu2+FVPRI=
Received: by mx.zohomail.com with SMTPS id 1762785951356141.73707238206362;
	Mon, 10 Nov 2025 06:45:51 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/6] wifi: mac80211: refactor CMAC implementation
Date: Mon, 10 Nov 2025 22:45:39 +0800
Message-ID: <20251110144545.15149-1-m@xv97.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This series refactors the CMAC implementation in mac80211 to:
1. Remove unnecessary operation
2. Add proper error handling
3. Remove duplication

Every patch in the patchset has been tested with mac80211_hwsim and the
result looks good.
---
Changes in v2:
- Remove words in commit messages stating that only compile is tested.
- Remove Fixes line in patch 1/6.
---
Chien Wong (6):
  wifi: mac80211: remove an unnecessary copy
  wifi: mac80211: fix CMAC functions not handling errors
  wifi: mac80211: add generic MMIE struct defines
  wifi: mac80211: utilize the newly defined CMAC constants
  wifi: mac80211: refactor CMAC crypt functions
  wifi: mac80211: refactor CMAC packet handlers

 include/linux/ieee80211.h |  14 +++-
 net/mac80211/aes_cmac.c   |  60 +++++++---------
 net/mac80211/aes_cmac.h   |   6 +-
 net/mac80211/aes_gmac.h   |   2 +-
 net/mac80211/rx.c         |   6 +-
 net/mac80211/tx.c         |   6 +-
 net/mac80211/wpa.c        | 144 +++++++-------------------------------
 net/mac80211/wpa.h        |  10 ++-
 8 files changed, 80 insertions(+), 168 deletions(-)

-- 
2.51.2


