Return-Path: <linux-wireless+bounces-33750-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCzCDATlwWkYXwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33750-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 02:12:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A00BD3005A4
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 02:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43B5130614D7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D834DCD7;
	Tue, 24 Mar 2026 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DsjJixMt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3662F261C
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314626; cv=none; b=mkpffp5/fYOVv1kV/mef48Pdgwn4+MN/8qcsXTg3JoCES5UJX2M6y1FaPlGXeYvlG+AE8Pr4nDlJ2UVvrE2hg1d3HIZFYEcy6IAKYTw4Rrs38Ctnylz5JajhBn5ouyDwSjlejFfjL5ZsUgmBCd4wjOV1WrvhjwuRU0YB1PS/LyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314626; c=relaxed/simple;
	bh=jtetcB+ufsNkfTBUJUPl9NB3q3PKF8la9lo7fT0D6Ik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KooaknT91rs3tY3npRVqQIAckEAH3AnGTzjngERcMFLCxur32tHXT0WB9LV7qS3UhUIsxG4nNsYhTPUGRMIAPelnultrSIqa1MNu4iiFQc/dqc8HAn3VcQz4Qada37DOdejDOLFmStIVnIrukW9XsEKjpLZ3m2ZBaoP+VdwFAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DsjJixMt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62O1AKvbC102703, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774314620; bh=08v+c9T1vYr7yu0Png31c4VQTwlgIl6wk5RXs83iGnI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=DsjJixMtDlUiRAlEJWC0Xs20rbgR7n9243o1Iul8gUznSbx3TPHO/qAjv1AsJjl5O
	 xkZcl+WpqPA9nD2kNbhXBSeDeSljZtdgRcOhlYR/1QmR3FyVTWzFans8qXC84FoXJU
	 E4advcc96Qh4BmkB/sBFe9MYYWe72x7itnQ5KppAnuxyByRA/aBNomr+7YvLLsjmXQ
	 sEGPDvMJuLOm3N1x1D//BURXS3I+S5AvjV9CPI72mcWTeaaGLWS5UmhDpubTd8zhEF
	 ZB+dr/mZkqHHVlQM4wamgiJqMjmp/4LqMdCkjGdTdcBw4H/myteP8rru5+zl50DRBB
	 d8laO4gLC/pxQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62O1AKvbC102703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 09:10:20 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 09:10:20 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 09:10:20 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 24 Mar 2026 09:10:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <goainwo@gmail.com>
Subject: [PATCH v2 rtw-next] wifi: rtw88: validate RX rate to prevent out-of-bound
Date: Tue, 24 Mar 2026 09:10:01 +0800
Message-ID: <20260324011001.5742-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33750-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A00BD3005A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The reported RX rate might be unexpected, causing kernel warns:

  Rate marked as a VHT rate but data is invalid: MCS: 0, NSS: 0
  WARNING: net/mac80211/rx.c:5491 at ieee80211_rx_list+0x183/0x1020 [mac80211]

As the RX rate can be index of an array under certain conditions, validate
it to prevent accessing array out-of-bound potentially.

Tested on HP Notebook P3S95EA#ACB (kernel 6.19.9-1-cachyos):

  - No WARNING: net/mac80211/rx.c:5491 observed after patch.
  - System remains fully stable through idle, load, Bluetooth A2DP
    usage, and multiple suspend/resume cycles.
  - Zero H2C or LPS errors in dmesg.

Reported-by: Oleksandr Havrylov <goainwo@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com/
Tested-by: Oleksandr Havrylov <goainwo@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - add Tested-by collected from v1.
  - add unlikely().
---
 drivers/net/wireless/realtek/rtw88/rx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 8b0afaaffaa0..d9e11343d498 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -295,6 +295,14 @@ void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
 
 	pkt_stat->tsf_low = le32_get_bits(rx_desc->w5, RTW_RX_DESC_W5_TSFL);
 
+	if (unlikely(pkt_stat->rate >= DESC_RATE_MAX)) {
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


