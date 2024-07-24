Return-Path: <linux-wireless+bounces-10478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EBB93B02E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 13:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDE51F2120E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 11:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD8D157A53;
	Wed, 24 Jul 2024 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ogmqw4H1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F620156F46
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819724; cv=none; b=DtR7GclOJBOiDUay9qA1tmuFEN9M3O9bZmM7FDCIrPsa66yvEA1kNhwog41leQ3DaVNP3zg/OAUsIAZvKVkrmXHJsa2MOa4AJ/lbdGr7Cvha75zU9CFAQzIbN2arFhNQBY1RvVZNDBezziEkyr+iT/kXTN9tzx/CffQutroEPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819724; c=relaxed/simple;
	bh=nYrAHsM0RZYC7QJeUBLUjTkSrTLsddHZZh/W5bu52Ds=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=W+OyK9LpYViHrwmuari6B4S0jL+P0lcs8EZRSWPd4n+nR2PH+6T6lCUWAkdT9ZM/6PhOyYhWRVkO+sbjiWC2SiiuGcHOk5jQDnK3nxk2TBSE8DGY7jYcS8hDro65tYEP/OPDy3Xm4eomS1BOulbOKarzLJ/s52O0g7fWO0eVjX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ogmqw4H1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3685b9c8998so3007737f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 04:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721819721; x=1722424521; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYrAHsM0RZYC7QJeUBLUjTkSrTLsddHZZh/W5bu52Ds=;
        b=Ogmqw4H13Mme1PgMWYFC045Y+G92tHU3KQqvBgRbmxq9ZqnJPdnNaVSC1Wfntr+2UX
         6+TpefGTMF5YzWJQlQlABQzmGIcNWFROCD5IXLnb7PC1JjfXGRd9HBB2N4vkD9U1qVru
         uV43KroKuWaBXKQ71dGdZ2RzobHIO9gL8bsdaopEm9FS4F/evO+WEarcNx+RPK3bN+os
         5DLyegOnb0UrZO2hN60YyhZy8cf654Sio8Lg98hMCTUggOisA+EnCieKbyg1KcnY1nae
         qXFqTrJl/fInFukW0JMYrO6e0TZLJUrvx/73msOKhIVLNfFq8NgtFkx+uWmbOo3DWzCi
         l70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721819721; x=1722424521;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nYrAHsM0RZYC7QJeUBLUjTkSrTLsddHZZh/W5bu52Ds=;
        b=U7mVhZc5GMVAnooExv2BZB/ETQL4pRNFcFei76VVh7jjp5MDNuN5qzWPDbL0YEKnt+
         /8xBg6V14We+zUT8QWeLl4delZkt6CLb2PHv7WK6BbmAYEawa0dP9aLRGgsfWlsqg1sE
         K+XkK7LHu5IdVf71iw7LaZcvYRzunDYEpgg9O50eoQaHOzUN8JRCL8RUw4x2jlHZolRV
         FUowXLssY21yo1Bf6Qfw/r/7a90qqLcMEqR6LlL3HtxojXBHSL2hjd09heMQw7A1LqKI
         UuC1XHFYy+8G8vLOR9WAjI5QX1qaF+Lf6mrJoW6HfmtMVljDBilud6GMdjg4439MRoaG
         vN5A==
X-Gm-Message-State: AOJu0YyTkonFt09Df9SwQb6ueA7O1L0BotEVnnkShrcVY5e4ZiiEcKJi
	PManoXcUX0wBDHWEUcb0MpVfxbeunCv6JA+o5KQtC4nItq9b8o1k1ForJWuI
X-Google-Smtp-Source: AGHT+IF05yvOe54qUFI3agX0Yw/OqiC6aGW+b1HYO5wGTqb/fpNlTyW7LYYcXAvFkXu2CM3H/5tqug==
X-Received: by 2002:adf:fe4e:0:b0:369:9358:4634 with SMTP id ffacd0b85a97d-369f5a76f43mr1330769f8f.19.1721819721365;
        Wed, 24 Jul 2024 04:15:21 -0700 (PDT)
Received: from [192.168.0.188] (asfd-05-b2-v4wan-170068-cust1033.vm14.cable.virginm.net. [80.192.20.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-369b77b4d2bsm12015620f8f.63.2024.07.24.04.15.20
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 04:15:21 -0700 (PDT)
Message-ID: <d115c07d-4e3e-4e9d-9704-f0cbe159b986@gmail.com>
Date: Wed, 24 Jul 2024 12:15:19 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-wireless@vger.kernel.org
From: Adam Macdonald <adampoke111@gmail.com>
Subject: iwlwifi ring buffer log spam on kernel 6.10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Greetings,

I have just upgraded to the Linux kernel 6.10 on Arch Linux last night and am having issues with the thermal driver (iwlwifi) for my Intel AX210 (8086:2725) being unable to read out one of the thermal zones (the only thermal zone?).

The following log message is repeated about 3-4 times a second in the kernel ring buffer log.

[...]
thermal thermal_zone3: failed to read out thermal zone (-61)
[...]

The offending driver:
$ cat /sys/class/thermal/thermal_zone3/type
iwlwifi_1

I am currently running 6.10.0-arch1-2, but was previously running 6.9.10-arch1 without this log spam occurring.
It is important to note, however, that on 6.9.10 it would previously fail to read out the thermal zone _once_, but not continue to retry forever & fill the log:

Jul 23 14:26:09 milky kernel: thermal thermal_zone3: failed to read out thermal zone (-61)

Thank you for taking the time to read this email
Cheers,
Adam


