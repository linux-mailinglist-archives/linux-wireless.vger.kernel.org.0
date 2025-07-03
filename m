Return-Path: <linux-wireless+bounces-24801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A10AF8172
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 21:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317137B22B6
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 19:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23598298CC5;
	Thu,  3 Jul 2025 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F56v2AnD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE902DE6EE;
	Thu,  3 Jul 2025 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751571495; cv=none; b=Wk7ArStE3/bsswR+QF4Ignzv18VuRTOPZcpVS3UcRN81xNiY5byy6JFPph1r3jwOgZrbLztTrUVe9SY8jXLWp+/77bBkfXIuDGd60oKlqhsTG3SEkVhstlJo+EC8Dy8fOKQIAOIwGqkGus6WQYBXiM14wPZQynMRRXsDOyAdFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751571495; c=relaxed/simple;
	bh=p5uOMFHvJwUGuJvmvYotmeGOkDlMkIpY+4J3jc724Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSBiBxiuyak7mPXJ1ShKWyiFgpOGI9buzacFqFbJwJ2e/npaPgMd6RFeq68zJy+/GaHkoFSx4gExuXwOGZaOZBJP5dSju/8JIWBTiU50Rj313h3GrMkDPWv3LDP9i60jdt2SCTIIqEIafxdM1MVfnv5TtiSsaUuHRTO1BnhgFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F56v2AnD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-236377f00a1so3387635ad.3;
        Thu, 03 Jul 2025 12:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751571493; x=1752176293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfLY4ZIIX6c7Uf9FQfy3N6nezkDQGS+OMzVy2anSQiE=;
        b=F56v2AnDkrsgjEEkpk7zKYrCvywGY6v5N/XHlU3Xn9tlu5XgZqIBpQM/jgmEFgGi6h
         U+UZrwARUCmHInEdbNV4ndv/5pzmoOYCT+pI3Jzk3Eeh1K8sQslCTQDlZGPzwBSPwJ8y
         RQIAe0yd6aqcnK9bYHpX5tbsp17LFo/8mhY5KOvoDSLa5WpDoisebi8Kr9erCd0PFumH
         OjOqLgossOO8ZgoxRxr3nR26KX9IyAbdAID3DWrAL3IyLINYKvX2Z+tQlNK3w/JSEj45
         TGNM0a7UVwtLaPlpZ1AsmXTmZPuikN/Yc5yMubLnWRmywCB0iy+IUdBrmEw0k/VU9L35
         vpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751571493; x=1752176293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfLY4ZIIX6c7Uf9FQfy3N6nezkDQGS+OMzVy2anSQiE=;
        b=suuykLqj3KFA6Q8ZAuoXuwySD4TXS+zH9YVTAlaF2CIyd5X+vv9aWFzAdeLrdZkq9X
         9FyLSgX/t5xOpOm8f4Z9Gee+BQKnF+o0SejH6mR8beH3CixQSElH3N0pP+CxMeyZSPsp
         NlxPM8Lk8tnamnwoMIJuCYQC28JNsgEraRMX3356gbLgHNA6K4NhEJbdmA87/yO8oKAf
         TNCP8sLEqFNHiI7CZ/ICLAzBDxmL/fiW9ekVOszQa909gQiFyoAq5mFQq6OroRR/CsVK
         UYUCZpPldNsMhp7C8Qy8r9vdzdZONdKHwb4VfmN1mMVJsO3NHz7OWrAWbNCaNOpm84n0
         sViw==
X-Forwarded-Encrypted: i=1; AJvYcCUDN/p4mMBPwm3Z03z1e3c2tNVZLv4/2UeAqZ1uscRShpSya31PIo1/9pRz5U4j70lOTWpQBsgSyN0yNi8=@vger.kernel.org, AJvYcCUZTPfgvDcZ6DdNUM4GTu+5OIcNf3NmLF1U113DK3zirZOdXaAhO8ywS0gToCD2J95lCZsWNk4w6vCfbg6RsmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYvDHVs/dBbdiExFMf+zG/CvxcsVl2Oa1H7mjN7WPC99POWB7
	+f/+PXmTT9G7foRRVrR0oaGkqZBXwYVy2jMJqtAMqxHvgIAZVTkfTtK+
