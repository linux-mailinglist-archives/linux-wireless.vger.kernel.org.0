Return-Path: <linux-wireless+bounces-18422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB85A275C3
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 16:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A1E3A266D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7906213E81;
	Tue,  4 Feb 2025 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnPDSnF7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1225C21420C
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738682839; cv=none; b=qSBLdrUA7AMz+EHAa65VqE2gBaQSiboD+X8ePbwWdx6zZJIjMWUdqw546AUdKhjr+A2gIJ3aDjZrzWA8aYWz/4nw/wfSV6E+o7gkDaUjwYel62J9ml5ADJZQ1mlOSNuLAJRFRK9KiaLv5nmDhkHZ5kCDnU6xM6PSzTW+IWvma0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738682839; c=relaxed/simple;
	bh=6bbw6NuplC45g5e415URYITIdUl4aCpORburWx1YQSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiue5ilHrMLzO9rglamSq2RBIMt15NOOARtYtTU4V52Py09dr8V3vRjU+0mh3REHTce0AXJnlvszPOy780vETACRYFVVyRKuKASehNNeGWoUsfyEkT0yJXkHQapih4fiBtbxE3KfcyYbUzOrKRLJJ/GwSXyR/DVJvND5yU175Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UnPDSnF7; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e53a5ff2233so5863557276.3
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 07:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738682837; x=1739287637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6bbw6NuplC45g5e415URYITIdUl4aCpORburWx1YQSQ=;
        b=UnPDSnF70VmXOjjZwJ0vq5JYM2h3Cx4HfuB2Ghy8hv+Y8ncaIoZikV0JxKRaUSdeDK
         aByhDeaC3zPF8Uvf9g4i3pDH/m+o0b8XCt5BeuswTI7raOjPWCE+HHNH1Db6zMEwVufb
         XtuCmyxk8l2NZSXBqelUh5gKQK6/IViY35bYhcClSOq/6ht9RG6RclNy12xequ9aLCvI
         WZayThXXrmEFmR1UGTwTWCJR75C4/Hn9RbyzyeYPq1ro62cYLV5m7Ye2mbbzuQP8W89Q
         4GhgGwU05XXswQKhsARzWOBvUhupKoEjB8h90tDw1cN5oFZh7Uny3MEYFogQP+Zj8ApW
         H62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738682837; x=1739287637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bbw6NuplC45g5e415URYITIdUl4aCpORburWx1YQSQ=;
        b=qUthc3E9MCeE7Z78PNdNjXU/3cjaY5SKAvQjU6ZHhlaDGmoa3iOVbsjx141xkMNaRh
         Pu1bSNPi2RIECqYw0Ux6THPC9eec3NjRE+ijOsUChM4IFGPjmfeGlbCjCYqkyvO9W2Yy
         eOwi1+64gq6G3CLkZA6VqvVBPCub/gUD4Lown8zAKF+Yrm/ZpKh7ONFqtAdEldAQ/zPp
         JQlqIRlm43aUWCd5VRmi/S8xpskH+ErqM2cOFmzkNGrJJtqGaFgAMxVWtn9swJecgttD
         tCSWc7xBwOROQYKTxEjKXEitCYqlVJPNc1Hi402uQfkacnkzBxWhM/VKuMnJa8mKD6x2
         tiuw==
X-Gm-Message-State: AOJu0YyNfe5i5RGAogqoXPjYynpkaQHhNSbzG6rXWBA56QrLepUQfQKL
	tlV66fofYy9o7ndAZ0FgLAK8lzccfyZHQKCE19iz9HhmDP6RvTBCzPF4uSP0jI/u4GBYhSlT8uj
	GWjIz134mABRNbrdcX7pkTmhp8yw+Rd4hlzLmYQ==
X-Gm-Gg: ASbGncu42N0WRt9LyoU4k5tH/GMfMVJXzCWf3MdDXubct5OKzNvgrGyhhMPicXwMW7i
	r+eZiMP8sQdaSaQNPsne3jahZH3fJOOP60azyY+6CV+EveDEFlIiX783bCcCVxRc6V9duhMT3sw
	==
X-Google-Smtp-Source: AGHT+IGuTehydOk3Axr20URL8vBy9g3qWXoLiXwzZEf5vxniYy62jE4Kl9yHuwqLqMu97MIGL+LC7qy+k9L+D/GoJRY=
X-Received: by 2002:a05:6902:2808:b0:e5a:e625:e513 with SMTP id
 3f1490d57ef6-e5ae625e61emr11909922276.12.1738682836852; Tue, 04 Feb 2025
 07:27:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd1b13d4-b01d-4237-813e-bd48c55d9ca9@matthias-proske.de>
In-Reply-To: <cd1b13d4-b01d-4237-813e-bd48c55d9ca9@matthias-proske.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Feb 2025 16:26:41 +0100
X-Gm-Features: AWEUYZmzVPGqQjAUScsSlKOO9d6YlW9_MWDY69DsffBTqZs8gHgQdoTz5D-t8mI
Message-ID: <CAPDyKFr=XyLg2VjuEq1ZTrdAwSJJmYFDn9wSFj4zWD1+ZB9MTQ@mail.gmail.com>
Subject: Re: DT property keep-power-in-suspend and how WiFi drivers use it
To: Matthias Proske <email@matthias-proske.de>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 12:05, Matthias Proske <email@matthias-proske.de> wrote:
>
> Hello,
>
> I have a question regarding the usage of the Device Tree property
> `keep-power-suspend`.
>
> In the Device Tree documentation it reads:
> "SDIO only. Preserves card power during a suspend/resume cycle."
>
> Does that mean that the SDIO Host Controller will remain powered or
> should this equally apply to anything that is connected to this SDIO
> Host Controller?

Unfortunately the documentation isn't really clear.
"keep-power-in-suspend" means that the platform is *capable* of
keeping the SDIO card powered when the system is suspended.

Depending on what the SDIO func-driver (like the brcm_fmac driver)
decides to do during system suspend/resume, the mmc core we may or may
not keep the SDIO card powered.

>
> To give a bit more background:
>
> I have an embedded board with a brcm_fmac WiFi module. It seems that due
> to a hardware limitation we are not permitted to switch the module off.
> It simply cannot be re-probed afterwards.

How did we manage to power it on and probe it in the first place?

>
> The property `keep-power-in-suspend` was used and that used to work fine
> until 92caded ("brcmfmac: Avoid keeping power to SDIO card
> unless WOWL is used"), which made the wifi adapter by default turn off
> on suspend to be re-probed on resume. Not working on our board...

Would you mind elaborating why it isn't working?

>
>
> I have also looked at other WiFi drivers with an SDIO interface and it
> seems that none of them are really honoring the `keep-power-in-suspend`
> flag. Is this flag for the SDIO Host Controller only?

See above.

>
>
> What would be proper way to implement it so that the brcm_fmac return to
> its old behaviour if necessary?
> Add a Device Tree property directly for the brcm_fmac driver..?

The corresponding SDIO func-driver may call
sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER). In this way, the mmc
core will leave the SDIO card powered-on during system suspend.
Although, unless it's really necessary, it's ofcourse a bad idea as it
would mean wasting energy when the system is suspended.

>
> I would like to write a patch, but I would like to know in which
> direction to go.
>
>
> Thank you for any feedback
>
> Matthias

Kind regards
Uffe

