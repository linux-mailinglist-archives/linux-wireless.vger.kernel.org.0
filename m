Return-Path: <linux-wireless+bounces-34616-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEm7LvH42Gm1kQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34616-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 15:19:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 349513D80B8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 15:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCBAB3010506
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B4329AB02;
	Fri, 10 Apr 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z1gNFicO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE1B346E55
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826844; cv=none; b=NlPdBbzw29xhbC6l2JdMVQFcHuqxeEuqruGIjTM2Ltis4ewbVE6OzcSrf3Xn2YALvG0/LdXSBrvxxQiXaNsE6j4UC6Ykwi7pd3a2UtlmKZ57+lGS436X6ZUyIDGF9RA8QMY6Q70/JjrBGgNO/m1D3A13bcswqYOTcTJQDh2rG3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826844; c=relaxed/simple;
	bh=fLup4mn7uE4phDGpFPumU36mMrpljvCxPlJE7AZYGYw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G3cRC7IMkCGHzrQreqBnx8HgyPNyzEanwxXAo+070i200hnPmmB6SAn7+azsJhA7TbQaiyo8GdmVhnJKdPQSKBW9hJemBalpWzdf/86AukjoXdp2CdGicKqYNqyMXFnPfLWE7cdLRPLHvYJfxF/oFaBVtkUDhAwrKPSWofkURVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z1gNFicO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63ADDrOjA3040427, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775826833; bh=LJGZeVofc0Kg/KJI1CQmO3FXUXy6zXV9sc4YUmMxvQk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Z1gNFicODpOV0AVj47axllStX0i+ERuU4ZA70fBPq1QwDr6oJOs/9zVJZk5LLv96K
	 Uf3s+LDQRAvKuBTzPALfq1Y1QscmGyn5LLj8mfKbG00vnQvdG4hPkjty/2hudvh10+
	 rQbbGHrhxZ7j2JchNZ6U2fq7IWETm0hNJ2BwFeahCEGMpisWpgKI5/EUwWfAVnTzjw
	 Z5N/fBC4PnpeETS2Pne9S7+oG8PhZyNTsGhklgjMxnO2BT+HsqflhI3afwb4UW7dX8
	 6+gPOfteKaZZMlkIMDoO1ff8Bc6SpZ6pb7ZnZC6UxuLhipii/LLL7nR47zLHUbUtov
	 stp7TbA9CJ9+Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63ADDrOjA3040427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 21:13:53 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 10 Apr 2026 21:13:54 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 10 Apr 2026 21:13:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>, <lkp@intel.com>
Subject: [PATCH rtw-next] wifi: rtw88: 8814a: add __packed to ensure efuse map size
Date: Fri, 10 Apr 2026 21:13:53 +0800
Message-ID: <20260410131353.1550803-1-pkshih@realtek.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34616-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,intel.com];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 349513D80B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All nested sture/union used by efuse map should be packed. Otherwise, a
arm-linux-gnueabi-gcc compiler might throw errors due to size assertion.

   In file included from include/linux/bitfield.h:10,
                    from include/linux/fortify-string.h:5,
                    from include/linux/string.h:389,
                    from include/linux/uuid.h:11,
                    from include/linux/mod_devicetable.h:14,
                    from include/linux/usb.h:5,
                    from drivers/net/wireless/realtek/rtw88/rtw8814a.c:5:
>> include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct rtw8814a_efuse) == 512"
    #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                            ^~~~~~~~~~~~~~

Fixes: 1a7545784642 ("wifi: rtw88: Add rtw8814a.{c,h}")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604101721.fsv5XmCX-lkp@intel.com/
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 9c0b746540b0..3cc7c2666c1c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -471,7 +471,7 @@ struct rtw_2g_txpwr_idx {
 	struct rtw_2g_ns_pwr_idx_diff ht_2s_diff;
 	struct rtw_2g_ns_pwr_idx_diff ht_3s_diff;
 	struct rtw_2g_ns_pwr_idx_diff ht_4s_diff;
-};
+} __packed;
 
 struct rtw_5g_ht_1s_pwr_idx_diff {
 #ifdef __LITTLE_ENDIAN
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814a.h b/drivers/net/wireless/realtek/rtw88/rtw8814a.h
index c57c7c8f915e..a0d9446e2043 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8814a.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8814a.h
@@ -51,7 +51,7 @@ struct rtw8814a_efuse {
 	union {
 		struct rtw8814au_efuse u;
 		struct rtw8814ae_efuse e;
-	};
+	} __packed;
 	u8 res5[0x122];			/* 0xde */
 } __packed;
 

base-commit: 929298742bb5dfacd53ea99cf989cc81210f90a3
-- 
2.25.1


