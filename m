Return-Path: <linux-wireless+bounces-37601-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VWq7OhpKKGqmBgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37601-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 19:15:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA843662D18
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 19:15:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm3 header.b=ZxnRPF2L;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="K 1jznXH";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37601-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37601-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=shazbot.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 061E83110A73
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 16:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFAB47ECD3;
	Tue,  9 Jun 2026 16:44:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE8481AAD;
	Tue,  9 Jun 2026 16:44:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023468; cv=none; b=t7kBfG3qjyCVf9u2El/gloExV9EPHTJgAmcPMJyKdkerABknH4J9iE7i/W007Y6SI6cdPMInYDyRNTMCWxlfXmjCpzerbDZLuZ/QcGNTHtViylFVulK5ESIMNNPa9l0KkLLJjTyf0XH1oO6sLNQ1VB1Fm7xAOw6jMRqYcW/xqJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023468; c=relaxed/simple;
	bh=I6CesmfoIlfOdot1WU2Sgz7jy9kVlptUq6uVqJoEokE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piblot62XRlARWhBYOYNXxdmiUFZlXgDM3r0cf9Lp7YCNjS5sGQ6EYKIbbIWdxpBUHtK6wlYN8LteN6bkLuCqMdOZND7b1Q0fZX+kyHCKQX7cdYS9g4OdxvfmJYg4hsraPLwRwsVcGL8Ty3KH2fFEZ5CgWF7rKqmQi5eI9xWnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ZxnRPF2L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K1jznXHS; arc=none smtp.client-ip=103.168.172.144
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CC922EC0112;
	Tue,  9 Jun 2026 12:44:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 09 Jun 2026 12:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781023464;
	 x=1781109864; bh=ZvpGOg0McmFFQ0JmTAfnzIXcmaEu3YPVXxWgHR7A9Ks=; b=
	ZxnRPF2L17v/Dqu7N++8AdvVHdCSK1wdxl9F4d8xRO++wcMOMuDO0XXKYxtjuRXn
	5tpeZHvhuH123wT4BUCOaxOXq4NOCIzr6ol4te1AUHT/dzObm3+eykp4cMOzkdLs
	qflJGDc3CueMJzNVl2FPzG8Ri45V36qs1fJoi+gLVaoYjGY80VC6ZLqt8JUsJfaC
	X7Wyx8SnQ3CEQ1aoWr5c4jQkABw3pM+W+bX8npn6sQ9id+gw1BTJIT1Mh0Fos6bc
	eZin1NM9cuiSEzXg03fTIkbMlL+cHB/97hXBnprriWn02IVu5INCYg2jfqVYsm0f
	8xwq31c6H7D4xenVJMsuQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781023464; x=
	1781109864; bh=ZvpGOg0McmFFQ0JmTAfnzIXcmaEu3YPVXxWgHR7A9Ks=; b=K
	1jznXHShtA5II0txNCpN51TNboW05+Iq2er7ALudNxujAJrr42fx8vKhRgzvj2ru
	rygw7iSl1znk0O9oPMjtP97OeaRGB+sa/A0YPftuCamnVOpgnVVRP7Ff0H2IWZre
	rZfJHWSa9i+BGXpuodPLBDQqmh7t2y/JBk/EDsKyhVrxUnXhXor+6CfnZc/CfjxY
	vdGuKx0OmsepCHML4vBJmYmPqULS2YDXoNo/w5YXEArEpHdiGssiZ8ScLGD1IVb0
	fAjU9sr5+/R62C/FNRuj3hINDkaNQxIEmDFNrWm4hdTVZNWhcjl4YWBTNtoW5hF+
	TrWSvYXhWm/6CyFl84YWQ==
X-ME-Sender: <xms:6EIoakWSzzaKgrD0czDWoDBPH-U1Q5o0U-SpmzDiOukxpClMHe4WDw>
    <xme:6EIoanxgMlHiHI496wBJZDKaOPVGJVs2OwpmPs80gxj4qUCaiw6iI8KzeM72kLxcg
    ZfDyAT8ycySiRyO5rWzL6Vlh0vCWac-PiGLB-DXPxEJ6VnqvVKRIA>
