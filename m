Return-Path: <linux-wireless+bounces-32028-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GaXOxHzlmndrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32028-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 12:25:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B3615E40C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 12:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C206B3008995
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 11:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C101633EAF2;
	Thu, 19 Feb 2026 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="MbpBmKXr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sonic308-17.consmr.mail.ir2.yahoo.com (sonic308-17.consmr.mail.ir2.yahoo.com [77.238.178.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8233E35A
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771500302; cv=none; b=dcSu06/UuS8VYv+ILCZI4E2R2x3ivRKKzLqpmx9dVKl+pIpM3/nTquMEkjuiRMPLILr8c1qj/DVlLuPpBSrp9tkIMRhLEBf8/PyZSpjZnHR41pI0K8rq79Ys0r+Gd4OipwKMo7ufBte/xUnA7KUQDWTVvPiWCb8/ZD/jzcNekZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771500302; c=relaxed/simple;
	bh=OhSdwfy1FtG4ztzOwXlEkdBpe0lhi5439WS5nFTsDsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=XOgpcSZQV7ZiHgqWO3VSOKKA/EfSROERVGnEfyyOT4i/8Ar+BfwezY4dFOn+we5O414gSCwgIG6GyJY1yA75IBHxgVgHMg3PMRjixYz4AkYAtz7hMWBYjN6HG96zwth1LRWzdoegisp/mffZ88+QQQWYBmtbVs3sySRmphzFl7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=MbpBmKXr; arc=none smtp.client-ip=77.238.178.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1771500299; bh=VeJXZz8rO9UPaobGdDqzKgcsjS8fLwLcgWdV+vsQR9Y=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=MbpBmKXruv/zDdbryX2ktQIwER1JuidgNacAJ7JDrTopdBRQIUeEG/E0MMHVl1+4TvTjkFZ7rSk4c9LXbhuuBoyvELwkSuw3rP5cUvEBYEiDzcSfvowYXAMWuXIRY7Vng9UWAmHjuMOhVtmr0utPbfKKoICk4/rw9MREFP6yDwKzNvwT9dGn8x4uM8tv+RsVc3u1ac22OpjupD86e/6Y9aUplK1ZoTlKl3k8+01tG43BUVmD9PZfN01DFg8g/9IJgcfvvUClZIoiUNTkdlFVVkw2hbQsLgMoB8bKo/2abgYVKgnHE4cfcjm8m5qrSgQUH6T2PBMkzRm4wPGWOBCcyQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771500299; bh=4Vpz+lDepeD7YwqoMqUIOOFLJCJ0aE5tzmr+CtuNhg9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=foJjJYtB5P4+lGiblkW34U9AzuTjTMGtOgQSGbsyazrbllDpd6ZY4niDAaXzo5FpEpsyjw50DzuDRBH60htLHVGfpkWMsYq17fhe3XzOf+zIw+rUUElNfR3R7AVXQov/vfUUNX82b8BdO1Ur1EZcssEQ8nt+GIycEl2nYlsf5cCLJdZ03UDqYvKq8af02ZJOwSozJnA3tH8ZLjDhSMgefLjdXKzBb8ZY5SVGOTWNLuBFeiFvuAESuqL8ZSKuZnRlRQCqOYStU7NrSOuZn8Xf6DzIvJTlSiFXJuoTfy4Wt1EcQEOMsuFBK7QH1SSH44+jLjyzOUBQemhjSnWYRmFM4A==
