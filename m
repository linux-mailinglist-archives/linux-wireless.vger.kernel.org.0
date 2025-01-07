Return-Path: <linux-wireless+bounces-17155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51ACA0488F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 18:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5591889384
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 17:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228F21F2C48;
	Tue,  7 Jan 2025 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h0/8tGlS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBE1E3789
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271919; cv=none; b=QZMa/aJicxoPGPeM6cloWCmfV0IULfR3aYnwM3O8QbqX0F8/TE6Xd70xET3D2C5W0OP5KC9x2d7SU04XqOA+Sw5lKP+VKkuYP7JRnIdh8pn3Yr8QKGHwx43deGtI+m7H97inW2KjBKniA+Mwf9dEB8yom6dJM+gaCzrVB56K+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271919; c=relaxed/simple;
	bh=4O441MQ7/1ECwfzwBdnpB3F2Geqpc2NHRW2VlEmXq5Y=;
	h=From:To:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=D+7n3WYe1M6lhVOOFAiCQbno40wln3Qt+m38HfaGXR+GcYpEjbylNX3wiGLWlSPO5cqvedaFrGb1zWnC1kud+ZHMR8pKgS3OAAqKQKr5F2GfhXqiZNJuIrvRE1bFbrKYkOE7R1wTdsavVvKm6q8LKCfiCmrBBNs0vzYa935TOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h0/8tGlS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21675fd60feso39044215ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736271916; x=1736876716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4O441MQ7/1ECwfzwBdnpB3F2Geqpc2NHRW2VlEmXq5Y=;
        b=h0/8tGlS+eR55oSxbg428Qk9/K7+s+TelKGHeWVn06IZ38xEj7JX7uFurSDxaXFg8Q
         4prkPenqfZI+3XIzsORvVJ2u/V1KNbYunT+nkOf+w0LlvLz5lXqfiPq+3mnqRTOXADpj
         tDPNELIxu4qUTRKcfvd8v1ZIc+ZAAOB4OsRWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736271916; x=1736876716;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4O441MQ7/1ECwfzwBdnpB3F2Geqpc2NHRW2VlEmXq5Y=;
        b=Vb2quJEaZ8+/ZfQzD1UD8hFxhI56m7rwJ6RN25X9Coh53z9gh/eFo8ec8EPTNcGluG
         t1X8r/y+MvB0ITy3WnyxFWsnsUHymf10ykpE//WX+HrU9wxIjKqtJ1u7fOnSV+B6Dh1T
         0PoO2+e2mZJ4wD0EbENUyWyCXAwj7qF+9SRNQCqzOalTNAA7M2SHqD8w8uBrDKUfRdK1
         5sT+DFMNr5ed9fDUz19trRNuvs4j1bN+Nem8rTMFuCDirw/MhxAV8q+HalqSpL7UNXsQ
         ElVqVgXBerRsIVK3sZNKl0Bg/Ky8I2M49JpgaKQnbDzlqYxM95GgGyyJkKFAq5ZtL/1w
         4C3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+O6l/+9DX7Ym1QGL0TPCoFWF3UxR4eGH0ptcOOwU7yXVPE7DZ+zbO8lTM2Hy1nkPzm48JPJiztNg5z47JDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwD4NlO02kMTeaGNddJAl9CKh0YKbvQddECMEwnXD84h6ipCIKD
	mRXxV/Mn7JwMgas5yz7EEdW0CIU3UuOp80JHzLwG6S9gHFYI/cPc/xwsGktBbs9eQOgK0A66T9I
	e+w==
X-Gm-Gg: ASbGnctbZzdc4oZKPM6/GsmduKz1MQn/Eg0R9gfPHvGtkM6Gk+jj3bcN7V+usaR9VaK
	ULfyvPFTvc1uMWKy/o+mQPTLTsYFNf/+kfxUgceX4+YIpOofE/NhLH5DHXGzz06/o32e42PJlPc
	KUpziJlmBAX9kwyuLaoKygutwJoaAJM0j5ncii3+aYxn8tGj95BqeKoKrJbbOQHQmHxP85n6iyW
	HQ0f5PeTXC8hf65Lxa1co1LsOwiWH2owIoLGfprWDndmWipZAMehFh7ZVrO5CGAgCuSv4+L8wIU
	i45Z4cuAoYIFR6YbvmA=
X-Google-Smtp-Source: AGHT+IHOa21ZR+Lr7/3YheszCow8lEFw0Lvzec4fHEOR6yhep5nEp1ly/leR6XcpwqOMs4X6WahxRg==
X-Received: by 2002:a05:6a21:910c:b0:1e1:f281:8cf5 with SMTP id adf61e73a8af0-1e88cf48a57mr108716637.0.1736271916005;
        Tue, 07 Jan 2025 09:45:16 -0800 (PST)
Received: from [192.168.178.74] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842dc7eda63sm31187729a12.68.2025.01.07.09.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 09:45:15 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: =?UTF-8?B?U3RlZmFuIETDtnNpbmdlcg==?= <stefan@codeweavers.com>, <linux-wireless@vger.kernel.org>
Date: Tue, 07 Jan 2025 18:45:12 +0100
Message-ID: <19441dedc40.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250106170958.3595-1-stefan@codeweavers.com>
References: <20250106170958.3595-1-stefan@codeweavers.com>
User-Agent: AquaMail/1.54.0 (build: 105400535)
Subject: Re: [PATCH v2] wifi: brcmfmac: Check the return value of of_property_read_string_index
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On January 6, 2025 6:10:13 PM Stefan Dösinger <stefan@codeweavers.com> wrote:

> Somewhen between 6.10 and 6.11 the driver started to crash on my
> MacBookPro14,3. The property doesn't exist and 'tmp' remains
> uninitialized, so we pass a random pointer to devm_kstrdup().

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Stefan Dösinger <stefan@codeweavers.com>
>
> ---
>
> v2: Don't assign err, inline of_property_read_string_index into the if
> statement.

[snip]


> ---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)



