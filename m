Return-Path: <linux-wireless+bounces-27885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C83BC4775
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 12:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 595174E4C2F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 10:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08E52F617B;
	Wed,  8 Oct 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="DjCRC4S7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94865208CA
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920959; cv=none; b=UR8N8LkpHRbsr9rMO9+mUh9zewLEcKCQNaySCQ+lVrZVpimO0M0wgzZlZYBhjX0YnIkCnfTMCJ2D+wZZc5m/lgF6FYa98lldoczPTxhY96ObvmPtpGrxaGJEfbD3Eu6KICuxWA4W3F/uEqdAWPvBcNSaIz6nAZlNX3z8TQxmoUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920959; c=relaxed/simple;
	bh=fty4qe0rTasQ+aXjki8jrPRsNk1+66Z5vcfvciKkOKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GFK+KFjDGPwHHaUbj1ftJ7aPrgIRxKlToxhCv84SxQ+eIQyuCPWDLKx+9IkyeaFFkauO/ma73H/kJvz1lP3QGc/hn9kgIucP/ahZYGN6TGNP77xuTXnd8EVrMpYIbX+amYuc20Mo/1Pc+PxaP2SgpVfR4+pETSsWlg86AreVdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=DjCRC4S7; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=I5eeA3CDXkVLGTfpHcqbLFPozBfOCQBSXzveel3DE6w=; b=DjCRC4S74JZepRIWRjroiLlKag
	oVbKxl7mGiMl5IINtvTgM8uZVOVfMhwBiyI8Rnymwz9Foj4Rn7ISRginVFW3qoJ5iVFNNBKwjH7qL
	iP9ddz944p/ol2JjrzEzVVus4IF6qZbsvmDenAf3oG4peTnjQDrIKV+XDbWHRzbvbs6M=;
Received: from p4ff13580.dip0.t-ipconnect.de ([79.241.53.128] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1v6RdD-001RwO-1G;
	Wed, 08 Oct 2025 12:42:51 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: steven.liu@mediatek.com,
	Evelyn.Tsai@mediatek.com,
	Shayne.Chen@mediatek.com,
	Mark-MC.Lee@mediatek.com
Subject: [PATCH 1/2] wifi: mt76: fix license/copyright of util.h
Date: Wed,  8 Oct 2025 12:42:49 +0200
Message-ID: <20251008104250.46292-1-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extra copyright line for Ivo van Doorn and GPL license was only there
because of code that I had already removed before the initial upstream
submission of mt76.
Remove it and make this header file use ISC license like the rest of the
source files.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/util.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wireless/mediatek/mt76/util.h
index 260965dde94c..037d39a55f71 100644
--- a/drivers/net/wireless/mediatek/mt76/util.h
+++ b/drivers/net/wireless/mediatek/mt76/util.h
@@ -1,7 +1,6 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-License-Identifier: ISC */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
- * Copyright (C) 2004 - 2009 Ivo van Doorn <IvDoorn@gmail.com>
  */
 
 #ifndef __MT76_UTIL_H
-- 
2.51.0


