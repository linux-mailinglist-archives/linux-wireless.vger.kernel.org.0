Return-Path: <linux-wireless+bounces-6506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901F8A955E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 10:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B301C20D2B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0BA15AACC;
	Thu, 18 Apr 2024 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="a4z3vcv4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF47F15AAAD
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430355; cv=none; b=F7EWmH04fvsXnCEWvn243+wiHFEbHYwWtPB7OThEMLUMBgMXQDKH9Ft+3kDITqAZJGiIRy5Wf+hpvcM/M4r/Cd3mZvp2n/e8XGUtSxx8js6St6a3fgraHVZlpMnP00Bt78e5iXdBVzrLx2gZBbgXXVWLwbgvfMeo/ECK/WgiyCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430355; c=relaxed/simple;
	bh=9hoUm5POCuTxc3+9KwPVjrX1Tb9aEkNsvVgbiRa9z70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmZdm9ppC0DX8+89cSevZgi2JLXxC3vtGQIgKq7JgfG1PtVALue0u85xFyBmsoRI6VoA7wUHSy+fPqT4ROgKUI4WiIIhBmU5UBnrjjhDUGDZEOKydYvQTl5LM7GYKhDXvEcllXqcDHn9FzDv4xfnlDXqZvn6w0sChwwnJznHfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=a4z3vcv4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ay+c9wu6kl7oYkHo5zpr+zpGhSopkkHHh+yc2Ug6Jbw=;
	t=1713430353; x=1714639953; b=a4z3vcv4CiRksvFRha518lBeACIbZevAkr0zf2BTTKj47pw
	frFD4U301sgFSAG/kklOQM5T/6dZog4qOoy0srZqUz7gZ1s+ShcQJetkQuQLdBDzIEbPmnzOzsj2S
	s2cveVMTf/JOlwTxSFTaPzTW1nJrhVei+pwlHgKqp5RExowYVzS4D68u4GA8YX5VFdLpuRwf6NWyn
	VQOQyLT14PfPKdx+u9S+HB6aV/cb6rSbkZMG6KuAG4rqAa+WfI6Dpb+v0Jqcj2ieVnxjA4tdlAJDs
	xXSTBfPRDeYkmdxSP157P3TGC0W4ZFC3YiT8o3mGV/IBQR6taYKQFU8iFxCm6C+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rxNVJ-0000000CIvO-2Ve4;
	Thu, 18 Apr 2024 10:52:25 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless 3/8] wifi: mac80211: mlme: fix memory leak
Date: Thu, 18 Apr 2024 10:52:21 +0200
Message-ID: <20240418105220.458421e3bbff.Icb5b84cba3ea420794cf009cf18ec3d76e434736@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418105220.90df97557702.I05d2228ce85c203b9f2d6da8538cc16dce46752a@changeid>
References: <20240418105220.90df97557702.I05d2228ce85c203b9f2d6da8538cc16dce46752a@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When re-parsing the elements here (with changed mode), free
the original ones first to avoid leaking memory.

Fixes: 310c8387c638 ("wifi: mac80211: clean up connection process")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 98cb475a14c8..6fa3752b740e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -753,8 +753,10 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* the mode can only decrease, so this must terminate */
-	if (ap_mode != conn->mode)
+	if (ap_mode != conn->mode) {
+		kfree(elems);
 		goto again;
+	}
 
 	mlme_link_id_dbg(sdata, link_id,
 			 "connecting with %s mode, max bandwidth %d MHz\n",
-- 
2.44.0


