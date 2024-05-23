Return-Path: <linux-wireless+bounces-8016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D38CD60D
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 16:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C85281DE6
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E68F29CEB;
	Thu, 23 May 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/0GIsXQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F8B13E032
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475484; cv=none; b=AeadWWfv142X0Zk8EcXZycxB8aupqYOn+Vy8dCoTkpGsWmIIjRCGAJctDnNxPlvO1ay2RK27DBjROYbLYFrmlegq3OkYK6uG1fwSnoTZeZXefpIxTuMclAhVUnBiff9YiB51p58M60OWEEHz/+Y6pcVnXxafghd/w71MAYP03YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475484; c=relaxed/simple;
	bh=WvyTgi6DejAUko6r/SY40c4uWXol+vziQTcSK/ICRP0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UrdaQmfohEsi4k7RUF0MeskQZkF5rQVoz8hna0XI12tRCbVvoLDVIlaCGNKn7P0hZlelc8pu8dwsKd7tvxE4BC+f5+373ehdzoc3JdkNdQQ42k/qO9XeMZ8PIElE59E/mJ4WVkJ7Ent0Z+KGznwxVWp3mD9QQkLEj8NneVm/UUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/0GIsXQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so3933744a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716475481; x=1717080281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hHUJ5ABI1VdpZBQkbxrT2Z4vBj+GHVoPG6xwNl6j578=;
        b=G/0GIsXQMrSnabxMCHBIeVvCRotWhTDS9NmwdEFluqUA8PUgFminseSaAJnnPU6Voh
         GLvBAF62TcBl3ZjWq8RKuDh5sebJXGWkE0ZLUW+c1W48Poqya6tv64NeJu/3IQWxPUPG
         6Ne8gR6ckenuMSOsp24/KVqSShQk4lLFB/OS3tmJkGA6F9Mde8xp2t2JhaOYJ55gbBVP
         sSqWWJCULWKsE4Y/Iqi/d9QowvzXvcmiAgW6BpYteMB7DECwe2qhCpVwel/86NiFNQCf
         Tx7CckF9Dtu2qTSH2YjAlWAtc5RsQpUy/kDd8wZDDcHesve/ROlZDuXPLQc2NDCjV0jY
         zPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475481; x=1717080281;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHUJ5ABI1VdpZBQkbxrT2Z4vBj+GHVoPG6xwNl6j578=;
        b=K4ZOwiHg7NI9vSGqXsXLvbKxVSvLH8d9WRav4Fpx6iw8wIa+nmyV1UEz28ego7PLRG
         vXR8uqvrKTqZ8OvAZUeDPsbm/3irnYp0N8jRZ4j0xnxTOXMGSmpwm5gLD9lMxOUNHQz8
         jPDOUvd2agB1ChJMeYpxEY+7EnpnG/nCwWSK/aoUh80L/pi3KODJl8nrPydXkV5kyToe
         qsjaXgQMMTvcTgoMMCO3T0OadGZAhNjRnQiMH6p9K1DtBTo4giCqvCrjMyKlVHDLtcf8
         ApjJ5mlhUfXOnR5lC8V6LsKeVLrezMoLux3ZUZmohZxjovOoq/y2/rYFkPxfX8shn3IL
         KkLg==
X-Gm-Message-State: AOJu0YzvOfFFuY5e5lBrYRAkGJsoEk5xyAV2TqIFgcrDT5E7CZJ2QgD4
	Je29MFSdKRBJ+xybjfJ2kp76SuPV42UgxzygFQl7P3X1ljoOkW0XHF6H3A==
X-Google-Smtp-Source: AGHT+IEaPodH0+RV70UKkmVSqeIcM0HN/pxUDSjlJlo24l/XVcksFfzreKbRzbA6NDVwgDR5AIfFRA==
X-Received: by 2002:a50:bb4b:0:b0:574:f38a:289 with SMTP id 4fb4d7f45d1cf-57843f22d0amr1844827a12.20.1716475480821;
        Thu, 23 May 2024 07:44:40 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574f6b8b9d7sm12278606a12.82.2024.05.23.07.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 07:44:40 -0700 (PDT)
Message-ID: <d1bf581b-de41-4d09-bf56-768c2fc29dd3@gmail.com>
Date: Thu, 23 May 2024 17:44:39 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 03/12] wifi: rtlwifi: Add new members to struct rtl_priv
 for RTL8192DU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
Content-Language: en-US
In-Reply-To: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These are needed for the dual MAC version of RTL8192DU.

The two mutexes are used to avoid concurrent access to the hardware
from the two USB interfaces.

The two arrays are filled by one interface during LC calibration and
accessed by the other interface during channel switching.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v7:
 - No change.

v6:
 - Add more information to the commit message.

v5:
 - Patch is new in v5.
---
 drivers/net/wireless/realtek/rtlwifi/wifi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 442419568734..6a8212fd36af 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2746,6 +2746,12 @@ struct rtl_priv {
 	 */
 	bool use_new_trx_flow;
 
+	/* For dual MAC RTL8192DU, things shared by the 2 USB interfaces */
+	u32 *curveindex_2g;
+	u32 *curveindex_5g;
+	struct mutex *mutex_for_power_on_off; /* for power on/off */
+	struct mutex *mutex_for_hw_init; /* for hardware init */
+
 #ifdef CONFIG_PM
 	struct wiphy_wowlan_support wowlan;
 #endif
-- 
2.45.1


