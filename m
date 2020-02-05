Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A98153704
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2020 18:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgBERtP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 12:49:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36816 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgBERtO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 12:49:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so3905744wma.1;
        Wed, 05 Feb 2020 09:49:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7yEieln0jae2eT2M/0er6+kV9NoBt/oQX2qMjPZJ/Q=;
        b=Vkg6rWGzIbo2Rb2+JwVkfGipK8LcEPHzzweKLy1UXhfWkt8taI12ZVYMyTHw+Sx+az
         kcscyMSDyzCHgo4BUNWLRs86WOl6RgWT34GUkdXYQGODl/n3wAaUub8205qukgpfLsZ1
         xe2wRUc+sQeZxWzHwuoWzmy5aOLhKBwVaBZc0XEFzxJ955Xd9BR+T1N/PnK3nCojidQB
         7WamhChOj+p15UVuKr3l7i2HpFr4EPCNfajws4S12LjtXVZYUlXDZECdFPItenZcJEZ7
         rYSqfJVCKMCK15gCn+dfah65C1xoq/ZMssX4T4LK4qAivMVTycBUHt1BMKsXaVZPoziH
         RgPQ==
X-Gm-Message-State: APjAAAW7L6wkzm46TYRgKxfgZZvJA1AEaIa4GMAFUEGffr7mKHvLE9gO
        G2VWjf1j6RHg9eoEweColw==
X-Google-Smtp-Source: APXvYqxrkccvNl9da8AtZiLVomEnf+cjr97jeYk9zDCvBB4OzibTwGtQk0HvdayBC/CQAVvY6ffffQ==
X-Received: by 2002:a05:600c:20c6:: with SMTP id y6mr6912417wmm.95.1580924952525;
        Wed, 05 Feb 2020 09:49:12 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id s1sm695548wro.66.2020.02.05.09.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:49:11 -0800 (PST)
Received: (nullmailer pid 29276 invoked by uid 1000);
        Wed, 05 Feb 2020 17:49:10 -0000
Date:   Wed, 5 Feb 2020 17:49:10 +0000
From:   Rob Herring <robh@kernel.org>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     ath10k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: Re: [PATCHv2 1/2] dt-bindings: ath10k: Add new dt entries to
 identify coex support
Message-ID: <20200205174910.GA29218@bogus>
References: <1580152736-18654-1-git-send-email-tamizhr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580152736-18654-1-git-send-email-tamizhr@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 28 Jan 2020 00:48:55 +0530, Tamizh Chelvam wrote:
> This adds new dt entries qcom,coexist-support and qcom,coexist-gpio-pin
> which will be used by ath10k driver to identify coex support
> of a hardware and notify wifi firmware the gpio pin number.
> This pin number information is needed for the hardware QCA4019.
> 
> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
