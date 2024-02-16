Return-Path: <linux-wireless+bounces-3713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ADE85881B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 22:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76DF1C20D04
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BF2137C58;
	Fri, 16 Feb 2024 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QR8YcZNb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B123A136658
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119426; cv=none; b=Il7DGdau+Hm1/xeEXfOMRuK40ilSi1qMv8Fy9jg4h+9fhlxWx2wY7s+tL7CkIscQ/wjhN33wGVMMZVJgNWnZmeDLVfMW9cy4tAgn18YtgT/orQL37FgnK59bmbVPKyJDiOpjGp3YBYdM2FAjc3BBpJfQ+73eOnNeB1jeggm/Ryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119426; c=relaxed/simple;
	bh=wl6y8FK/dvtshKxXABRSsy4XelscnZEwWKOKDtjNd/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnWc3iMu6fyC0qu7eyLeK7hs2ON7fsC+/6w02Z5FF9/Es4AN8ZDjRIZ6isMkX4lr/oDgm+QL8qpKCDdd4kiT8oKHSRH0DFydmoJuVITHxBpEyqHtFqDJOCQ4wtGNQC1t/+v6d8DSOexhMvyj7khh3A8PI1iSfGlRO8kmJzOi1l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QR8YcZNb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708119423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GCuV9hqJo7IcFu0Burh0T9FKr0+Qq7OtOr9k96PzPdM=;
	b=QR8YcZNbYmVIqrez8MMgYm5pRSFxBL8pZPf3GFwgZxjOi10EcnpEhOCHFu85oTDUPwd+KX
	GCgHEJGXi37zicd0lrGDkXSP7fQJ8MSKBMAxjPKHfHfMlLByvWZdn/7G2oOFQ0Y5Ufejgq
	SwpiOlH3FZP6QpyfzNHIYAJxqDgOzeA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-Oa3WRp4iMHeMBg_uCuSMQQ-1; Fri,
 16 Feb 2024 16:36:59 -0500
X-MC-Unique: Oa3WRp4iMHeMBg_uCuSMQQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 316D03813BC5;
	Fri, 16 Feb 2024 21:36:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2EA43492BE3;
	Fri, 16 Feb 2024 21:36:58 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-wireless@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH] wifi: brcmfmac: Add DMI nvram filename quirk for ACEPC W5 Pro
Date: Fri, 16 Feb 2024 22:36:49 +0100
Message-ID: <20240216213649.251718-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

The ACEPC W5 Pro HDMI stick contains quite generic names in the sys_vendor
and product_name DMI strings, without this patch brcmfmac will try to load:
"brcmfmac43455-sdio.$(DEFAULT_STRING)-$(DEFAULT_STRING).txt" as nvram file
which is both too generic and messy with the $ symbols in the name.

The ACEPC W5 Pro uses the same Ampak AP6255 module as the ACEPC T8
and the nvram for the T8 is already in linux-firmware, so point the new
DMI nvram filename quirk to the T8 nvram file.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
index 86ff174936a9..c3a602197662 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
@@ -82,6 +82,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&acepc_t8_data,
 	},
+	{
+		/* ACEPC W5 Pro Cherry Trail Z8350 HDMI stick, same wifi as the T8 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "3"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+		},
+		.driver_data = (void *)&acepc_t8_data,
+	},
 	{
 		/* Chuwi Hi8 Pro with D2D3_Hi8Pro.233 BIOS */
 		.matches = {
-- 
2.43.0


