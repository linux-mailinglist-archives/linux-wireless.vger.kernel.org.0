Return-Path: <linux-wireless+bounces-21180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CC6A7D27E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 05:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC203AC8FB
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 03:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F33D1863E;
	Mon,  7 Apr 2025 03:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="oTfKK+4m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D911C36;
	Mon,  7 Apr 2025 03:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743996665; cv=none; b=c1oxu2o2A4OXqX1bAcNR0D3/M3T9tj9ivX6kcqjq0R9N/2XABGITWgFd6zTDLHP7f5BeeLAvnHoMSdtsL//8wClVMXOEiaC5QBRjQZgVbWSgZNypxZUFc7uUJ7EY/CODRMxqIgMdmiZ+MpkDmtyQSp3/pPMuUnjvCj2LUOUqvXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743996665; c=relaxed/simple;
	bh=F4YPuhYwwH5EPtzJdyUauY3TMCnUWvTAe9kMB/iwmNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JX9JFro39Be/JnwiexhLnvpLS7pO3S2g3o6x5n8vkyq6jvEVA4SPW411gFBNjBlW91/IyEE56RbDAD9MTHZfWnx6n6SPMt9DZyD7hWCvUVj87J/i1diWMRPDaV+uUXfyUHVmM8vQH0qq+Np9dHruu9K+6qT1VKRc6WyCQDJcZSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=oTfKK+4m; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5373Ur4T2397097, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743996653; bh=F4YPuhYwwH5EPtzJdyUauY3TMCnUWvTAe9kMB/iwmNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=oTfKK+4mjg6OZkCIZi2ZTyxJ8H4WQGfe1BHn7O0vvi/8Y5yDfwlwZc1VdLsLWoIqZ
	 o/qHE1/YkOuL1LEW+UOyNE9FyWtaYrFOoLnLtCOZglyCAQuRmAg7KwkOMlwgTb0lCr
	 UEdbGeqS1NnT9uC+ix8jmTTZtpn3b3mPE7sQnwkrKA93r7lSviilYrPjzBy/F8Xv4U
	 auTfDhfHqG6tGCPx2a8HdaywF1+0DfBdQJeZNS/fRHCxtP8JGIqbfmvSeAOc+i8+8R
	 HU7bJD8lnRaHoqmWt4RhhdKZn3mMTL89lybli4eJBN4kNZeoXwd0H4Wd7lQLu1H/Zf
	 KJZoa8RpIirEQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5373Ur4T2397097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Apr 2025 11:30:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Apr 2025 11:30:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 7 Apr 2025 11:30:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 7 Apr 2025 11:30:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zhen XIN <zhen.xin@nokia-sbell.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Subject: RE: [RFC -v1] wifi: rtw88: sdio: Tx status for management frames
Thread-Topic: [RFC -v1] wifi: rtw88: sdio: Tx status for management frames
Thread-Index: AQHbo+jJuNfRBVSN0k+LjlPmG1YP3LOXjoew
Date: Mon, 7 Apr 2025 03:30:51 +0000
Message-ID: <9d908c7c77684260818470225b8a0980@realtek.com>
References: <20250402160310.996141-1-zhen.xin@nokia-sbell.com>
In-Reply-To: <20250402160310.996141-1-zhen.xin@nokia-sbell.com>
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

Hi Martin,

I replied original mail, because I think discussion would be clearer.

Zhen XIN <zhen.xin@nokia-sbell.com> wrote:
> Rtl8732ds doesn't work in AP-Mode due to the missing tx status for manage=
ment frames
> This patch enables tx status report for all tx skbs
>=20
> Signed-off-by: Zhen XIN <zhen.xin@nokia-sbell.com>
> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wire=
less/realtek/rtw88/sdio.c
> index e024061bdbf7..84f71e13b5ae 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -1186,7 +1186,7 @@ static int rtw_sdio_request_irq(struct rtw_dev *rtw=
dev,
>  }
>=20
>  static void rtw_sdio_indicate_tx_status(struct rtw_dev *rtwdev,
> -                                       struct sk_buff *skb)
> +                                       struct sk_buff *skb, enum rtw_tx_=
queue_type queue)
>  {
>         struct rtw_sdio_tx_data *tx_data =3D rtw_sdio_get_tx_data(skb);
>         struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
> @@ -1195,7 +1195,7 @@ static void rtw_sdio_indicate_tx_status(struct rtw_=
dev *rtwdev,
>         skb_pull(skb, rtwdev->chip->tx_pkt_desc_sz);
>=20
>         /* enqueue to wait for tx report */
> -       if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
> +       if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS && queue <=3D RT=
W_TX_QUEUE_VO) {

Is this because you have seen "failed to get tx report"?
Have you tried to increasing RTW_TX_PROBE_TIMEOUT?

If it still can't get TX report, we might take this workaround with comment=
s
to mention why we need it. Or a local variable with proper naming to point =
out
this, like

	bool queue_has_no_tx_report =3D queue > RTW_TX_QUEUE_VO;


By the way, USB behavior is very like to SDIO, but TX report seems to work =
well.=20

>                 rtw_tx_report_enqueue(rtwdev, skb, tx_data->sn);
>                 return;
>         }
> @@ -1227,10 +1227,7 @@ static void rtw_sdio_process_tx_queue(struct rtw_d=
ev *rtwdev,
>                 return;
>         }
>=20
> -       if (queue <=3D RTW_TX_QUEUE_VO)
> -               rtw_sdio_indicate_tx_status(rtwdev, skb);
> -       else
> -               dev_kfree_skb_any(skb);
> +       rtw_sdio_indicate_tx_status(rtwdev, skb, queue);

I think this change is reasonable, since skb via all kinds of queues could=
=20
set IEEE80211_TX_CTL_REQ_TX_STATUS.

>  }
>=20
>  static void rtw_sdio_tx_handler(struct work_struct *work)
> --
> 2.25.1


