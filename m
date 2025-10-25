Return-Path: <linux-wireless+bounces-28251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3875C096C8
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DA8C4F1682
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E3D304963;
	Sat, 25 Oct 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPL0zfV2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86D330597B;
	Sat, 25 Oct 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408896; cv=none; b=Loak8ldaCa3K6sMKiNO133WPmTIBDAnp/YOoApEMGHvxdRvVWvV4X1f26Wn4amgcV+bDFXzwmjcTnRygfPB3GLzZFpPTQEW8BneUYRHJSL+pGOqGRYnnl8yuGWp1M6erX6AWBzMULgY8mhew+L9KCR3H7jCBya1Zr95r2YqexgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408896; c=relaxed/simple;
	bh=SJ2tykIRrO3VfuRAjf9XZkC0hbketZ/+M4J680sx3J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBPEW9disJ0F0t8TLCVw3BxSUtrerPtkItlJiznSXJfBmxuUslwrcNS8s0go4yOFYgPHFig6sT0jgdAlJO9Gm8rYDvecpQEilbwrFWAbGlYNMyOsjDagP2yxEQxQK+VXYFrW5JaeATN9RKCudz4kqErIIVMkZrSKBqzQhXLYGYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPL0zfV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33F4C4CEFB;
	Sat, 25 Oct 2025 16:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408896;
	bh=SJ2tykIRrO3VfuRAjf9XZkC0hbketZ/+M4J680sx3J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPL0zfV2Qwbq7utETjxjgS+g/9Oug8xwJHPFr5pgf0ghb3/CEdCbOTb2V7bRdmqkL
	 YcZK1VMqIGgjJHdZAhOkF4WfM5aGjw7cBiY7zUEpQ6USaLvxBTagLo5RLMNOYcUC+h
	 VcetzaIYiclIk9bLp5V+w0WFNx2oBB+LXVoOzN/EsuJ5ThQWxMggwUP2+OpqVe9jat
	 hKdR3hqhDG3cAJGJwC/PYBZTEXnGq3AD5xklZPE1iZvMb76tatdISAgZsBGMBTgTsk
	 Mrr56Ui90MZTn2g2xCLFSXXMedM6dQln3/Ev9tBSHWSzaeXq/UzTQnpY00TlD3iZae
	 XnbzuBLPAH4Ug==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] wifi: rtw89: add dummy C2H handlers for BCN resend and update done
Date: Sat, 25 Oct 2025 11:55:51 -0400
Message-ID: <20251025160905.3857885-120-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 04a2de8cfc95076d6c65d4d6d06d0f9d964a2105 ]

Two C2H events are not listed, and driver throws

  MAC c2h class 0 func 6 not support
  MAC c2h class 1 func 3 not support

Since the implementation in vendor driver does nothing, add two dummy
functions for them.

Reported-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com/
Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250804012234.8913-3-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- User-visible issue: firmware sends two valid C2H events which the
  driver doesn’t list/handle, producing noisy logs:
  - “MAC c2h class 0 func 6 not support” (INFO class, func 6)
  - “MAC c2h class 1 func 3 not support” (OFLD class, func 3)
  - Current dispatcher prints this whenever a handler is missing:
    drivers/net/wireless/realtek/rtw89/mac.c:5539.

- Root cause in current trees:
  - OFLD class has `RTW89_MAC_C2H_FUNC_BCN_RESEND` but its slot is
    `NULL` in the handler table, so it logs as unsupported:
    drivers/net/wireless/realtek/rtw89/mac.c:5410 and
    drivers/net/wireless/realtek/rtw89/mac.h:390.
  - INFO class has no enumerant for BCN update-done, so func 6 is out-
    of-range and also logs unsupported:
    drivers/net/wireless/realtek/rtw89/mac.h:398..403 and
    drivers/net/wireless/realtek/rtw89/mac.c:5418.

- What this patch changes (small and contained):
  - Adds two no-op handlers:
    - `rtw89_mac_c2h_bcn_resend(...)` in `mac.c` and wires it into
      `[RTW89_MAC_C2H_FUNC_BCN_RESEND]` in
      `rtw89_mac_c2h_ofld_handler[]`.
    - `rtw89_mac_c2h_bcn_upd_done(...)` in `mac.c` and wires it into
      `[RTW89_MAC_C2H_FUNC_BCN_UPD_DONE]` in
      `rtw89_mac_c2h_info_handler[]`.
  - Extends the INFO function enum with `RTW89_MAC_C2H_FUNC_BCN_UPD_DONE
    = 0x06`, which bumps `RTW89_MAC_C2H_FUNC_INFO_MAX` accordingly so
    func 6 becomes in-range: drivers/net/wireless/realtek/rtw89/mac.h
    (new enumerant before `RTW89_MAC_C2H_FUNC_INFO_MAX`).

