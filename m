Return-Path: <linux-wireless+bounces-33907-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCvbMdZ9xGmTzgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33907-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 01:29:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E1832DA68
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 01:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C8B8303B2F5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 00:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E97723EA88;
	Thu, 26 Mar 2026 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="FfGJaiGR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMCjAfot"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883B823C51D;
	Thu, 26 Mar 2026 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484567; cv=none; b=nzEtvbmB5NqDPhxgA0MrDINfHmQg610um5XgA+2ibPw9v5VYq44yv/CodNVMgmKPBswK6mEMmYm2jc0bTgpSKSxrsQZnVzGe5kC+OKMoVPT3jntXMw/RJNOdJV7OQybapP7xHSDQLdU3PKAyhJvRhYz3Q7JxMg7DZq+BMq0tp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484567; c=relaxed/simple;
	bh=KoGksBrhgEtRDSfM/YDFfZUq76xOqjELkeavOboi/IU=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:In-Reply-To:
	 References:Message-Id; b=Ho7rSybZfGdL19af+VOjbyM9CGi67JuFQRpeMbNy0mRO1CS9T8TKgvgkCVujwQ7PjLsVw5EwUqwH9ZsaE3sRpsMWOitnrSosWJixNWCrz8KoN0tNwY3t5iULsVDROJ47JAR8sz6aAWoc5GWtau9sipAFwBAPFk1pcSrDwJeyplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=FfGJaiGR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AMCjAfot; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 1EE311380743;
	Wed, 25 Mar 2026 20:22:43 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 20:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774484563;
	 x=1774491763; bh=KoGksBrhgEtRDSfM/YDFfZUq76xOqjELkeavOboi/IU=; b=
	FfGJaiGR8wwkUXmw0OxoZpapCVyITNP9jQy8V6NXs0B+Ph/EboZ2CHMbTVSeupkj
	JBD0zhKFeLS3L8CW8USOd442u1gW4WT1y9mQbnYGuun3qhtkeSv0HTFgcexsIOgZ
	DKM26Re1KjHSTDGIlM+h0WJlhs+6rzihgMk0Vmx/h6GyzimOsPkL2rmPlw2agXHH
	R3M7xQBFAIHcDdxKbyLWVKOM10V7AR6FC1cS2z3WipPG7/8omenaCkD8IyqJVC8i
	uieLb8upy0xI0GAU8XQBD2js3xklu2zPADpLfKLaFndXrs0M5tD+Xt51R/k+YLuy
	8CHf8wsChVIfAwZPnRHNdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774484563; x=
	1774491763; bh=KoGksBrhgEtRDSfM/YDFfZUq76xOqjELkeavOboi/IU=; b=A
	MCjAfotSWOW3C9NV4AeCNzy4JHkSliVuTt0hUDrEPtKEGOshqyW4BvD6IQTIXirQ
	LTEe5edkZKe2JTOuo4MyQNiKv6ux/nahS3w0TKY6ATJzzq1eW3uNq50fUwdnEfuP
	eKXfHbE6JAWIHVz6C1pi/yHEHfkGPbX/GhrmRaiB95nmMkf0R/DQubxxJRzXiFxS
	66IPRzG+AX6DvMqqueeu7MbAi3repjTeColUxTWnJThzbOs4HSh1DmGPX+6FquSO
	uIQ2mf+QD15/nqo5uKEbU4z/oBdGdJh+hXMYIwq8BYcbVJ9RcXYopdGqXymK6raM
	OlbV4/XUk5khh1MSZc7CQ==
