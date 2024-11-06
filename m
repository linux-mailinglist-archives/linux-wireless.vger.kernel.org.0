Return-Path: <linux-wireless+bounces-15001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F7E9BF21B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 16:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7328A1C262E9
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E141202F87;
	Wed,  6 Nov 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU7sXoXt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9378A1DED78;
	Wed,  6 Nov 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908006; cv=none; b=Pecb4pK29Dfr1KU/rCkkVUWhswcs85u+4vGed+zUWDzULGxdK58dBBcVhC8HeqGxnKQx5DWTIOlzy6Tw1OBFFbod4w5nIn+AnMDNFc/B4AL2CfUaitC8N9vYB7mM5PRwsjF4cKDcCicaKayjmyOSCUPHthDEaiDVSsWxiDNj30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908006; c=relaxed/simple;
	bh=G8zBc1oEplggrSzM+Oq3oTQta1iek8SOWLMNciD4Ih8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nYepZeopsKOMQWC1x/UACYlygpkzXES0j/+lV9kucWc31neYTU7A3Ld6uRvBq0kQnNLdz/E/vUjAH5e3H2w5Ksqn8+qCT7VctTO3itERRlUEGUszhyEs1FzOlXK0vp37VNB4WqEDSuiQLBSxjLQ9HjMdn0hSGuvSYTWjrtf6pPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eU7sXoXt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so4125932f8f.1;
        Wed, 06 Nov 2024 07:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730908003; x=1731512803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EC5VDHqSWLfCPmVYOJBa2WEZ3CWt2YCpwg/25w5EPY=;
        b=eU7sXoXte0xD8O5bNEZN1OIlZysXgMQE7VgTpiJxhqbB889PwQ+K80qElNLTNoT78n
         kkETqxk1eziak7mneMjrJIH6xIgq56+C2cJbaXYIx2yv1GZMrFLnUHNghofg6D6YGwsL
         A4R8H/pThxxGcldAZpmtOhd2ojLINInMIS7t3Wbuygs2Z5FYQ708IpPDECs+cJlTljrl
         SOvMrfmGvBqtXE4IWD1WbJE8N6enIIh+51TUML+krI4UZkPCHSeYYteSzBRa2KIrYEmF
         Sj39eIBScLDyEScPoMp992JCLyhkXIMs+qt5G3im1Zq+CKXNnw0ZwmoW3cdeAUNJXASd
         LaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908003; x=1731512803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EC5VDHqSWLfCPmVYOJBa2WEZ3CWt2YCpwg/25w5EPY=;
        b=Ru2P8hsFva2oUX6DpHy/jN1jns0PcLm8YPK+tYXK1pJ+JaRR13JmSie+8d+m2xpaJh
         MqhcKHktwK5AK5GHOumfym7Ra/p+VBRKoGzImWO0tAZN4f5WwEzyX7smr0iuXXDrE123
         mkqp6km7t5SZTgp4dDwtNYXqOhfcamDpi+VYUoiNC0p2z0Bpo0QkIK1J7Jc4PS1bterL
         gwuLVRhUsKhl2eu8NDFOMookbXxOtIfgj3mPMHZOuYPPJxMuMu7HyGoMyPHnHUufwhxg
         yPxN3RTuXHNFIM1tSdR273D5F79tR502Za057Di9E3ntv5Mxm3Z4Fi3f9UuJ+KzZEzz5
         HrjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Rr7WHaEGqJ+bi77Y8/3VeTCKbWYM7GcMaqghoq8lzz+K7gIq8gLEMCfyMDWRJjS1FH7oRpJn@vger.kernel.org, AJvYcCW5JDXxpJp140+idjBd9hJ25qyZLXykYo5syNoYaxkjqkEoi8cuvFohJsjt4KgeVMu6iCNcqpqCPF0PDsw=@vger.kernel.org, AJvYcCXr6bOgSo3T0UMukhX+lDpIy2MdtDc7uHtDhURlzWd6P7JAK3KQx/ofXPvQZm1+EQtEd4BGpsTqoZZKoBZNttA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv9XmQp5+/u7vEiICTcs70TzITxgxuIP2nckAJJSaUpTa9l4RY
	ey9aLx4hoW2W6ph8SrxzVFz60Y1gcelMOwWJ+nm5PHzWXLmnjdeeOgYnfzPe
X-Google-Smtp-Source: AGHT+IF0gS5uvSc6VBJvVmYfWGVw97ZH6XEwCzJ1W2ZqRxljLrNtNME6ZvLIl6VN+GC+0i3AfJJErQ==
X-Received: by 2002:a05:6000:3c6:b0:37d:3650:fae5 with SMTP id ffacd0b85a97d-381c7ab60efmr19184695f8f.52.1730908002781;
        Wed, 06 Nov 2024 07:46:42 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b97sm19740853f8f.2.2024.11.06.07.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:46:42 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Su Hui <suhui@nfschina.com>,
	linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: rtlwifi: rtl8821ae: phy: restore removed code to fix infinite loop
Date: Wed,  6 Nov 2024 15:46:42 +0000
Message-Id: <20241106154642.1627886-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A previous clean-up fix removed the assignment of v2 inside a while loop
that turned it into an infinite loop. Fix this by restoring the assignment
of v2 from array[] so that v2 is updated inside the loop.

Fixes: cda37445718d ("wifi: rtlwifi: rtl8821ae: phy: remove some useless code")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index 1be51ea3f3c8..0d4d787e8be5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -2033,8 +2033,10 @@ static bool _rtl8821ae_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
 			if (!_rtl8821ae_check_condition(hw, v1)) {
 				i += 2; /* skip the pair of expression*/
 				v2 = array[i+1];
-				while (v2 != 0xDEAD)
+				while (v2 != 0xDEAD) {
 					i += 3;
+					v2 = array[i + 1];
+				}
 			}
 		}
 	}
-- 
2.39.5


