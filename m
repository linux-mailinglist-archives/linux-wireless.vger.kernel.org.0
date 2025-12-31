Return-Path: <linux-wireless+bounces-30209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F2BCEB531
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 07:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BFCB300790F
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 06:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699042E093F;
	Wed, 31 Dec 2025 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gUaI8Us+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3B02C0294
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 06:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767161190; cv=none; b=PaYP3TFndWFW5EvaMKf0TyMrCSMasEyjdx/DqpHJnNxeWtKevxZpy0T15pdGg3XyKTSEGoj4JYOLYpWDJjIyTTkN0loAG1n0VRIKjvZ/yTVXoN3aW0ffgM/Nw61gSF5L6PH+Ph6RoWzb4HPEkXMsEFX3sqyPwBJUXKsmIkR5wnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767161190; c=relaxed/simple;
	bh=0QGVrzHVELAyrsCIo/W4VZMiZ+CiCLv/DCPc2hHTNW0=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MatzCackXfOdYYlcb/GV+ZoFFzSQVXafdlhSEooKOEmpDmgKbS9EU1Q7UYptdSsPNanZ6icWeWBHqxgCFuBXdXppxBbODQ/jRx6QPHGvjm+uCnHhIQWfqZTip/7d7S5uPLY+1wtZ2FymlheI5NWI8f/MxZfCRhDOHQ8TTnuEetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gUaI8Us+; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so13007738b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 22:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767161188; x=1767765988;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxInCXIieNrCVyMMDuEN44qeFuhRjFwOIv9Pud/p0MM=;
        b=FYAHAjWwvWIkSkLHLZu02kN8DO6VcPAEu9abI14Qg9W/lo5F6dD8iWUrnvnQkQIYik
         wj2fl6xyf4JgVKsLEOg3WQ6cNBtgW4moRAtkhUvxq3GZOzs1zMqtKwadRblddRo5LxBh
         wQ5urQnjnb1zlfp9iwggVMHcetMPADq2gKB2d6s9Kzo+bAH16b0A5c/gS6SXzwNZ+wAR
         HDkBotwx0U72M9FCSLiVgY0HOs3kuOpW6zWkd3EwWjO5YmA3R2i9q41hGJ300Umhqsrt
         hOmTPncvOXfJxNrDf5f93qSMnFBLwohku+8Qm1ZkKeVGpjfbb/GhrsZJvqT5ZUyzMjbC
         NxCQ==
X-Gm-Message-State: AOJu0YwMt7vtv5fuLAvSu5cxkS4+wrsa/SruominWgi3Ckrol7R1P52k
	ViU1VogBK3AqnJmnzZ7B6udufcFHXCB4Z1ec/dpXb7sh1c3pedKdTTq1dL8/EhUF0TRqPCTl00R
	Q1vUnPxLgpGkdnm/Uur4ruZ8gF5n4QmZGpyJvqwOV8kdCf6bw2mISGMMO56dmahP9uTXXh/jApJ
	RCegav00ivF+vry+GLOS8lBfES/pJrfyZEpfmRxluyL7oqMQlX4pHWxaOMX6mtnftihovqtVOYH
	9JIKglXL8Z8HI7WRUvppfu++ZQU
X-Gm-Gg: AY/fxX7wfE4Ltg8BKKfrzG5npEiQKBnEMHnatwK+aQcfsxEqG1Sp02TRTpmMGZsitY1
	O8ns/IyBpVBUlZdQNDnColq0wcIjkmscfqdZQWqHdhUTIitTBSrpIBhDj/rlyX64PRBKsh0XVsr
	TiiwBMR2bMGgZi/eurud42jLqHkU/O5RTN+LLXSNHqhfgIaH8kQSxk/LTyNkRczMZ0pKnkaR2bh
	0dwROR4MCFmKoyR1USpkJXRYBOzlhmq+ySigBKAcwMoDF5K2ZGok467ZxLeIH6vMd6oJRhRLTuI
	RgPk3F9Dr1eNAxTiMIyqYBludjIH5CvARdzM9lOo92qoTv1FI3dptfjqGIYlADBgxPPRoRm4CPq
	rVFIvarO1n74kkAHtQUtVj+qiXrqAINQjcR8Om8UeG/agPYslZlLyXDJQ8glY7IlS9OBZotYBuy
	0cb88yn1JBsu2U2KiuhNQ8XX1rM+JQuKj44Zp2RMDqRd5IId3qqp0=
