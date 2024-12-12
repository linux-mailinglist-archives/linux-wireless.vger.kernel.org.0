Return-Path: <linux-wireless+bounces-16321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844869EF850
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 18:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B7A1896CD1
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 17:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44A022331C;
	Thu, 12 Dec 2024 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sH1e0U+K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7700C222D4A;
	Thu, 12 Dec 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024792; cv=none; b=HiwgPMGs74CylY1CYQ/oFEmEeFl94VgAV8si2QIm6Guwz9/ikYGUlYKV0hs4UvTdxLsMZNJKfJ9ZF1XPsu6J2E6Wy+LGBTImqXJNZUvOuPNXxrT2bYNijvNONHUF/XmpccP/COS2lehWlY+kFm2JXARaJZgwcxu6iu+NPRZfuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024792; c=relaxed/simple;
	bh=8zifT6ewWYEFbntDyJ6Ww05c6ssCJZsNoWbJSANJZng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXGojjT/bJyBYZkOTjBLWQJa1LMdF4buljyYxlFslbDqIAxzNsr3pHDF7KRNDVp13Z9vJ7iGCGCxbNBrZ4VMp+VGBjmEsab+9QhYbG5Wv86v0aD3OAZBbvVvC3+YQF6+AB4+uHy2XW1Lx1ZlnEQPONG5KyHZNcnqPExd5XTYNDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sH1e0U+K; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC255204BA86;
	Thu, 12 Dec 2024 09:33:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC255204BA86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734024790;
	bh=ejEwRygxca6lQ1bnnmgGz/a6d9eFvOqci4xwtvOcijY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sH1e0U+KayP+lsFRd5cH4rW4QJHnRLOWDFCTJoPjZRvL6dwQYhPEw6wLSEiQVtzIz
	 MGjOiqbZKlHIKC/I0x+IjPT78qNmm2OrOBklKG81Gn4wy67uMgQIlzYxTIMktAVNJA
	 yGuIpYUjNjbN3EVimHdjo9phwdZ8Nt/bD5dSfqhA=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH net-next v4 2/2] wifi: ath11k: Convert timeouts to secs_to_jiffies()
Date: Thu, 12 Dec 2024 17:33:02 +0000
Message-ID: <20241212-netdev-converge-secs-to-jiffies-v4-2-6dac97a6d6ab@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com>
References: <20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: quoted-printable

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced=0D
secs_to_jiffies(). As the value here is a multiple of 1000, use=0D
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.=
=0D
=0D
This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with=
=0D
the following Coccinelle rules:=0D
=0D
@@ constant C; @@=0D
=0D
- msecs_to_jiffies(C * 1000)=0D
+ secs_to_jiffies(C)=0D
=0D
@@ constant C; @@=0D
=0D
- msecs_to_jiffies(C * MSEC_PER_SEC)=0D
+ secs_to_jiffies(C)=0D
=0D
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>=0D
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>=0D
---=0D
 drivers/net/wireless/ath/ath11k/debugfs.c | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wirele=
ss/ath/ath11k/debugfs.c=0D
index 57281a135dd7fa6b8610636f47873c8bba21053c..bf192529e3fe26a91e72105a77b=
4c6f849b905ec 100644=0D
--- a/drivers/net/wireless/ath/ath11k/debugfs.c=0D
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c=0D
@@ -178,7 +178,7 @@ static int ath11k_debugfs_fw_stats_request(struct ath11=
k *ar,=0D
 	 * received 'update stats' event, we keep a 3 seconds timeout in case,=0D
 	 * fw_stats_done is not marked yet=0D
 	 */=0D
-	timeout =3D jiffies + msecs_to_jiffies(3 * 1000);=0D
+	timeout =3D jiffies + secs_to_jiffies(3);=0D
 =0D
 	ath11k_debugfs_fw_stats_reset(ar);=0D
 =0D
=0D
-- =0D
2.43.0=0D
=0D

