Return-Path: <linux-wireless+bounces-34827-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNfyKvsP4GkycQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34827-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F372408916
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C7A33075845
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECCA388E41;
	Wed, 15 Apr 2026 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8u/TRds"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A5D39099A
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291810; cv=none; b=CsohMPbh47RK0huEGfr7Q5AGzoccwSbI2LVLnkc0hYu92BZOUo/OyusEYfac20o0X26cSm1idFcGMbw32I4n7EqAsyaLPLLlahO5D3Sbg/d5SdUdS1G7KMx9MnglbOsMRlnNFhYXSTXhJOeD36JJcEztI8lMU6MKyBch3nGHjwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291810; c=relaxed/simple;
	bh=0U/bcsQpieIf1bqTC2ixQ525IqpXMLQqveQUbJkCJe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBeMbp9TkX0Ledwa6ISN0jY0u0s8ipD7kktyb2UmlLpv4H10gJRtYEmXL2I1tn+hxBSRG0/wjjjdDUmoxq5Xlc6D9dE16KGADHT8PQD2lYGFDSFt3zlgTMBUlTi9fjf3AUT0wcHfoYl/hDVXksXtQ1SvzRHsg9xLl1p1RypWVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8u/TRds; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso40702645e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291802; x=1776896602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJZr+//quW+MQVyUFXI1nceGLIm8xDCx/CEd5g1IcZI=;
        b=h8u/TRdsgDoQs1LpwJdMN1k29LP/17qHsZt7OTTcMMQ0x8pF8rc0A/axyon4khbSzd
         xE4PJNO52zNWiWiy43CiDpbTIgvZiqWk/5PA6B30aQzoi6S3QGVadMgl1e17kogErcpB
         VNE9qBxmZ6Ownl7UkWCmYa3EeBwdJM9OHfbehM/LFmhAM9mYn/zsprh8Z+8NQf4cVd5c
         V7IcIQuu6VGMg5dmxIuNvu5ni0vsZUGEHqTSWTG8gn/KLk5+mDCaWBNJ7c0hx4r65YGd
         Lft6yaqhMKUUz1Q6zpRpbDj0y0FfvS2RzQbfIfcBXBcw3JAYiAtqXVDKgOXPWdKNM7+j
         egVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291802; x=1776896602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJZr+//quW+MQVyUFXI1nceGLIm8xDCx/CEd5g1IcZI=;
        b=tGa3egNdidVea795fzIOFqk3kagu8HhCNi00kuzhlEdC2ktkgZgSgzSno2FqQFjZMJ
         aCVytPlS0a+tf2G7wIYx/2GtzVgyyzzEbAsBgF7cPwnyzxK1BQOO209gx5CkApIbgBWt
         I/v/kbJ5GsoLxsko7aYWAfhUetQHaua2KbfaqMbprvnNtddyG0NERrRGV/elqg7ZYOPT
         EmCb7OHy0MLLSWVD2DsCToYcOG2cAnnlKv6zi7fG0JfTKR6uDFMCHVQpl/PZ8KhXXasF
         aliHKzY6W3ELJq/YtROeFE+kQFELSncYDS0Kw+PkJrJmSCtS4lV5geQOu6nLgMRXsuGg
         H7sA==
X-Forwarded-Encrypted: i=1; AFNElJ/tAmHdtGd88f5iJooWF3R9bJoVrqHhh1OR5Mz0CUe+sACH1E1V48Arr84tjzhtzk7P2DCMY6lMvPUGjcIOcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAsq/dSchw70iHwRYZ/8UGUulb1grdBjo5A7jf3oP14gDml6dr
	8d6r5d+3oqyFBWERZL8Su/jkMQNjCMPcR91dkZGEyBGABUXYCeDT0HQ=
X-Gm-Gg: AeBDieuFB7C4s3e4LVPNXylt4AHOg977mz0HVqfVhEki3hCovwMXLI8yqIWJ0uolOPe
	uejAZFFnIkC+8kzpmOg0Zi7YoXd1Ud0I2o28ngBCRyCgME2lT2dpWrUar7rh1WYD5U9pNAoxZ8I
	h2HzcPuXS8pFN2yEPkv+QqmrIPAbYd4OMLfihvP9ibPP91IUrsntY1MJOLWTIcYb38yTv2HCq7n
	hPfS2+bxBAMzPJ/CAp4nDTujuyt3ZBtA5b0VPi4F06yha+1FJK/hny/TaSn+UWWCs0kzwTgG2Rp
	CcJ5E8Xx/P4N0xC4iDrNPtkfW7q/OwRAtcwkqJvM9I4xEhbqsgjWxWXIluRls4RYP6+wLkD0qnN
	LacFSq/o5jmoV59MZArWqtSSNbvsKsvSqUYprOkTJq54BkoMADZZ20s8SZV5fGplXWk0wJZ2TLB
	iWIU4=
X-Received: by 2002:a05:600c:8207:b0:488:a4d6:69ad with SMTP id 5b1f17b1804b1-488d688dd1bmr317940585e9.27.1776291801962;
        Wed, 15 Apr 2026 15:23:21 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e9a742sm28702585e9.14.2026.04.15.15.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:21 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] wifi: carl9170: fix OOB read from off-by-two in TX status handler
Date: Wed, 15 Apr 2026 22:23:18 +0000
Message-ID: <20260415222319.1538389-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222319.1538389-1-tristmd@gmail.com>
References: <20260415222319.1538389-1-tristmd@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34827-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 8F372408916
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The bounds check in carl9170_tx_process_status() uses
`i > ((cmd->hdr.len / 2) + 1)` which is off by two, allowing
2 extra iterations past valid _tx_status entries when the firmware-
controlled hdr.ext exceeds hdr.len/2. Fix by using the correct
comparison `i >= (cmd->hdr.len / 2)`.

Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/ath/carl9170/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -695,7 +695,7 @@ static void carl9170_tx_process_status(struct ar9170 *ar,
 	unsigned int i;

 	for (i = 0;  i < cmd->hdr.ext; i++) {
-		if (WARN_ON(i > ((cmd->hdr.len / 2) + 1))) {
+		if (WARN_ON(i >= (cmd->hdr.len / 2))) {
 			print_hex_dump_bytes("UU:", DUMP_PREFIX_NONE,
 					     (void *) cmd, cmd->hdr.len + 4);
 			break;


