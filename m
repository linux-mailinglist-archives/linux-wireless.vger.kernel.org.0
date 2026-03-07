Return-Path: <linux-wireless+bounces-32701-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G2eCml1q2kvdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32701-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:46:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAAD229182
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01CFC31898DD
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C02D77FA;
	Sat,  7 Mar 2026 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="ES8gN2g9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KqShWAJy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BE32D640D;
	Sat,  7 Mar 2026 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843652; cv=none; b=omF15n+3P0mzmTHiJ39SwQ5SuvRP0ieAXa1CZTtDEDphOTqa7eG5I6HahRnz5Ji4QjTWYz/Jfdi2Qn6c0sxcJz0DHj1ya2KT5+mGI46rr9gtJ29s+7zDSLSnZd7Rq4GXaQWnq4ur3oJ77YqEWwX5+bDalzTUrKwYOTP51Ml5K/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843652; c=relaxed/simple;
	bh=tCHjsPhpfMH7ZEGqWpgSyLniBJo0Zn0CURYGz/GzZP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=Gj5p28btTF+eNYeZRNGBTjyVGHwSzOsi9dh/+U7mhak2Z36lnTu3OBQrp4KNIXBNx/ESE2g5fziJHaL1EPMkAdHC7/4tA3ABr9xbdwQ2svI8lk0gGclVoHl05OsDVqcwUwkY5P5jo635zOlNQTKEefHlkNhKphhxOXpdsnKB2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=ES8gN2g9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KqShWAJy; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 4D0311380AB4;
	Fri,  6 Mar 2026 19:34:10 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843650;
	 x=1772850850; bh=SPSKM3QYVOcFDvng3faMKvZZN8LqVSIHWoAzKRCTAZ8=; b=
	ES8gN2g91ZN4V71Hrkfv+G3zV3C/s6x8wCCKZZ/8cXI9fA6Zc+kBVCbOy6SGemLm
	/dhpn+dCKxTGvQ8czjSDbT+7T7rsq9/HMlT8ZdLQFcBPauy6fo4fGSK7TBegTdG8
	CVuW8UdQuEZdDgRM4eHlehUB0g8MT9QfJAATBdvb+iQkHtNXmmnDEzqNR+zDYy+F
	/7NhSwsJt/+6/nn/FDsel0hdlgXwbjL549GusQbMb1blW9LkazGMGrxn/O5sL2Kv
	SBGs0FFMX9rvsE+bwJUfL9PNPM4vjUgfdX+8+qWKvojoPkZ85NJeG6c0QuxQ3PiT
	Tzw7qimd2JacbojlLkP/pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843650; x=
	1772850850; bh=SPSKM3QYVOcFDvng3faMKvZZN8LqVSIHWoAzKRCTAZ8=; b=K
	qShWAJyDTfnCdQZnIhmG8qd+x4Xs/Ruji8ir1L7PesfNax0QFqA956/qnihcklKl
	rZxtsAnVCZQ4aGvzp7Ms9Hj8WSEVJfdKY7lyKV2A1SCrBFKqZNcx7490en7/hGlP
	b1ZmWYTA2TCQ7Rh8qGTQv9BjQm7cU87JmyUY3eDVA5OykPHSzZ/s8LpRXNqhCYFO
	47liRut97miphIicoLjbYsyRlwGEOwcdMh1V0z6iDazlUxtA6mqBUB8aGDFhEL4h
	qKEIYi3YfyNPD6W0QLIeYd4WnJuO+vB4tja2/p9F6TwXODtD3Kk21D8oOyMxm4lp
	7Fiiu0jmTDEOJtsS2512A==
X-ME-Sender: <xms:gnKraVjj9qvLEXNe7wm-VycQpsHmn2h1-CwRe_PCC9Q5-ZGdYMuhPQ>
    <xme:gnKraU2wDslORc43GI8Q_GbPzjE1gKQkmBqRHtGn3wq0JzKRkB8Knpw3pVg4TmUeA
    Y6ISqlqx_nj4o9yQIAdEWcuaho07F2EdiGrX4GipBM68AvIAwPwqfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhhoshhsse
    hjvghtmhdrmhgvpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholh
    hlrggsohhrrgdrtghomhdprhgtphhtthhopeefudelfeeifedusehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheplhhoohhnghdrtdigtddtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprghrihgvlhdrrhhoshgvnhhfvghlugdrjeehtdesghhmrghilhdrtghomhdprhgtphht
    thhopegthhgrphhuihhsuggrrhhiohegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hiohhsrghlledtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrthhthhhirghsrdgs
    ghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrughoihdrtghhrhhishesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsrghmuhdrthholhhjrghmohesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:gnKrabi4B8QkJwQw1aIDnnZwYr8-r7UudDSlO9UG07bVnGzWyCpMrg>
    <xmx:gnKrac7pL0Nj3_9TuXy0NEciQdJCsubEQl6mW_vIsQNZYp27v2BYfA>
    <xmx:gnKraYqxiS1jY_DGSwGpNTIGsbpDhZMEiQOepJE8U3hdLj7jFqIG5g>
    <xmx:gnKraaVj_XxpXEx_wXyvByKBtjPmzrx1ACtL0tzPCGc0iEhjJr9tKg>
    <xmx:gnKraXM-JSsE_odE577K_0wZCwZ4w-mnvSE1cT-5mCcx534IGDRLLnhU>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1B2BF1EA006B; Fri,  6 Mar 2026 19:34:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:33 -0600
