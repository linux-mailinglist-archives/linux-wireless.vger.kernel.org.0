Return-Path: <linux-wireless+bounces-31372-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH/COTjHfGnaOgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31372-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:59:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A98ABBD20
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 209C6300A137
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6DB329E5A;
	Fri, 30 Jan 2026 14:59:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CC041C62;
	Fri, 30 Jan 2026 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769785140; cv=none; b=lAzFZ/n9vrU5bxWoLCaYMFq1Uq7QXwb9wxai2OjqgXpXfA5x8fECJzxMFqvT+JSw6ku3TWR0i7QADddWt9bLa5P+in69j1m2Qh6fQtIrDzy1moNRjjuLx/MFju7A48ZN/nDudSdgpovUTuqfDrUl1mUZ+WUFMGD1OHCELjdZStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769785140; c=relaxed/simple;
	bh=QtzEdA9ntSNO7ppt6lzTmGwmBNOVWqhYXfkYsqeaHB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d1rO51UTy8SZN8u3RTK+7w+WR3ppowgyE3Gbc5GjlSahfP0WawldLt/JnGu3i3/o7ArKNfCBMxemP3C3BlHfNd1+DdxcLgY1OumC50llSpwhjVhQfcGa/Sa6dVP3XCphTAZZf2L3+jFAcJDYjTgf5VAi+gcBHWU3mCTXQ8X0EZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [106.117.99.170])
	by mtasvr (Coremail) with SMTP id _____wBnPM78xnxp8L1gAA--.5479S3;
	Fri, 30 Jan 2026 22:58:05 +0800 (CST)
Received: from ubuntu.localdomain (unknown [106.117.99.170])
	by mail-app1 (Coremail) with SMTP id yy_KCgDH0dv5xnxpnhTxBQ--.54572S2;
	Fri, 30 Jan 2026 22:58:03 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	kuba@kernel.org,
	alexander.deucher@amd.com,
	pkshih@realtek.com,
	akpm@linux-foundation.org,
	StanleyYP.Wang@mediatek.com,
	howard-yh.hsu@mediatek.com,
	rosenp@gmail.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] wifi: mt76: mt7915: fix use-after-free bugs in mt7915_mac_dump_work()
Date: Fri, 30 Jan 2026 22:57:59 +0800
Message-Id: <20260130145759.84272-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgDH0dv5xnxpnhTxBQ--.54572S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwYHAWl7uAYDcwBHsY
X-CM-DELIVERINFO: =?B?cYGOmAXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR11YjdbuMySUouUtrOXK8iwzYcuYFk7aHTFsYiRbb0uC/oQbxyu3xRrnSKM/xJF44wcM8
	Hq9+lQsvkMLsMeqhmXkB8lQQRIwc0TJdq+owcnJ2UFiSBZHsqxAN1s176MXBxg==
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr1xKr15CFykKFyxXFy8tFc_yoW8WFWkpa
	yFga4UurWUWFsrt3yDJFWxJa15W3Zag34jkryrW34Yq395GFySyws8ZFy29Fy0yF4qkFyY
	vr45tr98uFyYvFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8YFAJUUUUU==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31372-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[zju.edu.cn];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,amd.com,realtek.com,linux-foundation.org,zju.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[duoming@zju.edu.cn,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zju.edu.cn:mid,zju.edu.cn:email]
X-Rspamd-Queue-Id: 2A98ABBD20
X-Rspamd-Action: no action

When the mt7915 pci chip is detaching, the mt7915_crash_data is
released in mt7915_coredump_unregister(). However, the work item
dump_work may still be running or pending, leading to UAF bugs
when the already freed crash_data is dereferenced again in
mt7915_mac_dump_work().

The race condition can occur as follows:

CPU 0 (removal path)               | CPU 1 (workqueue)
mt7915_pci_remove()                | mt7915_sys_recovery_set()
 mt7915_unregister_device()        |  mt7915_reset()
  mt7915_coredump_unregister()     |   queue_work()
   vfree(dev->coredump.crash_data) | mt7915_mac_dump_work()
                                   |  crash_data-> // UAF

Fix this by ensuring dump_work is properly canceled before
the crash_data is deallocated. Add cancel_work_sync() in
mt7915_unregister_device() to synchronize with any pending
or executing dump work.

Fixes: 4dbcb9125cc3 ("wifi: mt76: mt7915: enable coredump support")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 22443cbc74a..250c2d2479b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -1294,6 +1294,7 @@ int mt7915_register_device(struct mt7915_dev *dev)
 
 void mt7915_unregister_device(struct mt7915_dev *dev)
 {
+	cancel_work_sync(&dev->dump_work);
 	mt7915_unregister_ext_phy(dev);
 	mt7915_coredump_unregister(dev);
 	mt7915_unregister_thermal(&dev->phy);
-- 
2.34.1


