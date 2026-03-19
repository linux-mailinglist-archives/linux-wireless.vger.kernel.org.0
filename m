Return-Path: <linux-wireless+bounces-33526-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMLLGdd5vGkFzQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33526-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:33:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 082F12D3244
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 339993028C17
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEAB3E0C47;
	Thu, 19 Mar 2026 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="f/q76d0z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D+Mz2j0n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20545407577;
	Thu, 19 Mar 2026 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959089; cv=none; b=pXb6EfY7rYcv2LQBB092Kt2Wl+LsaUCug/Z9PAMSJEUuj/BpCQQYXqXMLl/MlbSeFMfdwhhdEfx0U9JLeGrKd6dcM3ApNN7cdieOUcp4JMO8NaAJJBUc9UXyaDV7dvJjA1deOibWtNiQpsCHY4nbw+W/rJ+DDtATHnazG3NMLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959089; c=relaxed/simple;
	bh=/gjiel5869rYGCVjZwRZFG03XJXO8FEsTHwufAYf8os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=DJfdMvzkHIeFdtuhLeNZXLpTsJjakPZrOcahJL8QZ53CmFLqeoPADA3BE167JsbXfHUOXrk5kSMHZyDqDElrdFwMVysyP5O+TVApgpIgJUcSMeklRCV0n2mHB6CQPqCoA/UO4tnGOFdM5DnMFDX841l9kKMbB49T/Msw3wFaF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=f/q76d0z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D+Mz2j0n; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id B91F613000BA;
	Thu, 19 Mar 2026 18:24:41 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 18:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773959081;
	 x=1773966281; bh=FmXZ9AWojJY1aMvgCUXzZGGkyVWJ2/d5Ccx43mIJnaI=; b=
	f/q76d0zqSLgaEWiJFVdGd9BdZQt5Djoe3REvmWm67Nc4qfeSWw9kwT83DwjbPKb
	fz8HJgoENN0rm21kUeweptvzThkQBSNeq04HHpEDxSs/lZwW09dqlvE6RUoX5M+P
	4jC1cq8pumqpsi1eqk+Zk1UQdy62TbxpL0v/EUKCbtXO9KJ68fDVoiiPiNGkXXYu
	TK/BPcaEeQD3yWdD1obYlmrToizofl4jRToBzvp4qwjYaWB85awRUNxG819oHY45
	5Stsjg5bSuPgKUyFM4GYSmZCOhVgZWabagwq+ACqncIBzyB6+UFWHbw2aUptREv1
	8xMurSF1qI0KA7ZNRCp3Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773959081; x=
	1773966281; bh=FmXZ9AWojJY1aMvgCUXzZGGkyVWJ2/d5Ccx43mIJnaI=; b=D
	+Mz2j0nWcv3jocWe9nLGYtHwOsT3H20nmtB/lcukqSVtNhvKD0bNoucQxXPynCnr
	50bO0KczF0DhQKLK9U/875fsYuKi2+11jlbzYHJ3g4on5ItdU65aA/3CjVMegFsM
	fprg+TI4ipwlM0lBVzCGCiufq2SgI+/j+X4aWcUrjd9PAcJtZKI9gMUTXvhCl8qV
	zv+jM0yLf5RRrDqRZ1kVzafFPuCuvpa0wfg6P14Dc7JaWvJdlH5sRXwtBBM/MIm6
	3fNe07sf1o3FNoe6GCmkQwTVdLCicZyCMdBe9c71zXO6ScoE5JuFGRgFwOQoEVbO
	DTh+RVh9T7Pc8Cl6a1BnQ==
