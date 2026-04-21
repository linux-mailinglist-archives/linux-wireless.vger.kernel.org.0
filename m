Return-Path: <linux-wireless+bounces-35127-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMbMJPRY52n36wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35127-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:01:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5C2439DD7
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0925E300A243
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CB93BD634;
	Tue, 21 Apr 2026 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4ZJo/KO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81D3A450A
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776769262; cv=none; b=urS4r5umGS2mvb5j3LujkSANvr7orb0Ysl4XjcdUIps8fYDJiIlhJk5dabit6xqXPM9nUIdtviD/8hNe9xHiRd9IhHLn2QRCxkNtAh+YffRdYdVnvZ2nkotXYGaPC7pdrxQqhmV1JFl9wHxM7UKS6h1evyDBgnWTrgiTsqNaL1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776769262; c=relaxed/simple;
	bh=Rae1EKE2i/yqff3D58fCafa8KKUmbAR58pzldOzn2J8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GP3qhHF6rAfyyHfKx3ZO8aYUj5R88+4yUmjGPFVq9V6yxRLEjw1Z04nJosi4OkFcCpLNkJaC1fMpAx3Vd7qsCuMctbjAAYIXJZfSso/Ihj1P9MN6fcAAaq0dhwbXqCjIHxAKxhnH6IfHXgoKGqRFmiWK2Ge9F3UJLv9eELhjQGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4ZJo/KO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9e00649769so574109866b.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776769259; x=1777374059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=440d0H57MWPuvBGVE+TuDWy9lb97YvYXTjQ+y+rkxLM=;
        b=p4ZJo/KO9orbAjAYELAtyoUkEvjqXqo+uTtGoXYu9Bd4esOntJEJblme6KCB9DKO5Y
         Bz6oC6/AprjX4Bk8sAwl65T0FxWHK10vF7uDzebcSwLpwipp0HRxor+/1ZFYzCbaTASO
         uLWNx9tV9luJfdLUjOFpg4AyudIud78zF2UBYZ0TIzbtz8/tPdBAjnsWnhqU/BkLP9MY
         LZI9DJtf0BtYQmyNsmwm5moztfMAz393v7uWPM9xZmQa29cFkhsxvaeyvY2NuphfJpdu
         MGT1s71f6nTvJV+tZGxKgVdYXX+4HD6eLoZ40Cspvf9vJfGTqc0jO9/5tSoq+ZwMd1cz
         Yu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776769259; x=1777374059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=440d0H57MWPuvBGVE+TuDWy9lb97YvYXTjQ+y+rkxLM=;
        b=mkz2FFdvbMEAi6N79a08slAmAZ+uh3/f/7XdTttpcJjiZ+bzReoV70XACrjxIy/UJa
         UcPWUC2RIaQS9j5sNmsk6Eruqaccn9RvYKFWvBZPK7GsHp8YHIHbGOZKUh3i289aO9NB
         zIpzSVP+5hJ836EIfBXjnbejbYBq+12ZheRMHvmaDBcN9PqzrsbTYNgy8o5tza4AeIOo
         sF8vWzlmHt2FHa8gncBCLGpdTaVltjdt6v6de8CQx7s6zBIvmPUdtoCyiDfBD6MAcH9C
         xrORBRAJ7I1qmUqwgglkLsKjifnw0ENsproJWmKAYbx7JrM9FxtfsXKixhxOhPu5m7m1
         Fynw==
X-Forwarded-Encrypted: i=1; AFNElJ9MwLIHAwuXz3oNtyOauusOiMM9poJFu4ZODJqNKwgKgK1JXX8oXzWuZxKbybLBYqeiF3bFACKe58ROwga7Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxA+IbrYNaWBwIc+PEuNwv3FiF2y4KvYe0iKgk0LuSlkGTsKtVh
	tzjJEujiFco8N+sWRxJWq4bugdEf62movI5z0cRm+a4fYlXE14UcvLw=
X-Gm-Gg: AeBDietL12LbGxd/zRP98NmNRyK27waIkLPM8GCI4P1dHn1G2poIiDL5TE8/TUBKMBu
	EIJvcBMH6GgqttfVIJ4P++wreoBnHr1ri/VUxr3MjTbo9Cyto6HvYJ/xDeXwfC8idlmJ6lMLSyO
	aWy0CteC5hgmkJMGO6Hzgll1OW256hJZkA7nxGFAIUEGp/l+NgeVlXrTtSrSZJru8vaRChthCp/
	lHScw84FxqVHqPeDdB+BG14zKd38JfmtzLnLr3C4YthacJ77YtMgn7dvvy2kXGTN15d2ihJrdPu
	8XnkTKJoHhOBhoSwN6FTEkCuxSmmvmWaODtk+mqX9gAo7he0xeEXGtOVyawVXr5I9DLySL34dXV
	Htx6PP9Ab6Biis5FYQSMSD4P9k1XLaDmaipw3YiOvIvplYD3ma/9ROja5pUEkW3mh0IXm7RU/68
	v6nBG/8dWVYwPf2w==
X-Received: by 2002:a17:907:2d2a:b0:ba6:22e8:69ce with SMTP id a640c23a62f3a-ba622e875e3mr625118166b.25.1776769258487;
        Tue, 21 Apr 2026 04:00:58 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc09b1sm36952716f8f.9.2026.04.21.04.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:00:57 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3] wifi: rtw88: fix OOB read from firmware RX descriptor exceeding DMA buffer
Date: Tue, 21 Apr 2026 11:00:57 +0000
Message-ID: <20260421110057.2939553-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,vger.kernel.org,talencesecurity.com];
	TAGGED_FROM(0.00)[bounces-35127-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 0C5C2439DD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

In rtw_pci_rx_napi(), new_len is computed as the sum of pkt_len (14-bit
descriptor field, max 16383) and pkt_offset (drv_info_sz + shift, both
firmware-controlled). The result can exceed RTK_PCI_RX_BUF_SIZE (11478),
causing an out-of-bounds read from the pre-allocated DMA buffer when
skb_put_data copies new_len bytes. The USB transport already validates
this (rtw_usb_rx_data_put checks against RTW_USB_MAX_RECVBUF_SZ); the
PCIe path does not.

Add a check that new_len does not exceed the DMA buffer size.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Wrap check in unlikely() since this is the RX hot path, per
    Ping-Ke Shih.

Changes in v2:
  - Clarify field widths and maximum new_len derivation in commit
    message, per Ping-Ke Shih.

 drivers/net/wireless/realtek/rtw88/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1078,6 +1078,11 @@ static int rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 		new_len = pkt_stat.pkt_len + pkt_offset;
+		if (unlikely(new_len > RTK_PCI_RX_BUF_SIZE)) {
+			rtw_dbg(rtwdev, RTW_DBG_RX,
+				"oversized RX packet: %u\n", new_len);
+			goto next_rp;
+		}
 		new = dev_alloc_skb(new_len);
 		if (WARN_ONCE(!new, "rx routine starvation\n"))
 			goto next_rp;
-- 
2.47.3

