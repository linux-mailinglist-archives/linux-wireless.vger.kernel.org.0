Return-Path: <linux-wireless+bounces-35000-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMZTLYCg5WkqmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35000-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:41:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA90426941
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EF743011846
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E564E37F75A;
	Mon, 20 Apr 2026 03:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Xin1rA3z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D002BDC0F
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656509; cv=none; b=AU9+LflnvhsO7jp+0jTU+B1zufaECS7b0rd4we9EB2Dxrvx7Am7U1xBBI6boX4fLA6sq4BhDr15Ov80pXU6fPi+09hqdR0QFCksIG1skN2udmsoedOaxbuS/iCEzKDCRr41w8jbQ6ZkBXqsTMiRLt9b350B7nY7s6TU7SZfslfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656509; c=relaxed/simple;
	bh=PIAzBE3pxmc8mU+CxlyYeIBOJr9FiJ0WSps8NxcXAaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCgvU8mI0DEXNEd8WMssnEJVjIo7kibwVoqfTBHzPf5bC741B1ZLPverw/E0DpwG8eYu0VkV8X6KreVmuY/q9WeFruxLy8ZpqzzbMEbZXOcOBrD2vYlVAo0MI0ZkVt/81l8HsWfYvVXrtPlO1TwiZCOsLM2x2wlptieCEcTfIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Xin1rA3z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3fkSA3426814, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656506; bh=rb+gl9rKptgQwYD49bTOgWK6TIVs8totaOCaYiw2+oY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Xin1rA3zrPLfMb4Wx3PeBSOqO9wZHyIduTxix1AUEHszg+0bxVpVFjGeWFO22CHJl
	 VrM3O2Ctpf4OR7gHlzl2h+h5kFIHbo7YRN1yn8lVjA3DYvSzJxKDHjuz6xVjl0aUkO
	 I94QJ89DfStveqjBw7TflQmn96ECFTzN/z2+HYzulJKkX7MRzYU5onxtXDfJLU0xq5
	 uveh1RnbnrC6tNpjsU6kSONguzDTnWYaWfjFFmoDUQ8D3NFgqcbWAsEQSZhMg7YJLz
	 dXoRp2tfo7rABBUbP5X/NhJvWFzMQIbRq8eWN64hB8xtjZ5QRTBbUIntB9K4ukxVJM
	 CkrMm5wIQa7Fw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3fkSA3426814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:41:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:41:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:41:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 07/16] wifi: rtw89: 8852bt: configure support_noise field explicitly
Date: Mon, 20 Apr 2026 11:40:42 +0800
Message-ID: <20260420034051.17666-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-35000-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3AA90426941
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zong-Zhe Yang <kevin_yang@realtek.com>

RTL8852BT missed to configure support_noise field in chip_info.
Although RTL8852BT doesn't support that, add the configuration
to make things clear.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index ab4263bc8b9f..0d980fcd22d4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -811,6 +811,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.support_ant_gain	= true,
 	.support_tas		= false,
 	.support_sar_by_ant	= true,
+	.support_noise		= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_from_ie	= true,
-- 
2.25.1


