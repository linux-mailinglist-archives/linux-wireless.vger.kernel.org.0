Return-Path: <linux-wireless+bounces-28700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E7C43F8F
	for <lists+linux-wireless@lfdr.de>; Sun, 09 Nov 2025 15:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A652F4E2AE5
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Nov 2025 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637DD2F83A7;
	Sun,  9 Nov 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="GwEWE0Lz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A92EBDDC
	for <linux-wireless@vger.kernel.org>; Sun,  9 Nov 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697102; cv=pass; b=JTGwa/9VUb/Ro3ZoVS+YbGNvvGy5B8p9HsP2l69JGV8jpXLWk4zBePkOzOlCZqcfgsN6aPdZdmVGCQXeoZaFaH0ow+obqjXpOdZQ6qJDid4WcsEHj1QW3+yt6SgOA5YAr68lbGGpKUZ2HoLs1Ilo+1hcqlaLSa9rwo2YHea0DYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697102; c=relaxed/simple;
	bh=hlYZLS8eC6iP1bKUeJ5MTfSp8YLSGQhWLgNcTtS42Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GH+klx6dTgJJ4xN/yGp5zBVGDKp6XXCc6t77pPYSi5jW3yMknELAlFnUK+vhUVopsWbCGd9PHJd0UyjJl2vVBIqBl2OZE6PWtO7uvZo9e+RtMjT13opfipyBndMnhder2F2PEKOgNKF+aL8PgRNb6BicZgXgpbXTSGTri7W/QHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=GwEWE0Lz; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762697098; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k6EzVzLFTQOIP4H8fDA7oIeeNB6NpYJo/Mb50lGW3EykN0bOlisHs+j0XyuMq2GxEjSopxCQrFtbfvkhxLogfwzYNae/a9Y+ktaNI4BTqEmQcZd6fEPK0RHW1GagsvzAGzKvvY3HD3zhrvJ3mVdXcRtRZmXwpEewZecwrhpCoHk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762697098; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ESnT+KstWgNLUWZ/+Mxsqe6f0SP1oG201igxyyNDl90=; 
	b=GG8VRX1KSCYbvbxDijVczwMRLBnx0X5tJTl50sL5bD24m+eSDsVGxsQEgWHwSbP2kNeevOr3cbgqT4oCopAojenAhXRFMLJTEza02C/SFlFoqWRhlAx0vlDaU31Cjcnm+1d2JjNAwDq0vg58JGlG/lQBJJiWZez1AP7FI4GMTFw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762697098;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ESnT+KstWgNLUWZ/+Mxsqe6f0SP1oG201igxyyNDl90=;
	b=GwEWE0LznfttOiHCq1DZVUsWwzDUmjmxEnO93N+5Ka+QswYxBuP/lAI1q99+Vmo/
	Ebe5L24GvpGEa4mGSKtHZlrVYkKCwFBzPAcM9gFB89yAFF0aA9uDtknCMnnMWCydtRL
	2Etoj86CvvsrTHpJn3yrWlylcfq5xOhiEr0c0PWM=
Received: by mx.zohomail.com with SMTPS id 1762697096105703.0027215487275;
	Sun, 9 Nov 2025 06:04:56 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/6] wifi: mac80211: refactor CMAC implementation
Date: Sun,  9 Nov 2025 22:04:44 +0800
Message-ID: <20251109140450.118106-1-m@xv97.com>
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


