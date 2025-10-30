Return-Path: <linux-wireless+bounces-28405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 012BFC2011F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 13:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D85614E0EDA
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955CA326D73;
	Thu, 30 Oct 2025 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LguW/d9b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365B323D7D4
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828281; cv=none; b=gbz9Flh7o4Yg4p7wCf/VmWe16p6w+YRNtf7uXvuwnpit1K0luYxkAXRzkX2ZxdW9JRUfTaSr3DqjElSTiFWSli35ZryUZPeCZ4StEc285ma5Wf3egjg6qL1bWP0NOv6nybqowOMdfj6z14u7zQpEikVfXIysvEa44UL0LkiJWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828281; c=relaxed/simple;
	bh=cvvZA7+qJeflSP1NlbAS5AXhgF46EZ6m6aWmA0G/6ZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHXySnJrcX/I9+bZdbvdcvOF4PJ29alrlhP42AlIZg26Un+JW3air7JF7MHbEzSEl///jdP1ydrqqvDKiyfkTsZ7rKNUBeVI4KSrj0G7dHGFbfbfngc+Z5tSZ+oec8qLyjOOGZbk1Mc7jSKVtlw9Nq54GaYofOpgCy4UHIG3AB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LguW/d9b; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-7a1603a098eso675290b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 05:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828279; x=1762433079;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0ZO+Z/yIeLzdxpgTNNQEPGygwiE0S/8mhzLNxS1ecs=;
        b=BxcRqQgpn4l8a8rjL1+pfCi+RuEbKApy3dN2X1hgViLibsd5zByIscPn/+HhVg/LTS
         a0X03AOOm6XeSVuIDsHPL/VUCiUzvraBkVjwqaR5o/bNnNewcoKPRNHr6s7VVCQcLNHk
         VdvUydvuEUq4/htBQRBwYOnGQGnfKRSkrErYpfEvplhA9MWgdQlCls4ePKBbVGZqixKO
         kv/psz82bnIyiJqbtxsudIWdZNBNCRhYFpJ5xbA6rncT4ti5PKLf5lZ5v1DwCLrxm87i
         s/W5PDO4sIaQbWOe6aCMMtdKhxXv8Gulsb+ws9K1NZzHNQ83+D4KuOl5qU9EFZ6lEZGY
         A61Q==
X-Gm-Message-State: AOJu0YyOz1NccnZqx9dYP2DL1BHHB+bF1SqFVrESAzkSJDYn9oE4RBiv
	6SkinPJTtHiSPqhlwBLQLgYRzW3teEc1NRy0Lq1mU9rBuBc6G8oq96lT5igefr8SFgisBDA+XHl
	KN4u94BN/yHVJgBazVrJZ6ADAstONQHTXhB3QWubLzBtgMK6ViJ6ay1ol5fSEKL8frTFdKAERxL
	2GeNwZvmwDcRtodkUc8sUXleFf4+dPud68VzsL/Nrepald3isf+f0ckw/q08ci+KmMsDZQSNFar
	JF5CumvMviMpaAt5WKdkn24i4QW
X-Gm-Gg: ASbGncuJtDscDVftBq+2Cn5uixEmRdh84M0OLDjEkY43ywoBMZ9zOUeNZeLnZnBx7fO
	yTyIDxYUDozFoTvKOPVJqZrnuY+67b3+LnX2yhERkCl/viejmaRkH2vZZGsMaNGwTAoEC93i3GK
	bQznyn8cbSofQmufJW1uZMyb1IU6tufhlfOGF3qi1ORQFs0NaoyfMyOVJ63hVmR0Qvxt32kIV6G
	X0kZPj+KIu6I5vUWf7/IMl3+3Mz5Gg8Aey8RAYG5UHxjMOdN2deL1BolHRKpEU5DhNQwOztHD3X
	ASvTUAyLJSH9iiIvKJ8zUknq9RjNTWIUehbiZ3tGPRctSv+mx44vjle0iZ3MAJeW7CAXSJJoVKp
	1NALBST+wWiJ9bnIOY2118xJZCfbGM5YlCEBNMfxYZavwO7ZqkJLpXxzAF9eDhNK9d7UT+1nFxn
	yCSng6n2fq14YzlT5SG0BM2qqvrs/51km81qj5ZWFt
X-Google-Smtp-Source: AGHT+IH7wWcf74Vve34/01OqqVJa7Ij17tcQUzTeyODofG4CK4f2ox6vbHS02nCAXKge3GiIvoSd2D6e9Mu4
X-Received: by 2002:a05:6a00:2d0f:b0:7a2:7157:6d95 with SMTP id d2e1a72fcca58-7a4e2cfcbe7mr8253735b3a.14.1761828279329;
        Thu, 30 Oct 2025 05:44:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7a41409fd52sm1357806b3a.7.2025.10.30.05.44.38
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Oct 2025 05:44:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6ceba8968dso780134a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761828276; x=1762433076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V0ZO+Z/yIeLzdxpgTNNQEPGygwiE0S/8mhzLNxS1ecs=;
        b=LguW/d9bJORIHa7AgPuPBJmd0GqYZZpIFsod9qshaDhBcMgaje/iDyU4QAAv3rA3vw
         rU5Moj2I32ZcRbtSVPgQWQTVLgtNFWQcR9sZe0X+no0bMPsrvOyNbgH+b7J1ohMbE1g2
         afiEzmD41LqBEgdOB7qXguda3sc2S9DdDnBoU=
X-Received: by 2002:a05:6a20:a10b:b0:341:262f:651c with SMTP id adf61e73a8af0-34652f52792mr9835362637.25.1761828276247;
        Thu, 30 Oct 2025 05:44:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:a10b:b0:341:262f:651c with SMTP id adf61e73a8af0-34652f52792mr9835327637.25.1761828275836;
        Thu, 30 Oct 2025 05:44:35 -0700 (PDT)
Received: from [10.176.2.229] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068cdcsm18970045b3a.47.2025.10.30.05.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 05:44:35 -0700 (PDT)
Message-ID: <12ed332e-bcd9-4f0e-a2ee-6d1b3de8753c@broadcom.com>
Date: Thu, 30 Oct 2025 13:44:32 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: Add DMI nvram filename quirk for Acer A1 840
 tablet
To: Hans de Goede <hansg@kernel.org>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com
References: <20251020163421.68717-1-hansg@kernel.org>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20251020163421.68717-1-hansg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/20/2025 6:34 PM, Hans de Goede wrote:
> The Acer A1 840 tablet contains quite generic names in the sys_vendor and
> product_name DMI strings, without this patch brcmfmac will try to load:
> brcmfmac43340-sdio.Insyde-BayTrail.txt as nvram file which is a bit
> too generic.
> 
> Add a DMI quirk so that a unique and clearly identifiable nvram file name
> is used on the Acer A1 840 tablet.

Thanks, Hans

Please note that the subject should start with subtree name, ie. 'wifi' 
prefixed:

wifi: brcmfmac: Add DMI nvram filename quirk for Acer A1 840 tablet

Apart from that...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Hans de Goede <hansg@kernel.org>
> ---
>   .../net/wireless/broadcom/brcm80211/brcmfmac/dmi.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

