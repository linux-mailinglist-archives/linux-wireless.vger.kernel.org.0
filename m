Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2CA3FCDD9
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Aug 2021 22:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbhHaT3B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Aug 2021 15:29:01 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:46652 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbhHaT3B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Aug 2021 15:29:01 -0400
Received: by mail-oi1-f181.google.com with SMTP id o185so494040oih.13;
        Tue, 31 Aug 2021 12:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fe1iPBUGll7CabOyKIXq9rii3gzsPUouD/WcotDVXrU=;
        b=ecv9w6QVKqgIeS3B+t4h9TQnegJdFMd9JhwhimC+7VHuXNSwnawUbIkPzZkAfbULQS
         p8i7LTRnJj0cHKIxA7SZPN633XNI1zdLhch22Tv7qefjiXzVtMnp8xxu/p+Ct66TZ0Bv
         E8tVMKCLU7FPRg2xeAn/waNjIaoWDBQTeRgsqxX5TEO2XCkGMvZ9K+U89ugEhuapIb4j
         De4fNnnPN4d+52iebQYp4iKuJB+kf0+7UHGwUDDodjDfnc1bcSKlBgyjGL87nTtxf5xj
         auFR7C94dZ2RkcjiMsaBgn4Ybw1m1a2rWth27AAeA8aRA8NasxBJzvjOM+TXHvk7ue1l
         C7wg==
X-Gm-Message-State: AOAM530j3DLqGoboP/evu9sUhrA2WEk5QBYoImzIqZvWtuXa3faHNBfa
        leXBdCnwM1R8WLQTnN6u4w==
X-Google-Smtp-Source: ABdhPJws9qx6XcrPGYIgnpGeYwiVAlvmQxI62yN9BSuYhFdbaGJzn1YOmnSK5UDGBccHB3nFVAw/sQ==
X-Received: by 2002:aca:210f:: with SMTP id 15mr4521746oiz.102.1630438085170;
        Tue, 31 Aug 2021 12:28:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p81sm2001401oia.48.2021.08.31.12.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 12:28:04 -0700 (PDT)
Received: (nullmailer pid 516178 invoked by uid 1000);
        Tue, 31 Aug 2021 19:28:03 -0000
Date:   Tue, 31 Aug 2021 14:28:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH 2/2] dt: bindings: net: mt76: add eeprom-data property
Message-ID: <YS6Cw7YxKKaBaLzW@robh.at.kernel.org>
References: <YSWdv7ZKz7SBtF+v@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSWdv7ZKz7SBtF+v@makrotopia.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 25 Aug 2021 02:33:23 +0100, Daniel Golle wrote:
> EEPROM data for mt76 can be embedded into device-tree as an array.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../devicetree/bindings/net/wireless/mediatek,mt76.yaml      | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