X-ME-Sender: <xms:qXe8aX7oYvaV8UWckGwcLqjqtS_Uxko4Fli1cirZEZqe8-8CFxbftA>
    <xme:qXe8aXsFtTiG-dk3iniQwhFvUFqZ1lZaGqLR7UDZbRJNHOflT1vQ8rYN79dkIZsN6
    M89-tXsPjAxGq8cPMziD0osyDhxoIPp6SMpsOFF1F6ttNr2noB4FSM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepue
    dttdfggfdufeeiueetffegveefffevjeehvdelfeevhffhteekgfegveeuiefhnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedunecurfgrrh
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
X-ME-Proxy: <xmx:qXe8abqQDFn0_N-_SeatG2WsodyTajjbYtZLoTRVORBJCWv4QUO6VQ>
    <xmx:qXe8aS0SEQLf0j8jUhVlSPke7spvOYK8Ukl5kLU81RgAeEPNkhOQ5w>
    <xmx:qXe8acujzPYqDgga3WZarBJ4V2fVTr0nTZjt9Kn9ELvMzY3SLi0KgQ>
    <xmx:qXe8abEmNw-QTfvdI_2WajSGOuS9ENj3dlyy-zABgIK9A2xwdRQrRQ>
    <xmx:qXe8aaLkh0LEv_a9hx7Dc8ojDo7mpah0eZkRFkTWI6DyaZSbYhRwF95L>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 27A6F1EA006C; Thu, 19 Mar 2026 18:24:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 19 Mar 2026 16:24:26 -0600
Subject: [PATCH v2 10/13] wifi: mt76: mt7925: add MT7927 hardware
 initialization
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260319-mt7927-wifi-support-v2-v2-10-d627a7fad70d@jetm.me>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Deren Wu <deren.wu@mediatek.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?utf-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>,
 Marcin FM <marcin@lgic.pl>, Cristian-Florin Radoi <radoi.chris@gmail.com>,
 George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>,
 Samu Toljamo <samu.toljamo@gmail.com>,
 Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
 Chapuis Dario <chapuisdario4@gmail.com>,
 =?utf-8?q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10527; i=floss@jetm.me;
 h=from:subject:message-id; bh=/gjiel5869rYGCVjZwRZFG03XJXO8FEsTHwufAYf8os=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpvHeR2w1DkIuJrbkOygUy5D9atwjadjhCjVIIo
 DbVywuclWKJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCabx3kQAKCRC17sMLqGd3
 H42FC/4msAplLp8BrK1e1KTKrdd2iO9NN8QAQUQE7O6QiDnbAjhPm6GxoKvd1NdhX/aSQcEFCVg
 c9tSYGNxxeV7K3YFAt7mNreux2DrJdkdnFLSvw2RWpPyIwFYXbs78LWKXLx69N+qk06r/0CTfnM
 fHVfCjAZ7bBtCTWMnL9FVBU1oMrgi73MSTPOUKXNFo3+WIyxr8r2WUd+wxTkI5B6VgPRkMnaFmc
 kbmox3cAu4mPhm58fYrmPlBMDPnX4NJUwvUgV/U9ZMrxxl2G1Fp43kMthGRqTu+jwfaesN3IXiV
 ibdJVzV21MmwAeZ5mmq4HuW0Vuxto0/yOpnFxnP1E3Rwz0JrJ4ESZLoFwiVTs7M8iNIYwSOPAuj
 z85YV6IWwfM5QFA0M/4M3jNj4u0Y6bqAVM946h5erEu+F1VPqwNOCdergJToA6v80NBPgD2k1oD
 7OkOCd4cnkEvfuQjbdnV+C3KcpTDoekMRss5xbE4D9L7AjFgwChPeja3mwgoDGPw5KW3o=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
