Return-Path: <linux-wireless+bounces-33170-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCIPL+BRs2l8UwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33170-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 00:53:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 667CC27B5B8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 00:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEBD1300C02C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 23:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81173D9DAF;
	Thu, 12 Mar 2026 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="oehuqMnQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC41377016;
	Thu, 12 Mar 2026 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359582; cv=none; b=M71MH3glvI2d7EC0i6vNIryg9i9l45O5FhDXTQWZENgjWPopLpvlmWuSidyfZY+0zefRmrckhJye58hn9blewmzvKUU/pxP0mr2W+K6DDq9rx2cLL3Sbg2RdxUYYudEabHnhPm/u/pE17hmOGoZme7+uqc4Dq8l4m/1I5WaN89M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359582; c=relaxed/simple;
	bh=U8q13vUIZSlhWn31PbeGa6CfhOiv8jKKTs3UiWNpFhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLtVgisEInTNgyIcPsoaI4AYZ7N1wmaBgSf0kQnnO09X86Ts54BWePco2Qppx74mde35fuoOFIcLNoyfFyU11ptmQ1Zz5PwztUM9Mke8chnkVak2UNfm92njMGK0uHrcuDLaknO4KYCvcPeg4xuhh1Zt8GxJs9yyt0f5+bTwEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=oehuqMnQ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773359579; x=1773964379; i=georgmueller@gmx.net;
	bh=U8q13vUIZSlhWn31PbeGa6CfhOiv8jKKTs3UiWNpFhM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oehuqMnQBni2ZgNlZrLEzt6nfXfnMVAXcXcd/8WWsjekV+0mWoYBycoSKBYENiei
	 r0iEwzUpPlMA888HqDsvOUVfJj0HcCrZRIxHF6jkPlnpBzPT9BM92TQMUIJx/M/RQ
	 9BYkJhXN+4Dfjp74sDgxZyaQEp2XHUpVGXqss5jLQOIXCXMeRA7sfY4nTFNM0Mf8y
	 K+naW8w0tMM0mODfAO7iwbOwIOPuVSBlZ4dFa+1KnXqauH6dLtXkF3ERFyEZvpn21
	 CmxY9dfONXTtki0yUsIS67hClunTA4jR93nvkyyqd+I3cQ/tLHoQlLmjiwDmFINuQ
	 90zoSv6Q8nAbUFp8Fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU9Z-1vMX8L3VPX-00fm1b; Fri, 13
 Mar 2026 00:52:58 +0100
Message-ID: <3bc0cb18-f133-4cd8-a514-b4388e227286@gmx.net>
Date: Fri, 13 Mar 2026 00:52:58 +0100
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
 <98711825-cbf3-46ad-a26c-9f1d284480ac@gmx.net>
 <d622184a-36b2-4df6-bea2-7f5c6ba9b22a@gmail.com>
 <95d34233-e5d4-43fc-9478-b9b46510b01a@gmail.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>
In-Reply-To: <95d34233-e5d4-43fc-9478-b9b46510b01a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O9geA+ugUpLxfcFcZFWXO8K51XcPUc/IDr71oiT8m43KXMtfhf9
 pai7zTRZFjMxRK2uVPZ9DjSMJLIG+yW4B+EIyOQ+iigqFQ9NC6leGprpU/WkfSdVcrrAdKv
 K2C0RXjcuSECi9no/igx1NeCAI2X83/4WmOrA28GM4IokCzwrLK45wCvBPhWbG3l9y1aBPN
 D7bIMuYlVnofJvj8kdXJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KnqGLTo3IJY=;QScQtjY8/Pnc1QprPoa7/Z6crbx
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33170-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net]
X-Rspamd-Queue-Id: 667CC27B5B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Am 12.03.26 um 23:20 schrieb Bitterblue Smith:
> On 12/03/2026 19:06, Bitterblue Smith wrote:
>> On 12/03/2026 18:08, Georg M=C3=BCller wrote:
>>>
>>> Am 12.03.26 um 16:58 schrieb Bitterblue Smith:
>>>> On 12/03/2026 16:21, Georg M=C3=BCller wrote:
>>>>> Allow devices with this driver to be used as a wireless access point=
.
>>>>>
>>>>> I successfully tested this with a TP-Link TP-Link TL-WN725N adapter.
>>>>>
>>>>> Experiments two years ago failed, but some other improvements to the
>>>>> driver seemed to have resolved theses issues.
>>>>>
>>>>
>>>> The rate control code still doesn't handle more than one station.
>>>> It's not going to work right.
>>>>
>>>> It shouldn't be too complicated. The ra_info member of rtl8xxxu_priv
>>>> needs to become an array.
>>>
>>> Ok, I have only tested it with one client in my setup.
>>>
>>> So the ra_info array needs to of size max_macid_num?
>>> Dynamically allocated or hard-coded in struct rtl8xxxu_priv (8188e see=
ms
>>> to be the only user of struct rtl8xxxu_ra_info)?
>>>
>>
>> Yes. :)
>>
>> Also, if I remember correctly, there was a member of rtl8xxxu_ra_info
>> that needs to be moved to rtl8xxxu_priv, because it's a global thing,
>> not per macid.
>>
>=20
> Ah, we talked about it before:
> https://lore.kernel.org/linux-wireless/938ae608-a865-4056-06de-c230d74e1=
847@gmail.com/

Oh, yes, I didn't remember all the details from then and only checked an e=
arlier response.

I will try to integrate the suggestions into the RFC patch and will send a=
 v2.