X-YMail-OSG: 2C0oKscVM1moaV20UbmspCSGyhtzNrq.Gfh3fwGjMXFy6Cd4nJ3QSP6EqNioHya
 YGwD20izixMKypIerQaloX0oEB50nGtsgYMpg8lesUNDKBiQjBCfFL_WXXDRLtjtaeZTUb63MtSn
 D9m81esyAUIjNBQsesLncuw52wEpJheixLe9g2wOnFMvSCgDjwYHC2_1wz74Zq1p8xPiAFftkG7O
 sgURUqSxO_YhTUQgyjiMaRaztT.cYaGtQ4S8P1P3LomOp8yFbhWA277YPPO_w2CBDX85CO.jgZj8
 IpVdqKZM7Zf7iE6VQ78rKsE7u4zy._jf8y9ywuLlzOcwewsmsPDGxrRho8yhCGJAFv71DOZ8B6zu
 MBSCSAz_qoE8.d7AWmvlQ4sfP.v8s0fshxbnfG5LcFlideLBIPnJG0pxGpRnOTHd0Oc0ND3w4k0q
 INGfzLCPiM_i7jGCkUHF4Uge_.AdzgQwOnLEAluVFOD8yY08OPsdI.WB2q5EGpJ48Z054CQajKRU
 XhkSdiEN.Kud3n6LkAx3JMev_uBB8.nIYu5O1YkUsJ2u1JQYHTbp7TnBHYVTovFOVn9r_4VzBf.x
 Gistzu_Ro4y.cSjX612fWB7rFyBccnLci5jhHT8kvy9u4gJJtRkGaNcXccG9ifdCoTQeFjvNCisR
 2eeO8vfn0rfnmBV2NeIuhFQIQYyyEaWi6vkoEcPUSYAIJlZtQ9rQHmViLYc6qgKEiq6qmNHM9wzI
 eTY91XUc34d.eqtTEQwAcydW5hPfufPHPp5Ck7LiR7pO0d9zxYySSRbXrwarN37zZik0Vjhyuxbp
 ikvjY5S3aFYr0_7y6c4g02esgQ2mUXuPWWwIJn0FXSSr.lJvfEOqTGnrOBMuDZfchs7udcZsdqty
 NG.YgYzmLHazBu6i6vOLzBa16aEisHwF6vKDcKR3tbDKxWQahFcz5Ov1ogk8sdlnzUe55JwsLP3M
 DDbyJSS.5RjCRlsjmPNGlVyle_q6ISuiRNTW4i4Yimb299TxdFU6HbZKArEjspfLEDNGoJf4n6xa
 doHtT.pbMWT.KNWqB2BphsPzwAZevqyyszDCYJMOg5m.01DOWgzJsDImxtXr1BfFStQe1XSl8bTn
 FpO4JgiKCilX0cRi0b2nq1IsoQEY31SL.amz1ss2Tki5l.aoaXs212puvXRq7ZH7v4VSRHt2lU.4
 hGZr9iC1r7XlJAAlHorF1nEfJhAORAHvqLfnG60djxOot8xJRqdcO6KEhTYua8UHQADUcgHnUlls
 NvpC.4M_rOAcOas.1OJNarqbZNI2bwa8EfzUjDkxXkZrHd07LIa2UCtS0vrBje.EXDTsEKdx3rJ8
 TF9A0jqHmom0BJdUIZhwvXE_3ESmiYkbBEqrNRD0vy9D20d8k9Sqm3mRaHcHpXXiPkXHBMvtWbn3
 i0rtJyMwjq4EsyyUPVuA3PzpzeGHPjuQ33IJo.iesJAA7yhQpOvsXbNzif2QoP9k43Xxsq9NrmF5
 O8aXBnVhYNEzjh7B_OM60yyGGj5YlzS_RCpCeZwQKhN8R0YddfnCRmkJuXsU9Qfzwu2aA41Skf07
 XB50y6TUN2.sJb9cHa8Gioc9SW4DpTa1dq9fzUjHrl.pp6eqC0jrorar1DzzwoSuvzr8SjlkohLN
 04p3lX.wwRw26ZmH4Q2jv0zxhCVo1qTzKFXsKCvpkkk60yMHvJGUZhrvKR0Lv_8qT4ZlmhT32U_5
 kvUydPF2scRCj.BWWejTTDJOdcVeDHYWUFFt1gU2_wGhjt4xUi8eMGm1tkJDaVRFSdCBElxOi_XO
 Z7a.2h7TNKKAU2baLQXtxBVn5uecYLS5t.qRo.CZJil_X_muJMZkgAMrZfAtQd6D_wiKXHJYXs1w
 goDguCcIgWqfdUw4XqXdSk702HLLwVEJF6.jwjd3AqHhdAhOHZ7Pov.whneua3ncWZmCkn7DbKWS
 rHFt3mWge2IJ3m_Ym0XuoeF2vOcSADNBHl_ABS9q52J_c3OycMXPof64gKUzr.upv2uSM.MBdF5o
 RuBfMIM9Hh8o0L2N5U0E4cYFFk__sV149XTeH4jou6VBVPJArP.EEQP.XBgSuzz8sQbPog2lQfKu
 6gudJO1bnOgu3zQWZ1Rj8g4q2u.Bx6r1vLBA85cc9McUB5LO7vBbbAW49_Y6DETBUAN5GRD97vYw
 SYfeTLSb5OkxlWD1.89etNUnf.g0bkRlSooyv1V2b_x6kERNz15gvOhI4iS1uPkrA_asOHCsl0qf
 WxRhaRjdPQ3ANYcbPFsX7tkiSabFuU11TWCPEKaAX15D0uUhKDp1ueBJBFZ.uTurrDCi40JW5BCQ
 tBXI-
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: aa63cefa-ee54-44b0-b215-8774486a4a4f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Thu, 19 Feb 2026 11:24:59 +0000
Received: by hermes--production-ir2-bbcfb4457-f49j6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID baf2b470e72ab17ac553910279b9b1b1;
          Thu, 19 Feb 2026 11:24:57 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: Mark Greer <mgreer@animalcreek.com>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH] nfc: trf7970a: Fix spelling mistakes in comments
Date: Thu, 19 Feb 2026 12:24:54 +0100
Message-ID: <20260219112454.46841-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260219112454.46841-1-tomasz.unger.ref@yahoo.pl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.pl,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.pl:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.pl];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32028-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.pl];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz.unger@yahoo.pl,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.pl:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yahoo.pl:mid,yahoo.pl:dkim,yahoo.pl:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95B3615E40C
X-Rspamd-Action: no action

From: Tomasz Unger <tomasz.unger@yahoo.pl>

Fix spelling mistakes in comment block (lines 64, 69, 72):
- 'recieves' -> 'receives'
- 'recieving' -> 'receiving'
- 'recived' -> 'received'

Found by manual inspection.

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
 drivers/nfc/trf7970a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index d17c701c7888..c3bf48f49eca 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -61,15 +61,15 @@
  * support that.  So, if an abort is received before trf7970a_send_cmd()
  * has sent the command to the tag, it simply returns -ECANCELED.  If the
  * command has already been sent to the tag, then the driver continues
- * normally and recieves the response data (or error) but just before
+ * normally and receives the response data (or error) but just before
  * sending the data upstream, it frees the rx_skb and sends -ECANCELED
  * upstream instead.  If the command failed, that error will be sent
  * upstream.
  *
- * When recieving data from a tag and the interrupt status register has
+ * When receiving data from a tag and the interrupt status register has
  * only the SRX bit set, it means that all of the data has been received
  * (once what's in the fifo has been read).  However, depending on timing
- * an interrupt status with only the SRX bit set may not be recived.  In
+ * an interrupt status with only the SRX bit set may not be received.  In
  * those cases, the timeout mechanism is used to wait 20 ms in case more
  * data arrives.  After 20 ms, it is assumed that all of the data has been
  * received and the accumulated rx data is sent upstream.  The
-- 
2.53.0


