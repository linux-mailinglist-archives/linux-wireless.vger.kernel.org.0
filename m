Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D738D10CA2
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 20:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfEASST (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 14:18:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37180 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEASST (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 14:18:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id r20so14330648otg.4
        for <linux-wireless@vger.kernel.org>; Wed, 01 May 2019 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=39iK6ttj1CJLX1CXijMOkng0NrHq60DKOdRIm134wF8=;
        b=ZMhZFxAef4N7PJmYGUQf6FDA6QB4jLB7Yio7Y/b0U4pCI+cW66XW2qczCUgYTPdbAl
         i/ojnfpvC/4987kna4XkC8h+4We7D1qlQS9YF4VWJUs6qw4qZ6inAxBw3dJvWbRrzjmY
         jXMFEna5AqduGTfRz1vnVggTq2Cph0viYMjiIw4x6jZWWE5JNanwp9+P5c7AwywMV8oK
         fKww3d0Bqa30zSCtAm/NNSHNKDuFNhn4SuaCHZXz7kyO34RC6NntROiDl6FnohVIakWp
         NYLce4RNBflEnu6iNCpzX9OHHEEhYzsMvfTQ+zjV8xgc5bC5VEshaBbJ+6WTvUDVOpvG
         IO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=39iK6ttj1CJLX1CXijMOkng0NrHq60DKOdRIm134wF8=;
        b=rPnrwcihD81J4FYyO2kyA919XFEQ07+GAfH0P/kkJCzrXN+5lFGdjdM6HX8aZaxsWA
         nAfyy77/ra0MKdWD5kQyhL9eipm64cMgXg0pwehCu2T79iP0cy3hUFjSUERYPqEiiTF9
         QQL68k5Xud8jUvMvz0jpAua4vpC3lVJ3CIzll/HrwL8RwVXtLbRxoqhmnoElkW0MN6e2
         vP23rc3OABExTgaRWb9vlbrMhrrnCpJeAUfVNcb5Hig69q/GPfjd9XjR8dwwWTT8SrN1
         ETFK+wfSsxzUIN+9RuCGRvOud56txZ8DuWHH079Y4lJC1nqfEW4d/74D37huARjXRZhU
         sXKg==
X-Gm-Message-State: APjAAAWgB6uYseo4nGBwvGGL4jqZu9KSLUo6qtnJVMZClxMW7Ig2jMCg
        uC68HaDAhco7NK5DB/Liyvw=
X-Google-Smtp-Source: APXvYqwuofq/SraXbZGgqlQOgFlDKOXmAQtd5CnobfAUCtrA6vMvetm2Q7JNjWHfxvBTQ+MeByrxTQ==
X-Received: by 2002:a9d:5504:: with SMTP id l4mr7320328oth.131.1556734698346;
        Wed, 01 May 2019 11:18:18 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id r65sm17954491oif.47.2019.05.01.11.18.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 11:18:11 -0700 (PDT)
Subject: Re: [PATCH v9 04/14] rtw88: trx files
To:     Kalle Valo <kvalo@codeaurora.org>, yhchuang@realtek.com
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        pkshih@realtek.com, tehuang@realtek.com, sgruszka@redhat.com,
        briannorris@chromium.org, gregkh@linuxfoundation.org
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
 <1555653004-1795-5-git-send-email-yhchuang@realtek.com>
 <87bm0npsp7.fsf@kamboji.qca.qualcomm.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <04c534eb-af32-adfc-62bb-90d83526af1a@lwfinger.net>
Date:   Wed, 1 May 2019 13:18:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87bm0npsp7.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/30/19 7:45 AM, Kalle Valo wrote:
> I'm not really fond of these "byte macros" or whatever they should be
> called, you use these a lot in rtw88 but I have seen the same usage also
> other drivers. The upstream way of doing this is to create a struct,
> which also acts as a documentation, and you can pass it around different
> functions. And the GENMASK()s are defined close the struct.
> 
> Also you could change these defines to static inline functions, which
> take the struct as a pointer, and that you get type checking from the
> compiler. And that way you would get rid of that ugly casting as well.

Kalle,

I have never been a fan of those complicated macros dating back to the day that 
I had to make them endian correct. Without Sparse, I never would have made it.

I understand your comment about making them be static inline functions, but I am 
intrigued be the struct method. Is there something other than bit field 
constructions that could accomplish this? If not, then this method would be very 
difficult to implement. My basis is an E-mail by Linus that said it was almost 
impossible to get this type of construct to be endian correct. If he thinks it 
is difficult, then I know not to tackle it. :)

Larry




