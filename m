Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26401C24AF
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2020 13:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgEBLVq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 May 2020 07:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbgEBLVq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 May 2020 07:21:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299B0C061A0C
        for <linux-wireless@vger.kernel.org>; Sat,  2 May 2020 04:21:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so3008599wmc.5
        for <linux-wireless@vger.kernel.org>; Sat, 02 May 2020 04:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sJijT4a1j9nQvyWg75je7ZT6OCbMpgJ+rujJ98q3RnQ=;
        b=BOcpjQBkHnP1PlW8xPC/wdiykrjWFuE8hLh3MtOcRba0RLejNkTqQeJdAFx25MGmZa
         Ql43zdR+ngo/brPlqZFoeYN9uYRA38RNKuTmn751g3QOSo3FG5t8MseCloz2baIlnbBS
         JcdqFUGjERaHx+OMtJKotHunNy0XuS5TTbWQjFKCoR81Sn5AH5ZPndj9rWcvvjpD220M
         6FT6+WLvHtSFH4h3a5NvBzCRDsoluQr8Ak4IvEeIpyXyl+djOhngV52YhNvOqqz+4gq9
         feD9ze1xBnY0PgDpk/C/vo1CB5G5lJW7uvZ4saMqQEjH4zrfIOf3NVAfyR82GbET4702
         9h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sJijT4a1j9nQvyWg75je7ZT6OCbMpgJ+rujJ98q3RnQ=;
        b=n5BJTUMPPvzFz87wLe9tZB3EDJ2UjUvWgeMTVftmat1xW8dggZorKNlCxzyb5aEDv4
         rD3m6yc51QGXZYrpiD2eZuZU2CLhiqu/cJOpXP755GoJPZTuWLG2NHNffSQULnc1LDjW
         RI+tWEqrXEX+nVi4p8x8tZwTP6veuzolvya3vjiV5XGhDZbSh2hFEbxheYWXpUjszqzd
         AOXu7/qsFDDEdwpb7Na4tZBcZQeGQ7JHaVdQaF3jmY5zj8js9uXfha8eu7l35K307YAs
         MmxpuIstcIEFtn04fzr4rsRMrBLtGKtMpKh524JYR2DBxWdDvg4T4TNL0rEUD38DYm+4
         yPhg==
X-Gm-Message-State: AGi0PuaqeYmGq+kQYOGm7PTfLA+AjPYQvgLSVcSMuw1MWUqQLbZm07Wj
        VesbBS82Ite73lXTF/lYRY+NX/9N
X-Google-Smtp-Source: APiQypLEGt097/krdyEeil57drfCN3k7Xxf2DKsE7CMV6LGKvZxzdohRE05WiuWepAfSdkRQLHJYcw==
X-Received: by 2002:a1c:5642:: with SMTP id k63mr4181685wmb.188.1588418505003;
        Sat, 02 May 2020 04:21:45 -0700 (PDT)
Received: from [192.168.43.18] (94.197.121.192.threembb.co.uk. [94.197.121.192])
        by smtp.gmail.com with ESMTPSA id h2sm3789426wmf.34.2020.05.02.04.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2020 04:21:44 -0700 (PDT)
Subject: Re: [PATCH ] staging: vt6656: refactor power save operation
From:   Malcolm Priestley <tvboxspy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
References: <5f32a399-bb35-2b77-7c37-a852393a9df7@gmail.com>
Message-ID: <26ab54ee-9f42-4c2a-e823-f1eccfe24dfb@gmail.com>
Date:   Sat, 2 May 2020 12:21:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5f32a399-bb35-2b77-7c37-a852393a9df7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop this patch v2 sent corrected TTBT.

Regards


Malcolm
