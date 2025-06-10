Return-Path: <linux-wireless+bounces-23940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8278AD396E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD3C162446
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963F117736;
	Tue, 10 Jun 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nechA3F0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53EC22CBFC
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562403; cv=none; b=EcnAXxghGyfzN+R4DKe1yz/KVfYmZSAJ4mlLOK+HgE2B1nrAS3A9Fpw4tmn7pKGmVmzQNotxFSfncxfNsTTaDgMRlg+rNWFS3R1IdBxDjueR78zkkGCT9dvdN5jjU4rbEjLRFzkRUH+AgZQBQOL+5Y9MrkUX/JTX10aJn+dbUPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562403; c=relaxed/simple;
	bh=I/Z1CrFbcM3GaI3dyJzJ84n5U/z193agS72haYQlncM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkzhZqPzNqGLUJV7BJVoC/Oei/pZktFXqu5yIzleXI72hYH2oGEHx7Lmkoygxaj6Z8vVJJ2OxKO3/Srazb5Hl4Dc95CKAXWVpU7lTZ/vtJQ6WEEfNPWipYo5VewGcDKYV3ko1A4J8ciqrxYiZFi60AGHaRw+NdMGYb46omZ+rmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nechA3F0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ade750971f2so144188866b.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749562400; x=1750167200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rStFFasi9wKnfuXYGKZXngpt0H1gmjEVwOvEne1l68w=;
        b=nechA3F0Cv7vCS1lf9w8dfsVyrU5NUkUpLAGjdNDvPc2AZ9eove0OTwZF9j4R4eZ1W
         YZ9iHR0gvkyhZ5tgW6mIB+dIVrp/IrJLXUEqdZzfZjvtY1MQU8Vo0fWPYKeOxCdcxeNG
         5UZbIRsofdMRT0jBsEKzrfrVXsy1RuJcQGn/jrRSjzOo/ITyj2pL6NKuHMHq/E9E+Eli
         DmLaNkzSH7Z/jssuWogUo09T5tBFwPFv6NoZwuyk2i/3c9FBNBwC1IPzuSpmalvmZdzG
         8IDcHxd4zvNx5civd6uPjI/O8AKiGPaVgbzVRpXtRpZSWSHg87Ffvhmni1L/gV+8z6jo
         HB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749562400; x=1750167200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rStFFasi9wKnfuXYGKZXngpt0H1gmjEVwOvEne1l68w=;
        b=AGBxJF+XLW7xxdSYJmW6r3B1QJOWT0/qI0WOuk6KGs6HRPRg1UoLKFc0KHgxUUNs0m
         GvP6WzF3BpL82R2QozvaghgSmy+qOMMY7ev1n6nE4mlId2qiaAzhjU5LxUod8N3Vtd9O
         MWoI7vwQ+tuUXXk1QAUI78rvARXLhNYAfA0hKeBZr9aLqKvnt6TtjSzlpK0pPtq1Ej9Q
         GdWjCD1k1we8AcX6N0stp7Hd6syIcuKHsdHUAzISqWneGkpXa+l6w8VVkovo8eQbjh30
         MszCodTqurDDlxGolo972X485lm3H+wm+DdHYDRzsx1J9/2H36Uc80t0XLFApFRkQCzj
         ihXA==
X-Forwarded-Encrypted: i=1; AJvYcCW2SpD0v6Hb2469TY59OnICL2scjkZ2BZrRpYVRhpv3waC0RGFX5FMYxsSK2Zt4gIDRuF4tsjpYSuRv/C2+ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxchBpT460twfwilhPMHYMo5+KTmF43d2eBysDmcQWedkcplKcs
	ytCqcJNVz4LBDU8hop5/UYqSps8YwI0t+YZV6rZDFQOAa3q4tMBo9t8G
X-Gm-Gg: ASbGnctqxYRuLYcbSuKcYwFG0R2KBAMff9KFsN8KhcStGF5RM4GofW6jc/2FAfTU1j+
	zfFwBk7u4jo8Ge+OFdn/sbw1AD/NEtw4lk2eZHOmce8ZTPZDrTxEviTrzAHtTm7tMq4v7X6fZKZ
	Arl6AQxcceER+Mzmas3wx9mWhupVVaOTtObNIsb56LeIx4oEJnqRf9gE0qHTOpA6RnChZN1xAKU
	xlvjadJfEOcqvOhp0SFd6PLAu/vOxIn6008jRwXGrduWrwtM7Hya+IWmTkPLVy6Ld1F9liSGv9y
	vpAKkVQzd0sRcgMRUcN8cIzWZbGTqWVICwQ5xGeULGv4Vxp00lVKsUEj2DzZ8aENu/+Ufg==
X-Google-Smtp-Source: AGHT+IG1M19sNDlIpTxYUy5jNl9AaNF5wPetNrRz8SeDwE1eTyzxnOMj31StieI8zqcznp8b50sfCg==
X-Received: by 2002:a17:906:ef0e:b0:add:deb1:d84d with SMTP id a640c23a62f3a-ade1aa5bc20mr1640012966b.1.1749562399633;
        Tue, 10 Jun 2025 06:33:19 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d753a6csm721053166b.2.2025.06.10.06.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 06:33:19 -0700 (PDT)
Message-ID: <b8690413-059d-4330-992b-36a7af10aa30@gmail.com>
Date: Tue, 10 Jun 2025 16:33:17 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 14/14] wifi: rtw89: Enable the new USB modules
To: kernel test robot <lkp@intel.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Ping-Ke Shih <pkshih@realtek.com>
References: <663044d3-0816-4b1b-874d-776835e774e9@gmail.com>
 <202506101956.cNXM2Qvb-lkp@intel.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <202506101956.cNXM2Qvb-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2025 14:55, kernel test robot wrote:
> Hi Bitterblue,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on wireless-next/main]
> [also build test ERROR on wireless/main linus/master v6.16-rc1 next-20250610]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Bitterblue-Smith/wifi-rtw89-8851b-Accept-USB-devices-and-load-their-MAC-address/20250610-033543
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
> patch link:    https://lore.kernel.org/r/663044d3-0816-4b1b-874d-776835e774e9%40gmail.com
> patch subject: [PATCH rtw-next v2 14/14] wifi: rtw89: Enable the new USB modules
> config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250610/202506101956.cNXM2Qvb-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250610/202506101956.cNXM2Qvb-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506101956.cNXM2Qvb-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/net/wireless/realtek/rtw89/rtw8851b.c:523:47: error: use of undeclared identifier 'B_AX_SOP_EDSWR'
>      523 |                 rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_SOP_EDSWR);
>          |                                                             ^
>    1 error generated.
> 
Oops, I'll add that to reg.h in v3.