X-ME-Received: <xmr:6EIoarHnowyCZ3wvlfZyVV-7BAP3J9apY9hDOqKxltKOCGKUyoog-0SHr-g>
X-ME-Proxy-Cause: dmFkZTGknTG+NctqFLBA1TpgQfMpv0S7zWjXCtRugjLVg39zSEs5ow92+YqXpIC4OvYOJx
    lA27PNvLOzkb92cL9V4gUoy5SIrj5uIZg1fEBX91/++cdnzfOnrCS9STL8qCbVksB1cPJn
    JzxPCVH27I7O5MbzARzArrub8la5CVxNts2uVvPxtwIfg1L7HHajiPaN3pzbEusZ2a0lqR
    2BKiYqg42mwwReIuv3BCfwTUYK/h407l6BW1j7itXLTUDNJ8eRtsMIMxCl2oovM+i2N6A9
    CVrM/92xI4N1ZVhaXHMR4+CuwwVQBYeYbzDHIqciVHHB/TjTFoLdxacQTvD47tjrBlcKmX
    brmje2APsyFdBULj/i15mj3w0PvNU86TjOwtbxQiG4rUHouiWVGkMkv4UXdJE6kf7PFJ7u
    4Ozq39yp0TaaVhSJasPUyL68wJkA2XJvVtME90tl2DIsMbjysMQp10iM9NLWpl2+KW63uv
    oJgmI3ds77KpQptXJ1hKsJ2G8zxNCUNIJGDWAIDGwOGxcAZp7ZecozlE1iMo4uubtMARU0
    ztP0TEoZPaXidEm/IaqhMTeUv3ndeQCd9zMqomumLmplD7cjSZWs9Pyl1YDYLqfXpM+OLs
    fEI0jvndXsp+BzMl+2i8exbhyUye8AjuSfbNhXmxlr4nhKMJurJ3uG26N7Hw
X-ME-Proxy: <xmx:6EIoasvlb4FUCWG2Mpd3RDssxOCVNYhep8S6pqqKe9BVTtFhuFgOMA>
    <xmx:6EIoarB267h9_vS1Y-0V0jWor0RMDbFN29FLdAd0enCmlN9AHYy6CA>
    <xmx:6EIoanA_rpnqdy-8rbUBxPyZt5uoSMKUAkw1yyyY0_3TXln8a4dP5Q>
    <xmx:6EIoalp0bsLYIid6VkPswu0p0zTi-sGRrUv7IPuFdBXiXSniPaqicg>
    <xmx:6EIoaieEz5NyEBtshnWmimh7TqAP0Rlgy4qmRiogVtbWSvkMnGa2mB9d>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 12:44:23 -0400 (EDT)
Date: Tue, 9 Jun 2026 10:44:22 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: helgaas@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
 lorenzo@kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
 shayne.chen@mediatek.com, alex@shazbot.org
Subject: Re: [PATCH v4] PCI: Disable broken FLR on MediaTek MT7925
Message-ID: <20260609104422.19c9580d@shazbot.org>
In-Reply-To: <20260609153333.70991-1-jtornosm@redhat.com>
References: <20260609144532.GA104629@bhelgaas>
	<20260609153333.70991-1-jtornosm@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37601-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@shazbot.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:helgaas@kernel.org,m:bhelgaas@google.com,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:lorenzo@kernel.org,m:nbd@nbd.name,m:sean.wang@mediatek.com,m:shayne.chen@mediatek.com,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,shazbot.org:dkim,shazbot.org:mid,shazbot.org:from_mime,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA843662D18

On Tue,  9 Jun 2026 17:33:33 +0200
Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:

> Hello Bjorn,
> 
> 
> > Alex, are you OK with this?  The v2 conversation talks about SBR also
> > being broken, but maybe that turned out to be a red herring?
> > 
> >  https://lore.kernel.org/linux-pci/20260508145153.717641-1-jtornosm@redhat.com/t/#u  
> Alex can answer better, but to clarify: SBR works correctly for MT7925e.
> The confusion in v2 was because I initially grouped MT7925e together with
> Qualcomm devices (WCN6855, WCN7850, SDX modems) to try to fix their reset
> issues. Alex suggested testing SBR for all of them, which revealed they
> have different issues:
> - MT7925e: FLR advertised but broken, SBR works fine (this patch - quirk_no_flr)
> - Qualcomm devices: No FLR capability, SBR is broken (separate series with
>   quirk_no_bus_reset + device-specific reset)
> So I split them into separate patches since the root causes are different.
> This fix for MT7925e (quirk_no_flr) removes the broken FLR and allows the
> working SBR to be used.

Yes, this patch follows our standard practice of quirking out known
broken reset mechanisms and the qcom devices are now handled in a
different series.  I'm ok with this.  Thanks,

Alex

