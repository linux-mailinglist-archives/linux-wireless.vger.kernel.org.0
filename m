Return-Path: <linux-wireless+bounces-23417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F604AC3C83
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 11:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244F81895607
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D391DF98B;
	Mon, 26 May 2025 09:19:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFEE19DF8B;
	Mon, 26 May 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748251171; cv=none; b=m9+oKmI3mzyBl/22Ap5pDGt/3kceAKjGtyIPNYVz/lbuzt0AVASIxfqVwE2xf0lCGFQ8muv+BXgvBQWE3/F45Ch89wdODsdAF0ZkZ+7gZr35b4J7IV/8bHla7mcJHVOZx+Q6gQh9tA0oOIQHG5OUG+baviQPw+h4MopDOQM+ijA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748251171; c=relaxed/simple;
	bh=dG4J7u6ZAFXFgS60iYbh4ZXwMw//VZ9CBuQVCx/Y0ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MnDboHuPsw5oImPt+7KgQcoBD6e7INyIzvXj9JZ3NizpXPtqkJpgPOX0ffIz7S/eRqQiZ2wnS8JWCGht4e0t/nGX3q4psTxC9iWqukTWdB/ClKOMoRxBnSC5/x79++aJeXV28zCacCsjF9oySOZTPtPmcuX94cwkaP6EILE9xXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowADHGFEZMjRocxodAA--.6994S2;
	Mon, 26 May 2025 17:19:22 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: johannes@sipsolutions.net,
	luciano.coelho@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] mac80211: Add null pointer check for ieee80211_link_get_chanctx()
Date: Mon, 26 May 2025 17:19:03 +0800
Message-ID: <20250526091903.587-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADHGFEZMjRocxodAA--.6994S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XF45uw1Dtr4ktw48Kw43GFg_yoW8JrWUpF
	43KryjgFyUXw15Xa48G3y8uFy5ua12kw1FkFyvy3Z3Aa1vgFsxWF4rCr45XF1rCF4DGa4S
	vF4vqrn0v34DArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjO6pDUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8OA2g0LsYQ5wAAsI

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
v2: Fix code error.

 net/mac80211/chan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index a442cb667520..c9b703c283e7 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1503,6 +1503,10 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 				continue;
 
 			old_ctx = ieee80211_link_get_chanctx(link);
+			if (WARN_ON(!old_ctx)) {
+				err = -EINVAL;
+				goto out;
+			}
 			vif_chsw[i].vif = &link->sdata->vif;
 			vif_chsw[i].old_ctx = &old_ctx->conf;
 			vif_chsw[i].new_ctx = &ctx->conf;
-- 
2.42.0.windows.2


