Return-Path: <linux-wireless+bounces-33348-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGK1DV45uWk8vgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33348-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:22:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A84B72A8A6E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9315C30292EB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 11:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E76D372B2E;
	Tue, 17 Mar 2026 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ypy0CkCz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297B23C51D
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746522; cv=none; b=dyNf8G+bK7+Uo4hc/u4SdvYtmm7jOQNCqAJE9sP9R0PUoly5rfNr+8W8QZr5flpvAUJeva5WKJezWlAXEiE5z6tQmB0o7AFHpiWnnRq65FAPyucLjOo9oOxt4SwH1YwdJEuXCEU5E+aoJjmK2rnQo0uO/NJ+ie8g3qFAlMAOxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746522; c=relaxed/simple;
	bh=BhnuXj199oDo5IdbUsWGRos6wrmftHAlFM5AHiFR/3c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=H3SDomdLuu1tqYRmkeQXuquZmJFvczdwqLlzuyNPdgBorBGYpXOF/BCSZtHW3Po+WUn+NLny3d+E0RrYduyvaAn6gg+Pz1yvAq1OmlRQinH+WLwAAXctUVDzZrCJ4xn+xT/35m82WUtRfHuycFI1uKayeSJQc2vTDR3ks+LFAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ypy0CkCz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4327790c4e9so4071666f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746519; x=1774351319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SPbwUjqmqWzC3gU+8epOWIHsoei+/pfAMpyfVJduFjU=;
        b=Ypy0CkCz1MdzVXehek6K0cNXp0TvvL4e8SK3uydCGexuMVizk6Zrcwt3PhQT6cSuSn
         DuuXrE6eJfWXI5vIvweQT6TrKI5oALFxgOyaTvTSNnwq5u5gj9sPlXLgG9jULSFNF44Q
         FBE2X0bX2kBx7BWfCVTHKolvBiyYLTXB06BQszhY9Pp2H2Tj2nFC8vm8gIzQkBDKzmfH
         t92ZbGWUpqW9PGOs0nz4eC4bGtfRfl5bGhxec5INVWkj08rn1DFt7cUKrGz92fiNi90M
         5m+KauzafUAjKYHixz5uUdfU6zkiljd7wJMdO5Gk2+sIGosmHuhmAHW4ZRLNtCN6Hkvz
         eFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746519; x=1774351319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPbwUjqmqWzC3gU+8epOWIHsoei+/pfAMpyfVJduFjU=;
        b=Y7xQia0W2SJYDDiK0uEj1kGx1udaZM/4vGzwQ3g21fo6WCypwxoTofZ3aEX0RexNLG
         584DZ+x/OPw5Ag9Hn8DdASNGzGr6gc/GR/6MkGxeqZyIhdlYQLIABpoKToEHeaJbCfKp
         WV5/2e5MgRX/kw4ov/mQs4SbCfrdu4dmwmRHzo/QY/gFoR/MjacxXrsCNkqxMvodoL1R
         SGYsqpGh+69kocfUE5IqD8NV9j8ZoUCRELJNVwsEImO9/cCYyD15ZYHxMrGCG4aZS6fB
         T0FZ8fJOYShdGc755/S42n348fV9FlUsmPSlIDHYARMqnA1RVNhwMXOiQVXxGS7qQ2+m
         st+g==
X-Forwarded-Encrypted: i=1; AJvYcCXTiwqgMiZwvRDi4gwgQhyHw8EDqjT7JVl8gXawHpbqf0A7HpJ3vRRxZyWF4m52SCnL/SI5JoqcazXm1Pmnzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzu0QiDSBFuCMfupCMGcihedhNEnvAVtvxdy0zVd4GhUXV1ZpQ
	ysXpqZVpP3nN51IR8jtYaSb0IXu3CdShUWQ3E67nJ1wJ/cnum4Xam08P
