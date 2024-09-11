Return-Path: <linux-wireless+bounces-12780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9B19749F1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 07:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511721C243DF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 05:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8D2AEF1;
	Wed, 11 Sep 2024 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmzRlnss"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED58824A08
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726033756; cv=none; b=Mwa7Y+ENj5TVhEbfZjvCXe04RRj80x7VG42m3PZ7tRZRSCzIck+JEef12SIhoC6ZgJw1KmDLMagKS8iWBFmSYxp8hYINRsApmOND4hJDNa0NlRRQeEJvr/yxZs1nNDHkMpWuuB/3oLMECwNZKdFJNFeQe+YGfQZislwfUn3J6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726033756; c=relaxed/simple;
	bh=V8CSa0+wRjGvyRgyfw++SfifgsGTHkRVWaiw8sgemq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ULkl8+zJmOKjCRUTFzScVf2M/26PW0t/DJUsS8DSHyAWqG2tOxhqRvSyPNhaz1++CFnrgfF9P2l+AH2pbYDgLo9XawE4up1Q0MHgb+nUkXm/qw7wOpayaWopYpGuSmwYWVTMQH3NXGVtz7iN5mZfb3tKAEhJZPg8D7GY91KNlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmzRlnss; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso4269765a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 22:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726033754; x=1726638554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bIuKARe3OG8Oqcq7F7hVObUiW0TBQcR2NzcfMJtwb7A=;
        b=EmzRlnssz/gQHn4cmp6wr6TL65EQyLUI+xy22cKAe6Om/+gS8gEtqiNCi3UTs9CbIt
         fi564IA4+yHkyPhlcMLAXiK5ZUBf0tCbdYY0mLVvKR+5HyNmgaPH4iIvUu/saLwFJ1DL
         Y1x7qH8zl5ajNTODaSGmY0J3V6rlv5oFo3+BQEAniJe7W6oX8amTFsO8zaNs0yGJKgqY
         NZ6bRWwusg5oh7+MYlkzn0kFGt5z2OV7+c35skDcsAKnMKBt8riYzV4mxlCbMH6yUPXg
         DmXCKnwTLA/6ydBvq+CIBh3VN/0Dk+qeIWBE+5FxtsHq/1cBDOOaqWiBC7WUDEUQFZS5
         8Kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726033754; x=1726638554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIuKARe3OG8Oqcq7F7hVObUiW0TBQcR2NzcfMJtwb7A=;
        b=cjuSvjKURJ3tWJEhy9Q+nks5uq0MD+LbR/uMIBqOH13WG7liLEKXfNUp/IUUHVYxqf
         e7Zd9OrwaLHGLzizr3OJLi88NiIR0tGho+D8tYkEl0W9sqV33PXNoEuEr5wRdZHhUye6
         1sNrSN8q3/ujk81rYpYUXhWKBqgl0CCG5RDT8khkFTIqWjUUCPqRtP98Lmo8TysLJXnl
         6bajwjGxDw8dh+7W7aN/N2srZ7PLebgrgTI0zxCixn7/rOcQmV7p6zuvTo1SquORmoGj
         JwUTdN0egemxR7q8Fh3WBOkbCbqoWLIuhIpAdf6hPdIKLfsN6ifwWaKIC2emz6e8hXU6
         BVFg==
X-Gm-Message-State: AOJu0YwND7HMxqxfn496okFRZKXlql/2WrqLYjRo88Jn5goBV5JHjeSe
	Leg4SLyJcpxfXhOnFQJnBCUm41oNz/jSFHzmUQrII1Y6HyfWgBeF
X-Google-Smtp-Source: AGHT+IESgqqIzfe0nh/cB/a9TNlRX0T35HszXFAP1H6qB/F3ScVnYMKrKJOTxURp1UZZHj05OOjTAA==
X-Received: by 2002:a17:90b:115:b0:2d3:babf:f9a3 with SMTP id 98e67ed59e1d1-2daffa3a790mr15804050a91.2.1726033754005;
        Tue, 10 Sep 2024 22:49:14 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2db043c3c51sm7517099a91.21.2024.09.10.22.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 22:49:13 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] =?UTF-8?q?wireless-regdb:=20Correct=20regulatory=20rules?= =?UTF-8?q?=20of=206GHz=20frequency=20for=20T=C3=BCrkiye=20(TR)?=
Date: Wed, 11 Sep 2024 13:48:48 +0800
Message-Id: <20240911054848.22003-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

As 7b of Table 3 on [1], frequency range is 5945-6425 MHz.

[1] https://www.btk.gov.tr/uploads/pages/ftm-teknik-olcutler-ek-5.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index 9a55f6b8cc98..947b9906f503 100644
--- a/db.txt
+++ b/db.txt
@@ -1825,7 +1825,7 @@ country TR: DFS-ETSI
 	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
 	(5250 - 5330 @ 80), (20), DFS, NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
 	(5470 - 5725 @ 160), (27), DFS, wmmrule=ETSI
-	(5495 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
-- 
2.25.1


