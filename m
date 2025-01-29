Return-Path: <linux-wireless+bounces-18127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A1AA21B08
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 11:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72FD1642A7
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDFD19E96B;
	Wed, 29 Jan 2025 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="a7SPHoSL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net [178.154.239.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B626778F58;
	Wed, 29 Jan 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738147012; cv=none; b=qjc/KZyqY0hntUxhnmSCz+SN/gUjWvTyDB7ADKOLWvl08FjAkUp0AzjoOcv4Yb8QN+E0+V5//1Ev/OpGGaJKwbNQAD9eZ82jo8hDaNHgzP8kWAIIrYmyBt+5QrA5pqK7YztjUUFL0DMY5mcKzJKSijG+oqsgDf8WttLg4wNdPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738147012; c=relaxed/simple;
	bh=greHx2GzThDeWxShXIMD1FA7KDxSaEofcq6FMRwJHXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqrpMH2AODNubBC1U46x9fpcqPDgsUQCzPP1TrqrPqYh89ZBnGJZiAbdF9HwP6IDaBrDvsFiSHViGkKhqwG3AGeu/Oje9yMNCaHeJoxtB5CIM4WMx9cYzlA0oJkWafo5/Pg/00HqD18EzKFyDgLoSVXDqT3u2VdGjzVqqvAWLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=a7SPHoSL; arc=none smtp.client-ip=178.154.239.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward202b.mail.yandex.net (Yandex) with ESMTPS id 4B91066890;
	Wed, 29 Jan 2025 13:31:31 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:fa3:0:640:de6f:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 765F560E5B;
	Wed, 29 Jan 2025 13:31:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KVboCEDOlqM0-Mx9wzL7c;
	Wed, 29 Jan 2025 13:31:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738146681; bh=V+/wiusPIeWm6nx3BAlj5NL9DbiCY8M+8VSd3wOJFbE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=a7SPHoSLMiGTel2LrlovUntfk+Fgxhy84pyPlkILhTy2T1hRLyqxsAiGDfNKOT9Gu
	 UsCDsZrj0Biqln3SiS3O+T0pMzelaFW0QWeC7Lw+OTSZ6M/cfQSFLWfdpfRkGtCq/L
	 0ecr3tzCazExB0f4x787QFczYfjdorahC1+to/gY=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 6.1] wifi: iwlwifi: assume known PNVM power table size
Date: Wed, 29 Jan 2025 13:31:20 +0300
Message-ID: <20250129103120.1985802-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'iwl_pnvm_load()', assume that the power table size is always
equal to IWL_HARDCODED_REDUCE_POWER_SIZE. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
I would gently ask Johannes to review this before taking any other
actions. This is intended for stable linux-6.1.y only in attempt to
avoid possible use of an uninitialized 'len' without backporting
https://lore.kernel.org/linux-wireless/20230606074310.889520-1-gregory.greenman@intel.com.
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index b6d3ac6ed440..ddf7acd67e94 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -332,6 +332,9 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 
 			goto skip_reduce_power;
 		}
+	} else {
+		/* see iwl_uefi_get_reduced_power() to check why */
+		len = IWL_HARDCODED_REDUCE_POWER_SIZE;
 	}
 
 	ret = iwl_trans_set_reduce_power(trans, data, len);
-- 
2.48.1

