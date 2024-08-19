Return-Path: <linux-wireless+bounces-11623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9D1956F45
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 17:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DB41F214AE
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7A512B176;
	Mon, 19 Aug 2024 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YQaKYT6Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358463BBF2
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082765; cv=none; b=SOsCiC9KwALditGluHa0ARZWnImHvqqO/RULAu20CTwp+52wqIZW6ayWHXwwIkguIQSyjrt6hIuTRAv93Q9wMd8dYg5wfhG3dtxlgB/I28Su04ZpzLzQkLu/LDM/0AlAbALFLTF2hit0u+yAcUYrJW9G/O3S0CF7t8rLZG8LYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082765; c=relaxed/simple;
	bh=Q7bJiVRG7liKTZBf0PjHSKqqS8kz/az3WbqO91obieY=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=j/cWCR2/Dr86mvfrV/x0TjSNHh+AO8MIxVfWAn5W4UDUDeR+x4FOXvI1kEzkB+HIqN7Y7vZ0hX+bZKFf6HiJiorVRYXgNlHxEf1XNv2Zp8LEIdhErIUbV0b8B52CfShNw5olBwUCxFC1Ysc3yAmlDUrtFJk+rystQUb+8FOefcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YQaKYT6Q; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-371afae614aso1387507f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 08:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724082762; x=1724687562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4RzSWJA3xUP/23XsRcXEBJL0JfqNAW5dNBSPD0qir4=;
        b=YQaKYT6Q7AT7D8NX6hrVP+iAt8Zc471egRGGfBtpexVREljsMX7O87svSXPSoeOsTc
         AUA4bDwROdCV6Ha3FvMs6lc9ac3NjKf5VaY9CKTOtqwzRo0RkKPovBc9ht6oaXWIyMFo
         h/QNl/M5kQIzVhrvWNiiP24lUi4i995MLAdNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724082762; x=1724687562;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4RzSWJA3xUP/23XsRcXEBJL0JfqNAW5dNBSPD0qir4=;
        b=rbKVxkQgL/QUIFsukA/r3OENXebHaVkkn4fV+W9bdjIbWKlH4jTQEfeX6f4eaEQjRx
         PYnF7nrZblsDhOL31cR6G3Wzj5Yi6x6w9SM5aLBWClTsooMKDKTD4Ud+w24K9UESp2Cn
         F/ArZEqEsb+HupxBfFBN7pLeltJ3E/ipa5wXtBb/rak50TDxnI3befsx3TvtHtpNRsRZ
         Iyc0BDm/knEaNp4w0uVtCHf26Dr6b119c2NqTYsPod1cf8+LsQQ0s9BeCMCUmhl0EdAJ
         bN0asTJhfYN1G2DoVB6o245bjY79m+ysV2xrFcteL4YoAUCVPGRp7jEA1C/Wjvi2TSYs
         KYZg==
X-Gm-Message-State: AOJu0YxKsQtvwPn7QrAtRbdsEZXzns43fEUwhG5LGmNiEl+H8hVAkm/k
	b0B91+E6wprFN+wfYsoHnjlcwgyGAYEKSU76ZT4fIq8WtPWwE/OjrxTkUp7a2Q==
X-Google-Smtp-Source: AGHT+IGW8oAqkMSHkpuCNV4nfLQQ7vz+yfoDUOn5qpGNhEM3JUwcTDHEUZap/RaAsTKmplRWZ/snUw==
X-Received: by 2002:a5d:6385:0:b0:368:36e6:b23a with SMTP id ffacd0b85a97d-371946c9ad0mr7268298f8f.55.1724082761901;
        Mon, 19 Aug 2024 08:52:41 -0700 (PDT)
Received: from [10.229.42.193] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898abf2csm10770266f8f.107.2024.08.19.08.52.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2024 08:52:41 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>, Marek Vasut <marex@denx.de>
CC: <linux-wireless@vger.kernel.org>, "Chung-Hsien Hsu" <stanley.hsu@cypress.com>, "Chung-Hsien Hsu" <chung-hsien.hsu@infineon.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Carter Chen <carter.chen@infineon.com>, Duoming Zhou <duoming@zju.edu.cn>, Erick Archer <erick.archer@outlook.com>, Kees Cook <kees@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Mathias Krause <minipli@grsecurity.net>, Matthias Brugger <mbrugger@suse.com>, Owen Huang <Owen.Huang@infineon.com>, Ulf Hansson <ulf.hansson@linaro.org>, <brcm80211-dev-list.pdl@broadcom.com>, <brcm80211@lists.linux.dev>
Date: Mon, 19 Aug 2024 17:52:40 +0200
Message-ID: <1916b572558.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <871q2ky3zm.fsf@kernel.org>
References: <20240818201533.89669-1-marex@denx.de>
 <871q2ky3zm.fsf@kernel.org>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH 1/2] wifi: brcmfmac: add support for TRX firmware download
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On August 19, 2024 4:36:05 PM Kalle Valo <kvalo@kernel.org> wrote:

> Marek Vasut <marex@denx.de> writes:
>
>> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
>>
>> Add support to download TRX firmware for PCIe and SDIO.
>>
>> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
>> Signed-off-by: Marek Vasut <marex@denx.de> # Upport to current linux-next
>
> The commit message should answer to the question 'Why?'. What's TRX
> firmware and why do we need it?

I looked over the patches, but did not sit down to comment on this. The TRX 
firmware format allows multiple images and possibly compression. Not sure 
if Infineon is using all this functionality. This is probably needed for  
55572 device support (patch 2/2). Turns out this device has a bootloader 
that the driver has to talk with and that is probably where this TRX 
support comes from. Not something I considered to happen for SDIO and PCIe 
devices. There is always a puzzle to solve ;-)

Also noticed a random seed is provided to firmware. This already there for 
apple chips so it should be looked at whether that code can be shared. I 
will follow up.

Regards,
Arend

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches




