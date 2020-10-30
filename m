Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C39B2A0D7F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 19:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgJ3Sft (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 14:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgJ3Sft (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 14:35:49 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58959C0613D2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 11:35:48 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id k3so6443949otp.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DlCc/8kYIdqr/RXKDPR0L0riWC/Jbil8ig26l1QL1Fg=;
        b=JdQ+8gkjcA55DVxNZbh34V0Y/MYvv4ftsd2vvatSqQercIgt+G6Y9iZrKqeOfS+NRA
         m+QsLhguacOY145ZpLfyjtjZj2WaXfugdQOgqjnmN3ykbwIiqb1hzRPBiZeicEz878Jb
         XK7TQUFjEOBUhcVLjT4VnbHSHIq8MAxEqa9V8zzQI4PSreok4u/65MEZdM5/eXsYrtg1
         NB6vl0fOWpaNttdEccLAx3m3EA36/o8Jc+iKVYR4GyuJ6tb6mUCdHFxUXlLN3DfGjJGm
         WqWkYMAIoDT6UzUbGd/xDdmODmWk1sSN6Tqqx2bPAdJwiYUH5t5umJQH8ZzBZuWxnyG8
         uOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DlCc/8kYIdqr/RXKDPR0L0riWC/Jbil8ig26l1QL1Fg=;
        b=ZNgQz69LvMjXkW9Wxc+SCGffgiGFmIkVdEzFdywvrACUVqPU49xqAW/suHYUjwMtxE
         eS/GfApUopVyt1GzbM4X0F+pmam8qhCckwKJhb+O3Q4DdhybVVyTJO34wWEnNhgRdQT6
         Tvp+dVNoJGUhYM4EQpzf1sUXb15lZDzEF8KUTZb1rgSBKq78on3zeTK/Q7ISrdmaXyTM
         aJeUoFi9rSoLc5UG2muV0cn8jMRBhOSFVnw+gAhHtNLvLWiwYxUrvnb1jAdHyGi550hw
         TVSMBfgjUdesVDcdjP+cVpOTnUK85OWGhLKxL6nIPTXVXK8KePglNSHpQZP6hxAEs3uu
         2dGw==
X-Gm-Message-State: AOAM530YdBrdvPFGRPyaZiXmytQ4HNKI2GQHXQUUqg1Me3Mjz99aAIB5
        ezUS3ghFAnGv9CkQ7xVLd+S+vJfqsBg=
X-Google-Smtp-Source: ABdhPJxaN8S78k+4YlTI8jCKiEZ8VWKxDMUaLlBgaMHhMch/r+5vmx4SfmwzgKsb229+hjaoKCgwIA==
X-Received: by 2002:a05:6830:22eb:: with SMTP id t11mr2682484otc.114.1604082947178;
        Fri, 30 Oct 2020 11:35:47 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id z22sm1587376ooe.21.2020.10.30.11.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 11:35:46 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtw_8821ce driver in kernel 5.9.1: wifi module inactive
To:     Michal TOMA <michaltoma@sicoop.com>, linux-wireless@vger.kernel.org
References: <6173742.tiux6Xeah1@linux-9g0r.site>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <3c2baab8-bdcf-0679-b396-b42a05a0ef38@lwfinger.net>
Date:   Fri, 30 Oct 2020 13:35:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <6173742.tiux6Xeah1@linux-9g0r.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/29/20 11:47 AM, Michal TOMA wrote:
> ->rfkill list
> 0: ideapad_wlan: Wireless LAN
>          Soft blocked: no
>          Hard blocked: no
> 1: ideapad_bluetooth: Bluetooth
>          Soft blocked: yes
>          Hard blocked: no
> 2: hci0: Bluetooth
>          Soft blocked: yes
>          Hard blocked: no
> 3: phy0: Wireless LAN
>          Soft blocked: no
>          Hard blocked: no


Those bluetooth soft blocks may stop wifi. Can you clear them?

Larry
