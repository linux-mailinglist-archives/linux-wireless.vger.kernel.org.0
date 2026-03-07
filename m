Return-Path: <linux-wireless+bounces-32688-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF2SEm9yq2m6dAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32688-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:33:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA44229043
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 858473020A4E
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307F521ADC7;
	Sat,  7 Mar 2026 00:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="QGRkcMAf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CwX8a0ni"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08F32550CD;
	Sat,  7 Mar 2026 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843610; cv=none; b=dbRn1gV3CF0Bbl9X9noNa++dHEKwBudS3sG32MDPUivtIbt2z3gezYp/A746FoY4nQYkGxlTqd+bUcAjKW8AgGXHnE67IklcLRLaDWGuP5XwqtUSPEbGImeTmphJjI5s3qQiGtkdLygOpihYNEy9SIqRrkyi8mAfP/sEtzD9Fqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843610; c=relaxed/simple;
	bh=1AevVC/l4SWg1OI7JWyQr1m70K/Jf4abzrWW5VnF5BA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=sRYrzEzfZU47mUE5ncmrSL3qfC8RClvf/zsM6KrZh2gDj6AkDOqdttO+prANhV6UiuFKMHgn4IyZm3ZqJxFHJQIo2Lp+P4jmom7B/nXiL7jPioYBXoqwe49fg6PHnvs1t1GLmzlXLS0/kBtv+0uVtIH3IoOSzgEJ+i1z1oQlux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=QGRkcMAf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CwX8a0ni; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 2E6DB1380A0D;
	Fri,  6 Mar 2026 19:33:28 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843608;
	 x=1772850808; bh=CApY8Np2oV4416ggobGvSdXqIAdQQmVHjuoAm9JeX8c=; b=
	QGRkcMAfcY/ghrQGIvoHQmM8GjfwwdGmJmoq1FOLB1bs86wgq7LDd6Uqhe+DK1VO
	INpqtzvNaG/ZKXM3yEo4lnyVRB16Px522AQxEnVj6mQHJk0atS2fzRTC6bZSelu1
	UGvKuEbggfk3k4EwB6V2EAdXLCtuMsvU5zrRm2Jv146PUrindkF58sYqpTf+ibTp
	pn60SRFqe4bNhZVtZPfKSfkNWGUSbOXjyrN8Xb1HQQacDCgSRNeaAP615Brn7ljB
	lBJBIvo9NNrQLqpOM6nK5PLS0NuELANpm/JwmEpfjdH42AmC0ZubTC09bxzG7tad
	aK0RffcQUvS17fWrbtSDeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843608; x=
	1772850808; bh=CApY8Np2oV4416ggobGvSdXqIAdQQmVHjuoAm9JeX8c=; b=C
	wX8a0niabfUFHJFWXR0A9+KecDCUoXVd3d5qxTZzU49XQS0UUU5zYi5uWm+DvBQU
	gPU8UOXd2P8DRyg0UErtZ/CMq5iuXRnNDPIR6h43aTjF61wXwOVvHSf9oGFDJyZS
	igGFy+tsJfVxu8xbCKtTc3b1J3NtGBtMW0bX5/Ul8a4eGnfe4+MvJuneTLmztbea
	YLpYxdZWBMjLKaJW8ql14XPBtkV1Gob+GyZxbjcvyPXuFoG7hNuRgxapaFBuDGtP
	T1vZ2uLW1p6aDvgRUMy7hFtHZMCwi5i42r9XrBkTT0FEvCUdlXWz6fZentRIakxr
	WaR3/PAJIYyNqbeTfb5cA==
