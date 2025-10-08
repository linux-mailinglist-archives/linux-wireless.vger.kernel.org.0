Return-Path: <linux-wireless+bounces-27871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FCBBC3584
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 06:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3C63E2D35
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 04:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D9828D830;
	Wed,  8 Oct 2025 04:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="wpAaw/DL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DDA34BA3C
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 04:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898945; cv=none; b=DQ/n0T7ldlvRNJWkwA92y/5l9Om3ff1AxIzOW8NvMi5+vewJYwf0KW/KKpkMiAJpH6O0pvtrvTs0SRavNqPC2PTyxcmjNojxqdb5GO7gesnszE5Yv0tkiHJjmSOJwDfdOXkU/MSrQMiA+u751BnP/z92NARHvZC5KguUq9IvozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898945; c=relaxed/simple;
	bh=nRjtg9ocg48+BDqOAeVBE2djk6MSHP+WiKpGbHd7UY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZPss6p5v6S30i3Hk1cSpOb6GfLPUQgdacaiKIajnv+pW1uLzApwwL+q3qJzUl4OZGQWJ+MqvFOK/tOlkYCTpAXbjQaPVosoU4xr6TfCEKfqEriZzNtOg4k2Rycx6T7ATX+KrraFSdtuHVQCGBm+zENoyfM7u2P2TKZcMZz9zU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=wpAaw/DL; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32edcc68e0fso1281262a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 21:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1759898942; x=1760503742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv7slNn1an32Vh96lSNOwuLdLd7RKPpa3pUig/+Q/jE=;
        b=wpAaw/DLOtgj3k1LIR2+yc4X+Abo022VlsKULn+IfplBY1Pwo8w8ONUmxNmkuai0a/
         KNkQLlEP3I6lgBpUj8JCYuoaRkdnQ74F919g/0POVxZ5FbthN9tABIHTLta0riA2UP9Z
         dlokfIVJGqkmzJz5DEJFe5TewT7Zv/Oo2SUX/bbRBduYn5dvtLcTf60oy7ByH+iJwuqx
         xEh7jjnF+jpNsuYnH+zRpbd0ljXfhyj8CxeSKn3KEYsEGtW44tSmE56qr9NzeQYHbtEi
         Sr2eCg5AdoD0Az2QhWAO2iYm0CgnnHha7DKkE5PV8zmNHfuYeprF7FjnbS7Fm+4KA1pU
         ssrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759898942; x=1760503742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bv7slNn1an32Vh96lSNOwuLdLd7RKPpa3pUig/+Q/jE=;
        b=p4QFpX/H2nLHdylGShvID2ns3VDSHkkvZuFUFm3Pr0SCbnGo3fzybNNj33HLM7Y1Sk
         C8qkLGaPGEYX5lSekQ1mCySOApXrGFdpvGGxnunAO19qEdZ0mOTZAHs0wlpKWRDR4hrH
         UMsxI7+O8DfNCRkuGFOzArM/dciGjyzFxyQ3pmF8zhdytnFTc8uC8NnQLdxY3GjHGhBX
         mNXlAKe+p5in8Kx7r9KCDqC/4mapw8jO+U0jvgkKgR2iC+1Q4JH4UfcM6tqYgmWPeQX6
         jEmUFnsrQM0Ype9w8zzNQruCEKYYZqF6GAX/vARrBtw15Jg/+1sKDfKL+LeNXVIBZQcp
         Mr8Q==
X-Gm-Message-State: AOJu0Yzs/hZTgA3/XviKDETR+6l0InzDl6J11I1GYbihz9mhfrwplu7z
	HymnIgDF48V0ajNZ1tGW9MTk6Qvb+Pwc3M2egzTsPB+GW+slqn60tBR8Mjy5BIsxbvcMwQLBXv2
	IQu1MdvQ=
X-Gm-Gg: ASbGnct57/SALz0QbblAmzk8mscqqRl5YMYSmP75Wrulsex1NLxIaKcbByoUAuNbrvW
	tzksJ6V/IqZwkGnDG72+c3UAVUcScg1ADbjTUq5rxRtRSWp4VhLcuQefGzp1JYIFmCverGiyl0N
	x4la2cRN9BiA2tYA2nE6HlXlSRVLNO6GZT20PCyLpl4oFIIrX9/yw08nw0Dflwm6F9Yhl+lXUKj
	hszUJvKfSIwFWCbBPEGdF6Var4KdVjyhGvA6PBGaDO/jgIpE5Ijy8IzGWt6//To8Evf57Sst2hi
	0vcsIQsQGR/Wlp5JNkS8XDvaeSTdpduDVEI8Z8+8i1NXJEEM2bHyfp0x67/kbfGmxfNss/J+H4n
	qLkyKuL3MGZpWInX7FYg2V5xdXb2UEkXb0mSf1I+e7y5s1+hr2qgZrYS+j67LWmNzlGGDFw7C76
	LT6W0ilatPoS02Ufo5HgsQSKkweNjyjrxqPiCA+jjU3Q==
X-Google-Smtp-Source: AGHT+IHBjQTrwzQ65yjY4G3iP+neHDL7NyqY8EmCMVQ7NItJb21zbLajgsXNDaHjw7WHJAZESoNllA==
X-Received: by 2002:a05:6a21:6e03:b0:2dd:5de9:5370 with SMTP id adf61e73a8af0-32da8425ff0mr1435537637.5.1759898942241;
        Tue, 07 Oct 2025 21:49:02 -0700 (PDT)
