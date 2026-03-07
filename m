Return-Path: <linux-wireless+bounces-32696-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECADGMlyq2m6dAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32696-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:35:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D0C229080
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B08C30314CE
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE21EB5E1;
	Sat,  7 Mar 2026 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="i5tfdGs/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2z2NEk7R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD893279798;
	Sat,  7 Mar 2026 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843640; cv=none; b=mpN3Vh1qLPm//MWtOzbAPmyffPSRSiWjPqhw6rxI3qP+ktaTg5LdeS6nylk8WBuM0CmGiY4tE56IBVOW7YmZyKo+MniI/NI7suSoZ5uvO+YVFpcn2HPkO+KFDEhbKF7stK08lWkivLaovQRv/YJbXIhCmSaBQM6D9Rqd1sXmd9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843640; c=relaxed/simple;
	bh=0y1/cfyMHHVKeRaAcDWZr6+p8GqZVWD4BkhOC6GENCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=r7PMMN83C0xgFtJU1jOC+IGOin6l8dSB7VNJwxqrcS1Uai5mcRKVC1a49XZSblBpjrUROLsM6PIBpNNDTxb/t4Bgfhy1PdLxTQ9zsmlAbp6t/uF6HIAY/ifm2gtNgRi6FsgVF/6gjBkHhWzk3Qb7UsSVPhsewRmfvVOqdchOYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=i5tfdGs/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2z2NEk7R; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 222EC1380A43;
	Fri,  6 Mar 2026 19:33:54 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843634;
	 x=1772850834; bh=O/FZ8St7B3QoQV6NVViBDN3fl77WhO5At5mZqNI+Gtw=; b=
	i5tfdGs/brz/xneND5XXws9E40wAj4trx/plR4iFCF9TXO4Hs1BEopFNjxBSYX7M
	S//EgeOusPKyqmwVAxiRap/BYKTmrudk7AMyxtsm+yLlBzF9l/OWzGFUu6TKG77g
	2GmQ8J+U2gwZ3Va7sud6SOd4YevhuKvDlroKt2etm103NNLs0krF2B4C22J2RnXh
	6vJtxiiGbKEMYUKBZUXtVQkKPqJb4XS3XLxtqqaEBm8cqAtLmsUmmQEZYhmR5bqB
	b3N3I4+0b0bxW9OrcG8j22Fh22DVwA8voJdfCS0wtFILQgSZIvZ1CEbk5+yj4B+a
	91tzPzFrIg46e9TVmR50nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843634; x=
	1772850834; bh=O/FZ8St7B3QoQV6NVViBDN3fl77WhO5At5mZqNI+Gtw=; b=2
	z2NEk7RFfyGiKyGHkkN0h0KTccbTc5+p5lABrEPgJaAcvUCmixPkAfHwTxX32596
	g9cvw9ksWHZHllfGxjwVfXF7k1z4QnEO0poFkjbJa39TwzJAJM+lmor+gl7AIfSH
	GerLMGX/ixcvD1hsO/HHk7jBCn19e7GJDOvSrRjzzzi67YtNj6EwOOvsaZKyRt90
	Pyqs1aYlKmO9TBXSt9ZfJIhs6vMTzQ3VDh6MZ3AN6cG0fu17Y72ekPi59FM9la4V
	ydG4GLqvtybCeXSCVLPvS4ThHJ8cGL3QB5p5Tzwbr0j309ppeZwNEdQtnfgu8n85
	moiiR00w42YNn66LvoLzA==
