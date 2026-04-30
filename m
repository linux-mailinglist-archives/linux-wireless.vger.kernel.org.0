Return-Path: <linux-wireless+bounces-35704-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DDKNF4p82lsxwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35704-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 12:05:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF774A077B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 12:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 617B23028116
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3607D3AEF27;
	Thu, 30 Apr 2026 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ei3OTv4y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f+dO5OsK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2AB3A5451;
	Thu, 30 Apr 2026 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543114; cv=none; b=uC9G8253qv5yLBE/Nz4FjrvXZ8djwzM3pTcLWA1YSqpx82E18me3HtQAb1LVD3vmQ6fFqxWzBdOOoiK2WL46uCtgHn9ybR5mZTAaOPn0tD1MesHkHP5WLT35A6QvG8UUkXD80nFgFEgxUQsTPduOR80ts8sUJ4uTKyaNEtMbqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543114; c=relaxed/simple;
	bh=uwbYKYPPdd/Z1s24vYMWqvTSRXHHdWm2fojXFGd2N1I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GqmCT+/8wV5/ncfFrkHF6yMX7ABoZLbpFLhtI+mtk9iCzZSVwWUURv7c86Upj+7gS76tcJ7+XdFxY6t+py4ipNv3j7ddTxbBcvucdIcvzN7tJRRcycs/qQYFBoiPV8ATG9ilkF1n1QdY3kkdnwn69bhfA53taFwrHOPWneinXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Ei3OTv4y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f+dO5OsK; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 1F9B61300024;
	Thu, 30 Apr 2026 05:58:30 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Apr 2026 05:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777543109;
	 x=1777550309; bh=2GZRcmUnBgFU/NnSUNvF0yJ6OQh07+XuyeXMMfMjdpw=; b=
	Ei3OTv4yPMbRmJibf59VFwjx/txeLxhoz1vkiRSeiuQdFzP60yCwic1wXfQ1ypwa
	MkMu9W2lRCwTXuI+l9H+yh6t6UfIHRRx2kAvxwofEA9gqlulztPdPxIboAjNKxwf
	OIlIPutFxrv45KYJSmx9OyELKDIEAt8q11lUs5Noyl9rU5jcTKnz3gk3zHLuGl+h
	NtX0iICmZYs46wBbWskSZ1o14QwCjcQ7Y1b3J0DjGXrsMV0HL1jWsiWykcmY6teT
	Gjas5Xh01RYTEIO5hWnd1XtdkTy/z4GCt5kyuqF61epboJrDqzRRhNSKO27FQyKe
	BiVRk1sBHjWsFiFb79L0xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777543109; x=
	1777550309; bh=2GZRcmUnBgFU/NnSUNvF0yJ6OQh07+XuyeXMMfMjdpw=; b=f
	+dO5OsKQEP+z4dIuEky0DobJ4pu+ixgoYFPzObV+1t65xswx+yk/6884x9NPu37W
	FR1rNA4sHgWb65DYcaeTlP1wPwinHwVb/8eCe58+Mxtp45sv/5ArZsbDiaN/JdOU
	ixBvGHOi1bXWAPKqdvumj+6LGfz8Sr3sV4R/vA2x2FbMRvBi6IdX9KEQPTfPKD6G
	tJB8Dc33Teu/0ekw4WoyIkp5PsaZvy7Ma/X+XeXKNb74ZMW9cmutATamYAR/vPAr
	gSomBT2TxyIs8mJ4kl9z75pxpWsumMnn/gK7VTANqjY+kfwl8HoGwOJ4TNRdQ3uB
	HjOs+2I98kYtBCbmnwawA==
