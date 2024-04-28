Return-Path: <linux-wireless+bounces-6950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA79C8B4BE3
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Apr 2024 15:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7793828194D
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Apr 2024 13:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496616A353;
	Sun, 28 Apr 2024 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="VOFpnd+r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6BFF516
	for <linux-wireless@vger.kernel.org>; Sun, 28 Apr 2024 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714309381; cv=none; b=auQNG5fK+hD9pvfrTp6+ysFKA1lKcdDKlpRdG+s9aljaj7nS2cc5AqiGEJ8d+8McTabyzMx16kCnOAhYWeDt1HziH/jF9s0jMyMKQz3Xjum8BR8XZ95mvHh/FsCv/OeKS2frQdiphBi4v40hau+giuD6CJl2S02yEwZvsUJf2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714309381; c=relaxed/simple;
	bh=R3O2JQfBP6xEEacrSvG0spb5D3MayLGlMWNIPKdaF9c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nY8xoCqdkjy4xUzBf4lRb2JS2c15Iv1FFvAaIOhh6rpQ+Q8dwHFatgYFN9fQe1g8cT3Ghxme/uiBuHSpmmnuIkoKejJzmqcVX6njOmHmf/7h6ig/OYmrMHP7qdke/823gu8lEAM9uh/ySmZ3/br5ucRTyGypvErgyow0KpXrfJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=VOFpnd+r; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Content-Type:Mime-Version:Subject:From:Date:
	Message-Id; bh=R0inuKM4+8aVSpQ081PkQgT7KM/xiGQY+z5xhcTASgM=; b=V
	OFpnd+r/FQUkvb81/uhi5++6W5N7pMegUWTGi5dv74y/Fg0CTkVS0hokLO6oTYC6
	uQwu2a8biHBTeBb1aShHefG0P59EHeyFNNCJvHgbgGHD4GymWeHKWqWP7xzjdxBF
	qB98aq2TiglcYC9zjLarutaffkhIolWyTBKTKVGPLM=
Received: from smtpclient.apple (unknown [120.231.220.21])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wDn75zkSC5mdEJvAA--.49303S3;
	Sun, 28 Apr 2024 21:02:29 +0800 (CST)
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
In-Reply-To: <A8B8371F-2FF4-45C7-9BEA-BE7FD5CA288F@126.com>
Date: Sun, 28 Apr 2024 21:02:28 +0800
Cc: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
 ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org,
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
 kernel test robot <lkp@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <22DBEF03-83C8-460D-AF50-E1DE0038C072@126.com>
References: <20240427091248.2013946-1-quic_tamizhr@quicinc.com>
 <c8812227-ae90-4bbe-9fd3-425b61e36838@quicinc.com>
 <A8B8371F-2FF4-45C7-9BEA-BE7FD5CA288F@126.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-CM-TRANSID:_____wDn75zkSC5mdEJvAA--.49303S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1fJFy7ZFyxAw4UZw4UCFg_yoW5urW5pa
	ySqFsIkr95Jryxtr4SqFZ7CF15twsYqr9rGr1fC34UWF4q9a4SgFnFgrWUWF98CFW5Ga4j
	vF4jqw1kKayqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UUnY7UUUUU=
X-CM-SenderInfo: 5phl501qjo53a6rslhhfrp/1tbiTh-OhmVLaYj0TwABss



> On Apr 28, 2024, at 8:54 PM, Meiyong Yu <meiyong.yu@126.com> wrote:
>=20
>=20
>=20
>> On Apr 28, 2024, at 6:46 AM, Jeff Johnson <quic_jjohnson@quicinc.com> =
wrote:
>>=20
>> On 4/27/2024 2:12 AM, Tamizh Chelvam Raja wrote:
>>> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>>>=20
>>> If STATUS_BUFFER_DONE is not set for a monitor status ring entry,
>>> we don't process the status ring until STATUS_BUFFER_DONE set
>>> for that status ring entry.
>>>=20
>>> During LMAC reset it may happen that hardware will not write
>>> STATUS_BUFFER_DONE tlv in status buffer, in that case we end up
>>> waiting for STATUS_BUFFER_DONE leading to backpressure on monitor
>>> status ring.
>>>=20
>=20
> Can you known the LMAC reset event, if you can known, you can set all =
the ring entry
> status  to done after reset is done, and the logic of code will be =
more clear.
>=20

If sene of the LMAC reset event is asynchronous, You can do this:
  1) when  LMAC init than set  a value to the new add global variabe =
lmac_life_cycle_id
  2) before add tlv to ring, set lmac_life_cycle_id to tlv
  3) when LMAC reset event is trigger, increase the value of =
lmac_life_cycle_id=20
 4) when get the status of tlv in ring(must delay for same period to =
ensure the real send ring is already send),=20
    check the value  lmac_life_cycle_id  in tlv, if it smaller than the  =
global one set tlv status to DONE=20


>>> To fix the issue, when HP(Head Pointer) + 1 entry is peeked and if =
DMA
>>> is not done and if HP + 2 entry's DMA done is set,
>>> replenish HP + 1 entry and start processing in next interrupt.
>>> If HP + 2 entry's DMA done is not set, poll onto HP + 1 entry DMA
>>> done to be set.
>>>=20
>>> Also, during monitor attach HP points to the end of the ring and
>>> TP(Tail Pointer) points to the start of the ring.
>>> Using ath11k_hal_srng_src_peek() may result in processing invalid =
buffer
>>> for the very first interrupt. Since, HW starts writing buffer from =
TP.
>>>=20
>>> To avoid this issue call ath11k_hal_srng_src_next_peek() instead of
>>> calling ath11k_hal_srng_src_peek().
>>>=20
>>> Tested-on: IPQ5018 hw1.0 AHB =
WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
>>>=20
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: =
https://lore.kernel.org/oe-kbuild-all/202303281719.CvnPkOiK-lkp@intel.com/=

>>=20
>> I believe these are misleading. LKP didn't find the problem you are =
fixing, it
>> found a problem in the implementation of the patch.
>> So I would move these below the "---" so the LKP knows the issue it =
found is
>> fixed, but the git history isn't itself isn't misleading
>>=20
>>> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>>> Co-developed-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
>>> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
>>> ---
>>> v3:
>>> * Rebased on top of ToT
>>> v2:
>>> * Fixed compilation warning Reported-by: kernel test robot =
<lkp@intel.com>
>>>=20
>>> drivers/net/wireless/ath/ath11k/dp_rx.c | 88 =
++++++++++++++++++++++---
>>> drivers/net/wireless/ath/ath11k/hal.c   | 14 ++++
>>> drivers/net/wireless/ath/ath11k/hal.h   |  2 +
>>=20
>> My Qualcomm Innovation Center copyright checker reports:
>> drivers/net/wireless/ath/ath11k/dp_rx.c copyright missing 2024
>> drivers/net/wireless/ath/ath11k/hal.c copyright missing 2024
>>=20
>=20


