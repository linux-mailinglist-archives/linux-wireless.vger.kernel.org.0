Return-Path: <linux-wireless+bounces-27942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20119BCFFB5
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Oct 2025 08:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352F21896112
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Oct 2025 06:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB90821254D;
	Sun, 12 Oct 2025 06:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aFji9lcX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626F78F51
	for <linux-wireless@vger.kernel.org>; Sun, 12 Oct 2025 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760249547; cv=none; b=q4TLE26kUNMD9y7s7eXvKU0tzKLc6+Iw3/P79ADs/MZhwjXVVn16wQZXUyqfBVz3b0qqXVyr7oKIT4qYbZQ7Zks8ClafUNhgMG1l7LKsSCkxXEOmy/HQQlWS1PLBP0L98IPBzL3RuQzyxfMjJNJD00Ly+KtcukJdx3f26lpRQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760249547; c=relaxed/simple;
	bh=f6Fz2uhUbKza6dYGWrICrcSXEb2K80K9HExqSGlev5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwJd1WDJ2HRZj2bhBa7WbIEb9nJnVzjAo5bSqCLpueAP27mVsgwGeya2m2TFU+3kr6thlxHKr+bLBG+Rw6nOPBXHs7phyuvWWBimGPKX+37SEQwXoQO1La6q0c5I9V/2lFSdAjfSr2CtMNIufG8jAWXHs39zwa57JSqqWX0vQHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aFji9lcX; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2697899a202so28764835ad.0
        for <linux-wireless@vger.kernel.org>; Sat, 11 Oct 2025 23:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760249546; x=1760854346;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGy3QEsEC9E7GQd/sFuSmn6gxBXBQEO0dEXX07xnZj0=;
        b=BiqZDbp640D4BpOVa7zPQKyLNzaKwYbzTB7F8myH9v0XpXV1ZAV7j5VIHTMYs9+2l4
         oLTaSQwXtfVdXRy1FUh8jxs/JmkU6LmoBeVeNmr0zVJE/r7FWNQheIaEl+zdGgFpXPXE
         gmBB2IUjYnKkWCHfKoVPN+4jM+q9IKLJz2uyvnK+DLEgHOcstof1RcTFaIkFJqgSn83o
         P3FbaJyoGfv/cloF2R6sEbb+641s29F2lbuMcMCRm+fqShNjdih0PqcqHhW/jADugCzD
         zZ+l3onKETCw+bHT5KQqR0tzwmBFZN7+CnBRLKN32tYhvHqWijEspLTuYhwKn2rsxl5W
         /63w==
X-Forwarded-Encrypted: i=1; AJvYcCVaKLnuKHTUmI6k8EcmmgamrGERoWLBBJ83heAnHYpmaGvUtpzEfsX5ji0VRRzAqdkMY+goODyzlKFRkBy7vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYr7mWnx8AF5j4hbtGs+67hdMxy0GysjrLLFRudftVl5SNJ5KJ
	wawbK49IT07CLwPVb4j65ywxveoltzyPt7bEo4zEqLSHQxHpc+xWn2eaOlfkFrjTRb/EYMi9lIx
	9iQR+pFnxUc/Jj3yUDk/Bmf3VaW1Y/RtAp5x5zr1GOFZFwepOeBvrcp/qbAMhGuGrPi+yAJjX+v
	myFomoXh79jJ/P56//PDeznZLyv5iFsbnh+Wxia1Hof/PxWHSo+yJmVnaMtmh4/wMiNsGBTKKHP
	bjquxw4kWYv0j7GaB8ZEvGCsUL+
