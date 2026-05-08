Return-Path: <linux-wireless+bounces-36103-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHByEqpn/WkMdgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36103-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 06:33:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B655B4F18D1
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 06:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B41130059A9
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 04:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659AB3C1F;
	Fri,  8 May 2026 04:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ofus8D2l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02372F8EAC
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214823; cv=none; b=QUF8p4bVyUQT28Dn0vqBIBotHCignl0Hg9zXaeLY99DmUpg3WmtnAVEpEXYinS02UAcC88jnbWLnTBNHrNa22hAsxQ6qEN7FsE0IQDCyaDSZzuXCyRZU4GUfau9lDLMsdJsCq7tIdzVnlKnYBvRvmC1AjDS3OjEWofAp7ARNkQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214823; c=relaxed/simple;
	bh=CF6CzsRqWja1BJc1mI1nxHf2+ArKjd7JVrHbaoU6erc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jMIY/M2GpAk6ABfSz1cnM18BGD2+IEvDfbk72aqvZqNgXUJ2dxrMQ2D1uTcQsbrM/GqxiqR02bvE+NIdZIM9vTVtYkbrALrpp45+BlxUjWii3vs9V82TiSe9JtTKT2oA+UMzloP+pYF+sq0YrtWoBMoOQLJeJ6w5WDC67ZX2WCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ofus8D2l; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 08 May 2026 06:33:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778214819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pE5lh1EP4AvUvaUhonsJnT7fLdhXLCTLwJ90eIHpPg=;
	b=ofus8D2lGEbnlCZdXHdMik3eeeAKrjxcxV97a+Mob84fY8T5W+BzNQDf8ZRN5VNIQ6fdhi
	T8QrzM+HBiGqxHuinMZ3l6DAeeABJbo6NOueXkSud+cw3e5nwoqaJmLyO3zLkG68TXIF14
	XOEQ7jxsJju8zxrNbd50thbOrTYDcVc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, luka.gejak@linux.dev
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_v2=5D_wifi=3A_rtw88=3A_usb=3A_fi?=
 =?US-ASCII?Q?x_memory_leaks_on_USB_write_failures?=
In-Reply-To: <25a127932474456f862b0a20f7c60b65@realtek.com>
References: <20260507163709.73581-1-luka.gejak@linux.dev> <25a127932474456f862b0a20f7c60b65@realtek.com>
Message-ID: <1C7E1191-635B-4806-946C-62DD1C82F79A@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B655B4F18D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36103-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

On May 8, 2026 5:47:55 AM GMT+02:00, Ping-Ke Shih <pkshih@realtek=2Ecom> wr=
ote:
>luka=2Egejak@linux=2Edev <luka=2Egejak@linux=2Edev> wrote:
>> From: Luka Gejak <luka=2Egejak@linux=2Edev>
>>=20
>> When rtw_usb_write_port() fails to submit a USB Request Block (URB)
>> (e=2Eg=2E, due to device disconnect or ENOMEM), the completion callback=
 is
>> never executed=2E
>>=20
>> Currently, the driver ignores the return value of rtw_usb_write_port()
>> in rtw_usb_write_data() and rtw_usb_tx_agg_skb()=2E Because these
>> functions rely on the completion callback to free the socket buffers
>> (skbs) and the transaction control block (txcb), a submission failure
>> results in:
>> 1=2E A memory leak of the allocated skb in rtw_usb_write_data()=2E
>> 2=2E A memory leak of the txcb structure and all aggregated skbs in
>>    rtw_usb_tx_agg_skb()=2E
>>=20
>> Fix this by checking the return value of rtw_usb_write_port()=2E If it
>> fails, explicitly free the skb in rtw_usb_write_data(), and properly
>> purge the tx_ack_queue and free the txcb in rtw_usb_tx_agg_skb()=2E
>>=20
>> The issue was discovered in practice during device disconnect/reconnect
>> scenarios and memory pressure conditions=2E Tested by verifying normal =
TX
>> operation continues after the fix without regressions=2E
>
>Did the memory pressure condition happen? and falls into the cases you ar=
e
>adding? This is main thing I want to know=2E
>
>>=20
>> Fixes: 87caeef032fc ("wifi: rtw88: Add rtw8723du chipset support")
>
>I don't find this commit touching the code related to this patch=2E
>
>> Cc: stable@vger=2Ekernel=2Eorg
>> Tested-by: Luka Gejak <luka=2Egejak@linux=2Edev>
>> Signed-off-by: Luka Gejak <luka=2Egejak@linux=2Edev>
>> ---
>> Changes in v2:
>>  - Use ret =3D rtw_usb_write_port(=2E=2E=2E); style, and check by next =
line (in
>>    rtw_usb_tx_agg_skb)
>>  - Remove unnecessary comment
>>  - Use ieee80211_purge_tx_queue() instead of skb_queue_purge()
>
>If it falls into the case, you will see some warnings without this change=
=2E
>
>Again, I'd like to know if OOM can happen in your test? If not, the test
>you are doing will prove nothing, since your changes are executed only if=
 OOM=2E
>
>>  - Add testing details to commit message
>>=20
>
While triggering a genuine OOM condition (-ENOMEM) during=20
usb_submit_urb is admittedly difficult to force and rare in standard=20
environments, my testing primarily relied on device disconnects=2E
When a USB adapter is abruptly unplugged, rtw_usb_write_port()=20
naturally fails to submit the URB=20
(returning -ENODEV, -ESHUTDOWN, etc=2E)=2E When this happens, the USB=20
subsystem never executes the completion callback=20
(rtw_usb_write_port_tx_complete or rtw_usb_write_port_complete)=2E=20
Because the original code ignored the return value of=20
rtw_usb_write_port(), it leaked the skb and txcb structures every time
a write was attempted immediately following a disconnect=2E Checking the
return value catches this exact submission failure and frees the=20
structures on the spot=2E
And should I use commit that introduced USB support for Fixes tag?
Best regards,
Luka Gejak

