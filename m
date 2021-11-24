Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B05845B260
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 03:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbhKXDCn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 22:02:43 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:43752 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhKXDCj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 22:02:39 -0500
Received: by mail-io1-f50.google.com with SMTP id z26so1294620iod.10;
        Tue, 23 Nov 2021 18:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=hUyB8SMEZEe+wyhi5A4ravu9airL4cafjZQp9SXQVNw=;
        b=IqVgIVYvlhWY18qCIn+Bzd4n2eHPsFKYqXXm4qnR1hzioaLNOpiMoPxvC7cFOaIWe8
         APdpIlHrcwmVX+4MWlmecZ0n3wDXBBbC9qDC7peX7lqMGN3+RlCkQdh5Ye+Nrm7rdNcz
         AoLdUO5oKLIDZSkeNeFzP+7czb0RIL7F1MXhw5h8YHMYPzZSuIkruvrgApb8BQazmyhd
         7CiYwSEFXexMmPTfShx/cy+UQLQJI22Rsrway2ssWNllC9U+wdeVna0u9phoDayYEx5+
         D7Pa/8vLi6zK8k+TsvVm/XVo/XIqZP0eZvs5eI1sVmmU5L72uawwXz9ilHkpqlwKLEQc
         D5Jw==
X-Gm-Message-State: AOAM531owkokzbNFqydZIZgBoqBHhafFKCKzcI2Cs8VdyQvTbTKl2va1
        gXSYl8GSNtz1zo4VnChGdMR5/wpoIA==
X-Google-Smtp-Source: ABdhPJxeQsgBpDAOtsETWCseXbp1sz848Ix20LrL1yEptsj4UjtqyKezE8HZZzhXVSIc9seyIhVb5g==
X-Received: by 2002:a02:8663:: with SMTP id e90mr11391156jai.14.1637722769739;
        Tue, 23 Nov 2021 18:59:29 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id ay13sm9089587iob.37.2021.11.23.18.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 18:59:29 -0800 (PST)
Received: (nullmailer pid 888172 invoked by uid 1000);
        Wed, 24 Nov 2021 02:59:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <1637693434-15462-20-git-send-email-quic_mpubbise@quicinc.com>
References: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com> <1637693434-15462-20-git-send-email-quic_mpubbise@quicinc.com>
Subject: Re: [PATCH 19/19] dt: bindings: net: add bindings of WCN6750 for ath11k
Date:   Tue, 23 Nov 2021 19:59:21 -0700
Message-Id: <1637722761.019285.888171.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 24 Nov 2021 00:20:34 +0530, Manikanta Pubbisetty wrote:
> Add WCN6750 wireless driver support, its based on ath11k driver.
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> ---
>  .../bindings/net/wireless/qcom,ath11k.yaml         | 333 ++++++++++++++-------
>  1 file changed, 225 insertions(+), 108 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml:57:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml:0:0: /example-1/remoteproc@8a00000: failed to match any schema with compatible: ['qcom,sc7280-wpss-pil']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1558747

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

