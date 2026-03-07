Return-Path: <linux-wireless+bounces-32705-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I1EJll0q2kvdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32705-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:42:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA202290F8
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A65C4304D902
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABBE2E62D1;
	Sat,  7 Mar 2026 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="XCxY9Mzn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YJg5mHKn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730422E62B3;
	Sat,  7 Mar 2026 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843665; cv=none; b=GBKn+PTt2ghbnoPm3E8aKUatEbJGflbpea4aqfy+MDN5eHBq1Jiy5C5T9LmGn8uK0ED/OkTgUiN+RtMubLjaX4MDQD+O+A7w/TuDJ7laFaGxNhiBorZJQ2UmMSysNadurTZE2ZGRj6c9UPVxybX0xKi5kGr97eCUdMrtpJJKAgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843665; c=relaxed/simple;
	bh=76o6pFwpyjUyv3yPBBBAdI2dlELkl13ZIgHkl2UbS2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=jAHGKK1Ok7AN8Xj5/bzIzuPT4m9OzGeeJwPzWIUrUjvetS7NCu4bc/op24yxV51VZeMvSZ06aSbssuxawTplJVdBg8WPaQyKeXjCsxjkEnpy1eOqCFvopJr9LLZ/YeYnecDldq+NJdbrg3Exs31G4TOezcHSzXWHgpgso0ziV8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=XCxY9Mzn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YJg5mHKn; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id E23B81380A22;
	Fri,  6 Mar 2026 19:34:23 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 19:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772843663;
	 x=1772850863; bh=HoAXh3SQ9Tz9LRhc8OIvPnjOzRFjWCfpsYPvBpkZEr8=; b=
	XCxY9MznMa/MuiHsUf9e2GLh6vAnqch9tXI5SktPbF3gCC9wBXCqKGqhwLRSnJnv
	ZCAVjIaHkxSJftmCMTrDtqkiPFDOT77EIpCJnrBz2he12ii56pbdOBhI0V7Ijs5I
	xY9k/wOS/1FVd3nIDsMrlIYAfLP4jPHqwqXtIWinl9e3iiY7XWvFK1kHd/3PYpRQ
	mb+AsGxRqyHc9quZ7LeUd0GpMaeGIOofMNjaUiIliaV6cLOt1go8nRAjBl9TKibX
	CxI9C1zUNQJqGygoJIRd6jYrxVsq/2kZb7OWREV3x3mVzkHkVk9PblKboQwJa3Yy
	e06NsPp5f0XaeJfYlDPVjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772843663; x=
	1772850863; bh=HoAXh3SQ9Tz9LRhc8OIvPnjOzRFjWCfpsYPvBpkZEr8=; b=Y
	Jg5mHKnc8+BGp84QtGwgcF9FxzS90dmabjPU8DYTX8yiHF2PFf4VcXwLQtLEA6xw
	nW1IBZJ03zHp7Sx9cBE2kcjdtdfehhTaimsatU/GySapFBBFunhs8/bi0somERBu
	HhuffvWjSaWFGdhvMS11MlnbM79frpU0n2N86lETyn1rUi8In0dzOUNsT7zPHgfh
	PooOw8JQHQowSU1yk+0iUd/OYvVFzTe55PaAr93grl8k9kQ+GHuFIuRv0PBOKCxT
	Ih22FRgeueiERgPCIrdAwIdJFTbL4UBt3qwrEiuV8WNrGx9PJscsRVpr5Vu9JDOT
	ZBARzbdBeIysS9eijeaUA==
