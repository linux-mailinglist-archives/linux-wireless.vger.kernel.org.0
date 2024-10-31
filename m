Return-Path: <linux-wireless+bounces-14787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31849B7D3D
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FED31F241C9
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795741A08B5;
	Thu, 31 Oct 2024 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsUPYw+m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631295A79B;
	Thu, 31 Oct 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385987; cv=none; b=UM44zPmc5vU+T4KFIw9I9a7mS415d4PGVWboDZzAOVCWAyEKAuPQqb5HuGHGcStZ1wudkiQFikLhqk+j5hR7UnyeEb29XKL8ePajsP/+c5XfHDwjGpalCavL5HoPr9sMTJoI/v+DZIYiYiLY0FyturJ1uLkq0xuXcAwWCZQ+VkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385987; c=relaxed/simple;
	bh=G3k8YCPLvT/vD+woarb58oSt9eiPRkiyHHDZR/GB9XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0wMu5AOEy8Ov2FZa+GSSVBF411B2OPfiFSSsQy+p9JxCvfltLtgPZrMX5M+hGTBxDVHEyznUI6FyeWWNncS7YWOI9SfflXld30mfnZQTD+4rCanFjFqHZMQedRHXDQJmwqcBIZ9recu0rmThaQ1h0ihXRUAYOxGjHz5EKfez9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsUPYw+m; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d47eff9acso673304f8f.3;
        Thu, 31 Oct 2024 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730385984; x=1730990784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+R2z2Hq8YdiXOzRMQtJlJNAR8ul2IAPxkBdT8ZGZaI=;
        b=EsUPYw+mN7HRSE8C7FFLIkXqmtMGt7p7x8ZcG7V6w4vnAYG42sgL1VpABunm/yEjyG
         qtfIeqp/Z5LCbpc0Tw5gfyO37Z/FgyOmba5BSlSBr3Pg793Pl85YM1HKEJjFnqEMX6Wy
         9bHG7cieYCkcXi4o9RzY4nnTMZ97qTrIPQqmMvMKcqIj+ijmqyhNQ1Y7YBv01J+y4IUo
         riTSWVQoZYcQZWLmONWhQvgI6rKQIAqgCrLaAAtQFs6mISHy5T9W9B2g86MoWhd/4fIE
         fKOTkWB3nOo47JllPywCQzpzaHBk2xuZ6kPdo5CFVB+ebvTPu58ilGRYNy+ZI8ZLc5Os
         233g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730385984; x=1730990784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+R2z2Hq8YdiXOzRMQtJlJNAR8ul2IAPxkBdT8ZGZaI=;
        b=XGYYmy+AHN8v4FROaXMMKxrl+9GuTcFczyWRG6byLqnHrHBx93tWLDnNrLf8LNHhCV
         APJiDbcdH7kmdO/YNJ+LfZNDAd18V8dDU5tvMJaxlP8CEUl1uzQozy+bBZTFOWlr8zmt
         CfYt7ieRAAczl/hE+swHgVnKrtbM1MpTW2OK4w5RiZS0wT4pfWiMzr1mMU0dlD8l3PUv
         lWMRojbKLf2/U4z0KCfBfVn109Rygo4Vyq7IyVdc1gZ+0IMgV/b0ntW9KMAi8d8H5ZLk
         ixGTno7mV0m46eGeINTEm7KN90gNUncxdXNn4Fo42H4Qwfu5i0Hox1UnFQRK8ocoZZlE
         N5/A==
X-Forwarded-Encrypted: i=1; AJvYcCU6dVq0RmseTX2lFrm+jYmC/LJ8h/c6Ha+39XQJ44Pyan70g9e8BNXzFPEbwmFbZ5K1ItXSI0y1@vger.kernel.org, AJvYcCUMGPqMwFD3ux3D3u0gs1uey8yXxYtW1Qs+rWd17aGurcqZjOspELsSgKcLUXxsTf/ObYSqRD0X2cXSpoU=@vger.kernel.org, AJvYcCWIvQYLuzTrPQmlO+qLfkRJRDtOBrE5j+Pw7pFvfq+VnU/GvNwofHwarNNcX/Bo1gecLTNvvzHGiRHr30URyUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzprEfrr9s8yakoeUj7YioPQrJ8JCNwsu3qZxPoohtsc2dZlWAT
	f9Vb90cXajELKaAAoTAS5N7G27JW3gAYOn2b4duuZe+f+nXH542O
X-Google-Smtp-Source: AGHT+IH9Re7qI11bFWjzdKhmKNOoTKp5aILEFXvdHmzSO7KktOHqim6bI57kv3Ke9l9/aFvrvDBnCQ==
X-Received: by 2002:a5d:6da6:0:b0:37d:501f:483f with SMTP id ffacd0b85a97d-381c7ab2fb6mr155006f8f.44.1730385983595;
        Thu, 31 Oct 2024 07:46:23 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:d7b9:afdb:c541:d023? (2a02-8389-41cf-e200-d7b9-afdb-c541-d023.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d7b9:afdb:c541:d023])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d439esm2316878f8f.44.2024.10.31.07.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 07:46:23 -0700 (PDT)
Message-ID: <fc0657cd-083c-4abe-8f27-0b5a49cdd35a@gmail.com>
Date: Thu, 31 Oct 2024 15:46:21 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] wifi: brcmfmac: release 'root' node in all execution
 paths
To: Kalle Valo <kvalo@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Hector Martin <marcan@marcan.st>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <alsi@bang-olufsen.dk>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241030-brcmfmac-of-cleanup-v1-1-0b90eefb4279@gmail.com>
 <173038429759.539202.17634636965892286169.kvalo@kernel.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <173038429759.539202.17634636965892286169.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/2024 15:18, Kalle Valo wrote:
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> The fixed patch introduced an additional condition to enter the scope
>> where the 'root' device_node is released (!settings->board_type,
>> currently 'err'), which avoid decrementing the refcount with a call to
>> of_node_put() if that second condition is not satisfied.
>>
>> Move the call to of_node_put() to the point where 'root' is no longer
>> required to avoid leaking the resource if err is not zero.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 7682de8b3351 ("wifi: brcmfmac: of: Fetch Apple properties")
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Wireless patches go to wireless trees, not net. But no need to resend because
> of this. And I think wireless-next is approriate for this fix.
> 


Sorry, the second link from your signature explains very well what I
should have done. I will keep that in mind for the next patch(es) to
wireless.

Thank you and best regards,
Javier Carrasco

