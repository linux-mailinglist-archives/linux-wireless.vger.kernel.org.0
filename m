Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BB17E6CF4
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Nov 2023 16:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjKIPLl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 10:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjKIPLh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 10:11:37 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236863859
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 07:11:32 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bee11456baso913560b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Nov 2023 07:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1699542691; x=1700147491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O5v+dAwjm30e0kGB+NS1Oi1w8KzDlGIijfK5vUktEP8=;
        b=cEOp1sMzJv8VacF/cxeL/ZOnaV7a6HN7mxabl9ywR8/liazX1sKTdtf175aZA1eKOf
         ZaDvPmS1d4eENFYYNR5tlLu10beodO6uxBmeFmpXZTB+46xsnxgcg2oAVQIlBUVXeSko
         hYxfVQm4Z3BkPMhYZIa28VRfoNsxmY1VyCPw5kwNE9U9DwSO2uH9WksIXce/HVjxZbAZ
         v6D+DCSY1fvmweksMTpNyFW2IW5US6vMWyzwYA8t6tucb7aKlJdM8u6d0liz6A5JYqVg
         31i8exexu3aHfu1IxFHSntxe0cA3PFZjeVdTY4UMxpAruv/P6IeZ2O73ETF7H9VnEF8s
         66Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699542691; x=1700147491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5v+dAwjm30e0kGB+NS1Oi1w8KzDlGIijfK5vUktEP8=;
        b=lcqdnc+n1jV91LW2lP8XVVoBtgxiArGkvPyBL18bj7B5offCOAvJWFur1s2WQQ7hGv
         6ybt8zxJ6mEzb2eFoGzfiV05QOI6hNVCmIDDl0CUZ5Bhp4mW2P76fFVQRejvQpp7r2ji
         7tngSLRmCalcFawVDpmYLqJT83Kj1UAJaNEQYedZvaiW5XmHecoMHuvW7XtBw3mU6Tn2
         lcNOzU5Ier4ovunCBu0V5IJwiIHYdr2E9JKisb7Wr0KXiLPJ8vJaOMefTHR8vtIzgmRA
         pkojN6uDoFjjYI8iOCjxoGWcLe9yy2CIe3VMFscuOKODMMCKcbE2HT12NYvQdRf55tev
         Tnmg==
X-Gm-Message-State: AOJu0YwYmpXfg1KJdCQFj6Wvce+2cOqyFw0emhMIMEuo6f2ia5co/29j
        stiahuWhvaKtBXCGBenOp8kQxw==
X-Google-Smtp-Source: AGHT+IGPQ9oO60T01y2Uku+Q2RO9uw7Rk3c5JPNl995y8AVjNbF2aI3KuXg25V5pcpsrcmm9QFYssA==
X-Received: by 2002:a05:6a20:a127:b0:181:6bde:72aa with SMTP id q39-20020a056a20a12700b001816bde72aamr6001863pzk.42.1699542691541;
        Thu, 09 Nov 2023 07:11:31 -0800 (PST)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id o3-20020a62cd03000000b00686b649cdd0sm11221586pfg.86.2023.11.09.07.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:11:31 -0800 (PST)
Date:   Thu, 9 Nov 2023 20:41:24 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] wifi: iwlwifi: Fix warning by adding dependency on DMI
Message-ID: <ZUz2nLO28djDYZHJ@sunil-laptop>
References: <20231109054027.2870124-1-sunilvl@ventanamicro.com>
 <5a5203915a94a0299131d3e03d132c40bd98dee6.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a5203915a94a0299131d3e03d132c40bd98dee6.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 09, 2023 at 10:09:53AM +0100, Johannes Berg wrote:
> On Thu, 2023-11-09 at 11:10 +0530, Sunil V L wrote:
> > This driver currently assumes CONFIG_DMI is enabled along with ACPI.
> > This may not be true. Due to this, the kernel test bot reports new
> > warning like below for RISC-V allyesconfig builds.
> > 
> > > > drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:25:
> > warning: '%s' directive argument is null [-Wformat-overflow=]
> > 
> > 1190 | "System vendor '%s' is not in the approved list, disabling PPAG.\n",
> > 
> > Fix the warning by adding dependency on CONFIG_DMI.
> > 
> 
> Not sure that's the right fix - why not put checks in the code there?
> 
> Is it just a build warning?
> 
> maybe
> 
> -dmi_get_system_info(DMI_SYS_VENDOR)
> +dmi_get_system_info(DMI_SYS_VENDOR) ?: "<unknown>"
> 
Thanks!, Johannes. It is a build warning because of allyesconfig build.

Your suggestion works. I will send v2 with this solution.

Thanks,
Sunil
