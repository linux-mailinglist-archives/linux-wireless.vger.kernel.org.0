Return-Path: <linux-wireless+bounces-13626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AC09935D7
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 20:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB07B20DE0
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 18:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620B91DDC2A;
	Mon,  7 Oct 2024 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oO2iQcWb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF01DDC19;
	Mon,  7 Oct 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324956; cv=none; b=kxLAQfFFaqB1Y+vqeLltDryIHytbZ9htPItZb6vG8DG6xL+SdVKUik3zSrNgrRltHLQ4/p3VgRZPeanZEn6KpjQAI199MgZIJzP2134t8OWtQQsbnRHg2d90SCBt/I2vFPoqYsT2/D/pw5ldfihFqceuDgSlHIECNYdjAcaztKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324956; c=relaxed/simple;
	bh=pZacWOFIAim5AEhAgNXAN2f1snSR49nZoWYqivycqD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmWe2AMi5NGkjfUX7Ooz7OeqHh55iHndM5HO7Ny05PLPEUZhLr1Dr2XgkrpoSQ9hYUDOFjSt8xSO0gdyl9QdvD4Gl7lOBwZPYYQPHcHfboUjneHHX1PjSssBsumydegCsHfZazXnlE/Z9NHfgpCqxcCRrCTJ4YU9UjOUQQ3K2S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oO2iQcWb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ptGWsTVt8njZ4Flc4XnLbsrxlD+iHZEfaFzIqKK7X6I=;
	t=1728324955; x=1729534555; b=oO2iQcWbqdOkyjwpwjXoUn2umPjc0AG3SyVzTaaW++uuO/a
	7yxh8ERdLbax4qYQyl/f8Vt8PQaEvjrTDDKVMWTX+4FbhyHYK2xTN5+T8rS110Mr/pViQ4rWwFYKY
	dDxoMLORDe/eGhramT22qqpTINw8YCluoZ3eoKg5zZPdGlxF28GrXFBgehVU3PrX5fZG3kveAhdw3
	YZX4Q90RYIYfzf2kn/yvfvOveqoPG3o5P1Etj56swAa5BjslisjYrW+j+aGo24rsYWSVFy4AEFed9
	v32445vG+lOnUhSgpPLF+BriA7cSZL2PxwfTIlcOy4IzOCiMMi3gqidxzH6COqHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxsGu-00000003TpG-1bGS;
	Mon, 07 Oct 2024 20:15:52 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/5] wifi: libertas: don't include lib80211.h
Date: Mon,  7 Oct 2024 20:10:53 +0200
Message-ID: <20241007201545.98aa15212cd5.I74bc1f334c02043a238303d3e71c955d0d9b01b0@changeid>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007181545.63207-7-johannes@sipsolutions.net>
References: <20241007181545.63207-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This isn't used in this driver, and should't be, so
remove the include.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/marvell/libertas/mesh.h | 1 -
 1 file changed, 1 deletion(-)

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


