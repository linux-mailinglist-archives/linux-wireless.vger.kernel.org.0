Return-Path: <linux-wireless+bounces-22913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC3CAB56B4
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 16:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407BC3BBB82
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 14:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753301531E1;
	Tue, 13 May 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq0AEfT5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F127519AD8C
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747145039; cv=none; b=AoQAKV+uumcSDUdO1G7Sx2vlkmfcjSWPw2dKy15xDuASGrvlGRFU7rGTxyEQRjLBExKmzeZfB9OJzN/daRMoxvPrfUOyUbR5u2AgwxR6mvQZ/YthYXZHWbRVASlHqlndHtIcZX8qqZAKJrhT6zfU1bD4EW/3CJDe/ytGaG0+OsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747145039; c=relaxed/simple;
	bh=zNU1NIcR+mxh0uAMBcOW0JdSObK1+f1hTWBbJCyMdWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJ60kV69vEJU6uFroUnbzu6cK6CMMn78L7/1GKwW/0E5zgx6i0BVjiL8msjBR3cH9J1rACkyKlc7NlJPnZQkeJ1u+jlUQPX0qgJzJ4R+IK9/hehfUU+58mOcb8P9mbG/f6WxMvPl1w9JJoNokvuWn2D+J7WUkuaN9klv+eCS0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cq0AEfT5; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2cca475546fso3247329fac.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747145037; x=1747749837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aW5B8TTX3bVin0Mq8HXvLIsjm9fkCwp2j09ZBvJh1GA=;
        b=Cq0AEfT5HwR2FjcGWZGIaDtk74qp5b0WkQlY9wz+LT1gREPzy95PjrqBnCGauO8iQR
         vcnrIV5kFcr61AUt/m47pOWf/BnLuNZzQWhZX3rIhV9GQc3k/b/+l90wwpnCSaA1Jo01
         eHCkAd2y8rV6vtMNUig5jsgxqukR+ji3Cpo/M22bKyRaZEb7IpB0CLg3AkwDWZAEvI+i
         HV5dB8YtT7+pIJ0VahaLZyXLMhxdx2buUknFBUXqzzee6f3yPTN3A58Ma8u726wbudmx
         oxb/zVdxnQACRFjwyt49z/p76IknPr977ZTAvPEfk7qXvBQHUP8G1slbrSub4an/aT8+
         KdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747145037; x=1747749837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aW5B8TTX3bVin0Mq8HXvLIsjm9fkCwp2j09ZBvJh1GA=;
        b=rOf+XaBe3tzPwYQh84DdWAPSyt6GsiexgIGTDpUIW/x46Eop3E4AI8oOQKPrpn+E9L
         JP/kzI3oD0NlDcbiO/EUHH68I0jZ94jhZ4CGHW3GP9b5cI2HguEM3jjhdrYYFnUXBepx
         IAp/ZhzXfVZdq8W4ZofVEIsAcPQed2XWt/FV7EJahM9UapSzmStxHiuu0e8YOje5CEGe
         1YW/uM+6kRH88cAU8X0awZZK8sQjY3/algdaYVGQNsKvFR1ZkEug1FWMAmOh4mD4Gix6
         4+rf2eN26B0hCw+V11QJJIoL4eEW1s8ylcaZGDriEWh5wFKTxe3z62Ne5YlTtChG3ftw
         UwdA==
X-Forwarded-Encrypted: i=1; AJvYcCXsOUT1ESrfVME6xEXDYKQtZX7xfWgl04GIuhPHe7gOZke66doIZp9/Kx+AfcvuSOIdIpLIwoa1Ay8JaZfJMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KhlwskTmjwuOUPAcbizucJ+r5W4ZfdEJjVKzFdduvVEyEcDc
	gocSkACSndKGrbtxzXiGouuBnF/wTa0vHQm2CLYoiNmF+euhh4As
X-Gm-Gg: ASbGncvb83dcqMYic+Que576ABaDI1NHDK4ltaM4RaUVv80gDtkBeHJDOSZxg20122y
	ANzMDlO44DI6m63lA2TpeY5DeXd9krqyjCdfn6eEoJSeFSDOuj3fR4WX4t+k1PlURNjoVYH+rDC
	Uz9caUFbF8knmR60niX2b6Hdll6536if1E2VvFCBkKyR1YHqgH6h0edPfdLOWE4J3Yzv95bmmAQ
	sqqrrSwvq8NwAP2q5QeZ1K6vmG3C9EqRLeHpcbb+l2+noxAFE2I+gPw7+a5OTJWHFax+qSlvERQ
	uEbwJLhQ+Ae+M0NSL616A/VOp0/nbJVvCef0tPklr+CWohwNDQGBVtdsU7tA4iVEvh8GQPHe640
	jTMXtT5+1Ss/OvIoQ
X-Google-Smtp-Source: AGHT+IFTkYDjrtvLD5vmMkiEOxHVhw9cbcvARvdT4vUjXFb0TOS0ch27+iqfn1uyVsIieCCESgCueA==
X-Received: by 2002:a05:6870:9125:b0:2d5:1d1:8613 with SMTP id 586e51a60fabf-2dba434eaedmr9471588fac.23.1747145036627;
        Tue, 13 May 2025 07:03:56 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-732264dd290sm1924596a34.40.2025.05.13.07.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 07:03:56 -0700 (PDT)
Message-ID: <562c4ac5-088d-4bab-9883-1d4f8eca2b2a@gmail.com>
Date: Tue, 13 May 2025 09:03:54 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
To: Jan Hendrik Farr <kernel@jfarr.cc>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev
References: <aB30Ea2kRG24LINR@archlinux>
 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com> <aB4HC8Iaa6wR5dj7@archlinux>
 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com> <aB4hMsBfyawYatoj@archlinux>
 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
 <aB5onavenLymR-QJ@archlinux>
 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
 <aCMtCCYtNNl4dL5Q@archlinux>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <aCMtCCYtNNl4dL5Q@archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

 >
> There is a an SAE confirm sent by the AP. It's frame 170 in
> capture2.pcapng. It's also retried a number of times after that.
> 

What I also find interesting is that the kernel on the client side reports 
sending the Authenticate-Confirm 3 times (according to dmesg and trace2.dat), 
but only a single Confirm from the client is seen in the air trace.  I'm 
guessing the retransmissions (attempt 2 & 3) are lost somehow?.

[64414.164169] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 2/3)
[64415.063575] iwlwifi 0000:00:14.3: Not associated and the session protection 
is over already...
[64415.063668] wlan0: Connection to AP 96:2a:6f:b6:d7:9f lost
[64416.215729] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 3/3)

Regards,
-Denis

