Return-Path: <linux-wireless+bounces-35762-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG7XMTYc9WlOIgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35762-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 23:33:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1E64AFD1B
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 23:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0254300D440
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 21:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7BF31F9A3;
	Fri,  1 May 2026 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w/QRcQ0u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C67830B50D
	for <linux-wireless@vger.kernel.org>; Fri,  1 May 2026 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777671213; cv=none; b=LY4tNWD0a3HBzazTLjNWQVz9rMM/VaRnPq3wtDkq7KYd6p9ZG3SLeY4LqcgxSNDlE8HlisSYLMRPj7JTkGnglBI5PZMTWm+PtprAgPK+b6Z7nlVUnfGkgDm0Lwi7XI99fLr+16tloPWulPc31z264CfsciZAYWXPxww5XGduBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777671213; c=relaxed/simple;
	bh=VBCdIfMdhRSGjRAFYSHsv7WfE9XYU5ZakY5w6z/akKE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tUiL49nmmPZKE3cBJHJVIPXfCz3t8U0coI2kacH9Dd2uJhbwz+gaBqTPU7JfdZjtfyhqUXkeoYxKX58NDZmQrIyehDqRk+o8UBZ25ge/r/mAWWNJGnzbS8/2epcUd30cd1ZYv9bhrcFEeYkzb2yr1fTw7LFB/SuNnHxnB30ABeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w/QRcQ0u; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 01 May 2026 23:33:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777671209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBCdIfMdhRSGjRAFYSHsv7WfE9XYU5ZakY5w6z/akKE=;
	b=w/QRcQ0uyU3yvbMHSfXcx5jZNEJ7F/CFIQNT7CId4NSpVX0tVbHq7EMDTeyxuRfpEq+Gzw
	VQ0ooAYAtpyscY1LSFJS57186mwjUzn2aO5MSWG77WINbz12w45KGuEWWOWKZKK3SKYHQJ
	G8NnAJvMD151og9HLW2cnfB7C9nkZxU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
 Kalle Valo <kvalo@kernel.org>
CC: Yan-Hsuan Chuang <yhchuang@realtek.com>,
 Brian Norris <briannorris@chromium.org>,
 Stanislaw Gruszka <sgruszka@redhat.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, luka.gejak@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_wifi=3A_rtw88=3A_increase_TX?=
 =?US-ASCII?Q?_report_timeout_to_fix_race_condition?=
In-Reply-To: <bc0a9969-b386-42d1-ada2-99ac39e394f3@gmail.com>
References: <20260501150402.227788-1-luka.gejak@linux.dev> <72f6fffd-bd77-437f-a9d9-6a542a8b365b@gmail.com> <6CD170FE-CAED-4B91-AEED-A1AFB98FFE8A@linux.dev> <bc0a9969-b386-42d1-ada2-99ac39e394f3@gmail.com>
Message-ID: <39E7B292-F03C-4307-B0BE-62DEC191FED8@linux.dev>
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
X-Rspamd-Queue-Id: CE1E64AFD1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-35762-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[]

On May 1, 2026 11:28:38 PM GMT+02:00, Bitterblue Smith <rtl8821cerfe2@gmail=
=2Ecom> wrote:
>On 01/05/2026 23:46, Luka Gejak wrote:
>> On May 1, 2026 9:26:30 PM GMT+02:00, Bitterblue Smith <rtl8821cerfe2@gm=
ail=2Ecom> wrote:
>>> On 01/05/2026 18:04, luka=2Egejak@linux=2Edev wrote:
>>>> From: Luka Gejak <luka=2Egejak@linux=2Edev>
>>>>
>>>> The driver expects the firmware to report TX status within 500ms=2E
>>>> However, a race condition exists when the hardware is under heavy TX
>>>> load and is simultaneously interrupted by background scans or
>>>> power-saving state transitions=2E During these events, the firmware m=
ay
>>>> go off-channel for longer than 500ms, delaying the TX reports=2E
>>>>
>> Hi Bitterblue,
>> thanks for the review=2E
>>>
>>> But power saving state transitions should not happen during heavy TX l=
oad=2E
>>>
>> You are absolutely right that power save transitions don't happen=20
>> during heavy TX=2E The issue is strictly tied to off-channel dwell time=
=2E
>> I reliably trigger this on my rtl8723du (USB) by forcing background=20
>> scans (iw dev wlanX scan) while under heavy iperf3 load=2E The firmware=
=20
>> goes off-channel to scan, which delays the TX report well beyond the=20
>> current 500ms threshold=2E
>>=20
>>>> When this happens, the purge timer fires prematurely, dropping the
>>>> tracking skbs from the queue and spamming the kernel log with:
>>>> "failed to get tx report from firmware"=2E Dropping these tracking sk=
bs
>>>> prevents the driver from reporting TX status back to mac80211, which
>>>> breaks rate control accounting and degrades performance=2E
>>>>
>>>
>>> But mac80211 doesn't handle rate control for these chips=2E How much d=
oes
>>> performance degrade?
>>>
>>=20
>> I understand the firmware handles that internally=2E The performance=20
>> degradation I am actually seeing is TCP window collapse, as the host=20
>> stack interprets the dropped tracking skbs as packet loss=2E In my=20
>> testing with iperf3, throughput drops from a steady 80-90 Mbps to=20
>> near-zero for nearly 2 seconds following the scan before recovery=20
>> begins=2E
>>=20
>>>> Increase RTW_TX_PROBE_TIMEOUT to 2500ms=2E This timeout is large enou=
gh
>>>> to comfortably accommodate the duration of full WiFi background scans
>>>> and sleep transitions without incorrectly tripping the purge timer,
>>>> while still eventually catching true firmware lockups=2E
>>>>
>>>
>>> rtw88 supports many chips=2E Which one are you using?
>>>
>>> Perhaps provide a full description of the problem you encountered=2E
>>>
>>=20
>> =2E=2E=2E
>>=20
>> I also realize now that globally changing RTW_TX_PROBE_TIMEOUT to=20
>> 2500ms is too heavy-handed=2E Since this impacts all rtw88 chips,=20
>> including PCIe variants where 500ms might be exactly what is needed to
>> catch a real firmware lockup, the blast radius is too large=2E How woul=
d
>> you prefer I handle this for the v2 patch? I can either implement a=20
>> more conservative global bump, or make the timeout dynamic based on=20
>> the HCI interface so USB devices get a longer timeout to accommodate=20
>> the bus latency during scans=2E
>>=20
>> Best regards,
>> Luka Gejak
>
>No idea, I'm just asking some questions=2E=2E=2E
>
>Actually, I have one more: what version of the driver did you test?
>
>My quick test with RTL8723DU doesn't show any "failed to get tx report
>from firmware" when scanning while running iperf3=2E Does it take a long
>time to trigger?

I am testing against the latest wireless-next tree=2E
You are correct that it is an intermittent race condition, which=20
explains why it doesn't appear in every test run=2E To reproduce this, I
use a script to sustain heavy TX load while forcing background scans=20
in a loop=2E Under this stress, it typically manifests after a few=20
minutes of operation=2E
Best regards,
Luka Gejak

