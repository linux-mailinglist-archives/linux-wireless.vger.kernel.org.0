Return-Path: <linux-wireless+bounces-28679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6C5C40509
	for <lists+linux-wireless@lfdr.de>; Fri, 07 Nov 2025 15:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8501E56279F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Nov 2025 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7411328B4C;
	Fri,  7 Nov 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="E95MYpiF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2152328B53
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525422; cv=pass; b=EWnaocHRlRzmHDWdLgByTpfoOUkJE1UrE5HOx4pSXBjspaNhjFornOEhQ4csUbzg126ToGtKf9jTy2Ro02mLskKWrIZmeYncbknfNB22G2n/jqfsN3ows5SMMDBuOmZZNfBMVD9O607x4IXIA5mRl6D9oAcXNI4qo1hLhfMuQk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525422; c=relaxed/simple;
	bh=kYdmu7m5tcmJ6pkeDIp3d3ZSMRfEM9EKy/93l9kAUYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjHim864xf6DJ8FaTTGNQI1frT1zIq8+nXKEMgdNBCeheWoWiiTsNOTwKJq4egqAtjV3tDlJqV2cZmQIbUQm2e+13EIud6V5bqHfEfGiR0mAfE5kwDyZd9C3lUic7zj9tRIXoQwZUfWVAV8edCXdgV41zCSjzK+d3HVEM27UjTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=E95MYpiF; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762525417; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VsQS2HWGYhoxOGWg8I4fkbFc4FBuc7kxuY4BOtuq80k2Py7+rGNPGggjFR9X5wpCKieLD/8G/gypY+ZOCtdpK3UVpu5r8wKTnFCVK6x3deztQC+F0nCp0DtMWwztAvzTv2Gz7krEY8Hu4VNrx8LuTxMuL8rXDh/4aKYT5SyW9Pk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762525417; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WMd+byUbXGYLtZdo6YadawPUVvaymL3D63gdXIACTBM=; 
	b=Onn9Qu9BNXbQI5lgA81/X/HLv477XgH42oXWQO4AjsJaqlc2UlxfsqdvK3Duow9VZ1jXGz6sQ9rDHV+CF3GB4NjSqVTuds83ZZO2u8YHsH2yh6wD1y41moUBQv+jycaUtKtnOFznRPh0TQnoBwV8DXeFpHilakKR8YaF/S7eJ4M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762525417;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WMd+byUbXGYLtZdo6YadawPUVvaymL3D63gdXIACTBM=;
	b=E95MYpiFyY1oJ25eCY4+WejsF5M2bIC1OFJxB8Ekb913V3ey2Ui+cP+JhQ44tFMh
	UIcrrZSOFUcgGLV/pTJ2tROvnjx+8KHzU8jm6r1vshAKtmOu5hxbCXV5SGWPW5gmJBt
	UvqN9nGHyJcEzw8ORwidPLc+LSTG6858vjrMtDlM=
Received: by mx.zohomail.com with SMTPS id 176252541667721.287471192262842;
	Fri, 7 Nov 2025 06:23:36 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: fix doc of struct key_params
Date: Fri,  7 Nov 2025 22:23:32 +0800
Message-ID: <20251107142332.181308-1-m@xv97.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The seq in struct key_params is for many ciphers, including CCMP, GCMP,
CMAC, GMAC. In addition to get_key(), it is also used when setting keys.

Signed-off-by: Chien Wong <m@xv97.com>
---
 include/net/cfg80211.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f2e8963cfaac..67be17f80ac7 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -786,8 +786,7 @@ struct vif_params {
  * @key: key material
  * @key_len: length of key material
  * @cipher: cipher suite selector
- * @seq: sequence counter (IV/PN) for TKIP and CCMP keys, only used
- *	with the get_key() callback, must be in little endian,
+ * @seq: sequence counter (IV/PN), must be in little endian,
  *	length given by @seq_len.
  * @seq_len: length of @seq.
  * @vlan_id: vlan_id for VLAN group key (if nonzero)
-- 
2.51.2


