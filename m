Return-Path: <linux-wireless+bounces-13073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C4697DD76
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2024 16:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9931F21FB3
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2024 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D158816DED5;
	Sat, 21 Sep 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G5drAkqf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2CA47;
	Sat, 21 Sep 2024 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726929830; cv=none; b=WjEP6BZXj6HEA7+fqXrOe5gJc7Bz7BdKoIKgPaXuxDhfa6pqQtmiObWiArGNTt8QZkMJIyx5oFlqNlEy8jReiGOLmkNHWYGFB2eKUNNHNn9ICitzRCYHeaf9/2Ul3rzEV6gYgkBdYWKdSkct3fYwjMA63FlexJ09esYbxfGCpx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726929830; c=relaxed/simple;
	bh=YymUbj4zzCEBemmQ4etvgd/sDwTI9w4pDoipO5vM0gc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=unKW8Thfn0ds+nT1CukvR7zfHdVqVQuNBF5d+AB9yyYSsVdMw/abno7MjvBzIRj2bHS8rr9aKEmkAhh8e0bq9wt+JYE9SgUKPuMACl1VNGpdO0eqo0aVR0HjgkP18zDjHoGb3UE78ll5WXnrxAEab+OLapHHdnM/pMGLJ5UgtAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=G5drAkqf; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726929801; x=1727534601; i=markus.elfring@web.de;
	bh=Ze5CkP7MQHmwCuO1XBfTk19h4/iqKy8mgsPeFXpqRQg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G5drAkqfR3T4Lzq/W+k4zvI48iRxKH9NhGenbapWZpTC+mRt3vs9RdVJcssk9Vk2
	 u2kS4OSLTf8WNfhBPqoGf4VWPd3OWMXh34CrdaRs8TqyT37myKPPj2OM4OGgKPONM
	 2+mjN73NJobh2mubr4SIZcvwj/9KK9PDDCTs9Kjk7ytbg4TbXGEuHGPvmHq5gp1lh
	 8RxqzGLgSf2cKLnnXtzEhn/iI7AYjS05ub2B4wlpxj53vUsalO7Hy3VO4aID24YQC
	 TgvLoaGMclKcymfy1SJHW+zPZHMgtJcLpy3arOot/FSx9J57l8voTfSjuv7A/kHd8
	 4/NcLCjPtpgX6tGbMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtPre-1rxA3C3fcE-014EHH; Sat, 21
 Sep 2024 16:43:20 +0200
Message-ID: <6658a046-9d4e-4f18-8405-f5dadcf410ee@web.de>
Date: Sat, 21 Sep 2024 16:43:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 linux-wireless@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
 Kalle Valo <kvalo@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] wifi: ath: Use dev_kfree_skb_any(skb) call only once in three
 functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y0mbzl/D0kDzSIz9D2uwsK9cknnXkWfSJZHPGL5XJMRJJAIdscy
 +8DFodCZeGr6Wqe7bh7idUQQpYUkJhOR2atAs/O0QSaeUF8eg87hnkzt945WatRXdo1lzFW
 hxGVI0XOwZnVnSWOl8Piok6njIJVA/QPmn5ZOL70Dxzw1D2Js+hET8+H5Ll1DCV8ojMUQje
 hiC/6o05XlXklUeT5k14g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2UyM1PGgl5E=;0iXHIZBz4wWxEax5Cnp5LoA5N3L
 ig9vOrQ27CnYRQczpkylS0WkR9ZigT+00f2fqrRj3Igps62vsdCdEvJ8fFYOBMSXuVAbYnb1O
 ZbphnlosBXm3ZENoWjHQe/Q1B698OHtFjQ43OZJ7X5kEWJUGt0C5xA8pD2UHjyAFxpHc5LD+7
 y5lYpprn72gOJAuURoMFo9p9XByK/2YGDPs8HL9rBtZ9vR1gbwCNpMqVDtPV6WVHQee1suBBG
 DVWjKmTEeU3pz28r6ZsYOk8UAxw9n8uoD171QPtgvGv5K03Rmo5IqkQ2klJvQm2x3w24ad/hF
 bBKaxp2HJW5jn1gClzdI1xnAlcfNKWVqrJZnPMkHqG+/vZvIyvGCmJNjHmJmMvoIAAuLet6vR
 CHGuFM69WsvUGaC5iIK2PCMVIQe29R83TFr0F80QnbzXtJ0lE/5mAD9Ii4wYkjAt109/+MPa0
 gYCCgSf4evynNpmrIswOSZb1izL8MGrGjxd79BZyQS5W1zso+nmOqAxTUYMg+DUri58vPOxch
 YFo69Fe76byWPGJPklWs1hz2Q5Xx4YWeYU75f+jMIv2FrQqI2W3pPIElpwApW/fYh855c9lhe
 hFXwtaDRzpOhdwE7Ukguq60UGeaIF9PQnU+ZRf0SiwIKxli2Vttj5JuvEWAYdHKExwGMNQ5ad
 J3xOJkTsOrzhQQ4nTje15miz+mSMG6OVNfMNMgndEJ2tjbvJ/hxkxD9NoQkeS8Bo3skbwyqSm
 elIvE5mxY2amLC20Sj6vpLL8SamElNcYSd9RJ31JhjTReDkvVnOW+2RUbxFL0xN8WnAKiBxZe
 XF3/1GseKFM4oIS6S/WQdwjw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2024 16:32:09 +0200

