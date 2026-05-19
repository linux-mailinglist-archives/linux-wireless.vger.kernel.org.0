Return-Path: <linux-wireless+bounces-36650-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM+xBaIRDGoZVQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36650-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:30:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 612865791D6
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7987130F8A2E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73853D3CFB;
	Tue, 19 May 2026 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZapgHjqR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82953D47C6
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175488; cv=none; b=qXjYxdzWv3jaIikD5UQgB4u0Bp1VUQSBQDxMAncQ64ovRSGDlceWKPxir0rT5ymFU+BYgXtN40FGd+eOBpdgrRWnicsnW83U753a4+Th4BZ9xqU8HIMq+mShrLHnXYajZ/r0LyA1DPfz4z2nahvwopAVhJ4ax1FFjCllmnXjriQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175488; c=relaxed/simple;
	bh=8qUbwbBFT7bVcWHxVfl3oSakpv8QaULn8YYEOZrmxSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwdU6QlS9t93F56T45KGx2PE1Me2WNsCboanfxG34LLACson+5m8FcT5hoRzyfy/Hw8qSoJFq7qtOoAseLAsFpP0Wbh5YV/wrrbJVU8zaebpzIiuX4BozdLE7vaM6pZLfFkoysrtRY2rq+Z1MCo3RGR//8fYIkumF9W/RMZhqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZapgHjqR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64J7OXWg82916586, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779175474; bh=yPFbW0fcMXPRPv+0gXdCsnHuBFf+HybPLYmc5zA2Mek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZapgHjqRDBcU9/VnJ7SDEIjpp0Udr03t/LfXaZ0R9zBqmKaKOR6QmVpErCwojdWLH
	 FAtxFH58m0DHaSdZh9IekPBWtfhVXNUrqPlKWwwqeq3/0Kqyti9aRZIid/O7InQZj5
	 V6ziX8yp00b4obQ/endb5VExiy5XCspeINOTE449cpET+wiRu9h5TcDfqpnfcHxLaw
	 UqahbZUDxOOmVLQ/oxFauOp0EThcuoQW0VhyvwN4W1BbLE19k/vxeLUQk0vPzw5K5s
	 ENmcGEkkJwuy7eMUN+aBd+NrZG59WGuisplZYsdow34V4NKHBGFJK5uTFc2OKIk+ZB
	 hmlI2FBVRfJGg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64J7OXWg82916586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 15:24:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 May 2026 15:24:34 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 May 2026 15:24:34 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 19 May 2026 15:24:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <wenjie.tsai@realtek.com>
Subject: [RFC rtw-next 2/2] wifi: rtw89: usb: add sysfs write example
Date: Tue, 19 May 2026 15:24:15 +0800
Message-ID: <20260519072415.25746-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260519072415.25746-1-pkshih@realtek.com>
References: <20260519072415.25746-1-pkshih@realtek.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36650-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,realtek.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 612865791D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johnson Tsai <wenjie.tsai@realtek.com>

Add a simple echo_sum sysfs attribute on the USB interface device as
an RFC example for discussing whether a writable sysfs interface is
acceptable for this driver.

The attribute accepts two integers from userspace, stores their sum in
driver private data, and exposes the result.

Signed-off-by: Johnson Tsai <wenjie.tsai@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 38 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/usb.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 53dcb84af5c0..566618e9f3b8 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -1059,6 +1059,43 @@ static void rtw89_usb_intf_deinit(struct rtw89_dev *rtwdev,
 	usb_set_intfdata(intf, NULL);
 }
 
+static ssize_t echo_sum_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct ieee80211_hw *hw = usb_get_intfdata(intf);
+	struct rtw89_usb *rtwusb;
+
+	if (!hw)
+		return -ENODEV;
+
+	rtwusb = rtw89_usb_priv(hw->priv);
+
+	return sysfs_emit(buf, "%u\n", rtwusb->echo_sum);
+}
+
+static ssize_t echo_sum_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct ieee80211_hw *hw = usb_get_intfdata(intf);
+	struct rtw89_usb *rtwusb;
+	int a, b;
+
+	if (!hw)
+		return -ENODEV;
+
+	if (sscanf(buf, "%d %d", &a, &b) != 2)
+		return -EINVAL;
+
+	rtwusb = rtw89_usb_priv(hw->priv);
+	rtwusb->echo_sum = a + b;
+
+	return count;
+}
+static DEVICE_ATTR_ADMIN_RW(echo_sum);
+
 static ssize_t hw_info_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
@@ -1089,6 +1126,7 @@ static ssize_t hw_info_show(struct device *dev,
 static DEVICE_ATTR_RO(hw_info);
 
 static struct attribute *rtw89_usb_attrs[] = {
+	&dev_attr_echo_sum.attr,
 	&dev_attr_hw_info.attr,
 	NULL,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
index bdf312559743..9eba6264a9a2 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -87,6 +87,8 @@ struct rtw89_usb {
 
 	struct sk_buff_head tx_queue[RTW89_TXCH_NUM];
 	atomic_t tx_inflight[RTW89_TXCH_NUM];
+
+	u32 echo_sum;
 };
 
 static inline struct rtw89_usb *rtw89_usb_priv(struct rtw89_dev *rtwdev)
-- 
2.25.1


