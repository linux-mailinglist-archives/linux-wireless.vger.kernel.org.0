Return-Path: <linux-wireless+bounces-16122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBC29EA2D2
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 00:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CB51667B6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 23:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E011FD7A4;
	Mon,  9 Dec 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="DvVcO4lE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BD1FC0F5
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786890; cv=none; b=TpiiV1/4KtsXSOUAvqaOTIHe/ZcHJk9HbyP14Lh1YQiAWPKHdL+vkjihIPD9GztLXKYrawb30ps+c2D0EKWbelS0AFb+YD65O7Uv/z8Zb9ui5u5mcvK7t8lLC6UzPwnI/ZhssSo5aP98D8LXiaM4nZ9lUbbPu9co6B2WwyxpMgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786890; c=relaxed/simple;
	bh=fVTRvh6PaEPhEbOwv3lVUNHwghRuxE+j5Pg5nJ2F/jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jz+ppa9q4Cva9yYOg/SfXtCNgLOabbrNOfsxvga05JIUeJUHNcsuSR+0WrYadvp9oeYimFfR7Tki3lFA/n3Jkj+QykL9ix6h2JhIJZI0hMtjN8UYtIXbmKDNfFuSFVVVUNJyuDV2C0YYM/jIiLNIyJNrctp7rgWjoTsE9O74M04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=DvVcO4lE; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C052A2A55A3
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 23:28:02 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A4596100086;
	Mon,  9 Dec 2024 23:27:54 +0000 (UTC)
Received: from corvid-conspiracy.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 224EF13C2B0;
	Mon,  9 Dec 2024 15:27:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 224EF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1733786874;
	bh=fVTRvh6PaEPhEbOwv3lVUNHwghRuxE+j5Pg5nJ2F/jg=;
	h=From:To:Cc:Subject:Date:From;
	b=DvVcO4lEcA7Zr+mq834n+I2n44++jcmqAwmZKHKkPEo702zF3P5HVDNPf+ZW+Fbd9
	 gTK9d1P16jTZiAPb+XMluN/aTwzJp90G1sgbzit02js91YvpKovMP+EmEC3PfnKPvF
	 PumSDk0bJQ16p6AS38w1HSwGvWU3sFGfVd8U/K5s=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH v5 0/2] iw: scan: add EHT beacon info support
Date: Mon,  9 Dec 2024 15:27:48 -0800
Message-ID: <20241209232750.416604-1-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1733786875-vkw7aTSIoBFy
X-MDID-O:
 us5;ut7;1733786875;vkw7aTSIoBFy;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

With the recently upstreamed changes regarding carrying an
ie context around in the scan parsing, a more sensible 
implementation of EHT capabilities parsing in beacons is
made possible. With this, the changes have been broken up
into two patches for better isolation.

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

 ieee80211.h |  1 +
 iw.h        |  1 +
 scan.c      | 21 ++++++++++--
 util.c      | 99 ++++++++++++++++++++++++++++++++++++++---------------
 4 files changed, 93 insertions(+), 29 deletions(-)

-- 
2.47.0


