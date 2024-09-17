Return-Path: <linux-wireless+bounces-12903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F5297AB56
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 08:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A5A28C9E5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 06:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31671384B3;
	Tue, 17 Sep 2024 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okamibA8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B37A923;
	Tue, 17 Sep 2024 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726553846; cv=none; b=eIDKQhh6at1vIAMorR0xg52ESNRXUfJccSPUttHzNDv+6Kd/um9S6oPHJhrKwn/Udutp8KOk6YrIrrOVwD54ox7VtmE9dwSp39yGPmoua/Sj1Za26s6qMIEC3sYeiKhqXq3w8jEVVCNgctZ3GO/XIBkk4PdJGPIzGuWyq8D1Hxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726553846; c=relaxed/simple;
	bh=CB4t/+5moG0/28K8fc5AivaacXB2UZMNsXSP/NqIUrA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=a+2RQNxHm+wim42DbQgLYDykUlD980bcCMOPAyWVHP67sLE82ZVjZFOh5IpmcqS+JbrW/hPWzRRYfktMIQbiyjt83GOWdtPpvS8HJIuy73lBx3j4+aRVMH92LM/cgu1qDAXE1WrTizPCRu6qXd+5shwGHBXo1TSRECZRGZdtdpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okamibA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7298C4CEC6;
	Tue, 17 Sep 2024 06:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726553846;
	bh=CB4t/+5moG0/28K8fc5AivaacXB2UZMNsXSP/NqIUrA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=okamibA89T+tS2KYSFAwVrMBm6dqR2AErTJMj4IQZ6f9YXr0OX2iihrJjdXKkStyV
	 qUqVD8pAe3kgju5SQWuZEqiVCKKHGlWaNnvLJPHGQ9xv41IfGKjsdMkDcbQgsz4bjo
	 UhQtYqTGX4B1FocupsBBx3m8w8EWGMia6m97OvZR75XNCi3zC2cedktZrDpDeQOGN7
	 SJJrOzn9Ibyb7Kj7xHWV08/eKpvTWHbNPss8E0+QftSdQhif/VVU/bVCYYrZJYzTDD
	 T151cGYeYe6/VMUiTdqKT4c2YyuIrhiF7pYkkK8SFD1/4EtX1QOO1Y14qml61S8Snk
	 0zAvdCZQa+45A==
From: Kalle Valo <kvalo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
  linux-mediatek@lists.infradead.org,  linux-wireless@vger.kernel.org,
  Felix Fietkau <nbd@nbd.name>,  Ryder Lee <ryder.lee@mediatek.com>,
  Shayne Chen <shayne.chen@mediatek.com>,  Sean Wang
 <sean.wang@mediatek.com>,  Matthias Brugger <matthias.bgg@gmail.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,  Deren Wu
 <deren.wu@mediatek.com>,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  Ma Ke <make24@iscas.ac.cn>,
    regressions@lists.linux.dev
Subject: Re: BUG and WARNINGs from mt7921s on next-20240916
References: <144fbf79-950c-4cd1-bc68-4e00b47b03e9@gmail.com>
	<ZujCwvd4XiwljDyv@lore-desk>
Date: Tue, 17 Sep 2024 09:17:20 +0300
In-Reply-To: <ZujCwvd4XiwljDyv@lore-desk> (Lorenzo Bianconi's message of "Tue,
	17 Sep 2024 01:44:02 +0200")
Message-ID: <87ldzqdcsv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Hi,
>> 
>> I ran into some bug messages while testing linux-next on a MT8186
>> Magneton Chromebook (mt8186-corsola-magneton-sku393218). It boots 
>> to the OS, but at least Wi-Fi and Bluetooth are unavailable.
>> 
>> As a start, I tried reverting commit abbd838c579e ("Merge tag 
>> 'mt76-for-kvalo-2024-09-06' of https://github.com/nbd168/wireless")
>> and it works fine after that. Didn't have time to do a full bisect, 
>> but will try if nobody has any immediate opinions.
>> 
>> There are a few traces, here's some select lines to catch your attention,
>> not sure how informational they are:
>> 
>> [   16.040525] kernel BUG at net/core/skbuff.c:2268!
>> [   16.040531] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>> [ 16.040803] CPU: 3 UID: 0 PID: 526 Comm: mt76-sdio-txrx Not tainted
>> 6.11.0-next-20240916-deb-00002-g7b544e01c649 #1
>> [   16.040897] Call trace:
>> [   16.040899]  pskb_expand_head+0x2b0/0x3c0
>> [   16.040905]  mt76s_tx_run_queue+0x274/0x410 [mt76_sdio]
>> [   16.040909]  mt76s_txrx_worker+0xe4/0xac8 [mt76_sdio]
>> [   16.040914]  mt7921s_txrx_worker+0x98/0x1e0 [mt7921s]
>> [   16.040924]  __mt76_worker_fn+0x80/0x128 [mt76]
>> [   16.040934]  kthread+0xe8/0xf8
>> [   16.040940]  ret_from_fork+0x10/0x20
>
> Hi,
>
> I guess this issue has been introduced by the following commit:
>
> commit 3688c18b65aeb2a1f2fde108400afbab129a8cc1
> Author: Felix Fietkau <nbd@nbd.name>
> Date:   Tue Aug 27 11:30:01 2024 +0200                  
>
>     wifi: mt76: mt7915: retry mcu messages                                            
>                         
>     In some cases MCU messages can get lost. Instead of failing completely,
>     attempt to recover by re-sending them.
>      
>     Link: https://patch.msgid.link/20240827093011.18621-14-nbd@nbd.name
>     Signed-off-by: Felix Fietkau <nbd@nbd.name>
>
>
> In particular, skb_get() in mt76_mcu_skb_send_and_get_msg() is bumping skb users
> refcount (making the skb shared) and pskb_expand_head() (run by __skb_grow() in
> mt76s_tx_run_queue()) does not like shared skbs.
>
> @Felix: any input on it?

Adding regressions list to Cc.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

