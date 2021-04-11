Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A8035B6F0
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 22:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhDKU4u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 16:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhDKU4u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 16:56:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4469AC061574
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 13:56:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id e14so16902414ejz.11
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 13:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GK6PVM/x1pIWKelmjFCf91DuPlaiX5HQKHPiDCCrZnc=;
        b=XvCF9CkIkos75VRaZLKnGbL/OXV+jPFE75s3M+sjYIuNqlI2FYGtzYu2t6IcFhjLhx
         MAC9B2BGmd+nmRk+KWspPEZeFj0Vi30BNkyePrjpy52wnoJbJXA9SQRH7RXedPMSUEjF
         jjDhD9GPkC61twUATQE21awxAbRwKKnjDPhaGLt+0qzAXrgeThppzMJaRZOT14ncG78D
         0EJOmnayPprNfifnnFW40yOTrKou7VDwUpo031/wwVvd0mZKip+eZeUeOcDmN+hy4kSX
         k70CuX9kP1KAae4A7AjBJJofOq26CfhjKxCBypSK+PyIhaK1ApD2/M9n0B0w5iTEmDDn
         PzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GK6PVM/x1pIWKelmjFCf91DuPlaiX5HQKHPiDCCrZnc=;
        b=uOMBAbppnObYTSdoWr+w31p6xjYzIag3C/vwG5Cpt7wo/quYYUnIc/foUgRLDdzPaW
         fCSw219gTd8WwfxN8UGDACf/wNzFNXueqhwxNC95MP8ZAvXwJtLe2I134A20C3P75IGV
         H8VCrIKUY8HqZ/BmNi5ASFi152yYeqL41wk+934U715m5DgRmxazAiKHzVwCTT5/zDLx
         lE/iYL2aMquEMJu49FDTtOQDVI9FySg96jM9aifcz7wIFFLGqsRB8Uc80IrKQCViw3lR
         cz0IOId6rZVnjDPB18FSmuo5KrICAWVYI2p8fvi4XmLx2dx7WS0qme7oQlZc7zineHX1
         kH/Q==
X-Gm-Message-State: AOAM531AoGgje5ZSN4zoLGRC+iEekkHKla5d2oQnYJhL+7nkJm6eN7Wl
        rlTlleXJxOaBTW6MKBlMDz3XqmjweNLu0w==
X-Google-Smtp-Source: ABdhPJwM8gMzP7+QwgrNw8x5Zv7Kn4TLopn9yYGVLup5hGPUZvs635FvwJbfUaMxAVC9VloykE16vg==
X-Received: by 2002:a17:906:1519:: with SMTP id b25mr24559980ejd.254.1618174591830;
        Sun, 11 Apr 2021 13:56:31 -0700 (PDT)
Received: from [10.0.0.2] (94-210-190-100.cable.dynamic.v4.ziggo.nl. [94.210.190.100])
        by smtp.gmail.com with ESMTPSA id f21sm5286559edq.55.2021.04.11.13.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 13:56:31 -0700 (PDT)
Subject: Re: iwlwifi: failed to load firmware chunk
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-wireless@vger.kernel.org
References: <40bb3a55-a872-414d-ed7f-6548beecd236@gmail.com>
 <CAJCQCtTxroboAeQgByCG0zfNK=Rda=2cOGW4i2_kqxu2Saqqsg@mail.gmail.com>
From:   Friso Smit <fw.smit01@gmail.com>
Message-ID: <b606a193-3e4d-cdd7-a2e4-c5b801e2f8fc@gmail.com>
Date:   Sun, 11 Apr 2021 22:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTxroboAeQgByCG0zfNK=Rda=2cOGW4i2_kqxu2Saqqsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/11/21 10:11 PM, Chris Murphy wrote:
> On Sun, Apr 11, 2021 at 2:24 AM Friso Smit <fw.smit01@gmail.com> wrote:
>> Hi,
>>
>> After upgrading to linux 5.11.12.arch1-1 I suddenly had no wifi
>> connection. I immediately tried downgrading again, but to no avail.
> Did only kernel version change? 5.11.12 has one iwlwifi related commit:
>
> commit 6159f947fb047fd8ecbfbcbcc86a8337e801bd10
>      iwlwifi: pcie: don't disable interrupts for reg_lock
>
It's not the only thing that changed, but this one stood out to me as 
the possible cause. Some other things to note are that I sometimes have 
to force shutdown my laptop, because of a long time issue in nouveau. I 
don't know if this can cause these kinds of issues. And I want to stress 
as well that the issue persisted even on another operating system, so 
something must have been thoroughly messed up somehow.

Here's a full list of (Arch) packages that were upgraded:

expat (2.2.10-2 -> 2.3.0-1)
glib2 (2.68.0-5 -> 2.68.1-1)
libcups (1:2.3.3op2-1 -> 1:2.3.3op2-2)
cups (1:2.3.3op2-1 -> 1:2.3.3op2-2)
dleyna-core (0.6.0+2+g1c6853f-2 -> 0.7.0-1)
dleyna-connector-dbus (0.3.0-3 -> 0.4.0-1)
libdrm (2.4.104-1 -> 2.4.105-1)
mesa (21.0.1-1 -> 21.0.2-1)
dleyna-renderer (0.6.0-4 -> 0.7.0-1)
dleyna-server (0.6.0+2+geb895ae-2 -> 0.7.0-1)
gdk-pixbuf2 (2.42.4-1 -> 2.42.6-1)
geoclue (2.5.7-2 -> 2.5.7-3)
glib2-docs (2.68.0-5 -> 2.68.1-1)
gtk-update-icon-cache (1:4.2.0-2 -> 1:4.2.0-3)
gtk3 (1:3.24.28-1 -> 1:3.24.28-2)
lib32-expat (2.2.10-1 -> 2.3.0-2)
lib32-glib2 (2.68.0-5 -> 2.68.1-1)
lib32-gdk-pixbuf2 (2.42.4-1 -> 2.42.6-1)
lib32-libva-mesa-driver (21.0.1-2 -> 21.0.2-1)
lib32-mesa (21.0.1-2 -> 21.0.2-1)
lib32-vulkan-intel (21.0.1-2 -> 21.0.2-1)
libmwaw (0.3.17-1 -> 0.3.18-1)
libva-mesa-driver (21.0.1-1 -> 21.0.2-1)
linux (5.11.11.arch1-1 -> 5.11.12.arch1-1)
linux-headers (5.11.11.arch1-1 -> 5.11.12.arch1-1)
lua (5.4.2-1 -> 5.4.3-1)
mesa-vdpau (21.0.1-1 -> 21.0.2-1)
meson (0.57.1-1 -> 0.57.2-1)
npm (7.8.0-1 -> 7.9.0-1)
opera-ffmpeg-codecs (88.0.4324.192-1 -> 89.0.4389.90-1)
proj (6.3.2-1 -> 8.0.0-1)
qt5-base (5.15.2+kde+r171-2 -> 5.15.2+kde+r171-3)
wlroots (0.12.0-1 -> 0.13.0-1)
sway (1:1.5.1-2 -> 1:1.6-1)
vulkan-headers (1:1.2.173-1 -> 1:1.2.174-1)
vulkan-intel (21.0.1-1 -> 21.0.2-1)
wine (6.5-2 -> 6.6-1)
wine-mono (6.0.0-1 -> 6.1.1-1)

