Return-Path: <linux-wireless+bounces-14810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 014799B9109
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 13:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8B628163A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9642119CC27;
	Fri,  1 Nov 2024 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUZ1dJ7r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0F175D2D
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730463262; cv=none; b=CGrUQDHjMJcc5rJaJLPlIShkno7tyyy59HlpPVeSSJyp7O/sNmvO2CJCo33yUQ4mRPKA4Yqa/2MnF1Oe+ku11T7rBI2LbCOiwCY7JRHEis34ZnYO1zCaVFX+Y3UlGE45wdslfoM7afHfDG6uoWPaWhB7ExO6i7E51vLThi3EJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730463262; c=relaxed/simple;
	bh=p9DKxdVSBtQD6DXS5i3JPCzqn4/KGAK9P6m7WbcJMw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyjAyrZAflkqbUs3UtwFx1OXvwZkh49ZSypr8GoyiH4BJuQq6ElWHjBoURz3XZR6h/Odsn8dSQhO7QkONA5DXjqJhgwqjYirPzVd4eN0T3LjTVVcIhL8GjVmFBUWl2oLFpQ7G6En26hDa6EYd7ffwscXKlHAnhAsUyMsfFnt5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUZ1dJ7r; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso259075166b.3
        for <linux-wireless@vger.kernel.org>; Fri, 01 Nov 2024 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730463259; x=1731068059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afXS28WNzPIn8ZiAoXeQQ+AWZulWG4v7TMM2B1Nbx3U=;
        b=QUZ1dJ7rkaon9IdRblSPKi+PUdbjaLpDy5AwncBPMqc56LGhZgHnoZFLI6cGrTwFYU
         pvGxqIH7jecdaZjAZ0Absw93WRxUmrEffiSqlEpV8XS0hYXT3RdjBfkQ5ZhklqInQad0
         WSYeS13phWkY6E4IdE2WewZgG/onG2hbIbOIjz2u3IDEKYGLvVj/Pmu6cOTqYy+yAgdn
         nCkv8qU7T4YNzN+SAONb4rk0Xw2S+Y3JGl8Brbc5xfEpolYC8YT+6oiPCUC19zrsqSre
         3ZZSIt1eltZ8VQ8s2Mna3nBNDwXpWe3NJatHWtoLdtS34C1Bq9TDM2Si15oNQabxDg9F
         tOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730463259; x=1731068059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afXS28WNzPIn8ZiAoXeQQ+AWZulWG4v7TMM2B1Nbx3U=;
        b=v5v+TqK54WwlgEHPhWwVbRoYj8sZxts8jmeZt5VBptL4mspvYkPBQWJIqQx/Q3/FJe
         lKS3/qdXvNjTS3sd2GZ+i71ZEUf5MRgUy/2gwz04k2EwUZSgwwRkq4WwFMm7ops4jOxU
         /kCr3VP58B28KRW2qfkn1xXoteWMwuG78aFz0QNquvsJuq85+7CSwKOXyrqubVaHBeG9
         P2skbsi3XBm8zh6iLFF1ndgmTha9NnWlOSkqPQJUfwiLvhVkxO6cgeAMnoeiwkUX8bpS
         Gj4wxRLbwFbXY3LLbZInxVyKsx7+4IjxfwsneX2O+ioC1hfLe5lEFaL56XQRPaaIo/1Y
         W+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUSvjODc+uBE1LcGjqGGOnPr0xqJbn53zZ7zBFRk/QR5QTl9F/r31Eq5ANh0gHOt9YHWciVCbW3VCvjtDhZmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YztfdEDV7pfOmywHzrCwZ/DqarEQr1MwgzysqRBn5Uq9Sih6fCr
	oz3AoxhnpkD0mlsaEjU9KKpV1dhzmKF6OV79V8cpfA2gvtPoQET4g/6uow==
X-Google-Smtp-Source: AGHT+IGswJw9DBDaL1k60WKA1olp/Z5xH9EPY//gHoHbDiGQFhhiaordtKUxXzGZhvoPWau6GTIcoQ==
X-Received: by 2002:a17:907:1c02:b0:a99:a9b6:2eb6 with SMTP id a640c23a62f3a-a9e652c179emr345249966b.0.1730463258564;
        Fri, 01 Nov 2024 05:14:18 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565dfa80sm173888566b.130.2024.11.01.05.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 05:14:18 -0700 (PDT)
Message-ID: <fdec3e56-ee9f-4b44-bd61-cb8cfec5f2f8@gmail.com>
Date: Fri, 1 Nov 2024 14:14:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU
 drivers
To: kernel test robot <lkp@intel.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Ping-Ke Shih <pkshih@realtek.com>
References: <0b8e8093-8103-4999-86bf-0055ec52ea64@gmail.com>
 <202411010825.Kzdw5VeV-lkp@intel.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <202411010825.Kzdw5VeV-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/11/2024 02:35, kernel test robot wrote:
> Hi Bitterblue,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on wireless-next/main]
> [also build test ERROR on wireless/main linus/master v6.12-rc5 next-20241031]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Bitterblue-Smith/wifi-rtw88-Add-rtw8812a_table-c-h/20241031-023323
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
> patch link:    https://lore.kernel.org/r/0b8e8093-8103-4999-86bf-0055ec52ea64%40gmail.com
> patch subject: [PATCH v4 7/7] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers
> config: um-allyesconfig (https://download.01.org/0day-ci/archive/20241101/202411010825.Kzdw5VeV-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411010825.Kzdw5VeV-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411010825.Kzdw5VeV-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>          |                             REG_RFE_CTRL_E
>    drivers/net/wireless/realtek/rtw88/rtw8821a.c:338:37: error: 'REG_IQK_COM64' undeclared (first use in this function)
>      338 |                 rtw_write32(rtwdev, REG_IQK_COM64, 0xfa000000);
>          |                                     ^~~~~~~~~~~~~

Ah, sorry, I didn't use --base. This series is supposed to be
applied on top of rtw-next, not wireless-next.