- Behavioral effect:
  - These two events are now recognized and consumed without logging
    “not support,” matching vendor driver behavior (“implementation in
    vendor driver does nothing”).
  - No functional change to MAC/PHY state; only eliminates spurious logs
    for valid firmware events.

- Risk assessment:
  - Minimal: adds two static no-op functions and table entries; no
    locking or state changes.
  - `INFO_MAX` increases to include 0x06, and the handler table
    explicitly sets index 6, preventing out-of-bounds. Indices 4–5
    remain NULL (and still log “not support” if ever seen), maintaining
    current behavior for other undefined funcs.
  - No ABI/API changes; touches only
    `drivers/net/wireless/realtek/rtw89/`.

- Impacted subsystems:
  - Confined to rtw89 MAC C2H handling; does not touch core
    networking/mac80211 subsystems.

- Stable criteria fit:
  - Fixes an end-user visible annoyance (log spam/false “unsupported”)
    triggered by normal firmware behavior.
  - Very small, localized, and low-risk; no new features or
    architectural changes.
  - Reviewed-by present; linked to user report and discussion.

- Cross-version applicability:
  - The OFLD BCN_RESEND enumerant is present with a NULL handler in
    older trees (e.g., v6.1: mac.c:3928..3952 shows NULL; mac.h:303..330
    lists BCN_RESEND), so wiring a no-op handler backports cleanly.
  - INFO func 6 is currently out-of-range; adding
    `RTW89_MAC_C2H_FUNC_BCN_UPD_DONE = 0x06` and the matching handler
    table entry brings parity with firmware without altering other
    values.

- Security considerations:
  - None; pure handling/no-op of already-received control indications.

- Conclusion:
  - This is an ideal stable backport: it resolves a real annoyance with
    negligible regression risk and no functional downside, aligning
    mainline behavior with vendor expectations.

 drivers/net/wireless/realtek/rtw89/mac.c | 13 ++++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index ef17a307b7702..33a7dd9d6f0e6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5235,6 +5235,11 @@ rtw89_mac_c2h_bcn_cnt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
 }
 
+static void
+rtw89_mac_c2h_bcn_upd_done(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
 static void
 rtw89_mac_c2h_pkt_ofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h,
 			   u32 len)
@@ -5257,6 +5262,11 @@ rtw89_mac_c2h_pkt_ofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h,
 	rtw89_complete_cond(wait, cond, &data);
 }
 
+static void
+rtw89_mac_c2h_bcn_resend(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
 static void
 rtw89_mac_c2h_tx_duty_rpt(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 len)
 {
@@ -5646,7 +5656,7 @@ void (* const rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_EFUSE_DUMP] = NULL,
 	[RTW89_MAC_C2H_FUNC_READ_RSP] = NULL,
 	[RTW89_MAC_C2H_FUNC_PKT_OFLD_RSP] = rtw89_mac_c2h_pkt_ofld_rsp,
-	[RTW89_MAC_C2H_FUNC_BCN_RESEND] = NULL,
+	[RTW89_MAC_C2H_FUNC_BCN_RESEND] = rtw89_mac_c2h_bcn_resend,
 	[RTW89_MAC_C2H_FUNC_MACID_PAUSE] = rtw89_mac_c2h_macid_pause,
 	[RTW89_MAC_C2H_FUNC_SCANOFLD_RSP] = rtw89_mac_c2h_scanofld_rsp,
 	[RTW89_MAC_C2H_FUNC_TX_DUTY_RPT] = rtw89_mac_c2h_tx_duty_rpt,
@@ -5661,6 +5671,7 @@ void (* const rtw89_mac_c2h_info_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_DONE_ACK] = rtw89_mac_c2h_done_ack,
 	[RTW89_MAC_C2H_FUNC_C2H_LOG] = rtw89_mac_c2h_log,
 	[RTW89_MAC_C2H_FUNC_BCN_CNT] = rtw89_mac_c2h_bcn_cnt,
+	[RTW89_MAC_C2H_FUNC_BCN_UPD_DONE] = rtw89_mac_c2h_bcn_upd_done,
 };
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 241e89983c4ad..25fe5e5c8a979 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -419,6 +419,7 @@ enum rtw89_mac_c2h_info_func {
 	RTW89_MAC_C2H_FUNC_DONE_ACK,
 	RTW89_MAC_C2H_FUNC_C2H_LOG,
 	RTW89_MAC_C2H_FUNC_BCN_CNT,
+	RTW89_MAC_C2H_FUNC_BCN_UPD_DONE = 0x06,
 	RTW89_MAC_C2H_FUNC_INFO_MAX,
 };
 
-- 
2.51.0


