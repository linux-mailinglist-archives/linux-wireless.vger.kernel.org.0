Return-Path: <linux-wireless+bounces-10901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDC8946E9C
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 14:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A204F2815E9
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 12:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D7F381B8;
	Sun,  4 Aug 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="LH05jqf/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QF7WWZbN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D27481D1
	for <linux-wireless@vger.kernel.org>; Sun,  4 Aug 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774259; cv=none; b=D98e8cIS8+gRsdSAaC0l3OHSDCDI5ZdGwOMTKvUuvbdM3SiUliljEbd8a43Sl1eEacMNS9zcJK8tmONRCBjnDIa4kJo5/IW7Fjj2ujXcW5y8MAjF9Ss2RGxuBwCENK5FBPObzT5BA624VMKyasSDJOqMvqxLe+9SQYOApr0g9Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774259; c=relaxed/simple;
	bh=/8vPRURRgMyU8ZdXUZCXtVYzd9RIwywFDiONXk6refc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=Ejn62SLO9kS5FkRe3tle0YiqOp493JpYwUN1lUxLIq/qPRAdvsxnmlxtr5oOPlMHrdeMdWEuliYVC7CCYaKPH3fGY3A8uRZ8C/LBZUSLa8oncqMijavHFp9ZxOIwB4cO2OREre6tyuSquLlDwwpB7JG9fWNucrZ8LjEGlEHhiCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=LH05jqf/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QF7WWZbN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BAF6A114E9D5;
	Sun,  4 Aug 2024 08:24:16 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Sun, 04 Aug 2024 08:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1722774256; x=1722860656; bh=/8
	vPRURRgMyU8ZdXUZCXtVYzd9RIwywFDiONXk6refc=; b=LH05jqf/3VvseFEL+3
	uCkTWBwp+jJimF8o0nFTAxxdTxqdEu7C5sKosQKlVHCRyu6QCTocOoa8ZEEAH7tR
	SLVI0j9JgMH+1lPOGxkZ2SspLTVXFpLNbQNK9DSpqZdomoxErwRHSEkIaGhZTfyC
	8p7e74mPgi7DV4uY5T9WLfyAwbfUv6+NC5uEuIBGZE81piC7NPSzws67PuGs776K
	W1x1pf67McwEYcK6bNqIM4sDgcO50LqrJy7GiL4wh5vGQXeZuJXpl0I2uWXWwZhW
	5q/e1Tn6/8tCUXivPXQQajf5iWZCr3IiYZs0T4r/rx1TxUoiVhtWkana5Rr7h0Oh
	SAYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1722774256; x=1722860656; bh=/8vPRURRgMyU8
	ZdXUZCXtVYzd9RIwywFDiONXk6refc=; b=QF7WWZbNH0m6lNduuqPxXcRka4owh
	toRoPKMVDiy+ni99D41KaEwYCVyi9+ROQjoOfTbIOMQ3mwJE7zwfKsI0Hx1yyKfi
	IEpTtxhPG4GJpM3xt5mcJ5YJoleEDIKohUpQcDapgi1SV/9vMh12DK6dcnRiEhaZ
	q499wJi+6doRPIznVJvcGx8IYGgNTNpkDsw4b7dAmQbaJKvQOU1bG1PsRUmsrxh1
	y/DXiAUuT1kKIK3eSBmcJGMqrqWRvIt7ZqqGMlfr4fxUgcWu/SjIxrdJCu3Hxlr2
	4fJFuThHrTnIzzHmREvIBjJl22Oy2vBSeL1BFncwL3pGru2/OzAXPwW7A==
X-ME-Sender: <xms:8HKvZqkVm-_3wEKAkyDFBMUenXVhjzxZ988R7MNfMDksB05GPeD31g>
    <xme:8HKvZh0rQCh-0tVNiMLuwlA-FNtXwWt1k7JC_uhql_YIzWcbRj1ofUahf_HRo0K36
    6LLdz1C9K2NENSszjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkufgtgfesthejredtredttdenucfhrhhomhepfdflrghnnhgv
    ucfirhhunhgruhdfuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpe
    ejteffgeeugeeggedtudekjeevuedvkedvfedvgfehieeltefhfeeigfekveeggeenucff
    ohhmrghinheprhgvughhrghtrdgtohhmpdifuddrfhhinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggp
    rhgtphhtthhopedt
X-ME-Proxy: <xmx:8HKvZorBKqYix0VkSqDCG66Yk3DG8UeEapB5mwYenBZESIH3E8Kwlw>
    <xmx:8HKvZunPMYaqvPIW1Odl51oTOyqQsPfURrAIrI0PZp4j1g0A29WnQQ>
    <xmx:8HKvZo2gENlAE3t7U8VQ12_G_pSe7I8T904VevXh-GoHbRtWVMlVQw>
    <xmx:8HKvZlumNSWGYlmCD4uDJf2Wa5gz6gRlzgGQZY_iXbkDxlSxhSv6fA>
    <xmx:8HKvZio3jeh1GdctDBZf-JzcJudfB-FmyM6_vJC5nl78WqPoA6jCaJC_>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3BEE819C0079; Sun,  4 Aug 2024 08:24:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 04 Aug 2024 14:23:56 +0200
From: "Janne Grunau" <j@jannau.net>
To: hostap@lists.infradead.org,
 "Vinayak Yadawad" <vinayak.yadawad@broadcom.com>
Cc: "Aditya Garg" <gargaditya08@live.com>,
 "Arend Van Spriel" <arend.vanspriel@broadcom.com>,
 "Hector Martin" <marcan@marcan.st>, linux-wireless@vger.kernel.org,
 linux-wireless@vger.kernel.org, asahi@lists.linux.dev
Message-Id: <92fe4dd4-21a4-4559-8441-32ef86672de6@app.fastmail.com>
Subject: wpa_supplicant 2.11 breaks WPA2-PSK / WPA3-SAE authentication on Linux'
 brcmfmac
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hej,

wpa_supplicant 2.11 on Linux's 6.9.y / 6.10.y brcmfmac driver runs in
authentication timeouts with WPA2-PSK and WPA3-SAE. This was reported
with Apple silicon devices using Fedora Asahi remix with a patched
driver as well as other devices without additional brcmfmac patches. See
https://bugzilla.redhat.com/show_bug.cgi?id=2302577 for some reports.

I've bisected this to
https://w1.fi/cgit/hostap/commit/?id=41638606054a09867fe3f9a2b5523aa4678cbfa5
"Mark authorization completed on driver indication during 4-way HS
offload". Reverting this commit on top of hostap_2_11 properly
authenticates the connections. Looking at that change and the code it
looks clearly broken to to me. As far as I can see is
`assoc_info.authorized` for the nl80211 driver only set when
QCA_WLAN_VENDOR_ATTR_ROAM_AUTH_AUTHORIZED is set (in main, I did not
check older revisions). This doesn't seem appropriate to expect this on
chipsets from different vendors.

A revert looks to me like a possible/proper fix. I can send that later
if no alternative materializes.

Thanks and best regards,
Janne

