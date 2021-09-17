Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3211140F02E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 05:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243668AbhIQDG6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 23:06:58 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:38463 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbhIQDG5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 23:06:57 -0400
Received: by mail-pg1-f174.google.com with SMTP id w8so8213926pgf.5
        for <linux-wireless@vger.kernel.org>; Thu, 16 Sep 2021 20:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RTIBZcrHfgJRG/qPnwrsIiHxUCIqeKEyFFMD3ajkpps=;
        b=aB3fky7d+mVPURnQEqzVWwL7XF9PkakV6ADyqw6BMDOPPBBFB9CmjA0fna48OifLvl
         bNWOzT9vuSW8nklAqNCQyfdFzSTdzKkMBZvVUJtdiQuj+3errr1RmA0I1T+IokeOV82b
         7d6YPXQyFb6Lm98Xb0m7qoZF4be8qkGM6bFk7Bt2XGoNOe69kVA9c2kBweeMWflX8oSb
         mGsFJh49Ee/86U1ShcLMRtNFopqw1HHCY0H/mg1yQLN8nVZDCzRna4cMuIttlVWQysll
         k01N2lTeZg2YdSZ7j9R+d0EwopyKmNO196+LIWDSmk4h7Cya/4gIhq0BNe4l07wgw8zx
         TIWg==
X-Gm-Message-State: AOAM530xiwLNXFM5okglv6mSy5IMwLoIvcUx6qTxOGyemVGGaSUi3ie2
        MA2ljHsGcTr3P9JzKChsjdlXmlRvB1y+Iw==
X-Google-Smtp-Source: ABdhPJzjx4ozIroyvDi280lCL65EEhatbzzs93E8RHqCIyeireUVIDeOWH/DhZmC4d0dwEmU1LpfSw==
X-Received: by 2002:a63:5f08:: with SMTP id t8mr7883774pgb.353.1631847935461;
        Thu, 16 Sep 2021 20:05:35 -0700 (PDT)
Received: from [192.168.0.242] (218-173-145-126.dynamic-ip.hinet.net. [218.173.145.126])
        by smtp.gmail.com with ESMTPSA id q1sm4104993pfj.132.2021.09.16.20.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 20:05:35 -0700 (PDT)
Subject: Re: pull request: iwlwifi firmware updates 2021-09-14 v2
To:     Luca Coelho <luca@coelho.fi>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com
References: <8ddba225f68405b5d4ed8b6cd9dcd05a03f532e4.camel@coelho.fi>
From:   You-Sheng Yang <vicamo.yang@canonical.com>
Message-ID: <576a9cff-b1aa-a46e-9e1a-bf99f46ddd8d@canonical.com>
Date:   Fri, 17 Sep 2021 11:05:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8ddba225f68405b5d4ed8b6cd9dcd05a03f532e4.camel@coelho.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Verified. Works for us. Thank you.

On 9/16/21 8:25 PM, Luca Coelho wrote:
> Hi,
> 
> I had typos in the WHENCE file in my previous pull request.  I have
> fixed that and here's v2.
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
> The following changes since commit 198ac651f46b7d4efd660a1f5ab4f93ca422947d:
> 
>   amdgpu: add initial firmware for Yellow Carp (2021-09-15 09:03:35 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git tags/iwlwifi-fw-2021-09-14-v2
> 
> for you to fetch changes up to 0324161cb0723fccf5d7659114851cf8c1b1cda6:
> 
>   iwlwifi: add FWs for new So device types with multiple RF modules (2021-09-16 15:19:45 +0300)
> 
> ----------------------------------------------------------------
> Add iwlwifi firmware binaries for So with Gf, Hr and Jf.
> 
> ----------------------------------------------------------------
> Luca Coelho (1):
>       iwlwifi: add FWs for new So device types with multiple RF modules
> 
>  WHENCE                       |  11 +++++++++++
>  iwlwifi-so-a0-gf-a0-64.ucode | Bin 0 -> 1515812 bytes
>  iwlwifi-so-a0-gf-a0.pnvm     | Bin 0 -> 41804 bytes
>  iwlwifi-so-a0-hr-b0-64.ucode | Bin 0 -> 1427384 bytes
>  iwlwifi-so-a0-jf-b0-64.ucode | Bin 0 -> 1365628 bytes
>  5 files changed, 11 insertions(+)
>  create mode 100644 iwlwifi-so-a0-gf-a0-64.ucode
>  create mode 100644 iwlwifi-so-a0-gf-a0.pnvm
>  create mode 100644 iwlwifi-so-a0-hr-b0-64.ucode
>  create mode 100644 iwlwifi-so-a0-jf-b0-64.ucode
> 
