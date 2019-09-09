Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6C1ADCE4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 18:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbfIIQPY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 12:15:24 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37111 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfIIQPY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 12:15:24 -0400
Received: by mail-ot1-f42.google.com with SMTP id s28so12999100otd.4
        for <linux-wireless@vger.kernel.org>; Mon, 09 Sep 2019 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XesThYHyb1/wm4eV5TGprpxg3EGb5A5t+rPTrW3ftGE=;
        b=nFqL4M3G56TgscrurCprsvlAivbOEa1EK5JGwog8RUkK19FaWkfbYVVpNDYCNWEnGR
         s6lc48O3WO5rGX4Moud2gvn6Fn8r7r6GxHHM1put2Ibvc3uK92ZM8st9c9y1WtnrZGMK
         lRGvDkinYD1Mpb0A6b2jzZoq7Cz9mglHCjM3XneORON+k3rpO0/tQhWT+RcoOPgzbqli
         Ihjr6PYbjymGTd8HJ9Qr4OaAv9DBHNvAWNbrpw1H7J71Fs1xRVve9TXZP9lS7LntwUJ2
         6vGqnWi6wQU+EBn+UJz7Gl8Luh9vXxbu9U8xxZ5qpmpEtxs3kQHowBtosZsWqCzK1JlL
         7T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XesThYHyb1/wm4eV5TGprpxg3EGb5A5t+rPTrW3ftGE=;
        b=RT1ky4rSRV2jr+nJpL8oDWBhyGUYn2qEwkR8tkuzM70hAlk1A2Xco5/I0JuTHMp1Jb
         7HsjIK4achp9672LvkYhu2AqbqMGiPOP6t/tmJIY1OLzkvMiSKfKVnhOFxFZ5mORdxm9
         8X+1RAGNKFTfoT4ylhqzdHpNyf5k5EP4Mtcjmm2boxAx2bjMO6kfWqspxOBhH9QoSvMa
         Rfwd2CnILKvvL6m7qYWAxmXKu6EkDjybT7ESQQlzsxyAWf8ezG+d6wpgxeRxcpX23IEV
         5u7QggGlOXHKc7ruyyUPFv9u5t2RRFP7qxFWrvTTvWoOBBbMtirXxeyeeI11ridAFqd3
         hl+g==
X-Gm-Message-State: APjAAAWMrHeTeE4+l2OEZ78scHSeGQ/ImbXwvgnwrAEcl53OYYE8kR6Y
        znIFwR1j6kgIieBu/H5GFpk=
X-Google-Smtp-Source: APXvYqxpb5h2CyuHLKcN0K8OINIynyc3d65wciX11OsRKEt3QTTAgmg7pO91cASJATsZJxFUJza83g==
X-Received: by 2002:a05:6830:1e9a:: with SMTP id n26mr18949414otr.353.1568045723633;
        Mon, 09 Sep 2019 09:15:23 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 94sm5725410oty.44.2019.09.09.09.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 09:15:23 -0700 (PDT)
Subject: Re: Fwd: Asus x540m - RTL8723befw.bin and rtl8723befw_36.bin
To:     Joerg Kampmann <kampmann@ibk-consult.de>,
        linux-wireless@vger.kernel.org
Cc:     kyle@kernel.org
References: <ql15114vjvsd2m1ywuv1u1b1.1565285708045@email.android.com>
 <12353dc2-5beb-7d65-54ee-5dd6cdd4fc47@ibk-consult.de>
 <746c6c58-04a1-42b6-9657-197677d173cd@lwfinger.net>
 <dcea9c36-e9c5-a80a-ec81-eb3454af4425@ibk-consult.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <c41ed218-3dff-0a3a-796a-a63dd4cbc960@lwfinger.net>
Date:   Mon, 9 Sep 2019 11:15:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dcea9c36-e9c5-a80a-ec81-eb3454af4425@ibk-consult.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/9/19 11:00 AM, Joerg Kampmann wrote:
> This seems to be very strange. Does anybody have an explanation for this strange 
> behaviour?

I just searched the entire kernel source for the message "firmware is too big". 
The only place it was found was "drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c: 
         mfc_err("MFC firmware is too big to be loaded\n");". I do not think 
that is the problem. :)

Have you tried any other distros? A Live Medium should let you know if it has 
the same problem.

Larry


