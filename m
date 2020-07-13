Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8574721DE20
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2020 19:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgGMRCB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jul 2020 13:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgGMRCB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jul 2020 13:02:01 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B251DC061755
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2020 10:02:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ga4so18038011ejb.11
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2020 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dBpWhohA4qCjmIGT5bfMOr9NwEjL/Z4UnFbenETGipg=;
        b=uvaZmiBxASuL2qzi+AMjmoPfNhR7BvV8tWOl6pu9wjXtyelMwr3EjAiUFgMNNmB/kd
         Yuu+jpVTuXk71FabOPEBD1NgCHw/0a4zO7weAValbJikPkjiB5qkWis8dRREoHDPkLlD
         pxsY2nfaUbZOC2TbbR3I60OY8KT470AOucKyLH/2vrWW/QJ3WcUPITBY7lAM+TqC0xvI
         Ljwu9L2A/k7L6sRzQVFXgfSMpwoVm3rgAeTrfoXt+wWQk/XHuy5ejU4azzLaZwTDUu8a
         1k31T2iev6hVeGdzWR4VWK6DGsf5GULtt3aRz00WmndkzUz7z/sSAnQhpu3ConoGskFv
         ureQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dBpWhohA4qCjmIGT5bfMOr9NwEjL/Z4UnFbenETGipg=;
        b=bsc+fX/c6nCQf1Y+bsa03WyJad4m0fQCiPHuWrwrcBZEhgAX2pkKjXlazpOZ0LWqtE
         XoPacVoOpS7TLPDD85wxlxPzc+arwljoiVBcLla2EtyrlZYHzG1jHpepZIdQFsaFnj/G
         HAYvPKBySeTN1n4GmS2Dvh5SEpnC3iJiHRMe/H3hkTzhSpp8QMTkM2XPER2uOQXXuQj1
         y+YBXSll36i414AnFxo4dFUSRORZqF0RcICuAnsAraDUcol2VqSCVNC1+J1veyDtRt+2
         cnxXwA2nhC3RNrj9tbxexqDamLGAkhhZZzze6uOrGNbmujTadHRDCMPE5/GWnc1MNbAD
         ekyg==
X-Gm-Message-State: AOAM530g3IocVLDHN8HnYoOTQytKkBNM3LVews8Bs7CePSD70FMI8ifz
        0s4Rawmsl47kcKuqQ/vAeAwQobgFSMg7jQ==
X-Google-Smtp-Source: ABdhPJwJ+M9ROc70wUCp7GjyxAJGbscyNjvG6NmOnMoxorDMJhuztFffg+0QpGN6jAm68PEU55Hm/w==
X-Received: by 2002:a17:907:2654:: with SMTP id ar20mr656650ejc.62.1594659718837;
        Mon, 13 Jul 2020 10:01:58 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id z11sm6069100ejx.17.2020.07.13.10.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 10:01:58 -0700 (PDT)
Subject: Re: [PATCH 4/14 v3] iwlegacy: Check the return value of
 pcie_capability_read_*()
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     helgaas@kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, bjorn@helgaas.com,
        linux-wireless@vger.kernel.org
References: <20200710212026.27136-1-refactormyself@gmail.com>
 <20200710212026.27136-5-refactormyself@gmail.com>
 <87wo37a5s5.fsf@codeaurora.org>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Message-ID: <fa99aee8-86ee-558f-cb6f-761519c13159@gmail.com>
Date:   Mon, 13 Jul 2020 20:02:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87wo37a5s5.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixed

On 7/13/20 3:44 PM, Kalle Valo wrote:
> + linux-wireless
>
> Saheed Olayemi Bolarinwa <refactormyself@gmail.com> writes:
>
>> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
>>
>> Cc: bjorn@helgaas.com,
>> 	skhan@linuxfoundation.org,
>> 	linux-pci@vger.kernel.org,
>> 	linux-kernel-mentees@lists.linuxfoundation.org,
>> 	linux-kernel@vger.kernel.org,
>> 	Stanislaw Gruszka <stf_xl@wp.pl>,
>> 	linux-wireless@vger.kernel.org,
>> 	netdev@vger.kernel.org
>>
>> On failure pcie_capability_read_dword() sets it's last parameter, val
>> to 0. However, with Patch 14/14, it is possible that val is set to ~0 on
>> failure. This would introduce a bug because (x & x) == (~0 & x).
>>
>> This bug can be avoided without changing the function's behaviour if the
>> return value of pcie_capability_read_dword is checked to confirm success.
>>
>> Check the return value of pcie_capability_read_dword() to ensure success.
>>
>> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
>> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> Please check your setup, linux-wireless was not in Cc field.
>
Thank you for letting me know. I have fixed it and resent to the missing 
addresses.
