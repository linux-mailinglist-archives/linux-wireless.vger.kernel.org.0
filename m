Return-Path: <linux-wireless+bounces-8838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2803904D8D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA0DB23E88
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 08:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF4F25605;
	Wed, 12 Jun 2024 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jN/invBY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB345948
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179541; cv=none; b=hg7fYGApl9nRIs8ssPE7zPdeQRk7AH4Bfjl5o4JnAEBpjnNVGQv3hymke1kqS9yPHsbngN6TpFsT/yQ4n2rXWEWmb/fr/ZKuEQoalrrt6NDHeQHnBOwi9WBj98A40AASFunxDoKcaozXCMh95+frMEpbFpzz6Egg/3hWmJi811k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179541; c=relaxed/simple;
	bh=IGHpArCv2jpEGFY4gVpV/fDuSaDNiPHUT96D9hBe7CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGW/hOKMzIUERjN0U2ZIyacnNPjq2Tv6y7DidZy215ujgeiTMOFIFod+KgqgDks9dBzN+g48jdHAr9m4WPFGIB2qfaBQBr4E8aURh/MZMSkOWvinra5SA4AlNps3X/YUC7R9ES7BNVPxVgATxfTWnA8nfxX4pIsmdKnDznkndx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jN/invBY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=iSPyIhNMxtArEHlFO0aNK+4vKqc7zeKLbrocKqBnlVA=; t=1718179539; x=1719389139; 
	b=jN/invBYAXdUUSQVgl/fUXe9u9jdPKE5lIS3iXLb+UMgVJLo+m5MWFq4nDJun8r2boks+Qd4dYx
	OSTYLtUQcpOd4ai7sfBbRDLrpSukB9hCDqUQAFJ0ze3d6BhFZpKVQq7Lic1QCxELz8Ri3CBwUsqn4
	k/fJELlIeNx5m3Y4xHWe7lJTpPg6ErP+gBES/TfieP24pMz+/oJ5XYsj0jdt+W4ZeTHBs+Jn+ewpw
	/jJ0DHzgMH3AykCChs5ZzuIQTQHQDQ3vYPcqXVVGAR/06Y2Z+QjTqZTq7soOd3eOjYz8VY4Da3dsR
	D3Ld2QAYb+/0YupKy5dpugyTyeUCcykOh7Qw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHIzA-0000000A2If-2Ykl;
	Wed, 12 Jun 2024 10:05:36 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: correct EHT EIRP TPE parsing
Date: Wed, 12 Jun 2024 10:05:33 +0200
Message-ID: <20240612100533.f96c1e0fb758.I2f301c4341abb44dafd29128e7e32c66dc0e296d@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For the EHT EIRP transmit power envelope, the 320 MHz is in
the last octet, but if we've copied 4 octets (count == 3),
the next one is at index 4 not 5 (count + 2). Fix this, and
just hardcode the offset since count is always 3 here.

Fixes: 39dc8b8ea387 ("wifi: mac80211: pass parsed TPE data to drivers")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 5c5c21ecb2b7..98fb4d316228 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -235,7 +235,7 @@ static void ieee80211_parse_tpe(struct ieee80211_parsed_tpe *tpe,
 		*cnt_out = count + 1;
 		/* separately take 320 MHz if present */
 		if (count == 3 && len > sizeof(*env) + count + 1) {
-			out[4] = env->variable[count + 2];
+			out[4] = env->variable[4];
 			*cnt_out = 5;
 		}
 		break;
-- 
2.45.2