Subject: [PATCH 14/18] wifi: mt76: mt7925: disable ASPM for MT7927 to fix
 throughput collapse
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-14-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2658; i=floss@jetm.me;
 h=from:subject:message-id; bh=tCHjsPhpfMH7ZEGqWpgSyLniBJo0Zn0CURYGz/GzZP4=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JQNGtFbWdcTB+Upou/8YMJmJGJHU4QfNdko
 PteefI72lmJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyUAAKCRC17sMLqGd3
 H36oC/41zVdsrE9+qtrN8xyBaeB/dnsrzUqhOj8nfug75FVdVifSRtQeDkJreXUiZYZal5icoL6
 XYbiTtxDACEOMEL2d/omAJ7EJXdH5BSftEhNr1+igQYE2xHjQZlYzN1ManvElv5hU0HYbWvVAdD
 INvyzqKA3ba4i9+xhsp6iQLTMuqYRH6+/Y1L83OmH4DeqmIPCcJbkAK0ZvuAJ4buaDYHfqcNeFu
 Lm2NXJCZ6L+6l35a6HseZiXr6pQl/WYEzRvEzPrmgzhgDByPovnFBykxJzrzgzghxxVIE0cEdNG
 tkXpAFrx2YP1EZOkutZc4ZXHSBq6dAyvSqutta4YKu3l6kKV6wVXoZVoOY7p9KkznlUd/+mjr8B
 bzfziceaPc0vkz+R2MAqfEGVIMvw97RRloirqSVXXIF3QKnsMpSSzZ2W3jxFGAU5WFspBiRoWAc
 nha6HcdDspsdcFxmFtdwBdRgRCZ31Ax+OUAFTCbgcmGGQIHYjoOaE82LeVlgfapHOi3xI=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: 2BAAD229182
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32701-lists,linux-wireless=lfdr.de];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lgic.pl,gmail.com,humeurlibre.fr,jetm.me];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	NEURAL_SPAM(0.00)[0.693];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[humeurlibre.fr:email,messagingengine.com:dkim,lgic.pl:email,jetm.me:dkim,jetm.me:email,jetm.me:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: add header
X-Spam: Yes

MT7927 (MT7927) exhibits severe throughput degradation when PCIe ASPM
L1 is active.  Upload throughput drops from 1+ Gbps to ~200 Mbps, and
intermittent download drops to ~69 Mbps have been observed.

The root cause is that MT7927's CONNINFRA power domain and WFDMA
register access are unreliable when the PCIe link transitions in and
out of L1 sleep state.  Unlike MT7925, MT7927 depends on CONNINFRA
being continuously accessible for CBTOP address remap, and its ROM
reinitializes WFDMA on every CLR_OWN which can race with L1
transitions.

Disable ASPM unconditionally for MT7927 at probe time using the
existing mt76_pci_disable_aspm() helper, which handles both the device
and parent bridge.  This disables L0s in addition to L1; L0s power
savings are negligible for a PCIe WLAN card and this avoids needing a
separate L1-only code path with CONFIG_PCIEASPM fallback handling.

After the disable, mt76_pci_aspm_supported() returns false so the
2-3 ms delay in __mt792xe_mcu_drv_pmctrl() is correctly skipped.
The pci_disable_link_state() call persists across suspend/resume.

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
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 6275e78777b0..e6830404c8fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -516,7 +516,14 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_pci_vec;
 
-	if (mt7925_disable_aspm)
+	/* MT7927 CONNINFRA power domain and WFDMA register access are
+	 * unreliable with PCIe L1 active, causing throughput to drop
+	 * from 1+ Gbps to ~200 Mbps.  Disable ASPM unconditionally
+	 * rather than only L1, since L0s savings are negligible for
+	 * a PCIe WLAN card and mt76_pci_disable_aspm() already
+	 * handles both device and parent bridge in one call.
+	 */
+	if (mt7925_disable_aspm || is_mt7927_hw)
 		mt76_pci_disable_aspm(pdev);
 
 	ops = mt792x_get_mac80211_ops(&pdev->dev, &mt7925_ops,

-- 
2.53.0


