Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE0107BFC
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Nov 2019 01:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKWAXJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 19:23:09 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33903 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKWAXJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 19:23:09 -0500
Received: by mail-pj1-f66.google.com with SMTP id bo14so3768135pjb.1;
        Fri, 22 Nov 2019 16:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lxLJiYCoNL4i7qjSa7Ir92NEE6tE0glZGS31je6RfW0=;
        b=cIFTyKDs//vQUUXeMmH9rC1VkDlRc3OYhNNjGFbgN4i5byLT+t3sX8XFrfHDGqqzYa
         27USZQ2ysAR8o+OZwCiWKVEJpzV4Msqyr8NReReeqlF0ihnW3SbuA08bnHq6MK9pGq4S
         0vv4X5OOK3gp+C9Q1UaFt7HHIZ5GAQNI2mdsHlr7einn9gXg1mxzHSdT03T9wvQpOgR6
         51rgbA4dSpvATIScRLzbfMjsfTEKGF6U7AQflF2OOjVbdTxTrN43+GEHko2+2QzOc4Ao
         8HuL3+4oyP4a0o3zXNh/rPMuJDccAVxNBitA/FPDtzitMS/mUpaboJgRNOHP0coIX+sL
         ZZ/g==
X-Gm-Message-State: APjAAAWex82sNhtIXA45ftYRAgjG39ysMNzkjKVfLEORmbme9Ge/u2hJ
        K8YmSkXSyyQg3DCtLBQ6eg==
X-Google-Smtp-Source: APXvYqwIxJT29FFU7zIhNQuLQfIDEJQuTdTfpWOzNcB5v2WaCAqz4wqoAtu2sebipwOcgxXsn4bZiQ==
X-Received: by 2002:a17:90a:68cc:: with SMTP id q12mr23009357pjj.118.1574468588250;
        Fri, 22 Nov 2019 16:23:08 -0800 (PST)
Received: from localhost ([172.58.139.180])
        by smtp.gmail.com with ESMTPSA id o125sm8329925pfg.118.2019.11.22.16.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 16:23:07 -0800 (PST)
Date:   Fri, 22 Nov 2019 18:23:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/49] dt: bindings: net: add qcom,ath11k.yaml
Message-ID: <20191123002303.GA23259@bogus>
References: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
 <1573810153-29623-2-git-send-email-kvalo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573810153-29623-2-git-send-email-kvalo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 15 Nov 2019 11:28:25 +0200, Kalle Valo wrote:
> ath11k is a driver for Qualcomm IEEE 802.11ax devices. Add a
> bindings document for the driver, first documenting IPQ8074 which is the
> only device ath11k currently supports.
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> ---
>  .../bindings/net/wireless/qcom,ath11k.yaml         | 273 +++++++++++++++++++++
>  1 file changed, 273 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
