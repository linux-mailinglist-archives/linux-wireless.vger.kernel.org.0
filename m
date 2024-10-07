Return-Path: <linux-wireless+bounces-13631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE72E99362B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 20:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2C81C230D0
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9711DE2A1;
	Mon,  7 Oct 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="v+A3CDKg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1461D31A0;
	Mon,  7 Oct 2024 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325634; cv=none; b=QtAzTkbq2czMfKPB9xzOY7T6ESeyuJ9KmG96W9p6OnjNmNYBkaskvT2qMLZZysnOqK0r42nQ//HLTkQqtuCpftv9f0R92k5Vlev4soSJQMkEzKIoDnZMebRrlNT4pSJ3KCKrzLmKLr/HGQVXQMY4bwVQqJBB92WxO8He8iZtrKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325634; c=relaxed/simple;
	bh=coJnbKiPl1qAg88gsg8yHg7SmLV1fAWZKmebdKeCvV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8My62DaCZ3oDQYAlxmd93eFo9l9mwN9j2dJb6vx1rnIrVQel6+l7f25uu3P/9MOHnKlQkXqJHaNwtAmbgY0cryEnIIKe+tqJf1mJvHYJg9pL6HecK6HgQwMjAAk6w0WZrtSZuMqEuICq1AHkQU15hWGzTIuTZU2hgJOoSAoYd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=v+A3CDKg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=C30AJ1ltqovF7s9EAys6NRtggm2c99WHROZQk/j4jEY=;
	t=1728325632; x=1729535232; b=v+A3CDKg2T7pDu5U4KEILsT9d98rw7B07QO3JcYQXoh+bGF
	PFyByKNjM/JKDvSZvzrQCM40Wlh3x4Uf0k9p3eky3qnbGqApZMP/6qOmdZNip92XMM5Ad8/Uorbez
	u/Nv5CVMNGuc8VdjUIV3O6RSFQLOCG47zgccFDfj4cZAMheVGu+mByjcFvt9kOFE1v0eSnUY0hGlT
	QXp8TvL+vDzKwPxs6yBM2HSGvT2TuwBzaBfz+OhtMsahyACE0KeXLm5YvoYPfQkZ+GagnhvBCMv2O
	JauRevsOIXUP6l7p3Hjnt8KKPRqcMb3IQ4WYAIFHmvOW0/dFZVqe4TQ69kgMUDbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxsRp-00000003U6n-3Hul;
	Mon, 07 Oct 2024 20:27:09 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 1/6] wifi: qtnfmac: don't include lib80211.h
Date: Mon,  7 Oct 2024 20:26:51 +0200
Message-ID: <20241007202706.d92615cbf659.I2dc8ea3df0760121dc202616bdf3942caf51b232@changeid>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007182706.66888-8-johannes@sipsolutions.net>
References: <20241007182706.66888-8-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This driver doesn't use it, and really can't, so don't
include lib80211.h.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/quantenna/qtnfmac/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wireless/quantenna/qtnfmac/core.h
index b204a24074ab..b375a4751580 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -13,7 +13,6 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 #include <net/sock.h>
-#include <net/lib80211.h>
 #include <net/cfg80211.h>
 #include <linux/vmalloc.h>
 #include <linux/firmware.h>
-- 
2.46.2


