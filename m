Return-Path: <linux-wireless+bounces-34018-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMAhBbWixWlUAQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34018-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:18:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA4E33BC02
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AA1A301983C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49141A6807;
	Thu, 26 Mar 2026 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="B1OozqUR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qoFAzsoV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5C78C9C;
	Thu, 26 Mar 2026 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559894; cv=none; b=HbmQJaaQUQaWuU65LIsnsvCmd7sstqfpX/f+iUd5aDZMcANVm3jmUYPByYzxFxBMvFhhqirJlMvBsgt0+k852R7bK5MxUH5uxBpYT8mzzxY4Exsc3NkcTEjh3QBcv2mOGLO+GAuAOzvymyvHRhICDpUVCSt/dV9sRqYOHzIwIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559894; c=relaxed/simple;
	bh=DRLRvIU8ZWZkXRz1bJkCUDrO6OoViF8KWKqmafYFSQU=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:In-Reply-To:
	 References:Message-Id; b=HZZMSM1rR7hrksr/uYknrc0UAuyQPGAfjt63oJsBA1CcfyBV0O/ydv//IT8HUb/iwalm4F0/6IpZJ2Z5Fe2BFjtMhnzUuhonEReAiQ4Hc7b7Frl/byMN1eQxjMbquyHGvq1HhjvkmRkLs/lU2IVy2CB+ohxEf83ij9RJBZh2mko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=B1OozqUR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qoFAzsoV; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 8DD59138014D;
	Thu, 26 Mar 2026 17:18:12 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 17:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774559892;
	 x=1774567092; bh=+tfmY/v2HtY5x2GcuRis244mDWronYR/iYKmIjptCQ8=; b=
	B1OozqUR9wU2oJhixwEKUomHLfraD83tHL6yHnbYQ4iOZjVUWhHp1Opo+ZccK+zV
	FWdShXollx6H1e6xnBK2cYid9K7YzIVspBRKkgWgRXa72nd47KX7dLHeyxf9WLnC
	kAlXEb/CTobWxTl8Uo7P3YwJCBv2PaPIEroGqCLYjuDUA6KMVChAji+d1fl//MM1
	ZuZUI7eOGOR5IRNAXMPzPAItDe5pGIPPaC0KbCHX4tyNPwgpjP1xMlParGhF7cx6
	1gdPlDif9EizP2iGILTuaTTS/7Qxq4dOB2QmIdk+WlWJxvJAvp65lBQUzX9Tu/F7
	r099vtVAz+eRqGS1d5nEjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774559892; x=
	1774567092; bh=+tfmY/v2HtY5x2GcuRis244mDWronYR/iYKmIjptCQ8=; b=q
	oFAzsoVEYP8xIX3IfCmjayWsk3qcBb6ga+rm9ACMoeL8elZikkQNs3itFtbUWpFk
	K5rpwXTbvS1pSRVJ/sQx+yqQ2jjGGsFidxVDVtrDrq0MsLXf55A2vJltXiJhXzCY
	b6zLbpYQ4hCg8N1NwaTuLMdID0VAiF7WsBjgDbBlrntkYPtKWaggkg+uv7oz5U92
	yujBFFG7fSUaX8afui+uu0hACmJ+Gy2GbQ9fxjPmMa+3qYB4hh4iCUmALtRh9q6c
	Gox/mZa9HMjeVPyLqaOzzvz7eNl1UMnV1dvklP/3I9p+oVj8juazJz0AkaMd7s9F
	D5W8nZhc/uRDVNKLJRRdQ==
