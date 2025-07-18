Return-Path: <linux-wireless+bounces-25631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B84B09A0E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 05:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1229177A5F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 03:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB731400C;
	Fri, 18 Jul 2025 03:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGYswyYT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A017A2E3
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752808115; cv=none; b=cMULo5fRlVNFH3Z34THY9bXIKJZLzIaYeoThnJeOktvOdxj9nhlhVY3/Gzg5v6yYBc7IH8aSznZ/6TOkIH70ikmXWCI4eLIQ2AgJF7mNUiJotAzPmpYIfnUM9feIBpxNwQ/wsAVFKoqbhKSAAHH7URGNQPa47xStjnR/6H8IHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752808115; c=relaxed/simple;
	bh=VY7pZU06+nEgMd1eB5aka3grkVYW073bF1S+aedjlho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9W542Yt1FG3Uy5TQECljnc5DLCHwtZs6mQDOtHDARQMS6FgJz2BdTsnE0e5iPHmLevKUZ0jYkhuAgl5OgdeqRKA1unmFb+zJowtr0K3wX+PUuxeUzte+Zgy3cbIVgWWNoYDJVJHDfH7Tzl+pUU3Ccy7Mp05vKAK4qQ9frCFXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGYswyYT; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b31e076f714so1948287a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752808113; x=1753412913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gliDNT8UmrvqpL4JkSM9BrFqPID+dcYPsDKzUoYCBEY=;
        b=ZGYswyYTezmumwwLQGuq7G6hnBbjXtzA8lAqUF7L1eQWPzZGuv6TVbG3VHpRuEtcow
         In2FXoeWIoSHMYA6RQtZ8sXl13hWIBRWoLoFzQqqpGbTEJNJ98nIJuhVWvF1/Ew9yYpR
         OoB4ZUks+VN4fsA8UpaO9/5sJzr9LUZHiWEf9BY/4/mDU0EvNIobAQI/768XgxzGyI9i
         bfwTLxxaObIZeykbC9+uqAqQL6vx1ZWDFfaFfsxaa1d8wZDKB1V8v9TJQ3VjFvunId+j
         Yuy5J30jUD/1RvPSSRhRhK3XDmuGPoO7sjKTzc2OowWhLrmxWk/jmJJ0gM8//VdRGP0L
         vcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752808113; x=1753412913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gliDNT8UmrvqpL4JkSM9BrFqPID+dcYPsDKzUoYCBEY=;
        b=kYfsSSLtFmSmD/tAVI3vvbFo8RCC2Kl00c9hJx1TH1g8V+QiIW2bY9PoWWzWbLqNOv
         NjGjF/4RmXb54UZfLKGXoVx3Nm3ETaNSWOdGw+73owcp0JxSYdHU5qsdR5vuP5UZ/+/4
         8bfhS6yMVi1+tGNE6Obxls2ooG32QwkcL3CrbUGC6fP/yVoNZWCvaPaKNvTGUSa1eOpv
         WgayniDiU5fdL1H1gEk72D06z0kCK5JQsHg1dYOH2pgciI2vb1Mq5b6lAn1Hgarktyj6
         7Q2Q44zdcDzRDWZyaAWMXEQnfvN3lWesJRy1SppvmaqowFptk3W0djPRzPHWztXo0nvR
         1G/A==
X-Gm-Message-State: AOJu0YzWzkmNKPR/hVJfW+COxocV2gJpIJ+f5gQLXXHktEjsPxISlxC0
	aPkJkcmzKXj3J4Nhriem5Q4Ry4kzRMM75Bmh5bzmqFpHsu4PbXS1slnC
X-Gm-Gg: ASbGncv8vqhM0pc63Rph3GNlhEEHgCqRjF0j4/1symK+TsWHT1wsTV8rmMRen5VzUTk
	hden137KUFlnrt5NafCbIKpyavi6ck0I8x41LaOd4GsnCFOodbLCe8v263V8Vo2N5FXQeb/ZdLB
	6PP+ZSJCg33Je09m4f0PfxfwxjChkwLaQVKI8g8XGf7Uq+p7GCYsz5qOqT0l1Emohdr4deai9Bp
	A9DC6AMzzo6EF0BPhL25i0fPv0A0eDZ3rFhK9fCGC3pNHKOqrVqJOC+PwPCkbVCw9K6WZ8rUSHQ
	L3GVltOhN5CIWJGVu10fN8B4pNFFzGlU3pZRWZonmLV5h70O1CzkW5zzIh3rHFvpNFDllsltsai
	S6zERlt2VG0bOHktMG+9hf7n9NUTfWw/1q2zV5oFX5e8UnzMoqXabMiydvV75pbt3
