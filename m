Return-Path: <linux-wireless+bounces-11313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABEB94EF72
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 16:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D91D1C212D7
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A1917E902;
	Mon, 12 Aug 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="IM0PIP/a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C616C440
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472697; cv=none; b=ZrsjpbUKmuwChFnZMhGWrjp2bovwRYBF1diFtx1PoW/ek66u8MBqxSsGwffoIwMHtWU66SiOnb46Q4XQNRwhauul2SXdSGmyLJm6HLse3C/imqISeZKK8rQ0HS+3/p4t1K3PVIblj3s264dsTF4AnBHgZHdCH+GNINeD7+mQfbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472697; c=relaxed/simple;
	bh=vR2XHx8f1rgvtnEtyGrGviHy4x+gjOJWd41PhUrs9dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qRSeDS7iKAJBHeCZT44Z7msa4KREFT2+D+ynZZY6RzkmIHzqI0mzp1ksDm+UrFD/rwn3WCAyxlUtwYez8zKicHanmnhS/MSlFJvKWelLOd2NtaJ9VVv4xBms39WMylyb5LwV0l1mrij3YE+J/o6zIM3qLH0Z1LiMtnNY1lPE0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=IM0PIP/a; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1723472692; bh=vR2XHx8f1rgvtnEtyGrGviHy4x+gjOJWd41PhUrs9dw=;
	h=From:To:Cc:Subject:Date:From;
	b=IM0PIP/afRcwfropNGQpmck5/enxbfDf/EMZXNFjbFXrL+CIEmJ4HGSyjluOFSv3T
	 aZmm4h/9+xB6ZVgGSbEiCNdiy8mYmCkaVITWbPwaGdzwysU422lEt4aHBJzZ/7oj4Q
	 rV3Zqa1jlfTAljRSKUtA4Pjs17Uvc62xIc+A203sOXQFVYSh4z9cSGFFwBMFFyHvBz
	 V1RxyKMb0pNYv7wh07y9dP5O/1eR0u5f4Ie7SNuGSdbbKN2AfzajznpEzYYwYXkp1V
	 w/W83Knwdl+RSj6xf4uQWLHGX+2NIeo/8QPTzNzokQoI4Oow5SANoHWkuC4AmP52rw
	 2oSs1C9UiQ60w==
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com
Subject: [PATCH] wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit
Date: Mon, 12 Aug 2024 16:24:46 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <20240812142447.12328-1-toke@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Toke Høiland-Jørgensen <toke@redhat.com>

Syzbot points out that skb_trim() has a sanity check on the existing length of
the skb, which can be uninitialised in some error paths. The intent here is
clearly just to reset the length to zero before resubmitting, so switch to
calling __skb_set_length(skb, 0) directly. In addition, __skb_set_length()
already contains a call to skb_reset_tail_pointer(), so remove the redundant
call.

The syzbot report came from ath9k_hif_usb_reg_in_cb(), but there's a similar
usage of skb_trim() in ath9k_hif_usb_rx_cb(), change both while we're at it.

Reported-by: syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 0c7841f95228..a3733c9b484e 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -716,8 +716,7 @@ static void ath9k_hif_usb_rx_cb(struct urb *urb)
 	}
 
 resubmit:
-	skb_reset_tail_pointer(skb);
-	skb_trim(skb, 0);
+	__skb_set_length(skb, 0);
 
 	usb_anchor_urb(urb, &hif_dev->rx_submitted);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
@@ -754,8 +753,7 @@ static void ath9k_hif_usb_reg_in_cb(struct urb *urb)
 	case -ESHUTDOWN:
 		goto free_skb;
 	default:
-		skb_reset_tail_pointer(skb);
-		skb_trim(skb, 0);
+		__skb_set_length(skb, 0);
 
 		goto resubmit;
 	}
-- 
2.46.0


