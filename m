Return-Path: <linux-wireless+bounces-20666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7DBA6BBE4
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 14:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83DE18921BA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1243022ACCE;
	Fri, 21 Mar 2025 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Vr9eWwg5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B622A4EA
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564622; cv=none; b=XIqL7Q4wEod8SCfKxDbMBc2eBa7026MpdSUXlS9G86PLydv7vfNRM7QktH8jjnvstY0TE1mr1V6+1AlQylpIUBdBbxF2ds+cUiD80ulWZKQHXbMTDAKmyBVDoMHS9A+eh7e4bSJlU4DoZ7kg3E/1IbwlkIN35qfSRLp6Kk35wxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564622; c=relaxed/simple;
	bh=cwaJwjLZUAMsf/xTeJRQucl03eWT7lIUyz+rEq2U1gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUwiILpZasMOBBy9wwKP/ydszvfWiCO0z9t3jVoWikyDWVBRAlC48OZfYQjtKZ4Wf5pCWEQ/7q9DHl2AoGhPYi9kx3+NanvbasxLcYB44e87xJzeYjnJxWolwRGj/PuYvsX1Nh0ALfuziLCkzKTjKOF+qtzYuTPmG3zpN3eU1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Vr9eWwg5; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:12a5:0:640:7a62:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 7C13C60D43;
	Fri, 21 Mar 2025 16:43:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ShLsDuALnGk0-XcHbLRqo;
	Fri, 21 Mar 2025 16:43:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1742564609; bh=e6php5jmNZjQNzfTTl7zzmkVf4f3WLm0I0zrRki1yHY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Vr9eWwg5L/PwxsC0TOuxccwKvZ1Xdij2abDEFFViTi7vUEwvGjwKliS+NMDfQHvB3
	 geFjYzDLWgmcuXK3ZAp0GAct8aI+iSzuDWiAfKuatoPKvvPlGZWZLIkcIXSRYHmEgK
	 hI9E1XijBp9sYDUmuPcJr/vxqxCJ+96NZbjg3REg=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-patches@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rt2x00: remove weird self-assignment in rt2800_loft_search()
Date: Fri, 21 Mar 2025 16:42:56 +0300
Message-ID: <20250321134256.821596-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove weird self-assignment in 'rt2800_loft_search()' assuming
that it was just a typo. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index e5f553a1ea24..b7ea606bda08 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -9393,7 +9393,7 @@ static void rt2800_loft_search(struct rt2x00_dev *rt2x00dev, u8 ch_idx,
 				   p0, p1, pf, idx0, idx1, ibit);
 
 			if (bidx != 5 && pf <= p0 && pf < p1) {
-				idxf[iorq] = idxf[iorq];
+				/* no need to adjust idxf[] */;
 			} else if (p0 < p1) {
 				pf = p0;
 				idxf[iorq] = idx0 & 0x3F;
-- 
2.49.0