X-Google-Smtp-Source: AGHT+IE++CP1VXtsmd5eUMkyIXO6e10NaE8ZNvsOA3fMKK/lTIkBWg9efmTugvYAb9+YXzXuqO1gv+oRIXTH
X-Received: by 2002:a05:6a21:6da8:b0:340:e2dc:95ae with SMTP id adf61e73a8af0-376aa4fc23bmr34237284637.42.1767161187738;
        Tue, 30 Dec 2025 22:06:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c1e7bc61b3asm2254229a12.12.2025.12.30.22.06.27
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Dec 2025 22:06:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8395caeab6so118668066b.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 22:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767161185; x=1767765985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxInCXIieNrCVyMMDuEN44qeFuhRjFwOIv9Pud/p0MM=;
        b=gUaI8Us+m/e9c5VevEhweU+dSTKiGBdumoJgmQZvWt9UNoEEplZqCgQj5w5bKQFD3E
         UiWH3jHACCh8bew65gLwyXab9D+6OHebTO7QA0o/2piFmogpoBl5zsZ9hssMUGfr8NVq
         143U25W1ll2TPgArW5piwIc7fXj0l05Gh0I/8=
X-Received: by 2002:a17:907:3f12:b0:b83:974d:ddc8 with SMTP id a640c23a62f3a-b83974dea84mr341477766b.25.1767161185261;
        Tue, 30 Dec 2025 22:06:25 -0800 (PST)
X-Received: by 2002:a17:907:3f12:b0:b83:974d:ddc8 with SMTP id a640c23a62f3a-b83974dea84mr341475966b.25.1767161184785;
        Tue, 30 Dec 2025 22:06:24 -0800 (PST)
Received: from [192.168.178.31] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f4ef1fsm3931732566b.64.2025.12.30.22.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 22:06:24 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Qian Zhang <qian.zhang@oss.qualcomm.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Venkateswara Naralasetty <quic_vnaralas@quicinc.com>, Yu Zhang <yu.zhang@oss.qualcomm.com>, Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 07:06:24 +0100
Message-ID: <19b7303bb18.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20251223092728.1950017-2-qian.zhang@oss.qualcomm.com>
References: <20251223092728.1950017-1-qian.zhang@oss.qualcomm.com>
 <20251223092728.1950017-2-qian.zhang@oss.qualcomm.com>
User-Agent: AquaMail/1.56.0 (build: 105600589)
Subject: Re: [PATCH ath-next v4 1/6] wifi: ath11k: Add initialization and deinitialization sequence for CFR module
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Op 23 december 2025 10:27:46 schreef Qian Zhang <qian.zhang@oss.qualcomm.com>:

> Channel Frequency Response (CFR) module will be initialized only when
> the following criteria passes:
> * Enabled CFR support for the hardware through the hardware param
>   'cfr_support'
> * WMI service enabled for the CFR support
>   'WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT'

[...]

> diff --git a/drivers/net/wireless/ath/ath11k/core.c 
> b/drivers/net/wireless/ath/ath11k/core.c
> index 812686173ac8..6a6bf6316ac9 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -1,7 +1,6 @@
> // SPDX-License-Identifier: BSD-3-Clause-Clear
> /*
>  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights 
> reserved.

Hi Qiang Zhang,

Some explanation on this would have been nice. Doing this in a separate 
patch would be even better.

Regards,
Arend
>  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>  */



