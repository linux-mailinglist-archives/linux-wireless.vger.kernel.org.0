Return-Path: <linux-wireless+bounces-39126-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6ITjMwMkV2pSFwEAu9opvQ
	(envelope-from <linux-wireless+bounces-39126-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 08:09:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B4875AD7A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 08:09:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39126-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39126-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43514303D329
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 06:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8954133DEE5;
	Wed, 15 Jul 2026 06:08:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5393093CF;
	Wed, 15 Jul 2026 06:08:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095727; cv=none; b=dIUpabJTBd7uNZL6mQYJWi0ZAMYo2BG9t3zCm4XXTxRpeow3phPUpranAEq3DvnQCDLHqaYtGBc3KfzjzGIflueX6T+Bj8y9gCcGTGBNkUA2DEvkqJj8jnKozhKJwGrUdR5dSuzEdhWQVEI8OemqjjmV5OY7FXchsiCmFqgQGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095727; c=relaxed/simple;
	bh=0HcfKZ2hi0yKXUiVc4SyQj57rp1umApG+q60fNw4U4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cTVh0a9gkHLuqz55Iv4OW5HOSFcZsup5/aXsWzAuANQVSdJIJcjpcwkaTfOthTp12xrU5SEa8l4+LaIjtjU6t1Z2XHz2MtGbn0BRLUDsKXEXYk1w4pcXZs1yrT7aA3Y7WecVH0V1ECiUb65eFLpeZ1xzX6Ak0pw7rHLNrVTlGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 9e23a166801311f1aa26b74ffac11d73-20260715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6c374e7c-cb32-44ee-b7e4-fa0c508ffd9e,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:6c374e7c-cb32-44ee-b7e4-fa0c508ffd9e,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:4322d353d4d3ec99e3d61e3e7cdb7824,BulkI
	D:2607151408385SNMO3JG,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|123|127
	|136|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9e23a166801311f1aa26b74ffac11d73-20260715
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 369183486; Wed, 15 Jul 2026 14:08:37 +0800
From: zhaoguohan@kylinos.cn
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rtw89: wow: fix unsupported cipher debug messages
Date: Wed, 15 Jul 2026 14:08:13 +0800
Message-ID: <20260715060813.476245-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-39126-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhaoguohan@kylinos.cn,linux-wireless@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoguohan@kylinos.cn,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:from_mime,kylinos.cn:email,kylinos.cn:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06B4875AD7A

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

Correct two WoWLAN debug messages to say "unsupported cipher".

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 drivers/net/wireless/realtek/rtw89/wow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 8dadd8df4fc6..a162a8431b6e 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -358,7 +358,7 @@ static void rtw89_wow_get_key_info_iter(struct ieee80211_hw *hw,
 		key_info->gtk_keyidx = key->keyidx;
 		break;
 	default:
-		rtw89_debug(rtwdev, RTW89_DBG_WOW, "unsupport cipher %x\n",
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "unsupported cipher %x\n",
 			    key->cipher);
 		goto err;
 	}
@@ -443,7 +443,7 @@ static void rtw89_wow_set_key_info_iter(struct ieee80211_hw *hw,
 	case WLAN_CIPHER_SUITE_WEP104:
 		break;
 	default:
-		rtw89_debug(rtwdev, RTW89_DBG_WOW, "unsupport cipher %x\n",
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "unsupported cipher %x\n",
 			    key->cipher);
 		goto err;
 	}

base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.43.0


