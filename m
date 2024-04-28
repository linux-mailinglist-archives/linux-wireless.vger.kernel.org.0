Return-Path: <linux-wireless+bounces-6949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AE68B4BDE
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Apr 2024 14:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294921F21446
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Apr 2024 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243BE653;
	Sun, 28 Apr 2024 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Ydbdm4mh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BAB6BB50
	for <linux-wireless@vger.kernel.org>; Sun, 28 Apr 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714308921; cv=none; b=L+u9yqrOmjo6m6Mt4J8BjO5XGexyp1yK8OmnMRE/EwXUdzJx3M1i4e1Xes5YcNVXyyesNB+BDee6YH2+P/n1UoYgsHKcpGrkS/7hTVRFaVl6xdCepasoDXUK3uBnHoRUHPIsDkn2IY2Z6eVfBm0srUibqhF1Se7J19fGzGeFyLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714308921; c=relaxed/simple;
	bh=JzbEui4yS1AogghGq+oCWwA4nSawR+dLZfkvtOzoCmY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jYM0l5xnH1OIf2D816DjTwTblSyJJlD9Uy3s+Quvh4mZskFdnIQ97N30TdKmDlXF2GyF9vIfSSTIApkSvBZyBtMUbHfdqWL3Ye4tzp0nvyKuy6cCEVO2zrk+nWfCDZA8T+OiM+POQ4fLzumR9WeNFoX4t7xyTcQCkw3u1AVCbnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Ydbdm4mh; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Content-Type:Mime-Version:Subject:From:Date:
	Message-Id; bh=hHUahLrMyWRrlTG2ckWoaVOAX6iPHfvsJqGLHw78ruk=; b=Y
	dbdm4mhxPP84Ltf3AW5IV9kw+s2KKMr70Q8bRmXhXZjGxRrtCFkyz33E67NvMyNv
	NWNU0dLrEExYuwu8PSgpxJQYx1VFqBIJfUv7NLv0IRxIrn0OlSgTpHqal3Vi5FNI
	XhdSZfOSMwVnt/WvoNf6wOQU4thYjcQFUWICZXmdLg=
Received: from smtpclient.apple (unknown [120.231.220.21])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDn75wWRy5mPdcnBg--.57798S3;
	Sun, 28 Apr 2024 20:54:48 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCHv3] wifi: ath11k: skip status ring entry processing
From: Meiyong Yu <meiyong.yu@126.com>
In-Reply-To: <c8812227-ae90-4bbe-9fd3-425b61e36838@quicinc.com>
Date: Sun, 28 Apr 2024 20:54:42 +0800
Cc: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
 ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org,
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
 kernel test robot <lkp@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8B8371F-2FF4-45C7-9BEA-BE7FD5CA288F@126.com>
References: <20240427091248.2013946-1-quic_tamizhr@quicinc.com>
 <c8812227-ae90-4bbe-9fd3-425b61e36838@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-CM-TRANSID:_____wDn75wWRy5mPdcnBg--.57798S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw13Gr1rWw13tr15Xr43KFg_yoW5Xr17pa
	yFgan0kF95J34xJw4fXF4xZF15JanYq3y2kr4xA34fWr4jva4fKFnFgrWUJF98CFW5Ga42
	vr42qw1qkayqv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UjzuAUUUUU=
X-CM-SenderInfo: 5phl501qjo53a6rslhhfrp/1tbiOxvOhmVLaYi6igAAsX



> On Apr 28, 2024, at 6:46 AM, Jeff Johnson <quic_jjohnson@quicinc.com> =
wrote:
>=20
> On 4/27/2024 2:12 AM, Tamizh Chelvam Raja wrote:
>> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>>=20
>> If STATUS_BUFFER_DONE is not set for a monitor status ring entry,
>> we don't process the status ring until STATUS_BUFFER_DONE set
>> for that status ring entry.
>>=20
>> During LMAC reset it may happen that hardware will not write
>> STATUS_BUFFER_DONE tlv in status buffer, in that case we end up
>> waiting for STATUS_BUFFER_DONE leading to backpressure on monitor
>> status ring.
>>=20

Can you known the LMAC reset event, if you can known, you can set all =
the ring entry
status  to done after reset is done, and the logic of code will be more =
clear.

>> To fix the issue, when HP(Head Pointer) + 1 entry is peeked and if =
DMA
>> is not done and if HP + 2 entry's DMA done is set,
>> replenish HP + 1 entry and start processing in next interrupt.
>> If HP + 2 entry's DMA done is not set, poll onto HP + 1 entry DMA
>> done to be set.
>>=20
>> Also, during monitor attach HP points to the end of the ring and
>> TP(Tail Pointer) points to the start of the ring.
>> Using ath11k_hal_srng_src_peek() may result in processing invalid =
buffer
>> for the very first interrupt. Since, HW starts writing buffer from =
TP.
>>=20
>> To avoid this issue call ath11k_hal_srng_src_next_peek() instead of
>> calling ath11k_hal_srng_src_peek().
>>=20
>> Tested-on: IPQ5018 hw1.0 AHB =
WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
>>=20
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: =
https://lore.kernel.org/oe-kbuild-all/202303281719.CvnPkOiK-lkp@intel.com/=

>=20
> I believe these are misleading. LKP didn't find the problem you are =
fixing, it
> found a problem in the implementation of the patch.
> So I would move these below the "---" so the LKP knows the issue it =
found is
> fixed, but the git history isn't itself isn't misleading
>=20
>> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>> Co-developed-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
>> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
>> ---
>> v3:
>>  * Rebased on top of ToT
>> v2:
>>  * Fixed compilation warning Reported-by: kernel test robot =
<lkp@intel.com>
>>=20
>> drivers/net/wireless/ath/ath11k/dp_rx.c | 88 =
++++++++++++++++++++++---
>> drivers/net/wireless/ath/ath11k/hal.c   | 14 ++++
>> drivers/net/wireless/ath/ath11k/hal.h   |  2 +
>=20
> My Qualcomm Innovation Center copyright checker reports:
> drivers/net/wireless/ath/ath11k/dp_rx.c copyright missing 2024
> drivers/net/wireless/ath/ath11k/hal.c copyright missing 2024
>=20


