Return-Path: <linux-wireless+bounces-16320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6469EF747
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 18:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AF028A904
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE793222D6D;
	Thu, 12 Dec 2024 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qlEXm7Lv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447342153EC;
	Thu, 12 Dec 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024792; cv=none; b=gHyaGVZb2ukrHnh+hfXGNMSMgh3ZQRA4EZNvF0BP0MIa/INtbEUoBFvOdBkkIWTt641GUIwoXw+Rx3Hc1Y2xuMOVqzamCoe3/uk3ahHA8+n0E9Idgwvr4jP46Ib21ai35Ndsj9GmpQVNWSKq8W9RT3B6Y1uIQR3h3VttzQgZNiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024792; c=relaxed/simple;
	bh=2NE2h+o0vnLauZoMsNvydgnef1Bo/amgX+VliXI66+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OB0zg2rN+RgWrTWI9gcCPRSRgYLtTMi73DzPu4BB1D73JRnjI0gYWlfaPYivLfmPqU5wXF+DdHp6kelQufyXJ2QdVvwfScfMvMhpjS+rxEBVrx9LuRb6/VQTdce6MZ993Ch3Kga+TiBKtm4RQDeNyraM6c8L8DjqwCNt97IdIRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qlEXm7Lv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id BE7E8204BA83;
	Thu, 12 Dec 2024 09:33:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE7E8204BA83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734024790;
	bh=KhekioNyEpahueZj3EOliOXkKSYfTJCi0WH05Jw+vpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlEXm7LvQZ1WtmQ5xwu0xb+LrZ21hjKTyunPYA1nGpM0Q6GTj0/o0lFrdWCC4I+Vs
	 jR6xM2CwIp+NGeNBJldkRVL7KJPw+DFee5aYjmgZWnTZXV+UrjG7EEuMVcKgV0+wv0
	 ACikRVkTvYokwxuGGnCg+rsu/x4tT+FTyKxkEO60=
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
	ath11k@lists.infradead.org
Subject: [PATCH net-next v4 1/2] gve: Convert timeouts to secs_to_jiffies()
Date: Thu, 12 Dec 2024 17:33:01 +0000
Message-ID: <20241212-netdev-converge-secs-to-jiffies-v4-1-6dac97a6d6ab@linux.microsoft.com>
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
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>=0D
---=0D
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 6 ++----=0D
 1 file changed, 2 insertions(+), 4 deletions(-)=0D
=0D
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/eth=
ernet/google/gve/gve_tx_dqo.c=0D
index f879426cb5523a7e150f363b5e57b9d472b5817c..394debc62268aadf2579f9b516e=
045cb48287e7c 100644=0D
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c=0D
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c=0D
@@ -1146,8 +1146,7 @@ static void gve_handle_miss_completion(struct gve_pri=
v *priv,=0D
 	/* jiffies can wraparound but time comparisons can handle overflows. */=0D
 	pending_packet->timeout_jiffies =3D=0D
 			jiffies +=0D
-			msecs_to_jiffies(GVE_REINJECT_COMPL_TIMEOUT *=0D
-					 MSEC_PER_SEC);=0D
+			secs_to_jiffies(GVE_REINJECT_COMPL_TIMEOUT);=0D
 	add_to_list(tx, &tx->dqo_compl.miss_completions, pending_packet);=0D
 =0D
 	*bytes +=3D pending_packet->skb->len;=0D
@@ -1191,8 +1190,7 @@ static void remove_miss_completions(struct gve_priv *=
priv,=0D
 		pending_packet->state =3D GVE_PACKET_STATE_TIMED_OUT_COMPL;=0D
 		pending_packet->timeout_jiffies =3D=0D
 				jiffies +=0D
-				msecs_to_jiffies(GVE_DEALLOCATE_COMPL_TIMEOUT *=0D
-						 MSEC_PER_SEC);=0D
+				secs_to_jiffies(GVE_DEALLOCATE_COMPL_TIMEOUT);=0D
 		/* Maintain pending packet in another list so the packet can be=0D
 		 * unallocated at a later time.=0D
 		 */=0D
=0D
-- =0D
2.43.0=0D
=0D

