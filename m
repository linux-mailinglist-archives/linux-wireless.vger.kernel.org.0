Return-Path: <linux-wireless+bounces-10460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BFC93A8C3
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 23:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E1F1F2317E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C9D13E024;
	Tue, 23 Jul 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="EsUIQgjR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76CC13D503
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721770365; cv=none; b=V4N9cXcfxEDfliiNy+z5x4mrQM6OqcZRvsIToQoK+ASNUgUjHZB0RcDLocWpKIbfBEc2p2WuBt9PybVMvKrnWI3sr0JJ2cevLma2KH/ardDv22wLHgm/3pHdE31w5tKcbOWxQVsd4EZRQamH9J1Uz8sbzBc4rqMUZCQt3csBVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721770365; c=relaxed/simple;
	bh=f1GnevIJLyEfuLlGQcA5OdHcrBKLK1a8BNJyrxTJDwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMyx2F5tkNm/5f37DcYyXHBAzoXcTnbrJKfpQ8WT+fjPiO9H7D0XTEp8zqFAM+VR2NIFJ3eTHILqv8/jePm5vaPzBzWzeU1Gr4WjpQg9G/wKHgxCahlqNXA00DcV0WVa5Vm/M10PLNJShlUzP3Ow9zmH3lYhRQvFOerW2z44I+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=EsUIQgjR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721770356; x=1722375156; i=fiona.klute@gmx.de;
	bh=gD4jYa2AtlX/ZJZEgcRDWnm4o/PDVuXLR1vuFHBn7Vs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EsUIQgjRbFjTu6aEos5dvZ/vLyM9jjrgeh4kVVAtJPKrBvgaFcMTrbRF472yWqq6
	 hwlTZxPNHWkLTj/sw3txDcTDB5iG5Ofl8qd2hK2HNq8dkeNRIgt2+N2fcXF5EUN/J
	 khkTFQm/FT5+v56zST5Qy588zCv1dOAVC3I3v9GpDq4Dyyj/avWCiw+YlDY4Yr1aW
	 hTQrPnIJtFrL2DsEYhUEzQw8AKQrelcq2Im4KfMgldpy25bss4m2yCYeYnXktD4tw
	 GLF1eIwdkYNJwpM8rI/IgHAy8vAt0Y+qyvU/mOXlGn5INC+qtoc9WrguNOzb1mO87
	 CHC15kSIu2Mi1AWghg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.125.116]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHMP-1rqxcg3sSX-00bzCm; Tue, 23
 Jul 2024 23:32:36 +0200
Message-ID: <cceb322e-0cc9-4262-ab41-54040074e4df@gmx.de>
Date: Tue, 23 Jul 2024 23:32:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] wifi: rtw88: 8703b: Fix reported RX band width
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <bca8949b-e2bd-4515-98fd-70d3049a0097@gmail.com>
 <1cfed9d5-4304-4b96-84c5-c347f59fedb9@gmail.com>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <1cfed9d5-4304-4b96-84c5-c347f59fedb9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SrQgBD9dG070m/eNaFXQr04EVVDdszmm8DmeY8de94r2eNfJ6U/
 r867SNaACyDY964UXmVWx60TDJXhZxKdHAyqGyRuZD4bwhTCfRcumwu/5wq/0qDBVbSihSJ
 6yV6Av608kXLenJoMe4l7VdSeURphIUmIs5r6bTec8Y9hFGpNi1qzXq1bZVMR7/zp5CyeA0
 lypUJpKKap2hKSP4bIQ3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:27j5tUu2dr0=;VY29DqsEtP9PKpVe29dp6duBI1K
 3ejImuB/irxdXA+soCzByDER9v+CKT75D5LZebkGeAtw0HqDeoUTo1gbBmSUkdBEZG9jIMlwu
 ffRzV2eV7mF+9P23+3W1ugJza30ppTdgQkdA2pD0QKrJulhX5zr0ZtmLHWjRnvJDyqrAVJEBf
 iget7nO7PcbmbgHha5TkKuAJXJ5F/lf9BzDd87l7wTB9kk21xMSvhaM8MMjspK81xhXaJ1Uu/
 zdGW4OP8aaeM1cd1+dubwcHhOB/axT7C+l64bBO4RRN8/kLxxNXukA8UcVzC/7z0poUYQRzxo
 EMj0RZZwR5Q/lcBTFtYNlag/RtQum6yO03ljK9dL9Fol2Gjhb43pTtGpwM+TS/JC/YFsyhJsB
 nvoPBHEG2qymwJQFXBHL3/bhAcJljPaFeAGmGptaYHeEOZLarh+/ACSKiYx+g59GUooprjww5
 /+CNqpNlqQFBZK+2qXbQ5l2sFAlq1uIx472oauS45rJw/lNntfgy6xwLVT1dEt8bAwuDTaSSW
 BYXqKeJzgjYR2NDdzNkJo6ANpWDmcxhPl7WySgZhQ/qlU8LvvlX+benPjpFMZ/4EDjdiQxgvb
 DW+ULwPgLCLDLJa6FuyvWxr7B9uOgba1XmToi4eod1UP1DGOMX26CwSEZsnwW4i8kvjKk6EoV
 mGZXZoM6/NBXY4FxaOzxZ9sNYb4GsXoR2JlXvdq2z00r9F1IMLf58j+jDmfpBujD55iZIUI2d
 eIoySvi7yuY1DbKEqBXRLscdn36Vytsi8V9gO4TSPYAcSRYPqMPc1lvW85Fuvuobi524KsB68
 pYgcm2b1qXhZDn0LtvB0v7Ig==

Am 23.07.24 um 21:32 schrieb Bitterblue Smith:
> The definition of GET_RX_DESC_BW is incorrect. Fix it according to the
> GET_RX_STATUS_DESC_BW_8703B macro from the official driver.
>
> Tested only with RTL8812AU, which uses the same bits.

Thanks for catching this! Confirmed that RTL8723CS correctly reports
20MHz, my radio environment is too noisy to connect with HT40.

Tested-by: Fiona Klute <fiona.klute@gmx.de>

> Cc: stable@vger.kernel.org
> Fixes: 9bb762b3a957 ("wifi: rtw88: Add definitions for 8703b chip")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> v3:
>   - Use Fixes and Cc: stable.
>
> v2:
>   - Use Fixes instead of Cc: stable.
> ---
>   drivers/net/wireless/realtek/rtw88/rx.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/rx.h b/drivers/net/wirel=
ess/realtek/rtw88/rx.h
> index d3668c4efc24..8a072dd3d73c 100644
> --- a/drivers/net/wireless/realtek/rtw88/rx.h
> +++ b/drivers/net/wireless/realtek/rtw88/rx.h
> @@ -41,7 +41,7 @@ enum rtw_rx_desc_enc {
>   #define GET_RX_DESC_TSFL(rxdesc)                                      =
         \
>   	le32_get_bits(*((__le32 *)(rxdesc) + 0x05), GENMASK(31, 0))
>   #define GET_RX_DESC_BW(rxdesc)                                        =
         \
> -	(le32_get_bits(*((__le32 *)(rxdesc) + 0x04), GENMASK(31, 24)))
> +	(le32_get_bits(*((__le32 *)(rxdesc) + 0x04), GENMASK(5, 4)))
>
>   void rtw_rx_stats(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
>   		  struct sk_buff *skb);

=2D-
Dipl.-Ing. Fiona Klute
Mollwitzer Str. 2
44141 Dortmund
Germany

USt.-ID/VAT number: DE363488944


