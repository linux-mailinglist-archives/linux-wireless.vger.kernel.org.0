Return-Path: <linux-wireless+bounces-28937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59FFC5A672
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 23:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09A13A918A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74F0326956;
	Thu, 13 Nov 2025 22:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIeJy+Ex"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401632693C
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074496; cv=none; b=lwUn0t69pssfH5rFLtPUyUrfBpg0JR16EzHJjTBwwC933z0iWI2meAyyaeaPIxuD60Sv1yIo3ORYBgcV+fOepDQTelf+drVe1ZboJzBwCea0jCzsZ4M/9FA+2/QYxfmvR0UjyYbExqdvBkAwdIWBqqyetfIKGXPmHMcAjdgaJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074496; c=relaxed/simple;
	bh=DjN8K1wx5tQZHx8Wy/TR3fuAPpG6Vu54rioTnoCLUZU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=u1A7Alk9aK9vSg521NMiIR2V02sIIhqXUCJc3P7RqJDudGi4j90wAflhU8gZOYN6/9Kt6dgLxE86uMRQPt1rVfFuo4Hu/W/rY9Z+TDlFzISqXn5ZTIEId2w8d/TfKINRNyEZ+V68MZgOpupecSicDwMoos8NgY4oRGSr151YqO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIeJy+Ex; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so2195520a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 14:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763074493; x=1763679293; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T//UGuvmvCbwdLU46t1xISLsiWvt9cjFT8n16PNrk7U=;
        b=FIeJy+ExRXet83gCWT08KwKfJETAW9/TI2caumQJHM1WwiJB27QkGd24Zd/rxF4mLO
         7GAfA9voAGJSn6Ta3T5kTJRDFnOEVluFZHB/TurdHq0S3s5ATaHFEe8qspmWadIMZ/cn
         KiX6xzTnzX1bUrUYSr/m3JI/k5hht2zV86+1ShoP1eO9Db1TtQ8i4ECKaGfZ3DaB0oFo
         XpEbLgZzYHMjjrIVQv5y7Q/dlZ67Umx2XN0M0oxG93+zOZWDMcsufQVz/Mt7bOARNFMQ
         OE2PBhqwli+KQeQSnir+nirjxl+z2RldOuVvCVYcFmcyh62jD6d7dB6xZvaxxDuT/uYz
         A7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763074493; x=1763679293;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T//UGuvmvCbwdLU46t1xISLsiWvt9cjFT8n16PNrk7U=;
        b=i1loPVTq7LRgs6rP20+0hAqVj347qBvwxabfj4TOm10P+tzTfSXK1/VJtJIi9Ep60C
         mhHYBy8rvNLP7E53Ryi4leXaYuDZB6VLUT+JDF+ho/kpmQH2vQE7rHn1H/QuUGeYCFlk
         r2ejg4KL1ScgdOb7leUoOxo8p3XMt2bAG4x5HdOX14fURxgCPvmwmHvzX4LhwKzPQC2j
         kGvf8bJTzQndwK2OfJZ0Qax9JQZ8eIlTxg89NH5Gfm0IYg5pwiMWrtc2FhE29tNcz80J
         jxN8Oj74Rm/P9A16QxrsS/DULqyPz1NzZK39FdZZCeD7Q/Q/GJAl9abzyQ5Df/mORwOq
         JjOw==
X-Gm-Message-State: AOJu0YyYnnZU1KwXzqAfxYVtkFQJyhw9y1aPOQfGMpCWx1H79maXK944
	2bxSZA+l6LLr25so5lbfx2jmsQlnoqtYWsQBDRtDEqXckA9Y1Ol2nNPbjUkneQ==
X-Gm-Gg: ASbGnct2T43h9BpdvkAliPmHRLLI+L2oJfckyONEcANCHZqxn35HBYWTESwhJ1jii8h
	LulwSjkKLzv3tb39lBKRqylaQNmB6bMt0PdxLQNPLUCr0gYOcMk0XS3hiSds9wC+gwCczJRfQ8O
	bMx39MgqHCpK8OSPbabB70QDmPdA+BAPcjozLSRs+easnPytC9W4oKLbTahp9D6d1ZPkrT4ppE5
	NRvVBCtsNP1TfRTN+6lkbs/Trw3THvjBZ+4yNVcWdP8Kn1yLg4PN8esbe7HSNcutK32NY/XmcPZ
	pNp1nYUoiVvAQqgYZio6pNTvVvz2e3btifi4TL451i9qyfrgRWPqB27Nxa/5pXdX9NOajRKG0iH
	ye9jVhAKHRbaBIyKh3M4DFFRsVPAyNdT5pW/KSWManGolnkyrwgS2BP2+I3sPdNL1F8mMzc4wdr
	0bNx3hNZ1D
X-Google-Smtp-Source: AGHT+IHbHFSYJ7MjayGMYcuw6bAdo/xh3fK07UVW7B2bjvPhxcIHA66RfKBlqivWMvT75c9DLRgBhA==
X-Received: by 2002:a05:6402:2792:b0:643:129f:9d8e with SMTP id 4fb4d7f45d1cf-64350e0468bmr873742a12.8.1763074493328;
        Thu, 13 Nov 2025 14:54:53 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4cbd18sm2310413a12.35.2025.11.13.14.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 14:54:52 -0800 (PST)
Message-ID: <c1e61744-8db4-4646-867f-241b47d30386@gmail.com>
Date: Fri, 14 Nov 2025 00:54:48 +0200
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
Subject: [PATCH rtw] wifi: rtw89: hw_scan: Don't let the operating channel be
 last
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Scanning can be offloaded to the firmware. To that end, the driver
prepares a list of channels to scan, including periodic visits back to
the operating channel, and sends the list to the firmware.

When the channel list is too long to fit in a single H2C message, the
driver splits the list, sends the first part, and tells the firmware to
scan. When the scan is complete, the driver sends the next part of the
list and tells the firmware to scan.

When the last channel that fit in the H2C message is the operating
channel something seems to go wrong in the firmware. It will
acknowledge receiving the list of channels but apparently it will not
do anything more. The AP can't be pinged anymore. The driver still
receives beacons, though.

One way to avoid this is to split the list of channels before the
operating channel.

Affected devices:

* RTL8851BU with firmware 0.29.41.3
* RTL8832BU with firmware 0.29.29.8
* RTL8852BU with firmware 0.29.29.8

https://lore.kernel.org/linux-wireless/0abbda91-c5c2-4007-84c8-215679e652e1@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
I didn't think a workaround would be needed in the kernel but 6.18
will be out soon and people still have this problem.
---
 drivers/net/wireless/realtek/rtw89/fw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 96f0463e66d6..c35317abc7f5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7709,6 +7709,13 @@ int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 	INIT_LIST_HEAD(&list);
 
 	list_for_each_entry_safe(ch_info, tmp, &scan_info->chan_list, list) {
+		/* The operating channel (tx_null == true) should
+		 * not be last in the list, to avoid breaking
+		 * RTL8851BU and RTL8832BU.
+		 */
+		if (list_len + 1 == RTW89_SCAN_LIST_LIMIT_AX && ch_info->tx_null)
+			break;
+
 		list_move_tail(&ch_info->list, &list);
 
 		list_len++;
-- 
2.51.1


