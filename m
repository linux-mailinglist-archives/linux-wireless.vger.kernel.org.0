Return-Path: <linux-wireless+bounces-10004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585849281AE
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 08:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0C91C2269E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 06:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014F313F42A;
	Fri,  5 Jul 2024 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joYSe0VT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D169913C69C
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 06:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159596; cv=none; b=QGqrEh/LnaiIn60BTdzvFXaqpJiy09QwShze0tGXy0fHPKn/+MSmnOKi8XPZukAIvFc7Yek7MqEwIwC7VLnJqeRkbgaSHDmyyauK/m2J+drxknkPZTYyuqD9iushVvs0czPf5lROjxGKb3XEQVRLHJVB5hjl+0VTlsh4X1kMvBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159596; c=relaxed/simple;
	bh=tvuPPOk2+l38Js+RGqqML8hNKZInclMtr9qpUO8xp+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zl55oQaLn/B9jzLf608sirCuwaA96JWEk9fLRpxZ3x4og4XmxeCde+pb3JigzANpCWUit6Rn4eM8PcOoNS2nGhsAKxGbwzyoApyJHxujePNtqIQhDA/OWi0K9Ok243GsKazBNpK5vNRZ+kpHqZx+/JSu/s9FpRX1OG30nHqgWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joYSe0VT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fafc9e07f8so8400905ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jul 2024 23:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720159594; x=1720764394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQvaQaAQdlAP66w3G8RuUGqwHRBtrQaO1GdIa+ZsF+E=;
        b=joYSe0VTeq+Aklh/YmQ7zFIT3/sfr8T+OrYCOsUsHuQd4tUJrcZiOIdknUxwyz/5Lp
         ENst0wuEEspImmgGf0asbtQJHSUa+9GD+tp6ipio2kIF73Q6fUgydNp0+7RGqU1pN+lP
         1HXAMwnzOWgqgbOB28CA7CtRfyBa8m4wJ1hOJQmNXUrbcMWCPLDmmJQ71IXVTssPIqeC
         yS7SZaXo7mL0iS2NfA6TjxHxcRoqe2tN0/TRqxEDfcKyt04o5gKURMM4GBLJPA/sLVnZ
         9XyWoFbQ++QlMkFrEkXJPRWCdbd9EWF9tdF/bQCrtUkfvpAyo8KCXxDDQ2RZzVBOlo79
         lZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720159594; x=1720764394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQvaQaAQdlAP66w3G8RuUGqwHRBtrQaO1GdIa+ZsF+E=;
        b=ETUUNhb3Bb6jYzOyHmEqA8BGT8z1VYCVIXgE+kIeK8j1WtGm7+Gf28EoiV8+xc+5f9
         dZSCWYFRfQdTF0hlH3SshJmB0uT95RogvVx8kyktf0k6NGNBfk/kQjX5KZnF2JIZ0Cj7
         wOCulZmSZSJvYC/5y424UWiuQ2wZc0VEbSp1+1nQ9Omi6XHk80BrsRGwZNkzmQBq+bOT
         Pnyr+LWn6L/i8797amwl2v8XutO7lYWlkQ5LfFGInigAA8gEvDy1clvWAziMoSeKVM4p
         eCKglqej2Rh0+h62K3fTt5v5h+Q+dPqLx13XzEB4D0yIG3VR0F/GeOnlyopViLO57bpP
         Ncaw==
X-Gm-Message-State: AOJu0YxDl4aGY8sa+a9hhLKQ0bCGzbcsGx2NIT41DzI3N8GrCB4Evyca
	8G4BkEQeHKQquXBFygQOZjDiWiHL/bO0j7dolbj6CM/b6XAuJ4or
X-Google-Smtp-Source: AGHT+IEDRGyhhcp7focnaTZk7ODz5BDHXv+ZmNW95RwPnBioGRTnqivt7+OiZOh1sjlSUhWRk4dPhA==
X-Received: by 2002:a17:902:f791:b0:1fb:1497:c304 with SMTP id d9443c01a7336-1fb33c81731mr30403435ad.0.1720159594129;
        Thu, 04 Jul 2024 23:06:34 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fb4e7c31afsm4644645ad.2.2024.07.04.23.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 23:06:33 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 2/5] wireless-regdb: Update regulatory info for Peru (PE) on 6GHz
Date: Fri,  5 Jul 2024 14:06:10 +0800
Message-Id: <20240705060613.28909-2-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705060613.28909-1-pkshih@gmail.com>
References: <20240705060613.28909-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Ministerial Resolution -2021-MTC/01 decided

For the band 5925-7125 MHz, low power indoor case of use.
 - access point
   maximum EIRP: 30 dBm
   Limited power spectral density: 5 dBm / MHz
 - user devices
   maximum EIRP: 24 dBm
   Limited power spectral density: -1 dBm / MHz

[1] https://cdn.www.gob.pe/uploads/document/file/1861732/Resoluci%C3%B3n%20Ministerial%20nro%20373-2021-MTC/01.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 266ba2d48731..2e862b322f13 100644
--- a/db.txt
+++ b/db.txt
@@ -1443,12 +1443,15 @@ country PA: DFS-FCC
 	(5725 - 5850 @ 80), (36)
 	(57000 - 64000 @ 2160), (43)
 
+# Source:
+# https://cdn.www.gob.pe/uploads/document/file/1861732/Resoluci%C3%B3n%20Ministerial%20nro%20373-2021-MTC/01.pdf
 country PE: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (17), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 
 country PF: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


