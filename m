Return-Path: <linux-wireless+bounces-34014-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xoK0FPSjxWnBAQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34014-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:24:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 054EB33BD12
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0D3130525C3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 21:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900C3AE190;
	Thu, 26 Mar 2026 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="LrZvBOJF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbXpuAMs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A53ACA4E;
	Thu, 26 Mar 2026 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559560; cv=none; b=mGwLFej1eQCFCQ7R97ENoQ82yjKWfc8POReoGZIz2T+efYlV9NHJSmhgaE+MA3sOcVA5eCPCYlorpB29pXD7NdpTKopXQbh7KjduCbArNkqn+RS3bc9dhQDLvigQIOfYhfL/2HcCf3VbQ70VFSK0pobajNRc2Bh0Qvbvot0ueYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559560; c=relaxed/simple;
	bh=9vX1+HCKHr0k2DqRknzuHVDKBxcMWdBFaonJ+C4rfPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=VuCQmbMf98FE6Uo4Jg474aoR8Yx4WFzz2zl96S8Yy9ZtyNzCi7MLu+SzDbWQDs9j3RDazOijPivu0H4yKgKJv8shcMefid6HkGAOCn0NK2X/AZPd8u0Ew8GwMPp2a59NkXQvvlP4SwMF5lmTaFX5TWVTtiihLBzqowLKOvPXP/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=LrZvBOJF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbXpuAMs; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id C1FCB1380179;
	Thu, 26 Mar 2026 17:12:38 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 17:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774559558;
	 x=1774566758; bh=6Jm/52oKcoIIFQozJ/h7Muhk36ukRaDKMKe1v8oJZSc=; b=
	LrZvBOJFtWtyMLrRnpySZa23FcZF+/iNhYX/F1dhvhUNYz/JeyyODJmirUf2xTI+
	K5mfHxuddq64XqSOE45xjSBlzanZ4E4xodbjnYrjDsB1CdEo5EyfH9ZSgO9Oqrmg
	lRVX4MMSAUGn6Vw7Uf1PJ9O5kugV/GKMwxtAnGCs8G01kuZsLjeu6oI/nvUQzJb5
	tNbKrdJl6tUfqBt79w0E+/YDAlD76rem0vU/PpCJbUxpbDXqBe6G8Q/GNpwG78SE
	S4tLfpjFZePJmCZIEeDlQM57Lc45/DiZmjaReW5oeQIsCO+4NmNURy7s/l97iZ3Y
	3ZrJ8wDHtSQrAphkAIEswQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774559558; x=
	1774566758; bh=6Jm/52oKcoIIFQozJ/h7Muhk36ukRaDKMKe1v8oJZSc=; b=I
	bXpuAMs8LrNRj9QxfVjDeCFRN8G7cVkhaHx8KfzrHy+3gS3tjlrPJCx/58clhShH
	yfpn2wHpDeAzDWk3IwaxaIzAvWSSH+aesKmOuIT9w3V2WWMC+QC5WFbYpO7nE099
	gJR58MJqM0Aoz/afjNQso6PFmCXHTmXCep8rLvknmHWbaHH1/4y28MKVwDY4YnwA
	H+uqMu6xn9bIUDR1gyOaQC+uXZ0DoI2klWmPnIEJdSMH9pCGYHBhK42zIMRYZfqt
	voQGq+KFMNul1ru1iTnokg6KlTS/0CwM2M3+bpYddqxNuHySFPd/qJqKvtIUjqIa
	2k5+FlRMzZ6zX7soja76A==
X-ME-Sender: <xms:RqHFaUhFfzvVYbmE_q4x7cEcqwMK6jEPW4DngYDJpvCu98xr8wJwQQ>
    <xme:RqHFaX0DXterFkPVMxT3crSknTYk7CjCyu0vLdYcbPmmcjU8y1KCTYkWMSC2km9kg
    I-3O-NV9lbRPwem8DqKvEjnNvt-WdbK7O4Z8sR-ZZyr4iku_I72OHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:RqHFaXTAne4m2jrN5GLgRoOg6bTYqCojy5rkDW2KKqxjF6gmOhDqjA>
    <xmx:RqHFaV-AO20_x-5X6Ri-YNkBxPsOQcKjvuCIYF294Q7eBB4x19BN3Q>
    <xmx:RqHFaRV79qiziZ1PQNHbjOlzAHeKeG76DiEtOksUoCzKBnHm4PrBtw>
    <xmx:RqHFaTNNrCa9fMsmORopKU1aFSuaoTkQ2-Go-PJHLRfyT8qXzIGafg>
    <xmx:RqHFaYzXkgZyFedSpWLNn9ISFEypouPamMTTSprI5pNyW2cp3g1PSEkC>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 95BE71EA006B; Thu, 26 Mar 2026 17:12:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 15:12:30 -0600
