Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C82240EA4
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Aug 2020 21:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgHJTPC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Aug 2020 15:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730127AbgHJTPA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Aug 2020 15:15:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B94E22CAF;
        Mon, 10 Aug 2020 19:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086899;
        bh=uk29GL4coUtLWOOTzRqG3SuII1bqfwPuOXtVJvyFpM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpzKaeUT5zzItKZGQBosQAaLBIn+TU2Or8OwUYOKBaRwnLTO5sUnjMlKoOxOTGSX6
         hdL/opnIuR90RH47Bz3gBFVWMCT3wodA7N9GRlk+Lc+wF9JQK0EzfU5lLXVsbCSCEO
         kkj7A4F0tgRPP1sU/yiVpASHv5nmOMweK5QkY6dY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 10/16] iwlegacy: Check the return value of pcie_capability_read_*()
Date:   Mon, 10 Aug 2020 15:14:37 -0400
Message-Id: <20200810191443.3795581-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191443.3795581-1-sashal@kernel.org>
References: <20200810191443.3795581-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

[ Upstream commit 9018fd7f2a73e9b290f48a56b421558fa31e8b75 ]

On failure pcie_capability_read_dword() sets it's last parameter, val
to 0. However, with Patch 14/14, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x).

This bug can be avoided without changing the function's behaviour if the
return value of pcie_capability_read_dword is checked to confirm success.

Check the return value of pcie_capability_read_dword() to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200713175529.29715-3-refactormyself@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/iwlegacy/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/iwlegacy/common.c b/drivers/net/wireless/iwlegacy/common.c
index 544ab3750ea6e..c56febdae1349 100644
--- a/drivers/net/wireless/iwlegacy/common.c
+++ b/drivers/net/wireless/iwlegacy/common.c
@@ -4294,8 +4294,8 @@ il_apm_init(struct il_priv *il)
 	 *    power savings, even without L1.
 	 */
 	if (il->cfg->set_l0s) {
-		pcie_capability_read_word(il->pci_dev, PCI_EXP_LNKCTL, &lctl);
-		if (lctl & PCI_EXP_LNKCTL_ASPM_L1) {
+		ret = pcie_capability_read_word(il->pci_dev, PCI_EXP_LNKCTL, &lctl);
+		if (!ret && (lctl & PCI_EXP_LNKCTL_ASPM_L1)) {
 			/* L1-ASPM enabled; disable(!) L0S  */
 			il_set_bit(il, CSR_GIO_REG,
 				   CSR_GIO_REG_VAL_L0S_ENABLED);
-- 
2.25.1

