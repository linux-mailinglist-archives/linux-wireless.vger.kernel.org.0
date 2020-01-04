Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBB112FFDF
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jan 2020 02:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgADBAD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jan 2020 20:00:03 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43710 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgADBAC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jan 2020 20:00:02 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so41580877ioo.10
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jan 2020 17:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I+/EbHTtG3XdToYbfWwK52tIPgUdmxs5X56AS9/kYW4=;
        b=MZJO/S4zZVJWcRpkraNSIyTYU0+8x8vh4fZfQ9jCrvDEIkOmI+f1In5zG/fV1vm6v1
         7cRrq/JkNTTsOV3RsKsqj4NanM9nSf7I4tjC0um9vw5mDoYbJ205S0mxXgJZEY4GZNep
         PcjF10moabKheDWppQcbXYq4nStURTbOc8DJyGWGB22qmwEgaa8EHXKFfl9m5R7Ky++0
         BSQjiKjYTnwW0siQEDF2iL2Ait9XUye4tBaWYi6UUKiWx9ySjHhPNfrj3/QOcdR1K57P
         xc+cGb3kP9++C7zcGnsYUrEdzZkXW5r2w6OVp9pIxjXAfNiLHviCzlvae4ImFG/4G0YP
         qBdw==
X-Gm-Message-State: APjAAAXxIerKzGE3IKGqW70I94JaNE07pXTR8/cs0HQ1DXMolvbickmF
        y6/uaimbxFE8abAJSYMosUrUGIw=
X-Google-Smtp-Source: APXvYqyUQbFIsoiCJpvqSEp4qqwhQw7fGoN4YQB16/OcCDQ/ZJYfURbKQj9K1gvi6eOKGMPchcGcPA==
X-Received: by 2002:a5d:8cda:: with SMTP id k26mr36880773iot.26.1578099601929;
        Fri, 03 Jan 2020 17:00:01 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id j26sm15256715iok.3.2020.01.03.17.00.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 17:00:01 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 17:59:59 -0700
Date:   Fri, 3 Jan 2020 17:59:59 -0700
From:   Rob Herring <robh@kernel.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: Re: [PATCH v3 1/2] dt: bindings: add dt entry flag to skip SCM call
 for msa region
Message-ID: <20200104005959.GA15965@bogus>
References: <20200103134414.15457-1-govinds@codeaurora.org>
 <20200103134414.15457-2-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103134414.15457-2-govinds@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri,  3 Jan 2020 19:14:13 +0530, Govind Singh wrote:
> Add boolean context flag to disable SCM call for statically
> mapped msa region.
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath10k.txt          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
