Return-Path: <linux-wireless+bounces-26583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 618BEB34055
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 15:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED9F1881D98
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 13:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6663720A5EA;
	Mon, 25 Aug 2025 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T81lGn4O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6B213254
	for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127079; cv=none; b=kGrRbNihc6NttrvJih4WGFoANVfd8BJHSIquJqU9hQ7DPULQd6kL8Mt73ZeHbar9npDVr3KaCCR1g/58wmvs6Ud+InIyNXe2rBfG+A50wC84AeEwcCFUtiTOJVbIgTE4U2ehSRN0pbi5UpYJ2J8GyG5OPYx2af/G2KmRMGAcbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127079; c=relaxed/simple;
	bh=opFb1gxgcEF24Psznxc91Reb7NqPoIFXHn+O+SyBDys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hbtx8kWybeBEHLEWIA4xwX70h2nr8CkTr9C4EmaaeJGWs9Z3IwXSAy7eMCW5fwI6NuxxNpdI43d339KpupWcjgB8tE4R20cgSnpN+lAniQ8I29pZZnQHj6c2oaPQvlt+QRbjStsHMhGyopzGwrF9hRbWdVZ8noYDiYUzVYzgU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T81lGn4O; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso24241995e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756127074; x=1756731874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn/SviJD49c7rc7vSoZpIs1ZaUK/bPx4EhxTEwUIQvk=;
        b=T81lGn4OLrPwuK1M0ez7JEZcf2Mp+T78F1urGV+KuvjSvJDO7iCkcNmDOk4bj4L/h3
         /A5n05+CHQi2qAn+1o1l4Y44w//Dlh/jaGfQB7ZPQ9jiXUsEJI+VRq+wAQaWI4KgGMMa
         OSy5K/4RS3US0crMSb70Mfv0TMHUFEDbq+zzI51JesS5OgO5tODt3JBkrvMnepIVZzat
         U8UdTKRazSBdCQBJIwMW1i4hplwOXaiAsB+8/IACToACqV02lcPrZ8omop676pVAWlWt
         k+H2udpIUlcqCKkC1uG4QEWfH6TFmrpuGNTuRdDyGLPg4JjzaGW21LJerDLpYH7+aT+8
         fGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756127074; x=1756731874;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qn/SviJD49c7rc7vSoZpIs1ZaUK/bPx4EhxTEwUIQvk=;
        b=jexteoW2tHbYGJoZH5Tucw0KXH99HTndj+m4G4okGK27B3GTSoRoeBSkvG0hXnv4tw
         nGNm801crnsf1j09SA65iV98XDzZxmta69OyyhzWbKWk75aKspk/Q0ldAfypKO1EvfQx
         44TDwu8sj/kWHAEuQr6vjYtuynDj4bhEpl9+kJRp48Gkep0ns/VBiVQ8fQg9WjxX5cPi
         xNJVMsjgVxWX/1ljwmFmD5P5yV9SnMoCClM2vDKK0cpHjVaXB6UkALig3qmtGNdQxc3R
         nhJdDhGg01zeXfDndb0nyMtJz38Wg+EYn92Xj6KbEMGslolWbRl1h/Y2jXGxg77t1sJn
         xt1g==
X-Forwarded-Encrypted: i=1; AJvYcCVm/ZdeaoR1lkH1vIC8Ol66AQyC75LW2gIF9AO8dPkvy9m3FcBC2zAykLlCaUIh5K1tH3c2wOhBYjcfH2S90Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/q67sKMgjFspak9NUHKZWA9yvycJhx+CdmKO0cYGtmMkxCVF
	ktCpr03a7fdZV4ArIlqwQ2EB97pEJ6BS57kFiH25lCMGNTG4chBUzdSdS1j64BBfc5TGBpnZHvL
	bRywm
X-Gm-Gg: ASbGnctuVNboi5EUcbQ3Bs1LAkn0G5h3rQQCDb//kMWvu8fzmR8tmyvxNSw7ZQ5faxy
	3lXw6uXVMU1zkgoJaWzY2j8JS8jYGan13V5sP6xdNdmHNUZ8Gja9kr6AcL+KZKzzGZwp0O7Ko/V
	mJHWdk1Lnx2XEGrxUHczlzv7HzTI2iAfXjFlxNM2foyC+zNODHPJ/sRolt4HDG+sC22wdSqQlKD
	Wl0ORN1Ve1ys64tdXHLZ3RxJ1ow/7cBc0fu2GL7G3M52UOoIGGlePflH6He5lY1yP5jwweypkey
	x4p8vqzHK1Mf733Mn7K1gLRZy3+GboQQJDpqamn/K2d8Hl4WllH+TPaJRwSUhNIApsf3iWiEI42
	GGXB9G6++uA2K8p1qsiQXDVZS5xE=
