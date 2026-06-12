Return-Path: <linux-wireless+bounces-37755-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yRnuGrphLGrcQAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37755-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 21:44:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF567C245
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 21:44:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arndb.de header.s=fm3 header.b="ZGjGA/FN";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="D o3Bg+H";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37755-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37755-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arndb.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 019FB331141C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 19:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB48D37FF40;
	Fri, 12 Jun 2026 19:43:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549723806DD;
	Fri, 12 Jun 2026 19:43:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293416; cv=none; b=WqAutIFkIhrQcACgKpAqCfUTEEz/veOSo3dbEbShhj8ujYSfr8onbOTH7ZoDnwSGl5cBxuievzQy7MBmZeTVrPO+iRKjMo9Ttaozwx+oFhIxBMP04JMxSkTlMiwY+pu/7y+5t229H8GI9geN/eamsZ4vu5HABNdvBnDUP+pwXb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293416; c=relaxed/simple;
	bh=uuJb4tJweieSJqosV9WAO3JRB5smnehgUVL74wGSA6g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ITe6x7XzWMEycMqWs64kkMh5a2EC6hAVy3ZJIpDeAKArbGEE5dg2NeSOZZgpCWNejCDINhZVkyPU+brV7NdbEthi/WXcniQ/9SeOoZlIhS0LN7iF1N7VrUIRYpegRaNpEJ/sFc5IFnCv4UQIDhMy/jUOWS9fBtcNoQP3V6+KWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZGjGA/FN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Do3Bg+HH; arc=none smtp.client-ip=103.168.172.154
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 634811400080;
	Fri, 12 Jun 2026 15:43:34 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 12 Jun 2026 15:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781293414;
	 x=1781379814; bh=ScHxK0KjwcDjCF7wIFpDfscF/na+ZbrKo5E+v1XgI3Q=; b=
	ZGjGA/FNU+I271Pne8RdFpKjp55QCYbk0m/C5MJz1SBrzVAgXdwwRGeE8Ne2Wjg2
	8WknTpaLh8uq0nEHe64FJ/bsR5leVrgiy5O3M5QgnglCy4DPGMQ9j/bvnLyD46eh
	mFrPEPnIb8EmcMdPQiW9/t6+g+GrbT7eu4iQ0gjwiRMSEISujCcJvMKWMdBiBn54
	RSF4dRKkMAapi7zLrGR/FPag/3W1DkAMqo3XTS93JdMaRXoI5VGv6dTyeP0e8PmN
	nU4GfVV/VLIfFkIqE1sHG33Awnjf4beCiops4EPBcX/3LXwUBlwxSRCcULd2lDwo
	/00DYrl36GV8ZqsGFkymPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781293414; x=
	1781379814; bh=ScHxK0KjwcDjCF7wIFpDfscF/na+ZbrKo5E+v1XgI3Q=; b=D
	o3Bg+HHJnuac9ktNURT3WRam2ihewmNQxsiMm6c0HYB+4a2ZHOOWFRdi/8bL/P6v
	+unfUms/KCGQoOLimyglYpq+T3B22E8jhHuFNoYfrlnlwlZisf1TCSZgnDjFemqq
	ldlNtTS+7knuXWuEZoCXRw6vn6yeLKzPz9ALEQl6dCYpLljmYg0h0a0VEWqq0p16
	o2m+T0ydl+SwSt0qJyU9gM3Clk+irpwk4mDq+OnhicM405bjFM4ia/VeGNd3YyYG
	+15sDbslvMAJm8OWb57JdSTsUnGcnCmT+J7Nmlh86PL9h52sjQK23N1xlqi3DwnZ
	yxBF+FCeB3rFX5hndN7kQ==
X-ME-Sender: <xms:ZWEsaozEC-9WnkaD73NzstBFX80Jgz8jzet7FwnqLyaKbrftABv-jQ>
    <xme:ZWEsanFLN896QHPogvtjFIuuu4NghPDLLqxBWX8-oHPHjDBZQM87GaMR3aKy9Nqv8
    RY3R-wmusXm8neOk16ltZuh0MDeKM0j4R_lHNA61EmAORjZ5FA1YUs>
