Return-Path: <linux-wireless+bounces-33520-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE8dBfF3vGmFzAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33520-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:25:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC152D2F32
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C892230255C8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 22:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A012B40711B;
	Thu, 19 Mar 2026 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="ZiRcPbw4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UZJYoQjk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB903D3CFF;
	Thu, 19 Mar 2026 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959077; cv=none; b=aq2wYVumVTkHWPaWlZa/6ZsmNe+JH2TwmD9BM7QVyO2irFfpu6/bxEWL1EoPwWrTVJofQYlLxFyPH3qiSk+vGRAqkPHBQTCUfx0Hh+nX0tGKOQy0e+O8nxoEGiSH9Rg8giQNX5Wj3yxz3junSfm6bSNUd64B/XR4P0PYkaAl+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959077; c=relaxed/simple;
	bh=b6wuUqMM9LRMdvCkKcW9uEToGwJgCsTkr6DKPTvA7cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=dqOQevw5ua6ffQanvvZBLB+tY3o9KAiVUyG3lXvD3LP2saBOFZgYA+AMlZteuWSys0lpkxEikKzvQj2XYMywMp+1rjK11rFHAQUnq8j/aItfrA5PB7tlzMuyDMHjCmm1cJK6xU74/BwSxd8SvRzXDWgAjIUFrLC6RW8RcSgaiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=ZiRcPbw4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UZJYoQjk; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 5C82713000A3;
	Thu, 19 Mar 2026 18:24:30 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 18:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773959070;
	 x=1773966270; bh=3c3om6+sjsXCFA8fMVuyG6m2PTBcXdiHeFZPaFuV0Us=; b=
	ZiRcPbw4zc9uGBItwlud/dxc+a3FDO/evSmNiTxBUkw6orRbQdG4mV/cy618KwoF
	zMNxtX0DZkw5BjLteB/wSRfZMTywalOyL9WqTsaXuhJHK51Yoyjd09K5sGvGOUKH
	TAexzZS8Xb8z3yr5JNn8wkw3dQ6El+Rfgma5v/ACZMBcawl5Sir1DxqtFt27EBjg
	lMq8K/fC4mTGJgXK4kvI8GX4PZYefvYjzJnLXz35l/OCfYc+XLxVAN5QaJ39BqBn
	bXraf+DskJGNyXTGVCnwQ02Ya13fZVBU3EFrOUqwe/5vx87wvJjxCwjy9H0sUxRc
	O60Xy+KEDC/81ggxMSappw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773959070; x=
	1773966270; bh=3c3om6+sjsXCFA8fMVuyG6m2PTBcXdiHeFZPaFuV0Us=; b=U
	ZJYoQjkf4PalwEQyPOKcw13Hb9Oe+7uvAoWFsvQxX3pM56LXY7ob60cZ/K0eq4jK
	hJhrQ4kz788/TxND0+1d4vT8oBr2Gc7JQ6oq+I3RSFjWZ4MrQYH0swWw/xHeyFa1
	xbXrWkkYc6S5L3rdKRavRGVEiivJ85whVQHW5fJuzMuHCfUS7t1vjwHd3N5amY4C
	PjhVh1Fkf8gNuoG/PqS2z4kdX96vBsi9rxUV607Bn3+LCPFjdHPrJiAeBXl1M6O6
	p2B71l9Hl1QYZGJo2nU91qTRMMdkVTu1/Lvz4zPUmFisMo+1a0syYfn4DM1XR0Ul
	zG91+9Oj0eK4dfP6eN+kg==
X-ME-Sender: <xms:nne8aR51vpMCtQ2fq3V6k4I45vkJo8ZvJm321ix6t_t02vCOJkvIDw>
    <xme:nne8aZulh9xp60v3Wl0ZuV5pdJa_OPOJSBj7yY3Phkl_Y4VTFhMM78Ddqdjr9HZ6Y
    TP4it0wlGwA8I6L0QU6KMFYZ6TPPnjBZXWsDK5_njZwH_4NsLtCyvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvddtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:nne8aVpMv7-BCgSI07b_mUtsG5e1VtESpXjQCO73jJ5YDJlgIu7gzQ>
    <xmx:nne8aU21PAgjCOFAabY3rgdQ1hvLrxbvLNVG-eUbgyCZ4lZVNXOzqg>
    <xmx:nne8aWvYb-2rztKJNLuW1ji6zvhfTP-U4zL3dg3ttCJt5SAJMPWADQ>
    <xmx:nne8adFOfPe4pbEK07M9Ez_A6vA7I4H1RdicXDSNOSZOuSJIBsc9rw>
    <xmx:nne8acjHNAG4VlYhy1k_PaKgaz-J9Zbx7c8LifYFyiZMVy29LyNvQZPm>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 15EE41EA006C; Thu, 19 Mar 2026 18:24:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 19 Mar 2026 16:24:20 -0600
Subject: [PATCH v2 04/13] wifi: mt76: mt7925: populate EHT 320MHz MCS map
 in sta_rec
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260319-mt7927-wifi-support-v2-v2-4-d627a7fad70d@jetm.me>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Deren Wu <deren.wu@mediatek.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Marcin FM <marcin@lgic.pl>, Cristian-Florin Radoi <radoi.chris@gmail.com>,
 George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>,
 Samu Toljamo <samu.toljamo@gmail.com>,
 Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
 Chapuis Dario <chapuisdario4@gmail.com>,
 =?utf-8?q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>,
 =?utf-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=floss@jetm.me;
 h=from:subject:message-id; bh=b6wuUqMM9LRMdvCkKcW9uEToGwJgCsTkr6DKPTvA7cE=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpvHeQd1hEzMIZb41WgjqFGwoxTSAuLFLrK1lUn
 InlC2iFzFSJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCabx3kAAKCRC17sMLqGd3
 H7MIDACy9HwJsPhZrZ7KiIkj8lu8z63AZj45vXV+EZ6h+OALFug80DB6KH4fNwkC+Vzb8OJENKO
 1otFUeZIaj/8RWV1ZluwDGazyp3dt+jEG2nmXGdlG+8Ub4MvEROpI89fT4LHLBAXDGpl7oaaeG9
 mTFT3Vniae6TfmDKMXpWT/6BoS7rARtEOdo20jwL/RNJTHOQIgMV699Fb2pqtUQC/R1341WiaUH
 MWtfyB9k5q5bRI//gOM0o3P36k4LFZHUXpzN97qz+jRYgYlmAnZf/p0odP+3eX8vkDUNQvujGSD
 09DE7fJbbes1YkR1y2WhkF1qkK+E/L7yT+rq5SwflCnLHkuuTBOsOhmWNGvd8VL3/PNflx85pff
 eb69izVPmmQZ6TFCdwb1OoPGJaisXfj6rtdXZlrP4Se+b/zmj5z6Pm4bWm9rQ8j4c72VXddkFfG
 3t7uyB3GE+wY8DBV8KCXP2m3YvutACkQPwVnzHnGhwaoxpicoN+GXIi4eeKkchm9p1Rts=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
References: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-33520-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.447];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,lgic.pl:email,jetm.me:dkim,jetm.me:email,jetm.me:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,humeurlibre.fr:email]
X-Rspamd-Queue-Id: AAC152D2F32
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


