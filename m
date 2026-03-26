Return-Path: <linux-wireless+bounces-34011-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C8HF3ChxWlUAQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34011-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:13:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F33933BB55
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A630302D497
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CD13A8736;
	Thu, 26 Mar 2026 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="DqzaVL3e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xgdbsf+m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B13A783F;
	Thu, 26 Mar 2026 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559555; cv=none; b=BLvHYoIquIZXnFHHwoWxIcYZQKql55ePoHuJWyei9ep8VZug6R+j8Dj8r/oGJF4kV77NDhC7B5dABIVQhl59IziJvnqBPEUmNSV44HAnM7ne8dXoPFim+5NavqV6nMHakU5rnlWW4lZC1HYQmUmo0eSnUUXvsW//wWKEF0+cJYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559555; c=relaxed/simple;
	bh=BZB4eayi5CQeKoa7X5LI8ihvLOiSO2F3JQGoBG3iu4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=j9t89MIDaRhuh2eGXjmfwyLJe6Nk2FHuu6yxWOoHF7KAbewAoEy7wHRn6/jc32iCQbp10hQRhNB7vojn0RtY9YBdpOleF9pWivVoW85El+t55BPkB429Y2mcHrvdr9CWfS2YjGSzUyOL4OVKEW7/Kxi5rGU3AhrbuQKRPOc4/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=DqzaVL3e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xgdbsf+m; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id CA3CE1380150;
	Thu, 26 Mar 2026 17:12:33 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 17:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774559553;
	 x=1774566753; bh=e5QLbR8nQwufqPNpMgHuGuZt5CzJuoJvqK1picXhn/k=; b=
	DqzaVL3ebYJKfqA99kI8FaxmJt1Jc1FzHmdK6II0AhTb/kOcy0RVARlAk92n4i6A
	JoDJsnxjGvmuy/oJBheQXah1SdP0H943RBj9iEgOlyvRkbheAAgMzIKr2PHyCvI2
	AqOPu0nwA0sv8nfMz2QZxgpZecs8W7hyBila8PdrkbERyhBVcYxyuuPWmWeOyhrR
	adYRdntXEacnO1lr5KwqMCDFiYr4eCN8oF0wXKny41EBcfxdXvIwq+HG2nBdSNHo
	vUW0EYXWvf493/cxBwEH9gDuF8gi9FJXTv+i9JUsUdO/0QsrrFLjnE+eTw8eRufF
	b4ykESWznU/7WD2GuE5ZJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774559553; x=
	1774566753; bh=e5QLbR8nQwufqPNpMgHuGuZt5CzJuoJvqK1picXhn/k=; b=X
	gdbsf+mYBF5okhDjs0D5YLjPLBjAlV+6+OVV9t8poZ1UYqt8Scklsjm0aWm3yYJo
	k8yeEeRXaDlMJmwk94ED6LspVzgg/BdGkVPGh4inkpRtu8UsBIDkIdPJdEkNN1ru
	NAm1U/lcwKKgnHzUhnc/+oZ0INoH6wemkJPhdZwlTYaZM55+HmDs8kcLlMQrj5TO
	C0VSWL8SHhSdzc+LZ8N7NZkpbay439coOZ1hOlmYFZI8dl6NIrtNgPD5ytzi6u0r
	PmMkKIGmLF/cazVJE+WqHL/C/BA05sURDozn6Bl6UFfU6B3zOEsGkVG2G8Gu4uoQ
	aDRdREWBvySyL2zbUBVIA==
X-ME-Sender: <xms:QaHFaSfDFAuCnN_OTrYr3q2ugqyuCBNL0oY1AgqzWdho3ZxtL1liag>
    <xme:QaHFaXD1rvQBY3oRjNkhbpd7h1tzHkdm7723c_ihQ8OGqWkoBbak4Cx9qkvGPip-p
    qrzG5YYOqVWS-wkRN-0wvP6-ki_5HUrWIh4A2NM0zQaECesb3hePu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekgedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:QaHFaTs72IpV7KQ22AjvPYDirNxr1ODP_CcardvLoSXqzEml6N1D1A>
    <xmx:QaHFaRqR5D3mHamGmNqW2ptzuokQO_PGW6o2EpE0lCxuT7knMcdNcg>
    <xmx:QaHFabScXvxmUxoZUfep5ZYLGwUKSMkLC6cDdtbcDBudVbH5fZpAig>
    <xmx:QaHFaeZ3yxjhmMzGn79qgS8SWdC2EKFCBqelSy4QmsXrFROHMc6gxQ>
    <xmx:QaHFaZvVtpUQVgb8ve6w42B2W31uSkvtDKqFP-urmbo0BWsMgFfuPBt0>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A16B91EA006B; Thu, 26 Mar 2026 17:12:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 15:12:27 -0600
