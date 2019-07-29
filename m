Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C129678F9A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 17:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbfG2Plh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 11:41:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38600 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387467AbfG2Plh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 11:41:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id h28so42349362lfj.5
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2019 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xV8S5dvH5X/iyMsitX1Lh7DBtL7ErfNc/D2854bEdkQ=;
        b=Vc/JBXKViMKy0zLHNPoq09elmCVFk6pcc1TOlA39i5qQ0ibFPNw4mtbvPiUXqh9aav
         n80TklzV1EbwCN+AdgynmOK/1LDt8BBK4zc6mjAwvdmGEENi66Dpiz/tT7sBs/MkP5Xa
         aLWf4Iwogp27Xsjg9ZjBpCLcdYE8HsSnggd2pn/aNxD6C08QKDp5ZDTHaBQWUEzxSr09
         yqqzZCdcsmgJ2Ma+KkEGTkafE7aHUK+aEUweDC55m9NF2xEYmutkuW2v9qf52LmX05nU
         kxWMB53JQd8zvRqizDZ8wvvMW2guCciPEJ9vk7Vu512PcysQo1lTdLgKn4933PDbqRNt
         In3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xV8S5dvH5X/iyMsitX1Lh7DBtL7ErfNc/D2854bEdkQ=;
        b=nfLtoo+eCNNJikDVmxPZuc9UiC+6C5BcwH31vN35oeudMvzhGE/VtYR5vLJvLP7gVO
         /wPAatEIiruHikjLGe54fR5JV3SlM3lWAj6kVNfmABv9Gzt/OkXSbpepn7nrwjXDg14b
         50OenCPrxU0Xmv84N9YzlcVs4fj3YDY05Q5NTOv2kBGdJhT+Ghs2F/fEb3QvsxQKjsCN
         ga1RDYzU0StbZxRUTIuSDyCc4/pu4QjE8Hi83Mh+S4gq1IP3gDoNAqfdnz96fzgpTj61
         x+pIlxH1zux1eCM4wCboUmilvALPVDONTTp6bEgP+8eqQ7cF/CCR9aGzw5TuS4FsD36T
         QgBw==
X-Gm-Message-State: APjAAAWEsUtMV05UK9CEt4mtesSL3+j2F74AOO/9mfnpKrFkzMClfLhv
        k0KRaGgf8bmXvsr65gmj+G26Zcw3
X-Google-Smtp-Source: APXvYqwGBF56ATWqCV8aGE2SfJlNlACeHmA8THIHxp6PhBpObiOW082024cyDUGLhpwkr2sweoUmRA==
X-Received: by 2002:ac2:5225:: with SMTP id i5mr6156166lfl.157.1564414542446;
        Mon, 29 Jul 2019 08:35:42 -0700 (PDT)
Received: from [192.168.100.6] ([109.252.54.73])
        by smtp.googlemail.com with ESMTPSA id i9sm10823571lfl.10.2019.07.29.08.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 08:35:41 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] nl80211: Limit certain commands to interface owner
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
References: <20190722113312.14031-1-denkenz@gmail.com>
 <20190722113312.14031-2-denkenz@gmail.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <443c450b-31f8-f059-e4c9-83eee00bfce2@gmail.com>
Date:   Mon, 29 Jul 2019 10:22:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722113312.14031-2-denkenz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 7/22/19 6:33 AM, Denis Kenzior wrote:
> If the wdev object has been created (via NEW_INTERFACE) with
> SOCKET_OWNER attribute set, then limit certain commands only to the
> process that created that wdev.
> 
> This can be used to make sure no other process on the system interferes
> by sending unwanted scans, action frames or any other funny business.
> 
> This patch introduces a new internal flag, and checks that flag in the
> pre_doit hook.
> 
> Signed-off-by: Denis Kenzior <denkenz@gmail.com>
> ---
>   net/wireless/nl80211.c | 78 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 60 insertions(+), 18 deletions(-)
> 
> Changes in v4:
>    -  Minor restructuring suggested by Arend
> 
> Changes in v3:
>    -  Fix minor locking mistake reported by kernel test robot
> 
> Changes in v2:
>    -  None

I noticed that the other patches in this series got applied.  Was this 
one left out on purpose?

Regards,
-Denis

