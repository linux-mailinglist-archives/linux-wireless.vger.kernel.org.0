Return-Path: <linux-wireless+bounces-18515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD997A288F1
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544753AFC61
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B6A15199A;
	Wed,  5 Feb 2025 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL89qgOo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53209151992;
	Wed,  5 Feb 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753582; cv=none; b=YFGYYkOQxMLYp6eT0IBXHURf9zgG36Po0CgrkaX8oedh08X+D7v7GzDksGWN+AM3Mg9XtQsS5x8JeuNfrfJoFAlJndwcSJf7ZP3fMX8XyjmrMU3KNsspoGnf3PQSb23I7HYy+6vHyBT0uaIPWwRauJQ+jYYduOPG+qr+sVl5itI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753582; c=relaxed/simple;
	bh=DcIeZrE0ASd5vx95sqQckwDlwUicHVVIRhJyQHvcw2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TYqqHsSIWtfBGM3o809NRVBS2/XZzX+Br7teH9Rf5suq3k1Xvce5bVQGVQgfsQqwcU7aLszBHGqkqoiPEm0fqP3BoRA9VAQMMlCYdBB44Bxn5QlSAVgYbWz+WhepQxX2gKYAw5hhNUpN/DhxYs89/cYC87MACAzbrsJ4ZYs/LSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PL89qgOo; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7515df1faso285515766b.2;
        Wed, 05 Feb 2025 03:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738753578; x=1739358378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EFvTTGlu7Xiejg+RENXn6LD9Xqubdth3nzEQ18VyCyQ=;
        b=PL89qgOozlplnHTNapCshJ0zDaRVM1i/9UU8kvCtI6QtEj0M90B90wqgt8NMNNQ/mZ
         wUWiPmX3os1YbB7pcCwmxLvv0bt3rmXguT7VZ8s6e+QVO9CGJsYyyFn7UBHp9d/Ud9d3
         OAjgwQUqnf/guc9umk3K89rr3eiK1doP4gVg2++K38PPmwSMfcqIezws7yeuEs607npk
         MuvebHJqZR0l2W4QbWG7fRdlr0OEaymafzk+/95FcajHd6bfV8+3GvnHwNg7Jh/rZ4Kt
         pnYauTwkqIF9oEppuVf+lniabZFG7xYgD3aQLNPn40krzSb6c31HpTsEgm2tIA2LDHg3
         XuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738753578; x=1739358378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFvTTGlu7Xiejg+RENXn6LD9Xqubdth3nzEQ18VyCyQ=;
        b=WDS0eFnw8VDgGuxAc6r1Etz6+XXNL7EH2fP2oaWIJsOxRU84lcOlWRdIG1Y0a86DCN
         4JANsLDUl0Hx+oBoKwZvmImFAx9aggNqEsqDpZLUzRnmqwCS6O000jjTP5F6Twrztzoi
         KeCPIrGnvu8H/9V88E9g5cg/xgYg1EO/Wqn0WjP0IJApGt+kQv6gluOW9oFlAK07I56U
         aGG4tM8HHDUKPExHIeqRyRSVdAogS7XvTW9cluAqhHkBUX8vQVK3HI29GQmJyEsHaHnh
         BVrT4qNTuZ0uWSAUXl23iKiM4qVih9DigKQsiW+h+KHECfSczibnFY2MtWE71Hfdw9Ce
         6F+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1n4kFF5Tt08iXo15I7HNcW1WXx02SvfIitxRHz/NFm3CjRVsbt935yvF4EvrEIvALDRw9owe9yWfnIkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZX/viVaEIIBiQq+TN/9cmMv7Dt9/CzeBa2BR/AO5SnBejay4/
	V4syb1J+QbqwzxKv09RYWgHhijL60FgFfUpvBzyQVWlWRgXsFFjq
X-Gm-Gg: ASbGncu1suZeOzc0s0SfOs3+0e+GVb+pDtjVuwC4uc6WT0LkyPBCsWbu7JvLOJG5mhJ
	0GwhviBc5BiVcFjD+ZDAwrzI0GXoOU/m9kjFfa3GajWWrz16A4Fheoaf/XYIcIsn1DP97CuyDKm
	t9jPG//NSrJ4ZYIhAXUZidOXAXwaM2FsjIN+mRYoekXAkON4Zm4mZNBLwPc2RZ0/DIZD7wD6l+t
	mJGbyUPHIerZjwLbe2Gav+wz0wgyMJaC9K3O+0DWclf6TyMa5qe6xMEdO+qbGap6uQICu60gaIA
	friAVr4BetAMFgNP0ivxPh5ITXEu8xSLxC9I1RX6XAeMHNWY
X-Google-Smtp-Source: AGHT+IHXrvo8JotKw9JqjHjM8kH2tEuwtzlIKz8RB0EOSkb5LyGMPbWWIfmxqiR/hGf1Ce6qe9p1Bg==
X-Received: by 2002:a17:906:794c:b0:ab7:5901:c6b1 with SMTP id a640c23a62f3a-ab75e2a4e97mr245670266b.25.1738753578355;
        Wed, 05 Feb 2025 03:06:18 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ff968sm1084391666b.111.2025.02.05.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 03:06:17 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id D74D2BE2EE7; Wed, 05 Feb 2025 12:06:16 +0100 (CET)
From: Salvatore Bonaccorso <carnil@debian.org>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	b43-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] drivers: wireless: broadcom: b43: Replace outdated firmware URL
Date: Wed,  5 Feb 2025 12:06:14 +0100
Message-ID: <20250205110614.216958-1-carnil@debian.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

https://wireless.wiki.kernel.org site now redirects to
https://wireless.docs.kernel.org/en/latest/ making the reference
information for the b43 firmware inaccessible. Update the URL to the
current location.

Link: https://bugs.debian.org/1095062
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 drivers/net/wireless/broadcom/b43/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 25b4ef9d3c9a..7529afd24aed 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -2166,7 +2166,7 @@ static void b43_print_fw_helptext(struct b43_wl *wl, bool error)
 {
 	const char text[] =
 		"You must go to " \
-		"https://wireless.wiki.kernel.org/en/users/Drivers/b43#devicefirmware " \
+		"https://wireless.docs.kernel.org/en/latest/en/users/drivers/b43/developers.html#list-of-firmware " \
 		"and download the correct firmware for this driver version. " \
 		"Please carefully read all instructions on this website.\n";
 
-- 
2.47.2


