Return-Path: <linux-wireless+bounces-22283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3229AAA548E
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 21:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1F44E7CC1
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78691D5CD7;
	Wed, 30 Apr 2025 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="k5dg0vXv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970A21CFFA
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746040275; cv=none; b=uwT8Q0KoctoyMzK5YhoQOilhqek1xboKtyKpYgSoK26Qd72++wc7wBVNwJCyYs1YLKrHigbd9NYKGuPXvzogKkJyuEmTktDElVv9vqTKye+skEwoRv3S3avoTfd8lXlenvHZbh2CydwVCgNAnTFc8S53b11OLAG4ueBuwyvErpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746040275; c=relaxed/simple;
	bh=VWX+TzZDczKD6ebHUIFbVrnAXS5A3/Igpzie3KNSmzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0rUUSOLPLHYsQJg2HsX/Dj1OfxlMNxOoYS6MAbQ6lr4+EkqztVywpUntMlIcjunh0P4tojHnSvKwvqzqfowNgj1fDgDGc1JjNUwiTIhDW86EkRsI0sRJ35geJjGtlTy8jGfyvm6oTg9i3Qvs3IhjohO36feOzaa6dCnuZ/fDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=k5dg0vXv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=DncxM4VWRzOVUWXpoAEFZ3uXg9DGLhLgAzjWV6dVy/U=; t=1746040273; x=1747249873; 
	b=k5dg0vXvsO7lHTWMcdo2IxGm9xnj5hbdYWSZGiSxmvsAlHbZgzvkpPje7Xm6EB807//ZigDM4RA
	BAhi/2vl9JF0v0op+Z17VZ6ROcKZPKtkQAqrjeIZDaJYsVsgoQ0PEZzcuaH9h/v1wFQQJJofVo1VQ
	ObveGC+qG915miDpqOTkOPeI0gPhE5A29GU779ij5GJQBGYebaeJlqwX0vs9N8cWTil/a4r7J1gRD
	S+r2DKWBQA5rR6Jkq49QFJrnF1CgtXV2r74hXSYBqkkeAkui97BSLDBbYvZKsBsn+Us81uufrS0LN
	mr/uFr5quK1jB9uCPXgPFoegV5LnrA5ZqLZg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uACpo-0000000E5MA-2adk;
	Wed, 30 Apr 2025 21:11:08 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Rouven Czerwinski <rouven@czerwinskis.de>
Subject: [PATCH] wifi: mac80211: do not offer a mesh path if forwarding is disabled
Date: Wed, 30 Apr 2025 21:10:42 +0200
Message-ID: <20250430191042.3287004-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing a PREQ the code would always check whether we have a
mesh path locally and reply accordingly. However, when forwarding is
disabled then we should not reply with this information as we will not
forward data packets down that path.

Move the check for dot11MeshForwarding up in the function and skip the
mesh path lookup in that case. In the else block, set forward to false
so that the rest of the function becomes a no-op and the
dot11MeshForwarding check does not need to be duplicated.

This explains an effect observed in the Freifunk community where mesh
forwarding is disabled. In that case a mesh with three STAs and only bad
links in between them, individual STAs would occionally have indirect
mpath entries. This should not have happened.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Reviewed-by: Rouven Czerwinski <rouven@czerwinskis.de>
---
 net/mac80211/mesh_hwmp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index c94a9c7ca960..91444301a84a 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -636,7 +636,7 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 				mesh_path_add_gate(mpath);
 		}
 		rcu_read_unlock();
-	} else {
+	} else if (ifmsh->mshcfg.dot11MeshForwarding) {
 		rcu_read_lock();
 		mpath = mesh_path_lookup(sdata, target_addr);
 		if (mpath) {
@@ -654,6 +654,8 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 			}
 		}
 		rcu_read_unlock();
+	} else {
+		forward = false;
 	}
 
 	if (reply) {
@@ -671,7 +673,7 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	if (forward && ifmsh->mshcfg.dot11MeshForwarding) {
+	if (forward) {
 		u32 preq_id;
 		u8 hopcount;
 
-- 
2.49.0


