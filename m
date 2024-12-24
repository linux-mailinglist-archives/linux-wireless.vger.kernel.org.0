Return-Path: <linux-wireless+bounces-16773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C86529FBFB1
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 16:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E690163A58
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 15:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDA51C4A34;
	Tue, 24 Dec 2024 15:33:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67941BC3C
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735054418; cv=none; b=aze3S7UCNKkWWFK+UzAKCBuX6ZzYmT1AKREQrk+TGbsh9JZtmfcr9VIXBoS+j77DAfMuTlkci+Ws2oAnlA6e6aYa4zVls2m4KOkazhZa/zHwpiYjR3QVXZJZHmtRVEedG0bYJlLeMBjgSWsrGQgxNPkJYLbKR7pCzTyJJQY60oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735054418; c=relaxed/simple;
	bh=S4BFXpK4uLU5Evyx7c8UHNwbUwYjPBoyLLSXF1Qo6uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oKIySq1MmdvEUYegF7wS9+tuLcUyNNaDqXICpyawvu5KW+ZyY4xhFs0+9o3EA7xe9zlPt9zpsmfSS10Chqn6jVbCoquTnFUg65B+8bYt74KmdAVlPZtftJWR0nxT7uNKaS57B/p84+wklEYuZEPqToPUlK/3aF9BAvj7Xzx3ABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rainwalker.ee; spf=pass smtp.mailfrom=rainwalker.ee; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rainwalker.ee
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rainwalker.ee
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <desu@rainwalker.ee>)
	id 1tQ6uS-004pB2-Lp
	for linux-wireless@vger.kernel.org; Tue, 24 Dec 2024 16:33:24 +0100
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <desu@rainwalker.ee>)
	id 1tQ6uS-0004gd-3B; Tue, 24 Dec 2024 16:33:24 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1227212)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tQ6uE-007NoX-5u; Tue, 24 Dec 2024 16:33:10 +0100
From: Veronika Baranova <desu@rainwalker.ee>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Subject: wireless-regdb: Update regulatory rules for Estonia (EE) on 5GHz
Date: Tue, 24 Dec 2024 17:33:08 +0200
Message-ID: <2968514.e9J7NaK4W3@nakatomi>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello,

The current values in the database seems to be out of date for the range 5470 
- 5725, the max power should be 1W instead of 500mW. And 200 mW in 5250 - 5350 
MHz. Also, V-band is permitted up to 71GHz.

diff --git a/db.txt b/db.txt
index e282e3b..2ada200 100644
--- a/db.txt
+++ b/db.txt
@@ -618,15 +618,15 @@ country EC: DFS-FCC
 # EE: https://www.itu.int/ITU-D/study_groups/SGP_1998-2002/JGRES09/pdf/
estonia.pdf
 country EE: DFS-ETSI
        (2400 - 2483.5 @ 40), (100 mW)
-       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-       (5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
-       (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+       (5150 - 5250 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+       (5250 - 5350 @ 160), (200 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+       (5470 - 5725 @ 160), (1000 mW), DFS, wmmrule=ETSI
        # short range devices (ETSI EN 300 440-1)
        (5725 - 5875 @ 80), (25 mW)
        # 6 GHz band
        (5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
        # 60 GHz band channels 1-4 (ETSI EN 302 567)
-       (57000 - 66000 @ 2160), (40)
+       (57000 - 71000 @ 2160), (40)


Related links from Estonian Consumer Protection and Technical Regulatory 
Authority:
https://www.ttja.ee/uudised/ttja-ja-keskkonnaagentuur-teevad-koostood-et-peatada-wi-fi-haireid-riiklikes-ilmaradarites [20.02.2023, in Estonian]
https://www.ttja.ee/eraklient/side-ja-meediateenused/raadioside/wifi-seadmete-kasutus [in Estonian]
https://www.riigiteataja.ee/aktilisa/1170/5202/4018/MKM_m15_Lisa6.pdf [in 
Estonian]
https://www.ttja.ee/ru/chastnoe-lico/svyaz-i-media-uslugi/radiosvyaz/
radiooborudovanie [in Russian]



