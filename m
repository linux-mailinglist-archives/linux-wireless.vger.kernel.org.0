Return-Path: <linux-wireless+bounces-30169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCEBCE8A27
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 04:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 191123000B4C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 03:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003441DE4E0;
	Tue, 30 Dec 2025 03:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="FDfDnu9j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sO9lmVs0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17C26159E
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 03:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767064704; cv=none; b=HHlVYARyIWTcPHItsbCPA2Bass14JkvRmaei8SogRQRLh3mYDNwXC9i+U5Cn6ajvaUOAjisSX+hw8d4q38ESK+nwIkjtu2eE8s1k/b+iivkIjq2zLTlPQBnXBuMdldYQJ7vd02d6ZfNCocBFkBN1K0Yf+tESxfOEHLE8FldaHDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767064704; c=relaxed/simple;
	bh=HTrsBMYTG1LOL9snVcsnxxfhp9MIDLZpPVYhCzskHNY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=c0RgQGqDlWO9mT4lbx+gfWUILf+vZW7jcoF0eJYvYgDrREsWwMXkb8uegMSgnFDBLqIOeaDztDl3JnMaSxJClVFbuifwSbFCyQhpqGvVDlPvg2SYR8WWMwqFre7SCGPz0HyNkQXS38WhF47dv7Q2Gg8CANdV5Y+I5QDaTXPZ3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=FDfDnu9j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sO9lmVs0; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF9EC1400151;
	Mon, 29 Dec 2025 22:18:21 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Mon, 29 Dec 2025 22:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1767064701;
	 x=1767151101; bh=BR1YrefQR5kgHzYShT/CgpB0E+LBEbnjiCncyOZA47M=; b=
	FDfDnu9jTO3X2brkk8lhF3Id/I6QvwQyZNXyhPISm5QyD0UpRI7ThNO/lk2fvsSb
	m3infpJECQxrmgB0rCdCq0evzbxipla5m81zOBtkVndOqJBpk4FO4S5L/xg3znav
	qWeBoDiReUjNalaYvszbuuC+9NISUHB4oR+V+h6Ajblf7DnMdGa99CWzfmkzBISe
	VlWsNslQp6ZCcf+ru7XkM2O8sdPYUZWw8dRkYvO9lhJjz7sieoWcqp6rq4yYHWKF
	MzpALqCi83H/UYyGoJaAbQBdH7rX/TbJb0i9HButgY3ObfgLZNcipfbzhiib/VCG
	ejpJ2LEBRJ6xpZoRC8vKUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767064701; x=
	1767151101; bh=BR1YrefQR5kgHzYShT/CgpB0E+LBEbnjiCncyOZA47M=; b=s
	O9lmVs0vfk9TxwTzUNP7/sTYZJGJJ4pHS8cKAe+V0e9NMLcOoyIkQ85l9QNWIDN+
	PoWlUrSDdfFdbn11+bR7SEpOgeceHAFYd0awJWpOz9pUhhdkZxy8UaSYtw6awZKK
	QkbX8MBM6QffawYJgkVxoQ9tl2FeTnk5Bzrd34B67rv8Borb/zXmiauUPCA/J9z4
	FEQ4MqNbrHZ9fUyUQugZ7OIphLmBkdQOcWCuM4zewEuH0QWl/HZJBBoPgeAf65/A
	5RMrqU3h1QQbK6e7JDL+f6+zHyoEwx4kQDNgcWhF7hn2Cez5eLOcCY0YcfJrLetU
	Uwc18hfH1+JbVK8QSdBVg==
X-ME-Sender: <xms:fURTaV3rdfR562o3m_OGW5SwvrnGVJvxHlyZfr4_5eOjZqu8DhL6Ug>
    <xme:fURTaW6Y9YKPCVxRq3aoS_fcrHbinrImTHyj8wcaKxsneLNiPMQz66H5wzpwDIaHk
    bZjbfND5Bc_SpA29dk6GrL7lENvzuHYejiyZKj3VtHdWLLkgrjPgpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejkeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdforghrkhcu
    rfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
    eqnecuggftrfgrthhtvghrnhepudelieegffefvdfghfevvdegtdetveekkefggfffteef
    heffvdefgfeufeekudefnecuffhomhgrihhnpehlvghnohhvohdrtghomhdpkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpth
    htohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhoshhssehkrghllhhi
    shhtihdruhhspdhrtghpthhtohepjhhjohhhnhhsohhnsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrthhhuddukheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fURTae_zsJmckAJDxKSKsfzr9WxyFGyPaZU-SndrKB93LrDr_lB_DA>
    <xmx:fURTaaLkaty8Qbniu542Bx4DloM9GJecd5dSRgoMoRuEJCoCTh1V0Q>
    <xmx:fURTaXj4L6xVxKZc-TRecJNVJsSQCNLEgS1MAiiG95Xz4uZXzb6AwQ>
    <xmx:fURTaa6BdaM4zh1FY7ovN5wRoIVQL3YrBG89Eyx4-Op3Mc1Tbgwalg>
    <xmx:fURTaQCXoTv-BU5GO1Z-hUy3AuJRYShiw-0Gztg5mrtkzEDzZso8tFf9>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B89022CE0072; Mon, 29 Dec 2025 22:18:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AczW8cjZh48J
Date: Mon, 29 Dec 2025 22:18:01 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Ross Vandegrift" <ross@kallisti.us>, "Jeff Johnson" <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Message-Id: <56017489-d1cb-4c9d-8550-0ca51dbb847c@app.fastmail.com>
In-Reply-To: 
 <lqdj7qwifphuvho2ag6fi25y63on2lzur7of6yt5prz3rxveur@zofllv7qgf2w>
References: <lqdj7qwifphuvho2ag6fi25y63on2lzur7of6yt5prz3rxveur@zofllv7qgf2w>
Subject: Re: [PATCH] wifi: ath11k: add pm quirk for Thinkpad Z16 Gen1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ross, 

On Mon, Dec 29, 2025, at 1:56 PM, Ross Vandegrift wrote:
> Z16 Gen1 has the wakeup-from-suspend issues from [1] but was never added
> to the appropriate quirk list.  I've tested this patch on top of 6.18.2,
> it fixes the issue for me.
>
> There's normally a second DMI product id, but I don't know what it is.
> I also suspect Z13 Gen1 should be added too.  Mark, do you have those?

It's a bit odd as 21D4/21D5 is the Z16 G1
Z13 G1 should be 21D2/21D3
(https://psref.lenovo.com/WDProduct/ThinkPad/ThinkPad_Z13_Gen_1)

They're both based on the same design and system FW so I'd expect the issue to hit both platforms.

I plan on testing this on my system but haven't done yet. I can check the Z16.

Mark
>
> [1] - https://bugzilla.kernel.org/show_bug.cgi?id=219196
>
> Signed-off-by: Ross Vandegrift <ross@kallisti.us>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c 
> b/drivers/net/wireless/ath/ath11k/core.c
> index 812686173ac8..1c910db69738 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -994,6 +994,13 @@ static const struct dmi_system_id 
> ath11k_pm_quirk_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
>  		},
>  	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* Z16 G1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21D4"),
> +		},
> +	},
>  	{}
>  };
> 
> -- 
> 2.47.3

