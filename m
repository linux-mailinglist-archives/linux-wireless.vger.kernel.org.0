Return-Path: <linux-wireless+bounces-38343-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /Vn2GG+GQ2qTaAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38343-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:03:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EA36E1E14
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:03:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=V3t2l2rS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38343-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38343-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E67B30093B0
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 09:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A0C3E638E;
	Tue, 30 Jun 2026 09:03:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9776282F35;
	Tue, 30 Jun 2026 09:03:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810217; cv=none; b=ZKqpDUxGqINGDvbLTh1bh+tI/OtRsoXYwfwaduT8xSNx/opSy6/qAgunxQ39qI3rjg48fzFHXT5d7v4tf/kPF3tdvlhXniBDhNqZn8fpZEMs9mGKU08wBDa/8haOFvpU69jJVM+2jFv84p/+0/p0fPOPm7D5+u/cF8XSABGYndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810217; c=relaxed/simple;
	bh=IZA6zaAqzIIyuQMA463msv9+ex442pIEyCdq82Qpfxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pr7PtAkkolQ9k4tE36oGqhcRdJxR5RQoah1VHzg19hyz9a8WoYwC9F1m/QdA37kGIvAKYQcnWrK7y8BIKH2C3/DX8XW+BllhabiHtxmr8pNLo3zK1r1EgcL8we3T/B9EV6JJLUD2RWVRX1u+pxqv62Wf4YSxjZaykvGOR/NgiMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=V3t2l2rS; arc=none smtp.client-ip=54.206.16.166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782810168;
	bh=/DbPEVJLeqWxXeZW+eO/pHHIYIquir08fIC3tmI1b7M=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=V3t2l2rSvEC8oCCgQ8qRin+jI2w+vTULqPNxGN86aMOD0F/siwmBNj8HKmaGTHB4W
	 0aVbNVDFjtmvBifotYwB7wZAxWggOZ6sODEfRYGQlKNHSFmIo/hJj1c38ZmP93IYil
	 37E5JRqsfURSf4x5UdzUkvs1JYQtxkfQJaZ5/jOs=
X-QQ-mid: esmtpsz10t1782810147t6bfd4277
X-QQ-Originating-IP: /V+MfEC+CGaw+MBecW7/C8hr9iS2fpHB2cqKH+c4jjw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 30 Jun 2026 17:02:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12524413929417674271
EX-QQ-RecipientCnt: 10
From: Wentao Guan <guanwentao@uniontech.com>
To: lorenzo@kernel.org,
	sean.wang@mediatek.com,
	mingyen.hsieh@mediatek.com
Cc: quan.zhou@mediatek.com,
	nbd@nbd.name,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7925: cancel pending mlo_pm_work
