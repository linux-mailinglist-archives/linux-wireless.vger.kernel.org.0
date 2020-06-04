Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958E41EDE9F
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgFDHiq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgFDHio (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:38:44 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED198C05BD1E
        for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2020 00:38:43 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g1so3864200edv.6
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2020 00:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mRhM4GPrCR980OBnWoTjhhHKFdM5nH5wniGhhiNRtCQ=;
        b=ecIfZo4Dv/7sWVM2NavekhmySgu0Ef0xD4wkIT/hE/xh/k1sZ8eHTUOU6xL/4cADiE
         KANQAJxXJ6sZxaA40jj3H4u9yCs8TPkZwUHwDPWCO79lVrks+URejGdtITz0AbI/QyAt
         1jWXKPKQSdQrqiZMBXM/RgxEyWQIFD0n3z6L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mRhM4GPrCR980OBnWoTjhhHKFdM5nH5wniGhhiNRtCQ=;
        b=SKSs08z7E0kNduQm93oDc1syIUyluE73BKyFae365+Y1fiMTfAV7CWjnAwr4afa4VR
         1n/2Ac68F5c7TRv56aDpXyKX11IoX7eOEy35Dl6vgVxK+Qp260mtvpvypoQZIZtjOo+L
         27Bo6Z/Im1TyMUtGWG58xvr8ncPR1xykzdZJqgeC8iESEantOZ3SpFgapg17xO5ZF+hk
         Bn4ACXiBYtR5TggjIlbz6KC6yAxwqQdKbmKh14hF62C50oRELDm2eQGIWcGZaxiHZXDI
         D6tyszBFCfzMQYDAE3SuJoLtcRu+c8NFB29HdKGg2sU4L2NHs7JUj0B2sG1ttM9B9TEX
         atXw==
X-Gm-Message-State: AOAM530++GOOU1ojyzwhcoNjcSP1dm6f0PLfKLnq+AbNkwHtVBI1WdNy
        UcoBJCBij9gKF8q1GSjk5oDe3uNWSW++ozrvi14KsTFulVO0k9xzGQvuJ939cgOkyX24QbsgPfl
        f6JEAwoJEtOF8sO7k3obVsZgk4y6BnnthDiboh0USZcBf9ZNkm13Q/a0SHWGKnj6zVXsmTOwpyG
        mr+WBdkw+6uzQlyd+r
X-Google-Smtp-Source: ABdhPJw7xGeYwH5wBLf9rI2vQAp4TaVRoRcGdnTiY+nV4CzYRV5JQHOHmUJb8bT8H03Tu/7MAKNfew==
X-Received: by 2002:a05:6402:c95:: with SMTP id cm21mr2949987edb.255.1591256322302;
        Thu, 04 Jun 2020 00:38:42 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id b11sm1372041eju.91.2020.06.04.00.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 00:38:41 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] Add FILS discovery support
To:     Aloka Dixit <alokad@codeaurora.org>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
References: <20200602013844.26275-1-alokad@codeaurora.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <21731442-f74f-339d-15a4-8dd18b68638a@broadcom.com>
Date:   Thu, 4 Jun 2020 09:38:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602013844.26275-1-alokad@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/2/2020 3:38 AM, Aloka Dixit wrote:
> This patchset adds support for FILS discovery transmission as per
> IEEE Std 802.11ai-2016.
> 
> This is the next version in the series given below:
> FILS discovery and bcast probe resp support.
> Unsolicited broadcast probe response support is now split into
> a separate patchset.

Hi Aloka,

What is your motivation for the split? As you stated earlier FILS 
discovery and unsollicited probe responses are mutual exclusive as it 
only eats up airtime to do both. I tend to agree to that earlier 
statement so I would like to see some arguments for doing the split.

Regards,
Arend

> Aloka Dixit (2):
>    nl80211: Add FILS discovery support
>    mac80211: Add FILS discovery transmission support
> 
>   include/net/cfg80211.h       | 25 ++++++++++++++++
>   include/net/mac80211.h       | 31 ++++++++++++++++++++
>   include/uapi/linux/nl80211.h | 46 +++++++++++++++++++++++++++++
>   net/mac80211/cfg.c           | 46 +++++++++++++++++++++++++++++
>   net/mac80211/ieee80211_i.h   |  7 +++++
>   net/mac80211/tx.c            | 25 ++++++++++++++++
>   net/wireless/nl80211.c       | 57 ++++++++++++++++++++++++++++++++++++
>   7 files changed, 237 insertions(+)
> 
