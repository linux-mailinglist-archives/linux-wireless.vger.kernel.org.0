Return-Path: <linux-wireless+bounces-11250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793D494DBE9
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 11:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8541F21D38
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B8214C586;
	Sat, 10 Aug 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="DVrKuxq0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B5Pu48Uf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E65145323
	for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723281478; cv=none; b=HpflFlTbp1wuUVxwWIn1wsz/TlauWzx2mDeu7Jf9WlAbaCZupSXP78YRp6/NgAFVRc0StZ99dpWmLE52KR4zdbzWzOc5ZaNul9WWVZjgMWyJC8KFJ/WVilfXHSKJv8mWsojf1/ejCeI29V0J2Z92RqCkGr/fot8tPszZc8hZHWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723281478; c=relaxed/simple;
	bh=mpVn6hSvCBO1sk5odNTAgq3bKxjAVo5Fn2GckBZi1ks=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cW+6cC9fwlX6oBQM8FaogUin/PNsv2v178s6tluh3BlTcicVaAmStZmA35ph7cRW49FI1XAKN1t3E2ykR5EoiCm/gsa6r24SsDli/ZeFP0HF9fqE+htIrv2vKeyX/mhgTlXJj9pn63KWNDOUjvgSlVVoO5CSe1LvoR2tRYDCDto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=DVrKuxq0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B5Pu48Uf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 92C9B1151AD8;
	Sat, 10 Aug 2024 05:17:55 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Sat, 10 Aug 2024 05:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723281475;
	 x=1723367875; bh=mpVn6hSvCBO1sk5odNTAgq3bKxjAVo5Fn2GckBZi1ks=; b=
	DVrKuxq02dczEsz1vx+FK+kZ1L7v73xe9MwXOXGqfh0HDbN9Jrn9HxNoxJpMCIxd
	WXXqmfCifaR8u+fDX6JNFuyg0uOExd59ljkZv8aPE7+L4wqIjAlOU9ZgNJM8dqa3
	QNBQNFxUoxRHL9k8X5oGmREd0AV28zZB0tQlKjJNg14VzhbhE8Uh6OETzcOdnv/V
	H0xtfkac2Ty4E4OYpVaEPDeX2cRoejBMCB4X8P51TjcF1lpD72K4iD/gh1llsfa3
	t87ZE6OIM6H81OunSs00z6aSnRAMwVXW99NIWbx1jHxLUcCYDvnFx4L0DHP+/sKt
	oobS/rzD780HLvodyr8pLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723281475; x=
	1723367875; bh=mpVn6hSvCBO1sk5odNTAgq3bKxjAVo5Fn2GckBZi1ks=; b=B
	5Pu48UfxSVp/l/rLwcDeowU0GnWRnZtZryPTCWNYNNCEzmlY7LTx4PMNNnnF8vet
	/HhC6kk7vtzYDjt4CFi1GVs+hPA/HvuQ2lO9SVmZ0wj7L7RlsyUuju7jHjs35ndL
	hy03Ck14FSD6Aj1sV5e5W/WdgR1uAVmHaPau7/v4kylZ7dKRp9mHNaWRRLR6Emzq
	ZRoQBArFeVp/qIPc524JEKQGHYugfJ0BDoNvNS8EolLYypMa4oKX35HyNwlq1Txv
	mbRhnfS1iqnRiqp8aewkU9HGdMc6aMbDwQZOZ0bkljfAqdO4nxOH5SvkLb6zRw1s
	x+H5HYBHQilNVhC3aneRA==
X-ME-Sender: <xms:QzC3ZnLD5p1p2NBTWnWEZkNXNaVGlnOr1CGZluk7fOTMBIIC6LQ4iw>
    <xme:QzC3ZrK_59_jkMZf4GCJEUWd4uTdk2OyNtGNPcyJDfKiwthHAN1Uf0daPKPrX8PyG
    46RWFuWv63Zvo2t8kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleeigddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdflrghnnhgvucfirhhunhgruhdfuceojhesjhgrnhhnrghurdhnvghtqe
    enucggtffrrghtthgvrhhnpeffudejkefgfeeivdejteelieelgeduvdfgtefgveegkeeh
    udelgeehgeetffevtdenucffohhmrghinheprhgvughhrghtrdgtohhmpdifuddrfhhipd
    hkvghrnhgvlhdrohhrghdpfhgvughorhgrphhrohhjvggtthdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnh
    gvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    rghrvghnugdrvhgrnhhsphhrihgvlhessghrohgruggtohhmrdgtohhmpdhrtghpthhtoh
    epvhhinhgrhigrkhdrhigruggrfigrugessghrohgruggtohhmrdgtohhmpdhrtghpthht
    ohephhhoshhtrghpsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    eprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehgrghrghgr
    ughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepmhgrrhgtrghnsehmrghrtg
    grnhdrshhtpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhesfidurdhfih
