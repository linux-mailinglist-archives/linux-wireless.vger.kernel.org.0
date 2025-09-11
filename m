Return-Path: <linux-wireless+bounces-27249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB8BB53EB8
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 00:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD1D5A681A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 22:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF1F2EC096;
	Thu, 11 Sep 2025 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TePLdTuG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A71EA7DD
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757630002; cv=none; b=LqJClnww8APkXrICxUaXNw+ie3jr5XWei38AV/qVP+40cNURb9b+anrC/uwP61OW6VVrf8gHKvQfQJvvoSd6DNHGqzu0ylr3yx0lhgqamnXo5jEg5sVk8cqXvCbW4LGStxQy5BoZBqZXNtXUUeZ2LORUZJjH5/Zzq6047cTG7OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757630002; c=relaxed/simple;
	bh=tfwVIX/6aF8q+dXSD+qNcn/V3k9oPkh8n78oVHGeNbU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KgkIrR3XrRTM6+3pSqkzDz2AQxqTBKsMzJhoV7/qHQLTAxvLujQoH3eetFs3I9ZzUzdsptFPuyobggTdPKVgmqWacBdjxrCZa7px58+1BGYKS17Bj/j7xyX/F1Us1QQylOei0x4t1bUzUbgtqLKGBzcVTeCpns+y6f2bauleItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TePLdTuG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b490287648so20709061cf.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757629997; x=1758234797; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O9RiA6yXEHDHT8h+ndmxEz5Ynac297GR1p7HFDs94Z0=;
        b=TePLdTuGEshyYmddTAszPfWzqDPyxccgfD32gSteopy+nYUsc+Cl4SRSgo+PzLiaxV
         h2Pjl7/Ofhdo/4AMtV5WH2EfX/Sdk2N0EEeCUXkplRw0HP+rUfErGTXckvtcW3WaPCal
         za2bsu5x00/6dgHQjkSnesL+Pc3UqW/TtJvN/CpGqYLPU9J9nqQVSWzaXKt3MjPi9Q9Y
         j31TGNZ/3WdKnGgKALldPjRhmIHOTRL230ZZIxUD1e/n0LyOpNdi28ZwJWAg4sanzOnx
         zATNaqdjho75dgYt1suTBFB+84aRdsSIA+od276gxyOfgYKvopgRfwa1gcY4CK6hFnHW
         YTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757629997; x=1758234797;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9RiA6yXEHDHT8h+ndmxEz5Ynac297GR1p7HFDs94Z0=;
        b=CGN9o6MAPIqWC9UIbTj8dZgDxev2PnHBSC3/N49HHavbnZLzzBpQ1sHx3glRK+O9xl
         kpm0JMGdTWnrcUIP9XQYqU0eyvrQM48CU67cd7JNF0wOagYgV4Fy62SqWApbtwNmuFT4
         TTMNn/OR8i64cs3VcebBTexMagE35i1h9rxj5HKelARAKDrQgEbQZSvL4i+ILFAICbTL
         s38NgkJCxdfKt+PimA6hRzprXv5JFfrZQ39DVwx2tIvecSKLHf2CC0u6x79RbijvRHMn
         eSgI3RIW0hrR2URtbpcv7qGv+fc+iQfdatTOUGc6aQII/O86sLLWXfP4ifSxwQzJS/1d
         tEVg==
X-Forwarded-Encrypted: i=1; AJvYcCXnAJfWSReu29vIkF3KvmvdVagNbfbHA45cvmN6NabYNnyrabYmEqD8VsGyg3vbyNMcKzHjRFEMY7mzrK8TZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJ08z0NUBdySBWDtzYVLS2iLEij4ppeuUvrMlStFk16hEy8PK
	13PBbUFRkNeONKYmgD77mRhHbbuFLF4FTkOtonyxWwnI+te+QJ1ZfV1+a0CDEPcVyELzGhzwcL5
	i7an79Ec4Gs/vKTrRvcuZEXdL9ExOq36SoSY=
X-Gm-Gg: ASbGncvZBl0fzkimJAabfeR9MaLJoDM1+TG/wCo4HPch4D/20NAe6o53GuFLqU6W8gb
	KUeqX+LEhUYmapCS0DMNVafaIirKBDGfybWEuVBDxzX9lHHdMe55wzKUypsSiuHaf4uGlBLh6CW
	6Wg3hvjnXMQmA3xaTY3+yI1txX07P58TA0JDK7rl22e6rMefkefznJdmGHx0uM7COkpacYpbE5o
	EECbsC4ECEmB9e4QIb/hlYiTJcg4jP1sPoC/Q==
X-Google-Smtp-Source: AGHT+IEnrDVO4+lV8w6iWfIZCxXDIuclhgzZoIttDg43rhxpZYOb0colikAb9y8fqVSyqkYQMbfLyxBIW6oIo8EZuZg=
X-Received: by 2002:ac8:5882:0:b0:4b6:33e6:bc04 with SMTP id
 d75a77b69052e-4b77d05a075mr10977771cf.60.1757629997478; Thu, 11 Sep 2025
 15:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nick <morrownr@gmail.com>
Date: Thu, 11 Sep 2025 17:32:51 -0500
X-Gm-Features: Ac12FXygJeDcVZEzEZ6tNZ2GzztUR_Iy_WRSM8Yz3VrsyLOEDAY53SZuAkdFCf4
Message-ID: <CAFktD2fBPP_RQQ6OpL6NZy8rqn9jF=BCGOSiEMQNtw5c6MzwPg@mail.gmail.com>
Subject: [PATCH wireless-next] wifi: mt76: mt7921u: Add VID/PID for Netgear A7500
To: Autumn Dececco <autumndececco@gmail.com>, Felix Fietkau <nbd@nbd.name>, 
	linux-wireless <linux-wireless@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add VID/PID 0846/9065 for Netgear A7500.

Reported-by: Autumn Dececco <autumndececco@gmail.com>
Tested-by: Autumn Dececco <autumndececco@gmail.com>
Signed-off-by: Nick Morrow <morrownr@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index fe9751851ff7..100bdba32ba5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -21,6 +21,9 @@ static const struct usb_device_id mt7921u_device_table[] = {
  /* Netgear, Inc. [A8000,AXE3000] */
  { USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9060, 0xff, 0xff, 0xff),
  .driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
+ /* Netgear, Inc. A7500 */
+ { USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9065, 0xff, 0xff, 0xff),
+ .driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
  /* TP-Link TXE50UH */
  { USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0107, 0xff, 0xff, 0xff),
  .driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
-- 
2.47.3

