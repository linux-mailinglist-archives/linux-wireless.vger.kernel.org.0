Return-Path: <linux-wireless+bounces-25270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B698DB01C61
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 14:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F9A7B9093
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07628299A82;
	Fri, 11 Jul 2025 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDRihIEA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECCF21B9C1
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238208; cv=none; b=elXoctSnZcQC60cKtpcZO6SwBaE/M3HN6OSqqb+Zo3YUnVFaC39rOnon/LHXQ0SpZwDIcNf7lkOP5NBSdVheGtT/dTPI4ODFz73pj59a/3hCk2W7JA4C0xLPtFtoFoD9jnAGJTaw+luj/T2GAFWFj4RrBxJmLtxx+7ONt4FI/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238208; c=relaxed/simple;
	bh=LjSl+InVHj0qd9c5stBFNLtXXDLO6HpXz1Mw5ZKWq+M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UkFaZ9SE4zzxP8RBpk2igxbpRfiieQMOOWNw1tMVCsObHUAEQoReLML0bka5exDctwEybIS/G9cUO2LB5HTdKIy0iLKCgcVYhrq4fvB4NUBuA7dOu/Eez4Mk/mnY2XJTWinOyznrlzSnevd6/3aROEvap40Q2hVkAQaNzF9cV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDRihIEA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so3853542a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 05:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752238205; x=1752843005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1T+ViH49gmvMWJ2mo4t77xbr78YOqgZNuokfg9OMAJI=;
        b=YDRihIEAm+yBfqNUmWBArSPjpW8CHUTvL0WlsvcStmj8gMhS3tkZxP2VuBUi51s3NZ
         WIiSQLPt2eeb0hBVvKmKwHFR1+87xQ09knRraFAxukGzytcN2e5g9U8MOc7kq/V9N7Ul
         VlxqO7wRsMorsFMnMzLdIg7dqSwh3DBpKuQAjO5OHrBuV+CMVjtSgVcVZ2Mzg3m/0N9H
         u2p4GmIU10Nj+234go8TKvEmNKVdby1kZwJt8ZpEKv4RLl65yrGYUSL2I1Dj8IkhKvqh
         B2gos0jUVFhDLBOWSCoSqhElbIFss9YFIBjEyAZ/RjV6FqH6qG5IP+nNw+D6sYmZXdYr
         qLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752238205; x=1752843005;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1T+ViH49gmvMWJ2mo4t77xbr78YOqgZNuokfg9OMAJI=;
        b=dp4pWY7YkPfLQJVocyM9CJe4qrfzB2RcqkiAGTtSeOV9QmrVF7SYBhWBB95DN1KyRa
         dZAKQbnqHDunyOeOc52/AZo5AoK62dmJHHLABdwsEpKqyL+t+jWWe0XnOvkaa5OZRsQg
         NBezSqR+pdhM/h0s9fbKu5XGpXoH0tE6Z9KxDHCSbyA7oRa7WeM9YvXjBQEuM/SJo8D6
         OyOFABpdWihWp9gn3XlsUasLpLxk1ihBwlujt9UlgyPD8f5tlsjjyuysvawmyTwZ0w2s
         lSQi8JJSWJjGT6YQNlHLiRVuLHRSBVL5iLuIRq4GOpJgN1ovSWT9Hb4NIN9EcP0kLYvn
         o+1g==
X-Gm-Message-State: AOJu0Yy+8XBmITPvrLgvfissG7zDhJdJFjCTF8MLe1iWl9G5H4Css+by
	XL+GPjXvFlr0NVtl7al1FulI2Ph8Gzhh7ndFyjKsN6QPwtJCJqujLrcDLOYPjA==
X-Gm-Gg: ASbGncvkAp7SaDjRvxnflofanXSTXUKi1o2q7uDPdYaKpg+bqfrFfcAr8fOIfpIRI6Q
	vAYvNSY+fRxG+98X9ayKA/3MIlOHElMs0A68F8Ht1VT3UZz3IDTDqh8QkeMzoQbuJCk77s9IlWF
	gUzwFf7PcST7nCMMacyHsccTBxEHiYt+t13jsEv3U/vzg4+o/h+FmaP+jA+HT42MFsEOM1kbKlA
	c7uKx91D46zCN+gjq1ecjjEupJpr3dqNWFo6iHq/e10Sle62gJwUIvTA685Nb2FYAYf1a/9Z/On
	i/YTVXGIJ1XaAjaMDCt/79E8ER8U0ET1GRC7heR6tp9L8rlFuJl/NEk96ixm5qWeffYP4uHUQzU
	X9tThRF7fGw/jPPMSFevkHtUHPbBvGQ==
X-Google-Smtp-Source: AGHT+IE8Hc9RsityAALZcTJosIzccPY3pwnlfJO5iurGlqeiYaBp8mHCMeDaEdmAOhxPgJx8Tf5cPw==
X-Received: by 2002:a05:6402:1d1c:b0:609:aa85:8d6f with SMTP id 4fb4d7f45d1cf-611ecf9b234mr1674813a12.11.1752238205277;
        Fri, 11 Jul 2025 05:50:05 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611db7d59e3sm1442573a12.44.2025.07.11.05.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 05:50:04 -0700 (PDT)
Message-ID: <403f7a7f-a1dc-4bff-b456-b2c43a8031b3@gmail.com>
Date: Fri, 11 Jul 2025 15:50:02 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 2/2] wifi: rtw89: Increase polling delay in
 rtw89_fwdl_check_path_ready_* for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <73f8bdbf-ff7f-4741-a6ea-b1d9026833c3@gmail.com>
Content-Language: en-US
In-Reply-To: <73f8bdbf-ff7f-4741-a6ea-b1d9026833c3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the chip is not powered on correctly (like during driver
development) rtw89_fwdl_check_path_ready_ax() can fail.
read_poll_timeout_atomic() with a delay of 1 µs and a timeout of
400000 µs can take 50 seconds with USB because of the time it takes to
send a USB control message. The firmware upload is tried 5 times, so
in total it takes 250 seconds.

Increase the delay to 250 µs in order to reduce the time
rtw89_fwdl_check_path_ready_ax() takes from 50 seconds to less than 1
second.

Make the same change in rtw89_fwdl_check_path_ready_be() as well.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 2 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index ff4335ef4033..6878109e3f42 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6928,7 +6928,7 @@ int rtw89_fwdl_check_path_ready_ax(struct rtw89_dev *rtwdev,
 	u8 val;
 
 	return read_poll_timeout_atomic(rtw89_read8, val, val & check,
-					1, FWDL_WAIT_CNT, false,
+					250, FWDL_WAIT_CNT, false,
 					rtwdev, R_AX_WCPU_FW_CTRL);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 0078080b3999..cdb8005d2dc0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -571,7 +571,7 @@ static int rtw89_fwdl_check_path_ready_be(struct rtw89_dev *rtwdev,
 	u32 val;
 
 	return read_poll_timeout_atomic(rtw89_read32, val, val & check,
-					1, 1000000, false,
+					250, 1000000, false,
 					rtwdev, R_BE_WCPU_FW_CTRL);
 }
 
-- 
2.50.0


