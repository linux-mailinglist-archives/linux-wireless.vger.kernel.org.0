Return-Path: <linux-wireless+bounces-28913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EA7C57D55
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 15:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A04B74E16BF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 14:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3B226ED4A;
	Thu, 13 Nov 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="FuzMtxyM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB8246774
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042722; cv=pass; b=Z/ahzyOZmqXokaRuWM8aDstRDvZee85XMj5IPwTcoOfKLJ5YofkKuEUHAKjjxV/dB74s8JKkhrBmKgsad2WAqujPE9D8xOsnCuskmNt1kIH5Lc8MDQ7cP6kEHeZbT93pq8cKVDUOh2tmTXHOyvrVHsHn8I5C/5UppxxDN8lWXmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042722; c=relaxed/simple;
	bh=CAGCBt8qMVLYEEFYO/iCRhaXjbapimC/BQNBqygh+yY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Om0qZ51Y2zXEYwe/7/GGShRhpUrZCz4KU15DMEx3bc58PdcrfUx2uiLeyaQBRfFRmT1DKxoQy19kWdYS9JXtXGX11hFQS+aCZcA9kkRUqyy8XliTbseASLHzTWi7OjQnR+awHrEApDMaQzRBfvmAWvr1ewW5xpmdQfvN4xyAewU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=FuzMtxyM; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1763042718; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oH//9aSm5K6t4t+M+PT/GEDaLfWhAliFgjg77TK9e78BKAgZxjdx4KzQCQ4ZdkaWuRAUr5PDnlwuiXNY/tyokPj41Cqvihn2ZiNHycox9qX1g3bvLIqtyz9Q5DA8Qb+3KZWHsFBvqIQS7JsrscdVBNnyLkVui86MZRRmdx/8SAw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763042718; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KjWJKYhxwAFCcMw9eDhRvNfliwxx7vfoAT7Hdy+ON5I=; 
	b=LLqd/jbVUWeCnRkJbp6NfUNrqhrt2OImjCe2tYjdCZ72TRH43cP0jkjvaCLOXEFC1xe2PSYR3aU7tdTYuJkYiS1mWWXo6LgOWv8oqGCAUHEFfyCUCXOJxu8m6nTX55S9vTzD6bpTl6fpM1oMd2ooKL7/tQIsyRZcOkvSvACmlvI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763042718;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KjWJKYhxwAFCcMw9eDhRvNfliwxx7vfoAT7Hdy+ON5I=;
	b=FuzMtxyMOEBeN3waknIs9dgHtNMsXG/b6uRnaUgc0J6Ai/iEGniWyoVImOmr4mbe
	Fj0ujQ/Is/Us9E3fZKndt0IwXnZ6ucXffz2XjrOs6B3Cq1OzvULMGvPtida4e8KXzgP
	w8tqCvQSub2rjLFnFEN82TjHp24ZeX4bD45LUUaY=
Received: by mx.zohomail.com with SMTPS id 1763042716448702.0229100875476;
	Thu, 13 Nov 2025 06:05:16 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v4 0/5] wifi: mac80211: refactor CMAC implementation
Date: Thu, 13 Nov 2025 22:05:06 +0800
Message-ID: <20251113140511.48658-1-m@xv97.com>
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
Changes in v4:
- Simplify error handling in CMAC functions.
- Use the newly defined constants in all available places.
- Unify output handling in ieee80211_aes_cmac().
- Coding style fixes.
- Remove cumbersome words in commit messages.
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
 net/mac80211/aes_cmac.c   |  60 +++++++---------
 net/mac80211/aes_cmac.h   |   7 +-
 net/mac80211/aes_gmac.c   |  22 +++---
 net/mac80211/aes_gmac.h   |   1 -
 net/mac80211/rx.c         |   6 +-
 net/mac80211/tx.c         |   6 +-
 net/mac80211/wpa.c        | 148 ++++++++------------------------------
 net/mac80211/wpa.h        |  10 ++-
 9 files changed, 96 insertions(+), 178 deletions(-)

-- 
2.51.2


