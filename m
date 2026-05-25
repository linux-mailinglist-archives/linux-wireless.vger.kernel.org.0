Return-Path: <linux-wireless+bounces-36867-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOkqMqwLFGr6JAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36867-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:43:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E59005C7F1C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 000603004D3F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDBD3563FB;
	Mon, 25 May 2026 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gservera.com header.i=guillem@gservera.com header.b="WrvuWFiV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F023C368
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698547; cv=pass; b=XEOBHVoImOEOc5h0h1n9lAggveDfnV107BIfMXllm6FUFloX91/sGyXoxeCHDzQ5c0x0bBy82NbHzK5zl84s+r8uN7DmqxTjzDRho+Os0u3i9AEc92YpHJ/2deZHmo5qNW6k5REPwAWZAxPTcJ6mzHXQEyvtbON1xg+ImvWBijY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698547; c=relaxed/simple;
	bh=jQUyUzSd7vW65V6KI7R5n2feN17mEZl9HAfM1kmtRfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MkOrHOQnQQXrO/8G8cZjwXlGA+FwFX/MPelLx5F/02ET1js50ahyL9dZB4oZOkVrnEIkx9QpZeXaHEfhYi0tL1xTfXWlVTzAiernQNWhHE+YWufrWCIB6xRnac6F0XmJsGcnKfUgW9nrC5Wq37RaQN11jgygkPbdzuRiOXJqdU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gservera.com; spf=pass smtp.mailfrom=gservera.com; dkim=pass (1024-bit key) header.d=gservera.com header.i=guillem@gservera.com header.b=WrvuWFiV; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gservera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gservera.com
ARC-Seal: i=1; a=rsa-sha256; t=1779698544; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ho1lqMRO7m8+8fGE0i7PBE6Hv1Z9r/aDL60a0vYTq7zrTmzyPDK12FtdZyDNj51QpHSrI8JH83Yv4TXj6Rd5mmko9oIM+KgwJus7ysqO51mblM3rgjpdT4CrrElF+QGmAInW2v7PcrfMYn7wIvsMSfcnr8nfH6Hwn9sA4H5SAK0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779698544; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=VYuW3NA9BSUYo8x5yRk0LG7Y2Tl0I+eAPReFyA52F94=; 
	b=HdTa6nVrA7wPW+grWHCf+5bpmvFqqLLAshkjMWjlHMLnDuzp7tygWewgx8kZkPVZ3e+6O4Xf1xhSwqE72W8Nr1Y4CbLU6XIhwT9uUwrDxa0vFuR4n3oB3VCcJlL6GYy31kdBTZtMDJbwvzsnLUqbGSfM2Ct8z2lan2XZCYU0chs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=gservera.com;
	spf=pass  smtp.mailfrom=guillem@gservera.com;
	dmarc=pass header.from=<guillem@gservera.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779698544;
	s=mailguard; d=gservera.com; i=guillem@gservera.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=VYuW3NA9BSUYo8x5yRk0LG7Y2Tl0I+eAPReFyA52F94=;
	b=WrvuWFiVutMalogjSoi5hiIx3oB85USUDkfRFb5oP+TzlhNVffppaf2lwzBD6LTd
	AhBFAA8Dcr2rQM6ff8xGwlIJapUIMmvTrtsGkEIhwyK8iShvbOKB5TpU4nwRtDAarSK
	o9+AWoGeYsh8sIE/0psdN5UZY/iS3DwTUGHg+SjA=
Received: by mx.zohomail.com with SMTPS id 1779698540938929.2853211609802;
	Mon, 25 May 2026 01:42:20 -0700 (PDT)
Message-ID: <a6d81f53-492d-40bb-a4df-3d35acc3997a@gservera.com>
Date: Mon, 25 May 2026 10:42:17 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: rtw89: 8851bu: add Mercusys MA60XNB (2c4e:0128)
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <418D5F85-B110-4CD2-B733-FEA8D4901EBB@gservera.com>
 <c6af176e57de41b8bcfd4868a6057e00@realtek.com>
Content-Language: en-US
From: Guillem Servera Negre <guillem@gservera.com>
In-Reply-To: <c6af176e57de41b8bcfd4868a6057e00@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gservera.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gservera.com:s=mailguard];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36867-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guillem@gservera.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gservera.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gservera.com:email,gservera.com:mid,gservera.com:dkim]
X-Rspamd-Queue-Id: E59005C7F1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Yes, that's correct. The adapter works with this ID after compiling and 
probing your patch.

Tested-by: Guillermo Servera Negre <guillem@gservera.com>

Thanks for the quick patch!

Guillem

El 25/5/26 a las 3:19, Ping-Ke Shih escribió:
> Guillermo Servera Negre <guillem@gservera.com> wrote:
>>   { USB_DEVICE_AND_INTERFACE_INFO(0x2C4E, 0x0128, 0xff, 0xff, 0xff), .driver_info =
>> (kernel_ulong_t)&rtw89_8851bu_info },
> I made a format patch [1] by this ID. Please check if it is expected.
>
> [1] https://lore.kernel.org/linux-wireless/20260525011728.6836-1-pkshih@realtek.com/T/#u
>

