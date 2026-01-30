Return-Path: <linux-wireless+bounces-31343-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIt7FhcBfGnPJwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31343-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 01:53:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E01B609E
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 01:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BA22300A8F7
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 00:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791BA2E719E;
	Fri, 30 Jan 2026 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="aKODAsO4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8F72DFF28
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769734419; cv=none; b=pXPlzg3UC3bVrehAhayzST3+QCMq3/rXz1aDaduIUGQ5CDOqVOQKBynaEIahjq1CuoKLJwYicgpfnJxP4hQlTsZ9Xbo+8S4L8QRgAYsrUnSdYe+VSl3ve7/SnyV0BRe98dpFpveWWKuDkSV0dzDo//4MyAniqZpbPqPaICKj4jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769734419; c=relaxed/simple;
	bh=Q4GsYZK4UZdYxhthcMI5I6peeUAq94Ng2S6llJbJNZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdpEH7zz+UM0NH2kP+n9n34jF1FMWxFtY/eSwVRLNW/FXeoAq9pqRSNBz9N+dijNVtSO+6Skf7bnGM2Hm+OK0/mH5k8c9PKfz/DCFKo9kt4qboLCHBzYLuAVBlLwwg7Vx8M4rNHdPdJ6UATzIxM/AevExGDLM7a8ZLNNnfdEqf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=aKODAsO4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81ed3e6b8e3so808753b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 16:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1769734417; x=1770339217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LZWHQULK4k6d4WwxoTJaobArWfPKXb/AmI10H63mXE=;
        b=aKODAsO4+zwTlyoIKHbfbMRb5ozVBHFUcxZVisxhFaNqW6c9XhAeBxUTGfkb+Xelm7
         ehtQrL5+t0khpnTM5Sl1OEcreh2bbsy1yGxVwOud3EAo9YDpK7kUCdjKTCfMQntJTpaq
         f69cyJqlS+YDPi6/nmrgLWROlBiqy/2JYZvcZgrl4ko17QyKQ6y5hv9ByR+NHCIzCKyA
         gy3aZAxlyzsxrd66VcvFmTneXX2nuGONN9Z3jEsiwqw1CkmYCJj27xlKbRMV6uhCl3Wp
         eq7IfcMftsD8vbh7G6l6EcTUJeDZ/UCeqGvH1jfRGonuQk+7caEO4Nc1BLslpq6e6Xi8
         OwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769734417; x=1770339217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LZWHQULK4k6d4WwxoTJaobArWfPKXb/AmI10H63mXE=;
        b=j3qWCkDTO6WfxCCV+we6aHe71im8qIOjHWSS9zy5ID7VGhZ8JOHfl2Y2hHKDXOc3nm
         IfX2WzWz2HxAqzn492mFudXTwAu3TJ6vkr0GEjuYISOwJWziFfbh40D7qobuExBindqt
         MtH0JsrNmeYNMZHn47k52pFE3ALp1NtncDv+A5k8nAumsEamQ70wRjM9OwkVMyLcfqD7
         dZaHt2FcpfNUTXjpeQ0HyTK4PmZHm+KQkuxyYOhZNDs9KOL7ulrc1lgOSVejCbZx+NCl
         O/jSkInJPqbyXHJyJcdCdixIYo+q6nblYTtwm+4SW+mdlgbc2P8vRc9ScuBZM76S1F1N
         tgMw==
X-Gm-Message-State: AOJu0YzNhTIiW0KHgvttSjRS9oTBbXUDAij3YD8cOf5HGQWrqmgHsEDS
	x61A1ahwB9KkcnCSQ0ho9fx8TVhAfWBj8soOW0U96a+qynCXS0akPYEOuHOACG51OOY=
X-Gm-Gg: AZuq6aItL8hpAiA6iZ/xXILLgkLy2ELlu2e3h4EeFVpTJg2e/2uCcELEu5Hh0ltmGjn
	7u5HzJOcenl0rXhmf0SgYnMBDobaJ9VmUNdxvh1tozxneAFK6GM3NCmG+g//YWpqpV4H3bB1ewR
	k2Uod9pMlNmZpt7WjTBQKLQHyfTkUo6r3toUeavgs5C7zNhW8YyeyFieY6vt6Ude1VWfkqLZxiJ
	kNUF6QeIEQis7w48GD7B6lQszSBa7HKvv4D9iTELbfg5CJoNtrCbufazjefYoLDMAFyD13XeZIJ
	VQ2+biAhUfroaHBxAqEXrbBnm/58eSsVc+JenLCZ4Oak2bjng5mxZLEh4cUMiuzNaM5Y5jTc9lK
	YBwlOas9/2+AmeP1roJU5VbY0+aBosE7DgeuCBQpuKkrMP7crIrUMkgimA6Wmi6I0o792qYeJLo
	HBD176CRS129qSh609pZEVphqcW6/9cgkZoCTpB4GCXx3yT7j3P8zWIGIku2rkWUQ6tglV9hGB+
	KsZPovkwF6LSKoU+dU=
X-Received: by 2002:a05:6a20:728a:b0:35d:58d3:2904 with SMTP id adf61e73a8af0-392e00428cdmr778060637.31.1769734417305;
        Thu, 29 Jan 2026 16:53:37 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6558a1a5c9sm3167655a12.8.2026.01.29.16.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 16:53:36 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next] wifi: mac80211: correct ieee80211-{s1g/eht}.h include guard comments
Date: Fri, 30 Jan 2026 11:53:19 +1100
Message-ID: <20260130005319.70019-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31343-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A0E01B609E
X-Rspamd-Action: no action

After the split of ieee80211.h some include guard comments weren't
updated, update them to their new file names.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/linux/ieee80211-eht.h | 2 +-
 include/linux/ieee80211-s1g.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index f9782e46c5e5..620dad3995cc 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -1179,4 +1179,4 @@ static inline u32 ieee80211_eml_trans_timeout_in_us(u16 eml_cap)
 				 _data + ieee80211_mle_common_size(_data),\
 				 _len - ieee80211_mle_common_size(_data))
 
-#endif /* LINUX_IEEE80211_H */
+#endif /* LINUX_IEEE80211_EHT_H */
diff --git a/include/linux/ieee80211-s1g.h b/include/linux/ieee80211-s1g.h
index 5b9ed2dcc00e..22dde4cbc1b0 100644
--- a/include/linux/ieee80211-s1g.h
+++ b/include/linux/ieee80211-s1g.h
@@ -572,4 +572,4 @@ static inline bool ieee80211_s1g_check_tim(const struct ieee80211_tim_ie *tim,
 	}
 }
 
-#endif /* LINUX_IEEE80211_H */
+#endif /* LINUX_IEEE80211_S1G_H */
-- 
2.43.0


