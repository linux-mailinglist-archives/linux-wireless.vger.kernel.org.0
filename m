Return-Path: <linux-wireless+bounces-36849-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMjLKUOjE2qhEQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36849-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 03:17:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 249AA5C527B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 03:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6F52300130D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 01:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD6A1EEE6;
	Mon, 25 May 2026 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wjipr6eL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0736FC3
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671872; cv=none; b=M+0QXaS4/53FjUp5D6CbqHl9TXq21YbkXU66IcX6pRWK+JxmmX++O7d+HDLk0yN1ABovVXcyABOlwPhlNrGxEt6yC/1jj/ZplDDr7JYynQKKFVkSEXH/EC3agGz2wG6gpvAjyUZz4yOT8KLmJupiN4hbUr2S7kwfA65JtrOz73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671872; c=relaxed/simple;
	bh=seyIhuMXh8N05yMB41NWtNFSIQNIlq7E5Jpumnj73e8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ve6wzKzN2dC89KSYOZmrsxZ/RW9JGFVbLCW3RIigo6RXNJfweDy/q6roiVIssHBM489UD/A7hYqnxGmUXsjvoZezUTjucmI0/7w3+96WtyjF8kNADbC5LY1gsaHZaDWjpR1Cz0N3l1/dcUAmQNvtiZarVKRALcV46ySqBW7xruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wjipr6eL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64P1HjImA565764, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779671865; bh=vxRP6MdDIr/uGAYbS0yfwiS1L0fVbIP/ixG/7zXz53g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=wjipr6eLuK4AtaisuPpb6IxvGF5lT/IO4J5oqVjvLbuBi15L969LrnewpuCP0i3NH
	 zHLOABB1UdMcBWjujj63uzOC0m41Y1xCe4hqe6Y9/cDXc6YxCXZ4kIS5f3mzdkLgfQ
	 tTS7n9jysNFvh4hZlvKr5Q25aR+fniZsn1RQyDMMpGPbwN4E+DbwPDD2ZCQlZBjxWe
	 IYciRyFrtzqRUvDxwdcDK0MUbyMEyafepgc2lCIyEoeSiOBilbpHB9VuLSH9MryS90
	 6CQEa6NAUIX9gLVEGEebrMmRyBIRoyYlzKJA0971DC1P4SmgNLbMSQubJfyGJE2WSk
	 W6AY2/Fa3MVfg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64P1HjImA565764
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 09:17:45 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 09:17:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 09:17:45 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 25 May 2026 09:17:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <guillem@gservera.com>
Subject: [PATCH rtw-next] wifi: rtw89: 8851bu: add Mercusys MA60XNB (2c4e:0128)
Date: Mon, 25 May 2026 09:17:28 +0800
Message-ID: <20260525011728.6836-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36849-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:mid,realtek.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 249AA5C527B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the specific USB device ID which adapter tested fully functional on
Fedora 44 with kernel 7.0.8-200.fc44.x86_64 and linux-firmware
20260410-1.fc44.

Reported-by: Guillermo Servera Negre <guillem@gservera.com>
Tested-by: Guillermo Servera Negre <guillem@gservera.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index 6a8d31544314..14f1b703902f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -44,6 +44,9 @@ static const struct usb_device_id rtw_8851bu_id_table[] = {
 	/* D-Link AX9U rev. A1 */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332a, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
+	/* Mercusys MA60XNB */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2C4E, 0x0128, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
 	/* TP-Link Archer TX10UB Nano */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010b, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },

base-commit: 7076af642955693935e60bc94546d105fb0395ca
-- 
2.25.1


