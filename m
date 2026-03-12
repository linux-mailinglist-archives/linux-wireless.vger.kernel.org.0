Return-Path: <linux-wireless+bounces-33117-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEhgE6HlsmktQwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33117-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:11:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F4A27545C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDA3730A04E5
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F023CAE9F;
	Thu, 12 Mar 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="KINH1iJo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667613C5DDB;
	Thu, 12 Mar 2026 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331691; cv=none; b=CsPIczIP1SPEA8vZmr23SaF/yYzmXRLZsUEP3leUIlNKFS2/tuoPJ7nL8aD2ObuwFjwTSPlWo1vYtHp0tr/gukaGoVzdd23nmyRarIL8fI774rBCDpj+7ikj3QTJynTTOAFAxiT0ZkwPlMqpEFX4tKCZz/wJEuvfLawcSIV0oBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331691; c=relaxed/simple;
	bh=CGsmgwDbwf1ORFGsoDw0qm29CIZKwvvrRlTdNdkmg7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gClVyjbfejbED4gZBZYyf9UTxlY22gbe26LfmKTx4bOwA6POloLfoI9P34fNffclfrfF0DXftNxvWIKaxoq3nmnBulin7vmAE+Y94RsHo/zlHIRUH5hoC6K3HF9AVUgNzq0jivt7LnGCbvHbLj56WxNfLbNAQ9k8j2nT6deC8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=KINH1iJo; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773331687; x=1773936487; i=georgmueller@gmx.net;
	bh=CGsmgwDbwf1ORFGsoDw0qm29CIZKwvvrRlTdNdkmg7M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KINH1iJoPVF/a25/MG63iL77GWeb7HwEm0R4WonmRuGqOaOQ0loE9y12M+wZoMV7
	 qO6RpgusWf8x1sWQpAzBZC6s2ixh7C+ii8zCvthDeXBYUG9eNOK5qeaCV71e4p3AA
	 oXHBzEZ5uNdgWElMJgzMDWz9LOOXzmyjf+7OmccMshlpRZyuxvpIpyQvbM+y7bdV+
	 MeaUAoVao/h/ccLrX8K9wCE9AwPaZKlh0HJerF/rGmjC9uQeVk3vwrDXb9Qoi6xJv
	 hW7AVPEzyUf4dvyRVdGsCndfGbodlw9oAybt2yyFdE4ngts31bFeLf2Nx+IACAUvJ
	 V20X/gifaP9M2B8wiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDkw-1vgjpG477g-00yfun; Thu, 12
 Mar 2026 17:08:07 +0100
Message-ID: <98711825-cbf3-46ad-a26c-9f1d284480ac@gmx.net>
Date: Thu, 12 Mar 2026 17:08:06 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: Enable AP mode for RTL8188EU
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, Jes.Sorensen@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260312142155.2642993-1-georgmueller@gmx.net>
 <093ad0f2-8265-4560-a51f-397eb34f7f1c@gmail.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>
In-Reply-To: <093ad0f2-8265-4560-a51f-397eb34f7f1c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BmBYfJPpezJ57JVT1iI2/WvhuK8GEDH8pZdyj2qGAD8NivVcYuj
 3dsDxKt+xM2nf8iXDnj5+jzm7juj0/ABex6kl0FaWiinALwplMLs5pzOsRftovywh4SP/F1
 F1DoNsDk/CgwYMo3RL/2j+tcZbXXwLIOW7PAty4nyby+7lLsOpUUvbnsMT9JqHYXCkI52uD
 7A8DVnA8g+3f/Qwg6DSbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RGrVuUfbyDk=;2gFr6Z1PRzpXC9sRuoaEMqrOR3o
 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
 zZH+yYJmePEMm+5oGpBC
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33117-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net]
X-Rspamd-Queue-Id: 99F4A27545C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Am 12.03.26 um 16:58 schrieb Bitterblue Smith:
> On 12/03/2026 16:21, Georg M=C3=BCller wrote:
>> Allow devices with this driver to be used as a wireless access point.
>>
>> I successfully tested this with a TP-Link TP-Link TL-WN725N adapter.
>>
>> Experiments two years ago failed, but some other improvements to the
>> driver seemed to have resolved theses issues.
>>
>=20
> The rate control code still doesn't handle more than one station.
> It's not going to work right.
>=20
> It shouldn't be too complicated. The ra_info member of rtl8xxxu_priv
> needs to become an array.

Ok, I have only tested it with one client in my setup.

So the ra_info array needs to of size max_macid_num?
Dynamically allocated or hard-coded in struct rtl8xxxu_priv (8188e seems
to be the only user of struct rtl8xxxu_ra_info)?

Best regards,
Georg