References: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
X-Spamd-Result: default: False [8.85 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:dkim,jetm.me:email,jetm.me:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33526-lists,linux-wireless=lfdr.de];
	R_DKIM_ALLOW(0.00)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com,lgic.pl,humeurlibre.fr];
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
	NEURAL_SPAM(0.00)[0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[humeurlibre.fr:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jetm.me:dkim,jetm.me:email,jetm.me:mid,messagingengine.com:dkim,lgic.pl:email]
X-Rspamd-Queue-Id: 082F12D3244
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Add MT7927-specific hardware initialization for the Filogic 380 combo
chip, which has an additional CBInfra (ConnectaBus Infrastructure) bus
fabric between PCIe and the WiFi subsystem.

CBTOP remap: configure PCIe address mapping so MMIO reads to WiFi
registers return valid data instead of zero.

Chip initialization sequence:
  1. WF subsystem reset via CBInfra RGU
  2. MCU ownership acquisition
  3. Poll ROMCODE_INDEX for MCU idle (0x1D1E)
  4. MCIF remap for host DMA
  5. PCIe sleep disable

Probe flow changes for MT7927:
  - Skip early CLR_OWN (CBTOP not yet configured)
  - Force chip ID if CHIPID register returns stale value
  - Replace wfsys_reset with mt7927_chip_init

CLR_OWN skip in mt7925e_mcu_init(): every CLR_OWN triggers the ROM to
reinitialize WFDMA, destroying ring configuration set up by DMA init.
The controlled SET_OWN/CLR_OWN is already handled in the DMA pre-ring
setup hook.

DBDC enable: MT7927 firmware defaults to single-band (2.4GHz only).
Send explicit SET_DBDC_PARMS to enable dual-band operation.

CNM force: MT7927 firmware lacks the connac2 feature trailer, causing
channel context ops to be replaced with stubs. Force the CNM flag at
probe to preserve ROC support needed for authentication.

mac_reset guard: return -EOPNOTSUPP for MT7927 since the reset path
performs CLR_OWN and logic reset that destroy DMA configuration. Full
reset recovery is follow-up work.

Register values derived from Loong0x00's reverse-engineered MT7927
driver.

Reported-by: 张旭涵 <Loong.0x00@gmail.com>
Closes: https://github.com/openwrt/mt76/issues/927
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
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |  13 +++
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    | 103 +++++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |   9 ++
 .../net/wireless/mediatek/mt76/mt7925/pci_mcu.c    |  20 ++--
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |  18 ++++
 5 files changed, 149 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 3ce5d6fcc69d..c4c99380f5b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -115,6 +115,19 @@ static int __mt7925_init_hardware(struct mt792x_dev *dev)
 	if (ret)
 		goto out;
 
+	/* MT7927: Enable DBDC (dual-band) mode. Without this, firmware
+	 * defaults to 2.4GHz only and ignores 5GHz scan requests.
+	 * MT7925 firmware handles DBDC automatically.
+	 */
+	if (is_mt7927(&dev->mt76)) {
+		ret = mt7925_mcu_set_dbdc(&dev->mphy, true);
+		if (ret) {
+			dev_warn(dev->mt76.dev,
+				 "MT7927 DBDC enable failed: %d\n", ret);
+			ret = 0;
+		}
+	}
+
 out:
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 415194a440f8..393d9f408b84 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -400,6 +400,64 @@ static const struct mt792x_irq_map mt7927_irq_map = {
 		.wm2_complete_mask = MT7927_RX_DONE_INT_ENA7,
 	},
 };
