Return-Path: <linux-wireless+bounces-31861-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDbYC4zokGkMdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31861-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:26:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E757713D5CB
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 117443015D96
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71185311C2C;
	Sat, 14 Feb 2026 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjmdE7bR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D70D311977;
	Sat, 14 Feb 2026 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104364; cv=none; b=NQpE7Xott4OLLdp2tvjfQpmGJ/D5fveAp8w51ykXiAx9sKvW0U4++ccjddxh6fDcYUSh31fzmSLi+gRaCHrw+nnNH1bXg1pY4hJUbNzr0Fg/d0DbMxYyCk0SvOE34Vod+zOR0ClHmxjHRINDZ+0vHJ4hA1ozilwYMLNIMulir6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104364; c=relaxed/simple;
	bh=tcxNxY/RcEW8fyNeEwUv+xpFUl2huf4mxOXo6J+tqo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AW+b495EUf8TTKwt4XoJIam4aaM/Om8hpMKO6XhP+hzOAqJlghgXjHBoMZyBDKm/qhT2whXqXIfhAxiru2+5tlPBYWI9XNtjm5N3NJcvnhVPuogU/b1OIhPK3+uiO12ENNwgRhM7ufZ2z49x76fPGtvgfX7/FVMIDerRjC+uxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjmdE7bR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DB9C19422;
	Sat, 14 Feb 2026 21:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104364;
	bh=tcxNxY/RcEW8fyNeEwUv+xpFUl2huf4mxOXo6J+tqo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjmdE7bR6tbjhZYRkNO9AI4EjQVaoKNPZN3HTlZxO7FbqV/ZmPfipM6ONc22Otp2A
	 6xanKxJzuaBIWefXZHa0D8qewVzVwGKsaHdbYHo833ezq/HYzCgnnntGqRuG2m9FrE
	 +p7HpKlxUecK/HEpRQ8q40pdohdoYsjEc/aqA5ntR0HAg8IolIt/21nUy2nqiRPyH2
	 Lf7qqm/aoc9y7aHsKRvoD+euxJezS7teReSUnUNoFYOS45+MMtSYvoivfpUaxe1+u8
	 axNhEJ28ese0BCEEZZ3gkOMwLZNooLQnrx1yKb9xYKqbWA3Snqt9pX1YmxnL456FO1
	 gNAUDbK7aXgIg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Dian-Syuan Yang <dian_syuan0116@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.1] wifi: rtw89: pci: restore LDO setting after device resume
Date: Sat, 14 Feb 2026 16:23:08 -0500
Message-ID: <20260214212452.782265-43-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214212452.782265-1-sashal@kernel.org>
References: <20260214212452.782265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31861-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,realtek.com:email]
X-Rspamd-Queue-Id: E757713D5CB
X-Rspamd-Action: no action

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

[ Upstream commit af1e82232b988f8fc6d635c60609765e49221a64 ]

The LDO (Low Dropout Regulator) setting is missing after suspend/resume
in some platforms, and it will cause card loss. Therefore, reconfigure
this setting to avoid it.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260127085036.44060-6-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

### 3. CLASSIFICATION

This is a **suspend/resume bug fix** for a WiFi driver. The
`rtw89_pci_hci_ldo()` function is called during initial PCI setup (line
3065) but was missing from the resume path. After suspend/resume, the
LDO regulator configuration is lost, causing the WiFi card to disappear
entirely ("card loss").

The function `rtw89_pci_hci_ldo()` configures LDO-related bits in
`R_AX_SYS_SDIO_CTRL` for RTL8852A/885xB chips and RTL8852C chips. This
is a hardware register configuration that must be restored after power
cycling (suspend/resume).

### 4. SCOPE AND RISK ASSESSMENT

- **Change size**: 1 line added — minimal
- **Files touched**: 1 file (`drivers/net/wireless/realtek/rtw89/pci.c`)
- **Risk**: Extremely low — this calls an existing function that is
  already called during normal initialization. It's simply calling it
  again in the resume path to restore hardware state.
- **Subsystem**: WiFi driver (rtw89 — Realtek WiFi)

### 5. USER IMPACT

- **Who is affected**: Users with Realtek RTW89 WiFi adapters (RTL8852A,
  RTL885xB, RTL8852C) who use suspend/resume
- **Severity**: HIGH — "card loss" means the WiFi card completely stops
  working after resume, requiring a reboot
- **Real-world impact**: Laptop users who suspend their machines
  regularly will lose WiFi functionality every time they resume

### 6. STABILITY

- The fix is from Realtek engineers (Dian-Syuan Yang, Ping-Ke Shih) who
  maintain this driver
- It calls an existing, well-tested function — no new code paths are
  introduced
- The pattern is well-established: many PCI drivers need to restore
  register settings after resume

### 7. DEPENDENCY CHECK

The function `rtw89_pci_hci_ldo()` already exists in the codebase. The
`rtw89_pci_l2_hci_ldo()` call was already in the resume path. This
single-line addition has no dependencies on other commits.

### Summary

This is a textbook stable backport candidate:
- **Fixes a real bug**: WiFi card loss after suspend/resume
- **Obviously correct**: Restores hardware register configuration that
  was present during init but missing during resume
- **Small and contained**: Single line addition calling an existing
  function
- **No new features**: Just restoring existing hardware configuration
- **Low risk**: Calls well-tested existing code
- **High impact**: Affects laptop users who use suspend/resume with
  these WiFi chips
- **From the hardware vendor**: Written by Realtek engineers who
  understand the hardware

**YES**

 drivers/net/wireless/realtek/rtw89/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index b8135cf15d13c..fb4469a76bc03 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4605,6 +4605,7 @@ static int __maybe_unused rtw89_pci_resume(struct device *dev)
 		rtw89_write32_clr(rtwdev, R_AX_PCIE_PS_CTRL_V1,
 				  B_AX_SEL_REQ_ENTR_L1);
 	}
+	rtw89_pci_hci_ldo(rtwdev);
 	rtw89_pci_l2_hci_ldo(rtwdev);
 
 	rtw89_pci_basic_cfg(rtwdev, true);
-- 
2.51.0


