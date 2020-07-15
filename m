Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E972221605
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 22:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGOUVe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 16:21:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40984 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGOUVd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 16:21:33 -0400
Received: by mail-io1-f68.google.com with SMTP id p205so3636959iod.8;
        Wed, 15 Jul 2020 13:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZRHVWlPqJelJFiVKMoOkTYHBbelJXS+3pBc0dV0b9NY=;
        b=Us7uKTD6M5DrP7gemiFjeU+XIkihb6vAloLajScmmxzyUH42Wz3sAuc8aLJvnxWjCK
         5ItPsbmgC160w3UD88EXwDiWT/62Bql9KQUP7IY8QlYg9Evcp2ghTb5xyyGxX9uDmUBv
         NcRx21+03cQ2T1OCVkTXKjQftIgIqgvHAWKj2v383e8hUimU2TyS7aNmkr7Ygcf0PCtl
         xlApc8sawJHBOX7urLqz0hxBMpaHxv6NG3cbdpPKwh8q1w3Y5t+jZU/28+AlR+t4vrt1
         vQf2YkEeP/Um4U6p6H+mP1Vl4AWqdT5NcvbckliXalouLEMDRLy3zguCEcfEDuSHA6u6
         Pa9Q==
X-Gm-Message-State: AOAM531dFO9bUaXxqyGK2qj+3Y+hjfGQcjdBKkfrQPa4fUYz6LIfyL7/
        ND+qo1cx7AJpHz1s+XJU324TsMnNmg==
X-Google-Smtp-Source: ABdhPJzoeoI9JWc8U3GcDRzj/D0vkgWn0Ht/jiPxplyMTK+Lmn1q8ZyO5nTQPEbx+N2/Rb9OdT1WwQ==
X-Received: by 2002:a05:6602:1581:: with SMTP id e1mr1134885iow.44.1594844493064;
        Wed, 15 Jul 2020 13:21:33 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w10sm1578678ilo.10.2020.07.15.13.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:21:32 -0700 (PDT)
Received: (nullmailer pid 754804 invoked by uid 1000);
        Wed, 15 Jul 2020 20:21:31 -0000
Date:   Wed, 15 Jul 2020 14:21:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH 1/2] dt: bindings: Add new regulator as optional property
 for WCN3990
Message-ID: <20200715202131.GA754725@bogus>
References: <1593194502-13164-1-git-send-email-pillair@codeaurora.org>
 <1593194502-13164-2-git-send-email-pillair@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593194502-13164-2-git-send-email-pillair@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 26 Jun 2020 23:31:41 +0530, Rakesh Pillai wrote:
> Add an additional regulator supply as an optional
> property for WCN3990.
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
