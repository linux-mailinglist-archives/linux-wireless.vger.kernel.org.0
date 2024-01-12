Return-Path: <linux-wireless+bounces-1848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090AC82C813
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 00:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE9B28695F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 23:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3741BDE0;
	Fri, 12 Jan 2024 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9kUiCYH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DA21BDC6
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e586a62f7so40454565e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 15:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705102954; x=1705707754; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RIte2y7M1FzOvcoNgzcBwvhRHKktRIdQOz1wPsAZgM=;
        b=W9kUiCYHaxEAUOMWeHxNaHIjQIf7I63kWWdQroQdzBp+9moijsCUS5+Xt7smfr+FKn
         a+b0URi0VKk8zenn9mVzvPyVwU3un+tjppcOPkeM8+3gjASB2s98RmQiMOKWE+3/Luo8
         tpyIksnrorJEapdmhjkagKZscixnmYj8Wk8jWEqapdOvw0pS62/QJvZTvPHk/FQVmkCL
         +xnwBo3Gf3TlVirRucHCYyU48h4j2HlivxMxXL5QSg3ISrw7kowm/+Q3I+CnvJ5W9RGq
         XBE92iTiR+614Uth+lg1AL7aC2a77c1GduVUPzaSKLX+3jcJQlTNGsSdBROExjuSM+5M
         Yn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705102954; x=1705707754;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0RIte2y7M1FzOvcoNgzcBwvhRHKktRIdQOz1wPsAZgM=;
        b=NzkRsOH8w24xfofENU7qo77dxXEzvHcdjIKjk7NJ3q0w7pEcekGChIOBM/xrzsPhv5
         qwHO/xuGkdKr6rqc03DUP3n2E7+8tCEPeqR5c/Af1IksY9u0HeR4r4nwQFbQ51jx5VaP
         sDR5F6JiUb/u5WtKBf7a5XtcjDHc1X3SgKCaq6ymKLghXD6TwLv/NPWr2duLgcHaEgiY
         wOQkMIHRYxA0g4j+nQV6IR3vjbd4lVWkPYje8N3rJ8k+lEv0p06i8ErQZ0SlEBln7CWU
         NzZl3+uAXJDQq49/OWPRLP9CSMa90wJUjq7mvpcSsyio46Efdx88Nf5yN+az3oS351Ti
         Br4w==
X-Gm-Message-State: AOJu0YyLU9CZRd/xcCIxFNDgLm4gbPPsPFwRVHtKU7VoUx/VZQYqIVJq
	7DwxpirPTdKhgfonPHdDdrvAbRgHNMQ=
X-Google-Smtp-Source: AGHT+IEP/Uj1Bys0EzaSWrkFiaQgZEI1HLv+SREkBqW96YF+PFtnIVS6hEjf8O6OUrRVW2kTLnECug==
X-Received: by 2002:a05:600c:6a06:b0:40e:66ac:dfd7 with SMTP id jj6-20020a05600c6a0600b0040e66acdfd7mr963474wmb.87.1705102953703;
        Fri, 12 Jan 2024 15:42:33 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b0040d6b91efd9sm11180319wmq.44.2024.01.12.15.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 15:42:33 -0800 (PST)
Message-ID: <19a3e023-0eaa-4096-9f78-a2c8e909cb54@gmail.com>
Date: Sat, 13 Jan 2024 01:42:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: rtl8192de: Don't read register in
 _rtl92de_query_rxphystatus
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Instead of reading bit 9 of RFPGA0_XA_HSSIPARAMETER2 every time a frame
is received, just use rtlphy->cck_high_power, which is initialised in
_rtl92d_phy_bb_config(). That bit never changes anyway.

With this change _rtl92de_query_rxphystatus() can be shared with the
upcoming USB driver. The USB driver can't read registers in this
function because register reading can sleep.

Compile tested only.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
"That bit never changes anyway." <- I'm 99% sure this is true.
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
index 02ac69c08ed3..192982ec8152 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -42,6 +42,7 @@ static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
 				       bool packet_beacon)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtlpriv);
 	struct phy_sts_cck_8192d *cck_buf;
 	s8 rx_pwr_all, rx_pwr[4];
@@ -62,9 +63,7 @@ static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
 		u8 report, cck_highpwr;
 		cck_buf = (struct phy_sts_cck_8192d *)p_drvinfo;
 		if (ppsc->rfpwr_state == ERFON)
-			cck_highpwr = (u8) rtl_get_bbreg(hw,
-						 RFPGA0_XA_HSSIPARAMETER2,
-						 BIT(9));
+			cck_highpwr = rtlphy->cck_high_power;
 		else
 			cck_highpwr = false;
 		if (!cck_highpwr) {
-- 
2.43.0

