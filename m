Return-Path: <linux-wireless+bounces-6404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7E98A714E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 18:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1201C22420
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0311131BDA;
	Tue, 16 Apr 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8CVKSO6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C21131BCA
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284759; cv=none; b=Kt4g/CRsDXUlx044lMXrk4rf7ry3dJdDRQ9u/sxff10kedAHg7V19VgmhYxkQyg3B66l9dLcDbUCRn6oaYcU33KZfEEHx+ulEupt3I7VpxArs9BX8K9kbUehIuAmm8pp7+wlah3xL5z/aRiackcemGG6LziCPowKkNeL2ullDSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284759; c=relaxed/simple;
	bh=5NW1DOXe/vrR53Z5kE76RMVXFMmVJjpQH5L2MMqEamk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGv9v8ovruCYaQGD2WqSPWaR97lfvgVmu8LzAFhFjEuJaIK7M5B4TJOmY5dOyyUwhwrzKodqkKU16mq511/dilwtXSeYx0Axk9hd3ibo+Nf0vy2vKjQUXBPUnqSOABcWMa++JniWveb7lGGvcrUZF7nmr2zhN+2H0duLqAUqvy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8CVKSO6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4167fce0a41so31501655e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 09:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713284756; x=1713889556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5NW1DOXe/vrR53Z5kE76RMVXFMmVJjpQH5L2MMqEamk=;
        b=b8CVKSO6xv7sNsVrxu9i1NxvVMWFcgTPeR3BUhBZSFEj5XsOuUitGx9CANZIJwKaEq
         bqPlRgzRlUkzVFmwLdrFiMT9EwKqRvfmkY3SS9dq7jFaC78OGkm7oOnh+dG2/fwRLOQ/
         WCkelwSWK0xzE37Bx6dPcxoINelmwHace1KaYwAJvs6zd8Da9k6Vh5kOqjCZvSVp/sRN
         tyG1yF4ovUdNsMJL5uLh3hGQdFLvL5zqEfO7pNcO4MayS1K1QO30KVKoCWmiNfXCY15l
         Eh8bts1CZFURYL69wZtNvTX/XyzTQ/lIXicBjy1SqgFU6oPnplGvrCOMCcPjbHtQo3ut
         RJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284756; x=1713889556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NW1DOXe/vrR53Z5kE76RMVXFMmVJjpQH5L2MMqEamk=;
        b=A4K7vTa5oVQICJSrN6VfYBu1dyN3Dw0Yv3Ws3kWO2/a9jzll9RS0HASZLS9WiWDqdZ
         fJ0WJjCvYmP2dPK43jLYMPqUD9082nPV4dGKil9TAy0kjNVH7GCA6Sx73kgz4WSTIi3w
         EmfLJ2YV0vhaPgjP2o2SJEvAD038PlY7iULWL0WdGJmtWKIBMxCtENqId17pETw3budm
         WbjQirMmFHmMj8mL4ZSSX6kOxXfS/RzZzluRWE0F+5mddRbZg5KPi8qeg2k1kpemGuXy
         bKJaFOyl/8ToeTFYSmU47g5GFdY3mrboxb/38T4nAsYbEZvTf9vsEmERYt7C1xTeYRDl
         Wb7g==
X-Forwarded-Encrypted: i=1; AJvYcCV+2djIJ7Vfa6/ecLFPQj+LeVaCMlu5TnNWCfdJGB7zOhJ+a5z+lxBMVLBwgmM3uVQux9bjHO2oJupODcx0qwJf1H1U0BtxRWrP6tX6gFk=
X-Gm-Message-State: AOJu0YyzlEz1eFdQ/14/CwPAECfE/WSet375DAd+WkwVOCvhpKgn0F1T
	ynOpq6wMG9rjaHcWWxZLvYIGz8aHVo6WSC0zOMx/iV2ruclM1WLN+VnNRz9gPXCyYTjRCz4Hao3
	cs1v8l6tsIuXjKHbTo2WwZ9yalVU=
X-Google-Smtp-Source: AGHT+IH0LKelEx40Euj2U1AEuBvmh9v5x0mvRQSrmegLlDQZcHS0/CRWKWYpQjwLluoPybtFiDjICsCXoCoc5vXXVQo=
X-Received: by 2002:a5d:59ad:0:b0:343:8097:213d with SMTP id
 p13-20020a5d59ad000000b003438097213dmr3917261wrr.20.1713284756434; Tue, 16
 Apr 2024 09:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD9ZU8Coc0r3AiWz+rA4eoXuDQBBCAMY0J4w5x-Pa1JEpbmdWA@mail.gmail.com>
 <CAFktD2cp5eXJufdQibxDPGvN2iMfMZKDOunFzxv0TBNLqcMAQg@mail.gmail.com>
 <c68a406361524b6888d973a1e428118b@realtek.com> <CAD9ZU8A8f-aJuH54e+93cZGTckOSu+rYKcnQr0mkc8eq56zedg@mail.gmail.com>
 <fe9d13fd-bf13-4c59-98a7-68fd20d97978@lwfinger.net>
In-Reply-To: <fe9d13fd-bf13-4c59-98a7-68fd20d97978@lwfinger.net>
From: Gabriel Tisan <gabriel.tisan@gmail.com>
Date: Tue, 16 Apr 2024 18:25:45 +0200
Message-ID: <CAD9ZU8CX-zC=mA-mE_B1ZGa2PCDwiW6qSWFhwvy7wMhu=MMNyA@mail.gmail.com>
Subject: Re: rtw88: rtw8822cu (LM842) on Raspi4 -> driver get stucked while
 sending data
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Nick Morrow <morrownr@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> > To be sure, does anyone tested this driver in AP mode for 8822cu ?
>
> I have no idea if AP mode works for the rtw8822bu. The vendor driver for this
> device is available at https://github.com/RinCat/RTL88x2BU-Linux-Driver or
> https://github.com/morrownr/88x2bu-20210702.
>
> There is a problem with the wireless-next kernel and my rtw88 github repo in
> that device 0bda:c82c is listed as active for both rtw8822cu and rtw8821cu -
> certainly a mistake.
The problem is also in mainline, was introduced by Nick Morrow with this commit:
wifi: rtw88: Add missing VID/PIDs for 8811CU and 8821CU

Maybe he has a reason.
He told me to check https://github.com/morrownr/8821cu-20210916
even if I use a RTL8822CU chipset.

I checked https://github.com/lwfinger/rtw88 regarding AP mode for rtw8822cu
and I get the same problems like in the inline driver for kernel 6.6