+
+static int mt7927_chip_init(struct mt792x_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	u32 val;
+
+	/* EMI sleep protect */
+	mt76_rmw_field(dev, MT_HW_EMI_CTL, MT_HW_EMI_CTL_SLPPROT_EN, 1);
+
+	/* WF subsystem reset via CBInfra RGU */
+	mt76_set(dev, MT7927_CBINFRA_RGU_WF_RST,
+		 MT7927_CBINFRA_RGU_WF_RST_WF_SUBSYS);
+	msleep(1);
+	mt76_clear(dev, MT7927_CBINFRA_RGU_WF_RST,
+		   MT7927_CBINFRA_RGU_WF_RST_WF_SUBSYS);
+	msleep(5);
+
+	/* MCU ownership */
+	mt76_wr(dev, MT7927_CBINFRA_MCU_OWN_SET, BIT(0));
+
+	/* Poll ROMCODE_INDEX for MCU idle */
+	if (!__mt76_poll_msec(mdev, MT7927_ROMCODE_INDEX,
+			      0xffff, MT7927_MCU_IDLE_VALUE, 2000)) {
+		val = mt76_rr(dev, MT7927_ROMCODE_INDEX);
+		dev_err(mdev->dev,
+			"MT7927 MCU idle timeout (ROMCODE_INDEX=0x%04x)\n",
+			val & 0xffff);
+		return -ETIMEDOUT;
+	}
+
+	/* MCIF remap - MCU needs this to DMA to host memory */
+	mt76_wr(dev, MT7927_MCIF_REMAP_WF_1_BA,
+		MT7927_MCIF_REMAP_WF_1_BA_VAL);
+
+	/* Disable PCIe sleep */
+	mt76_wr(dev, MT7927_CBINFRA_SLP_CTRL, 0xffffffff);
+
+	/* Clear CONNINFRA wakeup */
+	mt76_wr(dev, MT7927_CBINFRA_WAKEPU_TOP, 0x0);
+
+	return 0;
+}
+
+static void mt7927_cbtop_remap(struct mt792x_dev *dev)
+{
+	/* CONNINFRA wakeup - required before CBInfra register access */
+	mt76_wr(dev, MT7927_CBINFRA_WAKEPU_TOP, 0x1);
+	usleep_range(1000, 2000);
+
+	/* Configure CBTOP PCIe address remap for WF and BT */
+	mt76_wr(dev, MT7927_CBINFRA_MISC0_REMAP_WF,
+		MT7927_CBINFRA_REMAP_WF_VAL);
+	mt76_wr(dev, MT7927_CBINFRA_MISC0_REMAP_BT,
+		MT7927_CBINFRA_REMAP_BT_VAL);
+
+	/* Readback to push writes */
+	mt76_rr(dev, MT7927_CBINFRA_MISC0_REMAP_WF);
+}
 static int mt7925_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -482,6 +540,17 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 		goto err_free_pci_vec;
 	}
 
