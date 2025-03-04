Return-Path: <linux-wireless+bounces-19736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD08A4D1F9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 04:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D1A188A7E7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 03:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB172E634;
	Tue,  4 Mar 2025 03:16:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91EB640;
	Tue,  4 Mar 2025 03:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741058188; cv=none; b=nvhY5stlQ+uKNY+zzoUBtNsCVDFpYqn0qsyUrDkdgul1dR+8eENc1J1Et/rCljS+FaKNqlVzGk9stmZOvSiuM2s3luj2kFYEkRT+5JI/0Ws/luoXEKdOiwcgK5J9OxELIOWfeBv2IhrzK4ISaObgULjbzQp+ncfapHayB2TkBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741058188; c=relaxed/simple;
	bh=21uArsIzvAZGYIRg4tZeOsYknK6I+/gWgmKNVK2IuXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMPZ/y+c4DaB7VxwCuuZ0N935cVM0PqfG4r7CJmny+5XmOkeCPGOeoS3VyC20mcj0cUpjP0dpnFoWqh57T3WdFvUlcwMkWt0RCHHggISwaxQFHMBcVeQOoSar3C34MkYpUJbIPALcde7OXGtqeIBHSOOmj54RW3aIyMsYnASJrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowABHT9ODcMZnbqs4Eg--.8591S2;
	Tue, 04 Mar 2025 11:16:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: stf_xl@wp.pl,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] iwlegacy/4965: Cancel deferred work on device init failure
Date: Tue,  4 Mar 2025 11:16:03 +0800
Message-ID: <20250304031603.1989-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABHT9ODcMZnbqs4Eg--.8591S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw13Xr17GFW5WrykKr4fAFb_yoW8GFy8pr
	srta4jkry5Ga1UWayDJay2yF1Yqa1Fy39xGFs5Aw4Y93ZYqryrZF4aqay5ta4rGrWkZ3W3
	Zr1jy3W7Grn8JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUehL0UU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwLA2fGHmnwjAAAso

In __il4965_up(), deferred work is not canceled in time when device
initialization fails. This is harmless if the device has not started.
However, in il4965_bg_restart(), if the device remains operational
in any state other than S_FW_ERROR or S_EXIT_PENDING, a dereference
operation needs to be performed when __il4965_up() fails.

Add il4965_cancel_deferred_work() to the failure path of
__il4965_up() to prevent potential errors. Even if the current code
does not exhibit the described issues, adding this change can prevent
future problems at minimal cost, improving the robustness of the code.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 05c4af41bdb9..3b21bd79f3a9 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -5591,6 +5591,8 @@ __il4965_up(struct il_priv *il)
 	__il4965_down(il);
 	clear_bit(S_EXIT_PENDING, &il->status);
 
+	il4965_cancel_deferred_work(il);
+
 	/* tried to restart and config the device for as long as our
 	 * patience could withstand */
 	IL_ERR("Unable to initialize device after %d attempts.\n", i);
-- 
2.42.0.windows.2


