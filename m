Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80BE150191
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2020 07:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgBCGNS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Feb 2020 01:13:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46478 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgBCGNS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Feb 2020 01:13:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id g64so12495657otb.13
        for <linux-wireless@vger.kernel.org>; Sun, 02 Feb 2020 22:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WDgwveZNiwQI4lN1T/HnxxN3QEUl6oNocQfLFOXnUBw=;
        b=fzFQcigNnDYTH/XDKeoODFKtfZK6S8gTxJheGUMCOETVdrV0qYLdEoc0KHc9MQLu11
         vsGuzPrLcZOMd2TDoSEzyt42LJAo5Ji0NEHXjPftXBu28uNEFXp0wUyiHrKw6rVS61GB
         KiOgMdrPVnPyX8uwwJQMYNxUvezVuvENJbCMVRMuEGVV9+n+DB2aMKqDzUD7ogrD963U
         /Q0IfUos6y/WRGRSLPHckecFSloDBTkFKNvGasOgX4FEN5BvPpqVVMY2iuiTmfUIAfzu
         9l/6a4bHRbT9kn/Q8koU1/HORv+BlxkTjnXJ0mJe7iYNV+cNNDhNG/y9beufhy6Vqs7A
         4StQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WDgwveZNiwQI4lN1T/HnxxN3QEUl6oNocQfLFOXnUBw=;
        b=DzIx7hwA/QW0bQk0/G5dk3tuF8ThXLjQrHUHuOlA0Rr0L+PmvDskcWxs+qFaXgM8hd
         wQ7nZTD3J5UAeLIa55dy0L/bwcE3NYoE60bmX2Zko5vfGOSRCF06jLHhnq8WW1K2bKyq
         zS2NLblkItGbgdUGmSrBn2l9wyRnAF1ijkkZyPJv25kXuT2UnQ6enRFPEwcbhgwY0R6G
         kPJjy6bNI/MdZOZ7vJThfi1MatCU8S9HokzyPU+7JFZZVlZIJj8S74+kTD0UqnQ9yNvv
         Pz4MAUDgQbvZL/+co1G9T1Gtu+0VNNx8EaSgVMCckzYs+72dJaS5u3DwthYgNB0MjJze
         8VaA==
X-Gm-Message-State: APjAAAWFNQV8HS3T2N1qPd3FS0Wq6o/MZQ+O83PJjBShs/Af/V6Utq7M
        AQ9afVpUr8mY9ygUKQuKPlM=
X-Google-Smtp-Source: APXvYqw9we359N2EvXg0CkOQosSH3h90Us/Mz1LJs4DROHZZwpBTqCYl9uGW8D+rzjQV/wCKdAPnvA==
X-Received: by 2002:a05:6830:1e95:: with SMTP id n21mr17247683otr.25.1580710397405;
        Sun, 02 Feb 2020 22:13:17 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id i20sm6236785otp.14.2020.02.02.22.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Feb 2020 22:13:16 -0800 (PST)
Date:   Sun, 2 Feb 2020 23:13:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        briannorris@chromium.org
Subject: Re: [PATCH 5.6] rtw88: Fix return value of rtw_wow_check_fw_status
Message-ID: <20200203061315.GA6067@ubuntu-x2-xlarge-x86>
References: <20200203060157.15330-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203060157.15330-1-yhchuang@realtek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Feb 03, 2020 at 02:01:57PM +0800, yhchuang@realtek.com wrote:
> From: Chin-Yen Lee <timlee@realtek.com>
> 
> Clang warns that ret is used uninitialzed.
> And we found that actually the return type should be "int" instead
> of "bool".
> 
> Fixes: 44bc17f7f5b3 ("rtw88: support wowlan feature for 8822c")
> Link: https://github.com/ClangBuiltLinux/linux/issues/850
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Looks good to me, thank you for the fix and keeping my tags :)

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build
