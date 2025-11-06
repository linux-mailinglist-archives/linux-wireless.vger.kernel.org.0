Return-Path: <linux-wireless+bounces-28641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 037D9C38838
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 01:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99EA834F9E4
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 00:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E3028682;
	Thu,  6 Nov 2025 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NrfBlESi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556FE86331
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389970; cv=none; b=hfx4gtrBM1jWFef5hyh0Vb546QBVo8lUF874Kl2dGR/0Te970ETzknVi3P+2PDNpf8NeuuLq9IlwW4PPJDJ/NVIZIr+VZ4lSK4FcrdqDIrzGE+8YSjqVQnorrx9Yrh7B9osF6CARmFnigh5X/rtU6XbQpPMa1ALKTdIdcRx00O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389970; c=relaxed/simple;
	bh=FWSS/quBZeKlwUvl0vjNF7hYHXs6KVkm+0JA9K/i7R0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eD27XFtoZPN2bo77rnD04+DenUdUC115+NawPeyCqfhDEmFZGbZkHzrqEYBTAik71N7Gtl9ZONfmBh48NCSzdJcxzVzU62eMLZ22hyHZBYmG2pZwcAKek5lTzP912OdoNLEAW/Qo3Ze8iMoxi7IgeezEC15M1lAdP+R0/e98LeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NrfBlESi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A60k09912075728, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762389960; bh=KURB2uBVCzRtyxWr0PxwxreV5e8VDXK9N/Fuqg/4SQc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=NrfBlESi1TKjT8SuVZ6orueA7Dk7b/pHlBQA7AuWHQGUwZgcDpz+LvaRv8YZCPPX9
	 KrEWhfPun/CcK1DnQZllBXtvLs78QFH7BRpIMCRXZpuBaxhS/Dx5d42sQC7CAQ70gj
	 8L5uuqFcv0dzvb+FEsVACAcYxQf/Krsd7VwAXtd2lpaOtlDRh04PbG6IctKWUquFLy
	 CgDi7qoJ3DJmbj7PY1DipFR1rR0F7OmrfpdxEynk9FX4I6x7oDnmPamRo2jvw5x5f7
	 bxYYxkK7WMij3VohJJ1e1eVYNsYtmaD0dSdh5NOhidFVZxV2ODTQAiA9NZmcadbY8x
	 /lUjcdrGEM6Jw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A60k09912075728
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 08:46:00 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 6 Nov 2025 08:46:01 +0800
Received: from [127.0.1.1] (172.21.146.58) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 6 Nov 2025 08:46:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <dan.carpenter@linaro.org>
Subject: [PATCH rtw-next] wifi: rtlwifi: rtl8188ee: correct allstasleep in P2P PS H2C command
Date: Thu, 6 Nov 2025 08:49:32 +0800
Message-ID: <1762390172-21091-1-git-send-email-pkshih@realtek.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The "->allstasleep" variable is a 1 bit bitfield. It can only be 0 or 1.
This "= -1" assignement should be "= 0" as other chips and vendor driver.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-wireless/5c992936-4e7b-4c0a-abfc-0ec0fb9ef9fd@suswa.mountain/T/#t
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
index 7252bc621211..9a9f9e14f472 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
@@ -694,7 +694,7 @@ void rtl88e_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 
 			if (P2P_ROLE_GO == rtlpriv->mac80211.p2p) {
 				p2p_ps_offload->role = 1;
-				p2p_ps_offload->allstasleep = -1;
+				p2p_ps_offload->allstasleep = 0;
 			} else {
 				p2p_ps_offload->role = 0;
 			}
-- 
2.25.1


