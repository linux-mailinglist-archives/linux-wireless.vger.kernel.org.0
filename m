Return-Path: <linux-wireless+bounces-27629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92493B98FA3
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 10:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE554189B2E2
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744FF2BE05B;
	Wed, 24 Sep 2025 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="F9Bz0c58"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2562BDC32;
	Wed, 24 Sep 2025 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703829; cv=none; b=TXzej9DWmT6OjylElaHNL5xxiZje8QhPvVgGIhZlP6cc+af7lh8iIhCVMSWnYt49kUo5csMvJ4fcKib5Ul7o0v7TgAQl8/j1w+DcZIQChVegDgkfmc8Qy0zUF8MjmzuG9sfBJJvS4W8LXtrgP9EtavpAozMPMvDEK5PcN7yqk30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703829; c=relaxed/simple;
	bh=ZbVBS6NLG27rMFDjFvUQ2Kdc8oZwxYtjwgxlVPyJ3E4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QgPDrMzFjFMfE4ceWRTIL+MhSXgxKTiga1a+fr8akuOo4vc8RJIK4L6YgHsPJldidIJe5whtXBEIGgFyXJINNsYvEx5rkEjiSRonnGTfiu+vYJZRXShu3VL6Qci5kK7ULOM4TsoR3ng00qeZ7+Em6kHk11rgtS/+pgmV9g64ygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=F9Bz0c58; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58O8ns7433418274, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758703794; bh=yf5hOenGknaU/uDU0whNjq4J3btNq4aBRtTsPFX4uUU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=F9Bz0c58o++VOSoppckg1shYQQAPiAlusN+X4r4QH/tmvw+lm8CkY4SQSppwCRPBF
	 TCIsVVcy5coc0RUIwHvQkK7EkHsMITb+gdWrKCGz0pxg/1wEvufrmC7pJVQWJYg4FF
	 eUlx73nBZvGfC3oR4zj14vWHTXnQemkyBs+hNVkyZ3d+POcB7XjNE8iRQXJcXl0Q3B
	 FvsLLoA0QbxJWcONBWY2Z3rcEm3R3rwqFgMu5/NbYlK9ZrM9j4MsVmL1Mnj1HZa4RH
	 FinRAs5VmCMBQXwPu0euOAtUyjMDh9K9+aotViQinjGKqFpclnSKSpI7KNmPaaCdAw
	 Ro9HzNcggwDSQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58O8ns7433418274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 16:49:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 24 Sep 2025 16:49:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Wed, 24 Sep 2025 16:49:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next 1/6] wifi: rtw89: usb: fix leak in rtw89_usb_rx_handler()
Thread-Topic: [PATCH rtw-next 1/6] wifi: rtw89: usb: fix leak in
 rtw89_usb_rx_handler()
Thread-Index: AQHcKjJZ7gG/V4UORkyKDEREHbQ2dbSiCanA
Date: Wed, 24 Sep 2025 08:49:54 +0000
Message-ID: <1078ec2bdac24744925d24da9522d8d1@realtek.com>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
 <20250920132614.277719-2-pchelkin@ispras.ru>
In-Reply-To: <20250920132614.277719-2-pchelkin@ispras.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> Free allocated skb on the error handling path.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/net/wireless/realtek/rtw89/usb.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wirel=
ess/realtek/rtw89/usb.c
> index 6cf89aee252e..3435599f4740 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -422,6 +422,7 @@ static void rtw89_usb_rx_handler(struct work_struct *=
work)
>                         rtw89_debug(rtwdev, RTW89_DBG_HCI,
>                                     "failed to allocate RX skb of size %u=
\n",
>                                     desc_info.pkt_size);
> +                       dev_kfree_skb_any(rx_skb);
>                         continue;
>                 }

I feel we should goto free_or_reuse like below:

free_or_reuse:
		if (skb_queue_len(&rtwusb->rx_free_queue) >=3D RTW89_USB_RX_SKB_NUM)
			dev_kfree_skb_any(rx_skb);
		else
			skb_queue_tail(&rtwusb->rx_free_queue, rx_skb);

If just free skb, rtwusb->rx_free_queue might be starved.


