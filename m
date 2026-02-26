Return-Path: <linux-wireless+bounces-32234-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGEaNE7BoGlPmQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32234-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 22:55:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC441B018D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 22:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28D6A303BA43
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 21:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0604D42E006;
	Thu, 26 Feb 2026 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="v0EcSVJy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644324C076
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142910; cv=none; b=O4CptmigPyO4xhmcSX4viU0jAZF69H2u+Q+Tho+5haszNtJpveRr0vyd4RFd/AxVejzUgbLZaZ3gUXhuzIP8MOzAEhX2h+JmmLy/3Qop4/Iayw8QUvGbfyluixtTg4uGQsxkzkKOhkTBdXpzH6bfVAHhbjg3fWLkAGi0Gc64cyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142910; c=relaxed/simple;
	bh=7k4vYrbJ6xrpxAjo9hJNkIdxQq6FFLUNTmda5XOMLE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNO94Jt6mGaOqV1mT7/XewpQz9p+zNblHp2+xTDPKb17Vio8TaA63DJXmHo4uuvGpDUqnShK+tXbYpmhKsi0HLqbJoriYmyfo74sOiLVaTCVdBmoegQMpoJnd46V+GLh83lyPq5ACR+2Xgh10P42MdiITQ4B1I1o+juxfM57t7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=v0EcSVJy; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 56D7918014F
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 22:45:09 +0100 (CET)
Received: (qmail 6313 invoked by uid 988); 26 Feb 2026 21:45:08 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Thu, 26 Feb 2026 22:45:07 +0100
From: David Bauer <mail@david-bauer.net>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: mt7915: add debug query from WA firmware
Date: Thu, 26 Feb 2026 22:45:00 +0100
Message-ID: <20260226214502.2561168-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.999999) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=7k4vYrbJ6xrpxAjo9hJNkIdxQq6FFLUNTmda5XOMLE0=;
	b=v0EcSVJyA3j4V41/5QzOj4WBK9JMFD9bud0Fewr2BKZ1XkNJUPXyPZ7rl9x44lt0ouI5GhVCKx
	JPV9YEaiQggB72quWuW33gzsZ5ZQdturHuYScCFFVXJyDVRRBjeWzmXj9MSxqBzRJOVuBcvdNE5S
	2dTgcMSnS/maZWYSHje+aVwSnynuyPazCqkzoaQctsoJd61gdO/ohKKLnNxKFNGOkoBcP/CgwPve
	GoIVhkzzv7nxBcNxhserfT9BuQJT5FwSR3T0/2GoNyjO7FuOJv+JxGmDKxNMTzayTuqzO8Ca3XWt
	speoY+nQoVPT4xHtZIsyOeS+aFNX2KYA9+STP5mWvYqvGIiZpJwz9rStNC7oyW4wLnX63/Z6ncAA
	cpYP5Q48OktQd+KTpXy8LWEamMaakSdG6+U6GpP4l/WqdePWxGhZCNu0svynKJtRQijkfxN7nOen
	Ox0abD9a5k6fgw9uhwuLCC7Z97IKzeHyGsXny/x06nDq+ol5+Kx5j4dVAaQG0lMdapDrp1LL2obO
	3RdW+a1iVLRBnrdl8Ql+PhotOry6hJ1E4lBAioLWfGqS3SkFeOi6aNxQK7D88Ym8QpevC0nkwtW+
	S3AfEFLE0NmdxZoQMkz8SstnuEmTEFKbPdR/uL2L5AFqBY9hrD67KVzOanY9VyM6fHe3sesfmDtq
	M=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[david-bauer.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[david-bauer.net:s=uberspace];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	TAGGED_FROM(0.00)[bounces-32234-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@david-bauer.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[david-bauer.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,david-bauer.net:mid,david-bauer.net:dkim,david-bauer.net:email]
X-Rspamd-Queue-Id: 1BC441B018D
X-Rspamd-Action: no action

Add a new file to the mt76 debugfs to allow querying internal state
information from the WA firmware.

This allows to extract more information from the internal queue
structures and configured limits.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 26ed3745af43e..018b1c70b524b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -603,6 +603,86 @@ mt7915_fw_debug_wa_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug_wa, mt7915_fw_debug_wa_get,
 			 mt7915_fw_debug_wa_set, "%lld\n");
 
+struct {
+	u8 idx;
+	u8 query_cmd;
+	char *description;
+} mt7915_fw_wa_debug_query[] = {
+	{ 0, 0x16, "MSDU drop info" },
+	{ 1, 0x17, "AC queue tail drop" },
+	{ 2, 0x19, "TX Free info" },
+	{ 3, 0x20, "BSS Table" },
+	{ 4, 0x21, "STA records" },
+};
+
+static ssize_t
+mt7915_fw_query_wa_set(struct file *file, const char __user *user_buf,
+		       size_t count, loff_t *ppos)
+{
+	struct mt7915_phy *phy = file->private_data;
+	struct mt7915_dev *dev = phy->dev;
+	char buf[16];
+	u16 val;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	if (count && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	else
+		buf[count] = '\0';
+
+	if (kstrtou16(buf, 0, &val))
+		return -EINVAL;
+
+	for (int i = 0; i < ARRAY_SIZE(mt7915_fw_wa_debug_query); i++) {
+		if (val != mt7915_fw_wa_debug_query[i].idx)
+			continue;
+
+		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(QUERY),
+				  mt7915_fw_wa_debug_query[i].query_cmd,
+				  0, 0);
+		return count;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t
+mt7915_fw_query_wa_get(struct file *file, char __user *user_buf,
+		       size_t count, loff_t *ppos)
+{
+	static const size_t bufsz = 1024;
+	ssize_t ret;
+	char *buff;
+	int desc = 0;
+	int i;
+
+	buff = kmalloc(bufsz, GFP_KERNEL);
+	if (!buff)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(mt7915_fw_wa_debug_query); i++) {
+		desc += scnprintf(buff + desc, bufsz - desc,
+				  "%d: %s\n", mt7915_fw_wa_debug_query[i].idx,
+				  mt7915_fw_wa_debug_query[i].description);
+	}
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	kfree(buff);
+	return ret;
+}
+
+static const struct file_operations fw_query_wa_fops = {
+	.write = mt7915_fw_query_wa_set,
+	.read = mt7915_fw_query_wa_get,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
 static struct dentry *
 create_buf_file_cb(const char *filename, struct dentry *parent, umode_t mode,
 		   struct rchan_buf *buf, int *is_global)
@@ -1310,6 +1390,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 			    &mt7915_sys_recovery_ops);
 	debugfs_create_file("fw_debug_wm", 0600, dir, dev, &fops_fw_debug_wm);
 	debugfs_create_file("fw_debug_wa", 0600, dir, dev, &fops_fw_debug_wa);
+	debugfs_create_file("fw_query_wa", 0600, dir, dev, &fw_query_wa_fops);
 	debugfs_create_file("fw_debug_bin", 0600, dir, dev, &fops_fw_debug_bin);
 	debugfs_create_file("fw_util_wm", 0400, dir, dev,
 			    &mt7915_fw_util_wm_fops);
-- 
2.51.0


