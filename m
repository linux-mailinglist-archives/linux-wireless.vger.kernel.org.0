Return-Path: <linux-wireless+bounces-4952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E71880DBE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 09:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908F5B23A5B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA473FB2A;
	Wed, 20 Mar 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Bc3L/JlT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward201b.mail.yandex.net (forward201b.mail.yandex.net [178.154.239.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0D3FB2C
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924545; cv=none; b=M8LuZc5M+X9m1o+MRq4DPKp7sdW5YkCsojO1fHolfsutvABP59WULHI+OxxRRo4My2M4DBUN7ZJ5R0/At0rdU27GKuDxFXjXPAvDyvuXUa5Fnwqj6FksSbWOKSYWjjEk9au4xjEo0i7JGDSPf2kuLFr8pBrSCNI1lRdeNvzB0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924545; c=relaxed/simple;
	bh=Qlioykv5hApah2n20hboUTEU7sRCpV3NlM03TtGRKSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoDM7LhvfO8stvTFBnGRniCiaBGUm3VlOBhZTgW2GhC3PZyvTB1LDu+5K9jLYeu6P8P5O+U0ATcisCQLQL5otlpw0fA50L/+tZXx2VNVOYUeLKJrgb2f8JK03VtlBA+1fLxcRKOsFK3lewIkwAsvvkVn6+y+P5gcAvcK2OKh/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Bc3L/JlT; arc=none smtp.client-ip=178.154.239.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
	by forward201b.mail.yandex.net (Yandex) with ESMTPS id B06586736B
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 11:43:35 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1791:0:640:98f4:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTPS id DCFF160B58;
	Wed, 20 Mar 2024 11:43:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PhAfFV1OduQ0-fJC1zOpZ;
	Wed, 20 Mar 2024 11:43:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1710924207; bh=isYLfReRHHxvrQUz/5fzhXAtiXm5WmMKSF2U7YoDwjE=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Bc3L/JlT9BW9WnzJwzG3HYJMJ+mctMldAnkT2b7D4ZYrvcVTDwQ4mjtb/TEJgGUyj
	 uWsWCgaa4wqw+IQw26aUEX99DOWSGo8Tr5JF8xkhxYCfNZKZqnqolOilxxTN/dhIaM
	 g3GzYH7wbcR2B0j7Qejet5GFvgJBiKPRezGLk2U8=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: rtlwifi: always assume QoS mode in rtl8192cu
Date: Wed, 20 Mar 2024 11:43:24 +0300
Message-ID: <20240320084324.109506-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320084324.109506-1-dmantipov@yandex.ru>
References: <20240320084324.109506-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'rtl92cu_set_hw_reg()', always assume that QoS mode is enabled
as it was hardcoded since an initial commit. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../wireless/realtek/rtlwifi/rtl8192cu/hw.c   | 30 +++----------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
index 76bedfec55a3..0195c9a3e9e8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
@@ -1484,7 +1484,6 @@ void rtl92cu_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	enum wireless_mode wirelessmode = mac->mode;
 	u8 idx = 0;
 
 	switch (variable) {
@@ -1536,36 +1535,15 @@ void rtl92cu_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		}
 	case HW_VAR_SLOT_TIME:{
 			u8 e_aci;
-			u8 QOS_MODE = 1;
 
 			rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
 			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
 				"HW_VAR_SLOT_TIME %x\n", val[0]);
-			if (QOS_MODE) {
-				for (e_aci = 0; e_aci < AC_MAX; e_aci++)
-					rtlpriv->cfg->ops->set_hw_reg(hw,
-								HW_VAR_AC_PARAM,
-								&e_aci);
-			} else {
-				u8 sifstime = 0;
-				u8	u1baifs;
 
-				if (IS_WIRELESS_MODE_A(wirelessmode) ||
-				    IS_WIRELESS_MODE_N_24G(wirelessmode) ||
-				    IS_WIRELESS_MODE_N_5G(wirelessmode))
-					sifstime = 16;
-				else
-					sifstime = 10;
-				u1baifs = sifstime + (2 *  val[0]);
-				rtl_write_byte(rtlpriv, REG_EDCA_VO_PARAM,
-					       u1baifs);
-				rtl_write_byte(rtlpriv, REG_EDCA_VI_PARAM,
-					       u1baifs);
-				rtl_write_byte(rtlpriv, REG_EDCA_BE_PARAM,
-					       u1baifs);
-				rtl_write_byte(rtlpriv, REG_EDCA_BK_PARAM,
-					       u1baifs);
-			}
+			for (e_aci = 0; e_aci < AC_MAX; e_aci++)
+				rtlpriv->cfg->ops->set_hw_reg(hw,
+							      HW_VAR_AC_PARAM,
+							      &e_aci);
 			break;
 		}
 	case HW_VAR_ACK_PREAMBLE:{
-- 
2.44.0


