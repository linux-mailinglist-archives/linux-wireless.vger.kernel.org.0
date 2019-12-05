Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB561148CD
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 22:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfLEVsg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 16:48:36 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44334 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbfLEVsf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 16:48:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id x3so3963423oto.11;
        Thu, 05 Dec 2019 13:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=coyOvgWTYrQ7WR6ABQooVjUnJpSFQK1P2URKO0xpD0w=;
        b=BxqINOSFkEYKYaSb2KhlngJ9PuQ8zgIvdurDnutgvRTuJo/4SYleCF762nisrB8G98
         liFQcFEIkcCcS1Mj3IfzppGYKPmLLyM7cFCEo4sYsJGusuKWpLP4hhdz+8VExp3Cvlyj
         h2wX5vH0x+JGOgYGItdsFEADYmfShAFde93mknA1w7akVicUDkbMcVncvruxVABFURZZ
         9RXfz4AHZfxfgGI975mARh1FyydrsvK1EhFFmi5Ttx1k1gGF3klUIbp/TtLkWpq0q+U9
         M5vA+Tc0FaKFtxSQgC8hS6LRa1dqOpnhPKytNK1n4YptYM2i8q6BKnbnhjAR9pDnQ2MA
         ZyYg==
X-Gm-Message-State: APjAAAXmYop37md8hO5liCmd029WyM/cYIiP0yxBBcjOr7vRpdGWDvWV
        96QKqUtFCi+hX2jRsFhE0b97X/o=
X-Google-Smtp-Source: APXvYqz+/xHBWYyf66UeM80J+fWiUwnoj20g7bmhfI+HsBKUoddRJfDYxDbJ+yFkm+BibevNuV5lBA==
X-Received: by 2002:a9d:6196:: with SMTP id g22mr8749600otk.204.1575582515123;
        Thu, 05 Dec 2019 13:48:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s133sm4000150oia.58.2019.12.05.13.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:48:34 -0800 (PST)
Date:   Thu, 5 Dec 2019 15:48:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v2 2/2] dt-bindings: net: wireless: mt76: introduce
 big-endian property
Message-ID: <20191205214834.GA19679@bogus>
References: <cover.1574865558.git.lorenzo@kernel.org>
 <1b46b03f6c60c08d29d4c3cc4e2ae0a50af5eb30.1574865558.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b46b03f6c60c08d29d4c3cc4e2ae0a50af5eb30.1574865558.git.lorenzo@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 27 Nov 2019 16:46:34 +0200, Lorenzo Bianconi wrote:
> Introduce big-endian property to specify mtd radio partition endianness
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/wireless/mediatek,mt76.txt         | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
