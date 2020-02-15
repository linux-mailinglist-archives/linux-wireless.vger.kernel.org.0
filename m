Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7738E15FF87
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2020 18:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBORjW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Feb 2020 12:39:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38636 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgBORjW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Feb 2020 12:39:22 -0500
Received: by mail-oi1-f195.google.com with SMTP id l9so12786227oii.5
        for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2020 09:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2VnYF2xGeTvQDtgFqxiPDfO06Pv35LWegeCAZ+stKwo=;
        b=rygv2rHVHVG8A+xCvGl63SrbdBUUpA+e0/fMdAl0HNbw2KcMBArTEKUFCr1EFCoozq
         GuuR/eBKurbueS0Ld74VHaiFniwvMv21nEfkDMvEl0A0jpzKvBhYK6wOizusSclgvDrJ
         dlGo8MFNjH9Qwr0BOtIdseyK0J98z++Gt06rDdQCzZlSvoGrrGXx2rDABEjDfXR8vt4H
         Lks2CF8BiFYTYDcxavOFJG8ULJQMUek11hwOIpi8B/6lxeVg3C59CeNCrj5OdMVJQPM1
         bTozcvZO66Yim0DxMWxMz1wr65O0CYPzJQ7OTUUsL6TuSU3EQy1ahaq0IahaCuxyJux6
         yOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2VnYF2xGeTvQDtgFqxiPDfO06Pv35LWegeCAZ+stKwo=;
        b=VwFZ2mf+vAmNl3O+1BHUayN/evOGUGISIm4Uhpq1RN+WYRCgTIwu7uD7eXXLDnX++w
         jaBr+FIj07WN7yyxJbQJsDPz/GeREFlb6HZZ1KCKSoCnOcpAk077SZ6cuVDX/zONDZ2f
         eAC5ZyJE1qmalKdVVSLl4hLs8pl1WZCyOWEwktoOV6iVbHa04I4f32yJSXEBMzgSwr2Z
         UKfJTKAsl727FXXc1caP3eAUB56Aq3ALXX6jOkgjiM/umOHQC6UNZnGoh8KGCAe+natk
         Gz/pMhXP9R6PNKhFsk1XuWFpniqK8XhU91HzpmfbGw9XOlCHJvnBn7DzGnj3iaOIecU2
         L+PA==
X-Gm-Message-State: APjAAAWiVv9Yeqs8HJ6IGBPkFBbnqwNkGcoqm6chUoq5bDsmEankK0Zk
        W0C7sQOCPOfy+GZF/ESkX5BqwMx5
X-Google-Smtp-Source: APXvYqxLRPW3euY6Y+ugTPUreHeMn8b9PZEJSde+ztflliUHPvPZZQF1Y/N96puhxUNlVTNQ2mc3xw==
X-Received: by 2002:aca:f587:: with SMTP id t129mr5369066oih.143.1581788361468;
        Sat, 15 Feb 2020 09:39:21 -0800 (PST)
Received: from [192.168.1.120] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id n16sm3301207otk.25.2020.02.15.09.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2020 09:39:21 -0800 (PST)
Subject: Re: [rtw88] Linux 5.6-rc1 / RTL8822BE WiFi adapter
To:     Bjoern Franke <bjo@schafweide.org>,
        Tobias Predel <tobias.predel@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <20200214214134.GA12764@t2b3>
 <c76d37cc-2cab-a8f2-e570-a444c06ad020@schafweide.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <028ea5d3-1459-b37e-f996-72958be0ff4c@lwfinger.net>
Date:   Sat, 15 Feb 2020 11:39:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <c76d37cc-2cab-a8f2-e570-a444c06ad020@schafweide.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/15/20 5:12 AM, Bjoern Franke wrote:
> Hi,
> 
>> Is the provided firmware file in the linux-firmware tree still
>> compatible with the driver code?
>>
>> I would be very glad if someone could look into this.
> 
> I'm just wondering why these issues do not appear with lwfinger's rtw88 
> branch[1]. lwfinger mentioned several times that his module is mostly the same 
> as the kernel one.
> 
> But with the "official" one I often got connection losses or bad throughput.
> 
> Kind Regards
> Bjoern
> 
> 
> [1]https://aur.archlinux.org/packages/rtlwifi_new-rtw88-dkms/

I deliberately stay behind the official kernel repo so as to avoid implementing 
any regressions. As you are the one with the problem, you need to perform a 
bisection to discover which change to rtw88 introduces your difficulty!!

Larry

