Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9FC19E84A
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2020 03:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgDEBci (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Apr 2020 21:32:38 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42351 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgDEBci (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Apr 2020 21:32:38 -0400
Received: by mail-il1-f195.google.com with SMTP id f16so11302674ilj.9;
        Sat, 04 Apr 2020 18:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=bbwT0JDvAgpa3Sushm5zcwL/0sAYePwp2JhJddCJiiQ=;
        b=X67qtC/Ssl1KDNmnw7lA2tKiqLNyeQ4yLy2EBE3kqVJcwzxrxpf7k30GdYNhEO8S1k
         MjNZwWFt5ra08A0U6RkBOkGy3VZ6cPR/tYwa9/kehLaw1Em5728JXqhL7OwDugF4eRXM
         IKepHON+4fDO96Eu6qlMfFWPQJ03UL8dN0xa/+alKrkNt0ttgT2/DizTf9AxIm11PNyO
         RM+ph+8D1QLgkWrHDhUmlAt8StfdlUduwJ5opc2pVtDGIfcBtx5i85ozzzuHVCvDcxn5
         KJiE1ei/AEx5EZVQj/HaiQd1raoyAtmC5qK+Bd380RWXYMLLWAQ8+D0nqA295CwCeGNd
         Yz+Q==
X-Gm-Message-State: AGi0PuaMvYhzLmuc0UGGOdlSVglaNAa0eDhg5alGkd+yn3QD3JF9+su/
        l71LumXzzGXX/6oCqjXweQ==
X-Google-Smtp-Source: APiQypJIboR7CPmas3cH43grVLYaKmX7hmJ5bSlCUVLcJdeUJEMupnl7qTdmDv4uL+jfDP3xqrCl9g==
X-Received: by 2002:a92:9149:: with SMTP id t70mr16383960ild.114.1586050357391;
        Sat, 04 Apr 2020 18:32:37 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i16sm4429879ils.40.2020.04.04.18.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 18:32:36 -0700 (PDT)
Received: (nullmailer pid 24273 invoked by uid 1000);
        Sun, 05 Apr 2020 01:32:35 -0000
Date:   Sat, 4 Apr 2020 19:32:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        johannes@sipsolutions.net, Adham.Abozaeid@microchip.com,
        Nicolas.Ferre@microchip.com, Claudiu.Beznea@microchip.com,
        Venkateswara.Kaja@microchip.com, Ajay.Kathat@microchip.com
Subject: Re: [PATCH v6 16/17] dt: bindings: net: add microchip,wilc1000.yaml
Message-ID: <20200405013235.GA24105@bogus>
References: <20200327063302.20511-1-ajay.kathat@microchip.com>
 <20200327063302.20511-17-ajay.kathat@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327063302.20511-17-ajay.kathat@microchip.com>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 27 Mar 2020 06:33:20 +0000, <Ajay.Kathat@microchip.com> wrote:
> 
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> This file describes the binding details to connect wilc1000 device. It's
> moved from staging to 'Documentation/devicetree/bindings/net/wireless'
> path.
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
>  .../net/wireless/microchip,wilc1000.yaml      | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
