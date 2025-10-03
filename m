Return-Path: <linux-wireless+bounces-27803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E2BB7F3C
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Oct 2025 21:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480C3484046
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Oct 2025 19:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77691E7C19;
	Fri,  3 Oct 2025 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ccyYGpSz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED64212E1E9
	for <linux-wireless@vger.kernel.org>; Fri,  3 Oct 2025 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518485; cv=none; b=H35sYKztV3sPMgSO+f4ehIrS6LfUqT/woyzsBRAF8Fr1NSLLfOmPo78qYSavHbFmbscB6MF7RErRVBqS069lKzCedHKGWpi6eJaQe16FcmduNKCLUl587fJ1OJpuxx07VrA/H0E8HrhELZutt417Y4BPjF2jeuOK72mABMKfmf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518485; c=relaxed/simple;
	bh=K4TjQtbVvc6fORxgDh6NKFpWmwGsHoCpO+iP/IiIPdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxcZVoAT8MLNlbN63EQGU/AhFL4NipEWGMgM8dFhDOnxrAAMaAJgKlSx6MaFta5v1hnnPA5zv0xbN+52HaK7yY2qpaije64VcY8QmC47QrH/fRZd+z93ctBoRTCStd+GNHSmWKu5aEREWYtuE+jNaouLSHas4QXkMcI4dP4xVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ccyYGpSz; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-78125ed4052so2995555b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 Oct 2025 12:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759518483; x=1760123283;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3t5kODhNM1j+WpigRV7D6w3n74zsU+ueIPqGhb7P+nE=;
        b=ZZniOlu9y2eAantSHBtIi7p9SGOnP86YpqY5mWEsaXKpCo8n1AEsO0yUDAZ+WufKfj
         I9PtA6AZRShOaGlS5eCsu5IwOS9ydt19PBszXHt+WQ+IaUmfcXt2+XzWTi7ZXfGjjTcm
         zpkMcJn5AX1JHPTa3y5ZWdnS/26uGGWpXdQB4Ygbf7tnDCs0o9zaX+nYBlgqJSX9gcqb
         /r2plHc3H5cSFztaoEg4+MJmYOP38dgUPk9UkRFnVhN0aJNq0/HWB3ckWzYc3Koughrd
         jt/1iCrTm9cxuvtcdjjCEKQeE1BIiC1i1yeY+BCaWvOIbKwpV1bzNDYV5SZIIjIQfxuS
         hbjA==
X-Forwarded-Encrypted: i=1; AJvYcCUnUyfoZD6PMZgPopy6JsJe+hgYBQxgn5uD9hQinTgZoFJwO3duNak6HzoYfolvxl0i6PCqyoBPhn49BwR98A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ1/FpVs0KMEfli33Rbqi/VzzfJbC7kxCBBLEd60DFP2rrAzYR
	nUnIDbHxi74mD+2xTd7+ZmdvCdIwVp/gwci/VCMhRyopuuv0jhZtnDGWI5qjc57XC6bOmqQjCAM
	yoi3jaimfEze8FdDBkqese0ifx9WWuiFvpKoydlWxgu8Ycv9x11pBkoopCUYTV2XBsvMrLI6vBw
	fASghwTySDieoLcOLX8G/cYUumqwf/+grk5jrawnVgiQVb1wBCo+5s5nhPd7tjIk3yJMqMatkNN
	evyEMdQf9H2abpEYg1K7pQvOKA=
X-Gm-Gg: ASbGncsl0dgeqW+elB2aDPCOTWpoUVgMtBwd66T92IW40GKsZsFMoctuHIbW1+v25zj
	ljZg72FkYL+gKg/q7pS9t8TMFotkbGOrt53pVFXcrSH5Cz+FQELMnf8G3zhBumu4mP31TnpqdVU
	NYKDHE6W36K+QFf3Pe11xZve1e5+PhDuiCdyx0lhqa64+k4c9x3RDhm+o7OGC+GmkPE06NjVEVZ
	CaOv2n4Zz0OwMNX2zM+Yk5K/AqiWFYDqGWzJEIlbtJEDn00KgLlwyhBImJhB3imlgk0oeclHinD
	mbZDlrSr6THSwJKkJ3n4DbW0DsQwkDYJaiJLFoLPF8VJA6mWQ67lgE2D24yv4l19oKUyoV2cwU/
	As8qwNHRXO4zV4OFpka+3RwkMIGZylvAftV9Eu1YGo/aFv5BjDsWA7tr7ACE0LIoDKZuijNk/h4
	I3RA/N6Wlp6PmP
X-Google-Smtp-Source: AGHT+IEjLuS2P9fzUHqY2JGR9xcPWSSvP7KtvvD66fJVn8gYONN1YFSDQ3PGn+vQGq+ZCT5tj0NSwcdJ3xzH
X-Received: by 2002:a05:6a20:2584:b0:245:ff00:5332 with SMTP id adf61e73a8af0-32b61dfb909mr6307876637.7.1759518483205;
        Fri, 03 Oct 2025 12:08:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-78b0202dea7sm459001b3a.9.2025.10.03.12.08.02
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2025 12:08:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7810af03a63so4430493b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Oct 2025 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759518481; x=1760123281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3t5kODhNM1j+WpigRV7D6w3n74zsU+ueIPqGhb7P+nE=;
        b=ccyYGpSzXCAhqvNjltrTO6xGKaI2A6t35R3NebtU93bLy7HKaQVLrZxAgCIFxqQ4Tt
         YIaCMD2x+3jQMSnwBVDrGO7YHCdXe4P4sRibr6RI0Ij+etTzfet7hfKEd65mzKf1lXZC
         JPS6yLx+wOZla0A+0IeEI3fFUYXDuId7IdUqc=
X-Forwarded-Encrypted: i=1; AJvYcCVzpua3TghartUqVezUumG499nEX63hgKoqdLpRGG7XIF/CQkK1Kd+Iy5YeJOoRhj+MlCOFCX353NNJ8vVulQ==@vger.kernel.org
X-Received: by 2002:a05:6a00:14d3:b0:783:cb49:c67b with SMTP id d2e1a72fcca58-78c98cf84d3mr5589577b3a.32.1759518481404;
        Fri, 03 Oct 2025 12:08:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:14d3:b0:783:cb49:c67b with SMTP id d2e1a72fcca58-78c98cf84d3mr5589544b3a.32.1759518480986;
        Fri, 03 Oct 2025 12:08:00 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020537ebsm5652625b3a.47.2025.10.03.12.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 12:08:00 -0700 (PDT)
Message-ID: <59a487a0-9290-4229-b221-1ad6f971f1c9@broadcom.com>
Date: Fri, 3 Oct 2025 12:07:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcma: don't register devices disabled in OF
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 linux-wireless@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>, bcm-kernel-feedback-list@broadcom.com,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20251003125126.27950-1-zajec5@gmail.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20251003125126.27950-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/3/2025 5:51 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Some bus devices can be marked as disabled for specific SoCs or models.
> Those should not be registered to avoid probing them.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


