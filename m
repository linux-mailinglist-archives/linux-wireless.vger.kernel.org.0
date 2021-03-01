Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986B13282A9
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Mar 2021 16:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbhCAPig (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Mar 2021 10:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbhCAPi2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Mar 2021 10:38:28 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A2CC061756;
        Mon,  1 Mar 2021 07:37:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d15so1386816wrv.5;
        Mon, 01 Mar 2021 07:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2mjETDS/R3AcrHDxH+eBHTmfWCAT1YYDng8uSVTe0DQ=;
        b=ZijXwVTP9y+09zH0zD9ZoS6JDGqj/lSjfXbcaqFGfzV9rSL6eZVDHZAW0kSlgtHg15
         zwQQgWIduKj22O5riA3/wQKzgjWbCcsUTgJrGgdFo4tHxpYgKSErmSv7Bl3QFKUK1mNJ
         yeevnPS0LmK/KCLrwuWm8JQQvVkkoN68zBP8yCEtzAY/avhw4l+9BZjmF+1gH3otdnip
         uqovBZ4TOm4bb00bOgcxPTkYyd0DU/3PXoa34WBSE6jK72v0CO2OFhYe3IRbPaZmN4vI
         Nhscr25Rfao5pxLgOBHh9AFUPv9oUNvWJI+/5wp7+rv2bcXH/Jjg7LOy18A2Lah7zHmS
         vPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2mjETDS/R3AcrHDxH+eBHTmfWCAT1YYDng8uSVTe0DQ=;
        b=H7z4FaUVUN9ntiJ+h1J3nmmPuT4hYLK3jGESibYBczhDd8HFs2n9m2QIkuWGYLETQx
         dmtbgXAeoJSWwxV3uJibrVnB5fm9uXRTjoFqgt+dI5oUqgdYXX0atu0XxlsKfbJ67kGN
         oCuK5ZKV0zk5zdZFsmA0WzCamRQlN2LwMUsm9LTft/3AiDOvOS+Qw6RvWlKFul273FXU
         Fw5/FJFOpQZN40VKLYQMWRRJVavHUW0K4gSYPZ0c1FtAlJgR7SyFxo6rM1g9DpfPRuE2
         Y8xrTQ98pQdJZhbjtdQI2AxRDr40bSZxxF0JtMX8l2+m7P9HabS7B9XdV+bXzxiWFqxw
         Xy/w==
X-Gm-Message-State: AOAM531HjXPIHuyY1zQghrmlHQplWNOQOZ8kCE3iruX6x8U5tnuLnm6B
        PbOLE/+WitII+ZeaTueOyEU=
X-Google-Smtp-Source: ABdhPJwVOsqMcVd+MawWtsgwbNmlYQ/GlTYMnDc8ODM0H4y4vaQ4CERjuc4s6tjZRpm4/l1Xlb2hrw==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr15556026wrr.161.1614613064575;
        Mon, 01 Mar 2021 07:37:44 -0800 (PST)
Received: from ubuntudesktop (205.158.32.217.dyn.plus.net. [217.32.158.205])
        by smtp.gmail.com with ESMTPSA id n1sm28452749wrx.45.2021.03.01.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 07:37:44 -0800 (PST)
Date:   Mon, 1 Mar 2021 15:37:42 +0000
From:   Lee <leegib@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix possible buffer overflow in
 _rtl92e_wx_set_scan
Message-ID: <20210301153742.GA427438@ubuntudesktop>
References: <20210226114829.316980-1-leegib@gmail.com>
 <20210226134333.GA2087@kadam>
 <20210226140526.GG2222@kadam>
 <20210301132535.GR2087@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301132535.GR2087@kadam>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org




> This check worked out pretty well.  It's probably 50% bugs?  Unfiltered
> results below.  The trick of warning for "if (ststr(member, "->ssid")) "
> and the memcpy length couldn't be verified turned out to be the best.

That list looks great. I checked out 2 of those listed at random and 
they look like valid bugs to me.

> But there are quite a few real bugs as well.  If anyone wants to fix any
> of these just claim a bug, and I won't send a patch for that warning.
> :)  Lee, I think you mentioned that you had found a related buffer
> overflow fix?  Did the check find it?


I think I found 2 in these files:

drivers/staging/rtl8712/rtl871x_cmd.c    
drivers/staging/wfx/hif_tx.c

Regards,
Lee

