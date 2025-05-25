Return-Path: <linux-wireless+bounces-23382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9084BAC35BA
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 18:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA107A251A
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868F21F4187;
	Sun, 25 May 2025 16:43:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142491DFE8;
	Sun, 25 May 2025 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748191421; cv=none; b=TUYPCuz9g2dGGBp2bK6MHe/l3godh+2O4URFy6Nn3isN8mIXVUJleJl1jgyGkzv0fmL+MEcoVsLxD5bont/NYr3pinbgdiCq4uwxLZTbSAmHwp2UjZRXEX5K388AbmydVNMlkPNyGFUZ76tLo0PVgArBVB1olD4kQbwLqZQSOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748191421; c=relaxed/simple;
	bh=iU9IKvc63Yue1+C3Fgy1cjqseIPIHRdzt6L4ToGMMYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ci40Wp1fKUdPGUcLXZZcM/GO6/FrtrTp7cmOidlxwtJlxm/t3Cu9c3mmV31U7LWZREbkQlO0tlv+GUaNTFhGHH+QhkST91vhg2oBBxp2yx13iTFwULM5sNq/wHv8ve83tiTSyKkzllyCFhn0Uc52pu7NEIIh+Vf9Iyw7SdJhiGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.199.70.239])
	by APP-03 (Coremail) with SMTP id rQCowABHjy6uSDNotpJqAQ--.32733S2;
	Mon, 26 May 2025 00:43:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: johannes@sipsolutions.net,
	luciano.coelho@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mac80211: Add null pointer check for ieee80211_link_get_chanctx()
Date: Mon, 26 May 2025 00:42:11 +0800
Message-ID: <20250525164211.2039-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHjy6uSDNotpJqAQ--.32733S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XF45uw1Dtr4ktw48Kw43GFg_yoW8Jr4rpF
	43KryjgFyUXw15X3W8G3ykuFy5uay2ka4FkF10y3ZxAanYgFsxWF4rCw43XF1rCF4DGa4S
	vFsYvrs5Z34DCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYNA2gzMvQaKgABso

The function ieee80211_chsw_switch_vifs() calls the function
ieee80211_link_get_chanctx(), but does not check its return value.
The return value is a null pointer if the ieee80211_link_get_chanctx()
fails. This will lead to a null pointer dereference in the following
code "&old_ctx->conf". A proper implementation can be found in
ieee80211_link_use_reserved_assign().

Add a null pointer check and goto error handling path if the
function fails.

Fixes: 5d52ee811019 ("mac80211: allow reservation of a running chanctx")
Cc: stable@vger.kernel.org # v3.16
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/mac80211/chan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index a442cb667520..9e6235001e0a 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1503,6 +1503,10 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 				continue;
 
 			old_ctx = ieee80211_link_get_chanctx(link);
+			if (WARN_ON(old_ctx)) {
+				err = -EINVAL;
+				goto out;
+			}
 			vif_chsw[i].vif = &link->sdata->vif;
 			vif_chsw[i].old_ctx = &old_ctx->conf;
 			vif_chsw[i].new_ctx = &ctx->conf;
-- 
2.42.0.windows.2


