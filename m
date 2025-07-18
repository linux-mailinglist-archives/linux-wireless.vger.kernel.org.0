Return-Path: <linux-wireless+bounces-25657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8BEB0A1DC
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 13:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7299F1C27184
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 11:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDBE2D77F0;
	Fri, 18 Jul 2025 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFTRW8mU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B52E28B41A
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837820; cv=none; b=p9D4WSTelRCy7iONPdYHbST22Fc6Q95FUrXMXNt9RTCjz4oGhmMiI2X6KKVtdnqGJav98a/vKi+7nzDxvA7JtMcnB4WmPBrN6apwwaqDYXVU+e5BbJDSnT5kmw9FysupyTIJGTC71HsyXjD86+h6Inc9ZfDaO3eUrR9Wd1w/qf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837820; c=relaxed/simple;
	bh=T3fJ2/6liLURJMO4x2WwOH04lqOf1vzWtNiDQdAVHmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5UWHG9LlhWy/+eSjWdGN2n/w8NXZq1Fu1SViMiT65NzT66jHhJOLbNEmSv0CiqPKgqbLFPAvQka/QOwTf0HWPC++GegbskFShLGw9mxnRwYnkin7GnIwONVSS8QdguhypDJYHIJNo5nzDTHOnnIM9bJ6h5F+GutAopNTw7gqok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFTRW8mU; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b7123edb9so18745471fa.2
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 04:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752837817; x=1753442617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3fJ2/6liLURJMO4x2WwOH04lqOf1vzWtNiDQdAVHmc=;
        b=eFTRW8mUZxvqmThz7WlSrJJxZ49l6TgrkqzmmRrPqBXBB+eNoA1zppCpswFbReQeMj
         RAKEm/9gaxppS2SIG8fm9dOigt7SY7RmSTfrh7o/r05KsP0mkWLpNHwEV05H6A2VWxpF
         g5ojXNrSXO6YElt3wnPI+ltIIyaNjlV4S5JvIfAV1hcFONCXkgoUh9PgS9t0VB5srnFz
         OanC7jYSPtGK4tgOdA9zifwoo0roy0RCBdFO0QzkYZiU6ZKcAfip2HQ/VGi35FWW8j1t
         rvWiTaI9B0yyQFNLQN95BSTWeF0Hrl2N2jbEde1OEAhjfkp44fbY5Bb8T6Rfhs4vGSkY
         ATNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752837817; x=1753442617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3fJ2/6liLURJMO4x2WwOH04lqOf1vzWtNiDQdAVHmc=;
        b=kmk6HkS5AZLB19f6CtvVH7HJVOpO/jz8jjtKNTlS4nAwJ3b/OnTVYqSxFzBRnZMKdz
         8N9Xjr5e6o4mhcvZMp7a0t+1yfBIgwg5rN5HSR379vu5D3jBCSM9AnnLwKpFO9tEFWaX
         53mU/FtBeMQZQSFUjS9/iHeWPbm0iEo+KAXsD0JKVcU/x7QGCmKGow8T16OisrvCopkE
         yC4+kfpM8lzg/Y0WCnbYIHSmIwEpExDwFAhdqGnEGpGjGuTt6/ve1T+zFY5V5OmvViNm
         gOqveWgLpTRbwEQbuOvyGWwT6Uv3ETzljwHF9M8GDul7st6nq4P6ZF0T5z+0RAWUxrKF
         WX4w==
X-Forwarded-Encrypted: i=1; AJvYcCWLepFUSFvgR/qt3qmjLY59CKfIWfdOEIKG/m2zWDPn32kAiU+YimUWerjThYVhDQ3J/u5jwvVbjRtioav6IQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGdlTSSPLbfEk1LtocUTzUk6gZ+Hamh5f8OhBqo1STJcGhQ16W
	DgftyjXIwfYZCviNMSUmkaaNMzZiR8b+LH7aZkWpmUcGcgPjwSSWR46ZAnZVlWQMr7hjw1wue39
	yqgsTG/IYf1btjuoMwuSAhiACYbavAXc=
X-Gm-Gg: ASbGnctD3moSYA+V23eOHT/noFOEvXYrbXIjzO6Mo2cF7iVlq8y8Qe4vs6mC4+1cLdj
	PbTEV8jDHAeaZC2bjmFz+/EWuCjRAqI+VmnrEcMx9vFVQHUcuhwHEyohvQSo9N4s/Z9gpv8Vyp2
	iaIzVRfVb+0FiKb01DjB71sC0rTGeNko2mPC0K4fxmlqNWiw9rH2Wux87WVlEXCCBZDqEow69Jd
	/GrEaKGEYZM6Awq3PB+4cM1O+Mk2OYv2rTE
X-Google-Smtp-Source: AGHT+IGFfFerVQe22nhc4AXoVP7ZCBqVyOF+dqzI/2e39BvelFHPCrvzL+P/A4WV6SXyiGPTb6Drp6GCCt18uOy2TE8=
X-Received: by 2002:a05:651c:1488:b0:32b:2ea9:1dcd with SMTP id
 38308e7fff4ca-3308f60eb32mr27402531fa.32.1752837816771; Fri, 18 Jul 2025
 04:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712215307.1310802-1-festevam@gmail.com> <0f645579-0c37-4dd1-8c01-dc9a6dfb4131@broadcom.com>
In-Reply-To: <0f645579-0c37-4dd1-8c01-dc9a6dfb4131@broadcom.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 18 Jul 2025 08:23:25 -0300
X-Gm-Features: Ac12FXy0SHQC_XWOJQCoMbRLbbbAQl2EZUJktHKQvc2tbHl4WBtxQMVnbr5kEOM
Message-ID: <CAOMZO5AYR4nMTEhz=ZnOjQfLr8yrTrLvKrPcQxOjo7gGUudbEw@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: brcmfmac: Add support for the SDIO 43751 device
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org, 
	gokulkumar.sivakumar@infineon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arend,

On Fri, Jul 18, 2025 at 7:31=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 7/12/2025 11:53 PM, Fabio Estevam wrote:
> > Add the SDIO ID and firmware matching for the 43751 device.
> >
> > Based on the previous work from Marc Gonzalez <mgonzalez@freebox.fr>.
> >
> > Tested on an i.MX6DL board connected to an AP6398SV chip with the
> > brcmfmac43752-sdio.bin firmware taken from:
> >
> > https://source.puri.sm/Librem5/firmware-brcm43752-nonfree
>
> These chips seem to be shipped by Synaptics so maybe worth adding that
> in the commit message(?). Other than that it looks fine so...

I don't have any evidence that the Ampak AP6398SV contains a Synaptics chip=
.

The link you shared earlier is about the AP6398S (without the V):

https://www.ampak.com.tw/product/WiFi-Bluetooth/Stamp-Type-2T2R/AP6398S

The AP6398S works out of the box with mainline Linux. The AP6398SV
does not work with mainline Linux and requires the patch I sent here.

> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Thanks!

