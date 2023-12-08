Return-Path: <linux-wireless+bounces-570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBB4809B0A
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 05:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B292281DCF
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 04:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136511701;
	Fri,  8 Dec 2023 04:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l87m/mI8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1A0D54
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 20:34:41 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id 006d021491bc7-58d08497aa1so839894eaf.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 Dec 2023 20:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702010080; x=1702614880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MzdoGtdHZLEcq5pMBvJRDZhfXWWnoZDZDt/RPy/Z6xs=;
        b=l87m/mI8PcZXZ0x2CFILn+q0LkL2M0RSj47bxlCFmbRPTfM0Lh9qusU/Cg+etqtgEa
         Rkkqx1KVe6pDQL2wjCRcgy1PlrfKbtEvGPwzfNVFiqcNhQ4WxvqGJ/1jZiXhHphU/piU
         lzj0WS7B/LFhgyyu0VWqCGoUH/YXgN2MrQog1wUgcgJvvfNQt0KSK/aHO5s/J/uUvl4o
         LgQOm8Tdhd/XFERa2+QQ/ComwfJARZxtmH0rdk7flvfT5GgLD1INFNYiTWwPJ4eH2s8x
         IyOyicfjeQnZa/KcvUyTFJVrfGldDZJoOkI1GUWAHKKahYfVC33v4+shkfwxgXOi5CGF
         bD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702010080; x=1702614880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzdoGtdHZLEcq5pMBvJRDZhfXWWnoZDZDt/RPy/Z6xs=;
        b=HN4VwgKKgYmOg+S94xMT/eh82ZNhXdQTMqt1SxAXIJeuTwqAzwTG0g5GSsOkLxq8Rj
         H8m+cjddivpi0i6AoebZTLMtwafi3jJ6IVc9wvGshGw8cWdcn1nbO38dacL7yv4PYzbq
         bq9/fS4Lg7Tk61N4p9mT1/MZQC/H5uppamQWCPPiqOMiTC0SEmSOxtcMI69E9bNVDYt4
         QFahMYBmUZ0q9JeSl53VWHW5nVGpDAIlf6Io5qAnQUh7Iu2xR/cvaNXo7rlD8rHOedjy
         lFOkv3kRtWgR+x+HThGcgfrpCSOiiAZ5yolc4jWBMm4Ky6s0PZdvjrrryQo9EcXAVFlT
         HuyA==
X-Gm-Message-State: AOJu0Yxst4SCChZOSfQ18vq8g4KhHELgZxfv1ORgW5wZpCc85QpxtZDG
	3iteG3OFS4hEqzliy1HAIzk=
X-Google-Smtp-Source: AGHT+IHwbZG0kRlAsNtdu+0sGh4J/wEBGtXiM5SFj7ehSi0/JEn2pS/DRM/JW/QkcFKYJdOOCfAmRg==
X-Received: by 2002:a05:6358:60c1:b0:170:8da:1f50 with SMTP id i1-20020a05635860c100b0017008da1f50mr4060520rwi.20.1702010080287;
        Thu, 07 Dec 2023 20:34:40 -0800 (PST)
Received: from localhost ([113.88.15.172])
        by smtp.gmail.com with ESMTPSA id ff16-20020a056a002f5000b006ce65bf5376sm613293pfb.75.2023.12.07.20.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 20:34:39 -0800 (PST)
From: Xingyuan Mo <hdthky0@gmail.com>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
Cc: linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
	Xingyuan Mo <hdthky0@gmail.com>
Subject: [PATCH v2] wifi: ath10k: fix NULL pointer dereference in ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()
Date: Fri,  8 Dec 2023 12:34:33 +0800
Message-Id: <20231208043433.271449-1-hdthky0@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should check whether the WMI_TLV_TAG_STRUCT_MGMT_TX_COMPL_EVENT tlv is
present before accessing it, otherwise a null pointer deference error will
occur.

Fixes: dc405152bb64 ("ath10k: handle mgmt tx completion event")
Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>
---
Compared with the previous version, Signed-off-by and Fixes tags are added.

 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 6b6aa3c36744..0ce08e9a0a3d 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -851,6 +851,10 @@ ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev(struct ath10k *ar, struct sk_buff *skb,
 	}
 
 	ev = tb[WMI_TLV_TAG_STRUCT_MGMT_TX_COMPL_EVENT];
+	if (!ev) {
+		kfree(tb);
+		return -EPROTO;
+	}
 
 	arg->desc_id = ev->desc_id;
 	arg->status = ev->status;
-- 
2.34.1