X-ME-Sender: <xms:j3KraTAU-hnNENW5g4UGGib7v8xBqGxfPKqf6aKfjEdlM8SVNqDcRw>
    <xme:j3KraUWMbNWGqhJd4db7STpu-ilM0nIHAvOlsh85nUUrzUbQFuczY4y072SqTi6_n
    ZQcuAlQ71CGCS8rY3sNUD-wiLHD-4QG_6zyLult-nuPYnHRRWWswzE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepue
    dttdfggfdufeeiueetffegveefffevjeehvdelfeevhffhteekgfegveeuiefhnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpehflhhoshhssehjvghtmhdrmhgvpdhnsggprhgtphhtthho
    pedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnghgvlhhoghhiohgrtg
    gthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthho
    peefudelfeeifedusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoohhnghdrtdigtd
    dtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghrihgvlhdrrhhoshgvnhhfvghlugdr
    jeehtdesghhmrghilhdrtghomhdprhgtphhtthhopegthhgrphhuihhsuggrrhhiohegse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhiohhsrghlledtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgrthhthhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprhgrughoihdrtghhrhhishesghhmrghilhdrtghomhdprhgtphhtthhopehsrghm
    uhdrthholhhjrghmohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:j3KraUbLqOMu1hA6cw-UWeiu9gKgSKpc--opTLe8eK5ZUMBvQLf-Tw>
    <xmx:j3KraaKBMwbOlvl67uqmV7mwaBc38ZPjPJeQn8EXXO261m09aoRbSA>
    <xmx:j3Krad2NYPQ6c2L1sUn_98tnq0IGKSLjDzgM52GwcFAj4ijwoLE1FQ>
    <xmx:j3KraVZOldb7g2nmU0j69fJde_8qtx1OHDjDPg_FmdrfbKi0iZZ6UA>
    <xmx:j3KraTMa5YASg729nyEOKj3Mh47Vzow8ROdGkfqANSnyKxOENmQjQoWY>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BAF471EA006B; Fri,  6 Mar 2026 19:34:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Fri, 06 Mar 2026 18:33:37 -0600
Subject: [PATCH 18/18] wifi: mt76: mt7925: add 320MHz bandwidth to
 bss_rlm_tlv
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-mt7927-wifi-support-v1-18-c77e7445511d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=floss@jetm.me;
 h=from:subject:message-id; bh=76o6pFwpyjUyv3yPBBBAdI2dlELkl13ZIgHkl2UbS2A=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpq3JQOB5Xx7+rlhJvXpLwxYGMyLapclMOstIQH
 E88aKo5LjmJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCaatyUAAKCRC17sMLqGd3
 H6gDDACYdyveP2iYImYAeUIhT1CebEcBKEXBkf6+UBB9xo0vfTbrnyUiDYYgCJRD+zAuUsseDeB
 roHGHi44STPQbjBsquZDiMSDqiNQfjl5JKELfJ1Cjo2dSOKexcNKbj8YXBXzocO/oGxb4xy6L64
 +uhCJuxVJ7dpZePVEWjqFRsNIXRHoU9pxw27bTN2sdQuTcHUgUH5+KZqMBpfdlMio8MyWHj+ayH
 EOV0hYRssehxX1B7VyeTa61W9gtMEs8f5B3fkCcZ0bTjmgx/mpvd4d387Uhxjp66uTB7EjQykys
 Pr7b3PrKdJQk4Xqp2DvEs2fR030W9eRQB1Sr4rLIzOL5Y+DR8yhsk2ReBxfqsXnCcHnt3GjHaFT
 V6wKcQkHdwoG7I8vlcWT7K5HofbCHGfAeOU2gL4oUE38cPeEkP4vDt5n8TxVx/J5BjnExg+iHBB
 BDFr3nZmK8OGdnLTqP3+9jU/XF0UfjEyOw3IMdaMelFX7P+NZwv+AAR9o7jKX/C6MLwP8=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
X-Rspamd-Queue-Id: 3CA202290F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32705-lists,linux-wireless=lfdr.de];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	NEURAL_SPAM(0.00)[0.667];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim,humeurlibre.fr:email,anthropic.com:email,jetm.me:dkim,jetm.me:email,jetm.me:mid,lgic.pl:email]
X-Rspamd-Action: add header
X-Spam: Yes

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
Closes: https://github.com/jetm/mediatek-mt7927-dkms/issues/15
Assisted-by: Claude Code <noreply@anthropic.com> (claude-opus-4-6)
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
index 3458aa8c79cb..025e6d14f7ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2363,6 +2363,10 @@ void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
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


