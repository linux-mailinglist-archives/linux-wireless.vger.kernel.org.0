Return-Path: <linux-wireless+bounces-34010-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHKVJGChxWlUAQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34010-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:13:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A52833BB47
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42C6B3042FC9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 21:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A43A782E;
	Thu, 26 Mar 2026 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="N/Td8TvW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cNJFHR97"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02AA3A7586;
	Thu, 26 Mar 2026 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559554; cv=none; b=flQSeELB8k/zE3m0LHPof9KBEPTrqqivGBSmuAzh8tievpeN0jyovBstCWM4g2RxLBJ7bLbdSJ6vDMAkPUHM11AHcb2IxlpXCRleoWU51SHqrcQoaObv1NntL1s5nbMCRT5PMgA5X4ZKOp/HkNZAjEGOhRcqz5CbrgnfvWv5HSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559554; c=relaxed/simple;
	bh=oL0xrbX2LUVp9Q4JBTD78nnciF3VWT3fiWIhBG52oaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=ZTV7gyV1smORMrZEvr0mfCOHrHlCD6aP4ycjwaFx/7vWTIi3pBHJAHzemz5hv8JpVaT1gZT/ZNkK2++cn/q3AK53QIa+sauB0dv6tbKeN+FLGSoq391rHvpkGJFvq1CYTvxl509iMBDXEODPjKR4TMwOi+6yh3HnXjQJjxNMDuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=N/Td8TvW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cNJFHR97; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 0E13C138014F;
	Thu, 26 Mar 2026 17:12:32 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 17:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774559552;
	 x=1774566752; bh=HOxwP/LFDi9G4GG/ESf696AKYCs6uY6IFgrUHF+9MxA=; b=
	N/Td8TvWPrRBCT4UmRikJVm4u4hjXJujVyRbfmqewYl9zBJ68HcqJzPK/3u+c2XQ
	QVLtmwMX+UhxAijbn+IrwwUqV4eHR80YfbBng/6m7T7un237Wgr0/qfLBZtBbjHy
	Nc5NguTGEg8sefV5gKO9UWvjXJqq5V46KVRitAvFLIu8dcfomSd+N3zyYDBrVlvA
	tiIPOKnFzIoEiiuwP0t3ZBn8oYesLNDfmRvzOZk3CnlRjfegu6V2JxC1Y3Nsoi1I
	Q3u3KCrRNgLdyQcvYp+mffYID/dUYakPG0VQBs6RO0m7z6l1Br54uVq/6cCs93jc
	0Vj4+wsh/ziSTu1JjXRhIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774559552; x=
	1774566752; bh=HOxwP/LFDi9G4GG/ESf696AKYCs6uY6IFgrUHF+9MxA=; b=c
	NJFHR97oPOnHRwW9Lo+Ieivv8qr3rkPXYy0zXV9+wKENw+W18W9OzQ9B1ZGSS7V7
	WpAijZtjzGp8Yrd5eokaxaoEGCUi2Dah2YDeLXICZzxNuFGfaKAZl9JQWWIq0Wsm
	Z5gIS5BGCVJHCIFzR8dCTpstu0FSZu7Y3Dh0tUVkCSWt+MloSpIY6CNXCleCYzfc
	Vod8VgLOgXj4uTc9E1DungcRGRBP9ZRYPOJv9zhL1JKjW06d/ywMo1Nj+jxVd6iL
	kPxnEv3ev3mNrFN6xFKzMtNUGdinB42Tnrs1aUnbLX5B5d1nnRf5O4yZa9YokqUy
	7UCLxGdooWjx4JlcrvNmQ==
X-ME-Sender: <xms:P6HFafE8nsQPgCofhSzD5mDssTLPNtVXYt7nAE6yjYoYBZgU0IKVUg>
    <xme:P6HFaXJM2-kHO6i4TTk7txxWgetKomNLZgHH0XjVMrs7gbhBmo_SldmPSqV-mXKiN
    p96i190fvAd3lOSdIbTr1RL35mCkh5S3VLxCi7wmKs9piJHW-Y21eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepue
    dttdfggfdufeeiueetffegveefffevjeehvdelfeevhffhteekgfegveeuiefhnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehflhhoshhssehjvghtmhdrmhgvpdhnsggprhgtphhtthho
    pedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnghgvlhhoghhiohgrtg
    gthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthho
    peefudelfeeifedusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoohhnghdrtdigtd
    dtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghrihgvlhdrrhhoshgvnhhfvghlugdr
    jeehtdesghhmrghilhdrtghomhdprhgtphhtthhopegthhgrphhuihhsuggrrhhiohegse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhiohhsrghlledtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgrthhthhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprhgrughoihdrtghhrhhishesghhmrghilhdrtghomhdprhgtphhtthhopehsrghm
    uhdrthholhhjrghmohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:P6HFafU_oTocZuk9Wy5EbfEf41M0_u3pIlPlrlHNxRfn99ME3-IF0Q>
    <xmx:P6HFaUywMljqKR8P2oVw_uPDbfCZSBvSE6zTse1SyDoSEkIz_Et1EA>
    <xmx:P6HFaf7QwH0iRVD-4COUSY6HhdZwVoxKgz4Zvkb_Jkjid1WjFknVag>
    <xmx:P6HFaWg3zsqP9xJS-8KNyAHHbukNelnYaU8B7UvZA3Vh8GHAgmgplA>
    <xmx:QKHFaYV1B2ENikZnDZQvMK-2L-Wuw6SjoFqCYIbwEfqYzQpzWCgON-oJ>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DBCD51EA006B; Thu, 26 Mar 2026 17:12:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 15:12:26 -0600
