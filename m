Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A3A4936A1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jan 2022 09:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345394AbiASIyJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jan 2022 03:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352664AbiASIxt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jan 2022 03:53:49 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A70C061574
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jan 2022 00:53:48 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e9-20020a05600c4e4900b0034d23cae3f0so4381817wmq.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jan 2022 00:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=nysFfB7FiLhLLN3K973iPIjHDxbti2ZbLDq3A1XOYxM=;
        b=f/CdvPHkhUjMndzz2KQrne5Y/AYAw6nOm3Fl98qG5eTCpIZtXedJAIn6SuTiVtrxsF
         0Tg40csr0ACeUCD8mFZPOTa0BmHC4ILZ2r7TkZxhftFYoNEDcCnDitbS9dI4JbNGrB6p
         ytkwNCCKSTlwMumANukB1FQbVnpwdTu1GaP6TRexGpVG4UnihLI72XDXTjJktF4MTcUn
         2IvlMo5GTnpFxKYLxknXrSPDZ87nv2MUSAWG0rdvXF6G5Poj4NKn6ptRpX0Hh5yP7P1N
         Lp2bOzGZWQyZamG9BpPvP5u0+CsLF0YJDorR3sSCe8VJnxcLIiCGViKQZBv0nvWAsX3N
         Usrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nysFfB7FiLhLLN3K973iPIjHDxbti2ZbLDq3A1XOYxM=;
        b=bLZ/7kfysWLE+WKBgGP0wraYMyYURfDsdwiNHLgM06KDCOyB9BmQZm+sGOyc/8S9uH
         zi6HgXuv6v5LaJaS7tqr/t4JXoK4qHAYgxF0ZsgoVwH6JuN23cFWSfeGgCBw6/lzxA4K
         acjV85Ua5gy1tlBezoARzZYOC3Hq5AUNolzuAJQ5+Qd6VjDgG6reGxuOtLqg6vr/xEH4
         aiWdrE302FXp/29qIwfHuggPdE3xDCqiUbNuNvz9JsdyIIBtIstLy65v5qrowoKZy7LZ
         G4q2YGIadnwfqO7Qhx9eE8w/AO/vHHRO97C9gSX98E2qRsCoEhVca6GjII9t7eAx7rir
         RRxQ==
X-Gm-Message-State: AOAM531EASsy+y6dO8KsQJgnNlJ+w0YaQdqrPKE4qAZPEII5+4dFfNht
        Q4gd5MXWSMSZN1LMAr1MsMiHMpPNEUWIbg==
X-Google-Smtp-Source: ABdhPJydQ//GA+JIB/Oi66ShkYkXAWTodMW3y06FdUJ2Yezm+WPekzsCMy3DdJXLdsbqJ0CksneMtQ==
X-Received: by 2002:a1c:7517:: with SMTP id o23mr2407655wmc.120.1642582427301;
        Wed, 19 Jan 2022 00:53:47 -0800 (PST)
Received: from [192.168.187.147] ([86.12.200.143])
        by smtp.gmail.com with ESMTPSA id r8sm2056629wrm.93.2022.01.19.00.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 00:53:47 -0800 (PST)
Message-ID: <07dbaff1-bc12-d782-ed14-ef3f33d3c041@raspberrypi.com>
Date:   Wed, 19 Jan 2022 08:53:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] brcmfmac: firmware: Fix crash in brcm_alt_fw_path
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <20220118154514.3245524-1-phil@raspberrypi.com>
 <87h7a0gt7f.fsf@kernel.org>
From:   Phil Elwell <phil@raspberrypi.com>
In-Reply-To: <87h7a0gt7f.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/01/2022 06:01, Kalle Valo wrote:
> Phil Elwell <phil@raspberrypi.com> writes:
> 
>> The call to brcm_alt_fw_path in brcmf_fw_get_firmwares is not protected
>> by a check to the validity of the fwctx->req->board_type pointer. This
>> results in a crash in strlcat when, for example, the WLAN chip is found
>> in a USB dongle.
>>
>> Prevent the crash by adding the necessary check.
>>
>> See: https://github.com/raspberrypi/linux/issues/4833
>>
>> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> 
> I think this should go to v5.17.

Is that an Ack? Are you asking me to submit the patch in a different way?

Phil
