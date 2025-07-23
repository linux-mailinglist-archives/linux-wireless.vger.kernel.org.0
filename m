Return-Path: <linux-wireless+bounces-25938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B347DB0F108
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 13:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A859A16D48E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 11:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA8B27934E;
	Wed, 23 Jul 2025 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eFJyJr3+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69302AD3E
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269453; cv=none; b=aOCPiYsQ0/y9wKfk7OYrCZ7AnOMDf92Ee8VN9wkfrJs95/KEIlME5YFS34KZDqlPZlfGxhPQYAoJkYkD1VgEsx8vGTbqVHMLMQVFEy1GKBuFTaF3lgwinTjq9R+9HHiPQrX2gLVXLHVpHqRsQsGpVNuG8zO/1Kc/qqoxD70m2Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269453; c=relaxed/simple;
	bh=qrtiWgq0s14/1f+Diwwe6jAN6LEfnJ+RTz3O4WBK3vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVt5XjFNVqjIdBjfxXyQBFmkwzAuVqnOTyGNIHztn9QI7Z7OTI0ZlmZSE62SRFXcDyghSFy1eUF+LfoaUIhxfG8g1wgYahifg2Z0iprb8t1ptJi8SrPcyHNLk8fp6oAyp6bF+4GFxHi0eZQNJR3VGr+OuAYkLUMu9Kwgol/iUPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eFJyJr3+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e62a1cbf81so101779585a.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 04:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753269450; x=1753874250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Vf8TK/Ge7lp03MME7p3o0yl2WS/hBQEsl/wyeQ77Fc=;
        b=eFJyJr3+6AmQjUO+vndMNnWrGQV9xyX1ILrrCkf8v2doDmX3i1oIXMr+ugKqNJafrX
         f5c8U0GM2PovclaaeEvhcoDAEJ+nDHmq3wrVgUZS5+fuC4UPVAXTkTZ3hKaSC3zdjucG
         Fa6gPyy08XImwVFD7OfM0Dz8HsgfG0Kkk+OxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269450; x=1753874250;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Vf8TK/Ge7lp03MME7p3o0yl2WS/hBQEsl/wyeQ77Fc=;
        b=qHgIr2+5pYS9LDh8nU8gzCiHhE9zmnpIDRqZMrkSMAXG5PNOdu7H4gojMOgvBHOdYu
         wAS2GD3haRvjvTXkt7p8wlG5ObIYUgqUUv4HAGaGMMlkpAojK5K3Ssb8cGfBKY3oXBM5
         IbXgV7mR9nvoJXJseD+uZ8lSpZ8d7CAey3R4jkiThWwpdLyaKJHLBLp9hdum+uxg00af
         ozhu6VnpAkjtC1wXjotj8kmGU/2n7IQpRek9Ot+TnmyX9Y+s8LPb9m67smCNiA9zl5vr
         DvuLloXoDnr51n2Bb4IrMvje/6y4JksD7VsaWYfsGyVqKoDvJqaL44gmBAEJyTS5GjB6
         tvOQ==
X-Gm-Message-State: AOJu0Ywsd/rzH+IGTDy0kReMjBrftvNXryrxZcyu+CkEb3U196GSpXLb
	zXcgVfbebL4JVMF4DqRzXumSHPPeLi3AvhopknT8+2Gzl6PbiJhXrGEtrYXtB1/drA==
X-Gm-Gg: ASbGnctCV1q8IsH6Oulsjy29hc/9dtqYxef6scl4v/E0utY3yAdf2A8+NUpdpuO+YFQ
	JlDaYisAibOK/z2rH5ferHvNKNM5SK+fuIuJg4WxXA1AE6GPZLWf0qAv77730u3HhyPJRggq/c4
	haVgY91P4piNHQVVRdgVO7GEufUEwvtQhw4sFVGVAxc/XoGX0A9T9pdTNyn8wfCVLijj2ZXKJBq
	svHW4LGWsPXytT51KWywJH8TtLA1jUzOsFejTqldLgvtly94rCFDRNMmuNDOzV5cpv91x0ilxOY
	YdBBjJMOKmr3mN2wa5KB/ODPglu8PdgBe7cIBFQMtPqTndCMf7+MwLpFKlPezEBLMUs7/7a95kA
	xn4NtFoeNoWhwl9V9oGLuFcWRMTTBQt5p1R6JFqU88zvte0tw2EBt
X-Google-Smtp-Source: AGHT+IHAVOcyRtbpkVAnGJYmyrfzoQnS0iBySMet6QGfINmaJMVbHnzsDxW907eqmMl2YYxaeWPV7w==
X-Received: by 2002:a05:620a:720a:b0:7e2:3a27:a10b with SMTP id af79cd13be357-7e62a18980dmr244953585a.51.1753269450511;
        Wed, 23 Jul 2025 04:17:30 -0700 (PDT)
Received: from [10.176.2.145] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c6402fsm657341985a.81.2025.07.23.04.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 04:17:29 -0700 (PDT)
Message-ID: <e45d017e-9598-4a98-a1b3-e8ce2025d4c2@broadcom.com>
Date: Wed, 23 Jul 2025 13:17:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v4] wifi: brcmfmac: fix EXTSAE WPA3
 connection failure due to AUTH TX failure
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 wlan-kernel-dev-list@infineon.com
References: <20250723105918.5229-1-gokulkumar.sivakumar@infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250723105918.5229-1-gokulkumar.sivakumar@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2025 12:59 PM, Gokul Sivakumar wrote:
> From: Ting-Ying Li <tingying.li@cypress.com>
> 
> For WPA3-SAE Connection in EXTSAE mode, the userspace daemon is allowed to
> generate the SAE Auth frames. The driver uses the "mgmt_frame" FW IOVAR to
> transmit this MGMT frame.
> 
> Before sending the IOVAR, the Driver is incorrectly treating the channel
> number read from the FW as a frequency value and again attempts to convert
> this into a channel number using ieee80211_frequency_to_channel().
> 
> This added an invalid channel number as part of the IOVAR request to the FW
> And some FW which strictly expects a valid channel would return BAD_CHAN
> error, while failing to transmit the driver requested SAE Auth MGMT frame.
> 
> Fix this in the CYW vendor specific MGMT TX cfg80211 ops handler, by not
> treating the channel number read from the FW as frequency value and skip
> the attempt to convert it again into a channel number.
> 
> Also fix this in the generic MGMT TX cfg80211 ops handler.
> 
> Fixes: c2ff8cad6423 ("brcm80211: make mgmt_tx in brcmfmac accept a NULL channel")
> Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>> 
Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> ---

[...]

>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 30 ++++++++++++-------
>   .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 26 +++++++++-------
>   2 files changed, 35 insertions(+), 21 deletions(-)