Date: Tue, 30 Jun 2026 17:02:18 +0800
Message-Id: <20260630090218.3202029-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OBlCTbN6oDZ0VdIAHy6dMxzAyHEqJJlB3e5dBwYIrhQNV0VcIkMvkzdY
	P+1joB5M1AhKbzSz1nZ+Hqlx22mhJqsaGOeqb5G4cWupbVIYMa34OVm/sKadi25HitACbZy
	4D3XfS/cGjMmZmm3ia+OS1DGQmsHuAjzu1LOUbE8Vo+kDyQDLdQppRFo9EfpH3ZhXQc45Ma
	BajW4RnmiZzE7gluKb5C7HzAK4HZMlF8AhUYquftthr3t4XZRr5ggwW+70knI/U4hXA0tg/
	NCdyqZdyJ7OCTJS86XgQ1oWYB0HNmkMG3GwfHNdAAq2bFuH78ugD+segjtjEbDBNnDgkqj4
	bNv2U8l3e5rswbymlCu+mDU7Bp7jZHoZWhu72eUfIn+FfOyDgkEVs1HvaAnbKduErHykLKS
	0ZR+P8xBFnaA3cCe9p2NdqqvTgh+86oxKvrZbw3os8a0gRZ6cLFYpWtY3tPDlz2PzpdaIpv
	Gbzrl4LOjN+/yxNNJ9431pngQAyRCOKedi3WslPnmQoKFXgFvBAReGKH2fbOPFg2VrWz0IC
	x/gAO4hkDmPny3Xkv8p5LHdGQoPWeRNkg1Zrt8ZxhMwQ0xT5GcNm/Atj8rPGkJAVv3r+5Tq
	Fbe/sCFzKGjP9Jx3d2wm5qERWMbKISgdjMbZ2z9/cqkbppIhcbKP9XD8ljNtgL1LWaIDavL
	DJRBdronBwgPtu8Gr3Stxh/0m3VVgmyQyqGOeNXaFdc1xBifLkK2gN7uKSSxS27D3bCh7Hg
	v66dU+Xy2VMC+WIlndMMGUOZCyvPkWu78TTmZkzKEtOF9U3MujAUJwN7RKqUbvNX7vXAHg0
	wKOhAUBFCaWqEigP0AYaWBQIU8t43dC4IgaC+wuK7SJCo85hoHKWdroio7Ku02pyUuLHDxr
	RuF0UsNlPmszDjXB6ORiKnDGvU0fF8P3FVDthV3mRLoa1CzoOv0FchIRmU++Cvv6hoQfXGc
	uKdHZ6IAMAZe3gj5sFHaATmU7A3Dep44xveUHwWO9ME3XgoJq523bJ3EuTNRc5XKM73GXJk
	o9/Vwe9e3MnZURkwGN32gFvGuX6AWAg/R6DYxotJ/g85icsRre/U5eE1zYoadGklAcyOojV
	g==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38343-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:sean.wang@mediatek.com,m:mingyen.hsieh@mediatek.com,m:quan.zhou@mediatek.com,m:nbd@nbd.name,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:guanwentao@uniontech.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1EA36E1E14

If the device is reset, suspended or unregistered within that window,
the pending work can still run and access vif/bss data that may already
be freed, or send MCU commands while the firmware is not available.

Add cancel_delayed_work_sync(&dev->mlo_pm_work) in all relevant teardown
and suspend paths:

 - mt7925_mac_reset_work()        (chip reset recovery)
 - mt7925e_unregister_device()    (PCIe unbind)
 - mt7925_pci_suspend()           (PCIe bus suspend)
 - mt7925_suspend()               (mac80211 suspend)
 - mt7925u_suspend()              (USB bus / runtime suspend)

This ensures the work is stopped before the device state becomes
invalid.

Assisted-by: kimi-cli:kimi-k2.7 code
Assisted-by: atomcode:glm-5.2 #Reported-by

Fixes: 276a568832577 ("wifi: mt76: mt7925: update the power-saving flow")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  | 1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c  | 1 +
 4 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index c47bd812b66b9..d56a846dec53e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1307,6 +1307,7 @@ void mt7925_mac_reset_work(struct work_struct *work)
 
 	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 	cancel_work_sync(&pm->wake_work);
 
 	for (i = 0; i < 10; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 73d3722739d0a..ab6c6565ca0f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1602,6 +1602,7 @@ static int mt7925_suspend(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	cancel_delayed_work_sync(&dev->pm.ps_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
 	mt792x_mutex_acquire(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c4161754c01df..cfa91af065b78 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -42,6 +42,7 @@ static void mt7925e_unregister_device(struct mt792x_dev *dev)
 	mt76_for_each_q_rx(&dev->mt76, i)
 		napi_disable(&dev->mt76.napi[i]);
 	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 	cancel_work_sync(&pm->wake_work);
 	cancel_work_sync(&dev->reset_work);
 
@@ -453,6 +454,7 @@ static int mt7925_pci_suspend(struct device *device)
 	dev->hif_resumed = false;
 	flush_work(&dev->reset_work);
 	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 	cancel_work_sync(&pm->wake_work);
 
 	mt7925_roc_abort_sync(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index d9968f03856d8..7ba50c33cd32c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -251,6 +251,7 @@ static int mt7925u_suspend(struct usb_interface *intf, pm_message_t state)
 	pm->suspended = true;
 	dev->hif_resumed = false;
 	flush_work(&dev->reset_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 
 	mt76_connac_mcu_set_hif_suspend(&dev->mt76, true, false);
 	ret = wait_event_timeout(dev->wait,
-- 
2.30.2


