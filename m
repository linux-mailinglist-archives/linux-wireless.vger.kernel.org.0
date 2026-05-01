Return-Path: <linux-wireless+bounces-35760-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id o2hIC1IR9WmTIAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35760-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 22:47:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F794AF910
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 22:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A60473017C20
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 20:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729AC31AABF;
	Fri,  1 May 2026 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Diq3/lpn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682CE13A258;
	Fri,  1 May 2026 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777668428; cv=none; b=FWIi/Nq3Qn/nszkbT3Z1Tu8MXk1qMd4Onia5BmX4d4LJTElPiTyf+pcoJugFbC0YpHj+7bBBUqo/iWu9btgQsSEZK3UHH0NlfGRV8qCva/WroHpjL88Et2RSj0t/5XgbVhDe502X+FY7bzjLRVop7/UMTj++CtsVe0amdoXoM2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777668428; c=relaxed/simple;
	bh=8wnO9B0Eu6mpNIqDouO4jaaMmliPGSkqOKx4553yYLY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jrzndDxZtAVxXwDqzHwXwCHB9lZz11aIaCuXyS5xgMdbtO1vHJr2g+6aKVWusoaIM35jsOotbsDebYQk8XblkFMjDXCWZSplmAvTSWNEJoMrf7hxmXFPq+N+l7pmAsh7oG0vSrl9Sg2JT69wnslyaU3rYnsN1g6qqmQ9Ec72Cus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Diq3/lpn; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 01 May 2026 22:46:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777668423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wnO9B0Eu6mpNIqDouO4jaaMmliPGSkqOKx4553yYLY=;
	b=Diq3/lpntL7ul9Ajpu/jhcUuuR6F/rGVA/IArTkYSUWHSFh1q77ixK733DgwZcz+FEOIcu
	HbYzg49Xwct6ybioc4jTSMUGwIZSysJWCk9a6iNsY4Kf7Jbk1LxhsqFmbLnIe+jmOsppap
	XEbkUn6RnaGWx0uzUMpPncLnziE+IkY=
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
In-Reply-To: <72f6fffd-bd77-437f-a9d9-6a542a8b365b@gmail.com>
References: <20260501150402.227788-1-luka.gejak@linux.dev> <72f6fffd-bd77-437f-a9d9-6a542a8b365b@gmail.com>
Message-ID: <6CD170FE-CAED-4B91-AEED-A1AFB98FFE8A@linux.dev>
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
X-Rspamd-Queue-Id: B8F794AF910
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35760-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

On May 1, 2026 9:26:30 PM GMT+02:00, Bitterblue Smith <rtl8821cerfe2@gmail=
=2Ecom> wrote:
>On 01/05/2026 18:04, luka=2Egejak@linux=2Edev wrote:
>> From: Luka Gejak <luka=2Egejak@linux=2Edev>
>>=20
>> The driver expects the firmware to report TX status within 500ms=2E
>> However, a race condition exists when the hardware is under heavy TX
>> load and is simultaneously interrupted by background scans or
>> power-saving state transitions=2E During these events, the firmware may
>> go off-channel for longer than 500ms, delaying the TX reports=2E
>>=20
Hi Bitterblue,
thanks for the review=2E
>
>But power saving state transitions should not happen during heavy TX load=
=2E
>
You are absolutely right that power save transitions don't happen=20
during heavy TX=2E The issue is strictly tied to off-channel dwell time=2E
I reliably trigger this on my rtl8723du (USB) by forcing background=20
scans (iw dev wlanX scan) while under heavy iperf3 load=2E The firmware=20
goes off-channel to scan, which delays the TX report well beyond the=20
current 500ms threshold=2E

>> When this happens, the purge timer fires prematurely, dropping the
>> tracking skbs from the queue and spamming the kernel log with:
>> "failed to get tx report from firmware"=2E Dropping these tracking skbs
>> prevents the driver from reporting TX status back to mac80211, which
>> breaks rate control accounting and degrades performance=2E
>>=20
>
>But mac80211 doesn't handle rate control for these chips=2E How much does
>performance degrade?
>

I understand the firmware handles that internally=2E The performance=20
degradation I am actually seeing is TCP window collapse, as the host=20
stack interprets the dropped tracking skbs as packet loss=2E In my=20
testing with iperf3, throughput drops from a steady 80-90 Mbps to=20
near-zero for nearly 2 seconds following the scan before recovery=20
begins=2E

>> Increase RTW_TX_PROBE_TIMEOUT to 2500ms=2E This timeout is large enough
>> to comfortably accommodate the duration of full WiFi background scans
>> and sleep transitions without incorrectly tripping the purge timer,
>> while still eventually catching true firmware lockups=2E
>>=20
>
>rtw88 supports many chips=2E Which one are you using?
>
>Perhaps provide a full description of the problem you encountered=2E
>

=2E=2E=2E

I also realize now that globally changing RTW_TX_PROBE_TIMEOUT to=20
2500ms is too heavy-handed=2E Since this impacts all rtw88 chips,=20
including PCIe variants where 500ms might be exactly what is needed to
catch a real firmware lockup, the blast radius is too large=2E How would
you prefer I handle this for the v2 patch? I can either implement a=20
more conservative global bump, or make the timeout dynamic based on=20
the HCI interface so USB devices get a longer timeout to accommodate=20
the bus latency during scans=2E

Best regards,
Luka Gejak

