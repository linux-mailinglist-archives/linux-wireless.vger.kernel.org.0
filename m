Return-Path: <linux-wireless+bounces-33670-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ82JoKewGnrJAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33670-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 02:59:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC142EBC15
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 02:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 722D03006087
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 01:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A991EB5E3;
	Mon, 23 Mar 2026 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vihjWNhq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A91F0E25
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774231153; cv=none; b=ZRMoJvhbMP1IIiTaZvn7JWBKirp5jnGHgBgQ+SIzK1ltA0qvnRmw5j8TcwaMtwFjasfbgnVnGk50UH/Ha7geAVQKuivWsxqrotUnZTbtYd+7+IwG5icYXWQ99MaJ5cEmUgthtxwwtejO20eHvAYUmOpxA/3KTKQTk7Z3wimVE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774231153; c=relaxed/simple;
	bh=J3c0yByM1p90Gm0qQyxDolae/WfWAv6t5Gz/Tyg3D3Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g0hRAsCNBqL00YSypFTbJ6/cert4mSybMBx49li5cvIvbCnslM8z9/XWAtGwXLWxkYz4AxL3dqVSnuYGC+xomr/dj3hGnbhtWCLguQ5CyBg6ZLJuKSBZ1INnWuiuc5Z1KPu7cdY3ed2T+ZKXyxYySydlkmPJEpAIEfBcg2MysTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vihjWNhq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62N1x7W512232695, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774231147; bh=dDRKUKJl8IKJBumPa98Qeft2tqyS4PjJdflK0WCwRsw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=vihjWNhq43ocS/fXRaE3sH4MMMjnyX1OvU1L/02jfncslC1Nonzv+5wkx+ZKKjuIB
	 PPy9ZXTMB2Vagjw/eK6rwTA9L6NCwqJw0G/MyWOWtVicCgc7apykz7AfdnIUErpzw6
	 L42171eYS2LmV1NwmFQN8X1TZGMy6EA6KaVWlvtkgTomiXoKQQwyHuZ3oWR9lW/Xo6
	 KtxkGRB/UpGCouiGkwb/CZHRhxts+DR+JwZDtRPA/6F4Kj+YjsHiTerx2s6DXv8A8u
	 jgrXSqXcs0Zw+4QGxL24o6vxOZcm96k4nvyctxk/pI2X2+yjPWRh8GBzBjhKuGuGoq
	 ZK4yUvMrUwQcg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62N1x7W512232695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 09:59:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 09:59:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 09:59:07 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 23 Mar 2026 09:59:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <goainwo@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw88: validate RX rate to prevent out-of-bound
Date: Mon, 23 Mar 2026 09:58:49 +0800
Message-ID: <20260323015849.9424-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33670-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BCC142EBC15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The reported RX rate might be unexpected, causing kernel warns:

  Rate marked as a VHT rate but data is invalid: MCS: 0, NSS: 0
  WARNING: net/mac80211/rx.c:5491 at ieee80211_rx_list+0x183/0x1020 [mac80211]

As the RX rate can be index of an array under certain conditions, validate
it to prevent accessing array out-of-bound potentially.

Reported-by: Oleksandr Havrylov <goainwo@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com/
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 8b0afaaffaa0..41f6557d8d78 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -295,6 +295,14 @@ void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
 
 	pkt_stat->tsf_low = le32_get_bits(rx_desc->w5, RTW_RX_DESC_W5_TSFL);
 
+	if (pkt_stat->rate >= DESC_RATE_MAX) {
+		rtw_dbg(rtwdev, RTW_DBG_UNEXP,
+			"unexpected RX rate=0x%x\n", pkt_stat->rate);
+
+		pkt_stat->rate = DESC_RATE1M;
+		pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
+	}
+
 	/* drv_info_sz is in unit of 8-bytes */
 	pkt_stat->drv_info_sz *= 8;
 

base-commit: eef6d4449e8a540fde792968a26d8aa514af8089
-- 
2.25.1


