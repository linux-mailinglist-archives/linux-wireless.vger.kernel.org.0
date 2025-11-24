Return-Path: <linux-wireless+bounces-29291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0B9C816ED
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 16:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB3E3ABD99
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 15:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BC7314A7B;
	Mon, 24 Nov 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="AzqzzBAX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VZQi3v8s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B431355D
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999551; cv=none; b=KiBi3B5PAfBfw16DtUFZJOEvkJZKqO9tmrPVMpKhA6+fGTDgBD3Le7qyF1exUv+XEYp6sTrcS9iN8S5E+KXjWs/8biw/aJXwZKpUBJuCPKuzdwpqQa/ZpF+gHJDqnZLUrjd/xqieuS2/GxCnBXA1XhEcUwWscEfHX3PgMaqGXXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999551; c=relaxed/simple;
	bh=KJY+e/mkvwuR3uqJGDtENuLL8wHOA6eMJkTif10Psyg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Xa6YZDbtfMfkNAsJP9Ec0cBvC1QVl/u7zNiKdt3QXHpSeJyLyG46DS12nxQ1KJ6zNnu6ImmQQpPXHleHDUfg9Dyv40bI4N5+F8BT5INWFi3LgeC/0U3gwNeZ8e8qnIOVRUI1ZmTQIv4c9wKzPcngZvrUKY7Qpr73rcihf8JIATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=AzqzzBAX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VZQi3v8s; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E1D11D00135;
	Mon, 24 Nov 2025 10:52:28 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-02.internal (MEProxy); Mon, 24 Nov 2025 10:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1763999548;
	 x=1764085948; bh=/P3A8XqYfPOndlEJFspQX8roTam1zgUG+0GFJD35Qxs=; b=
	AzqzzBAXA8nd1EXbhlP18z1STsQ3qFB10rarI1gmxLOe1hrZvKQuxrbaGJPdklAl
	lw4ARRnfuhwx1HBJubsJNodsqoBVqgRJVViy+OzN9VXrUoOZRsy/64IWk/2roxrZ
	ctPk8hyar8StLLI4WST2dx60vJATkbTN0dxUHOZFB8ukMHBBSs8CWmvvCAhZWu/q
	rDCmkq+VUUUzHCb5s9JuOPN/qFf2jj19dMYww39w4iXKgcqFcfG8NmFTEOWEbMiH
	uuBmWufSbdCYUw2QW0x6DA/7JDvWzAo2Zwyyih4QCv4EOlc3qOl9QuxMdj5SDj4A
	kpddWdv4SVOKeOKvvfwS5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763999548; x=
	1764085948; bh=/P3A8XqYfPOndlEJFspQX8roTam1zgUG+0GFJD35Qxs=; b=V
	ZQi3v8seKXpXcl1DcLX1jvXIkHWOBST5TCPx0xckyoMixBcOBifaPu+dYAXrir10
	7Pie2gLfHjBbW00YUIMhgedU2/73V4QSaa13PHWA3xY8GL3Wu1wn/6l8Tmcw+2aa
	RoGjZdnUfHtMChRbA+JP/qBgbq2j4lOBrfqW8Vuua7S0112sCWChf1uIaUtSIot8
	cI1ovItYl2Us+FVzvkgRsocZ+JY+ouZdDEjqOjs1svpExvd8oyzGdaxK1FoXfgtS
	1C6VMKx6c8BsVAqdlmbgRf6nx85X+3g+MS1Sz2m3uGCBfzjYDUUDEUDT1/eq0Cbb
	/msq4phIP9nQTRPJqCpHw==
X-ME-Sender: <xms:PH8kaRcXmVXLXUgLxTmJSrT8b4V0DoHBsEtS13B7MsIk9AepWEWryw>
    <xme:PH8kaaBSsBM_CI2nPGni3rxG6_0e3qc0zF9u0_8Dvp-dw3qFL3x1pJ4j1LGgMUupg
    JPIOH6HPJNOu9wnQDedm0GAgp9zDt4yJVro5RmBn8_lY34F0hobL5MU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpefhhfffleeugeeivdelhfdvteejudekheetfffgueff
    leekudefteehieffuedtteenucffohhmrghinhepshhushgvrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhl
    vghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheprghthhduudhksehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtohepjhgvfhhfrdhjohhhnhhsohhnsehoshhsrdhquhgrlhgtoh
    hmmhdrtghomhdprhgtphhtthhopehtihifrghisehsuhhsvgdruggvpdhrtghpthhtohep
    lhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PH8kaTKJhZ24ID-6yNgDxeJ7BzVVwqtcoR-wjsuvFaKM--Aqvjvepw>
    <xmx:PH8kaeA8Y_xFC5VQcTysb8FU52MVJqDTgp_ZH_J70QGLdvMWjjajpw>
    <xmx:PH8kaUC-hKAkU8xZLj8-ZlhPhGbOP7kG4R_yAhEp5vQYn5BXtYWq_w>
    <xmx:PH8kaYCrEwRR12f_SMd8iebmKfgKTdhHhxq2yTEM-kC1-mfgaUmDMA>
    <xmx:PH8kab0kMBfr7gZAxW7LX5-xgrROEKOkjlUpk2SCNcGAt8Lnn6xHswgp>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 17A1E3020061; Mon, 24 Nov 2025 10:52:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aw6v1Pokv1cZ