X-ME-Sender: <xms:WHKraQIyKKCKJWoF-8cejLuKwhHn_L3lQG__dFbFNqwzlpBiUZT5eg>
    <xme:WHKraa_qcf8GYwiCxC_QCZifo3hiVwiV1ffViy6pca7HzKkG5z-tlcoP5s-GCZsux
    2N9pfukgYgnevQx26Hr-JqpCQiMNgQxTfKdOoBNvpg3Yl3okqCZC74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:WHKraYIiEz3BUqbsHFLg2TkRiZjeUMS-P-w0RJaEfPHAydxaRPEEfg>
    <xmx:WHKradBwT8Dxn5gZ15ITggGhLLZdoTIFjIGOiwfhwqUi3Ux1WPFbIg>
    <xmx:WHKraWT5GfnIhcS3tpYPn5JmLfsER3ihUkEwLGyF1R1IQ5az0DManw>
    <xmx:WHKraXfX8RJzyVkv8ti0sKcBj3Gm4ZWP1rnnB3Hc1nweEuD_WQ0nxA>
    <xmx:WHKracUf5B8CB8vKtI9Zx6PHdAO97cEVMUAcQtEDnEsdpnU5jiXu1O8n>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 058661EA006B; Fri,  6 Mar 2026 19:33:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:20 -0600
Subject: [PATCH 01/18] wifi: mt76: mt7925: add MT7927 chip ID helpers
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-1-c77e7445511d@jetm.me>
To: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Deren Wu <deren.wu@mediatek.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Marcin FM <marcin@lgic.pl>,
 Cristian-Florin Radoi <radoi.chris@gmail.com>,
 George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>,
 Samu Toljamo <samu.toljamo@gmail.com>,
 Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
 Chapuis Dario <chapuisdario4@gmail.com>,
 =?utf-8?q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>,
 =?utf-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>,
 Javier Tia <floss@jetm.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809; i=floss@jetm.me;
 h=from:subject:message-id; bh=1AevVC/l4SWg1OI7JWyQr1m70K/Jf4abzrWW5VnF5BA=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JPxiLy9/rnyv8/hU2nOrG1NZ1F8LD/n7PFx
 Bh53bFgIQSJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyTwAKCRC17sMLqGd3
 H3uvC/43mvQr4QalBZx9Pbd2/1hQVJJQ5Tl5fu0Ffa0NvmJm5IPtXgPaLXGHNFON4NtV47j0A1O
 VwFB5TLFLuHu+au5zpXARB+apbqjm6yxIcfKqFFUAP+cll7hFbFBLcrQebAJG+6C1NagR0wMg9V
 KsT+GAtJ2zqJe8xnzh/EeGMlMZpPmQqtnTgLui1AYrYBEWMlkxhh2ceWDMj+77UWf+MQNU0Zi6Q
 uMCthEI/VFEeFbQ62YUYh9Aywdbc94pg411Z1miGUPChPuLDOs1UFo2UU6SyE68esGjHDiKqpRQ
 L6d0x2YHZSlVSczopkhJ6DmUe8NlibVMDhNgu0anUMkNJYMc3dogNQfg2adAGInt9oSOSxupd40
 yMKE0nVAgh7cw9T3km/jJJdSg43bPkiZAcfqYx+N5pebffAdTgSahjLfaL7z27Y4U7WN3bq9VkD
 88Vrv+THzz6MwHiZsT6Q/3TwGmkSWzFXkTFfQA+fEKRhhvcRcpKNYe73/xxS0CNpd7wGo=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: ACA44229043
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-32688-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lgic.pl,gmail.com,humeurlibre.fr,jetm.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[floss@jetm.me,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[jetm.me:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,jetm.me:dkim,jetm.me:email,jetm.me:mid,lgic.pl:email]
X-Rspamd-Action: no action

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
index 813d61bffc2c..bfd5b05c2b20 100644
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
 
 static inline bool is_mt7920(struct mt76_dev *dev)
@@ -272,6 +277,7 @@ static inline bool is_mt76_fw_txp(struct mt76_dev *dev)
 	case 0x7920:
 	case 0x7922:
 	case 0x7925:
+	case 0x7927:
 	case 0x7663:
 	case 0x7622:
 		return false;

-- 
2.53.0


