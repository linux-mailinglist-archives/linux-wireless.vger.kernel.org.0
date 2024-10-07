Return-Path: <linux-wireless+bounces-13633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C4199362E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 20:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C5E8B210DC
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 18:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9285B1DE2B4;
	Mon,  7 Oct 2024 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L6+mVaW7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E11DE2A2;
	Mon,  7 Oct 2024 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325635; cv=none; b=JummIN0IbEzxalzw4aIekG6TXUxZ1MgY8h4qn3mSVpQucV0loNyOZFY8IPI4JsjwKfTVTJ6hbtSM6Wp3+fGPPLYcLl7CfJPK0iFmf/fTCsA4rgyJMbCHgD2B7nvbPt5yYvY5o82hvnbEmy+AeD/6HvRcEVWDcZNM+JkcP5sEcF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325635; c=relaxed/simple;
	bh=9ZYHqui6/v+lnEr6B0RzvfJmNxf+cVjpOiJdDaK5Ndc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvxRiwSHq6klRBuW3dbejwa37W3wME7q9+rOokVVTKrGRYzzbTeUM/uQv9mdDqg267aKhWefUttpkvL9x/7PNhB3AW+BHGPNJQrXv/uohhzHyWfzqkWocTNPiWLDaHxFr/qeCNmbhPD3k54NMvY6XwB53hjw6zAefRTvDYveD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=L6+mVaW7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LTBwHeaf2mySJJSHbbYVsMT/ICvX6Unv8toU94qmDdc=;
	t=1728325634; x=1729535234; b=L6+mVaW7TsDzOuvEO0M+iDrEdduirYzF3mA9BjNf2FbkCJt
	JpG3OzHAYP30gaXgsRXWhqePH7vXPqv2BfDBDXfV+S8cLf3NjnwRPrG8+VkbOekLNhI46oZ8RV3q+
	9fAZY9rqhhLUPiJCmnhsZuuIUY3O2nbi1HLJgoIOua0S3rmZmpxSodwRg3pfag8nHWniFNMZLzXX+
	qhC0qgA5TU8/9ZwcrXczfFWkzxS9CDunduaxkKqyj89NvzBp1kOtRO+59eqVVV4kd2BPvscE9EVeA
	FKdZ2Jm1jqc6NpiWPSD37mGPH+UV7lxlFrZxBz8nZFeuFZR3IeiWQsRynjBAc/2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxsRr-00000003U6n-0ZO7;
	Mon, 07 Oct 2024 20:27:11 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 3/6] wifi: libertas: don't select/include lib80211
Date: Mon,  7 Oct 2024 20:26:53 +0200
Message-ID: <20241007202706.f8a6dd67f650.I74bc1f334c02043a238303d3e71c955d0d9b01b0@changeid>
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

This isn't used in this driver, and should't be, so
remove the include as well as the select.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: remove Kconfig select as well
---
 drivers/net/wireless/marvell/libertas/Kconfig | 1 -
 drivers/net/wireless/marvell/libertas/mesh.h  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/Kconfig b/drivers/net/wireless/marvell/libertas/Kconfig
index 36b234bc5be8..caf8bc231b2e 100644
--- a/drivers/net/wireless/marvell/libertas/Kconfig
+++ b/drivers/net/wireless/marvell/libertas/Kconfig
@@ -3,7 +3,6 @@ config LIBERTAS
 	tristate "Marvell 8xxx Libertas WLAN driver support"
 	depends on USB || MMC || SPI
 	depends on CFG80211
-	select LIB80211
 	select FW_LOADER
 	help
 	  A library for Marvell Libertas 8xxx devices.
diff --git a/drivers/net/wireless/marvell/libertas/mesh.h b/drivers/net/wireless/marvell/libertas/mesh.h
index 44c4cd0230a8..e37db10e82a9 100644
--- a/drivers/net/wireless/marvell/libertas/mesh.h
+++ b/drivers/net/wireless/marvell/libertas/mesh.h
@@ -7,7 +7,6 @@
 
 
 #include <net/iw_handler.h>
-#include <net/lib80211.h>
 
 #include "host.h"
 #include "dev.h"
-- 
2.46.2


