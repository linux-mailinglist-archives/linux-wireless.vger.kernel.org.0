Return-Path: <linux-wireless+bounces-32079-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOqqJO5gm2kmywMAu9opvQ
	(envelope-from <linux-wireless+bounces-32079-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Feb 2026 21:02:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1A170438
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Feb 2026 21:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28082300A4C4
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Feb 2026 20:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9451D514E;
	Sun, 22 Feb 2026 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=animalcreek.com header.i=@animalcreek.com header.b="sp2ikvR/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NSQKd/sJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098EB2B9BA;
	Sun, 22 Feb 2026 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771790571; cv=none; b=AOPJP1XcmBr/9aohliikQi3aoka+h0Fta+c4MwU8RjDJp18iipd4rl5NVlc8uJWD7IDQbS/aflMhYLoZHrWpZ9lgyc5QXXdHMvDTIoAQAahYAa+tjAunYEHsA7vpwWxmwMyGl81drDQR7kMiHX8kwDbPhesAiGPvYfoimWLYxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771790571; c=relaxed/simple;
	bh=OP4O3q0tEgUsuEr5yc6i3Pk3OGco6JhTwWYBuWw8ZeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thUL5MMBSV5Ezh7ND5sI4OBz3DuaYerHCtnGR9DzQaP0fGqMzNvVwXJeDahMEFu2BIx33OwmtUm/0oNf3l8Pxn3dtkanbv1SDPOXaNeNd717CQmzgce7+/WwpYIkoyMQPynmoe205jW65ZZjpBoSJJwVzOjhc0cgeAS87WmL/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=animalcreek.com; spf=pass smtp.mailfrom=animalcreek.com; dkim=pass (2048-bit key) header.d=animalcreek.com header.i=@animalcreek.com header.b=sp2ikvR/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NSQKd/sJ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=animalcreek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=animalcreek.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FC377A004D;
	Sun, 22 Feb 2026 15:02:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 22 Feb 2026 15:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1771790567; x=1771876967; bh=iLfA9tYX3ZgFzd0/ew0lCDb5XE0nxrvr
	a7ORe8E4F0I=; b=sp2ikvR/wrlvxMw2Rg04UQBeovX12toH+bjpRyb0pTJIwrbU
	IOhGT/3fid+xVbtSzfpg8uVUB2mv+U6IH01qR8cifPea99MhsR1M8R6cLWHoeNHj
	UReMa4X3COK71OOekdw/0O0eYSCR2tqFVLhG7W3vhdDe7FAqqaBNjWSycMal8F38
	UCFIZ2i1nWRUNv59su2EUq+NLjF67ZFUH7YG/O3emOTa4DosPRRsCsbvbqdpaiBI
	vSNnkgbIE2+I3xUq6KISLtngNhY+KI8popxF3wowhNlSHPXfYXaTCHyQ5DszDtza
	DYgvYl2hQz3pq99+CUyXrU52yFPb51E8jkKkwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771790567; x=
	1771876967; bh=iLfA9tYX3ZgFzd0/ew0lCDb5XE0nxrvra7ORe8E4F0I=; b=N
	SQKd/sJdznCJrAvSWsG6YbBEHuROoMH6RFUGFaiZ20+Vz3vl4aAkYqwIOEvSap7W
	+A6/JPwAVwR0Z/hEzlPoAbdLpRtMJX6DPOcutYWYix2jTPosxndqamobFuTMX/IQ
	skEU0Z7c3X+BAMCQ3UbRVrA/0MgtKEUobE2GO5yx85g3XUf/9PsNh5Ph/OiqzTee
	Cfr1hI3mM6dGfb2V69qJOJGRPc/bX/pBrFWyAX4gN6GPgfWZsLzCPx8XdkJ0JLZw
	OygsKqXg8+2ScdQQMhHaERSsP8ZLVecqly5LE8JhX3+JrCVzF7eK8jVo8FaeBQXH
	aF1TfdUssixzRUNJgZWGQ==
X-ME-Sender: <xms:52CbaSXmiUO-WUZxbWcJBuBaZ0m56xHY9RABhhvFSBeEC9eI-uQbvw>
    <xme:52CbaXiVlOoz34fgPNZzEV4V_mY-HZYV8hXiFupcGnePoS1ulaRKuUwYc_Mw3z4ul
    gBMqi4IMA097PITJmeOpDHxFJGCMN1B1rrTvMl-od_l5upkarISSA>
X-ME-Received: <xmr:52CbaR-8ZpCD6cZ8eNioLyZKpJdBbvnc82rl67A-f6DrqGXT6z-xThQ8NYysZntPg7q2C-zA3YEZ6qPYBVBWgaOAyXop>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhohgjtgfgsehtje
    ertddtvdejnecuhfhrohhmpeforghrkhcuifhrvggvrhcuoehmghhrvggvrhesrghnihhm
    rghltghrvggvkhdrtghomheqnecuggftrfgrthhtvghrnhephfduteehueffkeelfeefke
    efjeeuffdtuedvffeftdettdfhleduvddutdefheeinecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhhgrhgvvghrsegrnhhimhgrlhgtrhgvvg
    hkrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhmrghsiidruhhnghgvrheshigrhhhoohdrphhlpdhrtghpthhtoheplhhinh
    hugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhgrhgv
    vghrsegrnhhimhgrlhgtrhgvvghkrdgtohhm
X-ME-Proxy: <xmx:52CbaZY0xw7DMS0Cw5MKQlM6_XB7PUvgwLfwgV2NeaKd15hiwW3jqQ>
    <xmx:52CbaY2CGxszxHsyF2Se7t3zMFvQp_lnwBJG-PjV9aSJNaTYbrsJxg>
    <xmx:52Cbacaz6sXeE2ANtP093_-dKeL-LjEgNaITbxOIhQreQ5OzS__QAQ>
    <xmx:52CbaYI-cPfDeHKCBJSV269JPkVme0DwOmVpYIfKQ3BWNhbD3QTpdw>
    <xmx:52CbaQuvwCW4nc-UV3VtD1M9kfExyx8yDjkqOv2HjRrpspzNWWBa9YyX>
Feedback-ID: i9cc843c7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 15:02:46 -0500 (EST)
Message-ID: <386f2ceb-30ae-4acf-9a62-287412fc5c79@animalcreek.com>
Date: Sun, 22 Feb 2026 13:02:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: trf7970a: Fix spelling mistakes in comments
To: tomasz.unger@yahoo.pl
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260219112454.46841-1-tomasz.unger.ref@yahoo.pl>
 <20260219112454.46841-1-tomasz.unger@yahoo.pl>
Content-Language: en-US
From: Mark Greer <mgreer@animalcreek.com>
Organization: Animal Creek Technologies, Inc.
In-Reply-To: <20260219112454.46841-1-tomasz.unger@yahoo.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[animalcreek.com:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[animalcreek.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32079-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.pl];
	DKIM_TRACE(0.00)[animalcreek.com:+,messagingengine.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgreer@animalcreek.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[animalcreek.com:mid,animalcreek.com:dkim,animalcreek.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2B1A170438
X-Rspamd-Action: no action

On 2/19/26 4:24 AM, tomasz.unger@yahoo.pl wrote:
> From: Tomasz Unger <tomasz.unger@yahoo.pl>
>
> Fix spelling mistakes in comment block (lines 64, 69, 72):
> - 'recieves' -> 'receives'
> - 'recieving' -> 'receiving'
> - 'recived' -> 'received'
>
> Found by manual inspection.
>
> Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
> ---
>   drivers/nfc/trf7970a.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
> index d17c701c7888..c3bf48f49eca 100644
> --- a/drivers/nfc/trf7970a.c
> +++ b/drivers/nfc/trf7970a.c
> @@ -61,15 +61,15 @@
>    * support that.  So, if an abort is received before trf7970a_send_cmd()
>    * has sent the command to the tag, it simply returns -ECANCELED.  If the
>    * command has already been sent to the tag, then the driver continues
> - * normally and recieves the response data (or error) but just before
> + * normally and receives the response data (or error) but just before
>    * sending the data upstream, it frees the rx_skb and sends -ECANCELED
>    * upstream instead.  If the command failed, that error will be sent
>    * upstream.
>    *
> - * When recieving data from a tag and the interrupt status register has
> + * When receiving data from a tag and the interrupt status register has
>    * only the SRX bit set, it means that all of the data has been received
>    * (once what's in the fifo has been read).  However, depending on timing
> - * an interrupt status with only the SRX bit set may not be recived.  In
> + * an interrupt status with only the SRX bit set may not be received.  In
>    * those cases, the timeout mechanism is used to wait 20 ms in case more
>    * data arrives.  After 20 ms, it is assumed that all of the data has been
>    * received and the accumulated rx data is sent upstream.  The


Wow... and I actually know how to spell receive. if you can believe that.


Acked-by: Mark Greer <mgreer@animalcreek.com>


