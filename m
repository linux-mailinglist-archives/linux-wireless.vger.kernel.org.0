Return-Path: <linux-wireless+bounces-19105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B2A3AB3F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 22:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5096188DE91
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 21:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651C1C5D6E;
	Tue, 18 Feb 2025 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMA1cZHG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2692862AD
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914954; cv=none; b=hG5CBnetYKlwgd78tslIqJc/WvcneeDF4CnkGSAkm4blIlb3UXcDuVKznzBodirb6gS8H6KGDIt56ZABPxpk6M98yNg6E56fdQB8PlY9JTP/Ex9s8jBWtmYDTWM3MXGP/xh4z/no4P3ctfF8L/wF785Unwwievo4DN0gUbGgvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914954; c=relaxed/simple;
	bh=dvT+OGJFnH+id/Afx4qY9wUNsaN0FnPaOn15yIyAI9k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ZvvFlZEeaTH0boAIfi4ssTEybWFL9EM8NFiWYCxTOxJ1+UbNZj47rqRc+eZdUFfRj4JsnVptuSPSp/byTTlwB87L8xN9is0mUsLLx6RyrrTeyND4etVZwOfLj7VHeYbsowY+IzkpO7IojbjD9IV7RVRqE3WBquMmJ7dNhVWT/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMA1cZHG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb79af88afso637816466b.1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 13:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739914950; x=1740519750; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbzWCcbRbOTgT4JZLAfnqovMcN7JLOQtCl2OkmB7qPE=;
        b=JMA1cZHG1ETjbXc4GHJqJsriey9Zk1oo0krOWncKCY4fuKWjL811TLVSHf8kaRMJHc
         rWx5/Sey0J9BqWvwvAb1GXijIJP78yulqQ5GGAaY95X3OOmcJBP6dqGgjC14BSaFYrcx
         jh9UjK1ZlWgk2qqhPHCNwntckSoF2oStcEtg89OCJcmO3lTihy+H3HLEHQhsZC3gvWoh
         EXluLcp01bH7CIu9WtNIMD2Z70uCJxCylJTlwYQ+xZ9/2ZrN88Y8wdWME2Dg32gpGt92
         ifd3jD4Qud80e3vLn+nkyjIU9cxCEtDXRRoRRIpnORM//HpGE74BksiwgNwQetpFqbL/
         k1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739914950; x=1740519750;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lbzWCcbRbOTgT4JZLAfnqovMcN7JLOQtCl2OkmB7qPE=;
        b=g4oiHMBZXBD4joX/Hb6tcCvZHFic+q4oN2aNttjjaXB6+CD6MbOZuLGts7mnOugGNr
         euUS+6Dg7Clvwz3gexzhsxSurjRMuxEbaQn29bZEgv+P6GmUCdyWHd53BLnkAIdOCgVp
         /lBY1F4tACzQjZ1syQTkV+kv5t24jciVhFHeGV06nKJtei4dCymK4pPddAXCVrzm8YeC
         9/+frf/Q4+LCls4enmBgOD08DAWctLRLBo2RijCpsAGk6wF0GtMUAFtD+jn5UKbfplta
         WMB+CY4Pu2MugLdmoVzcTu4edFzsImBbz3AtRwuCOLO7zldej9/KB1pJI4R048phefs5
         b7Zg==
X-Gm-Message-State: AOJu0YzpRgUo0bzLfOafgYKRUV4mBKxS4xEzmWqx6r2a3KUD3rWGbddS
	kSOcPE+vUvImk93vSBVPB0dKhP5bv1IWA3j3jHiaEv7JmN9iC90EEG9awQ==
X-Gm-Gg: ASbGncsDZjfAgBlBNDB2aEE7WepGQSKjWOAqu3+dXKxUWps6UPG8YWo/6VwMjWy2mjK
	Dc/VpJiyx1QTzkYBbBuiYA/kiv81aPLHEKsbNNYCZhd8jJ59dkLb8+DQ3XQcbSY3WMj6ymM6Vth
	AUCtVoGWurfojnJGKbSswdufqPK50eL2ahyVCzTlXU6/6yNsiq6vkAU93h9mVSCpWfctDpxEGXM
	lFlpCukP7YKijytfgPLdqvA4frX4q6xE3LGTmWaR3POlLjSicVeV+EP1pImy4VxdzzZ4X2bOScl
	c8nZoFk7Pw7zDzgzFV5kNm00
X-Google-Smtp-Source: AGHT+IF3uqBX1tx0sYshgezudLhj6V4db33vMVJr9meTAQQEZnxA6I1SdEhQHqLKeHsz865wnaGYqQ==
X-Received: by 2002:a17:906:c154:b0:aaf:74dc:5dbc with SMTP id a640c23a62f3a-abb70bbe128mr1780329166b.29.1739914948048;
        Tue, 18 Feb 2025 13:42:28 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbbb6553bcsm189674166b.185.2025.02.18.13.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 13:42:27 -0800 (PST)
Message-ID: <0c91ac77-a652-4ab4-b911-e0a2386fb863@gmail.com>
Date: Tue, 18 Feb 2025 23:42:26 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: pci: Fix condition to wake the queues
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The TX queues should be woken when there are at least 4 available
entries, not when there are at most 4.

Tested with RTL8821AE.

Fixes: d0311314d002 ("rtlwifi: rtl8192ee: Fix handling of new style descriptors")
Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 0eafc4d125f9..9614a9e752b9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -520,7 +520,7 @@ static void _rtl_pci_tx_isr(struct ieee80211_hw *hw, int prio)
 			rtl_tx_ackqueue(hw, skb);
 		}
 
-		if ((ring->entries - skb_queue_len(&ring->queue)) <= 4) {
+		if ((ring->entries - skb_queue_len(&ring->queue)) >= 4) {
 			rtl_dbg(rtlpriv, COMP_ERR, DBG_DMESG,
 				"more desc left, wake skb_queue@%d, ring->idx = %d, skb_queue_len = 0x%x\n",
 				prio, ring->idx,
-- 
2.48.1


