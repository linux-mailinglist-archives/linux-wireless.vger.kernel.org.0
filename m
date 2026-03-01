Return-Path: <linux-wireless+bounces-32323-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /w1NO3+/o2nyLQUAu9opvQ
	(envelope-from <linux-wireless+bounces-32323-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Mar 2026 05:24:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1891CE7FE
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Mar 2026 05:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91DD0300D1FB
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Mar 2026 04:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE8C307AC7;
	Sun,  1 Mar 2026 04:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSJTyxdn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05C20D4E9
	for <linux-wireless@vger.kernel.org>; Sun,  1 Mar 2026 04:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772339069; cv=none; b=kpB8q9HyVbvVBO+r6KEGY8Eh74ZKXtfMiw30INm0Jn7/8cyT/t9Ct4uNKpcCAT9mw1XdVdFBnh0B/+sVITUD1WtGuqbCRpqIGtTVvzlJQOXUbbFZ+JM5B9d7xJuWjFOONVs2Gzwbz68clKCMnK6x0KAK+E+u4h7wpeYqAe5Rmz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772339069; c=relaxed/simple;
	bh=erwOK0x85B3Sv/3Jz8eavTh4pZ93LMW9j48/lTd59+E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Cv/P3ZMv8gyCD6nZw2Rqnm9hxvaXG7G0xLNB93hKqwMvDOMAoo9w0II+3mQWbS+u5Y2m+D8uvod5DcG3I+ia1IJ8XhQpVtNqlO+fPbBrkJtF8Htd19FFMflpfgQpDeueyrV5t+LF4IzPr42smp609e031tg5YCntgsu74qc6sU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSJTyxdn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483703e4b08so28521605e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 20:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772339066; x=1772943866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i+Ib5hsO9rUEM/HRFPWDdLfMbgIdRqz1BGP7nNb3vgY=;
        b=JSJTyxdn0bhpSJkeIhHM2Qd5aiFAgkH5CvKDx5yoAAU6MGVgI26AoQdx+YqXRD+soQ
         ByS/RxinYIDVVYJzR3cbvN+2f8eio5YfMTM3mhcdh3yQ0oqa7bp7ievNyyhyL86hL0oN
         74ta3rwi5AN/MshKbA3zhqzcdJQnf6c9NzQZuhrjAUt4ZhH2Vr/EPVhUbela3pkI5tjF
         vPap8T17vfr6aONfKBdNoBAG5jDrKQXnj13JYssc9nqYBOSVn5mxRppYDJHtftXBcdlJ
         PSbfRWTR9VsyffuSPKCBc3zuELeNuOHfmaU1k0sZcmKrpo6GniFqhao0XAEfObi06VgK
         z5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772339066; x=1772943866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+Ib5hsO9rUEM/HRFPWDdLfMbgIdRqz1BGP7nNb3vgY=;
        b=ISD/SRTwYCFiK+TW4Vo3HrfKECNu0Ofhebof/HfQV6Gt6VRKIoHeM9lwDY7D6WOIRm
         a0SWCg8v6w4bfzYPdbnDATAAOmAqBfC1iQ0N8OVdCoyehCT1vWBgwct2Yf7LJeZjAi/0
         3V89dLSbCfFQu65QgU83ycpwqMWNDZAVniJYzp6zFNDaDsX/S6TtrZvy5w0kiYVtBNWs
         lc7qqansm4EusAqCHiQcxCq5V2dlfG0hfBvIc7cAQ83noH8AzXyKkM/dH/rLeYqcWnJt
         TjGxFmTTY1kBPbg3RcZVosCWOlqOu+YXarQYpH/vVyRiCr8DExnBoS+a4wjNm6SmBvjo
         O03w==
X-Forwarded-Encrypted: i=1; AJvYcCU/67eTgyLt2WWkowCBBVXPJtQ4z1T10b9MPgOGVPqgPgnokP6TcHLrI+WkBEc/j9EAPkFZhwEsYPkZAUw7tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwabHPvjFosa+tnUuhHMeQXocbYijfTEG/owu5B88IZk2N7ZNcS
	jvll0d/ChEZVPN3tlR3pIyPpccYqExaJ1OOkOuQsAA4O+207ihWNNPts
X-Gm-Gg: ATEYQzyjjN0F6GVSHmZ/9HNrdCVSUtbgYTLPHmVjrBoactS/JPsRK6yDMs9e7f6OIdF
	1LkGK0w7QL6ud5XIk5VgaIwRNeNb3Qb/CnRF+BvhMr4Vc1tTdPL5GV5MHgumm0jo5LU9mq8+eOU
	sOXYhungqsh6YvPtIpJ9KewTAMSGKev3ml6vwEwW4wYzAKJJJhp778DawuMcGF40LJX9TmKwgNq
	mwocz0/q21O/UlmvwJRvf52xv1XnXzhOYR6eNd1xyNP9BxLYqhZGuDuy7oUxofWGWGxACOtP53/
	7wluBXt7hDFrPMc4NiQRH1GLyfBCogsj9OId+sPndzVTYtg9T4sAJgJvyrWAKepIRPLQtc85Cr5
	CSRfEu4bWE/7YifznACs9lgRTC5ppCpQh59VTdmQeP49nTPqZgVOJXe0Gx/V0t0cZ4vWWaQFSLf
	xc+bSuHPlbxUKr7mezslyRt0B0L5U=
X-Received: by 2002:a05:600c:c16e:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-483c99348c5mr137166365e9.13.1772339066139;
        Sat, 28 Feb 2026 20:24:26 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7030b9sm257836325e9.4.2026.02.28.20.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 20:24:25 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rtw89: retry efuse physical map dump on transient failure
Date: Sun,  1 Mar 2026 04:24:22 +0000
Message-ID: <20260301042422.195491-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32323-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[realtek.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christianshewitt@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3E1891CE7FE
X-Rspamd-Action: no action

On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the efuse
physical map dump intermittently fails with -EBUSY during probe.
The failure occurs in rtw89_dump_physical_efuse_map_ddv() where
read_poll_timeout_atomic() times out waiting for the B_AX_EF_RDY
bit after 1 second.

The root cause is a timing race during boot: the WiFi driver's
chip initialization (firmware download via PCIe) overlaps with the
Bluetooth firmware download to the same combo chip over USB. This
can leave the efuse controller temporarily unavailable when the
WiFi driver attempts to read the efuse map.

Add a retry loop (up to 3 attempts with 500ms delays) around the
physical efuse map dump in rtw89_parse_efuse_map_ax(). The firmware
download path already retries up to 5 times, but the efuse read
that follows has no retry logic, making it the weak link in the
probe sequence.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
The LibreELEC distro is minimalist and fast-booting with some
history of exposing racy probing and timing issues that don't
show up on the mainstream distros. Below are some before/after
dmesg prints to support the patch:

Before:

ROCK5B:~ # dmesg | grep rtw89
[    6.575383] rtw89_8852be 0002:21:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
[    6.575538] rtw89_8852be 0002:21:00.0: enabling device (0000 -> 0003)
[    6.585763] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15 (6fb3ec41), cmd version 0, type 5
[    6.585779] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15 (6fb3ec41), cmd version 0, type 3
[   10.174946] rtw89_8852be 0002:21:00.0: failed to dump efuse physical map
[   10.176584] rtw89_8852be 0002:21:00.0: failed to setup chip information
[   10.178173] rtw89_8852be 0002:21:00.0: probe with driver rtw89_8852be failed with error -16

After:

ROCK5B:~ # dmesg | grep rtw89
[    7.393558] rtw89_8852be 0002:21:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
[    7.393729] rtw89_8852be 0002:21:00.0: enabling device (0000 -> 0003)
[    7.406341] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15 (6fb3ec41), cmd version 0, type 5
[    7.406363] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15 (6fb3ec41), cmd version 0, type 3
[   11.041563] rtw89_8852be 0002:21:00.0: efuse dump failed, retrying (1)
[   11.798390] rtw89_8852be 0002:21:00.0: chip info CID: 0, CV: 1, AID: 0, ACV: 1, RFE: 1
[   11.801013] rtw89_8852be 0002:21:00.0: rfkill hardware state changed to enable

For context, firmware also fails (and recovers) sometimes:

ROCK5B:~ # dmesg | grep rtw89
[    6.436873] rtw89_8852be 0002:21:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
[    6.437165] rtw89_8852be 0002:21:00.0: enabling device (0000 -> 0003)
[    6.450228] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15 (6fb3ec41), cmd version 0, type 5
[    6.450239] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15 (6fb3ec41), cmd version 0, type 3
[    7.864148] rtw89_8852be 0002:21:00.0: fw security fail
[    7.864154] rtw89_8852be 0002:21:00.0: download firmware fail
[    7.864160] rtw89_8852be 0002:21:00.0: [ERR]fwdl 0x1E0 = 0x62
[    7.864165] rtw89_8852be 0002:21:00.0: [ERR]fwdl 0x83F0 = 0x80011
[    7.864173] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931150
[    7.864188] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931150
[    7.864203] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931154
[    7.864219] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931154
[    7.864234] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931154
[    7.864250] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931150
[    7.864265] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931150
[    7.864281] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931150
[    7.864296] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931154
[    7.864311] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931154
[    7.864327] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931154
[    7.864342] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931150
[    7.864358] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931154
[    7.864373] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931154
[    7.864387] rtw89_8852be 0002:21:00.0: [ERR]fw PC = 0xb8931154
[    8.181342] rtw89_8852be 0002:21:00.0: chip info CID: 0, CV: 1, AID: 0, ACV: 1, RFE: 1
[    8.184322] rtw89_8852be 0002:21:00.0: rfkill hardware state changed to enable

 drivers/net/wireless/realtek/rtw89/efuse.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c b/drivers/net/wireless/realtek/rtw89/efuse.c
index a2757a88d55d..d506f04ffd6c 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse.c
@@ -270,6 +270,7 @@ int rtw89_parse_efuse_map_ax(struct rtw89_dev *rtwdev)
 	u8 *log_map = NULL;
 	u8 *dav_phy_map = NULL;
 	u8 *dav_log_map = NULL;
+	int retry;
 	int ret;
 
 	if (rtw89_read16(rtwdev, R_AX_SYS_WL_EFUSE_CTRL) & B_AX_AUTOLOAD_SUS)
@@ -289,7 +290,17 @@ int rtw89_parse_efuse_map_ax(struct rtw89_dev *rtwdev)
 		goto out_free;
 	}
 
-	ret = rtw89_dump_physical_efuse_map(rtwdev, phy_map, 0, phy_size, false);
+	for (retry = 0; retry < 3; retry++) {
+		if (retry) {
+			rtw89_warn(rtwdev, "efuse dump failed, retrying (%d)\n",
+				   retry);
+			fsleep(500000);
+		}
+		ret = rtw89_dump_physical_efuse_map(rtwdev, phy_map, 0,
+						    phy_size, false);
+		if (!ret)
+			break;
+	}
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to dump efuse physical map\n");
 		goto out_free;
-- 
2.43.0


