Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080FD7DFD4
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbfHAQLi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 12:11:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53586 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732794AbfHAQLi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 12:11:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so65231773wmj.3
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2019 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=944owNyPBjUV61hnMTGIdIThoKkj0Nuu4CFUCls7YwA=;
        b=OGzVsPWoBJ/Juaqyc0oTHidNSkl1aOhijQCeKW5e71Z8yKxMwg7t84Y3+fj3HkLS4G
         5lJWavkva644cRvML2Oduh5iIYVxw1waMIJMFghsykBHfUgL9nXJQuprbKcoSWMRDohy
         wlH6pghkD0yPaxz2vNFRV6ZVuGMF3IayOS/7wp/tEMBVsCgpibZgq/tik2B+mlVNfkM9
         WIODolf0Oic1fgW4VmDlnlpliVeRWcNjrG9FFaIyMICtdN7RR0KINOg4CCkwJCOZso/B
         Ql2BgRZ21L1q3Q68vaq8xHJhTxr+I2SmUfNYPJ8guB82Bb+Mnz7tZv0z33qUtjS2vgz0
         UYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=944owNyPBjUV61hnMTGIdIThoKkj0Nuu4CFUCls7YwA=;
        b=LjX8E6ZbAXopXixZSzvbssks1+TS/ndKVfSAx2suJ572fy+DAd97hGap5RTZOJlZIu
         Xk5w36GradR3b6X8PJyrsAraUmEl//8NrERj+KuxkMK8yrXtZGE0Cpy25LkZTmb13MVV
         tyXtpvsuTxP04jQU+0x+A+ecGnVtQ/CWN8lwBa8wq7E5fr/LMq0cDcSGA4j+h8BrunBc
         bx+L+iPJuW3YN2c8BqefGG0nlkAolFPT58ScNjFUcT4f/bsNeoMpSZ8zKj99LLA5n7JN
         mP4eQawMs3QsKXyUvzezrOj3DthTkZLS9liKSczIwdisHhkiWmhRJInH9ufziksoW4wY
         r2cQ==
X-Gm-Message-State: APjAAAUjf+t9e0ZVyaFryV+QnIPiGuJSvEOByJLu67ihvet70MtscWKN
        qNyejU2zh3ZbF9/gXdEwlcM=
X-Google-Smtp-Source: APXvYqyDydw4/u7t8psF+yEt6XWKPtV0P7Wl3Hgu55ES11j1NhkK+/mUzSYt6+3P7AuAjLj7oUagnQ==
X-Received: by 2002:a05:600c:230c:: with SMTP id 12mr19672716wmo.151.1564675895980;
        Thu, 01 Aug 2019 09:11:35 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id o4sm55501402wmh.35.2019.08.01.09.11.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 09:11:35 -0700 (PDT)
Date:   Thu, 1 Aug 2019 09:11:33 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Mauro Rossi <issor.oruam@gmail.com>
Subject: Re: [PATCH] iwlwifi: dbg_ini: fix compile time assert build errors
Message-ID: <20190801161133.GA48349@archlinux-threadripper>
References: <20190801070436.6588-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801070436.6588-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 01, 2019 at 09:04:34AM +0200, Johannes Berg wrote:
> From: Mauro Rossi <issor.oruam@gmail.com>
> 
> This patch fixes and preserves existing code style, and readability,
> for IWL_ERR() and IWL_WARN() macros invocations recently added in dbg.c
> 
> Fixes the following build errors with Android build system:
> 
> /home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c: In function '_iwl_fw_dbg_apply_point':
> /home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c:2445:3:
> error: call to '__compiletime_assert_2446' declared with attribute error: BUILD_BUG_ON failed: err_str[sizeof(err_str) - 2] != '\n'
> /home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c:2451:3:
> error: call to '__compiletime_assert_2452' declared with attribute error: BUILD_BUG_ON failed: err_str[sizeof(err_str) - 2] != '\n'
> ...
> /home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c:2789:5:
> error: call to '__compiletime_assert_2790' declared with attribute error: BUILD_BUG_ON failed: invalid_ap_str[sizeof(invalid_ap_str) - 2] != '\n'
> /home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c:2800:5:
> error: call to '__compiletime_assert_2801' declared with attribute error: BUILD_BUG_ON failed: invalid_ap_str[sizeof(invalid_ap_str) - 2] != '\n'
> 
> Fixes: 427ab6385cf3 ("iwlwifi: dbg_ini: enforce apply point early on buffer allocation tlv")
> Fixes: 57d88b116175 ("iwlwifi: dbg_ini: support debug info TLV")
> Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

I can confirm that this works fine.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
