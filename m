Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22592416821
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 00:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbhIWWjR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 18:39:17 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41739 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbhIWWjR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 18:39:17 -0400
Received: by mail-ot1-f43.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso10640698ota.8;
        Thu, 23 Sep 2021 15:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=UUg+xdONDeTpHdeqNZwfSRiohr9VRPnz8eYVI07uERI=;
        b=66axoZfA5LrHLpL2/SB3joFkBMET6+sUcJOZ5If0+vI7hPG0m4e/Ht7Fqr5smJlmA8
         wpd/ZQUQPE7U2AQ/hLgqvp2fhd8MH9WVMYhXj4yARiwhsG+vDASh+v0f9YJo6fgUZwUG
         JdcdbnIZnGMprm3KtlgkT50SI+R+boaNiGjf+W/cXuOanlI6Ma7kzWrIN+/O8/hbr07v
         8roLCCj+x+EQeAnQkg7ZIub47a0DGNBOqjRzqyEOvhI7J7cqSii13HM1JEeaC/YGMYgY
         F7sGQdcp8/srjVd6WIRJU6P3Jex/e4Y/37xdJyAZe91pAkjq0Tl2HHBy7sf0AdnFI1RV
         xmtA==
X-Gm-Message-State: AOAM533/D392BFSpEZMyE07bUyt9Pubrd/IMldEglBTGNZfAJ9QZem1c
        RugQgJO6wcaGoe6a8vEP/g==
X-Google-Smtp-Source: ABdhPJyZ8hoIBge0ZaeV70lQTJxCI4FfxoE0mXxAaQE8jnnAmXa18YCoM0BMlHe9eQAboEEkj6arXw==
X-Received: by 2002:a05:6830:358:: with SMTP id h24mr954358ote.159.1632436664563;
        Thu, 23 Sep 2021 15:37:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t80sm1722423oie.9.2021.09.23.15.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 15:37:44 -0700 (PDT)
Received: (nullmailer pid 3653403 invoked by uid 1000);
        Thu, 23 Sep 2021 22:37:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org
In-Reply-To: <20210923202029.575660-1-chunkeey@gmail.com>
References: <20210923202029.575660-1-chunkeey@gmail.com>
Subject: Re: [PATCH v3] dt-bindings: net: wireless: qca,ath9k: convert to the json-schema
Date:   Thu, 23 Sep 2021 17:37:43 -0500
Message-Id: <1632436663.364411.3653402.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 23 Sep 2021 22:20:29 +0200, Christian Lamparter wrote:
> This replaces the existing .txt binding file. Furthermore, this
> also helps with validating DTS files.
> 
> Introduced binding changes:
>  1. added inherited mac-address nvmem property
>  2. added inherited ieee80211-freq-limit property
>  3. added new calibration nvmem property
>  4. added second example (taken from the Netgear WNDR3700v2)
>     Reason: Setting qca,no-eeprom; takes presedence over
>     nvmem-cells. I think a different example is needed,
>     because the driver can only reads from one calibration
>     source per device.
>  5. (re-added) chip list (based on data from ath9k's pci.c)
> 
> Added binding .yaml to MAINTAINERS.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> 
> ---
> v1 -> v2:
> 	- added second example (pci device - AR9220)
> 	- added commented chip list from the qca,ath9k.txt+ath9k's pci.c
> 
> v2 -> v3:
> 	- forgot to include patch version in tag. Oops.
> 	  (Please ignore the v2 with the missing v2 I just sent.)
> 
> (I hope my changes didn't invalidate Rob's review there.
> I did run "make dt_binding_check" and no warning/error
> came up.)
> ---
>  .../bindings/net/wireless/qca,ath9k.txt       | 48 ----------
>  .../bindings/net/wireless/qca,ath9k.yaml      | 90 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 91 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml:23:21: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1531944

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