X-ME-Sender: <xms:UnzEac2LXinKBmeR3d0Q11WE2DDpQWKzJXO4ycyPck9LqLIS4IyPcA>
    <xme:UnzEaR6IZhGtIDeTOb3SAV7MGqaAp0Mo6JVoZm1d5LvTrvWBoY-60PvQzlbQWMjUa
    nocXa8ZOJGFtWGeDcbQNICZHxVD39rHIOe6tWbSJgvBuS5gSC9nxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegopf
    hokfffucdluddtmdenucfjughrpefotggggffhvfffufevjghfsehtkedttdertdejnecu
    hfhrohhmpeflrghvihgvrhcuvfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtf
    frrghtthgvrhhnpedtudejffejkeekteelueefvdejvdeuhfefteehkeevtddvleduteek
    leetvdelhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehflhhoshhssehjvghtmhdrmhgvpdhnsggprhgtphhtthhopedvfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrh
    gvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopeefudelfeeifedusehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheplhhoohhnghdrtdigtddtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprghrihgvlhdrrhhoshgvnhhfvghlugdrjeehtdesghhmrghilhdr
    tghomhdprhgtphhtthhopegthhgrphhuihhsuggrrhhiohegsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhiohhsrghlledtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgr
    thhthhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrughoihdrtg
    hhrhhishesghhmrghilhdrtghomhdprhgtphhtthhopehsrghmuhdrthholhhjrghmohes
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:UnzEab2oOstJnxD3dqX5RYKr-ESaHoxoRnNsZYzSCAV-UwH8WCVi5w>
    <xmx:UnzEae-ZILLAGzzaLn06h_7AIjh4xtDuvtUWod50hjVv7GIuwi3ktQ>
    <xmx:UnzEaZdVrqQuIE9xnoEK3CriglFgOK3tpmn3r3l-SFnbAstLTuVrKA>
    <xmx:UnzEaS7r9qT97VdUBsaCuJhRdNTDekAHd0IKPihETnVnXsem2QDGag>
    <xmx:U3zEaZShFSVc8IhrR0Le_l4CFEQpZQVkY_JEG6y5wJovFb4_lMPWUdbE>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 50D8B1EA006B; Wed, 25 Mar 2026 20:22:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Javier Tia <floss@jetm.me>
To: Sean Wang <sean.wang@kernel.org>
Date: Wed, 25 Mar 2026 18:18:45 -0600
Subject: Re: [PATCH v2 05/13] wifi: mt76: mt7925: advertise EHT 320MHz capabilities for 6GHz band
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Deren Wu <deren.wu@mediatek.com>, Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Marcin FM <marcin@lgic.pl>, Cristian-Florin Radoi <radoi.chris@gmail.com>, George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>, Samu Toljamo <samu.toljamo@gmail.com>, Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>, Chapuis Dario <chapuisdario4@gmail.com>, =?utf-8?q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>, =?utf-8?b?5byg5pet5ra1?= <Loong.0x00@gmail.com>
In-Reply-To: CAGp9LzoYcJEmFKTKGsF3WchxLedyo7HvGCn8Vi=WaEXS1N-VTg@mail.gmail.com
References: 20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me 20260319-mt7927-wifi-support-v2-v2-5-d627a7fad70d@jetm.me CAGp9LzoYcJEmFKTKGsF3WchxLedyo7HvGCn8Vi=WaEXS1N-VTg@mail.gmail.com
Message-Id: <20260326002242.50D8B1EA006B@mailuser.phl.internal>
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33907-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,lgic.pl,humeurlibre.fr];
	DMARC_POLICY_ALLOW(0.00)[jetm.me,quarantine];
	DKIM_TRACE(0.00)[jetm.me:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.588];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[floss@jetm.me,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailuser.phl.internal:mid,messagingengine.com:dkim,jetm.me:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42E1832DA68
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Hi Sean,

On Mon, Mar 24, 2026 Sean Wang wrote:
> I don't think this is correct for mt7925, and it will cause a
> regression there. Was this tested on actual mt7925 hardware?

You are right. I do not have mt7925 hardware to verify against.
In v3, is_320mhz_supported() now checks is_mt7927() only, so
mt7925 behavior is unchanged.

> I don't think this should be copied from mt7996 as-is for mt7927. I'd
> suggest dropping the eht_cap_elem->phy_cap_info[7] change and keeping
> it conservative for now.

Agreed. The phy_cap_info[7] additions (NON_OFDMA_UL_MU_MIMO_320MHZ
and MU_BEAMFORMER_320MHZ) are dropped in v3. Only the MCS/NSS maps
and per-BW beamformee SS/sounding dimensions for 320MHz remain.

Both changes are in v3, sent today.

Best,
Javier

