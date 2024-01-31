Return-Path: <linux-wireless+bounces-2887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C48844335
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 16:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7498C1C21F57
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7096F6A32B;
	Wed, 31 Jan 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjcwotS9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF1412A156
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715480; cv=none; b=hjg+h6jD3gst/qPwfk1MJGn1Aoox3YQvXZxAHUmpb/NneLNO0z6lgyR5Zupd5YGIJMYo+ay8JE2Z0VdB3SEVTir6iDH+f1jiBr5regf1VFPHUjXm6sOu3zhX+Us/R9KduKw7qZzCSvjnUbldA9NJnCua9MAI3uSRKjeze5aMPHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715480; c=relaxed/simple;
	bh=rT3GvlxgsEW5S9ZW5m4g2eav5TZe0yX/mVDhdH9iUsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBtPAZKUywAWmxl66qKQ9wc+BXN/DdgKq2DAuAaKUE250v3cmxcLHhKvHRdNYMfBAzdDvyVK1Z9hqre3ycfRgYLtE9o9GyKUy+0WuHdX03QWNipSQK6IPGJm9g84nkgKT8hzGgMZINfsRhGXYDVj54jq6u1AnhqVlOTbyWFFodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjcwotS9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3510d79ae9so613190166b.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 07:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706715475; x=1707320275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3KN4SfqwycPQ1C77XlG9aKJyoUtDnKTDJt+AUc5i5dQ=;
        b=GjcwotS9EOekX66CsZs+KxmHlJqdfU2EM6+gBY2HWtiCE8lDHUNfgYwT7gSTSJ/N3H
         3qZDaFySz/WpXUFwswSsVt8DCpbKWguzmpMQL97z3ud6lUOSg04IFMqRdP3LVD6bMarI
         DWdAX1dcLp2V2ANhp5GE+RistePBRsphfMqaD5UmfS0nH5LIl2hIb0v7sj3HPSJt1d44
         K9glKXL4tgHucZH7juhchurWFnFMqrLvP+9B0dhS2fGe41pynVxz33Sc2veeOmNmKLPH
         krgQDor3oTldvncXfVU3FA/kIhWsXfsX6ujeUwcaGVn5pURI8iPyjPv36IdAUFhVR9k9
         zgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706715475; x=1707320275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KN4SfqwycPQ1C77XlG9aKJyoUtDnKTDJt+AUc5i5dQ=;
        b=uNbTylSaDlLt2/4nhjn7sM4J1EJ1ZZelahOdipbtysxylbAUlaPBW+BlmfofusjFVS
         +1Mobx1bHU6UxPqDfQ+iZS5/zTmZfgOAjeL9H7fhu7roi5zbUbrMX4/LHJZ98loxYaui
         wjT0yf+R95TMOb4/1vr68/8EkTM6PnjdgwA+xxsxxOdGxYezLEGwymzzqAcTrLQRHPFT
         3pXXXj3Rv5D3EokFOVzmzESkpFBJR62fuLy3t2LekSiRmapbrso/Z4m7tziiTVNROxJO
         uUdxaBMxgCynHzTWuudxWZtBVunyG80sk2fmy9LoZZv3HmfThZawzhI+HFDXkEYV/vUm
         /rqg==
X-Gm-Message-State: AOJu0Yw+CXjMVQsr/X0M7X2hxk4QNxVYM2kMZS5pgsTxuxvFyfYcfKtM
	FaNIfogDWZ1Il9QA7NWfRh9TChEa3oEEuXtVvarfXW4nsboQIcC+p3SLUu8u
X-Google-Smtp-Source: AGHT+IHQWl83iknK7RHWo6/PQSAESQp4gyOxB4ZaaIDdvxiAbTU5e6oeAaQ0uh1/iwzSW3zJd5AAKg==
X-Received: by 2002:a17:906:48c7:b0:a35:62a9:a659 with SMTP id d7-20020a17090648c700b00a3562a9a659mr1302195ejt.72.1706715475024;
        Wed, 31 Jan 2024 07:37:55 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id s6-20020a1709060c0600b00a2a37f63216sm6348713ejf.171.2024.01.31.07.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 07:37:54 -0800 (PST)
Message-ID: <04b966d8-835c-4729-810f-65e9922818a9@gmail.com>
Date: Wed, 31 Jan 2024 17:37:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: Add TP-Link TL-WN823N V2 to the USB ID
 list
To: Chun Qiu <cqca@cock.lu>, linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@redhat.com>
References: <20240129053030.16369-1-cqca@cock.lu>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20240129053030.16369-1-cqca@cock.lu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 07:30, Chun Qiu wrote:
> TP-Link TL-WN823N V2 (2357:0135) is based on rtl8192fu and has been
> tested to work with the rtl8xxxu driver.
> 

Nice, thanks. Just out of curiosity, does the LED blink?
And do you know what RFE type it has? It's in byte 0xca in the
efuse dump.

