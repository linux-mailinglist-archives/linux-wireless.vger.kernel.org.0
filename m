Return-Path: <linux-wireless+bounces-11084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F4494A7C8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 14:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73666284E36
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 12:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E8D1E2101;
	Wed,  7 Aug 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RolE6EsM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5121E6734
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034091; cv=none; b=F+LHy5I+gQ/lPUiGG+A+Pw5VuAIUMDPzHjHUY5IZcGGVRugU/BNQlhMG1R4kJHS3xS+u9kzmzu5bMdGr7HR7+zdhLSaE1+eUcYePHjZ+mqLKKlswKKMwCEfuYSCgU5fOOTiyX+cIrZdlW7deqQLGIkPOiPUR0pyKJ2g7urUM6mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034091; c=relaxed/simple;
	bh=ys0po9uXAVjZn6YUCwk7hpwywjaBHJTgz/52B8yk1k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGuRNpQ+ZBGksO9fdRD+NiKdICyPwhhJGOSbG4eZIWKGr2Q4TKS9fmlTe9xAXUoeHn0JD54uUmLjaPD+1LDzkHs+HEVaFW4AQM10d5uxXXSOtmeI3WJ4wqzKl2563zve64rYz6L2gJtcYeP7px8W7gYUrMVChBJ6dbb6yJIIr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RolE6EsM; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-690aabe2600so15415847b3.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2024 05:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723034089; x=1723638889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hHrubDyYul6S/dsbW4ejvPUwj6KN2TaVmFfsX0pIZaY=;
        b=RolE6EsMyPJr0pgo41ggBIyAPFC7+yLCh6D5QJeAKlboTTgxkAYaiGw7G0PGdsk8YJ
         7ByNiO1NMTTdKIVw/Br9wrSfGmoup9/1llhv42khIcSARy7Vk9DZHcPDkJg0+9JwjJHb
         vu1Pil2CIXXigFOZqRm9nYGAupDLuEbaXXA9zPIMiZVnc+jHuEXcxIy78hSFwMfoLsm2
         WjgVt7SpMtpL5ffGkpQvE8g6xWDfFZzMzZZrtS1ywUDlONj22qhrWF/VLZXa3gmVKUEJ
         aXxoxzz5JcJxU8IIso7WgA1+gsX3s8/gNZjyKfVb9jEIVcBM3F50I8NPXBy+z9bn80m3
         u2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723034089; x=1723638889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHrubDyYul6S/dsbW4ejvPUwj6KN2TaVmFfsX0pIZaY=;
        b=dDAT1prKSyg21RM1q0mofwJ6oF3/sshc9Aabb1RJM0FCPe65kXXEuJEo5BHIPmzzfx
         zLW5gxAJk2dVKWZPFe7lFn9wSyqAHmeWYpxOWJo06nYApIEwMfp+fZIrrZ49h6dlKOzE
         C15T0aXyosFVAi61Kfx7/oeKr/FcX+jfcV8m1hhd5FNrX/oQIJQIe/XZq9jBXG8Hc3d/
         ycD0r2g45Kk+fYNODqvcFAfxOnRMOQIS++MrftYjE2ymMHffDSxJKIWA2BoWGhGMceia
         IVEwwrCGTqP0X/PSFA4mGBjniw6FU0GTzN0Qgz4AXtp5ZqJxrvXZErNzdYSVaZdIj465
         S9SQ==
X-Gm-Message-State: AOJu0YwMS+67puuKyysDnHZ6rd4V7j+dMZRLZgpFjrIZ4uOjYBc1IsmB
	kJZHOwIm+PBlIN0C9O1pRJH6hGDmc/9pcWC5e+k3M1+hvj+YVJD/djXvJYBAiT7ath4IOHJgsW6
	+LZ/nTqnUf3otc9B4zSQcz45x0NQ=
X-Google-Smtp-Source: AGHT+IFV5gcYHSw6LKIKmZ+grzDs0VgcikAFi0cJT3TV8sVKeJN2xsG+1V0RdKZ/POHFfPmQIdbRSothYtm39RETheM=
X-Received: by 2002:a05:6902:70e:b0:e02:b51f:830f with SMTP id
 3f1490d57ef6-e0bde4caaf5mr24666433276.41.1723034088972; Wed, 07 Aug 2024
 05:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZrNRoEbdkxkKFMBi@debian.local> <87le18ile6.fsf@kernel.org>
In-Reply-To: <87le18ile6.fsf@kernel.org>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Wed, 7 Aug 2024 13:34:38 +0100
Message-ID: <CAP-bSRboZLWg4pzHHrD66NFeKKbsX0z-wUcxJS4OYmzcHXdG1w@mail.gmail.com>
Subject: Re: [REGRESSION] bisected: iwlwifi: use already mapped data when
 TXing an AMSDU
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, benjamin.berg@intel.com, 
	miriam.rachel.korenblit@intel.com, regressions@lists.linux.dev, 
	johannes@sipsolutions.net
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Aug 2024 at 13:10, Kalle Valo <kvalo@kernel.org> wrote:
>
> Chris Bainbridge <chris.bainbridge@gmail.com> writes:
>
> > I hit the following bug in 6.11.0-rc2. Reverting the offending commit
> > fixes the issue. This happens immediately when I run `iperf3 -bidir`.
>
> [...]
>
> > [   42.873868] ------------[ cut here ]------------
> > [   42.873989] WARNING: CPU: 1 PID: 529 at drivers/net/wireless/intel/iwlwifi/pcie/tx.c:1836 iwl_pcie_get_sgt_tb_phys (drivers/net/wireless/intel/iwlwifi/pcie/tx.c:1836) iwlwifi
>
> Does the connection still work after the warning?

Not really. It is functional but tx throughput is severely degraded,
iperf shows ~1mbit/sec instead of the usual ~600mbit. Rx throughput
(measured with `iperf -c ... -R`) doesn't seem to be affected.