Subject: [PATCH v4 2/9] wifi: mt76: mt7925: add 320MHz bandwidth to
 bss_rlm_tlv
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-mt7927-wifi-support-v4-v4-2-8ab465addcfe@jetm.me>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
 Deren Wu <deren.wu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?utf-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>,
 Marcin FM <marcin@lgic.pl>, Cristian-Florin Radoi <radoi.chris@gmail.com>,
 George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>,
 Samu Toljamo <samu.toljamo@gmail.com>,
 Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
 Chapuis Dario <chapuisdario4@gmail.com>,
 =?utf-8?q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=floss@jetm.me;
 h=from:subject:message-id; bh=oL0xrbX2LUVp9Q4JBTD78nnciF3VWT3fiWIhBG52oaU=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxaE45JhSnc/J5oCpgtFJJoPpHiK6vkch8y345
 yuAeH5aXU6JAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWhOAAKCRC17sMLqGd3
 Hx9iC/43Gcu5nDAXTOrqictzohkwauPGpa+JwvfObi2x5ike6vlLV/iG5bAkArKYCcF6JInqYA0
 MJhVlVFZvddy81x0f3wU94Jg2QPZ2cE3HQ2y7ZZd9wpqEUYD+RWnpub8ixGijPmP9acnfTlsCea
 b8rEiCU4klmZSnlIbLHMli77J3rowsriAUPo3u0zq+hdCGxX47jVGQvdOUkD6lUEG8lhlejjljL
 lfICcqhDvTTb4ZtDk0ZvXHoU31fvBXvkcecq1nsHuzAYkOp2rKBJ6AWrYfU8DeS5qFcC2MoYShW
 htjoMZgmciqWKgifVqOBAqxKNBOBHMu1T+VoFB9uAkNy/9qDkk/nLpMHn70TgkF+o2TUAjVhqYE
 /gURfXt/6eA5Bd73gI1B9pvWTLBPdK4PsERZE8lJSwvex4RECZ9pVqk6U4d71BuTvy0ZvZyuFEM
 mB2UmABwv+6DH+mKnkWeXww+hUfGY8QOl0Ue/Dnx6bWnOOF52VA430SqnPTv70d6cNxtc=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
References: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-34010-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com,lgic.pl,humeurlibre.fr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[floss@jetm.me,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[jetm.me:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jetm.me:dkim,jetm.me:email,jetm.me:mid,humeurlibre.fr:email,messagingengine.com:dkim,lgic.pl:email]
X-Rspamd-Queue-Id: 4A52833BB47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bss_rlm_tlv() in mt7925_mcu_bss_rlm_tlv() has no case for
NL80211_CHAN_WIDTH_320. When associated to a 320MHz BSS, the switch
falls through to default and sends bw=0 (CMD_CBW_20MHZ) to firmware
via BSS_RLM TLV. Firmware then configures the RX radio for 20MHz
and cannot decode the AP's 320MHz frames, resulting in complete data
path failure at 320MHz.

Add the missing NL80211_CHAN_WIDTH_320 case with CMD_CBW_320MHZ and
center_chan2.

Tested on ASUS RT-BE92U: 320MHz throughput goes from 0 Mbps to
841 Mbps (iperf3 -t30 -P8), PHY 4803 Mbps EHT-MCS11.

Reported-by: 张旭涵 <Loong.0x00@gmail.com>
Closes: https://github.com/openwrt/mt76/issues/927
Tested-by: 张旭涵 <Loong.0x00@gmail.com>
Tested-by: Marcin FM <marcin@lgic.pl>
Tested-by: Cristian-Florin Radoi <radoi.chris@gmail.com>
Tested-by: George Salukvadze <giosal90@gmail.com>
Tested-by: Evgeny Kapusta <3193631@gmail.com>
Tested-by: Samu Toljamo <samu.toljamo@gmail.com>
Tested-by: Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>
Tested-by: Chapuis Dario <chapuisdario4@gmail.com>
Tested-by: Thibaut François <tibo@humeurlibre.fr>
Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cf0fdea45cf7..dd5ecb07947b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2331,6 +2331,10 @@ void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
 	case NL80211_CHAN_WIDTH_160:
 		req->bw = CMD_CBW_160MHZ;
 		break;
+	case NL80211_CHAN_WIDTH_320:
+		req->bw = CMD_CBW_320MHZ;
+		req->center_chan2 = ieee80211_frequency_to_channel(freq2);
+		break;
 	case NL80211_CHAN_WIDTH_5:
 		req->bw = CMD_CBW_5MHZ;
 		break;

-- 
2.53.0


