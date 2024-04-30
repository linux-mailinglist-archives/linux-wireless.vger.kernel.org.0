Return-Path: <linux-wireless+bounces-7077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9678D8B8312
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2024 01:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4015E1F21238
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 23:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D6F1BED90;
	Tue, 30 Apr 2024 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="qIw8PDc3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB583E478
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520539; cv=none; b=Kg0CUtf49Yj8zrf4Im6JlfhbdkFcwEJq5B0Dt274LiMhf5K6Jtf0la5ibaGhZkH/GJu7gTXQ60iVzQcaDaoNq0nYZ/uu7MNTolkvNrHZWAM+7GjiOAUZeQsv4i2VUd/KS5Bx/AN/rIPVL9cFdH/YPRatT8yloKz4HSmO/g0y1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520539; c=relaxed/simple;
	bh=yLjusH2Ggnh8Bd32udv8+csqasIfSdM2ZFN+gxKBCiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aa7ARxkfqiP8V75KOfJ59R2a1t4f3iPG7tn171ZXPXc9HuRsq02KkEi63wZ/yB00LzJ3WNxeC5isQjG/d3B91TehCsz2Q4ZbvF9ocwEedon/XrFxHrQleD36hj5ukZhhSV28wbVM4eY0Ux/wQvWaAvQbZdj7nrLcr184eNqAh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=qIw8PDc3; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CF253C4006F
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 23:42:15 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 5794413C2B0;
	Tue, 30 Apr 2024 16:42:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5794413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1714520535;
	bh=yLjusH2Ggnh8Bd32udv8+csqasIfSdM2ZFN+gxKBCiA=;
	h=From:To:Cc:Subject:Date:From;
	b=qIw8PDc3+wAE7w1ktu6clpr9t/P0Izsi+ZTwvw+kny1kk3qunjMywPI4G21KF/FZz
	 ZEDv0fhiqaexWaeiehAPCom5BugC+WfYnoMu6RQBLGKKb199wgb0kkUgcsWELZg6so
	 tPT4Jte+8/JIJclm1x16bFjYu4Q4LaMuaWVTDuus=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2] wifi: iwlwifi:  Use request_module_nowait
Date: Tue, 30 Apr 2024 16:42:12 -0700
Message-ID: <20240430234212.2132958-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1714520536-1DGY5XNT73_J
X-MDID-O:
 us5;ut7;1714520536;1DGY5XNT73_J;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

This appears to work around a deadlock regression that came in
with the LED merge in 6.9.

The deadlock happens on my system with 24 iwlwifi radios, so maybe
it something like all worker threads are busy and some work that needs
to complete cannot complete.

Link: https://lore.kernel.org/linux-kernel/20240411070718.GD6194@google.com/
Fixes: f5c31bcf604d ("Merge tag 'leds-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds")
Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v2:  Add Link: and remove newline between tags.

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


