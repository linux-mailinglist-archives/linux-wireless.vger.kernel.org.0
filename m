Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A0033F4DB
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Mar 2021 17:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhCQQAa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Mar 2021 12:00:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34388 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhCQQAL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Mar 2021 12:00:11 -0400
Received: from mail-ot1-f69.google.com ([209.85.210.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1lMXwl-00078G-Vv
        for linux-wireless@vger.kernel.org; Wed, 17 Mar 2021 15:18:56 +0000
Received: by mail-ot1-f69.google.com with SMTP id q1so22906169ota.20
        for <linux-wireless@vger.kernel.org>; Wed, 17 Mar 2021 08:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IMQkeb8C8zTS2KQtguiqq0hY0iudIDCXnoKwS1K8RHs=;
        b=Qr+yVLdUc9ZDs60jRKxxLzk3j1exIRgVHVCZ/LjEbV7y+X3g8gJWwwoxq5I/PT/Cup
         2wiWMsTUSH0zytZ2FUqYCcrvktFcNsb+nAOEsvJ4mE4Zyym0n3BdV/nx4+m6FGybfJZa
         u6+dJ5J1SnMR7awoOv7/b3PvYHa4FXTZ6KpP14z5oK823riTlSCghsnQZaR174/G6nlb
         4ONWEokNonj1IBzqRmAjAJaeYDR5J6NdeksLylQkvLcwy8AQgc8lRDV5nf7N/kVEXTzq
         Nb+76+7uNXutQLux6jjAagonJfwBnlFEK2q+rFaJUKLwXt4gZGhM1J4atKxsqxFXwiVi
         Nqfg==
X-Gm-Message-State: AOAM531DoRYLMLTYuz76NSaU6nHZV2uRlBf/A2a0JexXlj4kxDV6MK/9
        vW2I1cFtf8hjYp8JvybmrL28tgN0Kp837s8+T3gfEHtylMykzFn/ZTOGnB2p+gcGxMOJNoKNL9P
        XN6YJZkQX7056hUsfloSmiV+rNwTw1gCXxl/x/W9QNaK/
X-Received: by 2002:aca:d5d1:: with SMTP id m200mr3103991oig.102.1615994335063;
        Wed, 17 Mar 2021 08:18:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPDGcpB3AYV2GfSYPe9ARdwP8BP/TaRDgKfT82eqzMEsiWZUQXI4DAG6c76D5tVNlRoGhuuQ==
X-Received: by 2002:aca:d5d1:: with SMTP id m200mr3103977oig.102.1615994334923;
        Wed, 17 Mar 2021 08:18:54 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:7d7a:9094:cb30:6686])
        by smtp.gmail.com with ESMTPSA id k9sm8757560ots.24.2021.03.17.08.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 08:18:50 -0700 (PDT)
Date:   Wed, 17 Mar 2021 10:18:49 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: Do not hardcode 'sforshee' in the
 certificate commonName
Message-ID: <YFId2V808BExp/TH@ubuntu-x1>
References: <20210205180054.1031-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205180054.1031-1-nicolas.cavallari@green-communications.fr>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Feb 05, 2021 at 07:00:54PM +0100, Nicolas Cavallari wrote:
> gen-pubcert.sh hardcodes the 'sforshee' common name when generating the
> certificate.  Make it depend on REGDB_AUTHOR instead, which defaults to
> $(whoami).
> 
> Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>

Applied, thanks!
