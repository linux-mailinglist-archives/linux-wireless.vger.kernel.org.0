Return-Path: <linux-wireless+bounces-13646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ABA993937
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 23:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A687A282F4A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 21:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A60518BC16;
	Mon,  7 Oct 2024 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt9m/nbM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432318BBB7
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336749; cv=none; b=i/rcuLUnmTeBJURsSeqVr/FLSLHD8kIu9lRsPGnFxhNvCLCUDXSvtGAV8u6tCI+MVybaZeBdlXVK1M8iuwnnPvwvB0EiyYWIIo+1yZZyAABqDpIQRCxEVj/YGub9GkU/hqEXp/bJL+7m2iIDbGZNTglNaeeLFDwicK4A9j1XQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336749; c=relaxed/simple;
	bh=gL5/7aoZZbjUZOM1kABtEgwg/a+SkrQ2Kv6ccoibTis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIjiM3iHgNvDnFOVxyOrNhR+pvHWytfGOCbqMKAirWkJfVa0PcAp+5V7G6orb2kcKvgSPlsLRHahs+IbsVS0qc/Vci1i1IRCT2O0AUAShGv4U6+IMKWpB+AyVq0lc5XpGoSsjM8jyrSsKB8NgysBELkAnIi5OxG+mKMA+dMslSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt9m/nbM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a995627a0daso181584666b.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Oct 2024 14:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728336747; x=1728941547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekm5gKz417Yao8spvCZDf7dM5FZumrXk9Uz0nUEH35E=;
        b=Gt9m/nbMDmjt2yK0HSjWP2u1CKzAFd5oqD1Pgu0B1o3mOGgIJrSK5iqF52/UCVJK7c
         Ndljtbp57hpn7cZOrv3mSJPAfxUIMd1JOb0QQ+VDBXOK1pxVvtcy0SlSuJXK7gRiUyIL
         4Zzsxg4QxVySW84GcKmBkoQnefTPegDbnq6l/5E7LlqgZyEfL/j/SBpttjGdJaFuRdRn
         aKaR61kdxV07Drm5VaPBWe0qsKlGZI7R5p1Kd7NQvq7kDfwbQTxwBJbStFry9oRy+EVr
         pAuJUgbxDfzVUjJlKxJpn/LyY1IheQPrrG81h0vRdm7WCp2jIgaadGytD/13pbLuNHkx
         jyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336747; x=1728941547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekm5gKz417Yao8spvCZDf7dM5FZumrXk9Uz0nUEH35E=;
        b=TvfS4J6KZbgbf/QQINL3ztS0CQfiJbBfXwjQo/DDBxwcXU82ZThEJxuG4A9ijh/WPw
         lVsoQeQgfC0ohz4faCEkcJP+qM2/iB3n6b9YWWTIIN6tb6/HdC4r4RCIs90uDJFgQC8v
         8EtEg+MldEUawCoYyg16ZgPx0DShdKVavoNHmGRcdkmUhUaLeHaxrYnrnk8VRGELckxU
         ekKYJx5pwne9H8hc8uPNHEfoFIdmBhiiwUdX/a2ja2JyvoOCLfeWX4OrnJ34R4TJYX3Y
         3K2ArwcPcjZcF7exLZnwBHKfDcNTU6OGPqhJdhMp7ZQj3Y0n6DKZBGcOz9Ebz5wpUGKR
         D5ag==
X-Forwarded-Encrypted: i=1; AJvYcCWpx6WGPi2XPZOk//+snpxudZfCMUpLkMBPOunZtEdsWMH5KSFpgAMc+zLMt1P9hid2kXzOuDVcSKGJv9SGxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxiskydsngWNR/Rek5ddnMzVYnjWaDqoTbY6+yqbCwEzc/BYRb
	jhgw50TohlQNrxD4fYX8kJGAbE0wrwsgAlBkcwB7x3xs+/Whlw3M6/3jIPS2
X-Google-Smtp-Source: AGHT+IGgR2EkpaGxTSdHmhGbKh+kRFvmuzoBYzdgJGsL0ZyNNvwMDINlinsWWqTJqdZxhuJ58Vq+Iw==
X-Received: by 2002:a17:907:318d:b0:a90:41a9:7c3e with SMTP id a640c23a62f3a-a991c0af160mr1376735766b.65.1728336746406;
        Mon, 07 Oct 2024 14:32:26 -0700 (PDT)
Received: from [192.168.2.105] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994ada19fcsm270665266b.183.2024.10.07.14.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 14:32:26 -0700 (PDT)
Message-ID: <b6ff86e3-56a1-43d3-83b2-01818684f076@gmail.com>
Date: Mon, 7 Oct 2024 23:32:25 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] staging: rtl8192e: delete the driver
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>
References: <20241007182706.66888-8-johannes@sipsolutions.net>
 <20241007202707.d0e59cdd2cdc.I8e4d74a6e1d09eefe1f5e2e208735ba2ccef1d4f@changeid>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20241007202707.d0e59cdd2cdc.I8e4d74a6e1d09eefe1f5e2e208735ba2ccef1d4f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 20:26, Johannes Berg wrote:
> From: Johannes Berg<johannes.berg@intel.com>
> 
> This driver is using lib80211 and any driver that plans to ever
> leave staging should never have done that, so remove the driver
> to enable cleaning up lib80211 into libipw inside the old Intel
> drivers.
> 
> Signed-off-by: Johannes Berg<johannes.berg@intel.com>
> ---

Hi Johannes,

this driver is not only working, it is also supporting a form factor 
that is usable and is available on the used hardware market.

Is it possible to migrate the driver from lib80211 to libipw?

It does not have to be you who is doing this. How urgent is it to remove 
this driver?

Thanks for your support.

Bye Philipp