+	/* MT7927 firmware lacks the connac2 feature trailer, so
+	 * mt792x_get_mac80211_ops() can't detect CNM support and
+	 * replaces chanctx/ROC/mgd_prepare_tx ops with stubs.
+	 * Force CNM and restore the original mt7925 ops.
+	 */
+	if ((pdev->device == 0x6639 || pdev->device == 0x7927) &&
+	    !(features & MT792x_FW_CAP_CNM)) {
+		features |= MT792x_FW_CAP_CNM;
+		memcpy(ops, &mt7925_ops, sizeof(*ops));
+	}
+
 	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev) {
 		ret = -ENOMEM;
@@ -517,25 +586,43 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 
 	if (!mt7925_disable_aspm && mt76_pci_aspm_supported(pdev))
 		dev->aspm_supported = true;
-
 	ret = __mt792x_mcu_fw_pmctrl(dev);
 	if (ret)
 		goto err_free_dev;
 
-	ret = __mt792xe_mcu_drv_pmctrl(dev);
-	if (ret)
-		goto err_free_dev;
+	if (!is_mt7927_hw) {
+		ret = __mt792xe_mcu_drv_pmctrl(dev);
+		if (ret)
+			goto err_free_dev;
+	}
+
+	if (is_mt7927_hw)
+		mt7927_cbtop_remap(dev);
 
 	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
 
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
-	mt76_rmw_field(dev, MT_HW_EMI_CTL, MT_HW_EMI_CTL_SLPPROT_EN, 1);
+	/* Force chip ID for MT7927 hardware if CHIPID read returns garbage */
+	if (is_mt7927_hw && (mdev->rev >> 16) != 0x7927) {
+		dev_info(mdev->dev,
+			 "MT7927 raw CHIPID=0x%04x, forcing chip=0x7927\n",
+			 (u16)(mdev->rev >> 16));
+		mdev->rev = (0x7927 << 16) | (mdev->rev & 0xff);
+	}
 
-	ret = mt792x_wfsys_reset(dev);
-	if (ret)
-		goto err_free_dev;
+	if (is_mt7927_hw) {
+		ret = mt7927_chip_init(dev);
+		if (ret)
+			goto err_free_dev;
+	} else {
+		mt76_rmw_field(dev, MT_HW_EMI_CTL,
+			       MT_HW_EMI_CTL_SLPPROT_EN, 1);
+		ret = mt792x_wfsys_reset(dev);
+		if (ret)
+			goto err_free_dev;
+	}
 
 	mt76_wr(dev, irq_map.host_irq_enable, 0);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
index 1626a3684082..9b3eeb1328f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
@@ -72,6 +72,15 @@ int mt7925e_mac_reset(struct mt792x_dev *dev)
 	const struct mt792x_irq_map *irq_map = dev->irq_map;
 	int i, err;
 
+	/* MT7927: CLR_OWN and WPDMA reset destroy DMA ring configuration.
+	 * A full reset requires re-running mt7927_dma_init() which is not
+	 * yet implemented in the recovery path.
+	 */
+	if (is_mt7927(&dev->mt76)) {
+		dev_warn(dev->mt76.dev, "MT7927 mac_reset not supported, reload module to recover\n");
+		return -EOPNOTSUPP;
+	}
+
 	mt792xe_mcu_drv_pmctrl(dev);
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
index 6cceff88c656..1f50d1ef6fb6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
@@ -35,13 +35,21 @@ int mt7925e_mcu_init(struct mt792x_dev *dev)
 
 	dev->mt76.mcu_ops = &mt7925_mcu_ops;
 
-	err = mt792xe_mcu_fw_pmctrl(dev);
-	if (err)
-		return err;
+	if (is_mt7927(&dev->mt76)) {
+		/* MT7927: CLR_OWN was already done in mt7927_dma_init().
+		 * The ROM re-initializes WFDMA on every CLR_OWN, wiping
+		 * ring and prefetch config. Skip SET_OWN/CLR_OWN here
+		 * to preserve DMA state.
+		 */
+	} else {
+		err = mt792xe_mcu_fw_pmctrl(dev);
+		if (err)
+			return err;
 
-	err = __mt792xe_mcu_drv_pmctrl(dev);
-	if (err)
-		return err;
+		err = __mt792xe_mcu_drv_pmctrl(dev);
+		if (err)
+			return err;
+	}
 
 	mt76_rmw_field(dev, MT_PCIE_MAC_PM, MT_PCIE_MAC_PM_L0S_DIS, 1);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index 1b9b51d43f79..9c4bbbe898f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -499,4 +499,22 @@
 #define WFSYS_SW_RST_B			BIT(0)
 #define WFSYS_SW_INIT_DONE		BIT(4)
 
+/* CBInfra registers - MT7927 combo chip */
+#define MT7927_CBINFRA_WAKEPU_TOP		0xe01a0
+#define MT7927_CBINFRA_MISC0_REMAP_WF		0x1f6554
+#define MT7927_CBINFRA_MISC0_REMAP_BT		0x1f6558
+#define MT7927_CBINFRA_RGU_WF_RST		0x1f8600
+#define MT7927_CBINFRA_RGU_WF_RST_WF_SUBSYS	BIT(4)
+#define MT7927_CBINFRA_MCU_OWN_SET		0x1f5034
+#define MT7927_CBINFRA_SLP_CTRL			0x1f5018
+#define MT7927_ROMCODE_INDEX			0xc1604
+#define MT7927_MCU_IDLE_VALUE			0x1d1e
+#define MT7927_MCIF_REMAP_WF_1_BA		0xd1034
+
+/* CBInfra CBTOP remap values */
+#define MT7927_CBINFRA_REMAP_WF_VAL		0x74037001
+#define MT7927_CBINFRA_REMAP_BT_VAL		0x70007000
+
+#define MT7927_MCIF_REMAP_WF_1_BA_VAL		0x18051803
+
 #endif /* __MT792X_REGS_H */

-- 
2.53.0


