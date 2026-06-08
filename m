Return-Path: <linux-wireless+bounces-37518-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FHWSOSO4JmoWbwIAu9opvQ
	(envelope-from <linux-wireless+bounces-37518-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 14:40:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025F65643B
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 14:40:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UqqaUyRL;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37518-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37518-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2F7F3003EAB
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FD9379EE1;
	Mon,  8 Jun 2026 12:34:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903EC340409
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 12:34:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922097; cv=none; b=PkP0jo/Jl17Ecgf8w5+C0WDZLWy26gk3Gf/r7DKfVvqkRcJAItRB/qV5piKKMvMmd1aoYOlLwg93cnu8BAwGslVKePkSwqpOzLsPl5A6kvr9CTmcQSCIX858kGTsCA4p6HhbUZc6UL+QIDyGnAHRxFTG2rfRVHD57SHjRz+LF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922097; c=relaxed/simple;
	bh=DlPYUgHKFlKkxwKG/MJLNLlN2G2FcsJYjaMptCVzgjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LDs/TlLA6P1mQleW4pttICm/Xcf8JT0qDCuxUK/7qavpgDZGgJXlRzZx3VThU1k56kj2Di3Dv8/wtPflrePUHow/CTt8G/E9ltRuSU4xWBSCeXC/9qq7GF09XLTU0o5CokILXOWrgytQ0iq3Jeh8CLNTYq1DyFrxG91ZZpmZhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqqaUyRL; arc=none smtp.client-ip=209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bec3f69d343so618247066b.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780922094; x=1781526894; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51QOmcfHJGG9xTSzJNyI3kOBUAZjF52SeLGAO8MU7Gw=;
        b=UqqaUyRL2FfjTlL3FQFTV6QdsRSw3BoEk8sx+3JRlYzMZ2wfLF3zn4gaQaRDRSUq4S
         q38xgBJk1ZqWAncuvsdniWs22+qL5SH9OIaFuKPfKbSiV9dS/oMIhG4ILqhJfhaF88Hg
         NUyIetiI1Ua8/xMbiTaj8g6gWAd5/lTllHLo3Ul1dl+Ay4hwrxdahsr0is2DjG8V+bc2
         qmqAlKcozgXPmsWHILkAn3VsKwyqj36gxvxccv+cCUnKO5cpLU/s1SxzKUtPIxpqyxRT
         I6FWwyQqev4HsrXEMQUbtkGiSEhxdPrSSHiNPuDKVG1NL5EydThcPY6M7lzBsF1utOLJ
         aPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922094; x=1781526894;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51QOmcfHJGG9xTSzJNyI3kOBUAZjF52SeLGAO8MU7Gw=;
        b=U0Wm1K2Xz1PAO9qtJRJ3Mm3CgCxt8rlMLaQcvPzJgw9vCHtZOtsUvPm9tx5A+8qUt9
         N1FuX7stwBwf0X1wjh2o/zdVi9ktnut1ft8uwZFf0ckXytGvntLHsMBEIMcGhRm47PlP
         8eHJenrXdbm20ECWz3kokhuejpfEMF4/Qyl4JiD2fLnNQmS42iT/I3KtMNAnLkzebDZ2
         XJJvoOXMbJS36cTyMZX56QeF+pTUsY2r5KdEsLgqCbPpKN9LhLV+f6hohL3RJCIpHqID
         dNBLZO44ke45Hz3u1pSgu0nQoetKgXVoUOznm2JoAUKsZ/bM3y8eO0Gq4aNBAGjp8M9N
         kOvA==
X-Forwarded-Encrypted: i=1; AFNElJ8rsfEvZTj+xqnLD3SyDgfemkX31Z7gXTy+xpKHpjQD+TTX2amHKPPZc3kXaNUwo8haddOukIFRiw8AwdADoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzizYzQwr1VcXbfof6GJV404ZOeGnt21l+dEB6wSX0ZQonL3dwh
	0z1BvHo7GkKWDz2em7WHc8to+H5EYOnaWM9k3TXusrAMHjzFzKvcjm8Q2Y9JxY3a
X-Gm-Gg: Acq92OHd25mjaxZ9MxCzXgWwNiXMFvIEz7Mq3XrIRfSfBIk5+ppFBOkyh91S6pgZgVH
	FukrDHX4YeXJ0BsIJqRBZkw1My1BhJwKAB8aqhJMfni+8uN55crmXiUl1U3/5XwwnE7NAO1eM8F
	Hy78bswqam+/Wtjsoq4fRX1YP57rcK6pp8nZ6XgsrzuLMWR2UbUYRpR82tvMY41I+YudZt02QWB
	UsDskf3E+Is8ssdCzcwvGITbJbV2IVc594LNJBWRryKeC2/tD1RF8ZgpBUoIytNGoYs8o0CT/P2
	imE9nqCcmjHc9eVvV6op9jhaIcB+wt/ASoxSAN161b6Bfsvb0MYD1of2R/XU0rXWz2re77Us9aX
	GNAD565AHVG8YkuwYySg/DX7qflOQM5l6ib/Ynv+mef4H4zR530uRQdA+J6F/rGhU+7caFTfIA4
	CTl8hR74Y5XwU7ZpwxrC1q2KpROQ5e
X-Received: by 2002:a17:906:8a76:b0:bee:280b:8bed with SMTP id a640c23a62f3a-bf370e6217fmr535751166b.22.1780922093816;
        Mon, 08 Jun 2026 05:34:53 -0700 (PDT)
Received: from localhost ([43.225.189.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055303fc6sm877557266b.42.2026.06.08.05.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:34:53 -0700 (PDT)
Date: Mon, 8 Jun 2026 15:34:46 +0300
From: Dan Carpenter <error27@gmail.com>
To: Kuan-Chung Chen <damon.chen@realtek.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: rtw89: debug: fix off by on in rtw89_ppdu_str()
Message-ID: <aia25i0ds3B6QF6c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37518-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:damon.chen@realtek.com,m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:kernel-janitors@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[error27@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4025F65643B

This > comparison should be >= to avoid an out of bounds access.

Fixes: 419ed7f4a053 ("wifi: rtw89: debug: extend bb_info with TX status and PER")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 8f5af873e09f..5786120602ab 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -4348,7 +4348,7 @@ static const char *rtw89_ppdu_str(struct rtw89_dev *rtwdev, u8 type, u8 subtype)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_ppdu_info *ppdu_info;
 
-	if (type > ARRAY_SIZE(rtw89_ppdu_infos))
+	if (type >= ARRAY_SIZE(rtw89_ppdu_infos))
 		return "RSVD";
 
 	ppdu_info = &rtw89_ppdu_infos[type];
-- 
2.53.0


