Return-Path: <linux-wireless+bounces-33108-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NAKL/rNsmmPPwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33108-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 15:30:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D9D2735E2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 15:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFCA03004D33
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA02E36EA97;
	Thu, 12 Mar 2026 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="O02oaOxF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB32347524;
	Thu, 12 Mar 2026 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325767; cv=none; b=ZFOeTvwo1cqVYGkXZZ1SZov6DyLEEINUGX505jPqEHUBL5ghh6Ba8/2CwtgdR19taZGFh44tEf7OuI8bNwZcgfAvXhIVEtLdQ5rwf9JLhd0a/j7FUHrJDFxxAqPJOC1epOoE1etBZLSuXquxadx/q1m35LITemJ9vG35O+H3/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325767; c=relaxed/simple;
	bh=Lu2+c2CLHovWhakGFFJcndqaSyk2Eatzxss+4GJJOi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwrAs+UKEA4O/DHy6tQTXTrw+QCEaXtJpitVT+QI6QmN7X9h9r9z5evltxZH3ynuRancPkgW4P7W0dsob1SjJ0JTcI1KldvV9FpBfLSOJx3HqdWFrLrQQRALx/RJNeyGdJYBBHhAvhBkl4iqZrxt9mFhW4MFc9hVaw1lBvTYBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=O02oaOxF; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773325762; x=1773930562; i=georgmueller@gmx.net;
	bh=Lu2+c2CLHovWhakGFFJcndqaSyk2Eatzxss+4GJJOi4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=O02oaOxF/a480kmrtkQMbT2hxyusqYZbAbrqaSjvdsOnqJzfEqyFhHlcERTn8xD2
	 CDh4WltZb77AklSzvodeV6o4QaKXWDB9AqQh1CJlroh3ul7HITe8Pt9CzYvOBrORJ
	 n/cB9pj65yvztd+xgXHZ4XvbMt2gVnD0WfvABcbZ+VP2I86J3u/Wge0iWeqNLfFOZ
	 jA6u/AZoCBE0sNjN7aSpxEpuUFj4coWtbyK6h0z43lx3tvmOE9S9aqk1ov8zqf4/6
	 LvhoOf31TsylllXiES9ID3X0SBOACmel7h+liptNVRCcVHStJphY4gWixkYrUkPJc
	 huFDMWRT4wgnZm9SAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1vnXtq0Avw-009Vef; Thu, 12
 Mar 2026 15:29:22 +0100
Message-ID: <42f9788c-d58a-45a4-b6f2-4df33a7e0956@gmx.net>
Date: Thu, 12 Mar 2026 15:29:21 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: Enable AP mode for RTL8188EU
To: Jes.Sorensen@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260312142155.2642993-1-georgmueller@gmx.net>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>
In-Reply-To: <20260312142155.2642993-1-georgmueller@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ie6XLOXL7qiLc3D9OtV7YpMD/dfCWeXtq0GDSW22zhNoUL441RX
 KeOyNMzL3YdNy6dpc+QbrV+k4uSxcKrmLuZwlS4dEknc84+dbWPlT4CBJOaapF5jnsSPgVC
 W+WaOlEI50aU6T28C66ZRv2YBEVxueHQnhjvTZlG8FF0CeeM80L8EGrAGBTRZKPsY3qPjdT
 t2hqGtjtIRyj4vg+XlBVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LL7xqz5Q/3Q=;slViDvMdHfgnb/DOxUV2a6TJwsa
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33108-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmx.net];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3D9D2735E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sorry, I missed the link:

Am 12.03.26 um 15:21 schrieb Georg M=C3=BCller:
> The max_macid_num is conservative. The old driver used 32 [1], some
> other sources said 64. I have not enough adapters to test any of the
> higher values. Given the usage of this chipset in nano dongles, I think
> the 16 might be high enough.
>=20

[1] https://github.com/lwfinger/rtl8188eu/blob/f5d1c8df2e2d8b217ea0113bf2c=
f3e37df8cb716/include/sta_info.h#L28

Link for max_macid_num =3D 64:
https://lore.kernel.org/linux-wireless/27e83382-4c84-1841-c428-d1e5143ea20=
c@gmail.com/