X-Gm-Gg: ATEYQzz+uCts8/n52BsUtHZLEKGDi19loobry0vdZzJyZplS/j+TKXLFOmVn7upf6Zz
	4iwyocus0ZyzLL4FDK7yKrdv3jjLWdTXURKX+O12XGNHY9klw8chnSkVXuxT1M162Fqo57e50Vg
	UWSr2x0P7Mh1BHqyx2MjC+mW251ma0YdSlkwO8M8RyPkFz76dmIZEgkoyFy9Aze7nlHnpoI4c9n
	gio4wwYvS645x/pBpxqe2s5suCY0RbESrR1YA/gmNyq5tJErWaphjRXrbvDg8L+ueGoyWlYW/XM
	oKQPum6V73MEpVgDnepEH7XBLjV25scno2G5y47D0WKl9Z+VP4YN8SKRAEisM7W0njUCeCE0hlb
	qlJxJU8v7iAyDNN9BcmbSsgg3nGD37YVWtgm0bwmWByQZJkyen1jvCl7HRezigwzB0higFFifSV
	g0mt8HFOQh6Kfm7tPvPJWSqJNcJqJ+jSaar0b5bg==
X-Received: by 2002:a05:6000:184a:b0:43b:3f2d:7d58 with SMTP id ffacd0b85a97d-43b3f2d7fc1mr15378870f8f.52.1773746519061;
        Tue, 17 Mar 2026 04:21:59 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b46b41e93sm12858216f8f.2.2026.03.17.04.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:21:58 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: rtw89: retry efuse physical map dump on transient failure
Date: Tue, 17 Mar 2026 11:21:55 +0000
Message-ID: <20260317112155.1939569-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33348-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[realtek.com,gmail.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christianshewitt@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A84B72A8A6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the efuse
physical map dump intermittently fails with -EBUSY during probe.
The failure occurs in rtw89_dump_physical_efuse_map_ddv() where
read_poll_timeout_atomic() times out waiting for the B_AX_EF_RDY
bit after 1 second.

The root cause is a timing race during boot: the WiFi driver's
chip initialization (firmware download via PCIe) overlaps with
Bluetooth firmware download to the same combo chip via USB. This
can leave the efuse controller temporarily unavailable when the
WiFi driver attempts to read the efuse map.

The firmware download path retries up to 5 times, but the efuse
read that follows has no similar logic. Address this by adding
retry loop logic (also up to 5 attempts) around physical efuse
map dump.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Changes since v1 [0]:
- Adapt patch using suggestions from Pink-Ke Shih
- Simplify the patch description

[0] https://patchwork.kernel.org/project/linux-wireless/patch/20260301042422.195491-1-christianshewitt@gmail.com/

 drivers/net/wireless/realtek/rtw89/efuse.c | 23 ++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c b/drivers/net/wireless/realtek/rtw89/efuse.c
index a2757a88d55d..6ed4b569c2d7 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse.c
@@ -185,8 +185,8 @@ static int rtw89_dump_physical_efuse_map_dav(struct rtw89_dev *rtwdev, u8 *map,
 	return 0;
 }
 
-static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map,
-					 u32 dump_addr, u32 dump_size, bool dav)
+static int __rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map,
+					   u32 dump_addr, u32 dump_size, bool dav)
 {
 	int ret;
 
@@ -208,6 +208,25 @@ static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map,
 	return 0;
 }
 
+static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map,
+					 u32 dump_addr, u32 dump_size, bool dav)
+{
+	int retry;
+	int ret;
+
+	for (retry = 0; retry < 5; retry++) {
+		ret = __rtw89_dump_physical_efuse_map(rtwdev, map, dump_addr,
+						      dump_size, dav);
+		if (!ret)
+			return 0;
+
+		rtw89_warn(rtwdev, "efuse dump (dav=%d) failed, retrying (%d)\n",
+			   dav, retry);
+	}
+
+	return ret;
+}
+
 #define invalid_efuse_header(hdr1, hdr2) \
 	((hdr1) == 0xff || (hdr2) == 0xff)
 #define invalid_efuse_content(word_en, i) \
-- 
2.43.0

