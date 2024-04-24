Return-Path: <linux-wireless+bounces-6774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939DE8B1172
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 19:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502A62891FA
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 17:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F4316D4DD;
	Wed, 24 Apr 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="RCVIIhv7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F616D304
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980880; cv=none; b=QBBsgDWdh0CpkBbBejW20lDP7iw3vZ/jH5tT5g1nomQgOvdtMXTWdqPaR3/m1iiE4nHhWunrdfMeN+XPpP7mhsEnTvvNqVcVLXtslwebC2uYxcqVp6Mu7Uk23iSH65hPC8tww2VI+NbIMZOQJr2uYVnKGJc5Lyk+A795GZKvXVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980880; c=relaxed/simple;
	bh=bpt0fCmvC8aYvMc38k1GDWNovdOlMKvziGKoo34H8T8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H9CFU+tJzw1N6EZ1PjIABRjW1Q23CTT6H2sm8SCmbCBdN2vXVg90QHBtyCpKmGgY1UO7C4pqBEMxelpXeLco9ATgBk5K48VOr+NqQ1FpXNOgZnz9IFxSxjbEFmJLi1BRPWz9ujcmiHA3EwseTNPhEpusDjmPXtCNGlllxWVlF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=RCVIIhv7; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9CA13940073
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 17:47:51 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 10DF313C2B0;
	Wed, 24 Apr 2024 10:47:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 10DF313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1713980871;
	bh=bpt0fCmvC8aYvMc38k1GDWNovdOlMKvziGKoo34H8T8=;
	h=From:To:Cc:Subject:Date:From;
	b=RCVIIhv71ur4lTMzfjOULHTQC07ybGr76IliuUJd426RwXPxboCQPXrTl4KTOvj6m
	 G5IAEOn6TByhjpRQ0wWV5ey+EzgTcCFwzPScDMobIGkgUXHTUgyRV40XDeIaKQxADJ
	 nNMlyr8ELkWMhU12alDBI/1x4NXDkL9GwFSY7/CA=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: iwlwifi:  Use request_module_nowait
Date: Wed, 24 Apr 2024 10:47:48 -0700
Message-ID: <20240424174748.957641-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1713980872-ZnH42ZWtKhjg
X-MDID-O:
 us5;at1;1713980872;ZnH42ZWtKhjg;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

This appears to work around a deadlock regression that came in
with the LED merge in 6.9.

The deadlock happens on my system with 24 iwlwifi radios, so maybe
it something like all worker threads are busy and some work that needs
to complete cannot complete.

For reference, see mail to lkml with subject
"6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)"

Fixes: f5c31bcf604d ("Merge tag 'leds-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds")

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 4696d73c8971..993177e1de27 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1744,7 +1744,7 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	 * or hangs loading.
 	 */
 	if (load_module)
-		request_module("%s", op->name);
+		request_module_nowait("%s", op->name);
 	failure = false;
 	goto free;
 
-- 
2.42.0


