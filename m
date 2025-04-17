Return-Path: <linux-wireless+bounces-21638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12949A91D9F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4427F4410BE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6745248887;
	Thu, 17 Apr 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TNMKyZYk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qmZ5eJ2J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F624500E;
	Thu, 17 Apr 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896033; cv=none; b=WSb5Et+z3BhWyt23MYt0bdhI6ttk/sgPpXG3lMIOl/6AGIhWbmY7WR2bKL0u+Zt97eNASrpmlOYVEHKw1P8I3Ld38mgjR63kOB0c+PEBj95+ftGpDuauwLgzBCejWicygyVKDGUIsOe9BpTOT9cVa5wGqKT1VmsCkP55XR+ixEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896033; c=relaxed/simple;
	bh=OPNAC8Z0G8ITTpc1DdLDRC3Y4E82qIDfQhRitc5zvvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPzrcV8yQxMkzpq+C8eBuqrgnNDrHmgcXxsenytED5s7fH9rOLODeibwitJUJFFiPtNyMdIPwNlYv2kGIE/3XPju/WDvCxDj3yScd9Ejj35se2JzwyVh5BnQld/8U8lgXPZ2WEVAZu5tV735DtuM9JOb9XxOSlC7gLNoEO6YJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TNMKyZYk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qmZ5eJ2J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744896030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wl2sntL2foeXMHL68yZgS6j+JHjIlWFLQNY02bMKsA0=;
	b=TNMKyZYkQFCGx2hlGy222xN+FSM05lqYzc9pkB40Pkfm4GK62M6Pw+SyfP5vbk5GiGUH0Z
	QfyCYye3jK5B6KULY93cm/HodU8W2ttU0DpwNQIIQLEX7P8mo9o6/dLtlf+f3bRozAm9yE
	KRsyDn649Yds6WaoxiLfb8/N0RAhqooUkSq1L1XEUypxXDi+f8qCY/aI9hkl+f09KwqRgv
	Oh5oC2IBwb7oHqGyGvuhrSXLWdqxCEwt6425X3Al8gOJwuXC+DwDjL8hpFk2seSnYF8wp2
	CSFqc2pbJafDIno01pJJCH8DUCg0SdZhG+k3C/fHx8uPRpAB7gHorUdIJpNdFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744896030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wl2sntL2foeXMHL68yZgS6j+JHjIlWFLQNY02bMKsA0=;
	b=qmZ5eJ2JxK+q0AnKD+06vInxzCTLBW0rJFJbzJHcfKRjvWEPBo9Ljeo8tW5yud7+SCR3Mb
	73wS1UuLpExbkpAA==
Date: Thu, 17 Apr 2025 15:19:10 +0200
Subject: [PATCH ath-next 4/4] wifi: wcn36xx: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250417-restricted-pointers-ath-v1-4-4e9a04dbe362@linutronix.de>
References: <20250417-restricted-pointers-ath-v1-0-4e9a04dbe362@linutronix.de>
In-Reply-To: <20250417-restricted-pointers-ath-v1-0-4e9a04dbe362@linutronix.de>
To: Jeff Johnson <jjohnson@kernel.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, ath10k@lists.infradead.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 wcn36xx@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744896028; l=1588;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=OPNAC8Z0G8ITTpc1DdLDRC3Y4E82qIDfQhRitc5zvvE=;
 b=T9JbjQdhxZNU/5ra4J11M4K9RgxRQecAuFkyV/yXCB395zBURy5tiBfy5Y2S/5H8Fwnlxqbzh
 N3oXHE6uPafAuOx65sdfN4UN5MCYPBHgzjjQ0yXzQcuzxd341OlPjft
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/wireless/ath/wcn36xx/testmode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/testmode.c b/drivers/net/wireless/ath/wcn36xx/testmode.c
index e5142c052985ddf629b93d7b9687e6ba63a48e8b..d7a2a483cbc486308032709a99bba9a52ed0ff59 100644
--- a/drivers/net/wireless/ath/wcn36xx/testmode.c
+++ b/drivers/net/wireless/ath/wcn36xx/testmode.c
@@ -56,7 +56,7 @@ static int wcn36xx_tm_cmd_ptt(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	msg = buf;
 
 	wcn36xx_dbg(WCN36XX_DBG_TESTMODE,
-		    "testmode cmd wmi msg_id 0x%04X msg_len %d buf %pK buf_len %d\n",
+		    "testmode cmd wmi msg_id 0x%04X msg_len %d buf %p buf_len %d\n",
 		   msg->msg_id, msg->msg_body_length,
 		   buf, buf_len);
 

-- 
2.49.0


