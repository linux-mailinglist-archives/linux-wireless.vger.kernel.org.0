Return-Path: <linux-wireless+bounces-19639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D905A4AB5E
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 14:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1583818976B4
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CBA1DED51;
	Sat,  1 Mar 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TJAjIFPK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xqYomUpX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86B2FC23;
	Sat,  1 Mar 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740837004; cv=none; b=hoUJ95ScdWoNpqs3fScWJOeknXWDSHG06tW2qj73ZRmd/6ayVSuuvDeVWwn9Kc1nqbTM4OlKVRFdqBf2Fr52ZDbLQDapO5p1++8XOJKTl3ocbbAnTHMltLAoYm4HGFuViBYARy+2WwhXh75IiaXDPUOyGo2fQQrXkc18wBidpwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740837004; c=relaxed/simple;
	bh=sY//qPp22PMpSlwhTwo5L3jRdXujgnSb3V8Mf2jN9X8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hxPcNyrId1wvtuQv72PqMqXUHSvUukaCu1EvHkKKBmnIfZaYoNucVy9jxFCLslRZaF/vvRtwRxe0nSrJ3qP1XJNtEijy8INNotApGt3PbvX+4rYJGTJe1dxSMeFqTHvyWoXOftaOCKd/4bCvkal2sOIcC34Wa+McgOpmRPMfops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TJAjIFPK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xqYomUpX; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 018671140166;
	Sat,  1 Mar 2025 08:49:59 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Sat, 01 Mar 2025 08:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740836999;
	 x=1740923399; bh=ihRc8/uUUJkepGXewCKoZVfK5186pYNj66y9b1/NoDI=; b=
	TJAjIFPKsV3FznpN7aD/TDQgKZJFY9s/9Hfcd9IcTreR23u1ofldF5/Yzkir3fZg
	d67VHPg1Pl/2dj9NV/0WTqCcd4cfG1ym4m8Ve0lxpTwlTrr6p4x/B0fmOBxdgsCP
	m6mOUqtwBsZ/gsXmgoXCZ+Y6Xe+0q4ZSZe6Y5Xctk6D6JmETyHN6R3E8k3HwtdtU
	N9ouwdxliZEiZxotSs/utlHLvZJF4M2u5LLXO3wcVhp/w5zb823oQY0ogRa2WQEC
	aXQJNc4VL/658fPR5ECN6EnJVcgNGldaJiTCaR/RHaf4CnMZqkT5aVUXSLnnasab
	73d6dRpmyoIPejDyqURruw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740836999; x=
	1740923399; bh=ihRc8/uUUJkepGXewCKoZVfK5186pYNj66y9b1/NoDI=; b=x
	qYomUpXPm15l7GX4VDXk2aURPYYyWHRgh+RprvAIQgk4QlIl19atqgQwJOuQjedy
	Wiobse3uZ/jQ1vqj0z5Fwls69BrKUin7VO6AXZB6dKxulAZrghFSPuP18esS53S1
	b1YH9Cpcpwo2aXMM4uUhMDXsyk/u6Is3mXHDArDmFmunPA1XC9apOMdUoVZYlsUc
	ixkW1sjDpwdT/Kv4yVOIn90Pnw7HfLtO6fFa39yKNgsexunortsXT8f5NvDTEB/M
	8A7OBbVItqfAC6fXfZunWA9dCoeqzPCZ2cSm6f6iVdpbe9alcBTNOqnAST4jP8vS
	/DQFJQl8IeK6bkKiCi+yw==