Subject: [PATCH v4 3/9] wifi: mt76: mt7925: handle 320MHz bandwidth in RXV
 and TXS
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-mt7927-wifi-support-v4-v4-3-8ab465addcfe@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; i=floss@jetm.me;
 h=from:subject:message-id; bh=BZB4eayi5CQeKoa7X5LI8ihvLOiSO2F3JQGoBG3iu4g=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxaE43mYqYvjLKfFiKw/xDraf9On4ZhVZC9zX5
 CgZ/PlCnY+JAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWhOAAKCRC17sMLqGd3
 H/4LDACtHZzKRKfSiDyTKRDfgF+YxZdhtWscYyilTOCuhcyrdfCpsXzL0zeqfThofcrcuCFq254
 mQh5V+OJ334wEm1fZmpwLBjj7VGK9f1OcwJ2LDgLC0oEXsgtyWz5LvKKrucY3SWlXt8tl0GKnC3
 nA5TdRnE8YRAzuUTRalXX6tp2J1IWM+ffOi9BMpkFdWl5Fsl/NMlsFwGLdulf3cA3BCySgGxmaI
 k+2VzoFfZlUXQjx2mpzBOh2hmQ3Jwi6PnhcHllvKwTmdqIhaqYc7Up8E7nti3yA1rk/Wrg+Kcip
 Af8tJSu8hcX8yaTPBXNGUg5IpvRqhpFz/eNepR9a7KHHgspXieXv7UNhmbNsaiw4az2bHI0nhip
 FeieLZgSZYCUS3qIBJm60tnSEB1JQuG05P6/X+jQBoqcHJTy7pcpSsuaE9XZZrMhhX+9MD/C0HK
 YZstmB5ppRWjlQAXQj3X7D/q6y9b5v5dvwevmKz8eTi6UFFOcITNto9+xac9QIhWJ0Ubk=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
References: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
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
	TAGGED_FROM(0.00)[bounces-34011-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,humeurlibre.fr:email,messagingengine.com:dkim,jetm.me:dkim,jetm.me:email,jetm.me:mid,lgic.pl:email,rate.bw:url]
X-Rspamd-Queue-Id: 5F33933BB55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RX vector (RXV) and TX status (TXS) parsing in mac.c lack handling
for 320MHz channel width. When the hardware reports 320MHz in the
bandwidth field, mt7925_mac_fill_rx_rate() returns -EINVAL and
mt7925_mac_add_txs_skb() records no bandwidth stats.

Add IEEE80211_STA_RX_BW_320 cases to both functions. The RXV parser
also handles BW_320+1 since the hardware can report 320MHz in two
adjacent encoding positions.

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
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index caaf71c31480..ad03fc554b69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -339,6 +339,11 @@ mt7925_mac_fill_rx_rate(struct mt792x_dev *dev,
 	case IEEE80211_STA_RX_BW_160:
 		status->bw = RATE_INFO_BW_160;
 		break;
+	/* RXV can report 320 in two positions */
+	case IEEE80211_STA_RX_BW_320:
+	case IEEE80211_STA_RX_BW_320 + 1:
+		status->bw = RATE_INFO_BW_320;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -992,6 +997,10 @@ mt7925_mac_add_txs_skb(struct mt792x_dev *dev, struct mt76_wcid *wcid,
 	stats->tx_mode[mode]++;
 
 	switch (FIELD_GET(MT_TXS0_BW, txs)) {
+	case IEEE80211_STA_RX_BW_320:
+		rate.bw = RATE_INFO_BW_320;
+		stats->tx_bw[4]++;
+		break;
 	case IEEE80211_STA_RX_BW_160:
 		rate.bw = RATE_INFO_BW_160;
 		stats->tx_bw[3]++;

-- 
2.53.0