X-Google-Smtp-Source: AGHT+IGX1RxEzDOyTjrxinqZXxreXvwXhjTUNtlBZU1o/JS9UqTvXFLmf1LA1aobDwIlVR4JbHakVQ==
X-Received: by 2002:a17:90b:3d0a:b0:313:d361:73d7 with SMTP id 98e67ed59e1d1-31caeba85c4mr8247747a91.13.1752808112634;
        Thu, 17 Jul 2025 20:08:32 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-31cc3e5b46csm275324a91.11.2025.07.17.20.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 20:08:32 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 2/2] wireless-regdb: update regulatory rules for Sint Marteen (SX) for 2018
Date: Fri, 18 Jul 2025 11:08:10 +0800
Message-Id: <20250718030810.17213-2-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250718030810.17213-1-pkshih@gmail.com>
References: <20250718030810.17213-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

By "Legal and illegal wireless communication devices" in [1], Bureau
Telecommunications and Post St. Maarten lists the allowed equipment [2].

With ETSI rules:

* 2.4-2.4835 GHz
  - max. power 100mW
* 5.15-5.25 GHz
  - max. power 50mW
* 5.25-5.35 GHz
  - max. power 250mW
  - ESTI EN 301 893
    * DFS
    * for devices without TPC, the limit is lowered 3 dBm
      (reduce to 21 dBm)
* 5.47-5.725 GHz
  - max. power 250mW
  - ESTI EN 301 893
    * DFS
    * for devices without TPC, the limit is lowered 3 dBm
      - Not required for devices that operate at a maximum mean e.i.r.p. of
        27 dBm when operating in 5470 MHz to 5725 MHz
        (keep 250 mW for 5470 MHz to 5725 MHz)
* 5.725-5.875 GHz
  - max. power 1W
  - ETSI EN 302 502
    * DFS: 5725 - 5850
    * The FWA device shall have the capability to reduce the operating
      mean EIRP level to a level not exceeding 24 dBm for ChS = 20 MHz
      (reduce to 24 dBm)

[1] https://btp.sx/telecommunication.html
[2] https://btp.sx/dash/files/Telecommunications/Technical-Requirements/10t98466434723___TGVnYWwgYW5kIGlsbGVnYWwgd2lyZWxlc3MgY29tbXVuaWNhdGlvbiBkZXZpY2Vzb_64.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/db.txt b/db.txt
index d2414810442b..56868cf58759 100644
--- a/db.txt
+++ b/db.txt
@@ -1867,6 +1867,15 @@ country SV: DFS-FCC
 	(5735 - 5835 @ 20), (30)
 	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 
+# Source:
+# https://btp.sx/dash/files/Telecommunications/Technical-Requirements/10t98466434723___TGVnYWwgYW5kIGlsbGVnYWwgd2lyZWxlc3MgY29tbXVuaWNhdGlvbiBkZXZpY2Vzb_64.pdf
+country SX: DFS-ETSI
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (50 mW), AUTO-BW
+	(5250 - 5350 @ 80), (21), DFS, AUTO-BW
+	(5470 - 5725 @ 160), (250 mW), DFS
+	(5725 - 5875 @ 80), (24), DFS
+
 # Source:
 # https://sytpra.gov.sy/public/uploads/files/%D8%A7%D9%84%D8%A7%D8%B7%D8%A7%D8%B1%20%D8%A7%D9%84%D9%82%D8%A7%D9%86%D9%88%D9%86%D9%8A/%D9%84%D9%88%D8%A7%D8%A6%D8%AD%20%D8%AA%D9%86%D8%B8%D9%8A%D9%85%D9%8A%D8%A9/%D9%84%D9%88%D8%A7%D8%A6%D8%AD%20%D8%A7%D9%84%D8%B7%D9%8A%D9%81%20%D8%A7%D9%84%D8%AA%D8%B1%D8%AF%D8%AF%D9%8A%20%D8%A7%D9%84%D8%B1%D8%A7%D8%AF%D9%8A%D9%88%D9%8A/L1.pdf
 country SY: DFS-ETSI
-- 
2.25.1


