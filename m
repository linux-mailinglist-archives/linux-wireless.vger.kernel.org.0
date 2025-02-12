Return-Path: <linux-wireless+bounces-18861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36845A32CA8
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 18:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9DB3A26CD
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A85253B63;
	Wed, 12 Feb 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f7F4hpCd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86E221D8B;
	Wed, 12 Feb 2025 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379679; cv=none; b=TnVHawqQjs1gijptEqeLyowpwUsuwonWYrDemPh3a298fAGLX94Ge/4sj5y5lbdHMEgHuiNkMslsJ+f81xSs3Rl1ZuaDACKS1ztN73j2lplLwQzKiI30kWyNLEcv6CL6AggTuHt5XTjPxk2+bAz+fsWYnJZ86sUe3oIPr+qRgMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379679; c=relaxed/simple;
	bh=PNXX6obNWU7tUnUtVvYQStEQzBnCy0+YmkXrpfLfcQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnkjamsnQt5A2BltpQBc1PRfYz3EMoukuZWQrkq8y7/fGZFtBCphBnZ++ej05GJs1fxmb20e3l1S2JL0eQjWs0bXOv01vV22t6c8OKkkOaOYtj8qkaiE/yfOOfDdujGRUfTHkADNVrwrgq27ha2MMMuq17hjGztYx3L3ivff9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f7F4hpCd; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8880441BB;
	Wed, 12 Feb 2025 17:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739379672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+8tJdrJUUM2r3rGlZ87tl2Cw8IhsamzxMOaFlEPj2Y=;
	b=f7F4hpCdCR3z/FwoIu08EnVzGQ0zcm5AoyUNLuC30f4+TBNPiq8WyIpq85B1vQKH/a5Xuf
	Fjhp4ALHx/pNu2sNG4mKWmn2GEyxK9uyE/vwk4/i+0T+JkDnzXQdUu9bwC/EWH+lXssQ/e
	1mp0zcz1Rvx3noaAnvjJ0gmpsL2B2LAg127LkI8lQBuMDFvt8syI/kDxSCrkZSf4JOKpAw
	Ssuk13Roho2ghdOlELhoaaDvQtGONRC38PeY396QZGqvoA9Zi/WpFuZhYzk4WWROjAmSJ/
	2rcS7vXkRyb/wzK2rdI4RCps5R2rY5T43Zmz27JVh/urkh7J/yi7XOjX4x9UAg==
Message-ID: <a2702615-2946-4ca5-a33b-15da7026b58b@bootlin.com>
Date: Wed, 12 Feb 2025 18:01:10 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] bluetooth: hci_wilc: add wilc hci driver
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Marek Vasut <marex@denx.de>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
 <20250212-wilc3000_bt-v1-10-9609b784874e@bootlin.com>
 <CABBYNZJ5XDasAfVxcFU+K=ru2PpZJVXkRuf_kokv1z66KF=Xaw@mail.gmail.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <CABBYNZJ5XDasAfVxcFU+K=ru2PpZJVXkRuf_kokv1z66KF=Xaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdetteektdehudelheehkeeggfejgfelveevgeevtdejudfgveetgefhtdduuedtnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopeglkffrggeimedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhgtvghlsehhohhlthhmrghnnhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepk
 hhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrjhgrhidrkhgrthhhrghtsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheptghlrghuughiuhdrsggviihnvggrsehtuhigohhnrdguvghvpdhrtghpthhtohepkhhvrghloheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Luiz,
thanks for the prompt review !

On 2/12/25 17:14, Luiz Augusto von Dentz wrote:

[...]

>> +static int wilc_open(struct hci_uart *hu)
>> +{
>> +       struct wilc_data *wdata;
>> +
>> +       BT_DBG("hci_wilc: open");
> 
> Afaik you don't need to include the function name with the likes of
> pr_debug/BT_DBG, that said you should really be using bt_dev_dbg if
> you have hu->hdev set at this point, and this is valid for all other
> places where BT_DBG could be replaced with bt_dev_dbg.

I observe that BT_DBG does not bring any kind of prefix to the emitted log. But
indeed, bt_dev_dbg looks definitely better for my purpose, I'll update all those
logs with it.

>> +       wdata = kzalloc(sizeof(*wdata), GFP_KERNEL);
>> +       if (!wdata)
>> +               return -ENOMEM;
> 
> Add an empty after something like an if statement to make it clearer
> that it is not under the same scope.

True, that will be fixed.

[...]

> 
> Once you address these comments please fill free to add:
> 
> Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Thanks. I'll delay v2 for a few days to let other people review the series.

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

