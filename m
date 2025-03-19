Return-Path: <linux-wireless+bounces-20575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D96A69830
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 19:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B227189ED9D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B4207DF9;
	Wed, 19 Mar 2025 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="sGNZyZX3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E9187FEC
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409571; cv=none; b=W8wOOg1FrzFReykmZgMe7Tk0sPGJWxEH5yW/BwUlIZieHOmCjjhhvmKbDSHTczfDSycQxlDdVE56ksxXKqUzdO+hO84zcPKr+zfrJ1EoxJDHakUPj6PKwuqEpDOjhbm18aQDbVt3xPajsl385HxdbN18fCZGpJOc3gQRCzeidMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409571; c=relaxed/simple;
	bh=XmImYlIneGsHAHlF2+JVSF4kvnmfIQMkTM8Qi4NQT1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fsr4dPnxGj4OXMC8j+Qe9Sd8TaVFMwlOCJ+iYq08M76O0LTreGtHZqUZW439T9974usYIdy6pJaMGQsyTg17NIoc6SIJaLPkb2VcrMPNe90Hu7uwyFS0KAPScLv/NoHbE/7wNMwrxTHulsopFfzZb+ZFTw8uDHxDCpvi3m5Jt78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=sGNZyZX3; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0D04944006B;
	Wed, 19 Mar 2025 18:39:26 +0000 (UTC)
Received: from corvid-conspiracy.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 4364013C2B0;
	Wed, 19 Mar 2025 11:39:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4364013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1742409566;
	bh=XmImYlIneGsHAHlF2+JVSF4kvnmfIQMkTM8Qi4NQT1w=;
	h=From:To:Cc:Subject:Date:From;
	b=sGNZyZX3MQ8TNuqMLxlRy73ftPvRHDSnMM2mBMTNnkL2h8JLTcHIyXf4UrWCw1vV4
	 kX5F21Oh3nOD83oRqoVpJZhQRyzRHDdMDG+Py/xvJUxF6oIjWCh8YiKMN8YcYqjasE
	 Du1B7xe6KRs+y9FsrjoZ4uJMnJf244AfuVm9GGGU=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH iw v6 0/2] iw: scan: add EHT beacon info support
Date: Wed, 19 Mar 2025 11:39:16 -0700
Message-ID: <20250319183918.1215853-1-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1742409567-2rv04fUwb7lF
X-MDID-O:
 us5;at1;1742409567;2rv04fUwb7lF;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

With the recently upstreamed changes regarding carrying an
ie context around in the scan parsing, a more sensible 
implementation of EHT capabilities parsing in beacons is
made possible. With this, the changes have been broken up
into two patches for better isolation.

v6:
   - Fix 2.4Ghz MCS/NSS parsing
   - Show bitfield for MCS/NSS fields
v5:
   - Split out changes between two patches
   - Utilize new ie context in scan parsing logic
   - Clean up old EHT capa printing logic
v4:
   - Change s-o-b to use full name
v3:
   - Clean up changes and drop HE logic Johannes commented on
v2:
   - Fix mangled subject

Dylan Eskew (2):
  iw: util: update and clean up eht capa printing
  iw: scan: add eht capability parsing

 ieee80211.h |   1 +
 iw.h        |   4 +-
 link.c      |   5 ++-
 scan.c      |  34 +++++++++++---
 util.c      | 124 ++++++++++++++++++++++++++++++++++++++++------------
 5 files changed, 131 insertions(+), 37 deletions(-)

-- 
2.48.1


