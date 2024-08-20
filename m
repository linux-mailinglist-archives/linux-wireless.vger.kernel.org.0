Return-Path: <linux-wireless+bounces-11663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B209585D9
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 13:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C97282746
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 11:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C54818CBF3;
	Tue, 20 Aug 2024 11:30:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB11CAAF;
	Tue, 20 Aug 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153432; cv=none; b=hMMhcpmLZpRsHVqBvS3I2xSOnna0BGQIXsd6dvbbGEzcaXj+VpNn4HpsYOkzsRJsytlPjS4SoNxcpTPCjx+yN3wE8dKPGkxPaPfvPDC3i+K35FTCntUVC1jVEVSOskqul9fQz8r5+6x29x4vhY0Y7532DnWyG5LNvJco6xqgfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153432; c=relaxed/simple;
	bh=LwNxyJ8nRP2FJc1MWTutiqa/SpX3rNJs78aYCROn9FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je3ekqp1/VKFEPudxesiR0xIQ9Jj2G2lTHGpEbbLCkmxZPw43u3MHrNFTPpewiImOnRAJxbVYmgqO1/0NpR8Wx+fpYyHj05VytpEKJjfxDKGiDg52ZfLH/6eGRPYSveqY5vOUEgehf3T0h/SwMRSfdQqQO+LmjQI1BqrdQCbTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a83562f9be9so486756466b.0;
        Tue, 20 Aug 2024 04:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724153429; x=1724758229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSdQn5lqHbb7x/BQkgHUJ4Z5p0Igia2Fda+/Marx+2w=;
        b=IsN55myBIFVS3LzhYMq6KezxF41wgeNR7P2HAF7q2jYHYBXopDByOBTGfGWGKgmfjl
         qBHkOfYNYTcBeliohuy0pNbw/DWUvUHlpmYE9WyXN+/RGsQvfbq5SQ/cVqqrMUQ65hMt
         U7LabDnLq9Opcq1Vrl2lLIARaPreZj6YXz1ALta2zz+7EEYgoR3z71oA/38DMm8rPJUv
         wC44ZDgyUoSjoaina1ZGUuuMSO9p9pY4xZ7QlcFihd06jqhTP5lBMccB6Jr8TGJWkVLH
         qDARcv8fymd/79gnWlzCL6TlMXR2zMEuq4kF+Rg5YF1yKdckmZG4fgCRN8UZX1jf//Tt
         qWAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNRP+PJ32TrM+ZrcJmqnLa7Syobk8U9iG9VeBaUIyaBhqflbYbSFV4VyhKBRabEEUcsQAOHHVwpjmVBGLtv+ElurkxvKoUZpvIvqAyLm+RpRa/11P0a3TG8hDl+XUXtFVfLpZ+vWdqGO3S
X-Gm-Message-State: AOJu0YxYGtiXhQ9r3+foqh0YFSwUWm2rApSCn6QpoaBhBhy00ZLfMXUs
	r7XWN7qPs0BfG7qEuHcdmtu7KA1G1fI5vaH8+tCwpEFtHF3gsTDA
X-Google-Smtp-Source: AGHT+IFbS8TXkzjdmPgjYCIQx78qrEAP1lLMjYhcuqC0ZBklgV483mYM3zGpVoQdO8IekiLHD9sdLA==
X-Received: by 2002:a17:907:7f26:b0:a7d:e5b1:bf65 with SMTP id a640c23a62f3a-a8392930dc2mr886533166b.21.1724153428783;
        Tue, 20 Aug 2024 04:30:28 -0700 (PDT)
Received: from krzk-bin ([178.197.215.209])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a838396d5eesm749316166b.225.2024.08.20.04.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:30:26 -0700 (PDT)
Date: Tue, 20 Aug 2024 13:30:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, Hector Martin <marcan@marcan.st>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, asahi@lists.linux.dev
Subject: Re: [PATCH 2/2] arm64: boot: apple: fixup wifi device specification
Message-ID: <2mqpwbn2je526zs6joxgcsue7r73ttpms72dntkup7hg7jkmmx@3lnsea5le5ya>
References: <20240820101216.355012-1-arend.vanspriel@broadcom.com>
 <20240820101216.355012-3-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240820101216.355012-3-arend.vanspriel@broadcom.com>

On Tue, Aug 20, 2024 at 12:12:16PM +0200, Arend van Spriel wrote:
> Align with the corrected device tree bindings in brcm,bcm4329-fmac.yaml
> which imposes a constraint that the compatible should have the string
> "brcm,bcm4329-fmac".

Additionally, please explain why do you think these devices are compatible and
also how this change affects working. Considering that previously these
devices were not matched by brcmf_of_probe() and now they will, this is
significant change.

> 
> Fixes: e2e37224e8b3 ("dt-bindings: net: bcm4329-fmac: Add Apple properties & chips")

No, no bug to fix. Previous code was intentional. If you claim there is
a bug, please explain what exactly is being fixed.

> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Best regards,
Krzysztof


