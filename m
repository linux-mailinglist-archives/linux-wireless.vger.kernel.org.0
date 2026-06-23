Return-Path: <linux-wireless+bounces-38014-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 63A2LlSVOmoFAwgAu9opvQ
	(envelope-from <linux-wireless+bounces-38014-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 16:16:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 583756B7CB0
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 16:16:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm3 header.b=fWYbk6fk;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="d 5wFqDm";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38014-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38014-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=shazbot.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80DA53095FD5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 14:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D7384CC8;
	Tue, 23 Jun 2026 14:15:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9598237D11F;
	Tue, 23 Jun 2026 14:15:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224132; cv=none; b=fjzNnqTL5zV1RydD4voKlnFS8fNqdfTQ6TSDUGxaX2/mlX2AGoGeGSv7ejKH8Ti08D0T1amzVPRI1xMRk7WDw6Wg9t7hO6wWTbdeyCV9D00pspX/dT4PzWzWQXV2w8yIyGeHpz8Bi3qCv7hdZ8XDmU1Hq2KAhLROfqrNPdr1y+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224132; c=relaxed/simple;
	bh=E9QkdfRNiqCNA23VrWWi12cR+wbZEAHm5lOxyji1qm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpcwlyhLKnB2bqpefcab8Y1tXBoIbxoTQgnvcxi+tWIWjVm73RgkEMKPXOqAVfgctQRt5bW5XteuvpxMDvMyer9pznD5noZGCdP4rJHI6kYXCMxHukIkoHFU17WgZFAoEp4RZgKVYwxQF/bvU1XgKS2JHNtfxw01e1JA9XeNI2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=fWYbk6fk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d5wFqDme; arc=none smtp.client-ip=202.12.124.147
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A1B8F1D0012B;
	Tue, 23 Jun 2026 10:15:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 23 Jun 2026 10:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782224129;
	 x=1782310529; bh=2/BP8S3K7EAUl7PQnFjVmpuzHDdXnjTm3NfjEHjajEM=; b=
	fWYbk6fkCNJC0bClPCw0ReBNdY4hN50DXQBD3DzXZQlrOQKgfkztR1qs6Z1B59lM
	mXq/zyIRZQrmHPdTdXkxYvjCvd20lyfjz2/V29HoOovlhp6A4DOzlzMdyapJtjhu
	5r1/IDqtzHbH+p/xPReg6U2FyANt6gLsceneZbidHLLxUiKNPks+heZBIsC2ddJx
	tj9TqzPSKgFxvaTeiO1Z7ZKj6GJcgk/YMtBaOH1GSWdsehZYWR+gxk8d31tcLAB7
	BwCF1YHE7yibxQGzSU/6HlSkZW5Yy79reIBWOfzzbrlAtJyaUb4sJTNCVIObJE/N
	e+ONpLAI6slz+TUEjkLKlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782224129; x=
	1782310529; bh=2/BP8S3K7EAUl7PQnFjVmpuzHDdXnjTm3NfjEHjajEM=; b=d
	5wFqDmeEoZULivheN107RbYoHR/AiayXFajvfWcvzOueC9a/OpQjUk33AW2s+wud
	S68bO7o76KRqu60FLYGAFtdjOekhCIvpbNUQvN9P2kFfK5dDKG+23b47W5uh1dKH
	NQtrv3gGm4PxEvVz0SKJCN8keHi+WTw60m2vGmCgsd20MXveWNhrP2eG2e0JJpPZ
	XGVL//Cu9WN6xLVC92JF3fWr5VKpTZvIRAukXIbhptKVayPGbg3JXMEopYBue/nI
	WM1DYcuU6FyRQ/yXXhEaoFRZfSpdJlp1xqwDKtu5YVEnOpGgJtsMu+R6PD5zHa2M
	mHTnAHikq1lmBSf7knMrQ==
X-ME-Sender: <xms:AZU6amHwTQM9Sk9JhzlIL57NdDglaID_OXxTc38efbiZpidyv0EEmQ>
    <xme:AZU6avdQkVDsxA6PTEivIkdxE6go6uZwehI57pW0EmO0xQPHgnuzLF5JuFpdrzzA5
    _HzYk5Ez-ESaJyJIB4X93m9w_dCFsRg1t8d1Dt4g1dgWU-8-xGFwg>
X-ME-Received: <xmr:AZU6avpw6ntrmuenZorUPiJQ5HFCLxO4Tkvhe2qmLGChLDJ4-SslPzrcciM>
X-ME-Proxy-Cause: dmFkZTEtltNPcCC7LyAuhl+F6mArHQnqSrrLTwwKExrXFThrGIeCpx+D/j+xo8RW9Aeb11
    IjCJP2gJR3JeMmMcXRHHc6ZvZ6CmsaWiTS/tZu5AS4X6umxRyVu9/omdNSNMa4zgDvnwCW
    LmHl7a3hynDEBCupmG8oHySMy/FUCpt/Tz2sFcrjvGVk/aUa11z+/lCkvOUcuHixlVVZ8r
    ZcUMBKg/CR0J6Y4jXqGMml/9io5G/QNccl03ob3/2wk0l+xsige7kSbMveB3jq78qV/YSC
    lJnh42RgTRJ5DEmJdAK32pyA+wRJ2tisV6YI/QxALvNOt4ynidfjUmsGnjE82cfrTiMFNm
    QJeWWpu8OaaduqTC9G4JqO+pr+PmThSgZweCJkdbqnABYAEWMbRu2s+UwgrQFNeHMyJ2B9
    TtA4yF7PCrI2OL1V0CL7ZfbZUXqCjsSZNGLaoymRlLmk7NVo9O1WvtzIq2P/JvK15//DRs
    W3XROktIIlBGsMFb0efJ/HdTNaO4NwV51gGtv6e0mz1cdFy8X1g7YT3RSR6WcqjMgEC8hQ
    W7x5QwP9IvMqVwnjnk5g+5R9tzgZO5hnaHgqIeXtPG/3Avjzug8HPYeIQ5BmM7hhjRMH3o
    tu+rJbr4GLksDf7NFO9DUBa2SyH+iniMKm8SY7vOr8lhc80w/GmFEPPVxlWA
X-ME-Proxy: <xmx:AZU6agA1NamTjmN3RGC8XCC_HfwZXZ8gcqBeavb-hNqv9gn5uUZvyA>
    <xmx:AZU6aoeyNTIhZh0SplNYIa4iGoTht0cruMnDxc7-vk10W11yGLgr8A>
    <xmx:AZU6agvtI6tevKqtZpX3n4nO5Sf6_Ql9XeImd-itP6SErmCHQOJDsw>
    <xmx:AZU6anjaUc7soy3hM31J9HPENUmjN0SAx6sWHgA8luzAM-jxLmRpPw>
    <xmx:AZU6ao6ItSUirKMV9MCX9Mu6m87XTdBBQkDexvO6oePbn2MnQCEz73lD>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 10:15:28 -0400 (EDT)
Date: Tue, 23 Jun 2026 08:15:26 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: mani@kernel.org, ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 bhelgaas@google.com, jjohnson@kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
 mhi@lists.linux.dev, alex@shazbot.org
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Message-ID: <20260623081526.1366a16a@shazbot.org>
In-Reply-To: <20260623125637.1188867-1-jtornosm@redhat.com>
References: <r4jeqtx247iosfjdps6g4fqwtsdzine5qlgh33sdt4p6ktmaln@o725aolrpj4l>
	<20260623125637.1188867-1-jtornosm@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38014-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@shazbot.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:mani@kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:bhelgaas@google.com,m:jjohnson@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:mhi@lists.linux.dev,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 583756B7CB0

On Tue, 23 Jun 2026 14:56:35 +0200
Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:

> Alex, Mani - would you prefer a dedicated VFIO PCI variant driver (similar
> to mlx5-vfio-pci) to ensure the reset logic only runs in VFIO scenarios, or
> is the quirks.c approach acceptable? I can implement either approach.

It should be a device specific reset in quirks.c.  Thanks,

Alex