X-ME-Sender: <xms:xSfzaRsKVlg-ScY42aRobmDN45st5Yh6tt82I_2nrYdLqqesPCLR0w>
    <xme:xSfzaVRjKYABycFlKXsHs5n9HtHcLmIxyKCGIBiHXpQCmzmUqd9gUKVjl9FYtnzoz
    eWJJDRb4PCpyOQdcM6DfPE1oSBIzd6p3FESjRSLtwwlDTxTIIJ744E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekjedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeeutdekkeeftdehleekieejvedtkeelvdevteeugeejlefhhfehiefggedtvdduieen
    ucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgs
    pghrtghpthhtohepvdejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhnhi
    esrghtohhmihguvgdrtghomhdprhgtphhtthhopegstghouhhsshhonhessggrhihlihgs
    rhgvrdgtohhmpdhrtghpthhtohepkhhhihhlmhgrnhessggrhihlihgsrhgvrdgtohhmpd
    hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegt
    hhhunhhkvggvhiesghhmrghilhdrtghomhdprhgtphhtthhopegumhhithhrhidrthhorh
    hokhhhohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopegrrghrohdrkhhoshhkihhnvghnsehikhhirdhfih
    dprhgtphhtthhopegrnhgurhgvrghssehkvghmnhgruggvrdhinhhfoh
X-ME-Proxy: <xmx:xSfzaTqz2TAqWBJNhUetmWcAQzThHEWytbSBu19pUreFLJpG8D_ifQ>
    <xmx:xSfzaW114DhQkU7PsC_pDzf0NnfqA_rV3BUeA383pB1vx6bThO5C9w>
    <xmx:xSfzaaXOO6WiQjxnFZ0qTKACe6PlmvZcmZoS_VD5fJtxQrEjlV4AmA>
    <xmx:xSfzaXyNXunqCtskmYElQtsXbGmJjI8cN5ZUoEABr6gmV3ZRd9EQIQ>
    <xmx:xSfzaVodQF4K2tXT2Oxfv5o8TlVySilTpseCUTQ8a7plToUY_s5B80Tb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4C14A700065; Thu, 30 Apr 2026 05:58:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A3XgsrJ_aa9s
Date: Thu, 30 Apr 2026 11:58:09 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rob Herring" <robh@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Christian Lamparter" <chunkeey@gmail.com>,
 "Andreas Kemnade" <andreas@kemnade.info>,
 =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 "Eric Dumazet" <edumazet@google.com>,
 "Bartosz Golaszewski" <brgl@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Jakub Kicinski" <kuba@kernel.org>,
 "Kevin Hilman" <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>,
 "Felipe Balbi" <balbi@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, devicetree@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Roger Quadros" <rogerq@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Tony Lindgren" <tony@atomide.com>, "Linus Walleij" <linusw@kernel.org>
Message-Id: <f7e0f283-a640-4017-824d-2efdf5543470@app.fastmail.com>
In-Reply-To: <177754112702.3678889.4847926893667561974.robh@kernel.org>
References: <20260430081242.3686993-1-arnd@kernel.org>
 <20260430081242.3686993-2-arnd@kernel.org>
 <177754112702.3678889.4847926893667561974.robh@kernel.org>
Subject: Re: [PATCH v4 1/3 net-next] dt-bindings: net: add st,stlc4560/p54spi binding
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6FF774A077B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-35704-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[gmail.com,kemnade.info,baylibre.com,google.com,kernel.org,sipsolutions.net,vger.kernel.org,redhat.com,davemloft.net,lists.infradead.org,iki.fi,atomide.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devicetree.org:url]

On Thu, Apr 30, 2026, at 11:25, Rob Herring (Arm) wrote:
> On Thu, 30 Apr 2026 10:12:40 +0200, Arnd Bergmann wrote:
>>  .../bindings/net/wireless/st,stlc4560.yaml    | 61 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 62 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml
>> 
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> $id: Cannot determine base path from $id, relative path/filename 
> doesn't match actual path or filename
>  	 $id: http://devicetree.org/schemas/net/wireless/st,stlc45xx.yaml
>  	file: 

Thanks for the report, I've fixed it now for v5, to adjust for the
renamed file.

      Arnd

