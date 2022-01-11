Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A9148B097
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 16:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343534AbiAKPOz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 10:14:55 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41710 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343503AbiAKPOz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 10:14:55 -0500
Received: by mail-ot1-f41.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso855982otj.8;
        Tue, 11 Jan 2022 07:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Jk0EX4IKmaccSFEtdG8EcUPH3oeVBCrwdq4GrAlYL0g=;
        b=b9ViV3hj1ceONNz4EfH8tayIqx2PlWhE2/OPnePetMFf7KL4JesXLM+W3/i8giv/Ab
         wp0McgN8BboUu2oGh+b4sjOxUEmyKfrcQSyXKdueA90YoxDxmy6/E0TVDBfdbGcrgVi1
         b6TYmzspvEE4BkjujwO0bcSyMhin1u8tcpt95QEcI8vxlUCEJ2rYfLywX7jlaVpfqxpe
         NU+OIbNAhnVBtYDzEMQTIxHfC9/OVqRw0ISV5FifY0fTh2a7ihwIY4IIMKFVw7b15gDA
         sAxpuhRbZoSxlbOvyStfSVjO3NimlDZ6X0s8pD9KNm2hWa4ok8sDficywCE55gn/8Abz
         1TOQ==
X-Gm-Message-State: AOAM532zYP0AaAOjmQLnoCW8GF9IzM4IWOShsgIArD2EbGOd12G8ze9u
        +DJfyovIm320haXtK15NBTnTX1hSUw==
X-Google-Smtp-Source: ABdhPJwBT4MR4rPnah6BCMtcj1OVOlsRfsANGrWSYKQQmx3Ag8CUMbEk9vVqEBF2AO8N1KqyF/KZ2w==
X-Received: by 2002:a05:6830:149a:: with SMTP id s26mr3550608otq.23.1641914094277;
        Tue, 11 Jan 2022 07:14:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a28sm1682450oiy.4.2022.01.11.07.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 07:14:53 -0800 (PST)
Received: (nullmailer pid 2944758 invoked by uid 1000);
        Tue, 11 Jan 2022 15:14:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>,
        Xing Song <xing.song@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>
In-Reply-To: <67eb9adaa2ed281cb6b8f3c74afc0cc7081f0f6b.1641901681.git.Bo.Jiao@mediatek.com>
References: <cover.1641901681.git.Bo.Jiao@mediatek.com> <67eb9adaa2ed281cb6b8f3c74afc0cc7081f0f6b.1641901681.git.Bo.Jiao@mediatek.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: net: wireless: mt76: document bindings for MT7986
Date:   Tue, 11 Jan 2022 09:14:49 -0600
Message-Id: <1641914089.184254.2944757.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 11 Jan 2022 19:59:17 +0800, Bo Jiao wrote:
> From: Peter Chiu <chui-hao.chiu@mediatek.com>
> 
> Add an entry for MT7986 SoC.
> 
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Cc: devicetree@vger.kernel.org
> ---
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 29 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/wireless/mediatek,mt76.example.dts:131:18: fatal error: dt-bindings/reset/mt7986-resets.h: No such file or directory
  131 |         #include <dt-bindings/reset/mt7986-resets.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:373: Documentation/devicetree/bindings/net/wireless/mediatek,mt76.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1578404

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

