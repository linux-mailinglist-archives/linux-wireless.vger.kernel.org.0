Return-Path: <linux-wireless+bounces-27936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F9EBCEC7A
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Oct 2025 01:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E5DF4E538E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 23:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D90E2EA173;
	Fri, 10 Oct 2025 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="NzdwH1n5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A5727FB2F;
	Fri, 10 Oct 2025 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760140667; cv=none; b=gptf/FcOPoJ1IlkMRTCQp3vIT5/hVVKpGJKXnZ71HGniQTYzMCbeWm07hI52aOCxQVXvqN5/0gFBoU2V4le/To2xWur6HOa9M1m2w9WbyfRKMxq1ee/dJr0/iRE3dSG6AGOouNoZNdXUDyKvbE0AEfYseYw8+2WekiWg7lbDqCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760140667; c=relaxed/simple;
	bh=dN3O/eRcSJ8pvlqe+Qc1o3R9+nVl7l4ABYLURk0fPMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQCy6+7nzMXameZpF9OuYhey+YhLKqr25/1kDSK4eLGhSA5c6o8yaI+QCimFJdqjySJ42mlGEI+i22BHGxMM46ydBvin8fipLkVmmwxZcYxihx/dwLTfHnWvJi9TT92PcvspbHrDUH5EZKCMjTOaTI8Jir3IAwY6NfWpA140sis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=NzdwH1n5; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=HgqYiAk62nEUPgGef5NNfJTUURXX9WcPG3XzwfzVYVk=; b=NzdwH1n5XSFfLDx2
	LltVrhHkI9X5N5e7mya3M/RpMTwE6yKIZK+TlrzHL9zAGamtrJOKCJC1or3so5uFVqXxDwE80rnls
	nXJyhAH2coORgYWGhQCunNx1fW4G9n1dZA85V3k2M7YJoyucnSSBGYkU2wHjJ7oWnJISNpvSJdVsP
	LPKzFjezCNHAW1SYP8o6SEOM1ZVvca4R97KR8EWAEXqVGJLmu9nMWvU5mCfiuSbbRM1eGDpRPKa1m
	UJTg0cdblS+SAOW0tHrr2+ljtax+7FKSItWc7f9jiYCeNNIdj7DAkKLPDZQ+Z6osIC+/ymCsJd7NX
	xssklnuH5aCzGj5Bcw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1v7MzR-00FnsM-1R;
	Fri, 10 Oct 2025 23:57:37 +0000
From: linux@treblig.org
To: loic.poulain@oss.qualcomm.com,
	jeff.johnson@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] MAINTAINERS: wcn36xx: Add linux-wireless list
Date: Sat, 11 Oct 2025 00:57:35 +0100
Message-ID: <20251010235735.350638-1-linux@treblig.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The wcn36xx is a wireless device but doesn't have the wireless
list in its MAINTAINERS entry.
Add it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4886604631d..f681f8b60f4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21306,6 +21306,7 @@ F:	drivers/media/platform/qcom/venus/
 QUALCOMM WCN36XX WIRELESS DRIVER
 M:	Loic Poulain <loic.poulain@oss.qualcomm.com>
 L:	wcn36xx@lists.infradead.org
+L:	linux-wireless@vger.kernel.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/wcn36xx
 F:	drivers/net/wireless/ath/wcn36xx/
-- 
2.51.0


