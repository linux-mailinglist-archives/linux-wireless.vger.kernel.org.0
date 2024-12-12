Return-Path: <linux-wireless+bounces-16318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 344159EF225
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7DE1899652
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62C222331F;
	Thu, 12 Dec 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q50aHnnx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC3B53365;
	Thu, 12 Dec 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020829; cv=none; b=OBDTi7BmSZ4X6zSwZv8ueUOK0KaElSBklRiwxHbotGCYChjwU0/+V8fYUCnKAvkw61d2UxJJU9dA2Ottc0bcSlBbETYFLmc+lH8MHz3crQOxlGRMaiMlMao2hQ50jroKPuRrcPw6TlOAVV7nU+O5MHXBb6tw1Uzf96ZqC/JgBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020829; c=relaxed/simple;
	bh=aylyeHh2ioU3mzHBEyMiITqzanaYnxRfLoDoL/eQJ4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VxE6z5h1PhHKARtbgpLMNxgvZtUfV51F7Kk1p7FP2M172iaFzSL+XPNYMuHIQizi7JCiFKSD6ykzRQFtmfzM6KRCC1n5B3CE5+t6YYui/vkmjDcJXMvsIQL33++EiZQuHF5qE7ECO9+V2x5NRSObViw++tDULUfp9zWToHdyS80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q50aHnnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56ACAC4CECE;
	Thu, 12 Dec 2024 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734020829;
	bh=aylyeHh2ioU3mzHBEyMiITqzanaYnxRfLoDoL/eQJ4Y=;
	h=From:Date:Subject:To:Cc:From;
	b=Q50aHnnxKygWbUxqYCm30VrNup0G50ubLKnK2BQV3HTzWLGUXV0g5Z8nslne8gxGf
	 aWveWXMOC2I572nwEJy9y1phYmgSYxgitNIyWL96fmFXLzmOl8he5jCUendYH5tPJI
	 A4LCgeeexHyp73w1tNfQivn//4IMtDpd72HIUhe+yXJu7HUuIBPDfZ5vWOBhmmBHPM
	 QKuQisfF4dzIh6HI5RiEcrp56BZtsE/p2HK6UEjTyxebLhd7uug4zjThEs6qeFqPXA
	 4hrIQ4TVM4h+E+sbnqr8eip3pqJhYNpbSjpypgVyOw3bwtDtJyQzU81TMSUW303822
	 ux2IH2v3NqHew==
From: Jeff Johnson <jjohnson@kernel.org>
Date: Thu, 12 Dec 2024 08:27:05 -0800
Subject: [PATCH] MAINTAINERS: wifi: ath: add Jeff Johnson as maintainer
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-ath-maintainer-v1-1-7ea5e86780a8@kernel.org>
X-B4-Tracking: v=1; b=H4sIANgOW2cC/zWMwQrCQAwFf6XkbGB32wr1V8RDWp/dHFwlW0qh9
 N+Ngoc5zGFmpwpTVLo0OxlWrfoqLvHU0JSlzGC9u1MKqYspJpYl81O0LA6Mh9BCAmI39Gfy6G1
 46PYbXm/uo1TwaFKm/N38azqOD1dWwQp7AAAA
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

The "ATHEROS ATH GENERIC UTILITIES" entry shares the same git tree as
the ATH10K, ATH11K, and ATH12K entries which I already maintain, so
add me to that entry as well.

Signed-off-by: Jeff Johnson <jjohnson@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17daa9ee9384..18059822a350 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3608,6 +3608,7 @@ F:	drivers/phy/qualcomm/phy-ath79-usb.c
 
 ATHEROS ATH GENERIC UTILITIES
 M:	Kalle Valo <kvalo@kernel.org>
+M:	Jeff Johnson <jjohnson@kernel.org>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/ath/*

---
base-commit: 4d762e0043789e3608ad28c102131b232bd04377
change-id: 20241212-ath-maintainer-903ea0e14956


