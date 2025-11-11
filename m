Return-Path: <linux-wireless+bounces-28847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EB5C4EAA0
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 16:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC3B188086A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0E125C818;
	Tue, 11 Nov 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="UvgHQIQP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A02FBE0E
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873094; cv=pass; b=QQzBwBI8dTr/1PNN01vGxG3qh4eJNu1zor+u4Koflp1boYhuUMPPhnlrjoZ244EwPpfAdi6XKHczWTgUqLKBclT0TM5gNUEOCf8AqjvZ3jxNWaJmQa2+LpkUJbIClCd9FoAszcdMCO2swy9AuXODI64/oLvIbaKl8fzpfzciiYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873094; c=relaxed/simple;
	bh=wov2dI0P1si6TKBrwKax+HI5BoJrDULMkXV2xeTGA2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9MzZDnIS/RTlK8jFrylwAh+mrgmsyS+lBah//7U2quVjpUsKXNubM9s+0PlQSTJ6jOPJyJKaidojq5bajHnt3fWPa2e31rN34ybcKYeGJTgx8heBWwCLIpac3nYUcotVd1PYMYvPVUMa6nu9Co+M1pYt+xBlfarWqgAoA1ouy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=UvgHQIQP; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762873089; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z0p1q+Fc+NN82p9cL85ScoI8Zqlj7hXvEjS9ahBEAOHAA/ZQ2iakdPNLrlxEatLMx9btTHYWTu78kE/AIKaqgMvqycktILqV/c7JTU1l9z35vMLYSfh4uCSJ1a/C2KvaOPLfhbUXkkYASvdBsoaUFnVnWPTAD7ruWsq96svPlJI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762873089; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mIQrJeve5Fn/nVlxZNf6VuuGMd7uDxjrWkF9hPRUDnk=; 
	b=UXzbg6GgBkDPL3aCA840tuwpy4MxB9bkteGkPa8I2fVaz3pOra5Ly6KL7GpMTk2THR5XZ8v3QTgG8M2DwnAao2dxOr91fuxfL8JZgShDA39PrdVnZiuxazKWLQwE4K0Q69tzt6dE/MzsBwfwYPbe/vi+vuQeSDjg8mfBCFXVvCk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762873089;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mIQrJeve5Fn/nVlxZNf6VuuGMd7uDxjrWkF9hPRUDnk=;
	b=UvgHQIQPM01Tva9DwJdAS1htlIxG7UpZiAmOZvxIGkCrTL9WpKyjSjtHOMqEQY9b
	MImudR4GSxdfW/VhYCsPfmnr3zy4zidXRVksTGTySeajjQwhVOcgUrBbEdxLU2iYzZs
	Z6CDLM+qhVT+XmNzVpS0XstrwepSsnSVZvmrCuog=
Received: by mx.zohomail.com with SMTPS id 1762873086852253.66479691846257;
	Tue, 11 Nov 2025 06:58:06 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v3 0/5] wifi: mac80211: refactor CMAC implementation
Date: Tue, 11 Nov 2025 22:57:54 +0800
Message-ID: <20251111145759.111691-1-m@xv97.com>
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
1. Add proper error handling
2. Remove duplication

Every patch in the patchset has been tested with mac80211_hwsim and the
result looks good.
---
Changes in v3:
- Drop patch 1/6("wifi: mac80211: remove an unnecessary copy").
- Rework patch 2/6("wifi: mac80211: fix CMAC functions not handling errors")
  and patch 5/6("wifi: mac80211: refactor CMAC crypt functions") accordingly.
---
Changes in v2:
- Remove words in commit messages stating that only compile is tested.
- Remove Fixes line in patch 1/6.
---
Chien Wong (5):
  wifi: mac80211: fix CMAC functions not handling errors
  wifi: mac80211: add generic MMIE struct defines
  wifi: mac80211: utilize the newly defined CMAC constants
  wifi: mac80211: refactor CMAC crypt functions
  wifi: mac80211: refactor CMAC packet handlers

 include/linux/ieee80211.h |  14 +++-
 net/mac80211/aes_cmac.c   |  64 ++++++++---------
 net/mac80211/aes_cmac.h   |   6 +-
 net/mac80211/aes_gmac.h   |   2 +-
 net/mac80211/rx.c         |   6 +-
 net/mac80211/tx.c         |   6 +-
 net/mac80211/wpa.c        | 144 +++++++-------------------------------
 net/mac80211/wpa.h        |  10 ++-
 8 files changed, 87 insertions(+), 165 deletions(-)

-- 
2.51.2


