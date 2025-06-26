Return-Path: <linux-wireless+bounces-24548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EE0AE9FEC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 16:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F6E7B5003
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC18C28FFEE;
	Thu, 26 Jun 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="plsKIXrH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF221C1F05;
	Thu, 26 Jun 2025 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946903; cv=none; b=AQiP02npzP/LJKYJJRmAaFIOOlauj2lMsqDvjVJbJ1UKXdW/dAnf+qfCp3yeSj95V8W+yYIEho84M6AeYniLsXm2nzK/sEkE8fpW6kb459IXauBmU62IngTS2/M7wtdYwlWiWPi2NEvVDxQc9TjL1oOURRF6iBotuv4/X6Rpi7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946903; c=relaxed/simple;
	bh=yV/TOvlNS7DY7ek8fYzdAH/wndArW7CrW/l+Vyix1Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HLe44apRlbApT+LEhFLwuas6clNDfAxmAwovx9Hz1Deo9NIA3ec/KNga/g7uarcEpvj3/+y13gMuWdAyVUadKpNR+x4qqu0r6YkWnoq0tRklkIVa5UHdWIKnp/LBZwg/wwpc4SQRNQVqQo5GDiGKBeUOTabJd1vjl4xh8WB9H1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=plsKIXrH; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Y9Y517Y9AnZbSEb+d4KuZ68RhNAioutYm3amMPrGnAI=; b=plsKIXrHf1C+PF+y
	pfBEUho7Jq2QyWs/XAYvpPugQBnDjh0b/zPsgIFQr87LwRxwAWlVXpPH/aVlnBcQeQP5OfO6+ob0Q
	TDM4OUH27a5FOm2Dq7DgXoAgz+UpZrQWUySoul30IF1B2Y3V03zjlqiPy2cXYVXorWkd0FWY3u+Ts
	bpBW0+z71s2nNzlhe8DQyjtqj8NdyLJWa6kQ8nhOI79o3SClVW0tLnx6P0vTmUlW5+MpD+4Fu5DQv
	CBSO8lKAfbdHS7jaXu7V69maEN4+Pe40exdGaeQGqa+N9+dzWBbVP2QP0DUlMq8tuqwbwRYHQH7i2
	6bAvqd/KVbnwTzBrJQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uUnGv-00CF9J-0y;
	Thu, 26 Jun 2025 14:08:13 +0000
From: linux@treblig.org
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/3] wifi: brcm80211: Deadcoding around phy_cmn
Date: Thu, 26 Jun 2025 15:08:09 +0100
Message-ID: <20250626140812.56700-1-linux@treblig.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This set removes a bunch of unused functions in phy_cmn.c;
I've checked the history of most of them, and they look like they've
been unused since all the way back to 2010 when they were added
to staging.

There are a lot of them, so I've arbitrarily split it up into
convenient size chunks of about 10 functions each.

I see back in 2014, Rickard Strandqvist also tried to clean some
of this up, but I don't see any reply to that thread.

(Build tested only)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Dave

Dr. David Alan Gilbert (3):
  wifi: brcm80211: Remove unused functions
  wifi: brcm80211: Remove more unused functions
  wifi: brcm80211: Remove yet more unused functions

 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c | 443 ------------------
 .../broadcom/brcm80211/brcmsmac/phy/phy_hal.h |  27 --
 .../broadcom/brcm80211/brcmsmac/phy/phy_int.h |  11 -
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c   |  19 -
 4 files changed, 500 deletions(-)

-- 
2.50.0


