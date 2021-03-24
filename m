Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340E9347F1F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 18:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhCXRRM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 13:17:12 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:43842 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbhCXRQ7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 13:16:59 -0400
Received: by mail-il1-f169.google.com with SMTP id d2so22049836ilm.10;
        Wed, 24 Mar 2021 10:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MzSsbXS/EHdDoiyXCsUvYDAcPr5AyyjqLXTH/3U3mTM=;
        b=Xtox+eKIp4KWmab/Gty9voQK72q8cEThqhtTvCENK3iiotmO68DIGlc1MiwV2v8BQZ
         2v1LLz559ajYakd6j+0BO9WHNGTTY+h9VFr5Fn6sAlx5ojQeFoNdgJAGHb/osPjvLKyT
         zz3PwggKSSn39QffsbSYIFY0qgnJMs3CnRiDtL8NVoYIc1hr37pySOeIgSTpnJA3RLwU
         EoA/CfcVX1YfR6HtDRcVdC+WWPGqpsdxWDSRJh7rS8gS7MI2iQwMj3rolCfqxX4QJ9Qc
         heUB4OR5jIrT8/B5ADNwx9JG97YFSKs7t/BoxJOgjHYpbXtVlwK7vSXVryhfDI8FUQ3f
         6qgw==
X-Gm-Message-State: AOAM533lksOeOWZfaYkNinqPo49l1zWOhE27eUH8v03Xe69+pPlzi5fu
        jz75Y3vy2Wt8eEgH9f+18g==
X-Google-Smtp-Source: ABdhPJxdXDxMXRVURGpkS1DKn6VWOxa/qMIXq6sgdmihSdWdvnhllj3gcn4YKj3HtV3RwzLxjzYomA==
X-Received: by 2002:a05:6e02:df2:: with SMTP id m18mr3297428ilj.123.1616606218476;
        Wed, 24 Mar 2021 10:16:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id n7sm1419789ile.12.2021.03.24.10.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:16:57 -0700 (PDT)
Received: (nullmailer pid 3271536 invoked by uid 1000);
        Wed, 24 Mar 2021 17:16:55 -0000
Date:   Wed, 24 Mar 2021 11:16:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        johannes@sipsolutions.net
Subject: Re: [PATCH v2 1/2] dt-bindings:net:wireless:ieee80211: txt to yaml
 conversion
Message-ID: <20210324171655.GA3266836@robh.at.kernel.org>
References: <cover.1615752835.git.lorenzo@kernel.org>
 <3dca0518c14e3a8e563933c903de0d62429a3667.1615752835.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dca0518c14e3a8e563933c903de0d62429a3667.1615752835.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Mar 14, 2021 at 09:21:06PM +0100, Lorenzo Bianconi wrote:
> Convert generic ieee80211 dts bindings from .txt to .yaml
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/net/wireless/ieee80211.txt       | 24 -----------
>  .../bindings/net/wireless/ieee80211.yaml      | 41 +++++++++++++++++++
>  2 files changed, 41 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/wireless/ieee80211.txt
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.txt b/Documentation/devicetree/bindings/net/wireless/ieee80211.txt
> deleted file mode 100644
> index f6442b1397f5..000000000000
> --- a/Documentation/devicetree/bindings/net/wireless/ieee80211.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -Common IEEE 802.11 properties
> -
> -This provides documentation of common properties that are valid for all wireless
> -devices.
> -
> -Optional properties:
> - - ieee80211-freq-limit : list of supported frequency ranges in KHz. This can be
> -	used for devices that in a given config support less channels than
> -	normally. It may happen chipset supports a wide wireless band but it is
> -	limited to some part of it due to used antennas or power amplifier.
> -	An example case for this can be tri-band wireless router with two
> -	identical chipsets used for two different 5 GHz subbands. Using them
> -	incorrectly could not work or decrease performance noticeably.
> -
> -Example:
> -
> -pcie@0,0 {
> -	reg = <0x0000 0 0 0 0>;
> -	wifi@0,0 {
> -		reg = <0x0000 0 0 0 0>;
> -		ieee80211-freq-limit = <2402000 2482000>,
> -				       <5170000 5250000>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> new file mode 100644
> index 000000000000..6fb9ae7403c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/ieee80211.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common IEEE 802.11 Binding
> +
> +maintainers:
> +  - Johannes Berg <johannes@sipsolutions.net>
> +
> +description: |
> +  This provides documentation of common properties that are valid for
> +  all wireless devices
> +
> +properties:
> +  ieee80211-freq-limit:

Needs a type ref:

$ref: /schemas/types.yaml#/definitions/uint32-matrix
items:
  minItems: 2
  maxItems: 2

> +    description:
> +      List of supported frequency ranges in KHz. This can be used for devices
> +      that in a given config support less channels than normally. It may happen
> +      chipset supports a wide wireless band but it is limited to some part of
> +      it due to used antennas or power amplifier. An example case for this
> +      can be tri-band wireless router with two identical chipsets used for two
> +      different 5 GHz subbands. Using them incorrectly could not work or
> +      decrease performance noticeably
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    pcie0 {
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      wifi@0,0 {
> +        reg = <0x0000 0 0 0 0>;
> +        ieee80211-freq-limit = <2402000 2482000>,
> +                               <5170000 5250000>;
> +      };
> +    };
> -- 
> 2.29.2
> 