A dev_kfree_skb_any(skb) call was immediately used after a return code
check in three function implementations.
Thus use such a function call only once instead directly before the checks=
.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/wireless/ath/ath11k/dp_rx.c  | 6 ++----
 drivers/net/wireless/ath/ath12k/dp_mon.c | 4 +---
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 6 ++----
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireles=
s/ath/ath11k/dp_rx.c
index c087d8a0f5b2..eb8e5fbdd77a 100644
=2D-- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1808,11 +1808,9 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k=
 *ar,
 		/* Free up all buffers of the MSDU */
 		while ((skb =3D __skb_dequeue(msdu_list)) !=3D NULL) {
 			rxcb =3D ATH11K_SKB_RXCB(skb);
-			if (!rxcb->is_continuation) {
-				dev_kfree_skb_any(skb);
-				break;
-			}
 			dev_kfree_skb_any(skb);
+			if (!rxcb->is_continuation)
+				break;
 		}
 		return -ENOMEM;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wirele=
ss/ath/ath12k/dp_mon.c
index 5c6749bc4039..21780f06b4ae 100644
=2D-- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2102,16 +2102,14 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, =
int mac_id, int *budget,
 								  skb, napi, ppdu_id);

 			peer =3D ath12k_peer_find_by_id(ab, ppdu_info->peer_id);
-
+			dev_kfree_skb_any(skb);
 			if (!peer || !peer->sta) {
 				ath12k_dbg(ab, ATH12K_DBG_DATA,
 					   "failed to find the peer with peer_id %d\n",
 					   ppdu_info->peer_id);
-				dev_kfree_skb_any(skb);
 				continue;
 			}

-			dev_kfree_skb_any(skb);
 			pmon->dest_skb_q[i] =3D NULL;
 		}

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireles=
s/ath/ath12k/dp_rx.c
index 91e3393f7b5f..c0b59ac247bf 100644
=2D-- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1804,11 +1804,9 @@ static int ath12k_dp_rx_msdu_coalesce(struct ath12k=
 *ar,
 		/* Free up all buffers of the MSDU */
 		while ((skb =3D __skb_dequeue(msdu_list)) !=3D NULL) {
 			rxcb =3D ATH12K_SKB_RXCB(skb);
-			if (!rxcb->is_continuation) {
-				dev_kfree_skb_any(skb);
-				break;
-			}
 			dev_kfree_skb_any(skb);
+			if (!rxcb->is_continuation)
+				break;
 		}
 		return -ENOMEM;
 	}
=2D-
2.46.0


