Return-Path: <linux-wireless+bounces-1334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C328201E9
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 22:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E41A283D4E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 21:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C8214294;
	Fri, 29 Dec 2023 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7C16GtX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7214292
	for <linux-wireless@vger.kernel.org>; Fri, 29 Dec 2023 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5945fef58caso2945300eaf.2
        for <linux-wireless@vger.kernel.org>; Fri, 29 Dec 2023 13:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703885771; x=1704490571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=I0xY1vKhNpK1cvVQgGPsQNpQX7UxqJeJpQBJcfz25QU=;
        b=T7C16GtXMMD/ACbuQutkbb6pwfa6uUZX81l+mQqrgFQSTK16zNTpBon6Ubfhb3T8Ay
         59Vny/qXvuMzZnayF1n1w4SE53D3quMEsCtWrGWvXdEWbSo8KlkRsewl29DCXQ/MHjyr
         TWWdRHK3eJaNuPLMcBYjDe81JIhHLHQhq32zLmT7B1Ezu5fU1jqgV6Uqa5QMM5udLSgq
         nWwLD78bvic9NnOomIEKtVYLtOAsM4V1SqnO2+vuPtte8DgbpNDiiObs4IwBqwgb11G8
         W3DhJwAhEdYzQljLWCvOEm4giIPoRMfV+OfeUK+2riHq+Siqp+FwA5jY4ijNi/sJs2yZ
         ySxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703885771; x=1704490571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0xY1vKhNpK1cvVQgGPsQNpQX7UxqJeJpQBJcfz25QU=;
        b=fuMlIqeCBaL7oZKs6jcUQQLvysQZhfYrcZ5wUEo1dg7D0XHOC/KMAKf6d1j/zK6I6s
         bgX89aYkBtf8CxiqAsFvTZcn1J48oS4JNF56xjiyZjOD1kVy9V32DNxjKQJDivVWM+LW
         ONfxtJj1x7p4yxLQorAfORpERttQPfZ/LTq8m8Kt8Mvj64B0XRR1Z8MH8Now2qr7b6rn
         e9CfH7JC6XW7xJU+yt4hZDpc3CgJbnPgv6wB442H9Wh5JP6ZClrK013W0CvG2p8+SwOt
         lwmWWMVaZmG4u88F3GQkEmdCOOeHIW7nD4/eE0hDLo7sxk14PdJ6MIFiukgOAjsxExCW
         gZug==
X-Gm-Message-State: AOJu0YwJjXj0FZ/Cw96elTD/gWIaTCBOkjKk1foplRU8WehuciKTgYUJ
	RAdqr4IGJlEIEAJgKQJj/BY=
X-Google-Smtp-Source: AGHT+IEFA5ZFtvywanu+OK2LE+TBZvW+fMN9YnWHVNXl+q37Ngb9zVrYCARO3fMlwh65F4UjZlRUHg==
X-Received: by 2002:a05:6870:a1a3:b0:203:afa6:ad29 with SMTP id a35-20020a056870a1a300b00203afa6ad29mr10292295oaf.23.1703885771189;
        Fri, 29 Dec 2023 13:36:11 -0800 (PST)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id ms25-20020a0568706b9900b0020463640518sm3003214oab.14.2023.12.29.13.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 13:36:10 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <ddaf8f07-5a7b-49a4-8ec1-2a28eee2279e@lwfinger.net>
Date: Fri, 29 Dec 2023 15:36:07 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtlwifi: rtl_usb: Use sync register writes
Content-Language: en-US
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f806007e-8fba-4f29-8a38-f81d04bd4fb8@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <f806007e-8fba-4f29-8a38-f81d04bd4fb8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/29/23 14:51, Bitterblue Smith wrote:
> Currently rtl_usb performs register writes using the async
> usb_submit_urb() function. This appears to work fine for the RTL8192CU,
> but the RTL8192DU (soon to be supported by rtlwifi) has a problem:
> it transmits everything at the 1M rate in the 2.4 GHz band. (The 5 GHZ
> band is still untested.)
> 
> With this patch, rtl_usb performs the register writes using the
> synchronous usb_control_msg() function, and the RTL8192DU works
> normally. The RTL8192CU still works.
> 
> The vendor drivers use the async writes in only one function,
> rtl8192du_trigger_gpio_0 / rtl8192cu_trigger_gpio_0, which probably
> doesn't even run in real life. They use sync writes everywhere else.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> 
> Larry, do you remember why, back in 2011, you chose to implement the
> async writes?

Bitterblue,

That was code provided by Realtek from their USB group. I think they were in 
China, not Taiwan. At least the PCI and USB groups were in different countries. 
They provided the code, and I just cleaned it up. tested it, and submitted it. 
If the sync function works for the cu and du chips, go for it.

Larry