X-ME-Sender: <xms:hxDDZ3ip4CzrSj31ZDCM1M-QRIyJjSG8J3ZVxtuSBW0JwFXrxB3KeQ>
    <xme:hxDDZ0AUgIb9JSeOcF4n5ZvKxHx-QRAe2eXtyQgGSKj7y5xHZppi8qJ8UuQFWiz5a
    ZxSrb7QNO5CvHrKh_k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelfeegiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:hxDDZ3F3Gnkg07VHfsAKyqx_EbWNDfaPl0nCE505LqQ7suhvppU4EQ>
    <xmx:hxDDZ0TNo7YQxEQiwEAuBW7nI48W68n_uwCzyqqOs1ay3NnpRPdlrw>
    <xmx:hxDDZ0xCHV131qAuMhIgsMDeZKxH47W_HKGS3-EsZlDYSlbUIVcn1A>
    <xmx:hxDDZ64e_HUxaPeAVjYxZBzOuGoUgpDW3o-ho2UiLwQ5y43EDvy65w>
    <xmx:hxDDZzkeiqsVJu5OKgBZBUnY1tE824qgzG3Pg0CiVJkwYlye7BQwFSfv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 34CB82220072; Sat,  1 Mar 2025 08:49:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 01 Mar 2025 14:49:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Stanislaw Gruszka" <stf_xl@wp.pl>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Johannes Berg" <johannes@sipsolutions.net>, "Kalle Valo" <kvalo@kernel.org>,
 "Ben Hutchings" <ben@decadent.org.uk>, linux <linux@treblig.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <7e472cbe-bf29-432b-93da-d1fc87630939@app.fastmail.com>
In-Reply-To: <20250301133652.GA60453@wp.pl>
References: <20250225145359.1126786-1-arnd@kernel.org>
 <20250301122834.GA55739@wp.pl>
 <994e4827-0e16-4e05-be7c-1ca7a86e4daf@app.fastmail.com>
 <20250301133652.GA60453@wp.pl>
Subject: Re: [PATCH] [v2] iwlegacy: don't warn for unused variables with DEBUG_FS=n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Mar 1, 2025, at 14:36, Stanislaw Gruszka wrote:
> On Sat, Mar 01, 2025 at 01:38:16PM +0100, Arnd Bergmann wrote:
>> On Sat, Mar 1, 2025, at 13:28, Stanislaw Gruszka wrote:
>> > On Tue, Feb 25, 2025 at 03:53:53PM +0100, Arnd Bergmann wrote:
>> >
>> > But then the code will be compiled for !CONFIG_MAC80211_DEBUGFS
>> > case, it does compile for me:
>> >
>> > -  22475	   1160	      0	  23635	   
>> > 5c53	drivers/net/wireless/intel/iwlegacy/4965-rs.o
>> > +  23008	   1168	      0	  24176	   
>> > 5e70	drivers/net/wireless/intel/iwlegacy/4965-rs.o
>> 
>> Very strange, this really shouldn't happen. Which symbols
>> exactly do you see the compiler fail to drop with my patch,
>
> nm 4965-rs.o diffrence before and after patch:

>  00000000000000dd t il4965_rs_alloc_sta.cold
> -0000000000001810 t il4965_rs_collect_tx_data.isra.0
> -00000000000012b0 t il4965_rs_fill_link_cmd
> -0000000000000495 t il4965_rs_fill_link_cmd.cold
> +0000000000001850 t il4965_rs_collect_tx_data.isra.0
> +0000000000000e90 t il4965_rs_dbgfs_set_mcs.isra.0
> +00000000000002f6 t il4965_rs_dbgfs_set_mcs.isra.0.cold
> +0000000000001340 t il4965_rs_fill_link_cmd
> +0000000000000518 t il4965_rs_fill_link_cmd.cold
>  00000000000002a0 t il4965_rs_free

Ah, so the debugfs files get eliminated, but
il4965_rs_dbgfs_set_mcs() does not.

I think this should do it:

--- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
@@ -2495,6 +2495,9 @@ il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta, u32 * rate_n_flags, int idx)
        u8 valid_tx_ant;
        u8 ant_sel_tx;
 
+       if (!IS_ENABLED(CONFIG_MAC80211_DEBUGFS))
+               return;
+
        il = lq_sta->drv;
        valid_tx_ant = il->hw_params.valid_tx_ant;
        if (lq_sta->dbg_fixed_rate) {

or possibly il4965_rs_dbgfs_set_mcs() can stay in the #ifdef
if you prefer.

      Arnd