X-ME-Proxy: <xmx:QzC3ZvviXpcT1eXF1ENNkJ-iBURExhXBvNymXQNLl6mtCEOHTZDuEw>
    <xmx:QzC3ZgaTm-HaTvedWRRHHI2oYcRyqgBbF8xFB7ptr0IYmTNk72-7rw>
    <xmx:QzC3ZubBIM9yKMDOZMSnkm7mvf6JA4vbdXes0SUrqw-hiWR91zgDiA>
    <xmx:QzC3ZkDPFVS-vDsONXTmNlHDz10EbsWlcTJzJo9ppQUGn8jqxcV41A>
    <xmx:QzC3Zm6aaDi4RtM210qZaI_VmHVZDw2msDBikdhvzz97r3E2OsrtjSdN>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1055C19C0079; Sat, 10 Aug 2024 05:17:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 10 Aug 2024 11:17:33 +0200
From: "Janne Grunau" <j@jannau.net>
To: "Jouni Malinen" <j@w1.fi>
Cc: hostap@lists.infradead.org,
 "Vinayak Yadawad" <vinayak.yadawad@broadcom.com>,
 "Aditya Garg" <gargaditya08@live.com>,
 "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
 "Hector Martin" <marcan@marcan.st>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 asahi@lists.linux.dev
Message-Id: <d82c88a2-77f7-4308-97fa-c5b4446e2cf5@app.fastmail.com>
In-Reply-To: <ZrclLHJ63RxnG/B3@w1.fi>
References: <92fe4dd4-21a4-4559-8441-32ef86672de6@app.fastmail.com>
 <ZrclLHJ63RxnG/B3@w1.fi>
Subject: Re: wpa_supplicant 2.11 breaks WPA2-PSK / WPA3-SAE authentication on Linux'
 brcmfmac
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hej,

On Sat, Aug 10, 2024, at 10:30, Jouni Malinen wrote:
> On Sun, Aug 04, 2024 at 02:23:56PM +0200, Janne Grunau wrote:
>> wpa_supplicant 2.11 on Linux's 6.9.y / 6.10.y brcmfmac driver runs in
>> authentication timeouts with WPA2-PSK and WPA3-SAE. This was reported
>> with Apple silicon devices using Fedora Asahi remix with a patched
>> driver as well as other devices without additional brcmfmac patches.
>> See https://bugzilla.redhat.com/show_bug.cgi?id=2302577 for some
>> reports.
>>
>> I've bisected this to
>> https://w1.fi/cgit/hostap/commit/?id=41638606054a09867fe3f9a2b5523aa4678cbfa5
>> "Mark authorization completed on driver indication during 4-way HS
>> offload". Reverting this commit on top of hostap_2_11 properly
>> authenticates the connections. Looking at that change and the code it
>> looks clearly broken to to me. As far as I can see is
>> `assoc_info.authorized` for the nl80211 driver only set when
>> QCA_WLAN_VENDOR_ATTR_ROAM_AUTH_AUTHORIZED is set (in main, I did not
>> check older revisions). This doesn't seem appropriate to expect this
>> on chipsets from different vendors.
>
> This commit is from Broadcom to fix some race conditions with the 4-
> way handshake offload which I'm assuming is for a Broadcom driver..
> Whether that is for brcmfmac is unknown to me, though.
>
> It looks like the goal here was to move completion of the connection
> from the association event to EVENT_PORT_AUTHORIZED, i.e., the
> NL80211_CMD_PORT_AUTHORIZED event from the driver. Is that event not
> delivered by brcmfmac? I did not see any full wpa_supplicant debug
> logs for these issues based on a quick look, so I could not check
> that myself.

The following place in brcmf_bss_roaming_done() is the only place where
NL80211_CMD_PORT_AUTHORIZED event is posted.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c#n6402

In my initial analysis I missed that the NL80211_CMD_PORT_AUTHORIZED is
delivered directly to wpa_supplicant.

>> A revert looks to me like a possible/proper fix. I can send that
>> later if no alternative materializes.
>
> I'm inclined to revert this if it is indeed the case that
> NL80211_CMD_PORT_AUTHORIZED is not delivered reliably by the upstream
> driver and this commit was tested only with some non-upstream
> versions.

I intend extend the upstream kernel driver to post
NL80211_CMD_PORT_AUTHORIZED after successful connection with
authentication offload. I expect that the change will be accepted for
the stable kernel. Infineon/Cypress have non-upstream patches for the
brcmfmac driver which implement it already.

A revert in wpa_supplicant might be still appropriate until exteded
kernel drivers are deployed. The wpa_supplicant Fedora package carries
the revert as patch:
https://src.fedoraproject.org/rpms/wpa_supplicant/c/c2eac195adadd2c48b04f8752cc46b12a351e69c

thanks,
Janne