X-Google-Smtp-Source: AGHT+IFLTANhGv+KQFDBIFZjxSd5yvOaXONO+ygW9Srw+cCR8S/bQ48zKRnQ+aqZqSS//O4r2HbX5A==
X-Received: by 2002:a05:600c:3596:b0:458:bd31:2c35 with SMTP id 5b1f17b1804b1-45b517cca56mr108449475e9.25.1756127074447;
        Mon, 25 Aug 2025 06:04:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b57492878sm108933675e9.19.2025.08.25.06.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:04:33 -0700 (PDT)
Date: Mon, 25 Aug 2025 16:04:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	johannes@sipsolutions.net
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org, arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: Re: [PATCH wireless] wifi: mac80211: increase scan_ies_len for S1G
Message-ID: <202508251233.r1IFboEm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822062020.904196-1-lachlan.hodges@morsemicro.com>

Hi Lachlan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lachlan-Hodges/wifi-mac80211-increase-scan_ies_len-for-S1G/20250822-142135
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250822062020.904196-1-lachlan.hodges%40morsemicro.com
patch subject: [PATCH wireless] wifi: mac80211: increase scan_ies_len for S1G
config: x86_64-randconfig-161-20250825 (https://download.01.org/0day-ci/archive/20250825/202508251233.r1IFboEm-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508251233.r1IFboEm-lkp@intel.com/

New smatch warnings:
net/mac80211/main.c:1277 ieee80211_register_hw() error: uninitialized symbol 'supp_s1g'.

vim +/supp_s1g +1277 net/mac80211/main.c

de95a54b1aebe5 net/mac80211/main.c      Johannes Berg         2009-04-01  1262  
69e0d04e2b0b3a net/mac80211/main.c      Johannes Berg         2022-09-30  1263  		/*
69e0d04e2b0b3a net/mac80211/main.c      Johannes Berg         2022-09-30  1264  		 * Due to the way the aggregation code handles this and it
69e0d04e2b0b3a net/mac80211/main.c      Johannes Berg         2022-09-30  1265  		 * being an HT capability, we can't really support delayed
69e0d04e2b0b3a net/mac80211/main.c      Johannes Berg         2022-09-30  1266  		 * BA in MLO (yet).
69e0d04e2b0b3a net/mac80211/main.c      Johannes Berg         2022-09-30  1267  		 */
69e0d04e2b0b3a net/mac80211/main.c      Johannes Berg         2022-09-30  1268  		if (WARN_ON(sband->ht_cap.ht_supported &&
69e0d04e2b0b3a net/mac80211/main.c      Johannes Berg         2022-09-30  1269  			    (sband->ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA) &&
69e0d04e2b0b3a net/mac80211/main.c      Johannes Berg         2022-09-30  1270  			    hw->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO))
69e0d04e2b0b3a net/mac80211/main.c      Johannes Berg         2022-09-30  1271  			return -EINVAL;
69e0d04e2b0b3a net/mac80211/main.c      Johannes Berg         2022-09-30  1272  
de95a54b1aebe5 net/mac80211/main.c      Johannes Berg         2009-04-01  1273  		if (max_bitrates < sband->n_bitrates)
de95a54b1aebe5 net/mac80211/main.c      Johannes Berg         2009-04-01  1274  			max_bitrates = sband->n_bitrates;
5ef2d41afb7fce net/mac80211/main.c      Johannes Berg         2009-03-31  1275  		supp_ht = supp_ht || sband->ht_cap.ht_supported;
ba0afa2f22e1e3 net/mac80211/main.c      Mahesh Palivela       2012-07-02  1276  		supp_vht = supp_vht || sband->vht_cap.vht_supported;
0eafa59746812a net/mac80211/main.c      Lachlan Hodges        2025-08-22 @1277  		supp_s1g = supp_s1g || sband->s1g_cap.s1g;
                                                                                                           ^^^^^^^^
Initialize supp_s1g to 0 at the start of the function.

04ecd2578e712c net/mac80211/main.c      Johannes Berg         2012-09-11  1278  
e8c1841278a783 net/mac80211/main.c      Johannes Berg         2023-08-28  1279  		for_each_sband_iftype_data(sband, i, iftd) {
f04d2c247e0407 net/mac80211/main.c      Johannes Berg         2024-01-11  1280  			u8 he_40_mhz_cap;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


