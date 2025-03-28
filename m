Return-Path: <linux-wireless+bounces-20936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE2DA74D4F
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 16:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56551899E69
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC001A9B5D;
	Fri, 28 Mar 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4aDHu2q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3FC35958;
	Fri, 28 Mar 2025 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174320; cv=none; b=TFk92zJgGQZBFHgWw9FFdO8LF/tDr2BymQcRwqcDynTeJ6Ae4+VLtOABxnRLioObkvM4zROuvs51roOVa8vaCkcadXWCMdoaSYdukdYm68WfmdNd+0LiKQNlc/OJyRD04JpEqEDXSTdOualJ0BjpI0X+qXIu65ryBn3R9YB0BC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174320; c=relaxed/simple;
	bh=yBAnWmBAgw5MP+8CrbHdbxviKnFNTXsTwW8n9ca0eQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sch9ndKiZHgUJCL3ebfnxveO7eXaYOT4PGEgbXDiEUgfzYujxh2nrdZDFhMW+/IKHVcEsETvqtNC4yz1X7CwqZkTDuec2WpHqxy6Yd4UPON9dPSLju3+JjTweJD4xyEUMaCF9fMPR6ig63pAJThoEx5ojUkfASBb4aFrNzCuTto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4aDHu2q; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbb12bea54so424152666b.0;
        Fri, 28 Mar 2025 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743174316; x=1743779116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yBAnWmBAgw5MP+8CrbHdbxviKnFNTXsTwW8n9ca0eQU=;
        b=J4aDHu2qh+qL7NlFOsHN9NKI71fx0QIuQCPfNErXBzUg6DJ5YCS0lNP5iyJG0RvsQJ
         xsRqfDtXxk4dlh4IcjBl+dYwIMOOcOw2qs6UHh+U1ZkJOHc80xzeMbdWojxgyTPQIxvP
         sPO3tdiCJbvtQsBgDdc7/AcCIwaAUUg0cqTsAsVdulHHyKw/LByOHw4c1kij2TDCQ8pF
         eryQyjgSXpudxqYqtePVvTroCdYCFsrJu11Y0vkkBR37khY3naZEE5VYE3X5xhcn2cmg
         KWllNRaLcVSTIym+yJb464TeCvbn+/MYF2dx2VEkrIEauJxSvrvMHd5hTVrJK/IHJ9sy
         9F0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743174316; x=1743779116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBAnWmBAgw5MP+8CrbHdbxviKnFNTXsTwW8n9ca0eQU=;
        b=mK6siI69C/Iyytkz2SP6YU4UWJ9RCTktepijFR2bEXZmvvlrvyLVpv+3PEUZxQD1gI
         WsGidNEMU+Cv3H0+enr5nhdpLHQU+2/I6woMMfrbHTPFD7y58YM6k3O6/EbK0VVPwmsH
         QjL0ILagepaY3n++4XyigxhjFCHv7A/rc/aErT4IofJ3vCnTGj5DYs+qBoJSV8rRFUKz
         xpU+R97T9A58iw2LVid3rwvyXXFqpuZNNxpIEQ5kjqL0BI6wpqRFBm8QwQU9K+gHtNJS
         wwD1Ju6CVBAyk5rePhrcYPWbX6wDGGEm2TEpGmt+1P+rIm2Q2/wZRUkoJlqpDXm02RiE
         RrCA==
X-Forwarded-Encrypted: i=1; AJvYcCVtqQJtgSEHRKsXt6O5v+wOSLlFseAxQlsB+NfbXqGFbdsnty/VQ0wQ4gnePfedFV8yxWi6+x05McOjXgwYvZI=@vger.kernel.org, AJvYcCVxr2JwUCRVKq5zfMpsmv4ffrEFAXAiw+vAFSlHWF2TDZHv0HOFE8ZjbdkKmSf7de0CalujvH+IxBpT@vger.kernel.org, AJvYcCX6mitfqoB5+pclQtzeSUFbabAPjWNZSZddO8tiVt9chLNKdUOzsOtZlG+tCkgM5ICedAwDPD5jadAK4sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/gOyPtKuTNlLBaGQTUQYlwe+kbWthmFrnBlbaC6hjjQxY6t4
	syIbDOpojbId/hPZLF+j9zloqF7OBeR5JJU/IoKUF4yk16FiZw1o
X-Gm-Gg: ASbGncuLA5eoveLLjHR65ILIrRVnN5J+vMTFGGyegBqZSNpwa0omirWvdA5k3I4SvGs
	DVrsh6RrulRd9RNEgW0bgI0iIy33okKn/SwLpo+UgExjEPv8xRjkqnNnPRUJIN0RLeblsZuyrIp
	QgJOQKLLqXbkH85Xt6AVAWPkgr8fvg1KMYw3P/B6IvPjnu8mR2lDlvJZE3ik+0nKpAhi5WzQyRb
	7slqCA0rHMa35baTw4Fz7RRkB4gFmdXY8rNz+cO6EzLsuFsFobSU611wTdDwKAXvvDrZ5VKsSeh
	mNJC9trmDCjTPm7QJC19VckR2YRr7POEleNWPRm5Pse+FiKSGBIKHmF+2E/7GC5Zi4HN9FFGXYA
	q5xw1XDZVNw==
X-Google-Smtp-Source: AGHT+IHWk57vx99rlJfgQ42vdU2UnQJlrOL3Q7JbsZWIfDJj2d9tmTOHn7pyRMIDwZcmBZOmNRt2qw==
X-Received: by 2002:a17:907:3609:b0:ac2:7a6d:c918 with SMTP id a640c23a62f3a-ac6fb157031mr825364666b.57.1743174315568;
        Fri, 28 Mar 2025 08:05:15 -0700 (PDT)
Received: from ernest.hoecke-nb (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71967fdbbsm171192966b.135.2025.03.28.08.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:05:15 -0700 (PDT)
Date: Fri, 28 Mar 2025 16:05:14 +0100
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>, 
	Francesco Dolcini <francesco@dolcini.it>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH do not merge 4/4] wifi: mwifiex: add iw61x support
Message-ID: <p5xukavek27sxpploi7wvx6mwew6ubh2wmckwmzqoxnfmal3jy@gfvn2u3af7kb>
References: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>
 <20250326-mwifiex-iw61x-v1-4-ff875ed35efc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326-mwifiex-iw61x-v1-4-ff875ed35efc@pengutronix.de>

On Wed, Mar 26, 2025 at 01:18:34PM +0100, Sascha Hauer wrote:
> This adds iw61x aka SD9177 support to the mwifiex driver. It is named
> SD9177 in the downstream driver, I deliberately chose the NXP name in
> the driver.

Hi Sascha,

Thanks for sharing these patches. To test, I applied them to our
downstream branch based on the NXP BSP 6.6.52-2.2.0 and can confirm that
the driver works well on our iMX95-based board which uses a ublox
MAYA-W260 (IW611) for WiFi (SDIO) and BT (UART). Both STA and AP mode
looked good to me.

Kind regards,
Ernest

