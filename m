Return-Path: <linux-wireless+bounces-14920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2691B9BCB1E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 11:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25001F237FF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 10:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CCC1D2F72;
	Tue,  5 Nov 2024 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b="hhdUsOUe";
	dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b="hhdUsOUe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from h4.cmg1.smtp.forpsi.com (h4.cmg1.smtp.forpsi.com [185.129.138.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C01D1500
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.129.138.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804374; cv=none; b=DJxeI23nX7EFqj+FD4ma5CbpTvA0owlAMk44daA8XfCV8F6cc+zb/K0Pcegok5MDmpf30NMQoByBySEkJfaaoet/uErLcybDm1pReknTpUksSuL7SwtIQOmB8pKZ28DKAM7IKt31yX0Z+pZPDPggS0vlFTPaphMSrHu1D4GZfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804374; c=relaxed/simple;
	bh=46ouxS92JHhhp1/gpd2OtLeVjNUoT7qeGH2MWNkKMWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ES8JNiYO4cYerce2KM2sXqQRd447Aejml84cgQ4cs2JvCwadRRq3BgD3mB7HX+nqWWSVgSyxJHQ209U2vAiCwJtybsEFDuMiuA37DwXVLPOkzFDTHT2P2WUmGTXk2LjI1ftEFV1raL9fNxFc+QQjUZtXNfkLZhbE3UwCUwNQ3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=triops.cz; spf=none smtp.mailfrom=triops.cz; dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b=hhdUsOUe; dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b=hhdUsOUe; arc=none smtp.client-ip=185.129.138.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=triops.cz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=triops.cz
Received: from lenoch ([91.218.190.200])
	by cmgsmtp with ESMTPSA
	id 8HCUtJjLn5hDk8HCVtIKjb; Tue, 05 Nov 2024 11:54:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
	t=1730804060; bh=YGCoasgVytO01V7dHEHB94nSK2uhOXBPPbFCWwq2mo8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=hhdUsOUeZYGbNa2JHvuO5HGAMdBW2kJ3Bpjo0GQiaXlVQXCfT5FAj5P2iIKJ8eZOA
	 deVv0nvL51Qwzgz7K32ICgeQnoDLWD7n1/G5daD9VvwJZt8EoXzn6bAJtGlCXyDRwW
	 61gX1UK0dQ4j3I6AoBt7RKvvs+rK1NCEz2uBw7omhhsm5mTA4vVMqbB6Vn7Wiy4yoR
	 08d9ziv03TKou0hK+5fQW5RAhrLMmDHArW+mOmTaKi4V2KM5xnCdmDTNwTYgZdXMV3
	 b7ol+zNdyo3zC0+GIjIs+XlAnlcPs75bqWGMg1ipUKbfSrcbALSMeIRVfWArzkGyNX
	 a7hhhDJugSMmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
	t=1730804060; bh=YGCoasgVytO01V7dHEHB94nSK2uhOXBPPbFCWwq2mo8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=hhdUsOUeZYGbNa2JHvuO5HGAMdBW2kJ3Bpjo0GQiaXlVQXCfT5FAj5P2iIKJ8eZOA
	 deVv0nvL51Qwzgz7K32ICgeQnoDLWD7n1/G5daD9VvwJZt8EoXzn6bAJtGlCXyDRwW
	 61gX1UK0dQ4j3I6AoBt7RKvvs+rK1NCEz2uBw7omhhsm5mTA4vVMqbB6Vn7Wiy4yoR
	 08d9ziv03TKou0hK+5fQW5RAhrLMmDHArW+mOmTaKi4V2KM5xnCdmDTNwTYgZdXMV3
	 b7ol+zNdyo3zC0+GIjIs+XlAnlcPs75bqWGMg1ipUKbfSrcbALSMeIRVfWArzkGyNX
	 a7hhhDJugSMmw==
Date: Tue, 5 Nov 2024 11:54:17 +0100
From: Ladislav Michl <oss-lists@triops.cz>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
	pbrobinson@gmail.com
Subject: Re: [PATCH v2 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to
 purge TX skb
Message-ID: <Zyn5WcUGoibH7-s8@lenoch>
References: <20240822014255.10211-1-pkshih@realtek.com>
 <20240822014255.10211-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822014255.10211-2-pkshih@realtek.com>
X-CMAE-Envelope: MS4xfPacqMSXX9/39ZfRZRqEyPsZkn678wL4Gz7izxtFpjPROAF6bU2qdXrV5Kv/F+58QDU5c2fGoMf8ohxU3jau9vaWEmVWlkRKF4hfm7TmJ0oKndpYu74u
 +Y8LzAu4LrM2Eq3tU08xkrGDuzXS4LTTOlC1XkRw1sCdsP+h9HHVV+dlaU4YFF6lO+Dda+WDoDyF6bAT9+yb88uqRy1ivm9d3F2CJ8to0BnwjPkRfUJYfghC
 eScBn2TkoTFEpxnmtW3P1u94v/gIfCqEk2GTZiv8UqUr97P6b/oFFp41SdRmRj07

On Thu, Aug 22, 2024 at 09:42:55AM +0800, Ping-Ke Shih wrote:
> When removing kernel modules by:
>    rmmod rtw88_8723cs rtw88_8703b rtw88_8723x rtw88_sdio rtw88_core
> 
> Driver uses skb_queue_purge() to purge TX skb, but not report tx status
> causing "Have pending ack frames!" warning. Use ieee80211_purge_tx_queue()
> to correct this.
> 
> Since ieee80211_purge_tx_queue() doesn't take locks, to prevent racing
> between TX work and purge TX queue, flush and destroy TX work in advance.

A the very same problem exists in 6.1 kernel series, where this patch
becomes oneliner:
---
 drivers/net/wireless/realtek/rtw88/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 81f3112923f1..d7d4b0f05da9 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2145,7 +2145,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 
 	destroy_workqueue(rtwdev->tx_wq);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
-	skb_queue_purge(&rtwdev->tx_report.queue);
+	ieee80211_purge_tx_queue(rtwdev->hw, &rtwdev->tx_report.queue);
 	skb_queue_purge(&rtwdev->coex.queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
 
-- 
2.39.5

