Return-Path: <linux-wireless+bounces-18262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4650A25045
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Feb 2025 23:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AD23A4FF1
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Feb 2025 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980072147EE;
	Sun,  2 Feb 2025 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE0ONuE1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9312147E0;
	Sun,  2 Feb 2025 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738534251; cv=none; b=aWPF8S8DyOTMjU0zNKWeofDlvuBeX6UgC5ucB79XHA+99ItWQ2SoR9Ij+A+22wjWFji2uc0nsfK5L9l4lRscrFpvgL+3OWgOIoOlHNCNJj4ozdH/tfpbhf36nVE2kYBP/hm3SiArNQXQf6ym6SzrK2HWq6erLx9QRJOmA64NcdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738534251; c=relaxed/simple;
	bh=FaEmi+6h7TIJACu14O4Pf5MGspXNITwVUwkiqHw9l8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T0i57wsnyDfLMuaIcAZ5RiolXPpDG2CmKkCTT2GoF4K6h5AXlTv9zcei7e4ZPPFiHvZ9scl8cJkUeS2u9j9w9abFznYVFkrlj+r4nrodxVegDe/s4vH0YUMYegrtpn3f7NbrdR0sGJgcR7D75Po3Cnpy6+aOAzxITyhJufSJAXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE0ONuE1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43635796b48so22776835e9.0;
        Sun, 02 Feb 2025 14:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738534248; x=1739139048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nHE1WI8JJtx+KH2t3hCmFP2Wx+WtulpUrLsLx526dXU=;
        b=FE0ONuE1aCrr6V94RnLoiIjzGCR+4+bCHqOaJJLL/0XZ0m2BHmV6E+lF5pL/az0LVj
         SGchsUrSoT4kNWru6yKQ0xHDGBrYkyR/aoSj0m9RuH0P+lzavbhF3qnhfU1N/fZjUdDY
         DFUYRP0xlFrDYcGPH0kexGkRk1vOIneRJXv0B2PyejAZPwcbuZhktgvvsv7xa5IO0LWE
         HsRBCukVhuc1UE3HvXZ0XqfrxfKC9W8dLxqumGmp4K4/B7JCmax59wnusMnptrEaBo8h
         XunKvs44VpT4MpKlTV2ekJfz0OBqSMtXXBMbliH84x4IF9FdtNOBPJoar1J1dp55LFUj
         G27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738534248; x=1739139048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHE1WI8JJtx+KH2t3hCmFP2Wx+WtulpUrLsLx526dXU=;
        b=qZqSFyCo42NIEeLeH/N6T2Lem1IOFX3N6I5YgmSHCJA9tT/AHSXEpXYdqqsh2uxHyt
         4FmnUsMedAX+e04u2XcMW6cTGhzrzU1c6HO7460QpgZ3F/GLCO5SZMeZfmp1gPpWZV8l
         GV7xXa8NG8+qcosl2Lj7ggZmSckcIsZhldfY87/lmkBtudczNYFlSy0jFR7EvBsUiGkb
         Cus3zogm+C5+ogOM9usPYLakE++32FFoZ6TmZDtsNjAmywSpfxDnnS5jPLrH2/lgPNBJ
         Z/LjKvu4Gvaavq/4Atw+zYOXrg4mFds9g3pmYLm2JJspYIpq1LEj3pQaum70iy/iIdZR
         9teg==
X-Forwarded-Encrypted: i=1; AJvYcCV8YtIZu/50WOIzbiy7sq5U1S9TtX0jimatNbX5Tv7jIQ0vwx0nk9Seyzekkqhe+vKvZKmbM+3LUryWaZo=@vger.kernel.org, AJvYcCXFCbYhLgNGnAumERcbrG/I5lyar5GnfCS76R+cd5wUGCVl+4L+xePJEoz3u0rI0EEqEYtG2cKTxDVnZBAHXns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/LC/gcZVYc9tu9vp7T1mAli9ZiSc5c1hvHTwu+qGA+AZBgV9
	W2+4MP+1NZR9f77WLW+okKNkcLS0WulkkYbr0/rhPDVUO6RklT+W
X-Gm-Gg: ASbGncs7wXO3resgn81FjJxp4vPN6hNCw5+Z3xO4qbQzsQwESFXW24P3f3G1hJqY1lG
	cBHyRq+ySSwIwTYXEw4iBvKFPoeSqhJbhQOPEwNgG2mpTVy8pWEZh7mkgIWvfEzfI2qDWxjHFEq
	Zb3zaKg0K7ugMfDMOvJO35GS7y5q0chiM1Ex4TAcztt2pU6nfNCCHcsr1GX519VBwgCv/+ZLI4U
	x4YrISIgCKvXp/Lj7nFk9doXMqSjmM/8uOHrTSe3pDDeQfWGZS+pLeXX4IVMl5FLt/5ttnFHVdZ
	KHBLX8OOwADPZABb
X-Google-Smtp-Source: AGHT+IH1yqeybl1qfGVSRSeC0kKYYqcUHp0CD3q231k5KY4NO9BcQBJ53/3WRqSPX9TEy3WXt69fgw==
X-Received: by 2002:a05:600c:3420:b0:436:1af3:5b13 with SMTP id 5b1f17b1804b1-438e6f11aa0mr89680255e9.15.1738534247951;
        Sun, 02 Feb 2025 14:10:47 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38c5c101599sm10799779f8f.23.2025.02.02.14.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 14:10:47 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: iwlwifi: Fix spelling mistake "Increate" -> "Increase"
Date: Sun,  2 Feb 2025 22:10:22 +0000
Message-ID: <20250202221022.199584-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in an IWL_DEBUG_RATE message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index a8c4e354e2ce..068c58e9c1eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1783,7 +1783,7 @@ static enum rs_action rs_get_rate_action(struct iwl_mvm *mvm,
 	if ((high_tpt != IWL_INVALID_VALUE) &&
 	    (high_tpt > current_tpt)) {
 		IWL_DEBUG_RATE(mvm,
-			       "Higher rate is better. Increate rate\n");
+			       "Higher rate is better. Increase rate\n");
 		return RS_ACTION_UPSCALE;
 	}
 
-- 
2.47.2


