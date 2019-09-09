Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52085ADDB6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfIIRBR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 13:01:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45379 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbfIIRBQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 13:01:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so9422802oti.12
        for <linux-wireless@vger.kernel.org>; Mon, 09 Sep 2019 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HWUqmA+++cq706lOAx08Hot/vF4HE7AAHltNzd45g9E=;
        b=ADox3/gE8DAHfnMhyXOKR6ZcjtLwhcM5hdew1s7uTvm575+7j6wIq6yBneMJPo5UA9
         qTRWgIgvCvNzdWmAofkSt2E0bXj5qiq/d1uyKR1MiiXNj+Mtn2MChOosrHG0ow9kKyba
         Yzgjy0IR5CpEbgP+Ns3piVcXbI0kYdmHXkFnSHq1947x/skSeq6n2SX2FBqVKyAWlQCW
         TcYe7B6ccR1DQ/j2YEtB6Npkjm5HlcJMMWQPV4uCiEnsoluBaIbCLqrp0QLf8egwmZFz
         1v/Ts7QJMzeZiJ3LCjSxACzPgVzDu2hxMkbsINWh+i/kWUl/u2lX92TCKlDZGx7wUSyS
         J1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HWUqmA+++cq706lOAx08Hot/vF4HE7AAHltNzd45g9E=;
        b=BgKCKHGB9F9J0sOxi1ZyfOgzvdPLqkTDfPMSNt58F3wRP8HP5P1QYw1B3mg9FKb717
         VhE7KdVN9hDgXIWkoj2lbd4hOWuSWi/RYUqs4SIUFQCONqYEqMbSIPh3dghv2yibIF4X
         sePZWO74J5NmqSKBrLqqGQ8ccn6Hzi969rgTWEBIvmANiypcEfLH2EbaHhAshG+N2tIx
         kIqZE3YQiVZGcgzZTqGGX1eVVSoEe+xDnsvh5akAoJPPg9wJLIioSRFNNnggI8QFF/JV
         tty2QHK46nN3p7Pg+WiB9N/XeJD4QMTNNfZrwjfC1KdHLbDcj6Kl99YpBV3XGgafAWwR
         t+ow==
X-Gm-Message-State: APjAAAUbYUbXcqfGCNBpmwGTRTNln0TsAtUvkyvIZpjV0AnfsiwosWi6
        re76mZmDqnQbJkJyc+3K4So=
X-Google-Smtp-Source: APXvYqyf6b/1h9UORvGFRPeQV+naW6851SUyo6ZYWb5ik3arIHJjoGfEqbjpP44l0xf02ZylmuJduQ==
X-Received: by 2002:a05:6830:134a:: with SMTP id r10mr21652596otq.155.1568048474396;
        Mon, 09 Sep 2019 10:01:14 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id j3sm4921977oih.52.2019.09.09.10.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 10:01:13 -0700 (PDT)
Subject: Re: Fwd: Asus x540m - RTL8723befw.bin and rtl8723befw_36.bin
To:     Joerg Kampmann <kampmann@ibk-consult.de>,
        linux-wireless@vger.kernel.org
Cc:     kyle@kernel.org
References: <ql15114vjvsd2m1ywuv1u1b1.1565285708045@email.android.com>
 <12353dc2-5beb-7d65-54ee-5dd6cdd4fc47@ibk-consult.de>
 <746c6c58-04a1-42b6-9657-197677d173cd@lwfinger.net>
 <dcea9c36-e9c5-a80a-ec81-eb3454af4425@ibk-consult.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <b993fe58-f93f-420d-2be0-53adb4aef392@lwfinger.net>
Date:   Mon, 9 Sep 2019 12:01:12 -0500
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

I tried booting a Debian Buster LXFE live iso. It has NO wireless firmware at 
all, and is completely useless unless you have a wired network!

What files are in /lib/firmware/rtlwifi/?

Larry