X-ME-Sender: <xms:k6LFacctHZRcR25SPnyYG6-2Og085ugVTzFbtgZ4JJSmb1Vm_pxyjQ>
    <xme:k6LFaZAbkOi9K98JcoiD7xZo_0_P7RHK0b0snKR6Dvh5y7xgr93XWVeHNQzDePXgR
    upqhOSvu1AzwajmuVxZJuXEfocwN0dBTvv3zVqNw3wOBbrmosSgqrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegopf
    hokfffucdluddtmdenucfjughrpefotggggffhvfffufevjghfsehtkedttdertdejnecu
    hfhrohhmpeflrghvihgvrhcuvfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtf
    frrghtthgvrhhnpeektdffveejhfeffeevgfefhffhuedvvdfgfffhieetleefvefgfeek
    tedvffffgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhmvgdp
    nhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnh
    hgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgt
    ohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdprhgtphhtthhope
    hlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhopegrrhhivghlrdhr
    ohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrghpuh
    hishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhoshgrlheltdes
    ghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghgghesghhmrghilh
    drtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:k6LFaUFKcKZxNTo4j08o25c0HF_9cQzQ4_XdwnFdMEk0bX4NsCj6xA>
    <xmx:k6LFaZDTFJ9nvrD2sx7cZAtayQuL4yd-Dt6Pe7IuVmYFICS9dUiKJw>
    <xmx:k6LFaY3N-fYUmW7OxyFcbUCmMGe4-b0ASjdXftHTslMpTEPjfSG7FQ>
    <xmx:k6LFaXB6Lyk9B_EX-VJgI9tps54kS5YK-AS_bsALI0siRyvt-vaRqQ>
    <xmx:lKLFaSt9bSBv8SlWNkJ26_WP26ipKaDCtqsKVhxNXkMQHbjD91A6-F8g>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C96EC1EA006B; Thu, 26 Mar 2026 17:18:11 -0400 (EDT)
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
Date: Thu, 26 Mar 2026 15:09:40 -0600
Subject: Re: [PATCH v3 00/13] This series adds support for the MediaTek MT7927 (Filogic 380) combo
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Deren Wu <deren.wu@mediatek.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Marcin FM <marcin@lgic.pl>, Cristian-Florin Radoi <radoi.chris@gmail.com>, George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>, Samu Toljamo <samu.toljamo@gmail.com>, Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>, Chapuis Dario <chapuisdario4@gmail.com>, =?utf-8?q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>, =?utf-8?b?5byg5pet5ra1?= <Loong.0x00@gmail.com>
In-Reply-To: CAGp9Lzo1XPR7=Gwi_Qr9ZC=g4ec+zGg_eUdh8yBgUdi=qiHMag@mail.gmail.com
References: 20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me CAGp9Lzo1XPR7=Gwi_Qr9ZC=g4ec+zGg_eUdh8yBgUdi=qiHMag@mail.gmail.com
Message-Id: <20260326211811.C96EC1EA006B@mailuser.phl.internal>
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-34018-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,lgic.pl,humeurlibre.fr];
	DMARC_POLICY_ALLOW(0.00)[jetm.me,quarantine];
	DKIM_TRACE(0.00)[jetm.me:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.875];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[floss@jetm.me,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,jetm.me:dkim,mailuser.phl.internal:mid]
X-Rspamd-Queue-Id: 6BA4E33BC02
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Hi Sean,

On Wed, Mar 26, 2026 Sean Wang wrote:
> This part patch 1-8 looks good overall. My only concern was a possible
> regression on mt7925, but now that the incorrect mt7925 320 MHz
> support has been fixed  in the version, this should be fine.

Thank you. Patch 5 also had a build error (is_320mhz_supported()
called is_mt7927() before it was defined in patch 6). Fixed in v4
by using mt76_chip() directly.

> I am still thinking a bit more about patches 9-11. My current
> preference is to introduce the generic layer first, and then migrate
> the mt7925 and mt7927-specific parts on top of it.
> I will handle this part on my side, since I want to carefully compare
> the vendor driver with your changes first, and make sure the mt7925
> side is solid before moving the mt7927-related changes forward. For
> the mt7927-related work, I will make sure your contribution, as well
> as the work from the other volunteers, is properly preserved when I
> carry this forward.

Understood. v4 drops patches 9-13 so you have full control over
the DMA, HW init, band_idx, and PCI device ID enablement.

Regarding your feedback on v3 patch 13 (CNM quirk) - you suggested
folding the MT792x_FW_CAP_CNM force into mt792x_get_mac80211_ops()
instead of the post-hoc memcpy. Since the PCI IDs patch is now
part of your series, would you prefer to handle the CNM fix there
as well, or should I send a standalone patch for it ahead of your
DMA/init work?

> Similar to the BT side, I would prefer to have a dedicated Linux
> firmware for mt7927 WiFi.

Noted. The driver currently requests mediatek/mt7927/ paths. Once
a dedicated firmware is available we can adjust if needed.

v4 sent with patches 1-8 + ASPM/PM disable (9 patches):
https://lore.kernel.org/linux-wireless/20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me/T/#u

Best,
Javier

