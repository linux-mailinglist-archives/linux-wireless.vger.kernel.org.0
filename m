Return-Path: <linux-wireless+bounces-32087-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +cjgBKjGm2lN6gMAu9opvQ
	(envelope-from <linux-wireless+bounces-32087-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 04:16:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A303317181A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 04:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 861B7300B139
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 03:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23F472627;
	Mon, 23 Feb 2026 03:16:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AAD26B75B;
	Mon, 23 Feb 2026 03:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771816611; cv=none; b=e9xYwEg2rnuLbNOrjFWEY8yKpD7da0fbrvMinLO92e/YVa9WhdoJy6I73u68JBdUmsTcOCYZPrBvdQGdBB/oJXLb0XBszvugDshdM5u/6gdOYU1Sx+EUBTFHyHJDCBVkGygSRCJzMFo+KLoKOzsIV00S/3xVumk3Eb8Ylqb2gqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771816611; c=relaxed/simple;
	bh=rNI1Ctt94ExtQJUlP/ljV2uCFOFr6OdYRoZhGhPGMNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YfMW0pu97SWd992gK5VXgFe3wnD3T5ueMZqb4IEz4/ewXKj2ZurB/DbIlvrXnF65NplOa4aymt5t++2bLJly0u9fPNghvtJhUXgWMVxBayvkQ0fM8qD3jnwFnlBFt1KsfWc9LYXt5iXfsrBsLlcX253xYcvIg3d/OW/n3N1ByhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.17.5])
	by mtasvr (Coremail) with SMTP id _____wD3ncwNxptpeyzQAA--.11675S3;
	Mon, 23 Feb 2026 11:14:22 +0800 (CST)
Received: from ubuntu.localdomain (unknown [218.12.17.5])
	by mail-app3 (Coremail) with SMTP id zS_KCgDX2GsJxptpDfBYBg--.3639S2;
	Mon, 23 Feb 2026 11:14:20 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	linux-kernel@vger.kernel.org,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH wireless] rtlwifi: rtl_pci: Fix possible use-after-free caused by unfinished tasklet
Date: Mon, 23 Feb 2026 11:14:15 +0800
Message-Id: <20260223031415.39221-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgDX2GsJxptpDfBYBg--.3639S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQJAWmYuQgE3ABfsI
X-CM-DELIVERINFO: =?B?b08g1AXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR12+LyrQntYVBPxnzenB0a/HJLuynotOemBLS+42EV/9BiR7EI1i6nOS40VqJ3C/AJv2U
	sOe/FrJgocY3cm2KwE7YowI6lNkYKUD2nlrXiiWm7lSXcIQ+lDH52cqBEwkrJA==
X-Coremail-Antispam: 1Uk129KBj93XoWxJry7Aw17uF43tryrKw4Utrc_yoW8Xr43pF
	W3u3y3CFZ5G3Wjk3Z8Xa1ftFyrtanxtrWfGr4Fk34Sgws7ZF1Sqw4fCFZIyFWUtr48ZFZ0
	yr18tr9xGr1kCrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuY
	vjxU26pBDUUUU
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32087-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[zju.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.951];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[duoming@zju.edu.cn,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A303317181A
X-Rspamd-Action: no action

The irq_prepare_bcn_tasklet is initialized in rtl_pci_init() and
scheduled when RTL_IMR_BCNINT interrupt is triggered by hardware.
But it is never killed in rtl_pci_deinit(). When the rtlwifi card
probe fails or is being detached, the ieee80211_hw is deallocated.
However, irq_prepare_bcn_tasklet may still be running or pending,
leading to use-after-free when the freed ieee80211_hw is accessed
in _rtl_pci_prepare_bcn_tasklet().

Similar to irq_tasklet, add tasklet_kill() in rtl_pci_deinit() to
ensure that irq_prepare_bcn_tasklet is properly terminated before
the ieee80211_hw is released.

The issue was identified through static analysis.

Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index d080469264c..f0010336e78 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1674,6 +1674,7 @@ static void rtl_pci_deinit(struct ieee80211_hw *hw)
 
 	synchronize_irq(rtlpci->pdev->irq);
 	tasklet_kill(&rtlpriv->works.irq_tasklet);
+	tasklet_kill(&rtlpriv->works.irq_prepare_bcn_tasklet);
 	cancel_work_sync(&rtlpriv->works.lps_change_work);
 }
 
-- 
2.34.1