X-ME-Proxy-Cause: dmFkZTFZ7zD3Be8B30SaPbI6nkvYJJfGP2gTYuDGgUG73DODbZQp82HeUaNu/TitzBkHG1
    Bm6NVvqGTGV7y//ssMJjzYKMPiywgRQiaiT8BVVkQn6I7ky78pM7QStYJ7VpyHQ42GDCte
    HrZip5gfYkod+IeYjY/36Uvqp52bP350VDvjnLnC5e1DtyystUv7YtrSolpVWyTuPzZwyz
    wZdbors2yB7lsgP0OZaEFEFu7jrihO5UeH4fnwoSS9V8vXJF+GE7Jrf7GJ32aK99B1hOUt
    h0jhEawH7CZQDSD94l9OuB/sR+qwVzcUOcSgi9JUGI2CcEQTGimB7m4xrZImaf6If7A5qK
    pmBsoyOg3KQaqkCxtHxDuFU+qkYECpUUj0ODpdbVX1yXN777h5x0TkFhpYHyqEUOuuQUH3
    bUtNOzZfLUuKGArifAXitz4N9E2FgDahk1cDTk47x6cdL5IPcMbvJnDo3GntvAxF6rW/e8
    uocXx84MXuUy0i/tqXTX32XW6K/mYhiNTfwDqWiHrGKmhLV4uVssFRMn4XjzN/4LVlDkxM
    U4FtDaruULz9UCzR6Unhwp6ldDfaGAipl4EvrmHFa2kxzK+MZ0MXYmqlgl5ipWUtWcs+/p
    OlFDDWws2EM3w3L9KUBl30iVzdNa+XzF4xVQUY/PYOPBDlQiyx3d5ymCfMhw
X-ME-Proxy: <xmx:ZWEsatoCUK_FJIacnjEVzkR_R0GDHj2sahnI55ohaE8E8TMXyVmkXw>
    <xmx:ZWEsauKaA1RYhMzamZzOIRJQL1CwYEBqL7f1HpMPPuSlvIMIUxznow>
    <xmx:ZWEsals9JmXoCGYd6oKZZbyXtnng3SVc1bdWAzzPQg7PML0EzfjBpA>
    <xmx:ZWEsajB1x8jherg_MCaV56p44EdsSOJPrBDFRstaDB1hDwPGemRRKg>
    <xmx:ZmEsahLo9-hEGbgIc4j_NhjXsaiv9ZenPUEte2YzEurQHG3Z7w16WQ6j>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D82FB182007E; Fri, 12 Jun 2026 15:43:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXdheGxGYoOk
Date: Fri, 12 Jun 2026 21:43:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Arnd Bergmann" <arnd@kernel.org>, "Felix Fietkau" <nbd@nbd.name>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>,
 "Ryder Lee" <ryder.lee@mediatek.com>,
 "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: "Shayne Chen" <shayne.chen@mediatek.com>,
 "Sean Wang" <sean.wang@mediatek.com>, "Rex Lu" <rex.lu@mediatek.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Message-Id: <9370dc9b-a10f-4dda-8255-d59e9a8130ba@app.fastmail.com>
In-Reply-To: <20260611125912.3387021-1-arnd@kernel.org>
References: <20260611125912.3387021-1-arnd@kernel.org>
Subject: Re: [PATCH] wifi: mt76: fix airoha_npu dependency tracking
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nbd.name,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER(0.00)[arnd@arndb.de,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:arnd@kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:rex.lu@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37755-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,messagingengine.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arndb.de:dkim,arndb.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60EF567C245

On Thu, Jun 11, 2026, at 14:58, Arnd Bergmann wrote:
> 
>  config MT76_NPU
> -	bool
> -	depends on MT76_CORE
> +	tristate
> +	depends on NET_AIROHA_NPU=y || MT76=NET_AIROHA_NPU
> 

Further testing showed that there is a typo here, it should
be MT76_CORE instead of MT76.

I'll send a v2 patch.

      Arnd