Date: Mon, 24 Nov 2025 10:52:07 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Takashi Iwai" <tiwai@suse.de>
Cc: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Message-Id: <3b97881b-b21a-48ca-91f0-cbfac966ea76@app.fastmail.com>
In-Reply-To: <878qfvqwdo.wl-tiwai@suse.de>
References: <20251124134713.5819-1-tiwai@suse.de>
 <cb594fb5-faa3-4c6a-8ece-d2e176e196df@app.fastmail.com>
 <878qfvqwdo.wl-tiwai@suse.de>
Subject: Re: [PATCH] wifi: ath11k: Add quirk entry for Thinkpad T14s Gen3 AMD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 24, 2025, at 10:32 AM, Takashi Iwai wrote:
> On Mon, 24 Nov 2025 16:13:05 +0100,
> Mark Pearson wrote:
>> 
>> Thanks Takashi-san,
>> 
>> On Mon, Nov 24, 2025, at 8:47 AM, Takashi Iwai wrote:
>> > The recent kernels showed a regression wrt suspend/resume on Lenovo
>> > Thinkpad T14s Gen 3 AMD model; it fails to reconnect on resume after a
>> > long time sleep.  The only workaround was to unload/reload the driver
>> > (or reboot).
>> >
>> > It seems that this model also requires the similar quirk with
>> > ATH11K_PM_WOW which has been done for other Thinkpad models.
>> >
>> > Link: https://bugzilla.suse.com/show_bug.cgi?id=1254181
>> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> > ---
>> >
>> > I'm not sure whether this model has another DMI entry, so put Mark to
>> > Cc.
>> >
>> > Also, I wonder which Thinkpad models are rather the ones that should
>> > *not* take the quirk.  Since mine is Gen 3 and I already see Gen 2
>> > entries, which else remaining...?
>> >
>> 
>> It should only apply to models with the ath11k modem - but it looks like Gen 2 up to Gen 6....which is quite a lot. I don't know if all of those are impacted.
>> I think we'll have to do more testing and get feedback from the FW team, which will take a bit I'm afraid. I'll look into it.
>
> I see, thanks for confirmation!
>
>> >
>> >  drivers/net/wireless/ath/ath11k/core.c | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/drivers/net/wireless/ath/ath11k/core.c 
>> > b/drivers/net/wireless/ath/ath11k/core.c
>> > index 812686173ac8..3aa78a39394b 100644
>> > --- a/drivers/net/wireless/ath/ath11k/core.c
>> > +++ b/drivers/net/wireless/ath/ath11k/core.c
>> > @@ -924,6 +924,13 @@ static const struct dmi_system_id 
>> > ath11k_pm_quirk_table[] = {
>> >  			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
>> >  		},
>> >  	},
>> > +	{
>> > +		.driver_data = (void *)ATH11K_PM_WOW,
>> > +		.matches = { /* T14s G3 AMD */
>> > +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> > +			DMI_MATCH(DMI_PRODUCT_NAME, "21CR"),
>> > +		},
>> > +	},
>> >  	{
>> >  		.driver_data = (void *)ATH11K_PM_WOW,
>> >  		.matches = { /* T14 G4 AMD #1 */
>> > -- 
>> > 2.52.0
>> 
>> I think you need to add the "21CQ" Product Name for this platform too (every model has two IDs depending on where in the world it is deployed)
>> 
>> Unfortunately my T14s G3 AMD seems to be dead :( I can't test and confirm directly.
>
> OK, I can resubmit with 21CQ entry later.
>
> Also, maybe it'd be worth for adding a module option to specify /
> override the quirk, so that one can test without recompiling the
> kernel?
>
Yeah - that could be useful so users can confirm if they need the quirk too (especially if platforms outside of the Linux program are impacted). It gets my vote :)

Mark

