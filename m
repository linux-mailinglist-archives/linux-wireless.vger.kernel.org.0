Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5E91BB8EA
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 10:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgD1Igp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 04:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbgD1Igo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 04:36:44 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384FAC03C1AC
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 01:36:44 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k28so16177065lfe.10
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 01:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xz3A6xl5ya595zoZHjHSS41TmX4fAGs0v1xk0KBT4a4=;
        b=jcApM/YXd7Ysg6tNDbJlxNmqsQ9b/R1k3P4+Cjq9QBJ/TcZ7/b3WhfhubDmPQu966C
         1F7QaOF4oECGZ5mA4GeFosaqRj9b69nuoga/DknTOqwbSfbNaerxeHBKmcr72qPliHIx
         XEEZXQnm3xBawL/G8J2j4H12Ypzyb0mhBqkIdwDVjiRpPa5i9FgOoYvZo+VG0oIBuG47
         A1RXp4eanMhsoO6w/YDxAZXiwymJXNZfPtl6aQSoY2bieJs3OLNWt3Y9XRoP8YmN0sPp
         +tddM22r5+uquIhtCyZajxLrtBFjZj0ewTx3o3AMcylnVEPZNL3MTkJZGbWnw/ZDRWMQ
         ZUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xz3A6xl5ya595zoZHjHSS41TmX4fAGs0v1xk0KBT4a4=;
        b=UM1+4xifyhcdacqH8WpNWJrO8OxiNdOsMvaAd5DCalmMVkF16yiDUm0UI7tiziKdX0
         mSIq8PB8bpTxt3Xa+8E2w8BOVmGLPxAf9aQJjcxLRnLighMPdw19kwDiB31ZLnoTtb0e
         6XQ2ziiFcIF1wBqSgs+Emm66ByX6f8eVqaZNmsrwjiIy6QCs1wDv8nULzmAMj3N6NVk4
         DRusfs8JGXRoNnxCyuALk1VXxZwOkWZ/iqKg08RP6/t4h67KikQiquSMfii7INONZBEt
         hn0YUFVzR/7sGQPS0mod7RrA07FUPKVNnKdSACv6f3Ub9+YEIeAcX97b/BVcLMsnO9ra
         6XFA==
X-Gm-Message-State: AGi0PubuphG5VlJiwrnDlnaFfCBQuDppQqlcE6SH6LoTJaYhnk14nLLO
        fxMlHGXkLx2jqHEVO8JQOIMq6TPV
X-Google-Smtp-Source: APiQypJCXH01zzeVIyoTb/Rrgxg/w3McvgN9cYY/iqBCMLqWUB/lmmWRuJjSubqFbjV5gp8Q5dGglg==
X-Received: by 2002:ac2:4c9a:: with SMTP id d26mr18047161lfl.112.1588063002572;
        Tue, 28 Apr 2020 01:36:42 -0700 (PDT)
Received: from curiosity (ip-195-182-157-78.clients.cmk.ru. [195.182.157.78])
        by smtp.gmail.com with ESMTPSA id t12sm13732265lfq.71.2020.04.28.01.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 01:36:41 -0700 (PDT)
Date:   Tue, 28 Apr 2020 11:41:08 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 2/2] staging: wilc1000: adjust for management frame
 register API changes
Message-ID: <20200428084108.GB4287@curiosity>
References: <20200428101400.ae19d651ec38.Ieb15844bb5ab93b3d7931d6561f42e3316ef8251@changeid>
 <20200428101400.bac7e94c2bf8.I6a2287b9f68f35aff5f6de409c5ffa388de760e2@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428101400.bac7e94c2bf8.I6a2287b9f68f35aff5f6de409c5ffa388de760e2@changeid>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Johannes Berg <johannes.berg@intel.com>
> 
> Adjust to the API changes in cfg80211 for management frame registration.
> 
> Fixes: 6cd536fe62ef ("cfg80211: change internal management frame registration API")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/staging/wilc1000/cfg80211.c | 36 ++++++++++++++---------------
>  drivers/staging/wilc1000/cfg80211.h |  5 ++--
>  drivers/staging/wilc1000/netdev.c   | 21 ++++++++---------
>  drivers/staging/wilc1000/netdev.h   |  9 +-------
>  4 files changed, 30 insertions(+), 41 deletions(-)

Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

Regards,
Sergey
