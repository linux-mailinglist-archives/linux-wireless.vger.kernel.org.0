Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AED32BB4DA
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 20:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgKTTJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 14:09:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57799 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbgKTTJV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 14:09:21 -0500
Received: from mail-oo1-f72.google.com ([209.85.161.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kgBmY-0001Ct-Kf
        for linux-wireless@vger.kernel.org; Fri, 20 Nov 2020 19:09:18 +0000
Received: by mail-oo1-f72.google.com with SMTP id 4so4343052ooc.21
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 11:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PEveoKuLfLst6ktRz43NnxLZwk4q7ZB78x/yfj+Fi0g=;
        b=EfKji7pYj9ZxqfWm+5FWdwSa8uve42ZqfnfdGzgA8g2NvPv9IrN2Xejnlj5tg3/iAg
         7bGOAyfqxLpNZ8Xacumfx+B95Kd7ksa9iVWi2Fn+juG5iWBLHB7KiYRqhqG3QY7dyygY
         932rPnVkhSAwM/69cai4akyWgVgu2D6Iz6/eRMNBH5K3m7MvjUE2Jw1JopLcOnUAuYtr
         hVL9cSKml+AOltSjRrQ7Nh8Pl3RVtp51MkFzOAnsAI+YGsonE5/2nvYwaf63CapPb2y0
         Esm535dPyICB76qskbxGkQo3YUIW7Lx/KvxMhwKNr3Cgiy3aqd6f4q42EoVAbbIpmXj6
         SeqQ==
X-Gm-Message-State: AOAM533urlz4OrEM6UcNrC9CM91Pwtgv0vstQjx47s/Gj+sgPes0w4J0
        mMJKh3wClTPu12Tf4WHDvjDt+iXnDXMVH9gfFKt5jgXEzqIFQdSVgA5S31TgGk9YOFAGumONU2O
        vyQAzKmelpXjK7bqXtALpCrF0rpMTZ46M1b6onBfQ6DUU
X-Received: by 2002:a9d:69d2:: with SMTP id v18mr15473432oto.165.1605899357667;
        Fri, 20 Nov 2020 11:09:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzO+Z1/rftRa2kvpt2KELR7F6jliDKWqHuaM8WoA2xl+56vybPk970gYj8lHsZ5ErEOce/qTA==
X-Received: by 2002:a9d:69d2:: with SMTP id v18mr15473412oto.165.1605899357430;
        Fri, 20 Nov 2020 11:09:17 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:1158:e034:1c89:296f])
        by smtp.gmail.com with ESMTPSA id j9sm1666399oij.44.2020.11.20.11.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:09:16 -0800 (PST)
Date:   Fri, 20 Nov 2020 13:09:15 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Pavel Starosek <starosekpd@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: Update regulatory rules
 for Kazakhstan (KZ)
Message-ID: <20201120190915.GO5439@ubuntu-x1>
References: <CAPgWZqy_bD7KP_ONv1C7tUVw4TLw3QK_xcyYXpi_WH1=4VJwQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPgWZqy_bD7KP_ONv1C7tUVw4TLw3QK_xcyYXpi_WH1=4VJwQw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 12, 2020 at 12:46:34AM +0600, Pavel Starosek wrote:
> Based on [1]:
> * Extend 2400-2483.5 MHz range
> * 5150–5250 MHz range may be up to 200 mW
> * Add 5725-5850 MHz range for indoor usage
> * Add 57-66 GHz range.
> * In 5470-5725 range change the bandwidth from 80 to 160
> 
> [1] http://adilet.zan.kz/rus/docs/V1500010730
> 
> Signed-off-by: Pavel Starosek <starosekpd at gmail.com>

Applied, thanks!
