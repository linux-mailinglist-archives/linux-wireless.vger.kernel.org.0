Return-Path: <linux-wireless+bounces-8816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E1E9045A3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 22:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD791F21059
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 20:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192D52B9DB;
	Tue, 11 Jun 2024 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="figL5BFc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6362112E61
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136936; cv=none; b=eqGFBpEVG7bTsQdYyrW/oWVz3h7EVadhSjAMWjEMGyWXSnLhgjPT/k7du0+Mh9MF7vvG0JL+D6JGrrPs3ojLBPLQEWk51NU3CgRzWIdKsPZqmjjvXqpl/VWQuw7T18M+FhTz6qseE0325jYozPQmaOVFhS5xwXlYvN12OJ46iwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136936; c=relaxed/simple;
	bh=VvRZ7KVnOr57kEiFSY3cZGQGBGGhh8cwFIlSCmUXg/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVwX5kVNEPR7zNeVn3jntvO7peGfPGsMjJs/z8A4cNZDVQThZG3+emKbMEhuR76ojHM2KdRaq7MGEN946Qn6n1dPbxPs3PA1G4MyFRjpUNxuWWFRdT8aL+f2adNZOntNZ2aqK3XQ82vHM2BDuj6C/5bIhPSlfqw0k5m2UcaqHIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=figL5BFc; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so30307941fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718136932; x=1718741732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TkIPX3CRDTofzOKhBx3sX+Lmw4cSLxPYnCj2uhd9bFY=;
        b=figL5BFcRVc4KqbP+NRBIBdrOKsQjZ7UmQzAFER4jP/u6oEqV6LsTJLN3Moj/nZYqo
         mxZI9eLZchvb2ijoEc0QyOPAZnX6y8sXYde/guZZ5eV1fv4CKIKZJegAcHLLLaZgI/Bv
         zn/0Lyx2yOrL85VNtfvkJtw4LvxAcUvOmyY58UL4EotKvC2EB7oDepzGmON4J06vg8KV
         DvSJTejBrOO35qVSMBqv3YMbnpQVoquNWgQ1nlWoIzwI1SUCDlfXZZb5JaPe3ObI2h2D
         glFOukoMYSKZhsct40F6gsSTG7y1LinLb5Iz0tff8+SxAFqSprxs1WIjGP9blnk2liKd
         Cv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136932; x=1718741732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkIPX3CRDTofzOKhBx3sX+Lmw4cSLxPYnCj2uhd9bFY=;
        b=L4EcHQ7Y66Tculbt97DtabBhV6dsWHpiBKPo5LJdt48yArL0NX6yH9x/IjxBEv3Jw8
         tpeliS58a8mrwcNC2aoTplwE656yG3Eq3l+S7ZNiO2jVqudzqRBYIJEkGrvLOY5WgMFu
         lSsI1KBEMiKfkijGptUz2WeHCyUw7tDGZFkiosobO6fly6H0UPI4iz32spVelLdByTl3
         gZYle+WT0Z/XlSusXy6FXp9SO6eawCyX0NJcnGeXPfEfJE1+YWk7yDUbqFB10MdDmVph
         R+m0VpD3dAjicSpRhuCeibVTrtkntYal/PXx78jiTPIh9h9uVNKzzo4W4H77QHJawqvT
         LkVQ==
X-Gm-Message-State: AOJu0Yx+rkLr4xyGddl/+iesH9PXWQtsbHwyCWXRzgkoQVB4ftZ5c6wx
	Xap6Hl/kUIZYKK+e9QvUvc0skr5Tyt9ZXd8K42dPDkec2rVsCPBm
X-Google-Smtp-Source: AGHT+IEnr3jagbQNAxo4Oa3Mw8mV3U+r/QO/qJjP8JihTEA4edk+cK3gGkcvFKPk9eZ9QEMdoVStkA==
X-Received: by 2002:a2e:a7c4:0:b0:2eb:eb23:6cda with SMTP id 38308e7fff4ca-2ebeb2371ebmr36469191fa.49.1718136932099;
        Tue, 11 Jun 2024 13:15:32 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0c9f88sm9802491a12.21.2024.06.11.13.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 13:15:31 -0700 (PDT)
Message-ID: <e46407b3-3531-4935-a0a5-5132d5baa722@gmail.com>
Date: Tue, 11 Jun 2024 23:15:30 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ETIMEDOUT with rtl8xxxu
To: Martin Kaistra <martin.kaistra@linutronix.de>,
 Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
References: <ee08c815-9389-4277-be6d-197511636892@linutronix.de>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <ee08c815-9389-4277-be6d-197511636892@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/06/2024 18:54, Martin Kaistra wrote:
> Hi Ping-Ke, hi Bitterblue,
> 
> I have a problem with the rtl8xxxu driver and 8188f, but only on some boards. More specifically, I can see that during the second channel switch (which happens when I do "iw dev wlan0 scan"),  the rtl8xxxu_read32(0e08) returns -110 (ETIMEDOUT) and after that no reads or writes work anymore until I unload and reload the driver.
> 
> The strange thing now is, that even though it seems to be hardware dependent the vendor driver does not have this problem.
> 
> I tried to change the probe and start functions, so that they behaved exactly as their vendor driver equivalents, but so far I don't see any improvement.
> 
> I was hoping, that one of you maybe has an idea, what could be causing such an issue and how to avoid it.
> 
> Martin

Does it still die if you do a passive scan?

I wonder what vendor driver you are using? Is it loading the
same v4.0 firmware as rtl8xxxu?

Why reloading rtl8xxxu makes it work again? A USB reset?
Or something in the disconnect function?

To avoid the problem, obviously you have to make rtl8xxxu
even more like the vendor driver. :)

