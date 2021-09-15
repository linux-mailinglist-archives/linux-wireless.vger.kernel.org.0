Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D9640BF0A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 06:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhIOExw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 00:53:52 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:37555 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhIOExv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 00:53:51 -0400
Received: by mail-pl1-f173.google.com with SMTP id f21so880331plb.4
        for <linux-wireless@vger.kernel.org>; Tue, 14 Sep 2021 21:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yGHbYJBuSG9UZHDjC7+kOc8HYDQH3BClMCgGkanPURQ=;
        b=YhblaQAYTxR+phfHdpx9lZQFfkL38Du4XYYwjjORr/OPv7j2D1XOI7XJt0/pRJoyrn
         REEloBYlc4+Z8UMsurwbeI65iZI+stLC8M4EkZCIy9EcdFDSBwATCirvfRawNN9yruZk
         J8FbbJbj0rM4B49uHTrevb2NCXZ5AJP2HRTnURbhEFG7Q77enyXDnTa91kO/G7iI8Fqy
         CYBGBs/gY8jLFcx2JJKOUdYXyyiEO7eiMlX7Afmg/alnTqQGnSHsFqCsiIggYigqrQiP
         LK2lrEXIaX2RjLSF0h6m+Pjw2rNGGTRsmh+06KjOQNFHPdxSm5SLhD4tzg085sQmlNtC
         zXcw==
X-Gm-Message-State: AOAM530F/G+9WfSCMHllG45rA2bTbvT0ZUt5PmHkXUNGgD85/WXykmC8
        7+y+hUjXsW6gnr/i04VOmCU=
X-Google-Smtp-Source: ABdhPJxzdU+aGkSqmBgUR56W1EyHuhE2pzhs8apYKL6Z2f2tWkFu7NxDKQzogJ4iC6V0ti40epEJ4w==
X-Received: by 2002:a17:90a:9292:: with SMTP id n18mr6240214pjo.120.1631681553131;
        Tue, 14 Sep 2021 21:52:33 -0700 (PDT)
Received: from [192.168.0.242] (218-173-145-126.dynamic-ip.hinet.net. [218.173.145.126])
        by smtp.gmail.com with ESMTPSA id o5sm3024718pjg.40.2021.09.14.21.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 21:52:32 -0700 (PDT)
Subject: Re: pull request: iwlwifi firmware updates 2021-09-14
To:     Luca Coelho <luca@coelho.fi>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com
References: <cf74966169f716164a7e642edc1aae8cdb7417c6.camel@coelho.fi>
From:   You-Sheng Yang <vicamo.yang@canonical.com>
Message-ID: <945c6e9d-6635-7039-c876-260df26ee3d2@canonical.com>
Date:   Wed, 15 Sep 2021 12:52:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cf74966169f716164a7e642edc1aae8cdb7417c6.camel@coelho.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/14/21 4:19 PM, Luca Coelho wrote:
> Hi,
> 
> 
> This pull request contains a single patch that adds firmware binaries
> to support one more device family in iwlwifi, namely So SOCs with Gf,
> Hr and Jf radio modules.  This replaces the previous patch that we
> reverted.
> 
> Please pull or let me know if there are any issues.
> 
> --
> Cheers,
> Luca.
> 
> 
> The following changes since commit 090a34dfe32bfe139bf0f8df96bcbce320ee8864:
> 
>   linux-firmware: add frimware for mediatek bluetooth chip (MT7922) (2021-09-13 11:35:49 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git tags/iwlwifi-fw-2021-09-14
> 
> for you to fetch changes up to 22cfb96ad56e7c0fdee96550ce9612981dc8342d:
> 
>   iwlwifi: add FWs for new So device types with multiple RF modules (2021-09-14 11:11:43 +0300)
> 
> ----------------------------------------------------------------
> Add iwlwifi firmware binaries for So with Gf, Hr and Jf.
> 
> ----------------------------------------------------------------
> Luca Coelho (1):
>       iwlwifi: add FWs for new So device types with multiple RF modules
> 
>  WHENCE                       |  11 +++++++++++

This adds incorrect filenames. The `a0-hr-a0` and `a0-jf-a0` should be
`a0-hr-b0` and `a0-jf-b0` instead.

>  iwlwifi-so-a0-gf-a0-64.ucode | Bin 0 -> 1515812 bytes
>  iwlwifi-so-a0-gf-a0.pnvm     | Bin 0 -> 41804 bytes
>  iwlwifi-so-a0-hr-b0-64.ucode | Bin 0 -> 1427384 bytes
>  iwlwifi-so-a0-jf-b0-64.ucode | Bin 0 -> 1365628 bytes
>  5 files changed, 11 insertions(+)
>  create mode 100644 iwlwifi-so-a0-gf-a0-64.ucode
>  create mode 100644 iwlwifi-so-a0-gf-a0.pnvm
>  create mode 100644 iwlwifi-so-a0-hr-b0-64.ucode
>  create mode 100644 iwlwifi-so-a0-jf-b0-64.ucode

Regards,
You-Sheng Yang