X-Gm-Gg: ASbGncvCbMQ7ApcDBkidalPyW/95SJEy6CrJCWFHYxCOhld6OtOutNV+42BtUDctlpw
	pgniXl083WAnzalx1eD58SlstB1RKGXIC8Dwvzn8yUnjJGeSrwHOnvYeBywMCE4uLcf2nZzCqXq
	FFNnTWJQv2+n4Qy5X5PSPBIeqL9kIgDmzP9qlJOQvNfRVvEZg6+8rZKF02UG4txXA1/lRvfQ0Af
	3m5V6HQy/8Xaj6cUOUq8M0d7SUv+1iPbGxfgiDac34fHIJjkkRT50q5F5sGrRJPUl+tYt5qgPNv
	e8fWKxj0JgvMnj6p3lb/N0omPg4LY9wxehHjsAlg7Brtq3Q32NCXsyEJTTICg+w=
X-Google-Smtp-Source: AGHT+IEWpfYnkVr+s6TSpjhobBo4AZaEkt/VIFDfi8qDj8tp/r66E4q6OKPr5Gj3/ggnBkjffzqwxQ==
X-Received: by 2002:a17:903:2f8d:b0:235:779:ede5 with SMTP id d9443c01a7336-23c6e5b6125mr114749925ad.40.1751571492849;
        Thu, 03 Jul 2025 12:38:12 -0700 (PDT)
Received: from p920.. ([2001:569:799a:1600:788:c50d:c37c:e870])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431f1basm2947795ad.25.2025.07.03.12.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 12:38:12 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: johannes@sipsolutions.net
Cc: nico.escande@gmail.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH v2] wifi: mac80211: reject VHT opmode for unsupported channel widths
Date: Thu,  3 Jul 2025 12:37:57 -0700
Message-ID: <20250703193756.46622-2-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VHT operating mode notifications are not defined for channel widths
below 20 MHz. In particular, 5 MHz and 10 MHz are not valid under the
VHT specification and must be rejected.

Without this check, malformed notifications using these widths may
reach ieee80211_chan_width_to_rx_bw(), leading to a WARN_ON due to
invalid input. This issue was reported by syzbot.

Reject these unsupported widths early in sta_link_apply_parameters()
when opmode_notif is used. The accepted set includes 20, 40, 80, 160,
and 80+80 MHz, which are valid for VHT. While 320 MHz is not defined
for VHT, it is allowed to avoid rejecting HE or EHT clients that may
still send a VHT opmode notification.

Reported-by: syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ededba317ddeca8b3f08
Fixes: 751e7489c1d7 ("wifi: mac80211: expose ieee80211_chan_width_to_rx_bw() to drivers")
Tested-by: syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
Changes in v2:
- Dropped NL80211_CHAN_WIDTH_20_NOHT from the accepted channel widths.
- Clarified in the commit message that 320 MHz is not defined for VHT
  but still allowed to support HE/EHT clients that may send a VHT
  opmode notification.

 net/mac80211/cfg.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 56540c3701ed..d76643d46150 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1981,6 +1981,20 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	ieee80211_sta_init_nss(link_sta);
 
 	if (params->opmode_notif_used) {
+		enum nl80211_chan_width width = link->conf->chanreq.oper.width;
+
+		switch (width) {
+		case NL80211_CHAN_WIDTH_20:
+		case NL80211_CHAN_WIDTH_40:
+		case NL80211_CHAN_WIDTH_80:
+		case NL80211_CHAN_WIDTH_160:
+		case NL80211_CHAN_WIDTH_80P80:
+		case NL80211_CHAN_WIDTH_320: /* not VHT, allowed for HE/EHT */
+			break;
+		default:
+			return -EINVAL;
+		}
+
 		/* returned value is only needed for rc update, but the
 		 * rc isn't initialized here yet, so ignore it
 		 */
-- 
2.43.0


