Return-Path: <linux-wireless+bounces-21256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85497A7F970
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 11:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E399189D907
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49728264FA4;
	Tue,  8 Apr 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="EoZelvhr";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="dEjyzfdh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A7B264F8B;
	Tue,  8 Apr 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104330; cv=pass; b=MDyQZXrWooHRecTc35YSzcFbVWzPG+qQpu6sy4hsSxWS1VvI3rmhiJ4MuQFxr6Afx+r76WGv8nB8W6BcFRiIvm2qC8dF7//1XljW8CpB2hHbSHuZRSmoY9Hug9y0AGq0MzTLEL6YigORJ+8h9Ym7ZYj5E5u3zAmEVDzfM9iKlQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104330; c=relaxed/simple;
	bh=TZMPu/ggC7ANtb5CKg0jTBzsNDxTvYT2K5OsJaPxFME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AvD0AqnYSp+oSXYdgwpGIHgTx6V7VohBVcsZauiHPxGl7RQuaShRjnNazTWHkr7w5DcGdR1FXd4r1r/xZgoy4mK7K7oH9s0WCIqa5ShDzUKkQzS1wP9kfXGB9BbG4si3RzVB+S+PuM8LvulwE/DS618JY666yNSJMC/QIrzo6+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=EoZelvhr; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=dEjyzfdh; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
ARC-Seal: i=1; a=rsa-sha256; t=1744104146; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q327Fi3D0tCkbsdWreuMf/jF2eCl5b6DlkX0qiHqEFevUUOLc8c5/q0r6QGeSmFH6Y
    EgnRE/1vLl7zkzdZ9F6FP1iiz3USQ4REGzyKTJKKpYSOBcnPRkYnLioJXaLW170uxgfS
    LVZseVjs6e7GiMrVBfYuhXpNYkcyJ9bhH/EcEAiIa6O3gP89jt4T5b/dhiX1cK8jAbr8
    Q/PM4xpX1O02XBjJRJ0Jb6804iiUm3dx3EDh5MxDTN8fTkbVwFbJM7VJHhTB7eFHHOOA
    GXKJSnG5klzApdZOyw+WQDnCOufodypyc6hYvaJerWUErcO9k25wClDAQx2HdrBvs0DP
    N38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744104146;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DvPZngYBCIjvSMVeiHDGGoLNy0WyKcb5i/w8KIm4Xjk=;
    b=UlkrDEvhvTxfhYtn3bRhfcQV4XjbWOkh6CtPDUsA0kXUYKX+SlrNLjBqcKMkQF85LH
    qGfN35gbN/FU2gDVbPsIEW28pPZ6iR1f29t47WUjsJDbiP1fWwoAhbQSbOiHLEAjWJMG
    yQHpgeNmai6l/3x3JcNaNIy/hrG6GVD8ZRToiJ/HxcC0yJnJvuDH9beJVXVLTbp+lmbV
    io5TJZ7psCdHhvaLC2CSiTpLBwYfFEx1vRE7LIOXeY5bTjLxZIfrZAET+qns9WL/xq96
    BB9sGB1B4G5GUbsesuA2sb4SzwO8tFE0sRXtuV4T/ZgkMJYjqHWaQXENwzdne4FIsDhk
    lk3A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744104146;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DvPZngYBCIjvSMVeiHDGGoLNy0WyKcb5i/w8KIm4Xjk=;
    b=EoZelvhrCCBw36ltpkm5PUvTm2QkkjFKGZAtLtZtc9uj4RbxIJ8IHc+2yGZxfe6m7h
    nReTdgWViqEJ/KmJnlm3tjG6SsudSfxCacY4hFH/QsIB9eVaiyUbFaYhkdnxQE0IgwIQ
    Rf8Kz3VUV3oi0TpuG+eJtCurWrQSKRp70fjVLtBQ39tGLMffb7P1G80D+fOJ1h92WVyQ
    Ntx5rHw/Q/jFlTZUgb2GQLg9AcctDw9V0qwWg3Nrjec/4mmFIa3w20nE6uwXJTsPxopB
    JYGlJ1yKMqaJ+x3G/72oBXHjAn9ZVZvGP4BwdIbkU1LR1eyxMlGYfXaiEAMWpE4UARNR
    fviA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744104146;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DvPZngYBCIjvSMVeiHDGGoLNy0WyKcb5i/w8KIm4Xjk=;
    b=dEjyzfdhvGxYWVEdKQToYq3AS/mCISdBBQNiIJ1awEjhCTuX1KUKugp0OHuWnh8Xk+
    j1JPRo+d5F5UhyaGiPAw==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id J2b1101389MPXDG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 8 Apr 2025 11:22:25 +0200 (CEST)
From: Julian Vetter <julian@outer-limits.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH] net: mac80211: Replace __get_unaligned_cpu32 in mesh_pathtbl.c
Date: Tue,  8 Apr 2025 11:22:20 +0200
Message-Id: <20250408092220.2267754-1-julian@outer-limits.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The __get_unaligned_cpu32 function is deprecated. So, replace it with
the more generic get_unaligned and just cast the input parameter.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 net/mac80211/mesh_pathtbl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 9f9cb5af0a97..0319674be832 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -22,7 +22,7 @@ static void mesh_path_free_rcu(struct mesh_table *tbl, struct mesh_path *mpath);
 static u32 mesh_table_hash(const void *addr, u32 len, u32 seed)
 {
 	/* Use last four bytes of hw addr as hash index */
-	return jhash_1word(__get_unaligned_cpu32((u8 *)addr + 2), seed);
+	return jhash_1word(get_unaligned((u32 *)((u8 *)addr + 2)), seed);
 }
 
 static const struct rhashtable_params mesh_rht_params = {
-- 
2.34.1


