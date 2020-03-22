Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5AD18E59A
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2020 01:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgCVAeg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Mar 2020 20:34:36 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:38458 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgCVAeg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Mar 2020 20:34:36 -0400
Received: by mail-pg1-f181.google.com with SMTP id x7so5164449pgh.5
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2020 17:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OVBiZQ81sfKb2bi7YNF134goHng4U2/KqWiVvfDRpCw=;
        b=DbPYWoiSUNMCEuxoo9FYYSgpcOHik9zhBkdr9WmBztKey1V3AgQETHADvWp9xUNo9m
         6EWmfbt3zGFvRjVEWBs6aaQrZKVYglrG4nY6iEoQNAOBbMcNdga8+/Tp5r5D4XdrHALR
         dyUhebc3Q4YBlO1R/k+wk0gvW/FJAveotIoO1z33ol4XgFTknIUigeiKyiub78QlKP4x
         G3LbU2yv9kEEmN9e7T/IHWN21eVgUYvAi368R9eK5EqrjwdN/lR1jgvcOPcfZqqDJ+2J
         t4X4esyhQ+2SChXLLxp/I+A4p+FJBCjM9tFNmJrzjJZeyUI7lSmXboHcOuj1fXSw4FXK
         dr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OVBiZQ81sfKb2bi7YNF134goHng4U2/KqWiVvfDRpCw=;
        b=H4Zzo2olm5o1iKdbjZgxs1oVutyJkiPnvCKr6u/5o0Rj2EXqFuRYutax7MoueXpptT
         Q3ngtyF9e9UzR2YHIazER67oIwhFkSh3tsCUPvpPGCsEFDwy5Fda+4xIsu42Z0MWQz66
         PVTyeRbpx5qgZGL1yKSptgTtHnt927a+gvc6K1cnTaAY9u3QDsxh0UVjjM3GV22lZF7x
         RpK1nlfU5UcEmeBSR015xPoCR/uTSmvsC59VRYjcrapJ0KjidoTZOm59zvRxbPzwENGa
         qg1kLzlKUpbPtJRAiDImitWyBjiomCVmt1h07sovSM7e7SpAJdCHvNDqbTbrSpH3+P82
         J27A==
X-Gm-Message-State: ANhLgQ3UmZcn0sWlIKrDZ8BVfujB2fOTcJzcC2tl+AZ6WarwRUTRJ0P0
        XVqI9dzqN519QH7wggiXdRACeHqE
X-Google-Smtp-Source: ADFU+vt74TakMqmK6eolNAZQ2i5Yikk+oVGfCLavRuorKwrouk8FxOuK3AJfoaYLfMTDQtfi4ZmOnA==
X-Received: by 2002:aa7:947c:: with SMTP id t28mr16404956pfq.239.1584837273271;
        Sat, 21 Mar 2020 17:34:33 -0700 (PDT)
Received: from ?IPv6:2409:11:53c0:1f00:b04c:f0c9:bf68:24c7? ([2409:11:53c0:1f00:b04c:f0c9:bf68:24c7])
        by smtp.gmail.com with ESMTPSA id s12sm8573088pgi.38.2020.03.21.17.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:34:32 -0700 (PDT)
Subject: Re: Simulate Radio wave interference
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <fb4be9f4353193a789e4a6cdc4b35c096d2efd7f.camel@sipsolutions.net>
From:   Masashi Honma <masashi.honma@gmail.com>
Message-ID: <8f783032-8999-18aa-5980-8a87427fddd8@gmail.com>
Date:   Sun, 22 Mar 2020 09:34:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fb4be9f4353193a789e4a6cdc4b35c096d2efd7f.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020/03/17 0:42, Johannes Berg wrote:
 > I don't see this - the signal strength is just taken as is, and
 > overwritten, so there's no accumulation going on?

Right. The signal strength is not accumulated. The commit log is wrong.
The interference model is accumulating frame duration to calculate
probabilities. About accumulation of signal strength, it could be
calculated as vector. I wrote about it in response to realistic
simulation.

I think I should explain the concept of this interference model.
The interference model assumes signals which strength is under CCA
threshold are interference signal. The model accumulates the duration
of such signals. The model assumes (accumulated duration / time slot)
is probability of occurrence of interference. When interference occurs,
the model reduce the max signal strength of interfering STA from
transmitting STA's signal strength.

Though the implementation is not among the concept of the model. The
signal strength from node A to B was calculated and wrongly accumulated
to interference duration of "A to all".

I fixed it to "A to B" and sent a Pull Request to wmediumd.
https://github.com/bcopeland/wmediumd/pull/22

 > I guess my question really is how what's actually implemented is meant
 > to map to the physical world?

To get closer to real world, it is necessary to consider the phase of
radio wave. A radio wave could be weakened by radio waves which has
opposite phase.

Calculation of radio wave phase of multi signals could be described by
electric field created by mesh node antenna. By using this electric
field model, we could accumulate some interference signals as vector.

I have an idea of implementation. Though I need some more time to
implement this.

Regards,
Masashi Honma.
