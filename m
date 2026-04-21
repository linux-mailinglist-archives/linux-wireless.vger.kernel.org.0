Return-Path: <linux-wireless+bounces-35124-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LdyG3BT52mn6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35124-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 12:37:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7458D4399FE
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 12:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1BA33015143
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010373BD230;
	Tue, 21 Apr 2026 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRP97Ja0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14333BD63A
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767713; cv=none; b=VSfaQG9JDc31af04S49tn7Yx8Fp66zuWXFzONr4gAmtrM+1LDX/nMVvBEMC+uWHyDpObb0ys8oLbSWrfh528MCs/Ab/qe1ydwmDGTMpCSUff8VK7AqmOaV3iwMT20kOihSHZ8vY2U9yalcGinLd9IwFaF8uvjirJlYhhrnMHRxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767713; c=relaxed/simple;
	bh=+PMFofE/RVDQwfWPF5KI3qhV8YfkGycYU0EcSsfze8E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Cv0atTMtDMTexx55M4bfLYIOshpnlEWdZFOlkvdUCgV9fdQQjV51N8xAxNRYxbcAd96ERmBbBnwu5LH2wTGTCwUkMOzY/NhVjhKZ6+kMRhJnIMo2mbS/EfVSU76hs9ZiKPcMu0xO/Oa7Wf+/w2mXS6OxECMIN1oUy6QvGQToeOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRP97Ja0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso10765865e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 03:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776767708; x=1777372508; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oF46M04P6T5CRmKy4Co4KueMGTZYdCYXgFVWZK5hu8M=;
        b=QRP97Ja0eB4fCK4/vX3EF6quqqer9x4VnOxmRVsza3NALmSjY9Id3aYROiQo4sNg94
         rhC1GpET50xJML4Oo3Nx+BTC8K+5dGIU43+UFbrXbXAntIhH5gVYyKILBxDwXpwAkDlo
         A8+L6Uai4Jm1aYN4O23l+0oPucGnD2IQP0f72HMNQ+LRj2/IKq+Av5YWWhCdD2OjohqM
         qwQqPhROPSzyd5FGsA0yPdCpswlVCp18jLhJnuSk3mmurlYVYE1RERDQmqJSiBucbBQA
         KRNRS0hcfpQ0YLzPutFlnpOdWmM02vfdSSBDQUgQg1yaJn/uG7xuJDWB+kRKanDU1m8c
         QscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776767708; x=1777372508;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oF46M04P6T5CRmKy4Co4KueMGTZYdCYXgFVWZK5hu8M=;
        b=kVwG77sISkVHf4Qiq+YhSPHna+eFdgqX8hUcxvw43eZsCf15m+bc3vhPR5bmOwqzZl
         w3wQv3GrFlYA5HZ2XGYvuHSQ9/1lj5Of9FEeWrS/wJPX4eP4p6E4SwshBgKh6FqHYIUm
         AscDI7vvsxCKQ2KP+RfBmejbCzFVOq7DpYgPiADOEvU38N7MqZsNtHDRJpoJ3npKopGd
         7/EiD3kKStxfFZbmA6mQ1Kd/DDVFgePBPeHP0JRd+tHv7wHMVK5+qtFWV6g/POIE/Oy8
         xhwL4cDGvjoxxUXIexGJevm7HNtCforNSqnShJrXVLDxwMCpnSCIzBtTSZUdD0CRm9ow
         VYRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9P20WJdAfP90MFZ0aYV9LvcA+6oEIQ0U/iQm4Ydlg1xbUoYCKIx8vIibVbzB80oG69RB99hqgr9V5OF+vaCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqij7xH+Ev84i3LZvNU2hIDh1ioGHBVll7wgDLjHziYbySTPzR
	cTGT88Sfents25bpssF5M5l+XTtcRcPhPEpLoJr16fPA61Lr7F3vXMo=
X-Gm-Gg: AeBDietFQuVL/gwYNT0D9SrBpIPxhjqXpPzc/mCEFHOC4F4fu909cfGUHaOiMrnC9cJ
	CgloMdT7QUXDspEa23kJKU6JB9QuIawuwNMh7hOL8/bDSdL+UQB7UxSHH4IuAqUHYbPMH/eCTGJ
	xk1pfUV0PJC8ghkvivvxxT4x4SKrkwVNctaJNVS/1IVTro0N7mgrkjoc5ChpOfeHBkXe99TqMrb
	FUa+JxzgJiGRVInWspZa7uVfVQC64uxvbWKlLn8WJDOl+9N4CWBLKFkplJN0seblg9XWXJ3cxRJ
	R0qMRMgbTCfX7rrQj+TrIyRgci0U3QkMlfdnbnP5PeuEjg1aFYLPTc6IPySvG/rNq9JMkuic9P9
	UpC1kiDIFXN5MRrgVNCqEToukuc5fDUu1JtQkvDyBwhf/tKiWwmML8gG2D+nPL8x0xErH1Iith6
	wV
X-Received: by 2002:a05:600c:34c3:b0:485:41c4:e2e4 with SMTP id 5b1f17b1804b1-488fb792dd0mr245444935e9.23.1776767707626;
        Tue, 21 Apr 2026 03:35:07 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm129496075e9.22.2026.04.21.03.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:35:07 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Subject: [PATCH v3] wifi: rtw88: fix OOB read from firmware RX descriptor
 exceeding DMA buffer
Date: Tue, 21 Apr 2026 10:35:06 -0000
Message-ID: <177676770616.2086020.12978814842871576652@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35124-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 7458D4399FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 21 Apr 2026, Ping-Ke Shih wrote:
> Since this is data (hot) path, I'd prefer unlikely(new_len > RTK_PCI_RX_BUF=
_SIZE).

Good point. v3 below adds unlikely().

Thanks Bitterblue for clarifying -- glad the patches are complementary.

---

From: Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3] wifi: rtw88: fix OOB read from firmware RX descriptor exc=
eeding DMA buffer

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

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/=
realtek/rtw88/pci.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1078,6 +1078,11 @@ static int rtw_pci_rx_napi(struct rtw_dev *rtwdev, str=
uct rtw_pci *rtwpci,
 		new_len =3D pkt_stat.pkt_len + pkt_offset;
+		if (unlikely(new_len > RTK_PCI_RX_BUF_SIZE)) {
+			rtw_dbg(rtwdev, RTW_DBG_RX,
+				"oversized RX packet: %u\n", new_len);
+			goto next_rp;
+		}
 		new =3D dev_alloc_skb(new_len);
 		if (WARN_ONCE(!new, "rx routine starvation\n"))
 			goto next_rp;
--
2.43.0

