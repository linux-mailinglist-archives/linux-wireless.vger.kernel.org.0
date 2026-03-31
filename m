Return-Path: <linux-wireless+bounces-34206-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPVhOCRry2mfHgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34206-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 08:35:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 366A336483B
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 08:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04BAD301CF99
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 06:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30D74086A;
	Tue, 31 Mar 2026 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTE805pn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB8040DFAC;
	Tue, 31 Mar 2026 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938827; cv=none; b=mnVDKillCYjAwFCcQ96GLvbzKjXL8MpK0XqU0u7rsO2hkz6W/bMHH2qed04LWEXwD1ZzptobVpcqEJihMqNeVF8mW1xKAaw9xv8bZHcnHSY9NvQre7aSmaFJO0RIci6J3GkvgP7HNFDmE/70ZQVP+YsxmfLKR7mHBk9egRTnzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938827; c=relaxed/simple;
	bh=ui7nelJNgDVq7+lCQ8oQddflHq1KI/3JObI0yenQbQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t6AbPyGiquvP35YnHfEKtIV83uQQpJQbJJq10roZkUwUrH9UKM8w1NX32si5J6urxvtls8yzbXOGCybje/kInrg8x+f8wxLMWysghNVDuG19z/y44qFTlSLpWE0LS4iU7eGPZWIx+14UpYXZhMVyCzMwluzaZc0Lrw7TucxvpXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTE805pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 439DEC19423;
	Tue, 31 Mar 2026 06:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774938827;
	bh=ui7nelJNgDVq7+lCQ8oQddflHq1KI/3JObI0yenQbQE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZTE805pno7S6DeTyVYU0xr0Ac0Sk7pZt3Koareit5y7Go7/0WzmS5fstfcFIUMgSN
	 MOZl7bqz2CGZSym+Cc69MS/vlcuR+nt2n3nh3s4hNlWpA8hVbMFGc7XIjT+zmiBc9y
	 KlBNTsVsU+npAC+UhmXa6o1tKn1Mr6PEVjH6YoNZzGXr8MOMfYxro8CaksVcWe7yBu
	 cz9VZDGUDygWhJYOJmnfzT288lzUBIuV0EhPNKZTiGTwLehtl5+7Cl6g9sRAtcW7Zy
	 AO+rnIccsC0c3R8tLt+u70Fer8Nnqg7nfpvgOQKEsEw3ERswlK+JUww88plpo34u7u
	 e2VzB/TWn3GvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F678FF60CF;
	Tue, 31 Mar 2026 06:33:47 +0000 (UTC)
From: Kyle Farnung via B4 Relay <devnull+kfarnung.gmail.com@kernel.org>
Date: Mon, 30 Mar 2026 23:32:53 -0700
Subject: [PATCH v2] wifi: ath11k: apply existing PM quirk to ThinkPad P14s
 Gen 5 AMD
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMSw7CIBSF4a00d+w1PMSkjtyH6QAptDdKQVCia
 di72LnD/yTnWyHbRDbDqVsh2UKZwtJC7Dows14mizS2BsHEkUnJMPJDxujx8aJ0Q6YVv2reC6k
 ctE9M1tF78y5D65nyM6TPxhf+W/9JhSNH44TTsjdGjOo8eU33vQkehlrrFwFGBJiqAAAA
X-Change-ID: 20260330-p14s-pm-quirk-0a51ba19235f
To: Jeff Johnson <jjohnson@kernel.org>, 
 Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Kyle Farnung <kfarnung@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774938826; l=2024;
 i=kfarnung@gmail.com; s=20260330; h=from:subject:message-id;
 bh=goqTouCdFtdr9SNadM69GmR467yJ8YsnFiPC1yn5iAQ=;
 b=IdTKuCdL9uMN7+89uh+WWQM8YD+zhhN/m4BDbQDv4Ukh/UqXDAxT/kZFxTkgIyohPv/r4xmNp
 h+R43lTYheCDkjHeMkAMiQ3CqrP9or/GUtWD8C5oV/nlkR0bptu41P1
X-Developer-Key: i=kfarnung@gmail.com; a=ed25519;
 pk=47jis5OdLKFgZynNQVqkx1mTGiEgFTUX+MecmG9rbmE=
X-Endpoint-Received: by B4 Relay for kfarnung@gmail.com/20260330 with
 auth_id=706
X-Original-From: Kyle Farnung <kfarnung@gmail.com>
Reply-To: kfarnung@gmail.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34206-lists,linux-wireless=lfdr.de,kfarnung.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,lists.infradead.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kfarnung@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lenovo.com:url]
X-Rspamd-Queue-Id: 366A336483B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kyle Farnung <kfarnung@gmail.com>

Some ThinkPad P14s Gen 5 AMD systems experience suspend/resume
reliability issues similar to those reported in [1]. These platforms
were not previously included in the ath11k PM quirk table.

Add DMI matches for product IDs 21ME and 21MF to apply the existing
ATH11K_PM_WOW override, improving suspend/resume behavior on these
systems.

Tested on a ThinkPad P14s Gen 5 AMD (21ME) running 6.19.9.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
[2] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/

Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
---
Changes in v2:
- Fix missing mailing list recipients (linux-wireless, ath11k, linux-kernel)
- Link to v1: https://lore.kernel.org/r/20260330-p14s-pm-quirk-v1-1-cf2fa39cc2d5@gmail.com
---
 drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 3f6f4db5b7ee1aba79fd7526e5d59d068e0f4a2e..21d366224e75904feeae6cb9c93d9ef692d127fe 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1041,6 +1041,20 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
 		},
 	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* P14s G5 AMD #1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* P14s G5 AMD #2 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
+		},
+	},
 	{}
 };
 

---
base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
change-id: 20260330-p14s-pm-quirk-0a51ba19235f

Best regards,
-- 
Kyle Farnung <kfarnung@gmail.com>



