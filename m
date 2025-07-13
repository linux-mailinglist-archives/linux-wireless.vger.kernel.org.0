Return-Path: <linux-wireless+bounces-25342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014A9B032BD
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 21:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078EB189847C
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1F9A48;
	Sun, 13 Jul 2025 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbl0M/5D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA22E36FC
	for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752434861; cv=none; b=ODWy/CnARVKVTYCXHpX1fEehDQqHUjX/L5SBT/43Y7qPUTtfUU0QlSKN+05dNEQCXPtnCc0CS/mXpZCsB/eLz+rVhdSO79fAPW+mwJTEBM15d8zWZ3Za4B89Dkuq8DAJBRilV5pGWrFv0hURCQMtLAh5DtIsj3l4fUH1BFu0Ekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752434861; c=relaxed/simple;
	bh=wzeSWUmdoDIAzzo+jJzqpCI6MA2Ddlzo+oFhcEcQ0AI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iloiZStDBuPJCZA1PK1p5ai9s5wCXfHaYlgYpe6emg30HZISiot2zwlxS1e32QAmygpAdpLBf1iW7ufqnG00r7xIu5+zBXmOrXjaYP7PpDRfvtu+OdztfmEA/qfRiUBtjx1e4roLfZ5uzJX5nfJy28bniHiKtdnYXpmrmTEOIGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbl0M/5D; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso5805518a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 12:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752434856; x=1753039656; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LO70RIsH+WAnWizSfxBLh51Rx1BS3z9WC95syYohuXU=;
        b=Vbl0M/5D18tljJpDq9Q+Q2cgvoPW89i3So2qZ4yrj4NvbHgGWEyYRqNG1OC9YVOWxr
         YF+7kZqwtt+/5JgkAYeuL5kBzZwXvftJqi2ikzuQZ0WjJq92TDEvRSQPSjREEsqWnu2p
         FsaJ2vAx83xMxtfVIh4wk2pvUIYx2guJ1mB+9l+v8TN+OYk2zqKfhr9MW/10FuaE5Ner
         iVmpewqybAZBLE5fRLGRVgIHp7VbYZNUPtiopXdhQZX/cQHr8NifNbxv5WvQX3r62ct2
         JiTpx4uaploU83uyWjuUj4rd7UDgm9lp/mIpuC6XYmkdeKrVriQuhljFsjZvIu2FCB4U
         IofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752434856; x=1753039656;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LO70RIsH+WAnWizSfxBLh51Rx1BS3z9WC95syYohuXU=;
        b=AuLMysBtJPQ1UkhO2lhtIgKY3zfXlyucYpmkUS+UxtD56QCd1PE5onYIbCHdtzhXyt
         N8YS8HXsxZHYyEQbRnNM+79SWuWRAGIjWAj3sYj9BgtpILJl6TP8DMD7WFUErC0vhe4W
         Zsxphd/A5P/ukimPURo7pwZtwh9h+gSDzaILca2SVmnb3O+SbnWPeur3euWKNs2sGgmU
         Z4r9WBSnJQDzqgfthgw4d2AYZr+fIBydxv3qJGPoEHyu0QCgflRPCimEstczPnkbOaH1
         mdpRtvqKStt8LJTZe2HjOpg1tqPLS6CIVEdsoJcEaArGjLGIQa/lVKyIXuWGKnz++NWT
         98tg==
X-Gm-Message-State: AOJu0YwGWePm4rsjrHxC/4qYrKwe5nHMouWFAzGXLEJ/9VGPeBXZNNVd
	Cn22QubpP1XT3Dwd8R3Bm7a8dIERj5jYvQ2WdOkIrZ1BPjkENumKDxtUpmMkxQ==
X-Gm-Gg: ASbGnctnT1apI/FD+yjc2WArqqFtSpGhAfGN9YPU7b2PeSMDfS3WrqmgRmWhOPrjqwP
	v8Hb2XHYe0obgrapqJ28pgwkuIJUX2HHB1Q7zkxvIUIYbq92qjNJL5Z0zJBlEF2w1h9zCV0+Iqf
	IEwB9URMBmYK21LrI2kPSNk1pMUBzHNfhmxvRaMQ+HEaIjYcL3Nj1M4DFTCMBEvDl6/Kou/EGTD
	zP88hhy2IoQxLV9XKSWBhml8LOig8jItzhA9XgIIKON4wMIyyoqsiRacJZrROdFo1fpuzUtdphV
	7MbJqtNuqWwyp0xb4pqQeN6HkHRcBIPAKURqyPa7nAlJy1wCiaNjrz4mX/i2qCxRy5b5qVO7NoM
	Wzd+V+0ru4oPVpj7gdMWFdnHMkS9euJcK2KD1omv1
X-Google-Smtp-Source: AGHT+IHS4/kgAwC2WaUwPCgvQfKw5jve/6eUggC0cSW7SObFb4CZF4Tp1Dtu7ivCaInnHG9jhAP3IQ==
X-Received: by 2002:a17:906:7314:b0:ae0:bd48:b9c2 with SMTP id a640c23a62f3a-ae6fbe866b3mr1144505766b.21.1752434856127;
        Sun, 13 Jul 2025 12:27:36 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee4478sm707585666b.56.2025.07.13.12.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 12:27:35 -0700 (PDT)
Message-ID: <58648c09-8553-4bcc-a977-9dc9afd63780@gmail.com>
Date: Sun, 13 Jul 2025 22:27:32 +0300
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
Subject: [PATCH rtw-next] wifi: rtw88: Fix macid assigned to TDLS station
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When working in station mode, TDLS peers are assigned macid 0, even
though 0 was already assigned to the AP. This causes the connection
with the AP to stop working after the TDLS connection is torn down.

Assign the next available macid to TDLS peers, same as client stations
in AP mode.

Fixes: 902cb7b11f9a ("wifi: rtw88: assign mac_id for vif/sta and update to TX desc")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index c0103ace8239..f4a5580b75c1 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -349,7 +349,7 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	int i;
 
-	if (vif->type == NL80211_IFTYPE_STATION) {
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		si->mac_id = rtwvif->mac_id;
 	} else {
 		si->mac_id = rtw_acquire_macid(rtwdev);
@@ -386,7 +386,7 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 
 	cancel_work_sync(&si->rc_work);
 
-	if (vif->type != NL80211_IFTYPE_STATION)
+	if (vif->type != NL80211_IFTYPE_STATION || sta->tdls)
 		rtw_release_macid(rtwdev, si->mac_id);
 	if (fw_exist)
 		rtw_fw_media_status_report(rtwdev, si->mac_id, false);
-- 
2.50.0


