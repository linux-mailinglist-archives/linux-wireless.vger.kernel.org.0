Return-Path: <linux-wireless+bounces-25992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C869EB10831
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 12:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F9DAE5645
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 10:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943ED269CE6;
	Thu, 24 Jul 2025 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T5pH6b40"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D726AA8F
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354423; cv=none; b=EMKTMr4NcOcthrb1CWP5tFFt+PHWXkRtHiqB+6UyRGwy2L/acoBlc1pce14Zj8BNOsJ2QwVgn2btxvm7daU5St4qUlnYl80mjCabXNAkWvM7Ix33zAhe0cuMliSb7umv50chwJFXyJrsmqvWkxO7iixZeYPnLIzh8krVJIiAEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354423; c=relaxed/simple;
	bh=8jDhktb6gvguDf/b1lnlB4d22HgDluIX7IIiw6J/zv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huO8vlzT5bR9clJXE3H489svJV8SfGJomnSH57YLiAOxkIknLXw1PoUIQ9HC9xv29qPmt5FwVm16p5o3eT3JFw2SBzdRLYPb9E3PSfE9wWA9MJLnU7+VNaoisBxBu2TH4bVdcTK7rDd0PtM9eO2XsI2l+xlKR8lvoVXP6/Kl4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T5pH6b40; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e182e4171bso81501885a.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 03:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753354420; x=1753959220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MLDOPqxlBD8FDczYchESr/JqbEeFFZ2U1GuHWKOvpoE=;
        b=T5pH6b40m98ME4gdLo1TD/zmSnGqy7GLno+Tnwo2HXUE1gMwT1vqCKoEnEF8V/oOWE
         sXaKIzmkKSfSFioRzZJ0mzO4oNePA4TRU5/c2i/QnG1rwcNDRppabyrKMYvxTBNm3Bg6
         gCv4kCiZ6Rm6IWJsEytNBCjdszi8pPMHlizLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753354420; x=1753959220;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLDOPqxlBD8FDczYchESr/JqbEeFFZ2U1GuHWKOvpoE=;
        b=LjiUtGxfF9OwElWXn9WruhHXbcKQjUrb3pwaaQ7X1L4XWi54k2q54L2GPvjdjhL5iR
         On9jBaomP2Tuae9M5Gi2NQutgI8IcplxKg9X00QWoJLbIK0KoihuFuJrjaSyrHSfhGjD
         5yh4wdfkb5XSRXThCq5PHlk7gC9el8NC8sdzb3byxUiFScge6vaqPi2N9afxAnOt2/V8
         ZjCs7kXrjmndtdreoju2dzDwqKfdM2GuYrsHHLQhpPJJkC0CotGNjyE8z08KVikATkfS
         O4Yo3NlbzgF3BgPAz+LGVTto0TxP9GDLyXxw5vQvMZ+jIU1GIBpzaXRPxL8WNj/+EJhS
         THRw==
X-Gm-Message-State: AOJu0YyAPDM7l27+6ehQ4z5dwPjOAwX0uO58nbipdOXwgZnky83irFCx
	NVeTgMj7Fgn9UQPkHgk2T60xW900BUdDe89VhO2DhgJ+CiKIbqaYZgN8VPzYobTakw==
X-Gm-Gg: ASbGncty4eYZNdlOG+VzK9lTP53/rpHp/pun/NzwSupOtqtUvRISAZ7K4pIuWKjlsIm
	HH27wrVCRx/N0napMyVzjl/BNdXLmlEzrrXBuWTdbq65+FsYf5Amcv9OzOfZUeMFlT4kZrZ+NZJ
	GUwQT3xRmu2o3Pqo5uO3BxAePCfzaxdrnYL9OGvCz8U6CgSzhw308aaMtJecaJmvzC8S6ThOP/9
	OeWFkHEHuhfSN2eWDZAXHa0Zy1+gVuagD2Y3KKAjKPaLXRDX4JOQ7c2ZpKFdwudHwctlUVVlTLi
	KbOGsFLuRTNYSLRBauMqN7R13L+aMud3wRhxtTLBf73olVxUs2hiRVUQ489QPC/P35eAofv9nOu
	kM3Eym3QVBlygmqJ1FgHbOwJfMq9GdsQgfP5IMEWSFXYmnGJrJEUOwJ36/A7viQ==
X-Google-Smtp-Source: AGHT+IGUM8uRgCOTQBFV32F5z0OirCE60eT/KIEgETJ/ZilFjesKiL9h2WFc71njrAkiKrIkgnincg==
X-Received: by 2002:a05:620a:8e10:b0:7e1:7ff7:105e with SMTP id af79cd13be357-7e62a17fd11mr426277985a.39.1753354420530;
        Thu, 24 Jul 2025 03:53:40 -0700 (PDT)
Received: from [10.176.3.57] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e632e1b89fsm99848985a.47.2025.07.24.03.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 03:53:40 -0700 (PDT)
Message-ID: <7f913cec-a867-4b9c-84cf-e890a8a12d35@broadcom.com>
Date: Thu, 24 Jul 2025 12:53:37 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3] wifi: brcmfmac: fix 43752 SDIO FWVID
 incorrectly labelled as Cypress (CYW)
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 wlan-kernel-dev-list@infineon.com
References: <20250724101136.6691-1-gokulkumar.sivakumar@infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250724101136.6691-1-gokulkumar.sivakumar@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/2025 12:11 PM, Gokul Sivakumar wrote:
> Cypress(Infineon) is not the vendor for this 43752 SDIO WLAN chip, and so
> has not officially released any firmware binary for it. It is incorrect to
> maintain this WLAN chip with firmware vendor ID as "CYW". So relabel the
> chip's firmware Vendor ID as "WCC" as suggested by the maintainer.
> 
> Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
> Fixes: f74f1ec22dc2 ("wifi: brcmfmac: add support for Cypress firmware api")

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> ---
> 
> v3:
>   * Rephrased the subject to indicate that the incorrect firmware Vendor ID
>     (FWVID) of 43752 SDIO is fixed by this patch.
> 
> v2:
>   * Relabelled the 43752-SDIO chip from CYW to WCC instead of dropping the
>     support for this chip as suggested by Arend.
> 
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 2 +-
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c   | 4 ++--
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 8 ++++----
>   .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 -
>   include/linux/mmc/sdio_ids.h                              | 2 +-
>   5 files changed, 8 insertions(+), 9 deletions(-)

