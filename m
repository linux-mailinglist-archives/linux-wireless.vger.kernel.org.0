Return-Path: <linux-wireless+bounces-7330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B6C8BFB46
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 12:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E05E28219D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B3A7C085;
	Wed,  8 May 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzByISPs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675381721
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165310; cv=none; b=cDosAr9h+x43zCypYxY76eMXnBMd3x2IMua3f1zWN2k0tdXCE580epZ83UFctFOe1tfK2QO/Hgmx/WC4YBNiEbtB7ELEyNvxsGF6R2couu5QvkciERdlzZxz/FnM2BWNEp7zNVgKvuKc1/heeLzTgOdtRE3IPLOgZKykngDjXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165310; c=relaxed/simple;
	bh=jtpKGvmqnuqm4SJ27jK40aTAdWGIXjrNP/Pl9res3Gw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I4CZJPUy3MVtivHU6sJElhDe2Rtnl6bAMa6iSlm2FBc0uAMSpTOUJiWEnACUdH2eK1UGJ8sAUXuKwJfzqsgLZRLUmAHbBF6fICWnE2LLJth4eZYyarABwzKPQ0Pcu32LENOfeQTuKlY/rZ9PyEvHp932Uwhdz3VCIRLd0pCkjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzByISPs; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59cc765c29so779805366b.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 May 2024 03:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715165307; x=1715770107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uKXBMto7ljjpHc1vmaCQ4635t+IDSBGXpVOLoi5T3kU=;
        b=hzByISPsbDAFoTdlJMTlNWqZ/toAj4aTTjhPdMJ/oYQroiAxNhO+mbaGyTzcu5g7ap
         wlxiZS69g+yflo7YfUeKC2X89i77N0CcPQOsfsPiTu7RaSgfM9nEkuMOarxiFoujB31V
         C59xM1gnouJdNbegtEhgC/6CoQ2l8eSt7KOQKxSpp0GdMGTLkxrpPE/4BRe65DNZXLPH
         yFCn8MPdlLCIQpIg+P05UcwJGJkfoJUQq8uI3kxABBlRmreZPWw+K6iN6PYzE/AtBYyv
         oZz68laK/TrC/C0lEvMRK3mE7+xwPfRI7dM7hJmIiFdTL0xoo/nvT43M//Z+veg/KWyU
         5dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715165307; x=1715770107;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKXBMto7ljjpHc1vmaCQ4635t+IDSBGXpVOLoi5T3kU=;
        b=uqQUX1+/Aag0vBfxA97hu+Ko7cjYxfactV1DnpdUU/TCyPpTtsPxvyIaqETTFVHPI7
         qeTin3zloBsuEhUOfoYnR5Zbuab+1y7SJdELaOC14hAMdpCBpLxDXhb2fF+cuog0kBBv
         rPq0exBJfHpRk0HkbvmN+bzx0LUwWu4q6N8mSxXw7570cGu4zsGRkwxeDKfWffQOoFwL
         16DVwQrnfJwGPIz+ujf31sSDwUEuDpEkf9WC3nc4wXa92dFAaussrhaGjXjXdzaUgcmC
         cbPoLkpyFEnn/Fj8YBZ/TaWa0qYAKa52UyufpRaglPagRw/Y4lTqjjrGSvyK+4ziv7SL
         xf7Q==
X-Gm-Message-State: AOJu0YyUL5GDBVNIF4GwGEsY/0VkLrQKJHIadGan6gygKOg76zH2Dxrk
	m/gMGm9J5LTqcXl9G8gwJGdTJPofFgAcXuaF47wfjMcE3/Im97CaS0Cf7z9p
X-Google-Smtp-Source: AGHT+IGcqziQJEMiOC+7GRlswwOnMahMY7RZe8yjxAUgb0kTLgZjmFjxUMn/XBIesTrA0IJ/qo8jCA==
X-Received: by 2002:a17:906:fac3:b0:a59:beb2:62cc with SMTP id a640c23a62f3a-a59fb9dbd48mr136085166b.61.1715165307377;
        Wed, 08 May 2024 03:48:27 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c254f1sm18718115e9.14.2024.05.08.03.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 03:48:27 -0700 (PDT)
Message-ID: <0da95992-c93b-479a-93fb-eeca2cefc8c7@gmail.com>
Date: Wed, 8 May 2024 13:48:26 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 02/11] wifi: rtlwifi: Add new members to struct rtl_priv
 for RTL8192DU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
Content-Language: en-US
In-Reply-To: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These are needed for the dual MAC version of RTL8192DU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
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
2.44.0


