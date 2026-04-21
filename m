Return-Path: <linux-wireless+bounces-35125-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC7mKTZV52nz6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35125-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 12:45:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F4F439AFF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 12:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4265A3004689
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 10:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4DE3AEF24;
	Tue, 21 Apr 2026 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNChe7S+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829E3BD62C
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768275; cv=none; b=L9mTcvK1Klre/IIcERgksohWkisb/QF3vKY0mYngUrlCnzNJd1jvBAFKL3YXial+C+ZOAM0Ub561z65VVGaQsa4t9xuFalXDyOqS8DgD5BcAJT9ZHXhhF+OEwTtOCmdAKNjLZ9wyprDj35wv3tPONCJG9GOUEmP4OSPlSAgg+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768275; c=relaxed/simple;
	bh=WQ80ngdTEfSXXnl0/88N4APYT81iVqAaEMPuhPPCsLg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IHJFNPUoa+pQuZuRHX3laCIGIzglpSNhGeVXFG+GbfCES/qeAEjju6m9TFUr4c/oPCktkNVaPYLDT29eGgJVCB6eyuwB31srTfAsg/60DtxKcXj8XqZymEuay8OsAInLTEADffO+wEELHa9841VhbJdWqOq2CNFHxA2fQJPeM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNChe7S+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so3293221f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 03:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776768272; x=1777373072; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/GYp0Uff0kEZSdHnn6P6qphxXYKqwN6CbcRRI9HrOfM=;
        b=oNChe7S+evMvWwq9MtH0JTrdcjiaNPy2KeVHG8dD8YPco0/rZjAMxiJXkoLFYr3kTc
         4aowWqUfMZuRoW5e/GUMTc7wkdqxTRSgGw9VJPXM3LsIW15SjXGv7L6AQsy2kJHcKPyG
         NV3vYa6GXRgPaQ1MumTvopZtuVkcY4NPxmLfMEzP1ZT68AYyrewYdyRzsxEgLZxsZS1k
         zDPhthjdVx3r+P6kdVZToAQyIH/qgTHu3vZ1/LYD/CjUPHTZM/OVt77ZHu66GQvHy3Mn
         zd4OKzdQY0+mqE+ysDH4BFd1yqXzCLh4w5MtAQ5mpmnFWc8BUK3QPnlDlbUdi7itvD/N
         AI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776768272; x=1777373072;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GYp0Uff0kEZSdHnn6P6qphxXYKqwN6CbcRRI9HrOfM=;
        b=mtP1f8GdYFSY3y8l788/JuNt+ZrMyaIZ2GolEOABNe4iGXpedK+Sf2FI42HA/ejIRs
         wRO8XbTic4LShrnTny8T9w5hZsdGCd63VJ+kpP2fGlOUuX8AfCwSQXaZ7DVUPgWRO9Qs
         yxA49t/yPn3osaxxzjnlkK5+ZSHTjuf5FwhAN4w8JmJFnv8OkkC10AWyo297PGMxhNbX
         M4kcNO0sr8HvMHhaeIISO0kXpmwjnJEUmJXzcZEo3IA6LBgNeLPbq/Du0MGllLMTZw1P
         /FRxgeRgNLjT1j+VPnlRb1JfyjlrqbLFbDYFSLLOkoW50XAE59EthoVeaFgJfbejwzIc
         NgfQ==
X-Forwarded-Encrypted: i=1; AFNElJ88NPPfJejWv1xsm4X1EldwSFDGkXnGzWGEPO9CE1/+Z5CFiPA77nEwERDh5m0LCAdLlETgl5oun5hrENmpSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2tDss8rO8w1w3FgG4MhE88RH9gdhvrnvqvvS0kgz5bkyQHkf
	Z5M/YbDSy9pPS4wGHcPGD6p6qAmV3hL00YhTcIf5+PNKbWcv98Z9rUY=
X-Gm-Gg: AeBDieuU5bH5GiDtDi/q4XoOa+/LeoVPc5MtteBU2JTb7TArScA9ofcj1x7eDopbKdm
	kGhpFwG9eYVyDaEETwyI6TB/djzv9Z74mQhjY8V/ARd0K8lU2mpcO4XMtuhliwHkrXg4DsRcBEb
	Ffgaf3xa9iun1ewGgzfYXxMpYLqr39nGYFv9Fg1EltcfBf7wl0BYXUfjBHRv/7PoYdjTH+8xvpl
	QRZmHkUur5kHQXJTQJlCY79f7lXTZzGHUII/5F6llY4MeQQgqAhJ09stUiPLOowPXEuGTuLR7Gr
	8bOhe+LWg1sE+qRYEVWKpG/nQMxqq6mikERoYCmY1r+iqORr5n3S0MoT/HbGt3PDFEcnhQtgpav
	KKQR5iVx5k+oupMBC8dAY7kp9MyKaDiUujyG14XwFl7mpI69CAh2beLaJmAUPfM+tXil/yTfOX5
	yn
X-Received: by 2002:a05:6000:4201:b0:43e:a72e:ec5a with SMTP id ffacd0b85a97d-43fe3dc62f3mr26634685f8f.20.1776768271624;
        Tue, 21 Apr 2026 03:44:31 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1249sm33357604f8f.5.2026.04.21.03.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:44:31 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Subject:
 [PATCH v3] wifi: rtw89: add bounds check on firmware mac_id in link lookup
Date: Tue, 21 Apr 2026 10:44:30 -0000
Message-ID: <177676827049.2367429.4662933573625287135@gmail.com>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35125-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: B6F4F439AFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026, Ping-Ke Shih wrote:
> Since this is used by data path, I prefer 'unlikely(macid >=3D RTW89_MAX_MA=
C_ID_NUM'.

Good point. v3 below adds unlikely().

---

From: Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3] wifi: rtw89: add bounds check on firmware mac_id in link =
lookup

The mac_id field in RX descriptors is 8 bits wide (0-255), but
assoc_link_on_macid[] has only RTW89_MAX_MAC_ID_NUM (128) entries.
While the driver currently assigns mac_id values below 128, the
descriptor value comes from firmware and is not validated before use
as an array index. Add a defensive bounds check in
rtw89_assoc_link_rcu_dereference() to guard against out-of-range
firmware values.

Fixes: 144c6cd24b35 ("wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports=
")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Wrap check in unlikely() since this is a data path, per
    Ping-Ke Shih.

Changes in v2:
  - v2 resubmission with plain-text formatting (git send-email).
    Per Ping-Ke Shih: defensive framing (firmware assigns < 128
    today, but descriptor field is 8-bit).

 drivers/net/wireless/realtek/rtw89/core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless=
/realtek/rtw89/core.h
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6435,6 +6435,9 @@ static inline struct rtw89_sta_link *
 rtw89_assoc_link_rcu_dereference(struct rtw89_dev *rtwdev, u8 macid)
 {
+	if (unlikely(macid >=3D RTW89_MAX_MAC_ID_NUM))
+		return NULL;
+
 	return rcu_dereference(rtwdev->assoc_link_on_macid[macid]);
 }
--
2.43.0

