Return-Path: <linux-wireless+bounces-13655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7EB993A1A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 00:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047F71C23F10
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 22:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F3F191F91;
	Mon,  7 Oct 2024 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayunz/gp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24CC18FDC9;
	Mon,  7 Oct 2024 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728339801; cv=none; b=j7kGBo9EPnmzFMappOPHX/eoKoFecVF1O+fuQtHBm863f2/8L1Jp0h+BqeDR6UBB6kSR4ZH/Xz+0+uMFXhcO7ae5MWPLJBvXGuvFHBz1dvJNoeZtqa1wjR91wgx5POo1Yi+KJjH2EvCv/xx1K06DYX8AfzZYRsT9NuC+IcKpcVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728339801; c=relaxed/simple;
	bh=1xwCQjw7OIJYwBx+Ll76469/2xlTnNv83u+vEUHeLE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tT9ZDSi1yQUpOfz0EVcac2xMJCEIIyi6Ujbr31SEriZ0LtQs4IXnANwjoP2rRnfsvCw3yxjL55tFOgE5vwsvSleiC9cCaXfWi2+90odJyQmVman6wfkFHpwTqe9CtG/+2rT5/rVcc46rQviCse6AbzrA11AkKx7yzpB7hKyL1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayunz/gp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ccd81de57so3306280f8f.0;
        Mon, 07 Oct 2024 15:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728339798; x=1728944598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNPNpp0MeAYNrngJnQDd8W/cQ07lWgfLVB+09bhq70A=;
        b=ayunz/gp25apHU/r9GIxv8ewBmSpd6/ydDVKPZJWs2zV3ITvh8563ybdkK5YPvRKE8
         yKwWhAF9g72RuqlOgxUQTJJmOCGpIVQ6JNeGZLy3VjJsUoayY9SLDG0rwSBKyG87NQmL
         2sP8lWM1v1bxfzABl+1KLN0XZIbhlJkFZt5dFGC+e1/QS0pMPA/OHpp8E43glekePcCB
         AkHHB6aS/pCFxgvRAHX+cVL3tTrhc3UJfwKTX3jolwfsM+RW5q2wDX/0IEV1+wBmJFXp
         PML2+MtTZg/b8AQxEQzUCOaTPdbGG4YkbbJ43uS1ZplGGhTzEv8AqZs5dZ/xmTTpIgj4
         5rWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728339798; x=1728944598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNPNpp0MeAYNrngJnQDd8W/cQ07lWgfLVB+09bhq70A=;
        b=IsXt10J52xtUqem0027KgKc9/gbNyLK7o/XLvrJn48ti8FkUJi8M7PZ68Eldti1hi/
         xQCYphHqVA89SW7bstaQv3eoiUOAIOYwb4ZDD2pe5GNV22av0UONmZt5NxYhIw3qdcRO
         NCLTlv6+LCMVEFNwLkjmx/BzHZA72YgbwXsrmXpXjFlljw6U9HfDYipy7Clweiri4/gd
         pW2eDPmkDhprC6SBw1BhdYllhqzip5Fvo1bePrlS13z2ePGXyyJBz0MRJJCYzoiXmBVQ
         o3ZsouKeLef7rpko+8hzg0DIr4/EYWwzfPqcAtjC0Ar3nYApGUgf/fHeDsp1Svy1m9x8
         QGtA==
X-Forwarded-Encrypted: i=1; AJvYcCWEI0ODwEWvJ9vzYprVD5LgyQ88ywGX9CQWCslfqXGbYyEK7TIN17Pzc6I3I0HpqopUoARFf1pu97Hnsyfv@vger.kernel.org, AJvYcCXaznV+9lbrPNKMGxy/upKV6G8FcDsMacBeXI/akzbm3XO7nD4jLhXpWUhxVANK7kuZCSdrso2OnrRb//RAZLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytpiuC1CRY4Agd/dhJovTfLuyFhIBX3Yh2+7RAB/lIdNkBhfuV
	FahuYcL7vRw4nSjhGT1ojSLyaGqU6AICmniMMQ3KC8S2BCFryErTz0K+bA==
X-Google-Smtp-Source: AGHT+IHIj9TkpZy8HCYg3j0VAxoa8KY9XxdoduFtTNQxvWoBWr6/f4R1GJ94Lah6EOpK/nHxcrQaYA==
X-Received: by 2002:a5d:4567:0:b0:37c:fbb7:5082 with SMTP id ffacd0b85a97d-37d29315e90mr544928f8f.25.1728339798139;
        Mon, 07 Oct 2024 15:23:18 -0700 (PDT)
Received: from ALPER-PC.koi-vector.ts.net ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f3b1sm6545857f8f.14.2024.10.07.15.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:23:17 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Kees Cook <kees@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Brian Norris <briannorris@chromium.org>,
	David Lin <yu-hao.lin@nxp.com>,
	linux-hardening@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 2/2] wifi: mwifiex: Annotate mwifiex_ie_types_wildcard_ssid_params with __counted_by()
Date: Tue,  8 Oct 2024 01:20:55 +0300
Message-ID: <20241007222301.24154-2-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007222301.24154-1-alpernebiyasak@gmail.com>
References: <20241007222301.24154-1-alpernebiyasak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
`ssid` to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
I've mimicked the commit messages from `git log -S"__counted_by("`.
Since they refer to UBSAN I tried testing with CONFIG_KASAN (w/
kasan_multi_shot), CONFIG_UBSAN and CONFIG_FORTIFY_SOURCE. I do not
get any errors relating to this module with those options, but have
others -- I even had to test on another board altogether.

This attribute was suggested in reviews, I don't fully understand it,
but I am not sure it is correct in the context of this comment from
scan.c (with irrelelvant parts omitted):

    ssid_len = user_scan_in->ssid_list[i].ssid_len;

    wildcard_ssid_tlv =
            (struct mwifiex_ie_types_wildcard_ssid_params *)
            tlv_pos;

    /*
     * max_ssid_length = 0 tells firmware to perform
     * specific scan for the SSID filled, whereas
     * max_ssid_length = IEEE80211_MAX_SSID_LEN is for
     * wildcard scan.
     */
    if (ssid_len)
            wildcard_ssid_tlv->max_ssid_length = 0;
    else
            wildcard_ssid_tlv->max_ssid_length =
                                    IEEE80211_MAX_SSID_LEN;

    memcpy(wildcard_ssid_tlv->ssid,
           user_scan_in->ssid_list[i].ssid, ssid_len);

I expect we want to use __counted_by(ssid_len) instead, but do not have
it in the struct. And max_ssid_length = 0 when ssid[] is non-empty, so
is it really appropriate as the __counted_by()? But then again, I
couldn't get this to produce a warning.

Changes in v2:
- Add patch to annotate ssid field with __counted_by(max_ssid_length)

 drivers/net/wireless/marvell/mwifiex/fw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 4a96281792cc..e4e35ba35454 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -875,7 +875,7 @@ struct mwifiex_ietypes_chanstats {
 struct mwifiex_ie_types_wildcard_ssid_params {
 	struct mwifiex_ie_types_header header;
 	u8 max_ssid_length;
-	u8 ssid[];
+	u8 ssid[] __counted_by(max_ssid_length);
 } __packed;
 
 #define TSF_DATA_SIZE            8
-- 
2.45.2


