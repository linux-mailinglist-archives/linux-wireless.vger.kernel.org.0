Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446ED154D19
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2020 21:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBFUp2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Feb 2020 15:45:28 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34051 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgBFUp2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Feb 2020 15:45:28 -0500
Received: by mail-pj1-f67.google.com with SMTP id f2so655154pjq.1;
        Thu, 06 Feb 2020 12:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vCgkQ9Nwh84zfpfOxPFRld6KLGaYtG3x5hpmxoRF600=;
        b=MxC4VA803Hx8yGCukVXoo1C+5DjvHn7GLVWuGx9pZvDNRLaVC/JaZh6IbY63DdFA/K
         zOBEBvbXuhb42j0CnKWfMg1A4q8aQyt2ph3CAH3ii/vHEa9tN5DlQhunYEWj7JSofetJ
         AUMjrLURO8HgZRIyYNE2KBAkdgT3V1xmcJ7WWZNlUlbbkb+pG8DDoOkLy0ubvfoUpfCH
         zHi2r7bK2wW+hIYCPfL6LlpLvbAo3MdMhXzg6u79WiQ2u1zjvJ+aRTvuRnqkW00CQVru
         Lw7nHChEkz6lzwqud2AR8g+OLE0WWkkr2ABDvmFsFsVvxrh9UZSNP8wdW27ki3LWVZZ7
         t/PA==
X-Gm-Message-State: APjAAAXr/0x5g/3gjPF7AzZ0bjqnsli1abXwzQ3oymCwMAyWOEXH32j3
        W7N51BtQccDMGdDu/7XILEHuL/FafQ==
X-Google-Smtp-Source: APXvYqyq2g8mBmBjRil05ulZerB8hO+T93Rrx3/WCqh8GeKdyfaMW0nZ4KUewMQgTDEGvsBfTkFq3g==
X-Received: by 2002:a17:90a:330f:: with SMTP id m15mr6596932pjb.24.1581021927783;
        Thu, 06 Feb 2020 12:45:27 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id f127sm280145pfa.112.2020.02.06.12.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:45:27 -0800 (PST)
Received: (nullmailer pid 12148 invoked by uid 1000);
        Thu, 06 Feb 2020 18:22:39 -0000
Date:   Thu, 6 Feb 2020 18:22:39 +0000
From:   Rob Herring <robh@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/15] dt-bindings: net: wireless: mt76: document
 bindings for MT7622
Message-ID: <20200206182239.GA12086@bogus>
References: <20200130144718.14298-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130144718.14298-1-nbd@nbd.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 30 Jan 2020 15:47:04 +0100, Felix Fietkau wrote:
> MT7622 is a SoC that includes a 2.4 GHz 4x4 802.11n WMAC. Its
> feature set is comparable to a MT7615 chip, but limited to 2.4 GHz.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  .../bindings/net/wireless/mediatek,mt76.txt   | 26 ++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