Received: from localhost.localdomain (63.56.70.115.static.exetel.com.au. [115.70.56.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62e3508744sm13308036a12.30.2025.10.07.21.49.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Oct 2025 21:49:01 -0700 (PDT)
From: Wonseok Kim <wonseok.kim@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Wonseok Kim <wonseok.kim@morsemicro.com>
Subject: [PATCH] iw: connect: Add support for WPA3 SAE association
Date: Wed,  8 Oct 2025 15:48:47 +1100
Message-ID: <20251008044847.16966-1-wonseok.kim@morsemicro.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the driver advertises NL80211_EXT_FEATURE_SAE_OFFLOAD, pass the
SAE password and let it handle SAE.

Added extra auth and key option to connect since SAE requires a separate
AUTHTYPE and a password instead of pre-shared keys.

Signed-off-by: Wonseok Kim <wonseok.kim@morsemicro.com>
---
 connect.c |  8 ++++++++
 util.c    | 28 ++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index 33e1a5f..14a8a7b 100644
--- a/connect.c
+++ b/connect.c
@@ -63,6 +63,10 @@ static int iw_conn(struct nl80211_state *state,
 			NLA_PUT_U32(msg, NL80211_ATTR_AUTH_TYPE,
 			    NL80211_AUTHTYPE_SHARED_KEY);
 			need_key = true;
+		} else if (strcmp(argv[0], "sae") == 0) {
+			NLA_PUT_U32(msg, NL80211_ATTR_AUTH_TYPE,
+			    NL80211_AUTHTYPE_SAE);
+			need_key = true;
 		} else {
 			return 1;
 		}
@@ -229,6 +233,10 @@ static int iw_auth(struct nl80211_state *state,
 		NLA_PUT_U32(msg, NL80211_ATTR_AUTH_TYPE,
 			    NL80211_AUTHTYPE_SHARED_KEY);
 		need_key = true;
+	} else if (strcmp(argv[0], "sae") == 0) {
+		NLA_PUT_U32(msg, NL80211_ATTR_AUTH_TYPE,
+			    NL80211_AUTHTYPE_SAE);
+		need_key = true;
 	} else {
 		return 1;
 	}
diff --git a/util.c b/util.c
index 36c1185..5b314cf 100644
--- a/util.c
+++ b/util.c
@@ -285,6 +285,9 @@ static int parse_akm_suite(const char *cipher_str)
 		return 0x000FAC03;
 	if (!strcmp(cipher_str, "PSK/SHA-256"))
 		return 0x000FAC06;
+	if (!strcmp(cipher_str, "SAE"))
+		return 0x000FAC08;
+
 	return -EINVAL;
 }
 
@@ -373,6 +376,25 @@ int parse_keys(struct nl_msg *msg, char **argv[], int *argc)
 		return 0;
 	}
 
+	if (!memcmp(&arg[pos], "sae_pwd", 7)) {
+		pos += 7;
+		if (arg[pos] != ':')
+			goto explain;
+		pos++;
+
+		NLA_PUT_U32(msg, NL80211_ATTR_WPA_VERSIONS, NL80211_WPA_VERSION_3);
+		NLA_PUT(msg, NL80211_ATTR_SAE_PASSWORD, strlen(&arg[pos]), &arg[pos]);
+		NLA_PUT_U32(msg, NL80211_ATTR_AUTH_TYPE, NL80211_AUTHTYPE_SAE);
+		NLA_PUT_U32(msg, NL80211_ATTR_AKM_SUITES, parse_akm_suite("SAE"));
+		NLA_PUT_U32(msg, NL80211_ATTR_CIPHER_SUITE_GROUP, parse_cipher_suite("CCMP"));
+		NLA_PUT_U32(msg, NL80211_ATTR_CIPHER_SUITES_PAIRWISE, parse_cipher_suite("CCMP"));
+
+		*argv += 1;
+		*argc -= 1;
+
+		return 0;
+	}
+
 	NLA_PUT_FLAG(msg, NL80211_ATTR_PRIVACY);
 
 	keys = nla_nest_start(msg, NL80211_ATTR_KEYS);
@@ -453,10 +475,12 @@ int parse_keys(struct nl_msg *msg, char **argv[], int *argc)
 			"           or 10 or 26 hex digits\n"
 			"for example: d:2:6162636465 is the same as d:2:abcde\n"
 			"or psk:data <AKM Suite> <pairwise CIPHER> <groupwise CIPHER> where\n"
-			"  'data' is the PSK (output of wpa_passphrase and the CIPHER can be CCMP or GCMP\n"
+			"  'data' is the PSK (output of wpa_passphrase and the CIPHER can be CCMP or GCMP)\n"
 			"for example: psk:0123456789abcdef PSK CCMP CCMP\n"
 			"The allowed AKM suites are PSK, FT/PSK, PSK/SHA-256\n"
-			"The allowed Cipher suites are TKIP, CCMP, GCMP, GCMP-256, CCMP-256\n");
+			"The allowed Cipher suites are TKIP, CCMP, GCMP, GCMP-256, CCMP-256\n"
+			"or sae_pwd:data where 'data' is the password\n"
+			"for example: sae_pwd:foobar\n");
 	return 2;
 }
 
-- 
2.51.0


