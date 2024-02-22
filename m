Return-Path: <linux-wireless+bounces-3933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8151D85FC6E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 16:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E0B1F25CD0
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FC014E2F5;
	Thu, 22 Feb 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4mgHzoY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84D14D444
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615945; cv=none; b=trc1Qs+lGsKzKkFrfmwFKqA2lveuxJ7n79p8EowvGSE72e6iZlOOa1jbwtzy/7+LGE6WJpf8QenDSFDXwIKl6GTGixk1EZxW6fnwrIU+4LaGDeeRNkF848+nAoQOBPe59I7VQ1U0hg5k16zBdTHpekfFDnNASvgz8IHOWOapKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615945; c=relaxed/simple;
	bh=HZutNOEuozUmilTycsHTvraIH3r8+SypP+r2VRMcm40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MsX2oLxz0WdbAnwjjHHH/rB92QTn25/9V/3OzKJ9ThXUpH7cXHKZP7fuFpjN9OXptMLDMB0/8zJsZzSV9TEoenNXlsLZZ9knDTAHJu70G1BeLff6OSQ5vdrUNGxrA5lIUrUBT6yXX5N+TpllDLH3L6VUk8f5NCxmW0YniV0I+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s4mgHzoY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41278553016so14300025e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 07:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708615940; x=1709220740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+q4vsHLhF7Vv0hgSfbRQ/lU/wgrHQF8P9rNsVKFLL/o=;
        b=s4mgHzoYRJTs6oIl/CU+su+3ti314XJjJ8DBd9P2fX2lDHNWu1bPc8E4czizspP1ob
         Bh97ATikC26VrwpCHTfoV21EGyYgTIsffTuDHU1e0pnd8dEGIhM7NkVXOn04LbXdlzZF
         t4kTwuK1HCAMllWowhner2tm8/9av9bXvTPiCRSILn5xySkPs80HYKh3Jh/0GiOFHT8T
         F120R8vTh032xNb+6MJycxtvkvLTKNJgwDAJaJ1LZNtr+13iCDMXPPXqt+mUfnSJ1BpH
         MLwDlUE308xSoFlcGcrJptebxAVmcdxUVjto++7wQZ5G8pgnXMS4yZZaOjmTk3B6NZIu
         TdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615940; x=1709220740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+q4vsHLhF7Vv0hgSfbRQ/lU/wgrHQF8P9rNsVKFLL/o=;
        b=CONbUVL4f29NWLpo8+r+tg7g5LjLlc0sFZ0Y0kGx7DN8Htt5aD3mqIxWPLprOIwzoe
         D6jXnqRtC/qG/MWtkx03ueK9VxKDZncqu5iSrd9fLhnEWC4Wg1D4GNfA52lG8rh2iNkK
         VVsZ3LZNISIvNyuPO70yoAA+w1PkWwbYzJ1VixcXabe2mW2GOfcx9/sknXrsIOyp1tma
         mIpkp+f3XcWowsCkXbtptuY+q3rvKyqE9Sstc1ssm8pVEM833kOFl0LNUEsQ6w4n7HL5
         6SAQOh53S5wrS5gTNZEDOY+92nUu36x/17vpSNvXgr3Vw5FWqH/EoQnthqfD/WwGAhkL
         cQQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJSqcA3mRUFK9rW907n0KyCcm0BiMRsIFk40joDWIZO7XFMuAjzpIT/FS5KI1p+J5uSh0KUWNmjY/3/i8VUeD8+Rv62REjWgdHDlH7F8Y=
X-Gm-Message-State: AOJu0YxSmycCGSKcRRBECJ4ZZmD6rdbaxzxcHneN8H14LQwtaA5o15iJ
	DcZ5jdEMphs1Z8U+i0GkMxRZh8DCHWgaB9RB0aQ+u/ABh9AJ/ygP7WcV4HxjiGI=
X-Google-Smtp-Source: AGHT+IHFWn61+J9PBn0aK/tovKHOYNTYZTMeCP4cG4kdpItzeBRLIBT4km0f7vWmhkKsGRxrN0UJVw==
X-Received: by 2002:a7b:cd8a:0:b0:412:a6b:d572 with SMTP id y10-20020a7bcd8a000000b004120a6bd572mr15081272wmj.34.1708615940264;
        Thu, 22 Feb 2024 07:32:20 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ka7-20020a05600c584700b004101543e843sm6434548wmb.10.2024.02.22.07.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:32:19 -0800 (PST)
Message-ID: <04f0a492-aad2-43f9-a3d2-fe60b50caefb@linaro.org>
Date: Thu, 22 Feb 2024 16:32:18 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] thermal: imx: Set THERMAL_TRIP_FLAG_RW_TEMP
 directly
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <3790563.kQq0lBPeGt@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3790563.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:39, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is now possible to flag trip points with THERMAL_TRIP_FLAG_RW_TEMP
> to allow their temperature to be set from user space via sysfs instead
> of using a nonzero writable trips mask during thermal zone registration,
> so make the imx thermal code do that.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---


Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


