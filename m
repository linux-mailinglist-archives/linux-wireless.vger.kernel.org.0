Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248B21DA644
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 02:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgETAQs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 20:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETAQs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 20:16:48 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C3C061A0E
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 17:16:48 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w4so1458733oia.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 17:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dhvleQ689QNEHgOIdHy+23CP7Vfnnoy7TGPjbydhzcw=;
        b=UFyn+oLPY8K5X5MI8gl2yXzOJFJCCMSXKMLkcApvfQU5faLRUHg45HpOpBLKGHPZGN
         Sldjxdd3PCM/XI6jWYhpJ9c94fcMOWQuGTO/ZAQ9pHKIooxP+UVxrlB1ebm9G045cX0S
         oONwz99oMJRIV+a6UM2mtNrlpJydNvnUMcr0ai6FgQ+mRvvKIuDWsliaNmanH5O8nZu8
         fEeerj7uZBRXcflMITtSF/3b0qJEK/BRPsXniPLVBBio5VvLi5A+3hYIKWL9X9YOwEJz
         oXeAWVVzGgOLakRUxYMUWcYU8ki6JGEs01n7EjvTS6z9HzhGqCPPKTKjj45VsRLxQGlV
         7acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dhvleQ689QNEHgOIdHy+23CP7Vfnnoy7TGPjbydhzcw=;
        b=XXZu2GR9QBt0muUrqFr3bi6ZzPsHlhXDkZW/1NP/FKHqggtS2jA4opAe83SZ5IS9Yl
         UC79qaDYxyLlzkJUkUk20A2oj8bKAFgYSUG9OXDvXmQlvuAsbjJ+Fr5iOxHTg3UOHCQI
         Mdk8nnMPpuMO08GmZJgFMxDMORjfDaPDF48XbpyJ03EKYa1JEF6f6RvgtHVc2Dtfxun+
         ij2GKkw6YJo675JEPQRB3IVsa+l62xf8TCezVaUXzdzwNR8nIMDcce71mqjwynjSJfTX
         CqyILGWaHPW9eHaC/ThG3mwbLaG4Wne+lgXHm12XbGS7jweR/YMHGMqex/Su7Vz3XvDj
         UE8Q==
X-Gm-Message-State: AOAM532II8sJTmmj3Wvv1WPFIecKq0aywVGNXswlKXf6G5O7TVxJXAA8
        z4ulmGpR3F4iD3dfjM8MCno=
X-Google-Smtp-Source: ABdhPJx8E4I8W0gDgftY9I8uF6ivgwtF69zBfsr1Uaqz2eYnYUqyPKye/3ZnEymoGruRZG/qHmQnYg==
X-Received: by 2002:aca:1a18:: with SMTP id a24mr1554914oia.99.1589933807621;
        Tue, 19 May 2020 17:16:47 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id k12sm365799oik.30.2020.05.19.17.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 17:16:46 -0700 (PDT)
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net>
 <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
 <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <29f5e3de-a32c-6292-9197-19dcc57fa6a3@lwfinger.net>
Date:   Tue, 19 May 2020 19:16:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/19/20 6:13 PM, Rui Salvaterra wrote:
> On Tue, 19 May 2020 at 21:36, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>>
>> Hi, Larry,
>>
>> On Tue, 19 May 2020 at 21:30, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>>
>>>   From other drivers, it appears that handling WPA3 might be as simple as setting
>>> MFP_CAPABLE in the hardware capabilities. Please try this patch:
>>
>> Fantastic, thanks for the quick reply! I will do it ASAP and get back to you.
> 
> Unfortunately, looks like in this driver it's not so simple, the
> association is still rejected. I looked at the other drivers too and,
> sure enough, they just set the MFP_CAPABLE flag unconditionally with
> software crypto (I would expect mac80211 to magically handle it, but
> with b43 it doesn't seem to be the case).

It is necessary to load the driver with option nohwcrypt set to 1. I expect that 
you probably did that, but I forgot to mention it.

It would likely help if you can get verbose logs from wpa_supplicant.

Larry

