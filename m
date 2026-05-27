Return-Path: <linux-wireless+bounces-37000-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI2JIrzGFmpVrwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37000-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 12:26:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4515E2A93
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 12:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8DDE3015C80
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 10:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C6280318;
	Wed, 27 May 2026 10:19:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC71F385D9A
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877159; cv=none; b=ESFadJckpLI/RYlH2Q0DtHczygSUrqIajJOscjnS6suDMWk0PUy0uKDVOsMb7Tlbyy1qyjHow4iewFWoDGcNhu2W/jlMyv2mgMb7vhWTveg1da6sHEtQAarNqsruFhe6dJrISklAYaV/OgjEkUxlcCFFjm3GLuR94Oh49Hw/dAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877159; c=relaxed/simple;
	bh=yRxtd7TnGco5qEYANZdRswGpwqkos+2O8s1UVQ4Eems=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oI9CVvx+fz0spCi2+Dg8p9ldC4MjJlNG2lHkKafpsH62CY3sk0jv4HVHdxeTUnhopSnR6fHMiCh6Xll7JXDaIQ/MGc6nvfdG3TOXezpL/dWgPDeIRH0mZUDchv1au+GgIKMsMkg+UWK2sgfakM8hEPt5enRFMqt+7Gh3Qb0YURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADH6sQYxRZqADw0AA--.3853S3;
	Wed, 27 May 2026 18:19:08 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	kilroyd@googlemail.com,
	linville@tuxdriver.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	xuyq21@lenovo.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] wireless: wext: export each WEP key size only once
Date: Wed, 27 May 2026 18:18:59 +0800
Message-ID: <a039d8a18fa47ab9fce851b7f42cdadb62e54ba9.1779632308.git.xuyq21@lenovo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779632308.git.xuyq21@lenovo.com>
References: <cover.1779632308.git.xuyq21@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADH6sQYxRZqADw0AA--.3853S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13JFWDtF43JF4fCw47twb_yoW5JF1DpF
	Wak34qqr9rXr4xCryrXr48uFWayFW8uF97G3s8K3s7u3ZFgFnYqr9YgFWDur4DAaykGayY
	yF1vgrnrGwn5AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEACWoWqU4DZwAAs2
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,googlemail.com,tuxdriver.com,gmail.com,lzu.edu.cn,lenovo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37000-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lenovo.com:mid,lenovo.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DD4515E2A93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuqi Xu <xuyq21@lenovo.com>

cfg80211_wext_giwrange() fills iw_range.encoding_size[] from the
cipher suites advertised by the wiphy. The WEXT range data describes
supported key sizes, but the current code appends one entry for every
WEP cipher occurrence.

A wiphy may expose repeated WEP cipher entries, which can make
cfg80211_wext_giwrange() grow num_encoding_sizes past the available
encoding_size[] slots. Track whether WEP40 and WEP104 are present
while scanning the cipher list, then emit each corresponding key size
once.

This keeps the exported WEXT data aligned with the supported key sizes
and makes duplicate cipher entries irrelevant.

Fixes: 2ab658f9ce21 ("cfg80211: set WE encoding size based on available ciphers")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Yuqi Xu <xuyq21@lenovo.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/wireless/wext-compat.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 22d9d9bae8f5..6d64facd8115 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -109,6 +109,7 @@ int cfg80211_wext_giwrange(struct net_device *dev,
 	struct iw_point *data = &wrqu->data;
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct iw_range *range = (struct iw_range *) extra;
+	bool have_wep40 = false, have_wep104 = false;
 	enum nl80211_band band;
 	int i, c = 0;
 
@@ -170,17 +171,22 @@ int cfg80211_wext_giwrange(struct net_device *dev,
 			break;
 
 		case WLAN_CIPHER_SUITE_WEP40:
-			range->encoding_size[range->num_encoding_sizes++] =
-				WLAN_KEY_LEN_WEP40;
+			have_wep40 = true;
 			break;
 
 		case WLAN_CIPHER_SUITE_WEP104:
-			range->encoding_size[range->num_encoding_sizes++] =
-				WLAN_KEY_LEN_WEP104;
+			have_wep104 = true;
 			break;
 		}
 	}
 
+	if (have_wep40)
+		range->encoding_size[range->num_encoding_sizes++] =
+			WLAN_KEY_LEN_WEP40;
+	if (have_wep104)
+		range->encoding_size[range->num_encoding_sizes++] =
+			WLAN_KEY_LEN_WEP104;
+
 	for (band = 0; band < NUM_NL80211_BANDS; band ++) {
 		struct ieee80211_supported_band *sband;
 
-- 
2.54.0


