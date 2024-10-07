Return-Path: <linux-wireless+bounces-13654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048FE993A18
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 00:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91841F246F5
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 22:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B06218DF91;
	Mon,  7 Oct 2024 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+VdnDnU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70C018CC13;
	Mon,  7 Oct 2024 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728339798; cv=none; b=W6IbCMQzgDWhjGralflWfiZPEaMHUNcjvtyeV0TDqRi29CUO/RJOpGOckR9xoNTI0ZbxYV7Ic3krrHXbbAyT3mOu8Cm0ItJCdewU7PC3QqyUsERVGfQUvrpCTES4YEMBcOj19Vy2QZJEceRqkjLGkcANkcmVKdxcJ0LVrp3wWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728339798; c=relaxed/simple;
	bh=GMVUL1ph8tnsy7CfmMDTaKhyBTk9+UJc375Sc3WAe04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/hkiMnLDTBDZakvCF+wH3q+wCSSA7mZ5mwcXOOV9YklyCrSK0McAW4D1Cr9wRqCGXvGTlsa/5uKn9kF5lB1v+3/cl9ow081T5u9Z8181V78640JIVTeqAEQm6DFnEIcgJsqIzf6a/ZOhCo8EZjDc5c5jHbwiGowdLL+um9z6t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+VdnDnU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cc84c12c2so2648745f8f.3;
        Mon, 07 Oct 2024 15:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728339795; x=1728944595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcVTSVWTpad1n8YXrLoQ7ztmwpyIAW3B5vIodWxq0OE=;
        b=k+VdnDnUEWp5NDfcxHVkL6BgFdaMjtVSG46V+SffNRE+32D8tQtHZP8LHcExyZ7BcI
         XhQw9YapEbLB9mpdCeJ9vpVZ/o4AKchp4w9MI5MsXrvIH8pCHrKwkJItWj9Y9EO+Alox
         vbdehEZkvj7DVNRCQKgrugpYJytQFSnt+2ZS1vio9+eAXBvk8FK/aKNLqhtZy+YUfnW4
         oBPSXKhj3wd+cSNt9hcdwUQ9d5WN+leB8Uc1Jk/uIkC2Ja0g0fAo7zNyxEoxqysocNSx
         ykiRCFjy1qe/+FZ44+hzI2m7k2DjVNtiGMaEwRKmL/VbO9p2pqLZqP6q9E35//3xwzsF
         k58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728339795; x=1728944595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcVTSVWTpad1n8YXrLoQ7ztmwpyIAW3B5vIodWxq0OE=;
        b=mmoczg8yUq4xXBtRoM5v4cnK+p4QjVQDrksf6cUA2oj0BEB5jWi9u0jv3ZwX6ZYwkT
         2vHkcLfev8qd0XFzCXkpGEuBkAXbXvoONkWUwNKPi3Bi67TLEeZq73eLkY+tVSSgkz8k
         DknsJvziNfahkDYtL3LI/58cYRIWvBuo+nzczaZWbhvcskam1LVXUMKBeJXtpENF/fsc
         cSJYoT3zx8bPdz/SeVQ+XTQcHIONcu/XWv+qkqTXhk5xokHONxxMEikccxQGrMYYEw3j
         aJw5oktJ6gZ7piQ+MO3r8mxomP+yUOeJgO2kw3MvLCSoiMpYtcN3Ne5eNnnXol8H1dSi
         loVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9KqL0PcKmspknWXwG2Ks/5pZSbNeHH2iYwc16TKGWtkKG5y74AxjgeMc3GLUpdU7jW7tXG/NGpotdWwFlh7I=@vger.kernel.org, AJvYcCXKGMTHawEVtR4INxRppM2oD6qQUaJChny0y0R1myPEpk5LnAXekexW6iJZDPmREAXPSdTgYFo2ue1VrylX@vger.kernel.org
X-Gm-Message-State: AOJu0YySxf9RZ+U9KN74fgguUsABr1WLK6HMzyJcfB8l05SnDb99aey6
	5d2FV8Q3AGW8gJh9JRbf31DLog92fapInW0nESToAs1WVdnu4zLK0+iDhQ==
X-Google-Smtp-Source: AGHT+IHdnrhj/GDV7fld+3pebc4uNX4BY/OkB9M7WkZRA82JeynkKX1zpY/oF1cbl7mtSmr0nVr1IQ==
X-Received: by 2002:a05:6000:4008:b0:371:8688:1660 with SMTP id ffacd0b85a97d-37d0e8f730fmr8517987f8f.51.1728339794708;
        Mon, 07 Oct 2024 15:23:14 -0700 (PDT)
Received: from ALPER-PC.koi-vector.ts.net ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f3b1sm6545857f8f.14.2024.10.07.15.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:23:13 -0700 (PDT)
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
Subject: [PATCH v2 1/2] wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_config_scan()
Date: Tue,  8 Oct 2024 01:20:54 +0300
Message-ID: <20241007222301.24154-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace one-element array with a flexible-array member in `struct
mwifiex_ie_types_wildcard_ssid_params` to fix the following warning
on a MT8173 Chromebook (mt8173-elm-hana):

[  356.775250] ------------[ cut here ]------------
[  356.784543] memcpy: detected field-spanning write (size 6) of single field "wildcard_ssid_tlv->ssid" at drivers/net/wireless/marvell/mwifiex/scan.c:904 (size 1)
[  356.813403] WARNING: CPU: 3 PID: 742 at drivers/net/wireless/marvell/mwifiex/scan.c:904 mwifiex_scan_networks+0x4fc/0xf28 [mwifiex]

The "(size 6)" above is exactly the length of the SSID of the network
this device was connected to. The source of the warning looks like:

    ssid_len = user_scan_in->ssid_list[i].ssid_len;
    [...]
    memcpy(wildcard_ssid_tlv->ssid,
           user_scan_in->ssid_list[i].ssid, ssid_len);

There is a #define WILDCARD_SSID_TLV_MAX_SIZE that uses sizeof() on this
struct, but it already didn't account for the size of the one-element
array, so it doesn't need to be changed.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v2:
- Drop unnecessary +1 from scan.c #define WILDCARD_SSID_TLV_MAX_SIZE

v1: https://lore.kernel.org/lkml/20240917150938.843879-1-alpernebiyasak@gmail.com/

 drivers/net/wireless/marvell/mwifiex/fw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index d03129d5d24e..4a96281792cc 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -875,7 +875,7 @@ struct mwifiex_ietypes_chanstats {
 struct mwifiex_ie_types_wildcard_ssid_params {
 	struct mwifiex_ie_types_header header;
 	u8 max_ssid_length;
-	u8 ssid[1];
+	u8 ssid[];
 } __packed;
 
 #define TSF_DATA_SIZE            8

base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
-- 
2.45.2


