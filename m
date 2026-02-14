Return-Path: <linux-wireless+bounces-31840-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNUuMSrokGkOdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31840-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:24:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69613D4B6
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C598301A396
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D39F28640F;
	Sat, 14 Feb 2026 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+gZBDcc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CAB29ACFD;
	Sat, 14 Feb 2026 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104295; cv=none; b=tAUr84LiOXqqglIDI3Rhec8TJr0qXyz3BrAPIIidi7i5nz6FWx6vovwV12XZu6v6SR0Jhpm4LI/6huV0ADtzVM/yC+APFi7kTv/WLIj5hJAjENJA+EdbHwP6NT1mYYNDb7b8fAz1c/k9DWMKTYcfvO9DiTFzVKKP7l3QyOJfqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104295; c=relaxed/simple;
	bh=qbG+cytLBGuBf7Y6F1iiJG92wjTNv9nLmvMZ7v94DY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWFhM04fW91b3nCjYIHKSkqGoAvhL4cDUBSozH3DNUJ0Q0OdG8fX1GgeipDX5m2Nr+Pop/inl9m6OGy+xWh6+uRmKkMOVExI2AYS+X0g9XZLLS05JDtKpGuZcAb9ebyLY6vNOzpmgS8gHgcobjCDV4Q14zaGn2178DO5iHDU0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+gZBDcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342F6C19422;
	Sat, 14 Feb 2026 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104294;
	bh=qbG+cytLBGuBf7Y6F1iiJG92wjTNv9nLmvMZ7v94DY4=;
	h=From:To:Cc:Subject:Date:From;
	b=o+gZBDccvqsssYIuf8HgsCrWKI9a+XReLet2BcZ0AOJRZv+vtC45MSSQfyOuruXdD
	 wp6+bz3BJDJMlgWDh/UT0Ha8iHij1yd28qcBS5cQ6/VH5fTkQeJVFRWC6c861czM+0
	 0kp3+lvLIlfEyq7WU7WJNWDxYtkm55kvRxUdy8E9hix5v4nvPsIehD6xZg70p05sHA
	 oo3v4FqjlyM2GoeSw1z/v8jBJtNYw+LNFsbeBOhQEUmoWU1YNxYbCC+XZvxuIcBR5z
	 58ClvlCBqidPeRK2nd06IivbQKiibVBI4IwARenFla1riIJVHZf5nU7q0q40QBNJ2N
	 J9iNJxhvid2kA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] wifi: rtw89: ser: enable error IMR after recovering from L1
Date: Sat, 14 Feb 2026 16:22:26 -0500
Message-ID: <20260214212452.782265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31840-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E69613D4B6
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

[ Upstream commit f4de946bdb379f543e3a599f8f048d741ad4a58e ]

After recovering from L1, explicitly enable error IMR to ensure next
L1 SER (system error recovery) can work normally.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251223030651.480633-6-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

That's a different change (about FW event mode). The current commit is
standalone - it fixes the error IMR not being re-enabled after L1
recovery, which is an independent fix.

### Verdict

**This is a real bug fix**: After L1 SER recovery, error interrupts are
not re-enabled, preventing the device from detecting subsequent hardware
errors. This leaves the WiFi adapter in a degraded state where the next
error will render it non-functional.

**Meets stable criteria**:
- Fixes a real bug (error recovery mechanism broken after first L1
  recovery)
- Small and contained change
- Low risk (calls existing, well-tested function at appropriate recovery
  point)
- Affects real users (any user with rtw89 devices that experience L1
  errors)

**Concerns for backport**:
- The struct change adds a new function pointer - this is structural but
  necessary
- The patch should apply cleanly to recent stable trees that have the
  rtw89 gen architecture
- Older stable trees may not have the `rtw89_mac_gen_def` infrastructure
  at all

The fix is small, focused on a real bug in error recovery, and the risk
of regression is very low since it calls an existing function that's
already used during initialization.

**YES**

 drivers/net/wireless/realtek/rtw89/mac.c    |  1 +
 drivers/net/wireless/realtek/rtw89/mac.h    |  1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c |  1 +
 drivers/net/wireless/realtek/rtw89/ser.c    | 10 ++++++++++
 4 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d78fbe73e3657..b4c292c7e829d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -7184,6 +7184,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.check_mac_en = rtw89_mac_check_mac_en_ax,
 	.sys_init = sys_init_ax,
 	.trx_init = trx_init_ax,
+	.err_imr_ctrl = err_imr_ctrl_ax,
 	.hci_func_en = rtw89_mac_hci_func_en_ax,
 	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_ax,
 	.dle_func_en = dle_func_en_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 0007229d67537..a4ed1c545609e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1019,6 +1019,7 @@ struct rtw89_mac_gen_def {
 			    enum rtw89_mac_hwmod_sel sel);
 	int (*sys_init)(struct rtw89_dev *rtwdev);
 	int (*trx_init)(struct rtw89_dev *rtwdev);
+	void (*err_imr_ctrl)(struct rtw89_dev *rtwdev, bool en);
 	void (*hci_func_en)(struct rtw89_dev *rtwdev);
 	void (*dmac_func_pre_en)(struct rtw89_dev *rtwdev);
 	void (*dle_func_en)(struct rtw89_dev *rtwdev, bool enable);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 556e5f98e8d41..9b9e646487346 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2601,6 +2601,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.check_mac_en = rtw89_mac_check_mac_en_be,
 	.sys_init = sys_init_be,
 	.trx_init = trx_init_be,
+	.err_imr_ctrl = err_imr_ctrl_be,
 	.hci_func_en = rtw89_mac_hci_func_en_be,
 	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_be,
 	.dle_func_en = dle_func_en_be,
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index f99e179f7ff9f..7fdc69578da31 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -431,6 +431,14 @@ static void hal_send_m4_event(struct rtw89_ser *ser)
 	rtw89_mac_set_err_status(rtwdev, MAC_AX_ERR_L1_RCVY_EN);
 }
 
+static void hal_enable_err_imr(struct rtw89_ser *ser)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	mac->err_imr_ctrl(rtwdev, true);
+}
+
 /* state handler */
 static void ser_idle_st_hdl(struct rtw89_ser *ser, u8 evt)
 {
@@ -552,6 +560,8 @@ static void ser_do_hci_st_hdl(struct rtw89_ser *ser, u8 evt)
 		break;
 
 	case SER_EV_MAC_RESET_DONE:
+		hal_enable_err_imr(ser);
+
 		ser_state_goto(ser, SER_IDLE_ST);
 		break;
 
-- 
2.51.0


