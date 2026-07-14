Return-Path: <linux-wireless+bounces-39011-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I7W+NYbhVWrZugAAu9opvQ
	(envelope-from <linux-wireless+bounces-39011-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 09:13:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B44F1751C10
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 09:13:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arndb.de header.s=fm1 header.b=b+Mk3si1;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="b hfPs3j";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39011-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39011-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arndb.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C04ED3008FC0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 07:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946963EBF19;
	Tue, 14 Jul 2026 07:13:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA923033E6;
	Tue, 14 Jul 2026 07:13:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013184; cv=none; b=aDQPq1T9FJD2ODUkL43CI6Z2ofPwX9cdsm9ts6HYgHgxTWal+J88X4uq5K4cNvET/VuquYX3yDW6U2b+C93tsTiv0EqHjK6M0sdwXvIXy7clEdy9lKwtcfk9n58b4+hdG3sNUbIeTKX9bfJlizLN2CotKO/Yi3Dpo2zE27s/3mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013184; c=relaxed/simple;
	bh=hjMnmBy5eiiroY+WM19jerjrD4NSfqSbySltKRYbT18=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jRyCofIY8n8TmgVi6hIXg6n0ZQLoBrvluEOev/q/93JmTjrMDazStTMzknUEGsBCp3Q4y7YhAZ57IN8/CPJ/pzS+kzRtaZ4Cwh5Ud3s4+mn2CJVz5DdjjIUcWhQZVfc2slZTnDiW5dr1MWkt71J46IaUjYooN/r5LEE4CcJQV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=b+Mk3si1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bhfPs3jA; arc=none smtp.client-ip=202.12.124.156
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 77AD47A0145;
	Tue, 14 Jul 2026 03:13:01 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 14 Jul 2026 03:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784013181;
	 x=1784099581; bh=U2JleBMEyaN4TrOpJxl78gYeo4UTolhpSNMUutN3PbQ=; b=
	b+Mk3si1dnGvDUxCX9dTarczfqQV3U7abc1fyV2eDgAIbKaUw3MjuSXk2Oqq7tmY
	UpIWr83ATb+ggnNsoltuRUOSQYeYEeVOHoz58QR6l69cZqBJNxjyrMr3Z8lAR7eO
	MFAAoSnYXp3GU/GafGxwRrWxxjwkhI86zUXTZTqu1nyG4WMOvn3W85pdzf0TFYKa
	dx1NNAokYbrd9ijeY22UPlKYfeTbl5yMKPAeRnNDCWFlAlLyGD4QU6qj8ay9804a
	JMbcyyMN6j9BmM4Y5QrQDhUXO+4GCGEeuJq/GYge/YAvIQxu+xfc6J12teCW6l+D
	/DHvHQ6ZbYdAjQ5EsQZCtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784013181; x=
	1784099581; bh=U2JleBMEyaN4TrOpJxl78gYeo4UTolhpSNMUutN3PbQ=; b=b
	hfPs3jAdSBOSwUdaX0N7VbhDiPF8bSclHADKfVOLu6xGnOFzGNs5+B5UnMIQg6r3
	YqnZDfDfjg4vQghwz6hERGqzCedtPGWn2I/9bCF0WX80CQ9wwTZ1qylm9yWY491n
	F+2HikMrt6YL7iFpxnqjjpWdC7KN+vqB222T3ZdWnaj37Z389p7GoVp5oWVusilN
	btuiMGhNgKtSy5OppNp764PmYtbw3XbhczRKw5UkHuXI9DOYJPp7LPz8A42icZL3
	ToHG8ZnHlM/KsLf77njfG3c/kpcPGGdRVpAq12tx3w50f866aGA6+fd1/2zH50f7
	wFWiriK+5mu3gooWbEQXQ==
X-ME-Sender: <xms:e-FValZnF0Gh6-pAID_JiLxPlTDjBGclM6GAV3G27FnNXk-IpL90Eg>
    <xme:e-FVanMXpXC3qqZNUcvWp7yEN8J7RcjhXA-2zOnvib5prccOgarvRWUCASpm_We4P
    yb2h3rl5oXJs_Ot5cs1dErZtofN0Hlui9IuH5qEDGf3S3Y1npf8DT0>
X-ME-Proxy-Cause: dmFkZTEi623NeAIToclec5fEpZtjqETttKPLxvck5S7cX8ia4shMWBc5B04a00kNzETMhG
    nd8QZoxSuQqg7t9Lydv4FxzZSEPTOxk12aNxSKOoFr8X/jY9bz1l2ODa4aRqaT1RVYvKcQ
    XxIM/PA7ZmApHQNm17gbEVR51QX4FHkwHHLN3uDYfaNEFMnvcj01jbxs/9NRZGYpones3u
    b6rYdbijILeHfskKZWrZo2NNC+vK8LvenPGViV5grJFIWAjmoWKnWboj1Q7en0ruyiKaNd
    Xj1vnDHRJfz5hZo2LJcQUP9TzxdEsmVLW0LMiySucSZVvHlawGdj0/xaB9FbPkk1YbjJpO
    oXt7Ggj0nQHoVszgKLkHzX7luk1W+CiwVOazhwL5uk2ETUvbcfA5J4MOxeM0q/RkWYFQ9L
    Cyul8AJvkw/t3xrpM0w4ur3qe8mmQozCI9nKwHmCR9wxr4lLVqNfWA896ccQv/E1gcEzzT
    iPqBxORi1I1T3QskB63RB5IFIlQAYC0GtoqHrnMqNgwl4BJ1gkckjEtv0RIHyKA2AXQx0f
    MsrxvKjJT4FUiec7RvpZg89kjBNFWNoQGX5DFrteQzwzeyR1aTnxs7fdSJYqIYC9IrVXNZ
    v+C+24/ozwlT37VRZ6OdZA7LLPmbLRPtmj3P35V88MnbZE0MiTUXBibyX8JA
X-ME-Proxy: <xmx:e-FVakTFdwwuk9BuBWXPFofooOE_sma9W5OC_u-qDa5tc3ti212pbg>
    <xmx:e-FVap7n6Oe8ZBc0gMm-Kh4GWMsLF8uSxoiT6U4_mEM0EssT5lat9w>
    <xmx:e-FVahWgg1FTAP2U9xYwa12ptUfo8srFJhw05lTZ0nCrRO3NDd93zg>
    <xmx:e-FVan-FpBLhrhR3yWTq29pa26fYrkkP4IuzjJdcha-QFXqVcufTKA>
    <xmx:feFVagmAILd35LAyioF_Mgc-izHf2yIj0Bq0ei8Aw_o1BO44NB9ATcaK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D17C4182007E; Tue, 14 Jul 2026 03:12:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AR7AWmfjl_6V
Date: Tue, 14 Jul 2026 09:12:39 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
 =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
 "Hauke Mehrtens" <hauke@hauke-m.de>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Waldemar Brodkorb" <wbx@openadk.org>
Cc: "Bartosz Golaszewski" <brgl@kernel.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Message-Id: <4a8d64e1-5f8c-4ac0-afb0-2d68c3f53ada@app.fastmail.com>
In-Reply-To: <20260713-b4-bcm47xx-swnode-v2-0-2b879f0c193c@gmail.com>
References: <20260713-b4-bcm47xx-swnode-v2-0-2b879f0c193c@gmail.com>
Subject: Re: [PATCH v2 0/3] MIPS: BCM47XX: convert buttons to software nodes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dmitry.torokhov@gmail.com,m:zajec5@gmail.com,m:m@bues.ch,m:hauke@hauke-m.de,m:tsbogend@alpha.franken.de,m:wbx@openadk.org,m:brgl@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mips@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39011-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[arnd@arndb.de,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,bues.ch,hauke-m.de,alpha.franken.de,openadk.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,app.fastmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B44F1751C10

On Mon, Jul 13, 2026, at 23:58, Dmitry Torokhov wrote:
> This series converts the legacy gpio-keys platform device on BCM47XX
> boards to use software nodes and static properties.
>
> To do this properly without relying on legacy name-based matching
> (which is being removed from gpiolib), we introduce and register
> software nodes for the underlying GPIO controllers (BCMA and SSB)
> and reference them in the button properties.
>
> The first two patches add the software nodes to bcma-gpio and
> ssb-gpio respectively. The third patch performs the conversion
> for the BCM47XX buttons.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> As Johannes mentioned on v1 this best should go through MIPS tree.

Adding Waldemar to Cc. He has recently done some work to
get this platform working again in FreeWRT and should
be able to test your patches on hardware.

       Arnd