Subject: [PATCH v4 6/9] wifi: mt76: mt7925: add MT7927 chip ID helpers
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-mt7927-wifi-support-v4-v4-6-8ab465addcfe@jetm.me>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
 Deren Wu <deren.wu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Marcin FM <marcin@lgic.pl>, Cristian-Florin Radoi <radoi.chris@gmail.com>,
 George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>,
 Samu Toljamo <samu.toljamo@gmail.com>,
 Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
 Chapuis Dario <chapuisdario4@gmail.com>,
 =?utf-8?q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>,
 =?utf-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=floss@jetm.me;
 h=from:subject:message-id; bh=9vX1+HCKHr0k2DqRknzuHVDKBxcMWdBFaonJ+C4rfPk=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxaE4csdi7NGlGkgmzmbvvy5NLIyk+EFk7ZBMJ
 Luxur9lt1SJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWhOAAKCRC17sMLqGd3
 HyaZDACX+4UlGmEHINO9tW7mBzz3mq4T+pI8ONBRbjYvL/BaOjge29LD7smG1+CyHq295gBGmi5
 /2klrLLSuMT4JPcppRL+Zom/10oeUgLij997Ib4RYAxLJJD4LO+fWkPg0YBusuHbUc/Q9mZE4kk
 CDDjzwcOtVifQIW8Y7D6YkzE52SziV1o6EDNHYpfPgGq01JNaOa8x7bmlnsMPQs0pQeCR+LIyqE
 OnMLZt9YM6xIp4xEJsGvNXHOjCfjJGX2ebhI5kLq6oeDSD2OD8zxXXJvxfby5YvM/yMQQUwpKRG
 hwA38+hoPGpzZKbxReV3lbjJAbZj9PC4i5ln0jqhTNPLRNbdRoyqF8uz3caKUCb93FVsiJq44MK
 gAeQDhfahu901gQnX+16dyZqPeS/ic3WWL3m4m0h4/MvyEHd9vLggjXsyjFMdndkrIGs+swlh5X
 oeovBln4LmR7i3p6O05dA9VpDCCLf7KwpjlSV13W5yOMB6RNvvDTQekuh3s1BI/0LmCNQ=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
References: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34014-lists,linux-wireless=lfdr.de];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lgic.pl,gmail.com,humeurlibre.fr];
	DMARC_POLICY_ALLOW(0.00)[jetm.me,quarantine];
	DKIM_TRACE(0.00)[jetm.me:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[floss@jetm.me,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	NEURAL_SPAM(0.00)[0.836];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,humeurlibre.fr:email,lgic.pl:email,jetm.me:dkim,jetm.me:email,jetm.me:mid]
X-Rspamd-Queue-Id: 054EB33BD12
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

The MediaTek MT7927 (Filogic 380) combo chip uses MT7927 WiFi silicon
that is architecturally compatible with MT7925. Extend is_mt7925() to
match chip ID 0x7927, and add is_mt7927() for code paths that need
MT7927-specific handling.

Also add 0x7927 to is_mt76_fw_txp() to match MT7925's TXP format.

Tested-by: Marcin FM <marcin@lgic.pl>
Tested-by: Cristian-Florin Radoi <radoi.chris@gmail.com>
Tested-by: George Salukvadze <giosal90@gmail.com>
Tested-by: Evgeny Kapusta <3193631@gmail.com>
Tested-by: Samu Toljamo <samu.toljamo@gmail.com>
Tested-by: Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>
Tested-by: Chapuis Dario <chapuisdario4@gmail.com>
Tested-by: Thibaut François <tibo@humeurlibre.fr>
Tested-by: 张旭涵 <Loong.0x00@gmail.com>
Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 393a7952f86b..4a63ef4e5c34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -174,7 +174,12 @@ extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
 static inline bool is_mt7925(struct mt76_dev *dev)
 {
-	return mt76_chip(dev) == 0x7925;
+	return mt76_chip(dev) == 0x7925 || mt76_chip(dev) == 0x7927;
+}
+
+static inline bool is_mt7927(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7927;
 }
 
 static inline bool is_320mhz_supported(struct mt76_dev *dev)
@@ -277,6 +282,7 @@ static inline bool is_mt76_fw_txp(struct mt76_dev *dev)
 	case 0x7920:
 	case 0x7922:
 	case 0x7925:
+	case 0x7927:
 	case 0x7663:
 	case 0x7622:
 		return false;

-- 
2.53.0


