Return-Path: <linux-wireless+bounces-33518-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJHrEsB3vGmFzAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33518-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:25:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 047FC2D2F1B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 952ED3028350
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 22:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBBC3FF881;
	Thu, 19 Mar 2026 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="T/oMt3gL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="17Mzejps"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDD73BAD83;
	Thu, 19 Mar 2026 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959070; cv=none; b=jgC8dJUrySX2iTy1lnEb80O0mludv58r8MtdnKRMjda6Ci4cItCv34Rdv7Tu3Tdx13U7dSovpk+8n1cS8g6Kx1MZmByDCKHN7DT/bk+m0zPxL8qBkZm7xiwR57N8E8eShTQ1A1qotxbxYrLix0hBjorUUvAG+EDxzNbtZ6dhz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959070; c=relaxed/simple;
	bh=oL0xrbX2LUVp9Q4JBTD78nnciF3VWT3fiWIhBG52oaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=SWxti97YDiEbWslIjck8aq/PyWuUq79mEGrcX/NVFUYXajXl1eoKOZkl4jbhH3VeKVU+fVxpYTBfaAFJnhHsG4TxDPkDB8mrkpsKxUWEavPmwa1LB1MPUeWgbNcaT+Ta2fygeZLAKZpBen1DsqGRRiqjLNjtC6uGKoqE5ITQigI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=T/oMt3gL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=17Mzejps; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 553FA1300099;
	Thu, 19 Mar 2026 18:24:24 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 18:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773959064;
	 x=1773966264; bh=HOxwP/LFDi9G4GG/ESf696AKYCs6uY6IFgrUHF+9MxA=; b=
	T/oMt3gL6vM5XXXD5iGStXtepG7MEvbatbKheqegwW7Vg764fLCnhmbcN4FYeJe1
	Lk4a/1Rx1zMQWhz8uIjoUImsW4lKbfgwZ9bzZyIgKN4bTnmdpt73wIChGGLJ2B6U
	Ume1BeGOfaYxzmM8Y5pkrNjqi+BJ3DfENwu+ydY6BWGPIY1JsmezEzKB+5SvZwF8
	pn42YKI95c1haR64+yiI+BTUa/PJxJmjCB1ZKGN7rLE5VnQgGMUYXoGWgNPtVTep
	1gfCkuw/0YPqBMB6H8oi/X/yAeOrtZgGKV+yHlrpvBclNHkMCeOdY2jfBsOiOqmA
	wrOMJ1+A4/7PMwp+2e0A9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773959064; x=
	1773966264; bh=HOxwP/LFDi9G4GG/ESf696AKYCs6uY6IFgrUHF+9MxA=; b=1
	7Mzejps7pfm4JolCitPkFvEMYpOECckpx2Xxv2G5+gr9rztvjKA1QkdIzKMrAcez
	a4RStBPIJDsrIZbsDh3HU/Q2EC+qZOO1LQCOsMkLkB+AFOFc6zcwFt7mLm7C3aHs
	t55nb3ru6ALzTTo/j5fT5S1bUWiWbY6wt/OM1hZWQ2haDVu2/yj7/6HEdXUYOQHq
	THAqfvXAn6boOV8jdMKyQFkGbmAYNnFSk27BngNRD6QbCj+pbvESLpErEkfHVDv4
	J4zVXW19rtx2kFiOSsi96zJ8QrwC8sNvZQ7i/JRZhzPGcttn2apbyfeehMNlLtCM
	t6N5NFTOS3e7tZ4lTa7Fg==
X-ME-Sender: <xms:mHe8aXB2Wi0nInlKHZnaVx21FGYv6qiTwu3kXEpWojxP5NS_CUe17g>
    <xme:mHe8aYXhu8DaIypZXm43LNtC9J0pHl4EUvzydo1rvgwqlgyvByxYR0aru6oEqPVuQ
    a8EEFrynHfiBH3zdrsg_sgSTrrrv6ARdgM_JTHb3eHos70gu1t3QOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvddtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:mHe8aVwNloYeBmD6iy8w1XbRZKTESA0ZCjLgAa-IhUL4p8YANYd0mQ>
    <xmx:mHe8aSev7Ew-aFBx-08S3PKjHa2zkQd_c9Om5VF2HMeKKHi7sWHLCg>
    <xmx:mHe8aT0Wz6eg-bsjNbSPSIzM1eujrhpDWQ1Q5z8qrjwKToRSb0HtFA>
    <xmx:mHe8aTtNLP1ukgfki_ooo7c0tWmkJ-7StRZHszX-LQrPG0AuKpzqTg>
    <xmx:mHe8aTTBiPAinZ6bu6JrtsNkuU_b-VNIklB-pT0HzqchHXVlVGTRvtus>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 079371EA006B; Thu, 19 Mar 2026 18:24:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 19 Mar 2026 16:24:18 -0600
Subject: [PATCH v2 02/13] wifi: mt76: mt7925: add 320MHz bandwidth to
 bss_rlm_tlv
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260319-mt7927-wifi-support-v2-v2-2-d627a7fad70d@jetm.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=floss@jetm.me;
 h=from:subject:message-id; bh=oL0xrbX2LUVp9Q4JBTD78nnciF3VWT3fiWIhBG52oaU=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpvHeQM1UeD5VnQ9wjqUu6j/sz7dtyOhS1NJNEN
 lYq+/tgNP6JAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCabx3kAAKCRC17sMLqGd3
 H80aC/wNHmTjAL+3tuCHYF3BJwsK1kXW2AJneZctvf+yz6XnZplPXeP7GVTKx4FRlCySIe3j19Q
 fL0rxBVomu481PG0T5dbnnc4xfQUAAU/XCWSPO0Uvq91v2AFqWd5WT62TV7mfnPIz6lWKEEeHDA
 uBY1W3X8wMx4Tsyg0daublZniuAb/BIExbmt/EvEdoAd9nc+M7DG/LUawdCsrLs6kjqcqm9hnvT
 vc4LS5j8am88h9FLdmLfrMWraELq1ljKr0FtNDrwHNyobVSal/B6/ODqNpaQ+g0bEpHplo3BuTf
 MMSVYmMawfcU5K+v0TY2mzEld2/PwQWVeW0O4kZT192QEDqvejbaU/JbXhkveyI5LkEFtc5fMGq
 g8NbBV2KvoCHR1DcMC2JPLD3lOGSI7P0SS9fLJOsD8L7RQ/P1wX4n7SKWA6Hdcd6yXJZ6IMzTvI
 9iRjrCgvWPfZCuRVUWkcFqBxn/02CmmhAO8OkNKzhFucqogxIIDCbwK/2kcCm76UgddUM=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
References: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me>
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
	TAGGED_FROM(0.00)[bounces-33518-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.146];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,lgic.pl:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,humeurlibre.fr:email]
X-Rspamd-Queue-Id: 047FC2D2F1B
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