X-Gm-Gg: ASbGncu3WQ2xf7fAbv/n4ZsksSeke9cfdsnxcRSIhWdw+Oi0pb748hX7FWxnD4d4L9U
	OrfaJ1I4tuZWuN3UUd1xuYF+UoFhPNmU9cawj0CZgR3eLOwKfAN1w37ABMgk/ootWfLxBqwLNdc
	rv2IxWAk2g8il1inYdEvWT3TwXuu8NPyofazuGiSwIfdQxps+lpPcqo4d4SjkF+i3snEy9d+YmO
	/ZmCNr2EoygHK1/VdLGXkjmfwFCUs2g59D9HsISMrLY8346Jilp3Zcj8oaUUtvqdO2uma/sCY0O
	o5jqcjhqzeXVLWo190ZuPXtXh7G0TA4ZvEFYY5gbruHbjK0Ed7+uK6fRMED2QevZx+kaDjcF0Ay
	RUv5FzMUh3fa9Wd644Ehoc0dV3SUfIcNH5eAr8+oiUIPvMZI0Ggf61nQC59fMOcNQu5SLfo4s/x
	tGMOSfPw==
X-Google-Smtp-Source: AGHT+IGKuM4ntX7bEn+7IFgMRA748SPNOIMq2bpS+K1OcIbcmx+7aQk13dn22Z6elD/0c6vcsA9Jr2fDZLAW
X-Received: by 2002:a17:902:f788:b0:271:fa2d:534c with SMTP id d9443c01a7336-29027f24486mr184245955ad.22.1760249545496;
        Sat, 11 Oct 2025 23:12:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29034f82126sm8387235ad.68.2025.10.11.23.12.25
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Oct 2025 23:12:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-634700fe857so5177833a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 11 Oct 2025 23:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760249543; x=1760854343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RGy3QEsEC9E7GQd/sFuSmn6gxBXBQEO0dEXX07xnZj0=;
        b=aFji9lcXRtviGFYOb3gufqtAgJSpNqS6qlkEkn/iallP1cQ6sb+2yfmK6kMO6ibzx3
         8MljPCbyKUXvKVPWQIKdfLgsI8WBUMMS+p5zRPQMqkuCtWnUa9fCy/sTkNKQV4ywWllj
         PvXrM9F3tsGG/L4MJRX64XznP2f1Jjq92pCWE=
X-Forwarded-Encrypted: i=1; AJvYcCUWQuME49WaEkebihrQRKYJXQKXLoTz2l7gMhCtRXDplrQmN8dmMOOC/QuM0VMcdgcBr4AmST5ywzERwaq2Ig==@vger.kernel.org
X-Received: by 2002:aa7:d5cc:0:b0:61e:d2f0:5875 with SMTP id 4fb4d7f45d1cf-639ba74b30bmr15712679a12.1.1760249543253;
        Sat, 11 Oct 2025 23:12:23 -0700 (PDT)
X-Received: by 2002:aa7:d5cc:0:b0:61e:d2f0:5875 with SMTP id 4fb4d7f45d1cf-639ba74b30bmr15712659a12.1.1760249542865;
        Sat, 11 Oct 2025 23:12:22 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b71503sm6201052a12.27.2025.10.11.23.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 23:12:22 -0700 (PDT)
Message-ID: <ddfa0200-fbde-4739-b82e-195c4205c590@broadcom.com>
Date: Sun, 12 Oct 2025 08:12:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] brcmfmac: Fix NULL pointer dereference in P2P action
 frame handling
To: Richard Reigh <richard@govivid.ai>, linux-wireless@vger.kernel.org
Cc: wahrenst@gmx.net, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev, chris@streetlogic.pro, s311332@gmail.com
References: <9811a46c-70ab-4bf6-9e20-7882fe1d0c55@gmx.net>
 <20251006231306.131967-1-richard@govivid.ai>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20251006231306.131967-1-richard@govivid.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/7/2025 1:13 AM, Richard Reigh wrote:
> When iPhones query network information via the WiFi settings "i" button,
> the brcmfmac driver crashes with a NULL pointer dereference. This occurs
> because the P2P device vif is not initialized when handling certain action
> frames.
> 
> Added an early check in brcmf_cfg80211_mgmt_tx() to verify P2P device vif
> availability before attepting to send action frames. Also added a defensive
> check in brcmf_p2p_tx_action_frame() as a safety net.
> 
> Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+

Hi, Richard

Thanks for sending the patch and putting us on the right track to fix 
this issue. Very much appreciated. As you may agree the proposed fix 
from Gokul is preferred. So I will drop this patch.

Regards,
Arend

