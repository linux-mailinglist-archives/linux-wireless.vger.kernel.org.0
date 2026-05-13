Return-Path: <linux-wireless+bounces-36381-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCZsIolVBGqMHAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36381-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 12:42:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DB65317BA
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 12:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4949300721D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2981D39183C;
	Wed, 13 May 2026 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DwY7ezTx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6851F3DD871;
	Wed, 13 May 2026 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668931; cv=none; b=PS2jMY9SN650vw0LGJB3hUdz9Q5ylQ0Xx5CJj5qrbBdRKzLowKmMMo/5YMEbMAZZwu9O7x06U7371ERSHwSC1Do2et6sDqjOOTa6NcbdxoE5c2+eKQVT4XijeA9W8xyW92nB9kI4QykWTYuuYdYEJfnaIbRtSbxnKEiYrM1RHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668931; c=relaxed/simple;
	bh=HJvcMyjUHedTVyjr2bKimpLClLU9U9qRfh6sOKiz8Dg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WL8/6BvzMuiFNd4utJbgGC10TfEu3W568UxtNjQSVSGUV5/RE6e21DhYhLC6UBi+czozwslDwzjFJMLVXHYtkSVu3Gvpmdr7H9KVyI2sErvOnbVAicE5wVJpLI5XSfzezVzmSxlp4QTekqJjkUpHlUhaCDHSY8MxMDVtbOyb7Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DwY7ezTx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HJvcMyjUHedTVyjr2bKimpLClLU9U9qRfh6sOKiz8Dg=;
	t=1778668928; x=1779878528; b=DwY7ezTxBZjwqmRdj5PAsAFCPanGoHMxHEayXr3bA1zVqTY
	009tNP6rsdR4gd6z5Su3oGllTbC17R+qY57zrtXw8Hft9NTt7e93wnlY734XLANn1yJDT32eWl/+X
	va2BsuFTROzye7CWBJayQHoruOIwbIisX1b8eHI5OGj94dr+DZDHUM561gttfkc952x7+5LavVRet
	qGx5andJAQljGdrbqRZ7MqQkTfIZH2CnUta8gs4WTgSevVaVrcf6mu1kkm8GgTrSdZ8QtZt7BWYEw
	8IVrhYdozF+2gsUqkUnQ7orSPYz2RngZSeTh0ogxY+oNP1VoeBiXeiJcq3RJRG6Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wN72M-00000003jjn-2KEZ;
	Wed, 13 May 2026 12:41:58 +0200
Message-ID: <34084815328ea9ea00893e9aa46962d369d213e3.camel@sipsolutions.net>
Subject: Re: [REGRESSION] iwlwifi 8265 firmware ADVANCED_SYSASSERT in
 PHY_CONTEXT_CMD on roam (v7.0.3..v7.0.5)
From: Johannes Berg <johannes@sipsolutions.net>
To: Branislav Klocok <branislav.klocok@ofz.sk>, regressions@lists.linux.dev
Cc: linux-wireless@vger.kernel.org
Date: Wed, 13 May 2026 12:41:57 +0200
In-Reply-To: <d2ffd82d-01cb-470e-bb02-70c163c61216@ofz.sk>
References: <d2ffd82d-01cb-470e-bb02-70c163c61216@ofz.sk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: 91DB65317BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36381-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 2026-05-13 at 12:35 +0200, Branislav Klocok wrote:
> =C2=A0#regzbot introduced: v7.0.3..v7.0.5

That cannot be right, there are no patches for wifi between those except
a handful in drivers you're not running.

johannes

