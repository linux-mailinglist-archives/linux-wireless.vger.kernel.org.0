Return-Path: <linux-wireless+bounces-33892-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BjPEbldxGn1ygQAu9opvQ
	(envelope-from <linux-wireless+bounces-33892-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:12:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9449D32CCBE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45AE53028F47
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E039022D;
	Wed, 25 Mar 2026 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="nllXHRZF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sLY7tC4l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565C8358376;
	Wed, 25 Mar 2026 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476663; cv=none; b=ihjFAyUWCr1sOW9sn/jFza67wKsLYbk254b13xPp+n3mMFTelfYDKfEMumyg+FtRwXJ/zNeac+olOe6SY8S4zR4iAhuoDEJ2yekETt0MU/y4kmm0XE0cvCYNTUYPOYODh4YkNavdz8UcFEqejoCM26E8W7RNKAmkWsg8vggP4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476663; c=relaxed/simple;
	bh=b6wuUqMM9LRMdvCkKcW9uEToGwJgCsTkr6DKPTvA7cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=tnISsIBw1G/rnJb8PJuQOCcEyoCsp65UwzmOm38YO+6Yfy+MrzueaRfFaJs3mStrEpcm2fj9VRzkF2unIo9sD+SfHEsknzjJXIx5W1MnwijFQrs+XSSmwC56AK8qxtwt7XZ15aG0b8B6UwjXY4rApbRzWeqww/yPY23PGoxh6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=nllXHRZF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sLY7tC4l; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 2E1EA1300513;
	Wed, 25 Mar 2026 18:11:01 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 18:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774476661;
	 x=1774483861; bh=3c3om6+sjsXCFA8fMVuyG6m2PTBcXdiHeFZPaFuV0Us=; b=
	nllXHRZF0AnyRl7gtIweLoKF+5ybTU6fQSfQUhaebATNQHFrK3cOEpcdo5V4dH88
	BiFNUNyF9G0eeMIxa0BX6RDB09JvX4DvfxkpC7B4f/CS4FjnDyxUCUO3K2cSMzgl
	QAuIDIVlwfpZrlo5XoNVxuuT4FQXqv8n9G4valNPBH1F7DZFkxPxjbd1CZqXj4iJ
	F6CM67+mU8EA8LdgCZbU/XxOSSmHzOt0wpHRAChdjtbvSmLguKoeIP1eA7SlNZOc
	ffFJEqaTHD0yWQmAEEf+OvPCM4YMFiJss4A93XLuE9SXwykS9hfWZUHVt1Nn8Efn
	sjon6620xFyQD0tZ/11cNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774476661; x=
	1774483861; bh=3c3om6+sjsXCFA8fMVuyG6m2PTBcXdiHeFZPaFuV0Us=; b=s
	LY7tC4lJEksSlWfu4QqOV1+W/ChPPv5quGPB+koA6LzUa4yFi+H6b3mVmCaaPRUc
	+e4galswWiqnCsBIAxP+mgDL016MybvIKiUV7IJXl2Im7+3nk7emREFKE8uTeXW6
	7DtOzRRAsoXS5Hb2oMk470R0SbOti+xoNLY/MTVAfBBVNA5jQNE/5d8R58tk1SXh
	+O9FJloPvLOt9XZzMScGomAEoXnnNbAz3w+vJEjHnNNcAeo6zl7fw895ft/2iT6H
	hVBh2cIxo6sJ8449qnCs0Fj8DQFKVsSa0MjrH4X1ZYE29QnfKhEqzIInEg4WuOAB
	hPaGZaqhn4cVPYoMnziwA==
X-ME-Sender: <xms:dF3Eae0jreHKkDbUZAR1NMh7ta5Alx8a0W2tjRJMQbdpA0vJhrf3JQ>
    <xme:dF3Eab4NCiUt0FT-BEjeixJPVLm4GV1nbpV-pJQ8DQaPy9dDlKMeofuTTSKLtpZh-
    YpySY79WjOed_afW5h49xlIfeh9ufNRmfTLyiU22_cl-mSUuxcZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:dF3EaZGOMtxUt5fjM1DMKI-d3PivCT9IVMKWiKBXG0oxvK8patMd7Q>
    <xmx:dF3EabhQgW9xF3r7B0WQxJ0FO1cDkuShFYKFRTk0qsEdVB-kRXgFPw>
    <xmx:dF3Eafom7JkANQG0NsNjm5MZUBXSF98OIRoFtqFHhdCsgFvcOGu0tw>
    <xmx:dF3EabQ70oTeag4nyg44IfUQqmtVoNPdoMv5B5m0UkecLWqI7jBCJA>
    <xmx:dV3EaUF1sKCKuQgVb5cfPP_-X7-ECIFLZO0HDc-vskllgWVnpylurHyT>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D33101EA006B; Wed, 25 Mar 2026 18:11:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 16:10:53 -0600
Subject: [PATCH v3 04/13] wifi: mt76: mt7925: populate EHT 320MHz MCS map
 in sta_rec
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260325-mt7927-wifi-support-v2-v3-4-5ca66c97a755@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=floss@jetm.me;
 h=from:subject:message-id; bh=b6wuUqMM9LRMdvCkKcW9uEToGwJgCsTkr6DKPTvA7cE=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxF1pAI7AXpfmMiGndQcqS7Vuo+jQ2KPjQmyd0
 GNo5A/gEVaJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRdaQAKCRC17sMLqGd3
 HzD9DACDDpYw1OL9JL4L/QaxXf9k3up+HAQxAo4ZC8wYyLVj4g/J6Yh3Uh1ivH8gCM4rzWdzU7b
 zcfhy7c86MA1fQAo2eJ8p3FZZIO/rrW1vKGk9orziHEgV0bIaVZ+EhG+zTtRDuxb72ZZeC06vbR
 42YTiBaBYZWAQJeWz++9obNVkyHwUui5NqVRFls6YRgtLkygsvSzdQXtOAuXLc7B0RLPz1D/eGN
 2SlbO551jijmM+Gar2JpqTgQPOre1iZBb/GMnmFN8hYST41Z1PuhgJOyw4SCzuGX9W+RrvE1JAH
 vBG1YnoS6mh4Kw7B1rVBQjIdntMm00qPPDmPcJ6QmKaOpvS8sSfOTGKtiRLW166bpdQCVlUyUew
 CVqZlj6LQtSqIejxmLPzriVq4KuK1cZqxzr83ekdjoWG56XrKBWZCcRs0W0sN3+0gQ4YcZunI/M
 Qa6ksyIUekKhRshGfmOCaZz0Z1K7ro9t42P9T1AZSep32Kts+L3oGmDYGHc82cGROzpAI=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
References: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-33892-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lgic.pl,gmail.com,humeurlibre.fr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[floss@jetm.me,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[jetm.me:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jetm.me:dkim,jetm.me:email,jetm.me:mid,lgic.pl:email,humeurlibre.fr:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 9449D32CCBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index dd5ecb07947b..a7f27c5014d5 100644
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


