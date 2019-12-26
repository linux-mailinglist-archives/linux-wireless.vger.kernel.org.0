Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 573AC12ADFA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2019 19:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfLZSvf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Dec 2019 13:51:35 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40771 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLZSvf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Dec 2019 13:51:35 -0500
Received: by mail-il1-f196.google.com with SMTP id c4so20787962ilo.7;
        Thu, 26 Dec 2019 10:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3UMtDU8DxQ3MGtUa2c3Y90UpyYpDwJplb5ZS1zSkCmc=;
        b=QrtocgHCQXk04vR6BgiPYGQm7ytzjiESt+NOeJO1mbHgWqa0VE1HZiCOlU7j/35RPI
         e2yGeK8iCmQEQaWPAMLEhorxennaDJ6IL+VUtcRCPIkkqmKSmkZE+3b1geWoBjZ3sGpM
         +0am8og/i+aOzMGIQ5a2mMzr06Pthk8MxKEkX4LNSJfqSbCYdbdfdLFbGkqZ4zhFhYKF
         GXak+4NVTGODibAclqCuW8pA87KlLT+zGio450BNB3iaaC9J/3AHbKjUlKakwbb7SNzl
         oN2XrzTK7U8KSzi7JkpXQqzPhZPzzBohzpjbFxfSseBilEQndodVGuiDYVunebopGYDe
         BeJQ==
X-Gm-Message-State: APjAAAUfvBPaNiBvirnysKFiyoJIgJWzN3rNHDuYmEQ2Q1fapPqUtest
        /ISXr4IQCb0GXmzcoI8xiPBPEmo=
X-Google-Smtp-Source: APXvYqySldlRAzOb9NpZjVOq6WC0G5C70Vuhd2vFmw3FOsorrKM5EEz3CstEkjK7Hu4QPpJKtktk+g==
X-Received: by 2002:a92:9a56:: with SMTP id t83mr40442318ili.200.1577386294850;
        Thu, 26 Dec 2019 10:51:34 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k16sm12454714ili.35.2019.12.26.10.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 10:51:34 -0800 (PST)
Date:   Thu, 26 Dec 2019 11:51:32 -0700
From:   Rob Herring <robh@kernel.org>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     ath10k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ath10k: Add new dt entries to identify
 coex support
Message-ID: <20191226185132.GA31120@bogus>
References: <1576496415-23064-1-git-send-email-tamizhr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576496415-23064-1-git-send-email-tamizhr@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 16, 2019 at 05:10:14PM +0530, Tamizh Chelvam wrote:
> This adds new dt entries qcom,coexist-support and qcom,coexist-gpio-pin
> which will be used by ath10k driver to identify coex support
> of a hardware and notify wifi firmware the gpio pin number.
> This pin number information is needed for the hardware QCA4019.
> 
> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> index 0171283..a41e936 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> @@ -87,6 +87,10 @@ Optional properties:
>  	Definition: Quirk specifying that the firmware expects the 8bit version
>  		    of the host capability QMI request
>  - qcom,xo-cal-data: xo cal offset to be configured in xo trim register.
> +- qcom,coexist-support : should contain eithr "0" or "1" to indicate coex
> +			 support by the hardware.
> +- qcom,coexist-gpio-pin : gpio pin number  information to support coex
> +			  which will be used by wifi firmware.

What combinations of these 2 properties are valid?

Is qcom,coexist-gpio-pin required for coexist support? If so then it 
alone should be enough to enable/disable coexist.

>  
>  Example (to supply PCI based wifi block details):
>  
> @@ -156,6 +160,8 @@ wifi0: wifi@a000000 {
>  	qcom,msi_addr = <0x0b006040>;
>  	qcom,msi_base = <0x40>;
>  	qcom,ath10k-pre-calibration-data = [ 01 02 03 ... ];
> +	qcom,coexist-support = <1>;
> +	qcom,coexist-gpio-pin = <0x33>;
>  };
>  
>  Example (to supply wcn3990 SoC wifi block details):
> -- 
> 1.9.1
