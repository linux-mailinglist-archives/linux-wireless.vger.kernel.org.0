Return-Path: <linux-wireless+bounces-29020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A9FC62498
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 05:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51B5B3588DB
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 04:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3921C54A9;
	Mon, 17 Nov 2025 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="s9AvKsyX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FF6FBF;
	Mon, 17 Nov 2025 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763352123; cv=none; b=ihUwUoaXjWJpjxvxcOlnFrCxzEh/IvwhrMd5GyqBrjNMmcfJBGqUe724im5SiuE99SZL3dPPcTwhaFnHT3qTg3rcSepGqimYaI1ewzgHl9Y6/mxwMJpLUxhmdYBugeOSsd8YW2Wgk9TFLL9p8waFSe1TFu+CsG15R4eomSTVd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763352123; c=relaxed/simple;
	bh=qziXWYr+X2CUgWSh3n/AcgpTDmalUrip0XjFAotb7NM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=QPob1o648eX63jWLleWHQtvKeiNICzJrIV7o7lTezJNLpyYAb7COQZA/4CU4oKj7KkY+lAehlj1RkNLrPHwyY5abJuZjb4HBICyeDuz32yKCt+1uRjnaFQYHVaVUiiAxrYe8hAt+z8wrNRqLT00TzptMBDrVLGj97kZj3kGvs5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=s9AvKsyX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AH41qykE2813054, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763352112; bh=H/DYNq2DhyinaprMEcQ8wPFKkk1MhMhAdk5yGFqxFWk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=s9AvKsyXflVawnh7b+FXuVF7xzDf0KeUC/xUgOdZ2B/6D5BoyT04AMAd5p1oHEpCT
	 BOmWly4QVoFhCbTMz39/qGfRenPaiuvih4PIt59C/w5kp3/7Vfho/DEsHlud4UmQ7G
	 3uyBOB0ok3OoYX8yfWCGs7pJua8AR2wJFAovEUeh0sDcYzod+RwWKFxqyT5KpCh9Gn
	 Ye/jhsPdNUkBycblrGNF3jU5HFoEe5MvrIFJXM4VsMyWqY2/53wYSwUa3rfVd1TQhu
	 G4foa1uy7gjSxb6JyBCHuHGlZXTMYLf5KFjsvlJ0MxvhWbtz537/Bdd0b1WIHzIgyQ
	 cr5pcbDz152KQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AH41qykE2813054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 12:01:52 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 17 Nov 2025 12:01:53 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 17 Nov 2025 12:01:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Mon, 17 Nov 2025 12:01:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: pip-izony <eeodqql09@gmail.com>, Hin-Tak Leung <hintak.leung@gmail.com>
CC: Seungjin Bae <eeodqql09@gmail.com>,
        Kyungtae Kim
	<Kyungtae.Kim@dartmouth.edu>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtl8187: Fix potential buffer underflow in rtl8187_rx_cb()
In-Reply-To: <20251113184626.748717-2-eeodqql09@gmail.com>
References: <20251113184626.748717-2-eeodqql09@gmail.com>
Message-ID: <7012d9a3-821e-44fa-b325-9c4c37c9c26c@RTKEXHMBS03.realtek.com.tw>
Date: Mon, 17 Nov 2025 12:01:47 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

pip-izony <eeodqql09@gmail.com> wrote:

> 
> From: Seungjin Bae <eeodqql09@gmail.com>
> 
> The rtl8187_rx_cb() calculates the rx descriptor header address
> by subtracting its size from the skb tail pointer.
> However, it does not validate if the received packet
> (skb->len from urb->actual_length) is large enough to contain this
> header.
> 
> If a truncated packet is received, this will lead to a buffer
> underflow, reading memory before the start of the skb data area,
> and causing a kernel panic.
> 
> This patch adds length checks for both rtl8187 and rtl8187b descriptor
> headers before attempting to access them, dropping the packet cleanly
> if the check fails.
> 
> Fixes: 6f7853f3cbe4 ("rtl8187: change rtl8187_dev.c to support RTL8187B (part 2)")
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
> ---
> 
> diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> index 0c5c66401daa..eff42acc11a0 100644
> --- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> +++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> @@ -344,6 +344,10 @@ static void rtl8187_rx_cb(struct urb *urb)
>  	}
>  
>  	if (!priv->is_rtl8187b) {
> +		if (skb->len < sizeof(struct rtl8187_rx_hdr)) {
> +			dev_kfree_skb_irq(skb);
> +			return;
> +		}

Though compiler doesn't warn something if statements before declarations,
we still don't suggest this style.

A way is 

	struct rtl8187_rx_hdr *hdr;

	if (skb->len < sizeof(struct rtl8187_rx_hdr)) { 
		...
		return;
	}

	hdr = (typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));

Or, check before if branches

	(declare at top of this function)
	int skb_len_limit = !priv->is_rtl8187b ? sizeof(struct rtl8187_rx_hdr) :
						 sizeof(struct rtl8187b_rx_hdr);

	if (skb->len < skb_len_limit) {
		...
		return;
	}


>  		struct rtl8187_rx_hdr *hdr =
>  			(typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
>  		flags = le32_to_cpu(hdr->flags);
> @@ -355,6 +359,10 @@ static void rtl8187_rx_cb(struct urb *urb)
>  		rx_status.antenna = (hdr->signal >> 7) & 1;
>  		rx_status.mactime = le64_to_cpu(hdr->mac_time);
>  	} else {
> +		if (skb->len < sizeof(struct rtl8187b_rx_hdr)) {
> +			dev_kfree_skb_irq(skb);
> +			return;
> +		}
>  		struct rtl8187b_rx_hdr *hdr =
>  			(typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
>  		/* The Realtek datasheet for the RTL8187B shows that the RX



