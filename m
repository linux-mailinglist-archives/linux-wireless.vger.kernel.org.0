Return-Path: <linux-wireless+bounces-34573-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F7pDXOu2GljgwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34573-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 10:01:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2986E3D3B4A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 10:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12D1430235A0
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 08:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1061D3AE1B8;
	Fri, 10 Apr 2026 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrZEVRu1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF5A3ACEE2
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808041; cv=none; b=ic04f7ZjNZmbQMmW0r+gEoSQcsj7O9Cl7EGGxxoJZXbcbx4ABJXnJdKwlZD7RzT1G7Kn9Oubn2uKxPhKXt7CReUGzU4ayZMDrWC4a2HoDvxQdehLGSQd/oNvz/SRkTt7GEw6FVHODSu6dKuK0ZMfdG3RfOrIF5d3DAGtensFZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808041; c=relaxed/simple;
	bh=VPddwM7q9ai+Mc+Hm7URp9mhZzBpJZSUIvlqgPihycU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSZS7vCJZqbVqi4IqTixhNKzF0xuYlJwKYIKaVKlEno9F91D5mcw6y6jRfvM+37qJrXY07TTziGD9ftcBlJwW4ud5cauVP7ZUJnkOENjXLAl2gVZsFkzQamKxjQVw+tgoWVWRkF5+W99GDwF3CesGYFFYqN3GgbT1Xefu22+Em4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrZEVRu1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b8e8e7432so1523516f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775808038; x=1776412838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH4qigFMvJKamcVu6PpJKnPBitJ1tPD2bAQZHpobGMY=;
        b=LrZEVRu1cF8ARTyxV7oe+qNycEiPSievJ3j7kt8tptvwyUXYdg9DvGmRh71rOfr7zV
         tuSIU272nYeAR4/+R6p6jdZuxwmFtyfqfKZGG90btFJRspgcZJ6d4G15tYvCntn2VC/N
         kk3cmt1+AmtZZAtPAsSB3979mE7RFZHh6xJ/BsPH+XJajg1Iq1IklY5SAmebJdHufo+S
         CZ4IpsK7ArJHRoU88GgpDkX3B1F4Ao/jVd82lhTUn+IrtafglwAAdYuIQKHPJ3jHB1Nj
         A3Y2BZRAHOjfRedIim2CXrLBDvAJqdMbbpyRqKbGJPEy/m4WJKtPBKggsesF4YhssTkW
         j2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775808038; x=1776412838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FH4qigFMvJKamcVu6PpJKnPBitJ1tPD2bAQZHpobGMY=;
        b=owmtC+HbbDq7F/ohHTx75N9z6yWn8bt4k1tK+ORlTtyRMkZ8eSjxCcaYeQXHHa3WdN
         ii2Hqqooc6Q4qCBZW2y644RLp37uJoj1jAjfoDu/SvmJ7aZM04OI4/docoruhsD4HPGk
         njPW62AuB7VqXu3xnWPHfatZWiBpIm/par3pwTP+oDeB8cOMecuZa9ngHhXVtP1eZOXT
         BSXXFbUzX41zS6KDhMrNN9M5g6UODnbE5Idk+7X+/9BPav466tBPU1qFoxosHPSBwbA/
         F97AsNyEIceCOegn6nSTrRuapVLzIHZiHPijwoqDPW2eZjpmyQQ/bzWFcp326xIVG4UQ
         UTHA==
X-Gm-Message-State: AOJu0YxR2rRCjG6YmmBstFEba7tAkV+kGNGuplIrZXOzehwIVIC6AZX8
	MCd6MzB4cSTVF4clDT7TN4Ptmbn6xEjkwikV9yMZRqpg0gzPv+Wexqr88s9Lij9kMDw=
X-Gm-Gg: AeBDievlaVPncvo4ATVWNZfMW/zrns0aXhXsUBGg85lMrg74KsRA4AX47xJ63hh4dLR
	13a754I95FBFgIivvd5s0Csiy1pKv2eropGYjJvQMa8aewPtyim4Yb+R9oyn+CV7RWqfIQUZV8H
	VAIxXhnakG+OmRIQU0Y1AWHAdl9UdNqFV/XkA2xDndBnVXOsUfBBZt7copihqS/7yr6ppoRvxmY
	cOIs9e8Mlmq0KaKHRhr5ONyVeEliBU0LhkqDPjRqOIl9m22WyGQYqCy8SNROCS6F8wiJh0UGlee
	NxCa4Nn0b38QFRjtQLeHd5JJ8t4t5uJyJsQqb7ZvIpcTyjBHYJN6lR1xOaIoe7+JHyN7PMjqR/G
	HXEtFjolo3hUdJHVuygyxZ+2GFugp4keHpVnIYHI5FPo0p5gHlUJfT9kq5Ybodt71Z6pZuJgEUX
	YcWlElcyxKe7HEpuw=
X-Received: by 2002:a05:6000:1ac5:b0:43d:4df5:3de with SMTP id ffacd0b85a97d-43d642c5029mr2857827f8f.31.1775808037584;
        Fri, 10 Apr 2026 01:00:37 -0700 (PDT)
Received: from bazzite ([102.128.175.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm5891151f8f.35.2026.04.10.01.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:00:36 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	linux-kernel@vger.kernel.org,
	Louis Kotze <loukot@gmail.com>
Subject: [PATCH 2/2] wifi: rtw89: phy: make RF calibration timeouts non-fatal on USB
Date: Fri, 10 Apr 2026 10:00:17 +0200
Message-ID: <20260410080017.82946-3-loukot@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410080017.82946-1-loukot@gmail.com>
References: <795a8567fdbe48babc5cf0f2b5e10c0a@realtek.com>
 <20260410080017.82946-1-loukot@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34573-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2986E3D3B4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On USB adapters, RF calibration timeouts can still occasionally occur
despite the increased timeout values, particularly under system load
or USB bus contention. However, the radio typically continues to
operate correctly despite an incomplete calibration — the timeout
does not indicate a hardware failure.

Make calibration timeouts and bad state returns non-fatal on USB by
logging at debug level and continuing, rather than returning
-ETIMEDOUT/-EFAULT which can cascade into a connection failure or
disconnect.

PCIe error handling is unchanged — timeouts remain fatal on PCIe
where they indicate a real problem.

Signed-off-by: Louis Kotze <loukot@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 4d809df8b..a06bea88e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3972,9 +3972,21 @@ int rtw89_phy_rfk_report_wait(struct rtw89_dev *rtwdev, const char *rfk_name,
 	time_left = wait_for_completion_timeout(&wait->completion,
 						msecs_to_jiffies(ms));
 	if (time_left == 0) {
+		if (rtwdev->hci.type == RTW89_HCI_TYPE_USB) {
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "RF %s timeout (non-fatal on USB)\n",
+				    rfk_name);
+			goto out;
+		}
 		rtw89_warn(rtwdev, "failed to wait RF %s\n", rfk_name);
 		return -ETIMEDOUT;
 	} else if (wait->state != RTW89_RFK_STATE_OK) {
+		if (rtwdev->hci.type == RTW89_HCI_TYPE_USB) {
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "RF %s state %d (non-fatal on USB)\n",
+				    rfk_name, wait->state);
+			goto out;
+		}
 		rtw89_warn(rtwdev, "failed to do RF %s result from state %d\n",
 			   rfk_name, wait->state);
 		return -EFAULT;
-- 
2.53.0


