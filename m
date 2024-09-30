Return-Path: <linux-wireless+bounces-13334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1B698ABB2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 20:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC721F220CA
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 18:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E59C1991A5;
	Mon, 30 Sep 2024 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="IZzkuwFu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933DB1991A1
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719921; cv=none; b=BD/3UvO4PUtJqaZ+c+VD5g8ZwMZGBFHkcGhldnYm9Unme4VQlowXdZ+SMBDFYXfiSoqjEi02c7dJi7fNLsUNb3c4V8wNoyaSpYsgDvAKS4iJJKotLbYYxfTyTfFT1PmD74Ns+QVB3KNJGbGD9VtdOahOUK0jXnqMduSVUAYlJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719921; c=relaxed/simple;
	bh=tvO3DLpta3xTiSe4n+Hxofk+nQYPxT+qxAX5R+aBqq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAh6K/I2QLnBkBbe/jKFcmpmo/x9meynSPPfZAXzLYAEWdeE5cQYuigIK8TSiZ3KuumVUz3eMuDzS8DGvPsMWmT1y3EMcWA/IpANWEFDw0wOBGcinKLt2Gm9BdotarJ4XpubToaE+5mHYONQO2fCGO9AwyZsTDNUOfNvymUsM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=IZzkuwFu; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6F766C40067;
	Mon, 30 Sep 2024 18:11:51 +0000 (UTC)
Received: from corvid-conspiracy.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0367813C2B0;
	Mon, 30 Sep 2024 11:11:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0367813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1727719910;
	bh=tvO3DLpta3xTiSe4n+Hxofk+nQYPxT+qxAX5R+aBqq4=;
	h=From:To:Cc:Subject:Date:From;
	b=IZzkuwFuYoWzVMlFlmkktES9AVwZPYVi58+D8Qf8nhxPIG+6CIukE7gWxI5BeKE7V
	 snPiWMF8GKPCua2pITwEAxmNIMFAwpqb2Cs8B2DzDTaUezOzHr2CqCUNRKS1oS9ywt
	 QDAhfORHISbpsxzVGDIs42G8c/cBdKNzEFJ+Snsk=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH 0/3] iw: scan: ie parsing restructure
Date: Mon, 30 Sep 2024 11:11:42 -0700
Message-ID: <20240930181145.1043048-1-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1727719912-JAqfNkof3UiS
X-MDID-O:
 us5;ut7;1727719912;JAqfNkof3UiS;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

To prevent double parsing the ie buffer for ies which require
information from other ies, utilize pointer aliasing to simplify
the referencing of other ies.

Dylan Eskew (3):
  iw: scan: add enum for ie ids
  iw: scan: change parsing from in-place to cached
  iw: scan: replace passed ie buffer with alias struct

 ieee80211.h |  82 +++++++++++++
 scan.c      | 326 +++++++++++++++++++++++++++++++---------------------
 2 files changed, 277 insertions(+), 131 deletions(-)

-- 
2.46.0


