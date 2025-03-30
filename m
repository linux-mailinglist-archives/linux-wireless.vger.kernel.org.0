Return-Path: <linux-wireless+bounces-20973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F49A759ED
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 14:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6EC167E14
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978331925A2;
	Sun, 30 Mar 2025 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="p62biwOq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423BB2A1D1;
	Sun, 30 Mar 2025 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743336643; cv=none; b=s/j09YZsAgH7dVY6NO0bbkMo+I+WzNESouDZf439QQ8Hf43fm7LngoBlDME9PCHCAzFOP9v4SHnr6yRUJ9lpRQfK3VGuDNqVOozvBRVnalSwRdiCmp05GnB5aY6Rv0N/siSC4ugX25sTxkkSCJj59DGiTry2f1IGagj26n+ih3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743336643; c=relaxed/simple;
	bh=H5WQibwXZqiogSzK5haHT4eEMOwu0pDnlWcAreVVsIQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=acsgGhKPn7tOHOCTs0vTtblxtDxfmTbP94asqAb5ksFGLAiZUwcNq3f3QBQByzhtV0ZSbO4p1QtwRfz0bmiTDpA819CgxjMyU5SGCDI3HcpVZGBjqoOzr4ViZc6mJRicibU0q7fwkELQvFOZP2uVthfa8ww2qggumJ51Js6HIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=p62biwOq; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743336618; x=1743941418; i=markus.elfring@web.de;
	bh=PJw7Yfgh23Z1MKf/flQ4K1MK58f+fwjuTvUFKJ4f+/Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p62biwOq+yoA1zO8PSmXwwE+lKvPrMqM2rGOHWu2mUUztbA769wPSp/U1r++AqrJ
	 78VoxSLNwcFDZrZDLfKQDRgsJ5r3hTNJq1L6vhIzixSq2mDJ8ggvdpXFdNZUkD4SY
	 JuCBwnGJMYWypI5G/xpPZO6v5OyQDJbRrdwCnqrJ5XApZ1cSegVuHfsNnHpLkX3v+
	 PpHIR1r0F0yIIxQdKzEBfAm16mgHYjMWxR5xM7YrrUhdrOuhcTM9q7F+NqCkm9xwR
	 7NIM+3w4Pdez7XtFM0smvp/NodhnvpmtqdAnHvz83kOulgitdfFAseS6XDchw1hiI
	 SG/LgdrfSxlM/sZO1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.13]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgibW-1tT5Vt3mzk-00hLzE; Sun, 30
 Mar 2025 14:10:17 +0200
Message-ID: <0ca9b435-7e5f-4208-a707-c9bf08f815bf@web.de>
Date: Sun, 30 Mar 2025 14:10:15 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abdun Nihaal <abdun.nihaal@gmail.com>,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 linux-wireless@vger.kernel.org,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jacobe Zang
 <jacobe.zang@wesion.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Kalle Valo <kvalo@kernel.org>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 Sai Krishna <saikrishnag@marvell.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20250330103425.44197-1-abdun.nihaal@gmail.com>
Subject: Re: [PATCH v2] wifi: brcmfmac: fix memory leak in
 brcmf_get_module_param
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250330103425.44197-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7bVlY+MQQmXGYH/E73zZJhdPu/2yM5hleg4DlKxuS+sTmJzzetK
 LIApvH/qx34almhmQOq7W85FQCSqIKOTt3VcLUW6ZpNDXFqSsQWykPSELzJjmQ/AXYZGsCG
 tzNSCrv2L+YxXb8SqKoMjjBsS4NSi5wRNanLtHjJUoyxeWk+j3jJlPIntgP9VD8Ud1mmrh0
 tupKMZPkXBGWcjptAyRhA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jKyH6NX2U7U=;XsArFErJzd0Kl51Sf6JWKx4u3rz
 uBcinJ85KfmypRpjqGqnQ6VQME1V9LluPkxhIm71dzoG9TDTzmJexlpc36Ku0S+Tl2Sj9vD4l
 p5Vyk86swNcF0WzZ/RZpGb/fc3k1ORN3Bb25Kb6cOzOI4arXF/vx3a5ryIlNGLebJOp85yWBO
 287Q8HKqfWFJWDIuGq5JeU7ygCkZwdlaWSkUMKrn0Tj8n0CFBvRN3TA1al3fdMSip8HjYCxWP
 QHwi0bfQj175sCVmtCNNRnozGjXNMuz+5iL2ak+pnaa7IA2OOv6UK5w3HKLFmD7JorJTElknN
 Oz6CNfUbwHw9TFw3TTdpf4hx1uOJYVsilB5ltYba5btT15IzWDRaXf8lc1WnDrsM4VP0krlOt
 YvyiRCW0L/FlKtdhs9EFxoN8HC9ukg0l0LpCF3VhjjFSwXU4hWk62I7xXWY5ll26lW91kbuVY
 uk5PSlf9TZQLjPnbc9OEiANdhaTRekQ4Oo0Ob+B4Gccxr9uo/o08oOzgts/Fb7z0MbcQBqEkj
 7zBtBxfnk3psJqzOldev9OBztnEbtYUcvBZCzNmb2n+ed/WrObMb+rviVahhIcNT1eDOOjxhu
 fZbX+tJRplSlHp761wrlNVqXltH8VKb0B8/8C6U2KptBJahvDs3qd1dGjS/COf1kRL/u+0AW2
 kSBqUyibC469JYXaylUrq99ibwleLYd9kRIv3XBwmuWxqyhzpDf4yaiUV5Z4TKPt2GiOUBgrD
 Ff2J2XTAo5wzVYATNVyFWKkX3UDrUcjy4/Mms3qbiRPaSxyB79poAQvWzWpqF6WxFC1gt5vt3
 Q/2hcn97RsmOhLARicHLa8g0bLERzwNxOzHKQ1f2bz037Dl5JrsA3ulgEw+yKJ7k02nzCrOBr
 dncIwb7Xhh7EtolSv0l2TcknXWt1i+lieVEy2bUEdtKOqv+4HLN7B/ORPmX37pFA/9SYdCopd
 cTRwWFZmdctvSmm2frfE5RP9VvMohrBfMOakbrvHVXnlGftqtPsRxjBuKC4BKnCu6anXZnVxS
 aPIeN72C+HH93Z9rXsqT6NQDggW+9HlzAT1SfjxLMru/ISGp2zFVorv08GXWuRFSzANV9WzT7
 6AXiWX0M0g6P3p8dQbi4IcOxYMdj5zgfFz5O6h4K62lLwVBo+j+DP8cjIJ4MUTCpn9clzKZmE
 vEktLQx3LtC0jBfDfNA220xHaWx1kzs51h0gGZ/K8eoxFGYfUut9sAiqUoARV4g77/EaMTooF
 NcBDk9bcBcnXLh2zAWFpgX0BzyMCw6YfYWP2G2mBKDJ4zG8RM3WecSwj9p2BY5Ghg6hMqdMzD
 v9HwXUETpuZ9D8UuWt7jBEkzz2LXT8YK8jaeip4O7K/ZNNQZWkYPUCoId/LceGRNK+zxjoENM
 /39alYEvT11fNTGnivcyok6MVbD0ctgJSfe3Y05gtK46Y4oZZdcPJZr3jrS2svq2bmiMEt3EY
 fiwlrZbzTgz2E6UdvWqcR7+tJJwrQQVYwGDAzCy4nt2VrRSCL

> The memory allocated for settings is not freed when brcmf_of_probe
> fails. Fix that by freeing settings before returning in error path.

  failed?

Would you like to append parentheses to any function names?

Regards,
Markus

