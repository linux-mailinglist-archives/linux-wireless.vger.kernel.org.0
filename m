Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EE51B85A1
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgDYK0a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 06:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726059AbgDYK03 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 06:26:29 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BCEC09B04A
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2020 03:26:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so14486036wrb.8
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2020 03:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=38vQVlaeSZZxQKTG5783RHBThukGsAZS9fXDacuiSmU=;
        b=Gtltwj0k57U62g3GeZY/ggJ/mqgonj4qLUD4I/84b2SMyKNoDqeJgn+5UvjjQOONUP
         GW0HTpsf8e4kCqutI5ZmRFpWyZEjlAEXYJ5Tab9bg9EsltOW0/+H+xTPibrRGazG4Lua
         hfU8xDNpSJLVh28JIz/mn5NIXR2sCLcHWBwouhMXi0iFjkGJSnM51FXntz8oT281viLr
         xTR+J1oor1Eq74xYVBYEbH17KiQveAWiFIC6KoGDcft0kNTJaTSACfOppnQQ/hvtYt5X
         KRtuVTMUjx0qn1402Z/Uw/g0SvySIr/oFOHy2xXe2dDxHhtUv+7DMp+Vzur+xHT/kegY
         H5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=38vQVlaeSZZxQKTG5783RHBThukGsAZS9fXDacuiSmU=;
        b=rkngdMizzddW4+PVXvNdvLEH3yc1hhQq4LAw/So19jabopmBPLtyUFwc0SBy18g9RU
         Gr4kq90D8GIpMrriN7ddWh3kbQy9fK3WHLSDlgIxWzIRAd/Z2I0AGqn4hygzwhTWrKZq
         WtTE9GYD5dskuofcx7/9tMV/IIsyVEsa95/aD+ssEghmflgY+XFyQGGCKh/sLYH5V8tW
         jNlAYu6t89uZdS4IL+gN9se/R+5Yufp8+wNqzkYZ1I319kaW3Ai5Y4gBltOoiLxg+wzH
         PpjDRjpynZSdx39Lf3q5m+YcC9OEC0RGgKHNee9cnM9YEUJ4ZhUFH2mKR+/4HiPHBcr8
         mVow==
X-Gm-Message-State: AGi0PuYExRLmOxVQ3GHKk8gu7Fq81kJ2vGGUBQKdBgzmaxMlEYN2+SLE
        ARoHzdxcIiK/4rg4/1vYYjE=
X-Google-Smtp-Source: APiQypLKhIXBnlPPWWk/gKSpTt8Isfngp6z63ky08yVA/WfgmVJlqnu5se6FfXzXT+S3m4drxLKiOQ==
X-Received: by 2002:adf:e8c2:: with SMTP id k2mr16315312wrn.396.1587810387771;
        Sat, 25 Apr 2020 03:26:27 -0700 (PDT)
Received: from [192.168.43.18] (94.197.120.138.threembb.co.uk. [94.197.120.138])
        by smtp.gmail.com with ESMTPSA id t16sm6533125wmi.27.2020.04.25.03.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 03:26:27 -0700 (PDT)
Subject: Re: [PATCH] staging: vt6656: rxtx: remove duration_id and void
 returns.
From:   Malcolm Priestley <tvboxspy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
References: <7e44c528-2a3a-6a3d-0b47-0307d27a1c8b@gmail.com>
Message-ID: <d870351d-8d0e-9ed2-852f-90dcbae52bbe@gmail.com>
Date:   Sat, 25 Apr 2020 11:26:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7e44c528-2a3a-6a3d-0b47-0307d27a1c8b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop this patch there is a mistake in it.

Regards

Malcolm