X-ME-Sender: <xms:cnKraYYyl3MZflsv_GMzKArQ4EH64Uml7FnvDp5r3qCQEKLriI4eJw>
    <xme:cnKraeO627GjbpkUHF86jhsEGpfNyH2RTyNEHttmbtF4JrWDInOECmoHw-V3FL1il
    K6yOELbi_AT0kiLAONxGV4aO1WotPo71DG5Ynvwg8do0B6cF9j6xZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepkeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:cnKraUR9K4vGF_jNq_eJC83xeG69tC2YDu77bweSipFv04S8ligwEw>
    <xmx:cnKrach-6x6GbilOHmD80NpT7-LzpbZ2-BSGXaN8ZOURj5uN1MbymQ>
    <xmx:cnKraQt7LxvcSrh5_kMVwF19dwPdZS2bFLCC2Cd2bMeiAeokWpNHIA>
    <xmx:cnKraeyeL9BEcuQAihGyJ5UzoB9sGeQZSBWL5NvGq-W4y5fOd8jS0w>
    <xmx:cnKraUmLj7UEVzd2q8ztdQEsokF_aWVeFsn-Ot4JmJbn2aTRdNU03uW1>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EF95B1EA006B; Fri,  6 Mar 2026 19:33:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:28 -0600
Subject: [PATCH 09/18] wifi: mt76: mt7925: populate EHT 320MHz MCS map in
 sta_rec
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-9-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=floss@jetm.me;
 h=from:subject:message-id; bh=0y1/cfyMHHVKeRaAcDWZr6+p8GqZVWD4BkhOC6GENCE=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JPaqv7C247DGQfPMY5Ss9FIiRnQ8rMHoxoe
 ZPvocWSMSGJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyTwAKCRC17sMLqGd3
 HyDWDACh91WMXw+HeP56hkbaGH6qbFdptP25eSsiGWa8JJ4jj78edEiA8CAJnNkY+h1ZAIiRcGL
 mb0U3K3DSbowj/BpZTDZP74zLqOtVlOVdlU5j/MAbPE0xg+1eGJl12eGhYyu2AfTwuwAHafWogZ
 0uxJgGi0aSa87YN4LRUKhAZ2ATEIpTaCXPn7h9CbwKGvooQGV7AB3+FAXz95kx7/ZYxrjav6dvi
 FcP4v6edIgpUqz2zPnY8aZxu6DijZl4pRSd/ccIHASfR9ME1EhNshgZrMhk7gb2b1Ov2PxQo+W+
 +SDA7jt838Wk/PaPk65+QYxGoGZcuUvk+uMt+Z/lS4me+1NwnxpTiI/eVucUbre1rErktZKtV4+
 9zlkaQD8WJnfER+o4sn7sJCeu0y4o2SayVWNmZUkxVIPDrdGDr5StgaRrVTPLHpawORLbzeMkxf
 S52QxKzg1MmlHjU43jTOctXW+u2rb3qMkkkwi+Ikhpx8EcC89BDXcGSOKmqDlXVE/D/sE=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: 64D0C229080
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-32696-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,messagingengine.com:dkim,humeurlibre.fr:email,jetm.me:dkim,jetm.me:email,jetm.me:mid,lgic.pl:email]
X-Rspamd-Action: no action

The sta_rec_eht structure has a mcs_map_bw320 field, and the channel
width mapping includes NL80211_CHAN_WIDTH_320, but the 320MHz MCS/NSS
map was never copied from the station's EHT capabilities to the MCU TLV.
This prevents negotiation of 320MHz channel width even when both the
hardware and firmware advertise support for it.

Add the missing memcpy for the 320MHz MCS map, matching the existing
pattern for BW20, BW80, and BW160.

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
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cf0fdea45cf7..8b5ffb240d52 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1683,6 +1683,7 @@ mt7925_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
 		memcpy(eht->mcs_map_bw20, &mcs_map->only_20mhz, sizeof(eht->mcs_map_bw20));
 	memcpy(eht->mcs_map_bw80, &mcs_map->bw._80, sizeof(eht->mcs_map_bw80));
 	memcpy(eht->mcs_map_bw160, &mcs_map->bw._160, sizeof(eht->mcs_map_bw160));
+	memcpy(eht->mcs_map_bw320, &mcs_map->bw._320, sizeof(eht->mcs_map_bw320));
 }
 
 static void

-- 
2.53.0


