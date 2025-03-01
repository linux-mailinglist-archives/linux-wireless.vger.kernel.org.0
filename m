Return-Path: <linux-wireless+bounces-19637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A212A4AAF6
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 13:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F693B3C34
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD791DE4D2;
	Sat,  1 Mar 2025 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="d9WjBtFl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m2kl+B2U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C11D8A0B;
	Sat,  1 Mar 2025 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740832721; cv=none; b=AACZj84qHqL7Cki4swxR8Ra5Mxiw4AyNJROdTe4LmaI2npBFOpUS8S4bt1MKlINxFi6WOO51mFAvT4+mCPAjh6FTDzTuwCOXRHq9lr2D7rvjF2a2JhVa3wMIQPYCX+BWPJgPw+p2kKl7JsRIYslI5azUGWQS2LqlfFtmXYMWhcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740832721; c=relaxed/simple;
	bh=rrGNkFrv3f5CmhlRM+Joi7hAYrfRQG7h7GhOvXiAyM8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P3Utfz1/ljLnJ8sONMyQKO9Im5CKRIP286VExYsNo8xCFc851oy2scl3XOWhiZ+Xhbzde9hL0er+5Ji9dBdKY6xoHgVRtslouqH6tS3lUPTVCEsoyWOh5QpZ5JmrMAzP+toUJiri0TePwwW32HGcU+Px5JJJuHgKsNM5yl8xOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=d9WjBtFl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m2kl+B2U; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 858D21140100;
	Sat,  1 Mar 2025 07:38:37 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Sat, 01 Mar 2025 07:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740832717;
	 x=1740919117; bh=tjeEIDFBTv0qw01qPUrH5f6Cwruc5eD9G/E2Cffx1vw=; b=
	d9WjBtFl/SGX449KuGzSDcog2c4nuPXOGlzsuIlTJhrR7JqBbHMfgM51fMNGC9a5
	1iHv0GQnrhTEqqDJP39/MIMgxC6BKwbQa66anD1EAUHEoFJPJQPCdtSO5lVgxZ87
	IRovlOKhLhb9BNVcJZR53TLiX/LDSuoM4C4UJReLAqgxE54FoFg8icE8MR3Wg7W2
	bIRK6VQbPQd2eTfYiHnjd76MWbV+BBHq4Q39uReET3NFci/QZzi9NOi8D9EkBeXx
	lb0zHNDlvaBqxJNgYK7uQzZ2cQDF2mEU+G5amKyW+YY+WGJtTmFOxxtW8KjAqizF
	Gs4I+7GDImNh5IR1UQRdyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740832717; x=
	1740919117; bh=tjeEIDFBTv0qw01qPUrH5f6Cwruc5eD9G/E2Cffx1vw=; b=m
	2kl+B2UmzqKjszI6BZVkxRDpeOm5s2+BfERL1redhPBOkRMjRq+CA9k4ruXf9ro9
	RuyLRfw1uigTxWGgr5zIoHrXIp9uiKXxnigvQ8GGn6Zjos4pHQrekjzJ462Ds5YJ
	vSoyX7XTjLL+zE6/uYifInvG0y5nefKflmMrq3j64zbsf3HLePhPBpd+kJEyZd59
	sTVu+HgHhOSaf+OqV8me9c//bYQu5QvUD0XVYkL3Wb0EulDucJX94pCN9UQH3X8F
	Nizg3qaEX3b63Je7OG0zlIjCxmpKnEsiDdFOs/GRJILMvLgekGL2lTmqCEHNLDJC
	OeXywMaHVYXl1XS5doNnQ==
X-ME-Sender: <xms:zP_CZ1OWu5WI8zETg8KQm-IqFWfLVuTaKcyKChLPjhmiCf7SQf3Bsw>
    <xme:zP_CZ3-vZyAmYFLqbKPpLdvr7aw-ecF1acaEhq7vhV-OFMrCnrdyz0fRBhbqUYgH5
    9Rp6Qa0ShbPRdNR8AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelfeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnseguvggtrgguvghnthdroh
    hrghdruhhkpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehguhhsthgrvhhorghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhvrghloh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghssehsihhpshholhhu
    thhiohhnshdrnhgvthdprhgtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhtfhgpgihlseifphdrphhl
X-ME-Proxy: <xmx:zP_CZ0QrRtZQjU55u5UbdpqUANRnsA1AkYAmdL7V-cE7KT8w-v-7Eg>
    <xmx:zP_CZxvwUmZsVblgf8Un_wuVROzAhaWqTmBdmxXAojpbvNec9KriEQ>
    <xmx:zP_CZ9dBMBSj_WT2SfWyIK_BUUvGyXn8B8ixX8GzYMEwZ6ozyKhJkA>
    <xmx:zP_CZ93OzZh-u1-R0xAj1F79i26s2psWyhdO6CE7z48STvKJYvu1_g>
    <xmx:zf_CZ8xspkblI34gXURum3Zsi6wELjUiCFWHx3GCp2C9SbAa7Xl1OGfD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BE2B52220072; Sat,  1 Mar 2025 07:38:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 01 Mar 2025 13:38:16 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Stanislaw Gruszka" <stf_xl@wp.pl>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Johannes Berg" <johannes@sipsolutions.net>,
 "Kalle Valo" <kvalo@kernel.org>, "Ben Hutchings" <ben@decadent.org.uk>,
 linux <linux@treblig.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <994e4827-0e16-4e05-be7c-1ca7a86e4daf@app.fastmail.com>
In-Reply-To: <20250301122834.GA55739@wp.pl>
References: <20250225145359.1126786-1-arnd@kernel.org>
 <20250301122834.GA55739@wp.pl>
Subject: Re: [PATCH] [v2] iwlegacy: don't warn for unused variables with DEBUG_FS=n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Mar 1, 2025, at 13:28, Stanislaw Gruszka wrote:
> On Tue, Feb 25, 2025 at 03:53:53PM +0100, Arnd Bergmann wrote:
>
> But then the code will be compiled for !CONFIG_MAC80211_DEBUGFS
> case, it does compile for me:
>
> -  22475	   1160	      0	  23635	   
> 5c53	drivers/net/wireless/intel/iwlegacy/4965-rs.o
> +  23008	   1168	      0	  24176	   
> 5e70	drivers/net/wireless/intel/iwlegacy/4965-rs.o

Very strange, this really shouldn't happen. Which symbols
exactly do you see the compiler fail to drop with my patch,
and which compiler version are you using?

> How about moving  
> static const struct il_rate_mcs_info il_rate_mcs[RATE_COUNT]
> under CONFIG_MAC80211_DEBUGFS ? Maybe inside the function that use it ? 

It's not supposed to make a difference, let's try to figure
out if there is a compiler bug or a mistake in my patch first
and then fix it in the right place.

     Arnd

